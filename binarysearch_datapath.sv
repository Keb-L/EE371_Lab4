module binarysearch_datapath 
#(
	parameter WIDTH = 8
)
(
	clock, F, NF, set_L, set_R, set_M, load_A
);
	input logic clock;
	input logic [WIDTH-1] A;
	input logic set_L, set_R, set_M, load_A;
	output logic F, NF;
	
	reg[WIDTH-1:0] A_reg;
	always_ff @(posedge clock) begin
		if (load_A) A_reg <= A;
		if (~set_m) begin
			if (set_L) L <= 0;
			if (set_R) R <= memwidth-1;
		end
		else
			if (L > R) NF <= 1;
			else if (mem_at_M == A_reg) F <= 1;
			else if (mem_at_M < A_reg) L <= M + 1;
			else if (mem_at_M > A_reg) R <= M - 1;
			else {F,NF} <= {1,1};
	
	end
	
	always_latch
		if (set_M) M = (R+L) >> 1;
		
endmodule 