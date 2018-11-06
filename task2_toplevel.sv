module task2_toplevel (clock, en, reset, A, found, f_addr);
	input logic clock;
	input logic en;
	input logic reset;
	input logic[7:0] A;
	output logic found;
	output logic [4:0] f_addr;

	
	logic F, NF;
	
	binarysearch_controller control(clock, reset, en, F, NF,
												set_L, set_R, set_M, load_A);
	binarysearch_datapath data(clock, A, F, NF, set_L, set_R, set_M, load_A, 
										rd_reg, L, R, M, A_reg);
endmodule 