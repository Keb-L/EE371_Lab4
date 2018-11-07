module bit_counter_datapath 
#(
	parameter 	A_WIDTH = 8,
					RET_WIDTH = 4
)
(clock, up_result, A, load_a, result, done, isZero, hex_en);
	input logic clock;
	input logic up_result, load_a, done;
	input logic [A_WIDTH-1:0] A;
	output logic isZero;
	output logic [RET_WIDTH-1:0] result;
	output logic hex_en;
	
	logic [A_WIDTH-1:0] A_reg;
	logic [RET_WIDTH-1:0] result_reg;
	
	// done if A_reg is zero
	assign isZero = (~|A_reg | done) ? 1 : 0;
	
	always_ff @(posedge clock) begin
		if (load_a) begin A_reg <= A; 
								result_reg <= 0; end
		if (up_result) begin
								if (|A_reg & A_reg[0]) 
									result_reg <= result_reg + 1'b1;
								A_reg <= A_reg >> 1;	
							end
	end
	
	assign result = done ? result_reg : '0;
	assign hex_en = done ? 1'b1 : 1'b0;
endmodule 