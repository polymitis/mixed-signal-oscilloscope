//% @file DSGEN.v
//% @author Petros Fountas, Apurva Modak
//% @brief Plots a signal on the display

module DSGEN (
  input         Clock,    // 10 MHz
  input         Reset_n,
  input         Configure,
  input  [9:0]  Pattern,
  input  [9:0]  PeriodDelay,
  output [0:0]  SignalOut 
);

  reg [0:0] Signal_q, Signal_d;
  
  reg [9:0] Pattern_q, Pattern_d;
  
  reg [9:0] PeriodDelay_q, PeriodDelay_d;
  
  reg [9:0] CC_q, CC_d; // Cycle Counter
  
  reg [3:0] PC_q, PC_d; // Pattern Counter
  
  reg NextBit;
  
  (* syn_encoding = "user, safe" *) reg [1:0] State_q, State_d;
  parameter RISING_STATE = 1'b0,
            FALLING_STATE = 1'b1;
          
  always @ (State_q, Signal_q, Configure, Pattern, Pattern_q,
            PeriodDelay,PeriodDelay_q, PC_q, CC_q, NextBit) begin
    
    Pattern_d <= Pattern_q;
    if (Configure == 1'b1)
      Pattern_d <= Pattern;
    
    PeriodDelay_d <= PeriodDelay_q;
    if (Configure == 1'b1)
      PeriodDelay_d <= PeriodDelay;
    
    CC_d <= ( CC_q >= PeriodDelay_q-1 )? 'b0 : CC_q + 1;
    
    NextBit <= Pattern_q[ PC_q ];
    
    PC_d <= PC_q;
    Signal_d <= Signal_q;
    State_d <= State_q;
    case (State_q)
      RISING_STATE : begin
        Signal_d <= 1'b1;
        if ( CC_q == 'b0 ) begin
          PC_d <= ( PC_q == 8 )? 'b0 : PC_q + 1;
          if ( NextBit == 1'b0)  
            State_d <= FALLING_STATE;
        end
      end
      FALLING_STATE : begin
        Signal_d <= 1'b0;
        if ( CC_q == 'b0 ) begin
          PC_d <= ( PC_q == 8 )? 'b0 : PC_q + 1;
          if ( NextBit == 1'b1 )
            State_d <= RISING_STATE;
        end
      end
    endcase
  end
  
  assign SignalOut = Signal_q[0:0];
  
  always @ (posedge Clock or negedge Reset_n) begin
    if ( Reset_n == 1'b0 ) begin
      State_q <= FALLING_STATE;
      Pattern_q <= 'b0;
      PeriodDelay_q <= 'b0;
      Signal_q <= 1'b0;
      CC_q <= 'b0;
      PC_q <= 'b0;
    end
    else begin
      State_q <= State_d;
      Pattern_q <= Pattern_d;
      PeriodDelay_q <= PeriodDelay_d;
      Signal_q <= Signal_d;
      CC_q <= CC_d;
      PC_q <= PC_d;
    end
  end

endmodule