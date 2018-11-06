module bit_counter_controller (clock, reset, s, A, load_a, up_result);
	input logic clock;
	input logic reset, s;
	input logic [7:0] A;
	output logic load_a, up_result;
	
	logic[1:0] next_state, state;
	parameter s_idle = 2'b00, s_right_shift = 2'b01, s_done = 2'b10;
	
	always_ff @(posedge clock) begin
		if (reset) state <= s_idle;
		else state <= next_state;
	end
	
	always_comb begin
		case (state)
			s_idle: 	if (s) next_state = s_right_shift;
						else next_state = s_idle;
			s_right_shift: if (A != 0) next_state = s_done;
								else next_state = s_right_shift;
			s_done:	if (s) next_state = s_done;
						else next_state = s_idle;
		endcase
	end 
	
	always_comb begin
		load_a = 0;
		up_result = 0;
		
		case (state)
			s_idle: 	if (!s) load_a = 1;
						else load_a = 0;
			s_right_shift:	if ((A != 0) & (A[0])) up_result = 1;
								else up_result = 0;
			s_done:	;
		endcase
	end
	
endmodule 