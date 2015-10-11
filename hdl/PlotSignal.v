//% @file PlotSignal.v
//% @author Petros Fountas, Apurva Modak
//% @brief Plots a signal on the display

module PlotSignal (
  input  wire Clock,
  input  wire Reset_n,
  output wire [7:0]  X,
  output wire [7:0]  Y,
  output reg         WR,
  output reg  [11:0] RGB,
  
  // Markers
  input  wire [8:0]  DISP_VMRK1,
  input  wire [8:0]  DISP_VMRK2,
  input  wire [8:0]  DISP_HMRK1,
  input  wire [8:0]  DISP_HMRK2,
  
  // Input select
  input  wire [1:0]  INPUT_SELECT,
  
  // ADC Line 1
  // + Sample input
  output reg  [8:0]  ADC1_RDO_Add,    // Readout address
  output reg         ADC1_RDO_Req,    // Readout request
  input  wire        ADC1_RDO_Ack,    // Readout acknowledgement
  input  wire [13:0] ADC1_RDO_Q,      // Readout data bus
  output reg         ADC1_RDO_Done,   // Readout done
  // + Time/Div & Volt/Div controls
  input  wire [0:0]  ADC1_TDiv,       // Time/Div
  input  wire [1:0]  ADC1_VDiv,       // Volt/Div
  input  wire [7:0]  ADC1_VShift,     // Verticle shift
  input  wire [13:0] ADC1_TRG_LVL,    // Trigger level
  
  // ADC Line 2
  // + Sample input
  output reg  [8:0]  ADC2_RDO_Add,    // Readout address
  output reg         ADC2_RDO_Req,    // Readout request
  input  wire        ADC2_RDO_Ack,    // Readout acknowledgement
  input  wire [13:0] ADC2_RDO_Q,      // Readout data bus
  output reg         ADC2_RDO_Done,   // Readout done
  // + Time/Div & Volt/Div controls
  input  wire [0:0]  ADC2_TDiv,       // Time/Div
  input  wire [1:0]  ADC2_VDiv,       // Volt/Div
  input  wire [7:0]  ADC2_VShift,     // Verticle shift
  input  wire [13:0] ADC2_TRG_LVL,    // Trigger level
  
  // Digital Line 1
  // + Sample input
  output reg  [8:0]  DIG1_RDO_Add,    // Readout address
  output reg         DIG1_RDO_Req,    // Readout request
  input  wire        DIG1_RDO_Ack,    // Readout acknowledgement
  input  wire [0:0]  DIG1_RDO_Q,      // Readout data bus
  output reg         DIG1_RDO_Done,   // Readout done
  // + Time/Div & Volt/Div controls
  input  wire [0:0]  DIG1_TDiv,       // Time/Div
  input  wire [7:0]  DIG1_VShift,     // Verticle shift
  
  // Digital Line 2
  // + Sample input
  output reg  [8:0]  DIG2_RDO_Add,    // Readout address
  output reg         DIG2_RDO_Req,    // Readout request
  input  wire        DIG2_RDO_Ack,    // Readout acknowledgement
  input  wire [0:0]  DIG2_RDO_Q,      // Readout data bus
  output reg         DIG2_RDO_Done,   // Readout done
  // + Time/Div & Volt/Div controls
  input  wire [0:0]  DIG2_TDiv,       // Time/Div
  input  wire [7:0]  DIG2_VShift,     // Verticle shift
  
  // Digital Line 3
  // + Sample input
  output reg  [8:0]  DIG3_RDO_Add,    // Readout address
  output reg         DIG3_RDO_Req,    // Readout request
  input  wire        DIG3_RDO_Ack,    // Readout acknowledgement
  input  wire [0:0]  DIG3_RDO_Q,      // Readout data bus
  output reg         DIG3_RDO_Done,   // Readout done
  // + Time/Div & Volt/Div controls
  input  wire [0:0]  DIG3_TDiv,       // Time/Div
  input  wire [7:0]  DIG3_VShift,     // Verticle shift
  
  // Digital Line 4
  // + Sample input
  output reg  [8:0]  DIG4_RDO_Add,    // Readout address
  output reg         DIG4_RDO_Req,    // Readout request
  input  wire        DIG4_RDO_Ack,    // Readout acknowledgement
  input  wire [0:0]  DIG4_RDO_Q,      // Readout data bus
  output reg         DIG4_RDO_Done,   // Readout done
  // + Time/Div & Volt/Div controls
  input  wire [0:0]  DIG4_TDiv,       // Time/Div
  input  wire [7:0]  DIG4_VShift      // Verticle shift
);

  parameter COLOR_BLACK   = 12'b0000_0000_0000; // 0x0F0F0F
  parameter COLOR_RED     = 12'b0000_0000_1111; // 0x0000FF
  parameter COLOR_GREEN   = 12'b0000_1111_0000; // 0x00FF00
  parameter COLOR_YELLOW  = 12'b0000_1111_1111; // 0x00FFFF
  parameter COLOR_BLUE    = 12'b1111_0000_0000; // 0xFF0000
  parameter COLOR_FUCHSIA = 12'b1111_0000_1111; // 0xFF00FF
  parameter COLOR_AQUA    = 12'b1111_1111_0000; // 0xFFFF00
  parameter COLOR_WHITE   = 12'b1111_1111_1111; // 0xFFFFFF

  parameter DISP_NCOL   = 160;
  parameter DISP_NROW   = 120;
  parameter GRID_SIDE   = 30;
  parameter GRID_COLOR  = COLOR_GREEN;
  parameter DSIG1_COLOR = COLOR_RED;
  parameter DSIG2_COLOR = COLOR_BLUE;
  parameter DSIG3_COLOR = COLOR_WHITE;
  parameter DSIG4_COLOR = COLOR_FUCHSIA;
  parameter ASIG1_COLOR = COLOR_RED;
  parameter ASIG2_COLOR = COLOR_BLUE;
  parameter TRG_COLOR   = COLOR_YELLOW;
  parameter MRK_COLOR   = COLOR_AQUA;
  
  parameter TDIV2 = 20;
  parameter TDIV3 = 50;
  parameter TDIV4 = 80;
  parameter TDIV5 = 110;
  parameter TDIV6 = 140;
  parameter ASCL2 = 1*GRID_SIDE;
  parameter ASCL3 = 2*GRID_SIDE;
  parameter ASCL4 = 3*GRID_SIDE;
  
  reg [8:0] ADC1_Sample;
  reg [8:0] ADC1_TRG_LVL_Cal;
  
  // ADC line 1 Volt/Div
  always @ (ADC1_RDO_Q, ADC1_VDiv, ADC1_VShift, ADC1_TRG_LVL) begin
    ADC1_Sample <= 'b0;
    ADC1_TRG_LVL_Cal <= 'b0;
    if (ADC1_RDO_Q > 'b0)
      case (ADC1_VDiv)
        // 1st Volt/Div
        0 : begin
          ADC1_Sample
            <= 120 - { 1'b0, ADC1_RDO_Q[13:6] }
             + 37 + ADC1_VShift - 120;
          ADC1_TRG_LVL_Cal
            <= 120 - { 1'b0, ADC1_TRG_LVL[13:6] }
             + 50 + ADC1_VShift - 120;
        end
        // 2nd Volt/Div
        1 : begin
          ADC1_Sample
            <= 120 - { 2'b0, ADC1_RDO_Q[13:7] }
             - 27 + ADC1_VShift - 120;
          ADC1_TRG_LVL_Cal
            <= 120 - { 2'b0, ADC1_TRG_LVL[13:7] }
             - 20 + ADC1_VShift - 120;
        end
        // 3rd Volt/Div
        2 : begin
          ADC1_Sample
            <= 120 - { 3'b0, ADC1_RDO_Q[13:8] }
             - 59 + ADC1_VShift - 120;
          ADC1_TRG_LVL_Cal
            <= 120 - { 3'b0, ADC1_TRG_LVL[13:8] }
             - 55 + ADC1_VShift - 120;
        end
        // 4th Volt/Div
        3 : begin
          ADC1_Sample
            <= 120 - { 4'b0, ADC1_RDO_Q[13:9] }
             - 75 + ADC1_VShift - 120;
          ADC1_TRG_LVL_Cal
            <= 120 - { 4'b0, ADC1_TRG_LVL[13:9] }
             - 73 + ADC1_VShift - 120;
        end
      endcase
  end
  
  reg [8:0] ADC2_Sample;
  reg [8:0] ADC2_TRG_LVL_Cal;
  
  // ADC line 2 Volt/Div
  always @ (ADC2_RDO_Q, ADC2_VDiv, ADC2_VShift, ADC2_TRG_LVL) begin
    ADC2_Sample <= 'b0;
    ADC2_TRG_LVL_Cal <= 'b0;
    if (ADC2_RDO_Q > 'b0)
      case (ADC2_VDiv)
        // 1st Volt/Div
        0 : begin
          ADC2_Sample
            <= 120 - { 1'b0, ADC2_RDO_Q[13:6] }
             + 98 + ADC2_VShift - 120;
          ADC2_TRG_LVL_Cal
            <= 120 - { 1'b0, ADC2_TRG_LVL[13:6] }
             + 111 + ADC2_VShift - 120;
        end
        // 2nd Volt/Div
        1 : begin
          ADC2_Sample
            <= 120 - { 2'b0, ADC2_RDO_Q[13:7] }
             + 34 + ADC2_VShift - 120;
          ADC2_TRG_LVL_Cal
            <= 120 - { 2'b0, ADC2_TRG_LVL[13:7] }
             + 40 + ADC2_VShift - 120;
        end
        // 3rd Volt/Div
        2 : begin
          ADC2_Sample
            <= 120 - { 3'b0, ADC2_RDO_Q[13:8] }
             + 2 + ADC2_VShift - 120;
          ADC2_TRG_LVL_Cal
            <= 120 - { 3'b0, ADC2_TRG_LVL[13:8] }
             + 5 + ADC2_VShift - 120;
        end
        // 4th Volt/Div
        3 : begin
          ADC2_Sample
            <= 120 - { 4'b0, ADC2_RDO_Q[13:9] }
             - 14 + ADC2_VShift - 120;
          ADC2_TRG_LVL_Cal
            <= 120 - { 4'b0, ADC2_TRG_LVL[13:9] }
             - 13 + ADC2_VShift - 120;
        end
      endcase
  end
  
  //        --------------------------
  //        X           | Y
  //        --------------------------
  reg [7:0] ColCounter_q, RowCounter_q;
  reg [7:0] ColCounter_d, RowCounter_d;

  assign X = ColCounter_q,
         Y = RowCounter_q;
         

  (* syn_encoding = "user, safe" *) reg [2:0] State_q, State_d;
  parameter DRAW_ASIG_STATE = 3'b001,
            DRAW_DSIG_STATE = 3'b010,
            DRAW_MSIG_STATE = 3'b100;
            
  always @ (State_q, ColCounter_q, RowCounter_q,
  
  //        Input select (Analog\Digital)
            INPUT_SELECT,
            
  //        Markers
            DISP_VMRK1, DISP_VMRK2, DISP_HMRK1, DISP_HMRK2,
            
  //        DIG 1          | DIG 2         
            DIG1_RDO_Q,      DIG2_RDO_Q,    
            DIG1_TDiv,       DIG2_TDiv,   
            DIG1_VShift,     DIG2_VShift, 
            DIG1_RDO_Ack,    DIG2_RDO_Ack,
  
  //        DIG 3          | DIG 4         
            DIG3_RDO_Q,      DIG4_RDO_Q,    
            DIG3_TDiv,       DIG4_TDiv,   
            DIG3_VShift,     DIG4_VShift, 
            DIG3_RDO_Ack,    DIG4_RDO_Ack,
  
  //        ADC 1           | ADC 2
  //        -----------------------------------
            ADC1_Sample,      ADC2_Sample,
            ADC1_TDiv,        ADC2_TDiv,
            ADC1_VShift,      ADC2_VShift,
            ADC1_RDO_Ack,     ADC2_RDO_Ack,
            ADC1_TRG_LVL_Cal, ADC2_TRG_LVL_Cal ) begin
    
    // Column-wise scanning
    ColCounter_d <= ColCounter_q;
    // Row counter
    RowCounter_d <= RowCounter_q + 1;
    if ( RowCounter_q == DISP_NROW ) begin 
      RowCounter_d <= 'b0;
      // Column counter
      ColCounter_d <= ColCounter_q + 1;
      if ( ColCounter_q == DISP_NCOL-1 )
        ColCounter_d <= 'b0;
    end
    
    WR <= 1'b1;
    RGB <= COLOR_BLACK;
    DIG1_RDO_Req  <= 1'b0;
    DIG1_RDO_Add  <= 1'b0;
    DIG1_RDO_Done <= 1'b0;
    DIG2_RDO_Req  <= 1'b0;
    DIG2_RDO_Add  <= 1'b0;
    DIG2_RDO_Done <= 1'b0;
    DIG3_RDO_Req  <= 1'b0;
    DIG3_RDO_Add  <= 1'b0;
    DIG3_RDO_Done <= 1'b0;
    DIG4_RDO_Req  <= 1'b0;
    DIG4_RDO_Add  <= 1'b0;
    DIG4_RDO_Done <= 1'b0;
    ADC1_RDO_Req  <= 1'b0;
    ADC1_RDO_Add  <= 1'b0;
    ADC1_RDO_Done <= 1'b0;
    ADC2_RDO_Req  <= 1'b0;
    ADC2_RDO_Add  <= 1'b0;
    ADC2_RDO_Done <= 1'b0;
    State_d <= State_q;
    case (State_q)
      
      DRAW_ASIG_STATE : begin
      
        // GRID
        if ( ColCounter_q == TDIV2  
          || ColCounter_q == TDIV3  
          || ColCounter_q == TDIV4 
          || ColCounter_q == TDIV5
          || ColCounter_q == TDIV6
          || RowCounter_q == ASCL2
          || RowCounter_q == ASCL3
          || RowCounter_q == ASCL4 )
          RGB <= GRID_COLOR;
          
        // ADC 1 line
        ADC1_RDO_Req <= 1'b1;
        ADC1_RDO_Add <= ColCounter_q;
        if ( ADC1_TDiv == 1'b1 )
          ADC1_RDO_Add <= { ColCounter_q[6:0], 1'b1 };
        if ( ADC1_RDO_Ack == 1'b1
          && {1'b0,RowCounter_q} == ADC1_Sample )
            RGB <= ASIG1_COLOR;
            
        // ADC 2 line
        ADC2_RDO_Req <= 1'b1;
        ADC2_RDO_Add <= ColCounter_q;
        if ( ADC2_TDiv == 1'b1 )
          ADC2_RDO_Add <= { ColCounter_q[6:0], 1'b1 };
        if ( ADC2_RDO_Ack == 1'b1
          && {1'b0,RowCounter_q} == ADC2_Sample )
            RGB <= ASIG2_COLOR;
            
        // Markers
        if ( ( ColCounter_q + 1 ) == DISP_VMRK1
          || ( ColCounter_q + 1 ) == DISP_VMRK2
          || ( RowCounter_q ) == 121 - DISP_HMRK1
          || ( RowCounter_q ) == 121 - DISP_HMRK2 )
          RGB <= MRK_COLOR;
        
        // Triggers
        if ( ( ColCounter_q == 0 || ColCounter_q == 1 )
          && ( RowCounter_q == ( ADC1_TRG_LVL_Cal )
            || RowCounter_q == ( ADC2_TRG_LVL_Cal ) ) )
            RGB <= TRG_COLOR;
             
        if ( RowCounter_q == DISP_NROW
          || ColCounter_q == DISP_NCOL-1 ) begin
          ADC1_RDO_Done <= 1'b1;
          ADC2_RDO_Done <= 1'b1;
          if ( INPUT_SELECT == 1 )
            State_d <= DRAW_DSIG_STATE;
          if ( INPUT_SELECT == 2 )
            State_d <= DRAW_MSIG_STATE;
        end
      end
      
      DRAW_DSIG_STATE : begin
      
        // GRID
        if ( ColCounter_q == TDIV2  
          || ColCounter_q == TDIV3  
          || ColCounter_q == TDIV4 
          || ColCounter_q == TDIV5
          || ColCounter_q == TDIV6
          || RowCounter_q == ASCL2
          || RowCounter_q == ASCL3
          || RowCounter_q == ASCL4 )
          RGB <= GRID_COLOR;
        
        // DIG 1 line
        DIG1_RDO_Req <= 1'b1;
        DIG1_RDO_Add <= ColCounter_q;
        if ( DIG1_TDiv == 1'b1 )
          DIG1_RDO_Add <= { ColCounter_q[6:0], 1'b1 };
        if ( DIG1_RDO_Ack == 1'b1 ) begin
          if ( DIG1_RDO_Q[0:0] == 1'b1
            && RowCounter_q == 10 + DIG1_VShift - 120 )
              RGB <= DSIG1_COLOR;
          if ( DIG1_RDO_Q[0:0] == 1'b0
            && RowCounter_q == 20 + DIG1_VShift - 120 )
              RGB <= DSIG1_COLOR;
        end
        
        // DIG 2 line
        DIG2_RDO_Req <= 1'b1;
        DIG2_RDO_Add <= ColCounter_q;
        if ( DIG2_TDiv == 1'b1 )
          DIG2_RDO_Add <= { ColCounter_q[6:0], 1'b1 };
        if ( DIG2_RDO_Ack == 1'b1 ) begin
          if ( DIG2_RDO_Q[0:0] == 1'b1
            && RowCounter_q == 40 + DIG2_VShift - 120 )
              RGB <= DSIG2_COLOR;
          if ( DIG2_RDO_Q[0:0] == 1'b0
            && RowCounter_q == 50 + DIG2_VShift - 120 )
              RGB <= DSIG2_COLOR;
        end
        
        // DIG 3 line
        DIG3_RDO_Req <= 1'b1;
        DIG3_RDO_Add <= ColCounter_q;
        if ( DIG3_TDiv == 1'b1 )
          DIG3_RDO_Add <= { ColCounter_q[6:0], 1'b1 };
        if ( DIG3_RDO_Ack == 1'b1 ) begin
          if ( DIG3_RDO_Q[0:0] == 1'b1
            && RowCounter_q == 70 + DIG3_VShift - 120 )
              RGB <= DSIG3_COLOR;
          if ( DIG3_RDO_Q[0:0] == 1'b0
            && RowCounter_q == 80 + DIG3_VShift - 120 )
              RGB <= DSIG3_COLOR;
        end
        
        // DIG 4 line
        DIG4_RDO_Req <= 1'b1;
        DIG4_RDO_Add <= ColCounter_q;
        if ( DIG4_TDiv == 1'b1 )
          DIG4_RDO_Add <= { ColCounter_q[6:0], 1'b1 };
        if ( DIG4_RDO_Ack == 1'b1 ) begin
          if ( DIG4_RDO_Q[0:0] == 1'b1
            && RowCounter_q == 100 + DIG4_VShift - 120 )
              RGB <= DSIG4_COLOR;
          if ( DIG4_RDO_Q[0:0] == 1'b0
            && RowCounter_q == 110 + DIG4_VShift - 120 )
              RGB <= DSIG4_COLOR;
        end
        
        // Markers
        if ( ( ColCounter_q + 1 ) == DISP_VMRK1
          || ( ColCounter_q + 1 ) == DISP_VMRK2
          || ( RowCounter_q ) == 121 - DISP_HMRK1
          || ( RowCounter_q ) == 121 - DISP_HMRK2 )
          RGB <= MRK_COLOR;
        
        if ( RowCounter_q == DISP_NROW
          || ColCounter_q == DISP_NCOL-1 ) begin
          DIG1_RDO_Done <= 1'b1;
          DIG2_RDO_Done <= 1'b1;
          DIG3_RDO_Done <= 1'b1;
          DIG4_RDO_Done <= 1'b1;
          if ( INPUT_SELECT == 0 )
            State_d <= DRAW_ASIG_STATE;
          if ( INPUT_SELECT == 2 )
            State_d <= DRAW_MSIG_STATE;
        end
        
      end
      
      DRAW_MSIG_STATE : begin
      
        // GRID
        if ( ColCounter_q == TDIV2  
          || ColCounter_q == TDIV3  
          || ColCounter_q == TDIV4 
          || ColCounter_q == TDIV5
          || ColCounter_q == TDIV6
          || RowCounter_q == ASCL2
          || RowCounter_q == ASCL3
          || RowCounter_q == ASCL4 )
          RGB <= GRID_COLOR;
          
        // ADC 1 line
        ADC1_RDO_Req <= 1'b1;
        ADC1_RDO_Add <= ColCounter_q;
        if ( ADC1_TDiv == 1'b1 )
          ADC1_RDO_Add <= { ColCounter_q[6:0], 1'b1 };
        if ( ADC1_RDO_Ack == 1'b1
          && {1'b0,RowCounter_q} == ADC1_Sample - 15 )
            RGB <= ASIG1_COLOR;
            
        // ADC 2 line
        ADC2_RDO_Req <= 1'b1;
        ADC2_RDO_Add <= ColCounter_q;
        if ( ADC2_TDiv == 1'b1 )
          ADC2_RDO_Add <= { ColCounter_q[6:0], 1'b1 };
        if ( ADC2_RDO_Ack == 1'b1
          && {1'b0,RowCounter_q} == ADC2_Sample - 45 )
            RGB <= ASIG2_COLOR;
        
        // DIG 1 line
        DIG1_RDO_Req <= 1'b1;
        DIG1_RDO_Add <= ColCounter_q;
        if ( DIG1_TDiv == 1'b1 )
          DIG1_RDO_Add <= { ColCounter_q[6:0], 1'b1 };
        if ( DIG1_RDO_Ack == 1'b1 ) begin
          if ( DIG1_RDO_Q[0:0] == 1'b1
            && RowCounter_q == 70 + DIG1_VShift - 120 )
              RGB <= DSIG1_COLOR;
          if ( DIG1_RDO_Q[0:0] == 1'b0
            && RowCounter_q == 75 + DIG1_VShift - 120 )
              RGB <= DSIG1_COLOR;
        end
        
        // DIG 2 line
        DIG2_RDO_Req <= 1'b1;
        DIG2_RDO_Add <= ColCounter_q;
        if ( DIG2_TDiv == 1'b1 )
          DIG2_RDO_Add <= { ColCounter_q[6:0], 1'b1 };
        if ( DIG2_RDO_Ack == 1'b1 ) begin
          if ( DIG2_RDO_Q[0:0] == 1'b1
            && RowCounter_q == 80 + DIG2_VShift - 120 )
              RGB <= DSIG2_COLOR;
          if ( DIG2_RDO_Q[0:0] == 1'b0
            && RowCounter_q == 85 + DIG2_VShift - 120 )
              RGB <= DSIG2_COLOR;
        end
        
        // DIG 3 line
        DIG3_RDO_Req <= 1'b1;
        DIG3_RDO_Add <= ColCounter_q;
        if ( DIG3_TDiv == 1'b1 )
          DIG3_RDO_Add <= { ColCounter_q[6:0], 1'b1 };
        if ( DIG3_RDO_Ack == 1'b1 ) begin
          if ( DIG3_RDO_Q[0:0] == 1'b1
            && RowCounter_q == 95 + DIG3_VShift - 120 )
              RGB <= DSIG3_COLOR;
          if ( DIG3_RDO_Q[0:0] == 1'b0
            && RowCounter_q == 100 + DIG3_VShift - 120 )
              RGB <= DSIG3_COLOR;
        end
        
        // DIG 4 line
        DIG4_RDO_Req <= 1'b1;
        DIG4_RDO_Add <= ColCounter_q;
        if ( DIG4_TDiv == 1'b1 )
          DIG4_RDO_Add <= { ColCounter_q[6:0], 1'b1 };
        if ( DIG4_RDO_Ack == 1'b1 ) begin
          if ( DIG4_RDO_Q[0:0] == 1'b1
            && RowCounter_q == 105 + DIG4_VShift - 120 )
              RGB <= DSIG4_COLOR;
          if ( DIG4_RDO_Q[0:0] == 1'b0
            && RowCounter_q == 110 + DIG4_VShift - 120 )
              RGB <= DSIG4_COLOR;
        end
        
        // Markers
        if ( ( ColCounter_q + 1 ) == DISP_VMRK1
          || ( ColCounter_q + 1 ) == DISP_VMRK2
          || ( RowCounter_q ) == 121 - DISP_HMRK1
          || ( RowCounter_q ) == 121 - DISP_HMRK2 )
          RGB <= MRK_COLOR;
          
        // Triggers
        if ( ( ColCounter_q == 0 || ColCounter_q == 1 )
          && ( RowCounter_q == ( ADC1_TRG_LVL_Cal - 15 )
            || RowCounter_q == ( ADC2_TRG_LVL_Cal - 45 ) ) )
            RGB <= TRG_COLOR;
        
        if ( RowCounter_q == DISP_NROW
          || ColCounter_q == DISP_NCOL-1 ) begin
          ADC1_RDO_Done <= 1'b1;
          ADC2_RDO_Done <= 1'b1;
          DIG1_RDO_Done <= 1'b1;
          DIG2_RDO_Done <= 1'b1;
          DIG3_RDO_Done <= 1'b1;
          DIG4_RDO_Done <= 1'b1;
          if ( INPUT_SELECT == 0 )
            State_d <= DRAW_ASIG_STATE;
          if ( INPUT_SELECT == 1 )
            State_d <= DRAW_DSIG_STATE;
        end
      
      end
      
    endcase
  end

  always @ (posedge Clock or negedge Reset_n) begin
    if ( Reset_n == 1'b0 ) begin
      State_q <= DRAW_ASIG_STATE;
      ColCounter_q <= 'b0;
      RowCounter_q <= 'b0;
    end
    else begin
      State_q <= State_d;
      ColCounter_q <= ColCounter_d;
      RowCounter_q <= RowCounter_d;
    end
  end

endmodule