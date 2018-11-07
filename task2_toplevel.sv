module task2_toplevel 
#(
	parameter VAL_WIDTH = 8,
				 ADDR_WIDTH = 5
)
(clock, en, reset, A, NF, F, F_addr, done, hex_en);

	input logic clock;
	input logic en;
	input logic reset;
	input logic[VAL_WIDTH-1:0] A;
	output logic F, NF, done, hex_en;
	output logic [ADDR_WIDTH-1:0] F_addr;
	
//	output logic [1:0] state, next_state;
//	output logic [ADDR_WIDTH-1:0] L, R, M;
//	output logic [VAL_WIDTH-1:0] A_reg, rd_reg;
	
	// Controller signals
	logic set_L, set_R, set_M, load_A;
	
	binarysearch_controller control 
		(clock, reset, en, F, NF, done, set_L, set_R, set_M, load_A);
													
	binarysearch_datapath #(VAL_WIDTH, ADDR_WIDTH) data 
		(clock, A, set_L, set_R, set_M, load_A, done, F, NF, F_addr, hex_en);
		
endmodule 

`timescale 1ps/1ps
module task2_testbench();
parameter VAL_WIDTH = 8,
			ADDR_WIDTH = 5;
			
logic clock, en, reset;
logic [VAL_WIDTH-1:0] A;
logic NF, F, done, hex_en;
logic [ADDR_WIDTH-1:0] F_addr, F2;

// temp
logic [1:0] state, next_state;
logic [ADDR_WIDTH-1:0] L, R, M;
logic [VAL_WIDTH-1:0] A_reg, rd_reg;

task2_toplevel #(VAL_WIDTH, ADDR_WIDTH) dut (.*);

// Clock Setup
parameter CLOCK_PERIOD = 20000; // 20 ns / CLOCK_50
initial begin
	clock <= 0;
	forever #(CLOCK_PERIOD/2) clock <= ~clock;
end

always_comb
	F2 = F_addr >> 4;

initial begin
reset = 1;	en = 0;		@(posedge clock);
reset = 0;					@(posedge clock);
A = 8'h51;	en = 0;		@(posedge clock);
while (~done) begin
	en = 1; 	@(posedge clock);
end
#100000;
en = 0;						@(posedge clock);

#100000;
$stop;
end

endmodule
