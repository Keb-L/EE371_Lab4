module Hex2Seg
(input logic [4:0] hexIn,
 output logic [6:0] segOut);

 
logic [6:0] ret;

always_comb begin
case (hexIn) 
 5'h0: ret = 7'h3F;
 5'h1: ret = 7'h06;
 5'h2: ret = 7'h5B;
 5'h3: ret = 7'h4F;
 5'h4: ret = 7'h66;
 5'h5: ret = 7'h6D;
 5'h6: ret = 7'h7D;
 5'h7: ret = 7'h07;
 5'h8: ret = 7'h7F;
 5'h9: ret = 7'h6F;
 5'hA: ret = 7'h77;
 5'hB: ret = 7'h7C;
 5'hC: ret = 7'h39;
 5'hD: ret = 7'h5E;
 5'hE: ret = 7'h79;
 5'hF: ret = 7'h71;
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
