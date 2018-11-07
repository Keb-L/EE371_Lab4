module Hex2Seg
(input logic [4:0] hexIn,
 output logic [6:0] segOut);

 
logic [6:0] ret;

always_comb begin
case (hexIn) 
 5'h0_0: ret = 7'h3F;
 5'h0_1: ret = 7'h06;
 5'h0_2: ret = 7'h5B;
 5'h0_3: ret = 7'h4F;
 5'h0_4: ret = 7'h66;
 5'h0_5: ret = 7'h6D;
 5'h0_6: ret = 7'h7D;
 5'h0_7: ret = 7'h07;
 5'h0_8: ret = 7'h7F;
 5'h0_9: ret = 7'h6F;
 5'h0_A: ret = 7'h77;
 5'h0_B: ret = 7'h7C;
 5'h0_C: ret = 7'h39;
 5'h0_D: ret = 7'h5E;
 5'h0_E: ret = 7'h79;
 5'h0_F: ret = 7'h71;
 default: ret = 7'h00;
 endcase
end

assign segOut = ~ret;

 
endmodule


module Hex2Seg_testbench();
logic [3:0] hexIn;
logic [6:0] segOut;

Hex2Seg dut (.*);

initial begin
hexIn = 'z; #20;
$stop;
end


endmodule
