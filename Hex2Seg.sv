module Hex2Seg
(input logic [3:0] hexIn,
 input logic hex_en,
 output logic [6:0] segOut);

 
logic [6:0] ret;

always_comb begin
case ({hex_en, hexIn}) 
 5'h1_0: ret = 7'h3F;
 5'h1_1: ret = 7'h06;
 5'h1_2: ret = 7'h5B;
 5'h1_3: ret = 7'h4F;
 5'h1_4: ret = 7'h66;
 5'h1_5: ret = 7'h6D;
 5'h1_6: ret = 7'h7D;
 5'h1_7: ret = 7'h07;
 5'h1_8: ret = 7'h7F;
 5'h1_9: ret = 7'h6F;
 5'h1_A: ret = 7'h77;
 5'h1_B: ret = 7'h7C;
 5'h1_C: ret = 7'h39;
 5'h1_D: ret = 7'h5E;
 5'h1_E: ret = 7'h79;
 5'h1_F: ret = 7'h71;
 default: ret = 7'h00;
 endcase
end

assign segOut = ~ret;

 
endmodule


module Hex2Seg_testbench();
logic [3:0] hexIn;
logic [6:0] segOut;
logic hex_en;

Hex2Seg dut (.*);

initial begin
hexIn = 'z; #20;
$stop;
end


endmodule
