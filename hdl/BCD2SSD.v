//% @file BCD2SSD.v
//% @author Petros Fountas
//% @brief A BCD to seven segment display (G-A) converter.

module BCD2SSD (
  output reg [6:0] SSDOut, //% 7 segment display (G-A) output vector
  input      [3:0] BCDIn    //% BCD number input
);
  always @ (BCDIn)
    case (BCDIn)
      4'h0 : SSDOut <= 7'h3F;
      4'h1 : SSDOut <= 7'h06;
      4'h2 : SSDOut <= 7'h5B;
      4'h3 : SSDOut <= 7'h4F;
      4'h4 : SSDOut <= 7'h66;
      4'h5 : SSDOut <= 7'h6D;
      4'h6 : SSDOut <= 7'h7D;
      4'h7 : SSDOut <= 7'h07;
      4'h8 : SSDOut <= 7'h7F;
      4'h9 : SSDOut <= 7'h6F;
      4'hA : SSDOut <= 7'h77;
      4'hB : SSDOut <= 7'h7C;
      4'hC : SSDOut <= 7'h39;
      4'hD : SSDOut <= 7'h5E;
      4'hE : SSDOut <= 7'h79;
      4'hF : SSDOut <= 7'h71;
      default :
        SSDOut <= 7'h00;
    endcase

endmodule