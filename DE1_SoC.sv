module DE1_SoC
(
	input logic CLOCK_50, 
	input logic [9:0] SW, 
	input logic [3:0] KEY, 
	output logic [9:0] LEDR,
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);


parameter A_WIDTH = 8,
			 RET_WIDTH = 4;
				
parameter VAL_WIDTH = 8,
			 ADDR_WIDTH = 5;

logic [RET_WIDTH-1:0] count;
//logic [9:0] SW_F;
//logic [3:0] KEY_F;
logic [ADDR_WIDTH-1:0] F_addr;
logic done, hex_en;
		
logic [3:0] F_addr_h1, F_addr_h2;

//assign HEX0 = '1;
//assign HEX1 = '1;
assign HEX2 = '1;
assign HEX3 = '1;
assign HEX4 = '1;
assign HEX5 = '1;

assign LEDR[7:0] = SW[7:0];

//logic [13:0] temp;
//D_FF #(14) pass1 (.d({~KEY, SW}), .q(temp), .clk(CLOCK_50), .reset(0));
//D_FF #(14) pass2 (.d(temp), .q({KEY_F, SW_F}), .clk(CLOCK_50), .reset(0));
		
//task1_toplevel #(A_WIDTH, RET_WIDTH) task1 
//	(.clock(CLOCK_50), .A(SW[7:0]), .reset(~KEY[0]), .s(SW[9]), .result(count), .hex_en, .done(LEDR[9]));
//
//Hex2Seg disp0 (.hexIn(count), .hex_en, .segOut(HEX0));
//
task2_toplevel #(VAL_WIDTH, ADDR_WIDTH) task2
	(.clock(CLOCK_50), .en(SW[9]), .reset(~KEY[0]), .A(SW[7:0]), .NF(LEDR[8]), .F(LEDR[9]), .F_addr, .done, .hex_en);


Hex2Seg disp0 (.hexIn(F_addr_h1), .hex_en, .segOut(HEX0));
Hex2Seg disp1 (.hexIn(F_addr_h2), .hex_en, .segOut(HEX1));

always_comb begin
	F_addr_h1 = F_addr;
	F_addr_h2 = (F_addr >> 4);
end
	
endmodule

module DE1_SoC_testbench();

logic CLOCK_50;
logic [9:0] SW, LEDR;
logic [3:0] KEY;
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

// Clock Setup
parameter CLOCK_PERIOD = 20000; // 20 ns / CLOCK_50
initial begin
	CLOCK_50 <= 0;
	forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
end


DE1_SoC dut (.*);

initial begin
SW = '0; KEY = '1; @(posedge CLOCK_50);
KEY[0] = 0;			 @(posedge CLOCK_50);
#100000;
$stop;
end

endmodule
