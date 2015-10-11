//% @file SCDAQ_BUF.v
//% @author Petros Fountas, Apurva Modak
//% @brief Single Channel Data Acquisition Buffer.

module SCDAQ_BUF (
  Reset_n,   // Asynchronous active-low reset
  
  // Data acquisition
  DAQ_Clock, // Data acquisition sampling clock
  DAQ_D,     // Data acquisition sample value
  DAQ_Trg,   // Data acquisition trigger
  
  // Data readout
  RDO_Clock,  // Readout clock
  RDO_Add,    // Readout address
  RDO_Req,    // Readout request
  RDO_Ack,    // Readout acknowledgement
  RDO_Q,      // Readout data bus
  RDO_Done    // Readout done
);

  parameter NSAMPLES     = 128;      // No. samples
  parameter PRECISION    = 8;        // Sample precision
  parameter RDO_ADD_LEN  = NSAMPLES; // Readout Address length
  parameter RDO_ADD_BLEN = 7;        // Readout Address binary length

  // Asynchronous active-low reset
  input  Reset_n;
  
  // Data acquisition
  input                         DAQ_Clock; // Data acquisition sampling clock
  input      [PRECISION-1:0]    DAQ_D;     // Data acquisition sample value
  input                         DAQ_Trg;   // Data acquisition trigger
  
  // Data readout
  input                         RDO_Clock;  // Readout clock
  input      [RDO_ADD_BLEN-1:0] RDO_Add;    // Readout sample index
  input                         RDO_Req;    // Readout request
  output reg                    RDO_Ack;    // Readout acknowledgement
  output reg [PRECISION-1:0]    RDO_Q;      // Readout sample value
  input                         RDO_Done;   // Readout done
  
  // FSM state parameters and registers
  (* syn_encoding = "user" *) reg [1:0] State_Q, State_D;
  // One-Hot encoding (for speed)
  parameter DAQ_STATE = 2'b01, // Data acquisition state.
            RDO_STATE = 2'b10; // Readout state.
  
  // Samples buffer (Dual-port RAM)
  // [Note] Read-write checks are not needed because the operations happen
  //        on different FSM states.
  (* ramstyle = "M4K, no_rw_check" *)  reg [PRECISION-1:0] RAM[RDO_ADD_LEN-1:0];
  
  reg [RDO_ADD_BLEN-1:0] DAQ_Add; // Samples buffer slot index
  
  reg DAQ_Start;
  
  wire DAQ_Fin; // Data acquisition cycle finished
  
  assign DAQ_Fin = ( DAQ_Add == 0 );
  
  // Data acquisition memory operation
  always @ (posedge DAQ_Clock or negedge Reset_n) begin
    if (Reset_n == 1'b0) begin
      DAQ_Start <= 1'b0;
      DAQ_Add <= 'b0; // set initial address
    end
    // [Note] Memory is written only during data acquisition state.
    else if ( State_D == DAQ_STATE ) begin
      if ( DAQ_Trg == 1'b1 && DAQ_Add == 0) begin
        RAM[0] <= DAQ_D; // save first sample
        DAQ_Add <= 1; // set next slot index
      end
      // [Note] The acquisition will stop when the memory slot index reaches 0 
      //        due to overflow and it will begin again on the next trigger.
      else if ( DAQ_Add != 0 ) begin
        RAM[DAQ_Add] <= DAQ_D; // save sample
        DAQ_Add <= DAQ_Add + 1; // increase slot index
        DAQ_Start <= 1'b1;
      end
    end
  end
  
  // Readout memory operation
  always @ (posedge RDO_Clock) begin
    if (Reset_n == 1'b0) begin
      RDO_Ack <= 1'b0;
    end
    // [Note] Memory is read only during readout state.
    else if ( State_D == RDO_STATE ) begin
      RDO_Ack <= 1'b0;
      if ( RDO_Req == 1'b1 ) begin
        RDO_Q <= RAM[RDO_Add]; // present sample value
        RDO_Ack <= 1'b1; // acknowledge request
      end
    end
  end
    
  // FSM state decoder
  always @ ( State_Q, DAQ_Start, DAQ_Fin, RDO_Req, RDO_Done ) begin
    State_D <= State_Q; 
    case (State_Q) 
      DAQ_STATE : begin
        if ( DAQ_Start == 1'b1 // data acquisition cycle started
          && DAQ_Fin == 1'b1   // data acquisition cycle finished
          && RDO_Req == 1'b1 ) // readout request pending
          State_D <= RDO_STATE; // procceed to readout state
      end
      RDO_STATE : begin
        if ( RDO_Done == 1'b1 ) // readout finished
          State_D <= DAQ_STATE; // procceed to data acquisition state
      end
      default : // illegal state
        State_D <= DAQ_STATE; // procceed to data acquisition state 
    endcase
  end
  
  // FSM sequential part 
  always @ (posedge RDO_Clock or negedge Reset_n) begin
    if (Reset_n == 1'b0)
      State_Q <= DAQ_STATE;
    else
      State_Q <= State_D;
  end

endmodule
