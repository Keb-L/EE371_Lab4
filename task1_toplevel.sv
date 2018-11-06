module task1_toplevel (clock, A, reset, s);
	input logic clock;
	input logic [7:0] A;
	input logic reset, s;
	
	bit_counter_controller control (clock, reset, s, A, load_a, up_result);
	bit_counter_datapath data (clock, up_result, A, load_a, result);
endmodule 