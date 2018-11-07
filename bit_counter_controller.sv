module bit_counter_controller 
#(
	parameter 	A_WIDTH = 8,
					RET_WIDTH = 4
)
(clock, reset, s, A, isZero, load_a, up_result, done);
	input logic clock;
	input logic reset, s;
	input logic isZero;
	input logic [A_WIDTH-1:0] A;
	output logic load_a, up_result, done;
	
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
			s_right_shift: if (isZero) next_state = s_done;
								else next_state = s_right_shift;
			s_done:	if (s) next_state = s_done;
						else next_state = s_idle;
		endcase
	end 
	
	always_comb begin
		load_a = 0;
		up_result = 0;
		done = 0;
		
		case (state)
			s_idle: 	if (!s) load_a = 1;
			s_right_shift:	up_result = 1;
			s_done:	done = 1;
		endcase
	end
	
endmodule 