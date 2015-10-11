//% @file SCDAQ_tb.sv
//% @author Petros Fountas
//% @brief Single Channel Data Acquisition system testbench.
`timescale 1ns/1ps

module SCDAQ_tb;

  //% CLOCK_50
  parameter CLOCK_50_T = 20; //ns, F_sys = 50 MHz
  reg CLOCK_50 = 1'b0; 
  always begin
    #(CLOCK_50_T/2) CLOCK_50 = 1'b1;
    #(CLOCK_50_T/2) CLOCK_50 = 1'b0;
  end
  
  //% CLOCK_625EN1
  parameter CLOCK_625EN1_T = 16; //ns, F_s = 62.5 MHz
  reg CLOCK_625EN1 = 1'b0; 
  always begin
    #(CLOCK_625EN1_T/2) CLOCK_625EN1 = 1'b1;
    #(CLOCK_625EN1_T/2) CLOCK_625EN1 = 1'b0;
  end
  
  // ************************
  // Device-Under-Test
  // ************************
  
  reg         Reset_n;
  
  reg  [13:0] DAQ_D;
  
  reg  [9:0]  CFG_Add;
  reg         CFG_Req,
              CFG_WREn,
              CFG_Done;
  wire        CFG_Ack;
  reg  [13:0] CFG_D;
  wire        CFG_Q;
              
  reg  [7:0]  RDO_Add;
  reg         RDO_Req,
              RDO_Done;
  wire        RDO_Ack;
  wire [13:0] RDO_Q;
  
  defparam SCDAQ_inst.NSAMPLES     = 128;
  defparam SCDAQ_inst.PRECISION    = 14;
  defparam SCDAQ_inst.RDO_ADD_BLEN = 7;
  defparam SCDAQ_inst.NCTPSAMPLES  = 8;
  defparam SCDAQ_inst.CFG_ADD_BLEN = 5;
  SCDAQ SCDAQ_inst (
    .Reset_n    ( Reset_n      ),
    .DAQ_Clock  ( CLOCK_625EN1 ),
    .DAQ_D      ( DAQ_D        ),
    .CFG_Clock  ( CLOCK_50     ),
    .CFG_Req    ( CFG_Req      ),
    .CFG_Ack    ( CFG_Ack      ),
    .CFG_Add    ( CFG_Add      ),
    .CFG_D      ( CFG_D        ),
    .CFG_Q      ( CFG_Q        ),
    .CFG_WREn   ( CFG_WREn     ),
    .CFG_Done   ( CFG_Done     ),
    .RDO_Clock  ( CLOCK_50     ),
    .RDO_Add    ( RDO_Add      ),
    .RDO_Req    ( RDO_Req      ),
    .RDO_Ack    ( RDO_Ack      ),
    .RDO_Q      ( RDO_Q        ),
    .RDO_Done   ( RDO_Done     ));
  
  // ************************
  // Test 
  // ************************
  
  initial begin
    
    #100  // wait for chip to initialise
    
    $display("Test initiated");
    Reset_n  = 1'b0;
    DAQ_D    = 14'b00000000000000;
    CFG_Add  = 10'b0000000000;
    CFG_WREn = 1'b0;
    CFG_D    = 14'b00000000000000;
    CFG_Done = 1'b0;
    
    // Reset_n [Pulse]
    Reset_n = 1'b0;
    #(3*CLOCK_50_T) // 150 ns
    Reset_n = 1'b1;
    
    // Deactivate trigger
    CFG_Req  = 1'b1;
    CFG_WREn = 1'b1; // set NOTRG to MODE
    CFG_Add  = 10'b0000000000;     // MODE
    CFG_D    = 14'b00000000000000; // NOTRG
    while ( CFG_Ack != 1'b1 ) #(CLOCK_50_T);
    CFG_Req = 1'b0;
    CFG_WREn = 1'b0;
    CFG_Done = 1'b1;
    #(CLOCK_50_T); CFG_Done = 1'b0;
    
    #(200*CLOCK_50_T) // 10 us
    
    #10 $display("Test completed");
    $finish;
  end
  
  // ************************
  // A\D Input (62.5 MHz)
  // ************************
  
  reg [14:0] data = 14'b0; // initial value
  always begin
  // Feed DAQ with samples
    DAQ_D = data; // send value
    data += 1;    // increase value
    #(CLOCK_625EN1_T/2); // wait for a half-cycle
  end
  
  // ****************
  // Readout (50 MHz)
  // ****************
  
  reg [7:0] isample;
  always begin
    isample = 'b0;
    RDO_Req  = 1'b0;
    RDO_Done = 1'b0;
    #(50*CLOCK_50_T); // wait for 1 us
    RDO_Req  = 1'b1;
    for ( isample = 0; isample < 64; isample++ ) begin
    // Get the first 160 samples,
      RDO_Add = isample;                       // set sample index
      RDO_Req = 1'b1;                          // request sample
      while ( RDO_Ack != 1'b1 ) #(CLOCK_50_T); // wait for ack
      #(CLOCK_50_T);                           // wait for a cycle
    end
    RDO_Req  = 1'b0;  // stop requesting samples
    RDO_Done = 1'b1;  // indicate end of reading
    #(50*CLOCK_50_T); // wait for 1 us
  end
  
  // ****************
  // Response monitor
  // ****************
  
  initial begin
    $display("Time            | Reset_n | RDO_Req | RDO_Ack | RDO_Done | RDO_Q ");
    $monitor("%15t | %1b    | %1b     | %1b     | %1b      | %14d  ",
              $time, Reset_n, RDO_Req,  RDO_Ack,  RDO_Done,  RDO_Q );
  end

endmodule
