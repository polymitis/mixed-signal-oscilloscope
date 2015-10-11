//% @file SCDAQ.v
//% @author Petros Fountas, Apurva Modak
//% @brief Single Channel Data Acquisition module.

module SCDAQ (
  Reset_n,    // Asynchronous active-low reset
  
  // Data acquisition
  DAQ_Clock,  // Data acquisition sampling clock
  DAQ_D,      // Data acquisition sample value
  
  // Configuration interface
  TRG_MODE,   // Trigger mode
  TRG_LVL,    // Trigger level
  
  // Data readout
  RDO_Clock,  // Readout clock
  RDO_Add,    // Readout address
  RDO_Req,    // Readout request
  RDO_Ack,    // Readout acknowledgement
  RDO_Q,      // Readout data bus
  RDO_Done    // Readout done
);

  parameter NSAMPLES     = 512;                 // No. samples
  parameter PRECISION    = 14;                  // Sample precision 
  parameter RDO_ADD_LEN  = NSAMPLES;            // Readout Address length
  parameter RDO_ADD_BLEN = 9;                   // Readout Addr bin length

  // Asynchronous active-low reset
  input  Reset_n;
  
  // Data acquisition
  input                     DAQ_Clock; // Data acquisition sampling clock
  input  [PRECISION-1:0]    DAQ_D;     // Data acquisition sample value
  
  // Configuration interface
  input  [2:0]              TRG_MODE;  // Trigger mode
  input  [PRECISION-1:0]    TRG_LVL;   // Trigger level
  
  // Data readout
  input                     RDO_Clock; // Readout clock
  input  [RDO_ADD_BLEN-1:0] RDO_Add;   // Readout sample index
  input                     RDO_Req;   // Readout request
  output                    RDO_Ack;   // Readout acknowledgement
  output [PRECISION-1:0]    RDO_Q;     // Readout sample value
  input                     RDO_Done;  // Readout done
  
  wire   [PRECISION-1:0]    DAQ_Q;
  wire                      Trigger;

  defparam SCDAQ_CTP_inst.PRECISION = PRECISION;
  SCDAQ_CTP SCDAQ_CTP_inst (
    .Reset_n    ( Reset_n   ),
    .DAQ_Clock  ( DAQ_Clock ),
    .DAQ_D      ( DAQ_D     ),
    .DAQ_Q      ( DAQ_Q     ),
    .DAQ_Trg    ( Trigger   ),
    .TRG_MODE   ( TRG_MODE  ),
    .TRG_LVL    ( TRG_LVL   ));
  
  defparam SCDAQ_BUF_inst.NSAMPLES  = NSAMPLES;
  defparam SCDAQ_BUF_inst.PRECISION = PRECISION;
  defparam SCDAQ_BUF_inst.RDO_ADD_LEN = RDO_ADD_LEN;
  defparam SCDAQ_BUF_inst.RDO_ADD_BLEN = RDO_ADD_BLEN;
  SCDAQ_BUF SCDAQ_BUF_inst (
    .Reset_n    ( Reset_n   ),
    .DAQ_Clock  ( DAQ_Clock ),
    .DAQ_D      ( DAQ_Q     ),
    .DAQ_Trg    ( Trigger   ),
    .RDO_Clock  ( RDO_Clock ),
    .RDO_Add    ( RDO_Add   ),
    .RDO_Req    ( RDO_Req   ),
    .RDO_Ack    ( RDO_Ack   ),
    .RDO_Q      ( RDO_Q     ),
    .RDO_Done   ( RDO_Done  ));

endmodule