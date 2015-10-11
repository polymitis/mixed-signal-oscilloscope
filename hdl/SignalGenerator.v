//% @file SignalGenerator.v
//% @author Petros Fountas
//% @brief Plots a signal on the display

module SignalGenerator (
  input         Clock,    // 50 MHz
  input         Reset_n,
  output [13:0] SignalOut // 25 MHz square wave
);

   // 2 time steps
  parameter VPP = 15'hFFF;

  reg [14:0] Signal_q, Signal_d;
  
  (* syn_encoding = "user, safe" *) reg [1:0] State_q, State_d;
  parameter RISING_STATE = 3'b01,
            FALLING_STATE = 3'b10;
            
  always @ (State_q, Signal_q) begin
  
    Signal_d <= Signal_q;
    
    State_d <= State_q;
    case (State_q)
      RISING_STATE : begin
        Signal_d <= VPP;
        State_d <= FALLING_STATE;
      end
      FALLING_STATE : begin
        Signal_d <= 'b0;
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
      Signal_q <= 'b0;
    end
    else begin
      State_q <= State_d;
      Signal_q <= Signal_d;
    end
  end

endmodule