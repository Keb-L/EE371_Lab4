module bit_counter_datapath (clock, up_result, A, load_a, result);
	input logic clock;
	input logic up_result, load_a;
	input logic [7:0] A;
	output logic result;
	
	logic [7:0] A_reg;
	logic [3:0] result_reg;
	always_ff @(posedge clock) begin
		if (load_a) A_reg <= A;
		if (up_result) begin
			result_reg <= result_reg + 1'b1;
			A_reg <= A >> 1;
		end
	end
	
	assign result = result_reg;
endmodule 