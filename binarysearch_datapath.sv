module binarysearch_datapath 
#(
	parameter VAL_WIDTH = 8,
				 ADDR_WIDTH = 5
)
(
	clock, A, set_L, set_R, set_M, load_A, done,
	F, NF, F_addr, hex_en
);
	input logic clock;								// System Signals
	input logic [VAL_WIDTH-1:0] A; 			  	// Search value
	input logic set_L, set_R, set_M, load_A, done; 	// Control Signals
	output logic F, NF, hex_en;							  	// Output Signals
	output logic [ADDR_WIDTH-1:0] F_addr;
	
//	output logic [ADDR_WIDTH:0] L, R, M;
//	output logic [VAL_WIDTH-1:0] A_reg, rd_reg;
	
	logic [ADDR_WIDTH:0] M_temp;
	reg [ADDR_WIDTH:0] L, R, M; 		// Address pointers
	reg [VAL_WIDTH-1:0] A_reg, rd_reg;	// Value registers
	
	// Recompute M when set_M is high
	always_latch
		if (set_M) begin 
			M = (R + L) >> 1;
//			M_temp = (R + L) >> 1;
//			M = M_temp >> 1;
		end
	
	// Read 32x8 RAM memory, pre-init
	ram32x8_1p mem (.address(M), .clock(clock), .data(8'hFF), .wren(1'b0), .q(rd_reg));
	
	assign F_addr = F ? M :'bz;
//	assign F_addr = M;
	assign hex_en = F ? 1'b1: 1'b0;
	
	// Response to control signals
	always_ff @(posedge clock) begin
		if (load_A) A_reg <= A;
		if (~set_M & ~done) begin
			F <= 0;
			NF <= 0;
			if (set_L) L <= 0;
			if (set_R) R <= (2**ADDR_WIDTH)-1;
		end
		else // set_M asserted	
			if (L > R | L[ADDR_WIDTH] | R[ADDR_WIDTH]) NF <= 1; 						// End case: Not found
			else if(set_L & set_R)
				if (rd_reg == A_reg) F <= 1;	// End case: found
				else if (rd_reg < A_reg) L <= M + 1;// Recursion, right half
				else if (rd_reg > A_reg) R <= M - 1;// Recursion, left half
			//else {F,NF} <= {1'd1,1'd1};					// Paradox case (should never happen)
	end
		
endmodule 

`timescale 1ps/1ps
module binarysearch_datapath_testbench();
// Constants
parameter VAL_WIDTH = 8,
			 ADDR_WIDTH = 5;
			 
// Input/Output Signals
logic clock;								// System Signals
logic [VAL_WIDTH-1:0] A; 			  	// Search value
logic set_L, set_R, set_M, load_A, done; 	// Control Signals
logic F, NF, hex_en;							  	// Output Signals
logic [ADDR_WIDTH-1:0] F_addr;

// temp
logic [ADDR_WIDTH-1:0] L, R, M;
logic [VAL_WIDTH-1:0] A_reg, rd_reg;

binarysearch_datapath #(VAL_WIDTH, ADDR_WIDTH) dut (.*);

// Clock Setup
parameter CLOCK_PERIOD = 20000; // 20 ns / CLOCK_50
initial begin
	clock <= 0;
	forever #(CLOCK_PERIOD/2) clock <= ~clock;
end

initial begin
A = 8'hC1;
set_L = 0;	set_R = 0;	set_M = 0;	load_A = 0;	done = 0; @(posedge clock); // Reset State
																@(posedge clock);																
set_L = 1;	set_R = 1;					load_A = 1; @(posedge clock); // S_idle Control Signals
while (~F & ~NF) begin
set_L = 0;	set_R = 0;	set_M = 1;	load_A = 0; done = 0;	@(posedge clock); // S_getmem Control Signals
set_L = 1;	set_R = 1;	set_M = 1;	load_A = 0;	done = 0; @(posedge clock); // S_compute
end
done = 1;																@(posedge clock);
#200000;																
$stop;
end

endmodule