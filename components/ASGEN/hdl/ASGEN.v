//% @file ASGEN.v
//% @author Petros Fountas, Apurva Modak
//% @brief Generates a Square Wave.

module ASGEN (
  input         Clock,    // 10 MHz
  input         Reset_n,  
  output [13:0] SignalOut // Square Wave of 1.250 MHz
);

  // Internal feeding
  //parameter VMIN = 15'hFFF;
  //parameter VPP = 15'h1FF;
  //parameter HALFPERIOD = 4;
  
  // External feeding
  parameter VMIN = 15'h3F;
  parameter VPP = 15'hFFF; // 144 mV
  parameter HALFPERIOD = 2;

  reg [14:0] Signal_q, Signal_d;
  
  reg [9:0] CC;
  
  (* syn_encoding = "user, safe" *) reg [1:0] State_q, State_d;
  parameter RISING_STATE = 3'b01,
            FALLING_STATE = 3'b10;
            
  always @ (State_q, Signal_q, CC) begin
  
    Signal_d <= Signal_q;
    
    State_d <= State_q;
    case (State_q)
      RISING_STATE : begin
        Signal_d <= VPP + VMIN;
        if (CC == 'b0)
          State_d <= FALLING_STATE;
      end
      FALLING_STATE : begin
        Signal_d <= VMIN;
        if (CC == 'b0)
          State_d <= RISING_STATE;
      end
      default : begin
        State_d <= FALLING_STATE;
      end
    endcase
  end
  
  assign SignalOut = Signal_q[13:0];
  
  always @ (posedge Clock or negedge Reset_n) begin
    if ( Reset_n == 1'b0 ) begin
      State_q <= RISING_STATE;
      Signal_q <= VMIN;
      CC <= 'b0;
    end
    else begin
      State_q <= State_d;
      Signal_q <= Signal_d;
      CC <= ( CC > HALFPERIOD )? 'b0 : CC + 1;
    end
  end

endmodule