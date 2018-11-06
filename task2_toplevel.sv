module task2_toplevel 
#(
	parameter VAL_WIDTH = 8,
				 ADDR_WIDTH = 5
)
(clock, en, reset, A, F, F_addr, done, state, next_state);

	input logic clock;
	input logic en;
	input logic reset;
	input logic[VAL_WIDTH-1:0] A;
	output logic F, done;
	output logic [ADDR_WIDTH-1:0] F_addr;
	
	//temp
	output logic [1:0] state, next_state;
	
	binarysearch_controller control 
		(clock, reset, en, F, NF, done, set_L, set_R, set_M, load_A, state, next_state);
													
	binarysearch_datapath #(VAL_WIDTH, ADDR_WIDTH) data 
		(	clock, A, set_L, set_R, set_M, load_A, done, F, NF, F_addr);
		
endmodule 

`timescale 1ps/1ps
module task2_testbench();
parameter VAL_WIDTH = 8,
			ADDR_WIDTH = 5;
			
logic clock, en, reset;
logic [VAL_WIDTH-1:0] A;
logic F, done;
logic [ADDR_WIDTH-1:0] F_addr;

// temp
logic [1:0] state, next_state;

task2_toplevel #(VAL_WIDTH, ADDR_WIDTH) dut (.*);

// Clock Setup
parameter CLOCK_PERIOD = 20000; // 20 ns / CLOCK_50
initial begin
	clock <= 0;
	forever #(CLOCK_PERIOD/2) clock <= ~clock;
end

initial begin
reset = 1;	en = 0;		@(posedge clock);
reset = 0;					@(posedge clock);
A = 8'd21;	en = 0;		@(posedge clock);
while (~done) begin
	en = 1; 	@(posedge clock);
end
#100000;
en = 0;						@(posedge clock);

#100000;
$stop;
end

endmodule
