//% @file SCDAQ_CTP.v
//% @author Petros Fountas, Apurva Modak
//% @brief Single Channel Data Acquisition system Central Trigger Processor.

module SCDAQ_CTP (
  Reset_n,   // Asynchronous active-low reset
  
  // Data acquisition interface
  DAQ_Clock, // Data acquisition sampling clock
  DAQ_D,     // Data acquisition sample input
  DAQ_Q,     // Data acquisition sample output
  DAQ_Trg,   // Data acquisition trigger
  
  // Configuration interface
  TRG_MODE,  // Trigger mode
  TRG_LVL    // Trigger level
);
  parameter PRECISION = 8; //bit
  parameter NSAMPLES = 2; //samples
  
  // Asynchronous active-low reset
  input  Reset_n;
  
  // Data acquisition
  input                      DAQ_Clock; // Data acquisition sampling clock
  input      [PRECISION-1:0] DAQ_D;     // Data acquisition input sample value
  output reg [PRECISION-1:0] DAQ_Q;     // Data acquisition output sample value
  output reg                 DAQ_Trg;   // Data acquisition trigger
  
  // Configuration interface
  input      [2:0]           TRG_MODE;  // Trigger mode
  input      [PRECISION-1:0] TRG_LVL;   // Trigger level
            
  // Trigger modes
  parameter NOTRG          = 0, // No trigger ( Continuous acquisition )
            MODE_LVL       = 1, // Level
            MODE_PEDGE     = 2, // Positive edge
            MODE_NEDGE     = 3, // Negative edge
            MODE_LVL_PEDGE = 4, // Level and Positive edge
            MODE_LVL_NEDGE = 5; // Level and Negative edge

  // Level trigger
  reg LVL_TRG;
  
  // Positive edge trigger
  reg PEDGE_TRG;
  
  // Negative edge trigger
  reg NEDGE_TRG;
  
  // Samples buffer (Shift register using LEs)
  reg [PRECISION-1:0] SR[NSAMPLES-1:0];

  // Trigger mode decoder
  always @ ( TRG_MODE, TRG_LVL, SR[NSAMPLES-1], SR[NSAMPLES-2],
             LVL_TRG, PEDGE_TRG, NEDGE_TRG ) begin
    
    // Level detection trigger
    LVL_TRG <= ( SR[NSAMPLES-1] >= TRG_LVL );
    
    // Positive edge detection trigger
    PEDGE_TRG <= ( SR[NSAMPLES-1] >= SR[NSAMPLES-2] );
    
    // Negative edge detection trigger
    NEDGE_TRG <= ( SR[NSAMPLES-1] < SR[NSAMPLES-2] );
    
    DAQ_Trg <= 1;
    case ( TRG_MODE )
      // Level
      MODE_LVL: begin
        DAQ_Trg <= LVL_TRG;
      end
      // Positive edge
      MODE_PEDGE: begin
        DAQ_Trg <= PEDGE_TRG;
      end
      // Negative edge
      MODE_NEDGE: begin
        DAQ_Trg <= NEDGE_TRG;
      end
      // Level & Positive edge
      MODE_LVL_PEDGE: begin
        DAQ_Trg <= LVL_TRG && PEDGE_TRG;
      end
      // Level & Negative edge
      MODE_LVL_NEDGE: begin
        DAQ_Trg <= LVL_TRG && NEDGE_TRG;
      end
      // No trigger ( Continuous acquisition )
      default: begin // NOTRG
        DAQ_Trg <= 1;
      end
    endcase
  end
  
  // Shift register
  always @ (DAQ_D, SR[NSAMPLES-1]) begin
    SR[0] <= DAQ_D;
    DAQ_Q <= SR[NSAMPLES-1];
  end
  integer isample;
  always @ (posedge DAQ_Clock or negedge Reset_n) begin
    if (Reset_n == 1'b0) begin
      for (isample = NSAMPLES-1; isample > 0; isample = isample - 1)
        SR[isample] <= 'b0; // clear shift register
    end
    else begin
      for (isample = NSAMPLES-1; isample > 0; isample = isample - 1)
        SR[isample] <= SR[isample-1]; // shift samples
    end
  end

endmodule
