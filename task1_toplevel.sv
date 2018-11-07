module task1_toplevel
#(
	parameter 	A_WIDTH = 8,
					RET_WIDTH = 4
)
(clock, A, reset, s, result, hex_en, done);
	input logic clock;
	input logic [A_WIDTH-1:0] A;
	input logic reset, s;
	output logic [RET_WIDTH-1:0] result; // 1 bit for enabled
	output logic done, hex_en;
	
	// internals signals
	logic isZero, load_a, up_result;
	
	bit_counter_controller #(A_WIDTH, RET_WIDTH) control
		(clock, reset, s, A, isZero, load_a, up_result, done);
	
	bit_counter_datapath #(A_WIDTH, RET_WIDTH) data 
		(clock, up_result, A, load_a, result, done, isZero, hex_en);
	
endmodule 


`timescale 1ps/1ps
module task1_testbench();
parameter 	A_WIDTH = 8,
				RET_WIDTH = 3;
				
logic clock;
logic [A_WIDTH-1:0] A;
logic reset, s;
logic [RET_WIDTH-1:0] result;
logic done, hex_en;

task1_toplevel #(A_WIDTH, RET_WIDTH) dut (.*);

// Clock Setup
parameter CLOCK_PERIOD = 20000; // 20 ns / CLOCK_50
initial begin
	clock <= 0;
	forever #(CLOCK_PERIOD/2) clock <= ~clock;
end

initial begin
reset = 1;	s = 0;		@(posedge clock);
reset = 0;					@(posedge clock);
#100000;
A = 8'd21;	s = 0;		@(posedge clock);
//while (~done) begin
	s = 1; 	@(posedge clock);
#300000;
								@(posedge clock);
reset = 1;	s = 1;		@(posedge clock);
reset = 0;					@(posedge clock);

//end
#100000;
s = 0;						@(posedge clock);

#100000;
$stop;
end

endmodule
