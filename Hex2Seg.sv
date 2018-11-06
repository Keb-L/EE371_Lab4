module Hex2Seg
(input logic [3:0] hexIn,
 output logic [6:0] segOut);

 
logic [6:0] ret;

always_comb begin
case (hexIn) 
 4'h0: ret = 7'h3F;
 4'h1: ret = 7'h06;
 4'h2: ret = 7'h5B;
 4'h3: ret = 7'h4F;
 4'h4: ret = 7'h66;
 4'h5: ret = 7'h6D;
 4'h6: ret = 7'h7D;
 4'h7: ret = 7'h07;
 4'h8: ret = 7'h7F;
 4'h9: ret = 7'h6F;
 4'hA: ret = 7'h77;
 4'hB: ret = 7'h7C;
 4'hC: ret = 7'h39;
 4'hD: ret = 7'h5E;
 4'hE: ret = 7'h79;
 4'hF: ret = 7'h71;
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
