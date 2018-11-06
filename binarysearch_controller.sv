module binarysearch_controller (clock, reset, en, F, NF,  
											done, set_L, set_R, set_M, load_A);
input logic clock, reset, en;
input logic F, NF; // Found, Not Found
output logic done, set_L, set_R, set_M, load_A;

logic [1:0] state, next_state;
parameter s_idle = 2'b00, s_memgrab = 2'b01, s_compare = 2'b10, s_done = 2'b11;

//
always_ff @(posedge clock)
	if(reset) state <= s_idle;
	else	state <= next_state;

always_comb begin
	case(state)
		s_idle : if(en) next_state = s_compare;
				  else	next_state = s_idle;
		s_memgrab : next_state = s_compare;
		
		s_compare : 	if(F | NF) next_state = s_done;
						else next_state = s_memgrab;
						
		s_done : 	if(en) next_state = s_done;
					else next_state = s_idle;
					
		default: next_state = s_idle;
	endcase
end
	
always_comb begin
	set_L = 0;
	set_R = 0;
	set_M = 0;
	load_A = 0;
	done = 0;
	
	case(state) 
		s_idle : begin load_A = 1; 
							set_L = 1;
							set_R = 1; end

		s_memgrab : set_M = 1;
		s_compare :  begin set_M = 1;
								 set_L = 1;
								 set_R = 1; end
//		s_done : done = 1;
	endcase
end

endmodule

`timescale 1ps/1ps
module binarysearch_controller_testbench();
	logic clock, reset, en;
	logic F, NF; // Found, Not Found
	logic done, set_L, set_R, set_M, load_A;
	
	binarysearch_controller dut(.clock, .reset, .en, .F, .NF,  
											.done, .set_L, .set_R, .set_M, .load_A);
	
	parameter CLOCK_PERIOD = 100; // 20 ns / CLOCK_50
	initial begin
		clock <= 0;
		forever #(CLOCK_PERIOD/2) clock <= ~clock;
	end
	
	initial begin
	reset = 1;	@(posedge clock);
	reset = 0;	@(posedge clock);
	en = 1;		@(posedge clock);
					@(posedge clock);
					@(posedge clock);
					@(posedge clock);
	F = 1;		@(posedge clock);
					@(posedge clock);
					@(posedge clock);
	F = 0; en = 0;		@(posedge clock);
					@(posedge clock);
					@(posedge clock);
	en = 1;		@(posedge clock);
					@(posedge clock);
					@(posedge clock);
					@(posedge clock);
	NF = 1;		@(posedge clock);
					@(posedge clock);
					@(posedge clock);
					@(posedge clock);
	en = 0;		@(posedge clock);
					@(posedge clock);
					@(posedge clock);
	$stop;
	end
	
endmodule 