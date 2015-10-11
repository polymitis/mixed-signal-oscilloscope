//% @file MiniProject_DE270_Top.v
//% @author Petros Fountas, Apurva Modak
//% @brief ELEC5563 Mini-Project: Mixed Signal Oscilloscope.

module MiniProject_DE270_Top (
  // Oscillator (50 MHz)
  input CLOCK_50,
  
  // Reset_n
  input SW_17,
  
  // SW
  input [16:0] SW,
  
  // KEY
  input [3:0] KEY,
  
  // Reset indicator
  output LEDR_17,
  
  // LEDR
  output [16:0] LEDR,
  
  // LEDG
  output [8:0] LEDG,
  
  // 7SEG 0
  output [6:0] HEX0_D,
  
  // 7SEG 1
  output [6:0] HEX1_D,
  
  // 7SEG 2
  output [6:0] HEX2_D,
  
  // 7SEG 3
  output [6:0] HEX3_D,
  
  // 7SEG 4
  output [6:0] HEX4_D,
  
  // 7SEG 5
  output [6:0] HEX5_D,

  // VGA Interface
  output       VGA_CLK,
  
  output       VGA_HS,
  output       VGA_VS,
  output       VGA_BLANK,
  output       VGA_SYNC,
  
  output [9:0] VGA_R,
  output [9:0] VGA_G,
  output [9:0] VGA_B,
  
  // ADC Interface
  output        ADC_CLKA,
  output        ADC_CLKB,

  input  [13:0] ADC_DA,
  input         ADC_OTRA,
  output        ADC_OEA,
        
  input  [13:0] ADC_DB,
  input         ADC_OTRB,
  output        ADC_OEB,
    
  output        ADC_PWDN_AB,
  
  // DAC Interface
  output        DAC_CLKA,
  output        DAC_CLKB,

  output [13:0] DAC_DA,
  output        DAC_WRTA,
  
  output [13:0] DAC_DB,
  output        DAC_WRTB,
  
  output        DAC_MODE
);

  // Reset_n
  wire Reset_n;

  assign Reset_n = SW_17;
  assign LEDR_17 = SW_17;
  
  assign LEDR = SW;
  assign LEDG[7] = ~KEY[3],
         LEDG[6] =  KEY[3],
         LEDG[5] = ~KEY[2],
         LEDG[4] =  KEY[2],
         LEDG[3] = ~KEY[1],
         LEDG[2] =  KEY[1],
         LEDG[1] = ~KEY[0],
         LEDG[0] =  KEY[0];
  
  // 25 MHz clock
  wire CLOCK_25;
  
  // 10 MHz clock
  wire CLOCK_10;
  
  wire        DIG1_Configure;
  wire [9:0]  DIG1_Pattern;
  wire [9:0]  DIG1_PeriodDelay;
  wire [0:0]  DIG1_Signal;
  wire        DIG2_Configure;
  wire [9:0]  DIG2_Pattern;
  wire [9:0]  DIG2_PeriodDelay;
  wire [0:0]  DIG2_Signal;
  wire        DIG3_Configure;
  wire [9:0]  DIG3_Pattern;
  wire [9:0]  DIG3_PeriodDelay;
  wire [0:0]  DIG3_Signal;
  wire        DIG4_Configure;
  wire [9:0]  DIG4_Pattern;
  wire [9:0]  DIG4_PeriodDelay;
  wire [0:0]  DIG4_Signal;
  
  wire [8:0]  DIG1_RDO_Add;
  wire        DIG1_RDO_Req,
              DIG1_RDO_Done;
  wire        DIG1_RDO_Ack;
  wire [0:0]  DIG1_RDO_Q;
  wire [0:0]  DIG1_TDiv;
  wire [7:0]  DIG1_VShift;
  wire [0:0]  DIG1_TRG_LVL;
  wire [2:0]  DIG1_TRG_MODE;
  
  wire [8:0]  DIG2_RDO_Add;
  wire        DIG2_RDO_Req,
              DIG2_RDO_Done;
  wire        DIG2_RDO_Ack;
  wire [0:0]  DIG2_RDO_Q;
  wire [0:0]  DIG2_TDiv;
  wire [7:0]  DIG2_VShift;
  wire [0:0]  DIG2_TRG_LVL;
  wire [2:0]  DIG2_TRG_MODE;
  
  wire [8:0]  DIG3_RDO_Add;
  wire        DIG3_RDO_Req,
              DIG3_RDO_Done;
  wire        DIG3_RDO_Ack;
  wire [0:0]  DIG3_RDO_Q;
  wire [0:0]  DIG3_TDiv;
  wire [7:0]  DIG3_VShift;
  wire [0:0]  DIG3_TRG_LVL;
  wire [2:0]  DIG3_TRG_MODE;
  
  wire [8:0]  DIG4_RDO_Add;
  wire        DIG4_RDO_Req,
              DIG4_RDO_Done;
  wire        DIG4_RDO_Ack;
  wire [0:0]  DIG4_RDO_Q;
  wire [0:0]  DIG4_TDiv;
  wire [7:0]  DIG4_VShift;
  wire [0:0]  DIG4_TRG_LVL;
  wire [2:0]  DIG4_TRG_MODE;
  
  wire [13:0] ASG_Signal;
  
  wire [13:0] ADC1_Signal;
  wire [13:0] ADC2_Signal;
  
  wire [9:0]  VALUE_Q;
  
  wire [7:0]  DISP_VMRK1,
              DISP_VMRK2,
              DISP_HMRK1,
              DISP_HMRK2;
              
  wire [1:0]  INPUT_SELECT;
  
  wire [8:0]  ADC1_RDO_Add;
  wire        ADC1_RDO_Req,
              ADC1_RDO_Done;
  wire        ADC1_RDO_Ack;
  wire [13:0] ADC1_RDO_Q;
  wire [0:0]  ADC1_TDiv;
  wire [1:0]  ADC1_VDiv;
  wire [7:0]  ADC1_VShift;
  wire [2:0]  ADC1_TRG_MODE;
  wire [13:0] ADC1_TRG_LVL;
  
  wire [8:0]  ADC2_RDO_Add;
  wire        ADC2_RDO_Req,
              ADC2_RDO_Done;
  wire        ADC2_RDO_Ack;
  wire [13:0] ADC2_RDO_Q;
  wire [0:0]  ADC2_TDiv;
  wire [1:0]  ADC2_VDiv;
  wire [7:0]  ADC2_VShift;
  wire [2:0]  ADC2_TRG_MODE;
  wire [13:0] ADC2_TRG_LVL;
  
  wire [7:0]  VGADRV_X,
              VGADRV_Y;
  wire        VGADRV_WR;
  wire [11:0] VGADRV_RGB;
  
  // BCD2SSD 0
  wire [6:0] SSDOut0;
  BCD2SSD BCD2SSD_inst0  (
    .SSDOut ( SSDOut0 ),
    .BCDIn  ( VALUE_Q[3:0] ));
  assign HEX0_D = ~SSDOut0;
    
  // BCD2SSD 1
  wire [6:0] SSDOut1;
  BCD2SSD BCD2SSD_inst1 (
    .SSDOut ( SSDOut1 ),
    .BCDIn  ( VALUE_Q[7:4] ));
  assign HEX1_D = ~SSDOut1;
    
  // BCD2SSD 2
  wire [6:0] SSDOut2;
  BCD2SSD BCD2SSD_inst2 (
    .SSDOut ( SSDOut2 ),
    .BCDIn  ( { 2'b0, VALUE_Q[9:8] } ));
  assign HEX2_D = ~SSDOut2;
    
  // BCD2SSD 3
  wire [6:0] SSDOut3;
  BCD2SSD BCD2SSD_inst3 (
    .SSDOut ( SSDOut3 ),
    .BCDIn  ( { 4'b0 } ));
  assign HEX3_D = ~SSDOut3;
    
  // BCD2SSD 4
  wire [6:0] SSDOut4;
  BCD2SSD BCD2SSD_inst4 (
    .SSDOut ( SSDOut4 ),
    .BCDIn  ( SW[14:10] ));
  assign HEX4_D = ~SSDOut4;
    
  // BCD2SSD 5
  wire [6:0] SSDOut5;
  BCD2SSD BCD2SSD_inst5 (
    .SSDOut ( SSDOut5 ),
    .BCDIn  ( { 1'b0, SW[16:14] } ));
  assign HEX5_D = ~SSDOut5;

  // VIDEO PLL
  VIDEO_PLL VIDEO_PLL_inst (
    .inclk0 ( CLOCK_50 ),
    .c0     ( CLOCK_25 ),
    .c1     ( VGA_CLK  ),
    .c2     ( CLOCK_10 ));
    
  // UIController
  UIController UIController_inst (
    .Clock            ( CLOCK_10         ),
    .Reset_n          ( Reset_n          ),
                      
    // Command        
    .REG              ( SW[16:10]        ),
    .VALUE_D          ( SW[9:0]          ),
    .VALUE_Q          ( VALUE_Q          ),
    .SET              ( ~KEY[3]          ),
    .CLR              ( ~KEY[2]          ),
    .INC              ( ~KEY[1]          ),
    .DEC              ( ~KEY[0]          ),
                                         
    // Display                           
    .DISP_VMRK1       ( DISP_VMRK1       ),
    .DISP_VMRK2       ( DISP_VMRK2       ),
    .DISP_HMRK1       ( DISP_HMRK1       ),
    .DISP_HMRK2       ( DISP_HMRK2       ),
                                         
    .INPUT_SELECT     ( INPUT_SELECT     ),
                                         
    // ADC1                              
    .ADC1_TDIV        ( ADC1_TDiv        ),
    .ADC1_VDIV        ( ADC1_VDiv        ),
    .ADC1_VSHIFT      ( ADC1_VShift      ),
    .ADC1_TRG_LVL     ( ADC1_TRG_LVL     ),
    .ADC1_TRG_MODE    ( ADC1_TRG_MODE    ),
                                         
    // ADC2                              
    .ADC2_TDIV        ( ADC2_TDiv        ),
    .ADC2_VDIV        ( ADC2_VDiv        ),
    .ADC2_VSHIFT      ( ADC2_VShift      ),
    .ADC2_TRG_LVL     ( ADC2_TRG_LVL     ),
    .ADC2_TRG_MODE    ( ADC2_TRG_MODE    ),
    
    // DIG1
    .DIG1_TDIV        ( DIG1_TDiv        ),
    .DIG1_VSHIFT      ( DIG1_VShift      ),
    .DIG1_PAT         ( DIG1_Pattern     ),
    .DIG1_PDCC        ( DIG1_PeriodDelay ),
    .DIG1_CFG         ( DIG1_Configure   ),
    .DIG1_TRG_LVL     ( DIG1_TRG_LVL     ),
    .DIG1_TRG_MODE    ( DIG1_TRG_MODE    ),
    
    // DIG2
    .DIG2_TDIV        ( DIG2_TDiv        ),
    .DIG2_VSHIFT      ( DIG2_VShift      ),
    .DIG2_PAT         ( DIG2_Pattern     ),
    .DIG2_PDCC        ( DIG2_PeriodDelay ),
    .DIG2_CFG         ( DIG2_Configure   ),
    .DIG2_TRG_LVL     ( DIG2_TRG_LVL     ),
    .DIG2_TRG_MODE    ( DIG2_TRG_MODE    ),
    
    // DIG3
    .DIG3_TDIV        ( DIG3_TDiv        ),
    .DIG3_VSHIFT      ( DIG3_VShift      ),
    .DIG3_PAT         ( DIG3_Pattern     ),
    .DIG3_PDCC        ( DIG3_PeriodDelay ),
    .DIG3_CFG         ( DIG3_Configure   ),
    .DIG3_TRG_LVL     ( DIG3_TRG_LVL     ),
    .DIG3_TRG_MODE    ( DIG3_TRG_MODE    ),
    
    // DIG4
    .DIG4_TDIV        ( DIG4_TDiv        ),
    .DIG4_VSHIFT      ( DIG4_VShift      ),
    .DIG4_PAT         ( DIG4_Pattern     ),
    .DIG4_PDCC        ( DIG4_PeriodDelay ),
    .DIG4_CFG         ( DIG4_Configure   ),
    .DIG4_TRG_LVL     ( DIG4_TRG_LVL     ),
    .DIG4_TRG_MODE    ( DIG4_TRG_MODE    ));
    
  // Digital Signal Generator 1 ( Square Pulse )
  DSGEN DSGEN1_inst (
    .Clock       ( CLOCK_10         ),
    .Reset_n     ( Reset_n          ),
    .Configure   ( DIG1_Configure   ),
    .Pattern     ( DIG1_Pattern     ),
    .PeriodDelay ( DIG1_PeriodDelay ),
    .SignalOut   ( DIG1_Signal      ));
    
  // Digital Signal Generator 2 ( Square Pulse )
  DSGEN DSGEN2_inst (
    .Clock       ( CLOCK_10         ),
    .Reset_n     ( Reset_n          ),
    .Configure   ( DIG2_Configure   ),
    .Pattern     ( DIG2_Pattern     ),
    .PeriodDelay ( DIG2_PeriodDelay ),
    .SignalOut   ( DIG2_Signal      ));
    
  // Digital Signal Generator 3 ( Square Pulse )
  DSGEN DSGEN3_inst (
    .Clock       ( CLOCK_10         ),
    .Reset_n     ( Reset_n          ),
    .Configure   ( DIG3_Configure   ),
    .Pattern     ( DIG3_Pattern     ),
    .PeriodDelay ( DIG3_PeriodDelay ),
    .SignalOut   ( DIG3_Signal      ));
    
  // Digital Signal Generator 4 ( Square Pulse )
  DSGEN DSGEN4_inst (
    .Clock       ( CLOCK_10         ),
    .Reset_n     ( Reset_n          ),
    .Configure   ( DIG4_Configure   ),
    .Pattern     ( DIG4_Pattern     ),
    .PeriodDelay ( DIG4_PeriodDelay ),
    .SignalOut   ( DIG4_Signal      ));
    
  defparam DIG1_SCDAQ_inst.NSAMPLES = 512;
  defparam DIG1_SCDAQ_inst.PRECISION = 1;
  defparam DIG1_SCDAQ_inst.RDO_ADD_BLEN = 9;
  SCDAQ DIG1_SCDAQ_inst (
    .Reset_n   ( Reset_n       ),
    .DAQ_Clock ( CLOCK_10      ),
    .DAQ_D     ( DIG1_Signal   ),
    .TRG_MODE  ( DIG1_TRG_MODE ),
    .TRG_LVL   ( DIG1_TRG_LVL  ),
    .RDO_Clock ( CLOCK_25      ),
    .RDO_Add   ( DIG1_RDO_Add  ),
    .RDO_Req   ( DIG1_RDO_Req  ),
    .RDO_Ack   ( DIG1_RDO_Ack  ),
    .RDO_Q     ( DIG1_RDO_Q    ),
    .RDO_Done  ( DIG1_RDO_Done ));
  
  defparam DIG2_SCDAQ_inst.NSAMPLES = 512;
  defparam DIG2_SCDAQ_inst.PRECISION = 1;
  defparam DIG2_SCDAQ_inst.RDO_ADD_BLEN = 9;
  SCDAQ DIG2_SCDAQ_inst (
    .Reset_n   ( Reset_n       ),
    .DAQ_Clock ( CLOCK_10      ),
    .DAQ_D     ( DIG2_Signal   ),
    .TRG_MODE  ( DIG2_TRG_MODE ),
    .TRG_LVL   ( DIG2_TRG_LVL  ),
    .RDO_Clock ( CLOCK_25      ),
    .RDO_Add   ( DIG2_RDO_Add  ),
    .RDO_Req   ( DIG2_RDO_Req  ),
    .RDO_Ack   ( DIG2_RDO_Ack  ),
    .RDO_Q     ( DIG2_RDO_Q    ),
    .RDO_Done  ( DIG2_RDO_Done ));
    
  defparam DIG3_SCDAQ_inst.NSAMPLES = 512;
  defparam DIG3_SCDAQ_inst.PRECISION = 1;
  defparam DIG3_SCDAQ_inst.RDO_ADD_BLEN = 9;
  SCDAQ DIG3_SCDAQ_inst (
    .Reset_n   ( Reset_n       ),
    .DAQ_Clock ( CLOCK_10      ),
    .DAQ_D     ( DIG3_Signal   ),
    .TRG_MODE  ( DIG3_TRG_MODE ),
    .TRG_LVL   ( DIG3_TRG_LVL  ),
    .RDO_Clock ( CLOCK_25      ),
    .RDO_Add   ( DIG3_RDO_Add  ),
    .RDO_Req   ( DIG3_RDO_Req  ),
    .RDO_Ack   ( DIG3_RDO_Ack  ),
    .RDO_Q     ( DIG3_RDO_Q    ),
    .RDO_Done  ( DIG3_RDO_Done ));
  
  defparam DIG4_SCDAQ_inst.NSAMPLES = 512;
  defparam DIG4_SCDAQ_inst.PRECISION = 1;
  defparam DIG4_SCDAQ_inst.RDO_ADD_BLEN = 9;
  SCDAQ DIG4_SCDAQ_inst (
    .Reset_n   ( Reset_n       ),
    .DAQ_Clock ( CLOCK_10      ),
    .DAQ_D     ( DIG4_Signal   ),
    .TRG_MODE  ( DIG4_TRG_MODE ),
    .TRG_LVL   ( DIG4_TRG_LVL  ),
    .RDO_Clock ( CLOCK_25      ),
    .RDO_Add   ( DIG4_RDO_Add  ),
    .RDO_Req   ( DIG4_RDO_Req  ),
    .RDO_Ack   ( DIG4_RDO_Ack  ),
    .RDO_Q     ( DIG4_RDO_Q    ),
    .RDO_Done  ( DIG4_RDO_Done ));
  
  // Analog Signal Generator ( Square Wave )
  ASGEN ASGEN_inst (
    .Clock     ( CLOCK_10   ),
    .Reset_n   ( Reset_n    ),
    .SignalOut ( ASG_Signal ));

  // ADC
  ADC ADC_inst (
    .ADC_CLK     ( CLOCK_50    ),  //Internal ADC clock
    .ADC_CLKA    ( ADC_CLKA    ),  //Output to GPIO
    .ADC_CLKB    ( ADC_CLKB    ),  //Output to GPIO

    .ADC_DA      ( ADC_DA      ),  //Input from GPIO
    .ADC_OTRA    ( ADC_OTRA    ),  //Input from GPIO
    .ADC_OEA     ( ADC_OEA     ),  //Output to GPIO
      
    .ADC_DB      ( ADC_DB      ),  //Input from GPIO
    .ADC_OTRB    ( ADC_OTRB    ),  //Input from GPIO
    .ADC_OEB     ( ADC_OEB     ),  //Output to GPIO
  
    .ADC_PWDN_AB ( ADC_PWDN_AB ),  //Output to GPIO
  
    .ADC_DATA_A  ( ADC2_Signal ),  //Internal ADC data
    .ADC_DATA_B  ( ADC1_Signal )); //Internal ADC data
    
  // DAC
  DAC DAC_inst (
    .DAC_CLK    ( CLOCK_50    ),  //Internal DAC clock
    .DAC_CLKA   ( DAC_CLKA    ),  //Output to GPIO
    .DAC_CLKB   ( DAC_CLKB    ),  //Output to GPIO 

    .DAC_DA     ( DAC_DA      ),  //Output to GPIO
    .DAC_WRTA   ( DAC_WRTA    ),  //Output to GPIO
    
    .DAC_DB     ( DAC_DB      ),  //Output to GPIO        
    .DAC_WRTB   ( DAC_WRTB    ),  //Output to GPIO
    
    .DAC_MODE   ( DAC_MODE    ),  //Output to GPIO
        
    .DAC_DATA_A ( ASG_Signal  ),  //Internal DAC data
    .DAC_DATA_B ( ADC1_Signal )); //Internal DAC data
  
  defparam ADC1_SCDAQ_inst.NSAMPLES = 512;
  defparam ADC1_SCDAQ_inst.PRECISION = 14;
  defparam ADC1_SCDAQ_inst.RDO_ADD_BLEN = 9;
  SCDAQ ADC1_SCDAQ_inst (
    .Reset_n   ( Reset_n       ),
    .DAQ_Clock ( CLOCK_50      ),
    .DAQ_D     ( ADC1_Signal   ),
    .TRG_MODE  ( ADC1_TRG_MODE ),
    .TRG_LVL   ( ADC1_TRG_LVL  ),
    .RDO_Clock ( CLOCK_25      ),
    .RDO_Add   ( ADC1_RDO_Add  ),
    .RDO_Req   ( ADC1_RDO_Req  ),
    .RDO_Ack   ( ADC1_RDO_Ack  ),
    .RDO_Q     ( ADC1_RDO_Q    ),
    .RDO_Done  ( ADC1_RDO_Done ));
    
  defparam ADC2_SCDAQ_inst.NSAMPLES = 512;
  defparam ADC2_SCDAQ_inst.PRECISION = 14;
  defparam ADC2_SCDAQ_inst.RDO_ADD_BLEN = 9;
  SCDAQ ADC2_SCDAQ_inst (
    .Reset_n   ( Reset_n       ),
    .DAQ_Clock ( CLOCK_50      ),
    .DAQ_D     ( ADC2_Signal   ),
    .TRG_MODE  ( ADC2_TRG_MODE ),
    .TRG_LVL   ( ADC2_TRG_LVL  ),
    .RDO_Clock ( CLOCK_25      ),
    .RDO_Add   ( ADC2_RDO_Add  ),
    .RDO_Req   ( ADC2_RDO_Req  ),
    .RDO_Ack   ( ADC2_RDO_Ack  ),
    .RDO_Q     ( ADC2_RDO_Q    ),
    .RDO_Done  ( ADC2_RDO_Done ));
  
  // Plot Signal
  PlotSignal PlotSignal_inst (
    .Clock         ( CLOCK_25      ),
    .Reset_n       ( Reset_n       ),
    .X             ( VGADRV_X      ), 
    .Y             ( VGADRV_Y      ),
    .WR            ( VGADRV_WR     ),
    .RGB           ( VGADRV_RGB    ),
    .DISP_VMRK1    ( DISP_VMRK1    ),
    .DISP_VMRK2    ( DISP_VMRK2    ),
    .DISP_HMRK1    ( DISP_HMRK1    ),
    .DISP_HMRK2    ( DISP_HMRK2    ),
    .INPUT_SELECT  ( INPUT_SELECT  ),
    .ADC1_RDO_Add  ( ADC1_RDO_Add  ),
    .ADC1_RDO_Req  ( ADC1_RDO_Req  ),
    .ADC1_RDO_Ack  ( ADC1_RDO_Ack  ),
    .ADC1_RDO_Q    ( ADC1_RDO_Q    ),
    .ADC1_RDO_Done ( ADC1_RDO_Done ),
    .ADC1_TDiv     ( ADC1_TDiv     ),
    .ADC1_VDiv     ( ADC1_VDiv     ),
    .ADC1_VShift   ( ADC1_VShift   ),
    .ADC1_TRG_LVL  ( ADC1_TRG_LVL  ),
    .ADC2_RDO_Add  ( ADC2_RDO_Add  ),
    .ADC2_RDO_Req  ( ADC2_RDO_Req  ),
    .ADC2_RDO_Ack  ( ADC2_RDO_Ack  ),
    .ADC2_RDO_Q    ( ADC2_RDO_Q    ),
    .ADC2_RDO_Done ( ADC2_RDO_Done ),
    .ADC2_TDiv     ( ADC2_TDiv     ),
    .ADC2_VDiv     ( ADC2_VDiv     ),
    .ADC2_VShift   ( ADC2_VShift   ),
    .ADC2_TRG_LVL  ( ADC2_TRG_LVL  ),
    .DIG1_RDO_Add  ( DIG1_RDO_Add  ),
    .DIG1_RDO_Req  ( DIG1_RDO_Req  ),
    .DIG1_RDO_Ack  ( DIG1_RDO_Ack  ),
    .DIG1_RDO_Q    ( DIG1_RDO_Q    ),
    .DIG1_RDO_Done ( DIG1_RDO_Done ),
    .DIG1_TDiv     ( DIG1_TDiv     ),
    .DIG1_VShift   ( DIG1_VShift   ),
    .DIG2_RDO_Add  ( DIG2_RDO_Add  ),
    .DIG2_RDO_Req  ( DIG2_RDO_Req  ),
    .DIG2_RDO_Ack  ( DIG2_RDO_Ack  ),
    .DIG2_RDO_Q    ( DIG2_RDO_Q    ),
    .DIG2_RDO_Done ( DIG2_RDO_Done ),
    .DIG2_TDiv     ( DIG2_TDiv     ),
    .DIG2_VShift   ( DIG2_VShift   ),
    .DIG3_RDO_Add  ( DIG3_RDO_Add  ),
    .DIG3_RDO_Req  ( DIG3_RDO_Req  ),
    .DIG3_RDO_Ack  ( DIG3_RDO_Ack  ),
    .DIG3_RDO_Q    ( DIG3_RDO_Q    ),
    .DIG3_RDO_Done ( DIG3_RDO_Done ),
    .DIG3_TDiv     ( DIG3_TDiv     ),
    .DIG3_VShift   ( DIG3_VShift   ),
    .DIG4_RDO_Add  ( DIG4_RDO_Add  ),
    .DIG4_RDO_Req  ( DIG4_RDO_Req  ),
    .DIG4_RDO_Ack  ( DIG4_RDO_Ack  ),
    .DIG4_RDO_Q    ( DIG4_RDO_Q    ),
    .DIG4_RDO_Done ( DIG4_RDO_Done ),
    .DIG4_TDiv     ( DIG4_TDiv     ),
    .DIG4_VShift   ( DIG4_VShift   ));
  
  // VGA Driver
  VGA_LCD_Driver VGA_LCD_Driver_inst ( 
    .CLOCK_25  ( CLOCK_25   ),  // 25 MHz 
    .RESET_N   ( Reset_n    ),  // Reset_N
    .X         ( VGADRV_X   ),  // X Pixel
    .Y         ( VGADRV_Y   ),  // Y Pixel
    .WR        ( VGADRV_WR  ),  // Write Enable
    .RGB       ( VGADRV_RGB ),  // Colour
    .VGA_HSYNC ( VGA_HS     ),  // VGA H_SYNC
    .VGA_VSYNC ( VGA_VS     ),  // VGA V_SYNC
    .VGA_BLANK ( VGA_BLANK  ),  // VGA BLANK
    .VGA_SYNC  ( VGA_SYNC   ),  // VGA SYNC
    .VGA_R     ( VGA_R      ),  // VGA Red[9:0]
    .VGA_G     ( VGA_G      ),  // VGA Green[9:0]
    .VGA_B     ( VGA_B      )); // VGA Blue[9:0]

endmodule
