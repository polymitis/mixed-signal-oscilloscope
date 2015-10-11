//% @file UIController.v
//% @author Petros Fountas, Apurva Modak
//% @brief User interface controller.

module UIController (
  input wire         Clock,
  input wire         Reset_n,
  
  // Command
  input  wire [6:0]  REG,
  input  wire [9:0]  VALUE_D,
  output reg  [9:0]  VALUE_Q,
  input  wire        SET,
  input  wire        CLR,
  input  wire        INC,
  input  wire        DEC,
  
  // Display
  output wire [8:0]  DISP_VMRK1,
  output wire [8:0]  DISP_VMRK2,
  output wire [8:0]  DISP_HMRK1,
  output wire [8:0]  DISP_HMRK2,
  
  output wire [1:0]  INPUT_SELECT,
  
  // ADC1
  output wire [0:0]  ADC1_TDIV,
  output wire [1:0]  ADC1_VDIV,
  output wire [7:0]  ADC1_VSHIFT,
  output wire [13:0] ADC1_TRG_LVL,
  output wire [2:0]  ADC1_TRG_MODE,
  
  // ADC2
  output wire [0:0]  ADC2_TDIV,
  output wire [1:0]  ADC2_VDIV,
  output wire [7:0]  ADC2_VSHIFT,
  output wire [13:0] ADC2_TRG_LVL,
  output wire [2:0]  ADC2_TRG_MODE,
  
  // DIG1
  output wire [0:0]  DIG1_TDIV,
  output wire [7:0]  DIG1_VSHIFT,
  output wire [9:0]  DIG1_PAT,
  output wire [9:0]  DIG1_PDCC,
  output reg         DIG1_CFG,
  output wire [0:0] DIG1_TRG_LVL,
  output wire [2:0]  DIG1_TRG_MODE,
  
  // DIG2
  output wire [0:0]  DIG2_TDIV,
  output wire [7:0]  DIG2_VSHIFT,
  output wire [9:0]  DIG2_PAT,
  output wire [9:0]  DIG2_PDCC,
  output reg         DIG2_CFG,
  output wire [0:0]  DIG2_TRG_LVL,
  output wire [2:0]  DIG2_TRG_MODE,
  
  // DIG3
  output wire [0:0]  DIG3_TDIV,
  output wire [7:0]  DIG3_VSHIFT,
  output wire [9:0]  DIG3_PAT,
  output wire [9:0]  DIG3_PDCC,
  output reg         DIG3_CFG,
  output wire [0:0]  DIG3_TRG_LVL,
  output wire [2:0]  DIG3_TRG_MODE,
  
  // DIG4
  output wire [0:0]  DIG4_TDIV,
  output wire [7:0]  DIG4_VSHIFT,
  output wire [9:0]  DIG4_PAT,
  output wire [9:0]  DIG4_PDCC,
  output reg         DIG4_CFG,
  output wire [0:0]  DIG4_TRG_LVL,
  output wire [2:0]  DIG4_TRG_MODE
  
);

  // Register Map
  //        Register                 | Address
  parameter NOREG             = 0,  // 0x00
                                    
            DISP_VMRK1_REG    = 1,  // 0x01
            DISP_VMRK2_REG    = 2,  // 0x02
            DISP_VMRK_DIFF    = 3,  // 0x03
            DISP_HMRK1_REG    = 4,  // 0x04
            DISP_HMRK2_REG    = 5,  // 0x05
            DISP_HMRK_DIFF    = 6,  // 0x06 
                                    
            INPUT_SELECT_REG  = 7,  // 0x07
            
            ADC1_TDIV_REG     = 8,  // 0x08
            ADC1_VDIV_REG     = 9,  // 0x09
            ADC1_VSHIFT_REG   = 10, // 0x0A
            ADC1_TRG_LVL_REG  = 11, // 0x0B
            ADC1_TRG_MODE_REG = 12, // 0x0C
                                    
            ADC2_TDIV_REG     = 13, // 0x0D
            ADC2_VDIV_REG     = 14, // 0x0E
            ADC2_VSHIFT_REG   = 15, // 0x0F
            ADC2_TRG_LVL_REG  = 16, // 0x10
            ADC2_TRG_MODE_REG = 17, // 0x11
                                    
            DIG1_TDIV_REG     = 18, // 0x12
            DIG1_VSHIFT_REG   = 19, // 0x13
            DIG1_PAT_REG      = 20, // 0x14
            DIG1_PDCC_REG     = 21, // 0x15
            DIG1_TRG_LVL_REG  = 22, // 0x16
            DIG1_TRG_MODE_REG = 23, // 0x17
                                    
            DIG2_TDIV_REG     = 24, // 0x18
            DIG2_VSHIFT_REG   = 25, // 0x19
            DIG2_PAT_REG      = 26, // 0x1A
            DIG2_PDCC_REG     = 27, // 0x1B
            DIG2_TRG_LVL_REG  = 28, // 0x1C
            DIG2_TRG_MODE_REG = 29, // 0x1D
                                    
            DIG3_TDIV_REG     = 30, // 0x1E
            DIG3_VSHIFT_REG   = 31, // 0x1F
            DIG3_PAT_REG      = 32, // 0x20
            DIG3_PDCC_REG     = 33, // 0x21
            DIG3_TRG_LVL_REG  = 34, // 0x22
            DIG3_TRG_MODE_REG = 35, // 0x23
                                    
            DIG4_TDIV_REG     = 36, // 0x24
            DIG4_VSHIFT_REG   = 37, // 0x25
            DIG4_PAT_REG      = 38, // 0x26
            DIG4_PDCC_REG     = 39, // 0x27
            DIG4_TRG_LVL_REG  = 40, // 0x28
            DIG4_TRG_MODE_REG = 41; // 0x29

  //        
  // Command pulse action controller
  //

  reg INC_q, INC_d;
  reg INC_p; // pulse action increament command
  reg DEC_q, DEC_d;
  reg DEC_p; // pulse action decrement command
  
  always @ ( INC, INC_q, DEC, DEC_q ) begin
    
    INC_p <= 1'b0;
    INC_d <= INC_q;
    if ( INC == 1'b1 )
      INC_d <= 1'b1;
    else if ( INC_q == 1'b1 ) begin
      INC_p <= 1;
      INC_d <= 1'b0;
    end
    
    DEC_p <= 1'b0;
    DEC_d <= DEC_q;
    if ( DEC == 1'b1 )
      DEC_d <= 1'b1;
    else if ( DEC_q == 1'b1 ) begin
      DEC_p <= 1'b1;
      DEC_d <= 1'b0;
    end
  end
  
  //
  // Operation decoder
  //
  
  reg [8:0]  DISP_VMRK1_q, DISP_VMRK1_d;
  reg [8:0]  DISP_VMRK2_q, DISP_VMRK2_d;
  reg [8:0]  DISP_HMRK1_q, DISP_HMRK1_d;
  reg [8:0]  DISP_HMRK2_q, DISP_HMRK2_d;
  
  reg [1:0]  INPUT_SELECT_q, INPUT_SELECT_d;
  
  reg [0:0]  ADC1_TDIV_q, ADC1_TDIV_d;
  reg [1:0]  ADC1_VDIV_q, ADC1_VDIV_d;
  reg [7:0]  ADC1_VSHIFT_q, ADC1_VSHIFT_d;
  reg [9:0]  ADC1_TRG_LVL_q, ADC1_TRG_LVL_d;
  reg [2:0]  ADC1_TRG_MODE_q, ADC1_TRG_MODE_d;
  
  reg [0:0]  ADC2_TDIV_q, ADC2_TDIV_d;
  reg [1:0]  ADC2_VDIV_q, ADC2_VDIV_d;
  reg [7:0]  ADC2_VSHIFT_q, ADC2_VSHIFT_d;
  reg [9:0]  ADC2_TRG_LVL_q, ADC2_TRG_LVL_d;
  reg [2:0]  ADC2_TRG_MODE_q, ADC2_TRG_MODE_d;
  
  reg [0:0]  DIG1_TDIV_q, DIG1_TDIV_d;
  reg [7:0]  DIG1_VSHIFT_q, DIG1_VSHIFT_d;
  reg [9:0]  DIG1_PAT_q, DIG1_PAT_d;
  reg [9:0]  DIG1_PDCC_q, DIG1_PDCC_d;
  reg [0:0]  DIG1_TRG_LVL_q, DIG1_TRG_LVL_d;
  reg [2:0]  DIG1_TRG_MODE_q, DIG1_TRG_MODE_d;
  
  reg [0:0]  DIG2_TDIV_q, DIG2_TDIV_d;
  reg [7:0]  DIG2_VSHIFT_q, DIG2_VSHIFT_d;
  reg [9:0]  DIG2_PAT_q, DIG2_PAT_d;
  reg [9:0]  DIG2_PDCC_q, DIG2_PDCC_d;
  reg [0:0]  DIG2_TRG_LVL_q, DIG2_TRG_LVL_d;
  reg [2:0]  DIG2_TRG_MODE_q, DIG2_TRG_MODE_d;
  
  reg [0:0]  DIG3_TDIV_q, DIG3_TDIV_d;
  reg [7:0]  DIG3_VSHIFT_q, DIG3_VSHIFT_d;
  reg [9:0]  DIG3_PAT_q, DIG3_PAT_d;
  reg [9:0]  DIG3_PDCC_q, DIG3_PDCC_d;
  reg [0:0]  DIG3_TRG_LVL_q, DIG3_TRG_LVL_d;
  reg [2:0]  DIG3_TRG_MODE_q, DIG3_TRG_MODE_d;
  
  reg [0:0]  DIG4_TDIV_q, DIG4_TDIV_d;
  reg [7:0]  DIG4_VSHIFT_q, DIG4_VSHIFT_d;
  reg [9:0]  DIG4_PAT_q, DIG4_PAT_d;
  reg [9:0]  DIG4_PDCC_q, DIG4_PDCC_d;
  reg [0:0]  DIG4_TRG_LVL_q, DIG4_TRG_LVL_d;
  reg [2:0]  DIG4_TRG_MODE_q, DIG4_TRG_MODE_d;
  
  assign DISP_VMRK1 = DISP_VMRK1_q,
         DISP_VMRK2 = DISP_VMRK2_q,
         DISP_HMRK1 = DISP_HMRK1_q,
         DISP_HMRK2 = DISP_HMRK2_q,
         
         INPUT_SELECT = INPUT_SELECT_q,
         
         ADC1_TDIV = ADC1_TDIV_q,
         ADC1_VDIV = ADC1_VDIV_q,
         ADC1_VSHIFT = ADC1_VSHIFT_q,
         ADC1_TRG_LVL = { ADC1_TRG_LVL_q, 4'hF },
         ADC1_TRG_MODE = ADC1_TRG_MODE_q,
         
         ADC2_TDIV = ADC2_TDIV_q,
         ADC2_VDIV = ADC2_VDIV_q,
         ADC2_VSHIFT = ADC2_VSHIFT_q,
         ADC2_TRG_LVL = { ADC2_TRG_LVL_q, 4'hF },
         ADC2_TRG_MODE = ADC2_TRG_MODE_q,
         
         DIG1_TDIV = DIG1_TDIV_q,
         DIG1_VSHIFT = DIG1_VSHIFT_q,
         DIG1_PAT = DIG1_PAT_q,
         DIG1_PDCC = DIG1_PDCC_q,
         DIG1_TRG_LVL = DIG1_TRG_LVL_q,
         DIG1_TRG_MODE = DIG1_TRG_MODE_q,
         
         DIG2_TDIV = DIG2_TDIV_q,
         DIG2_VSHIFT = DIG2_VSHIFT_q,
         DIG2_PAT = DIG2_PAT_q,
         DIG2_PDCC = DIG2_PDCC_q,
         DIG2_TRG_LVL = DIG2_TRG_LVL_q,
         DIG2_TRG_MODE = DIG2_TRG_MODE_q,
         
         DIG3_TDIV = DIG3_TDIV_q,
         DIG3_VSHIFT = DIG3_VSHIFT_q,
         DIG3_PAT = DIG3_PAT_q,
         DIG3_PDCC = DIG3_PDCC_q,
         DIG3_TRG_LVL = DIG3_TRG_LVL_q,
         DIG3_TRG_MODE = DIG3_TRG_MODE_q,
         
         DIG4_TDIV = DIG4_TDIV_q,
         DIG4_VSHIFT = DIG4_VSHIFT_q,
         DIG4_PAT = DIG4_PAT_q,
         DIG4_PDCC = DIG4_PDCC_q,
         DIG4_TRG_LVL = DIG4_TRG_LVL_q,
         DIG4_TRG_MODE = DIG4_TRG_MODE_q;

  always @ (REG, VALUE_D, SET, CLR, INC_p, DEC_p,
            DISP_VMRK1_q, DISP_VMRK2_q, DISP_HMRK1_q, DISP_HMRK2_q,
            INPUT_SELECT_q,
            ADC1_TDIV_q, ADC1_VDIV_q, ADC1_VSHIFT_q, ADC1_TRG_LVL_q,
            ADC1_TRG_MODE_q,
            ADC2_TDIV_q, ADC2_VDIV_q, ADC2_VSHIFT_q, ADC2_TRG_LVL_q,
            ADC2_TRG_MODE_q,
            DIG1_TDIV_q, DIG1_VSHIFT_q, DIG1_PAT_q, DIG1_PDCC_q,
            DIG1_TRG_LVL_q, DIG1_TRG_MODE_q,
            DIG2_TDIV_q, DIG2_VSHIFT_q, DIG2_PAT_q, DIG2_PDCC_q,
            DIG2_TRG_LVL_q, DIG2_TRG_MODE_q,
            DIG3_TDIV_q, DIG3_VSHIFT_q, DIG3_PAT_q, DIG3_PDCC_q,
            DIG3_TRG_LVL_q, DIG3_TRG_MODE_q,
            DIG4_TDIV_q, DIG4_VSHIFT_q, DIG4_PAT_q, DIG4_PDCC_q,
            DIG4_TRG_LVL_q, DIG4_TRG_MODE_q ) begin
    
    VALUE_Q <= 'b0;
    
    DISP_VMRK1_d <= DISP_VMRK1_q;
    DISP_VMRK2_d <= DISP_VMRK2_q;
    DISP_HMRK1_d <= DISP_HMRK1_q;
    DISP_HMRK2_d <= DISP_HMRK2_q;
    
    INPUT_SELECT_d <= INPUT_SELECT_q;
    
    ADC1_TDIV_d <= ADC1_TDIV_q;
    ADC1_VDIV_d <= ADC1_VDIV_q;
    ADC1_VSHIFT_d <= ADC1_VSHIFT_q;
    ADC1_TRG_LVL_d <= ADC1_TRG_LVL_q;
    ADC1_TRG_MODE_d <= ADC1_TRG_MODE_q;
    
    ADC2_TDIV_d <= ADC2_TDIV_q;
    ADC2_VDIV_d <= ADC2_VDIV_q;
    ADC2_VSHIFT_d <= ADC2_VSHIFT_q;
    ADC2_TRG_LVL_d <= ADC2_TRG_LVL_q;
    ADC2_TRG_MODE_d <= ADC2_TRG_MODE_q;
    
    DIG1_TDIV_d <= DIG1_TDIV_q;
    DIG1_VSHIFT_d <= DIG1_VSHIFT_q;
    DIG1_PAT_d <= DIG1_PAT_q;
    DIG1_PDCC_d <= DIG1_PDCC_q;
    DIG1_TRG_LVL_d <= DIG1_TRG_LVL_q;
    DIG1_CFG <= 1'b0;
    DIG1_TRG_MODE_d <= DIG1_TRG_MODE_q;
    
    DIG2_TDIV_d <= DIG2_TDIV_q;
    DIG2_VSHIFT_d <= DIG2_VSHIFT_q;
    DIG2_PAT_d <= DIG2_PAT_q;
    DIG2_PDCC_d <= DIG2_PDCC_q;
    DIG2_TRG_LVL_d <= DIG2_TRG_LVL_q;
    DIG2_CFG <= 1'b0;
    DIG2_TRG_MODE_d <= DIG2_TRG_MODE_q;
    
    DIG3_TDIV_d <= DIG3_TDIV_q;
    DIG3_VSHIFT_d <= DIG3_VSHIFT_q;
    DIG3_PAT_d <= DIG3_PAT_q;
    DIG3_PDCC_d <= DIG3_PDCC_q;
    DIG3_TRG_LVL_d <= DIG3_TRG_LVL_q;
    DIG3_CFG <= 1'b0;
    DIG3_TRG_MODE_d <= DIG3_TRG_MODE_q;
    
    DIG4_TDIV_d <= DIG4_TDIV_q;
    DIG4_VSHIFT_d <= DIG4_VSHIFT_q;
    DIG4_PAT_d <= DIG4_PAT_q;
    DIG4_PDCC_d <= DIG4_PDCC_q;
    DIG4_TRG_LVL_d <= DIG4_TRG_LVL_q;
    DIG4_CFG <= 1'b0;
    DIG4_TRG_MODE_d <= DIG4_TRG_MODE_q;
    
    case ( REG )
      DISP_VMRK1_REG : begin
        VALUE_Q <= { 1'b0, DISP_VMRK1_q };
        if ( SET == 1'b1 )
          DISP_VMRK1_d <= VALUE_D[8:0];
        if ( CLR == 1'b1 )
          DISP_VMRK1_d <= 'b0;
        if ( INC_p == 1'b1 )
          DISP_VMRK1_d <= DISP_VMRK1_q + 1; 
        if ( DEC_p == 1'b1 )
          DISP_VMRK1_d <= DISP_VMRK1_q - 1; 
      end
      DISP_VMRK2_REG : begin
        VALUE_Q <= { 1'b0, DISP_VMRK2_q };
        if ( SET == 1'b1 )
          DISP_VMRK2_d <= VALUE_D[8:0];
        if ( CLR == 1'b1 )
          DISP_VMRK2_d <= 'b0;
        if ( INC_p == 1'b1 )
          DISP_VMRK2_d <= DISP_VMRK2_q + 1; 
        if ( DEC_p == 1'b1 )
          DISP_VMRK2_d <= DISP_VMRK2_q - 1;
      end
      DISP_VMRK_DIFF : begin
        VALUE_Q <= { 1'b0, DISP_VMRK2_q - DISP_VMRK1_q };
      end
      DISP_HMRK1_REG : begin
        VALUE_Q <= { 1'b0, DISP_HMRK1_q };
        if ( SET == 1'b1 )
          DISP_HMRK1_d <= VALUE_D[8:0];
        if ( CLR == 1'b1 )
          DISP_HMRK1_d <= 'b0;
        if ( INC_p == 1'b1 )
          DISP_HMRK1_d <= DISP_HMRK1_q + 1; 
        if ( DEC_p == 1'b1 )
          DISP_HMRK1_d <= DISP_HMRK1_q - 1;
      end
      DISP_HMRK2_REG : begin
        VALUE_Q <= { 1'b0, DISP_HMRK2_q };
        if ( SET == 1'b1 )
          DISP_HMRK2_d <= VALUE_D[8:0];
        if ( CLR == 1'b1 )
          DISP_HMRK2_d <= 'b0;
        if ( INC_p == 1'b1 )
          DISP_HMRK2_d <= DISP_HMRK2_q + 1; 
        if ( DEC_p == 1'b1 )
          DISP_HMRK2_d <= DISP_HMRK2_q - 1;
      end
      DISP_HMRK_DIFF : begin
        VALUE_Q <= { 1'b0, DISP_HMRK2_q - DISP_HMRK1_q };
      end
      INPUT_SELECT_REG : begin
        VALUE_Q <= { 8'b0, INPUT_SELECT_q };
        if ( SET == 1'b1 )
          INPUT_SELECT_d <= VALUE_D[1:0];
        if ( CLR == 1'b1 )
          INPUT_SELECT_d <= 'b0;
        if ( INC_p == 1'b1 )
          INPUT_SELECT_d <= INPUT_SELECT_q + 1; 
        if ( DEC_p == 1'b1 )
          INPUT_SELECT_d <= INPUT_SELECT_q - 1;
      end
      ADC1_TDIV_REG : begin
        VALUE_Q <= { 9'b0, ADC1_TDIV_q };
        if ( SET == 1'b1 )
          ADC1_TDIV_d <= VALUE_D[0:0];
        if ( CLR == 1'b1 )
          ADC1_TDIV_d <= 'b0;
        if ( INC_p == 1'b1 )
          ADC1_TDIV_d <= ADC1_TDIV_q + 1; 
        if ( DEC_p == 1'b1 )
          ADC1_TDIV_d <= ADC1_TDIV_q - 1;
      end
      ADC1_VDIV_REG : begin
        VALUE_Q <= { 8'b0, ADC1_VDIV_q };
        if ( SET == 1'b1 )
          ADC1_VDIV_d <= VALUE_D[1:0];
        if ( CLR == 1'b1 )
          ADC1_VDIV_d <= 'b0;
        if ( INC_p == 1'b1 )
          ADC1_VDIV_d <= ADC1_VDIV_q + 1; 
        if ( DEC_p == 1'b1 )
          ADC1_VDIV_d <= ADC1_VDIV_q - 1;
      end
      ADC1_VSHIFT_REG : begin
        VALUE_Q <= { 2'b0, ADC1_VSHIFT_q };
        if ( SET == 1'b1 )
          ADC1_VSHIFT_d <= VALUE_D[7:0];
        if ( CLR == 1'b1 )
          ADC1_VSHIFT_d <= 120;
        if ( INC_p == 1'b1 )
          ADC1_VSHIFT_d <= ADC1_VSHIFT_q + 1; 
        if ( DEC_p == 1'b1 )
          ADC1_VSHIFT_d <= ADC1_VSHIFT_q - 1;
      end
      ADC1_TRG_LVL_REG : begin
        VALUE_Q <= { ADC1_TRG_LVL_q };
        if ( SET == 1'b1 )
          ADC1_TRG_LVL_d <= VALUE_D[9:0];
        if ( CLR == 1'b1 )
          ADC1_TRG_LVL_d <= 'b0;
        if ( INC_p == 1'b1 )
          ADC1_TRG_LVL_d <= ADC1_TRG_LVL_q + 4'h3; 
        if ( DEC_p == 1'b1 )
          ADC1_TRG_LVL_d <= ADC1_TRG_LVL_q - 4'h3;
      end
      ADC1_TRG_MODE_REG : begin
        VALUE_Q <= { 7'b0, ADC1_TRG_MODE_q };
        if ( SET == 1'b1 )
          ADC1_TRG_MODE_d <= VALUE_D[2:0];
        if ( CLR == 1'b1 )
          ADC1_TRG_MODE_d <= 'b0;
        if ( INC_p == 1'b1 )
          ADC1_TRG_MODE_d <= ADC1_TRG_MODE_q + 1; 
        if ( DEC_p == 1'b1 )
          ADC1_TRG_MODE_d <= ADC1_TRG_MODE_q - 1;
      end
      ADC2_TDIV_REG : begin
        VALUE_Q <= { 9'b0, ADC2_TDIV_q };
        if ( SET == 1'b1 )
          ADC2_TDIV_d <= VALUE_D[0:0];
        if ( CLR == 1'b1 )
          ADC2_TDIV_d <= 'b0;
        if ( INC_p == 1'b1 )
          ADC2_TDIV_d <= ADC2_TDIV_q + 1; 
        if ( DEC_p == 1'b1 )
          ADC2_TDIV_d <= ADC2_TDIV_q - 1;
      end
      ADC2_VDIV_REG : begin
        VALUE_Q <= { 8'b0, ADC2_VDIV_q };
        if ( SET == 1'b1 )
          ADC2_VDIV_d <= VALUE_D[1:0];
        if ( CLR == 1'b1 )
          ADC2_VDIV_d <= 'b0;
        if ( INC_p == 1'b1 )
          ADC2_VDIV_d <= ADC2_VDIV_q + 1; 
        if ( DEC_p == 1'b1 )
          ADC2_VDIV_d <= ADC2_VDIV_q - 1;
      end
      ADC2_VSHIFT_REG : begin
        VALUE_Q <= { 2'b0, ADC2_VSHIFT_q };
        if ( SET == 1'b1 )
          ADC2_VSHIFT_d <= VALUE_D[7:0];
        if ( CLR == 1'b1 )
          ADC2_VSHIFT_d <= 120;
        if ( INC_p == 1'b1 )
          ADC2_VSHIFT_d <= ADC2_VSHIFT_q + 1; 
        if ( DEC_p == 1'b1 )
          ADC2_VSHIFT_d <= ADC2_VSHIFT_q - 1;
      end
      ADC2_TRG_LVL_REG : begin
        VALUE_Q <= { ADC2_TRG_LVL_q };
        if ( SET == 1'b1 )
          ADC2_TRG_LVL_d <= VALUE_D[9:0];
        if ( CLR == 1'b1 )
          ADC2_TRG_LVL_d <= 'b0;
        if ( INC_p == 1'b1 )
          ADC2_TRG_LVL_d <= ADC2_TRG_LVL_q + 4'h3; 
        if ( DEC_p == 1'b1 )
          ADC2_TRG_LVL_d <= ADC2_TRG_LVL_q - 4'h3;
      end
      ADC2_TRG_MODE_REG : begin
        VALUE_Q <= { 7'b0, ADC2_TRG_MODE_q };
        if ( SET == 1'b1 )
          ADC2_TRG_MODE_d <= VALUE_D[2:0];
        if ( CLR == 1'b1 )
          ADC2_TRG_MODE_d <= 'b0;
        if ( INC_p == 1'b1 )
          ADC2_TRG_MODE_d <= ADC2_TRG_MODE_q + 1; 
        if ( DEC_p == 1'b1 )
          ADC2_TRG_MODE_d <= ADC2_TRG_MODE_q - 1;
      end
      DIG1_TDIV_REG : begin
        VALUE_Q <= { 9'b0, DIG1_TDIV_q };
        if ( SET == 1'b1 )
          DIG1_TDIV_d <= VALUE_D[0:0];
        if ( CLR == 1'b1 )
          DIG1_TDIV_d <= 'b0;
        if ( INC_p == 1'b1 )
          DIG1_TDIV_d <= DIG1_TDIV_q + 1; 
        if ( DEC_p == 1'b1 )
          DIG1_TDIV_d <= DIG1_TDIV_q - 1;
      end
      DIG1_VSHIFT_REG : begin
        VALUE_Q <= { 2'b0, DIG1_VSHIFT_q };
        if ( SET == 1'b1 )
          DIG1_VSHIFT_d <= VALUE_D[7:0];
        if ( CLR == 1'b1 )
          DIG1_VSHIFT_d <= 120;
        if ( INC_p == 1'b1 )
          DIG1_VSHIFT_d <= DIG1_VSHIFT_q + 1; 
        if ( DEC_p == 1'b1 )
          DIG1_VSHIFT_d <= DIG1_VSHIFT_q - 1;
      end
      DIG1_PAT_REG : begin
        VALUE_Q <= { DIG1_PAT_q };
        if ( SET == 1'b1 ) begin
          DIG1_PAT_d <= VALUE_D[9:0];
          DIG1_CFG <= 1'b1;
        end
        if ( CLR == 1'b1 ) begin
          DIG1_PAT_d <= 'b0;
          DIG1_CFG <= 1'b1;
        end
        if ( INC_p == 1'b1 )
          DIG1_PAT_d <= DIG1_PAT_q + 1; 
        if ( DEC_p == 1'b1 )
          DIG1_PAT_d <= DIG1_PAT_q - 1;
      end
      DIG1_PDCC_REG : begin
        VALUE_Q <= { DIG1_PDCC_q };
        if ( SET == 1'b1 ) begin
          DIG1_PDCC_d <= VALUE_D[9:0];
          DIG1_CFG <= 1'b1;
        end
        if ( CLR == 1'b1 ) begin
          DIG1_PDCC_d <= 'b0;
          DIG1_CFG <= 1'b1;
        end
        if ( INC_p == 1'b1 )
          DIG1_PDCC_d <= DIG1_PDCC_q + 1; 
        if ( DEC_p == 1'b1 )
          DIG1_PDCC_d <= DIG1_PDCC_q - 1;
      end
      DIG1_TRG_LVL_REG : begin
        VALUE_Q <= { 9'b0, DIG1_TRG_LVL_q };
        if ( SET == 1'b1 )
          DIG1_TRG_LVL_d <= VALUE_D[0];
        if ( CLR == 1'b1 )
          DIG1_TRG_LVL_d <= 'b0;
        if ( INC_p == 1'b1 )
          DIG1_TRG_LVL_d <= DIG1_TRG_LVL_q + 1; 
        if ( DEC_p == 1'b1 )
          DIG1_TRG_LVL_d <= DIG1_TRG_LVL_q - 1;
      end
      DIG1_TRG_MODE_REG : begin
        VALUE_Q <= { 7'b0, DIG1_TRG_MODE_q };
        if ( SET == 1'b1 )
          DIG1_TRG_MODE_d <= VALUE_D[2:0];
        if ( CLR == 1'b1 )
          DIG1_TRG_MODE_d <= 'b0;
        if ( INC_p == 1'b1 )
          DIG1_TRG_MODE_d <= DIG1_TRG_MODE_q + 1; 
        if ( DEC_p == 1'b1 )
          DIG1_TRG_MODE_d <= DIG1_TRG_MODE_q - 1;
      end
      DIG2_TDIV_REG : begin
        VALUE_Q <= { 9'b0, DIG2_TDIV_q };
        if ( SET == 1'b1 )
          DIG2_TDIV_d <= VALUE_D[0:0];
        if ( CLR == 1'b1 )
          DIG2_TDIV_d <= 'b0;
        if ( INC_p == 1'b1 )
          DIG2_TDIV_d <= DIG2_TDIV_q + 1; 
        if ( DEC_p == 1'b1 )
          DIG2_TDIV_d <= DIG2_TDIV_q - 1;
      end
      DIG2_VSHIFT_REG : begin
        VALUE_Q <= { 2'b0, DIG2_VSHIFT_q };
        if ( SET == 1'b1 )
          DIG2_VSHIFT_d <= VALUE_D[7:0];
        if ( CLR == 1'b1 )
          DIG2_VSHIFT_d <= 120;
        if ( INC_p == 1'b1 )
          DIG2_VSHIFT_d <= DIG2_VSHIFT_q + 1; 
        if ( DEC_p == 1'b1 )
          DIG2_VSHIFT_d <= DIG2_VSHIFT_q - 1;
      end
      DIG2_PAT_REG : begin
        VALUE_Q <= { DIG2_PAT_q };
        if ( SET == 1'b1 ) begin
          DIG2_PAT_d <= VALUE_D[9:0];
          DIG2_CFG <= 1'b1;
        end
        if ( CLR == 1'b1 ) begin
          DIG2_PAT_d <= 'b0;
          DIG2_CFG <= 1'b1;
        end
        if ( INC_p == 1'b1 )
          DIG2_PAT_d <= DIG2_PAT_q + 1; 
        if ( DEC_p == 1'b1 )
          DIG2_PAT_d <= DIG2_PAT_q - 1;
      end
      DIG2_PDCC_REG : begin
        VALUE_Q <= { DIG2_PDCC_q };
        if ( SET == 1'b1 ) begin
          DIG2_PDCC_d <= VALUE_D[9:0];
          DIG2_CFG <= 1'b1;
        end
        if ( CLR == 1'b1 ) begin
          DIG2_PDCC_d <= 'b0;
          DIG2_CFG <= 1'b1;
        end
        if ( INC_p == 1'b1 )
          DIG2_PDCC_d <= DIG2_PDCC_q + 1; 
        if ( DEC_p == 1'b1 )
          DIG2_PDCC_d <= DIG2_PDCC_q - 1;
      end
      DIG2_TRG_LVL_REG : begin
        VALUE_Q <= { 9'b0, DIG2_TRG_LVL_q };
        if ( SET == 1'b1 )
          DIG2_TRG_LVL_d <= VALUE_D[0];
        if ( CLR == 1'b1 )
          DIG2_TRG_LVL_d <= 'b0;
        if ( INC_p == 1'b1 )
          DIG2_TRG_LVL_d <= DIG2_TRG_LVL_q + 1; 
        if ( DEC_p == 1'b1 )
          DIG2_TRG_LVL_d <= DIG2_TRG_LVL_q - 1;
      end
      DIG2_TRG_MODE_REG : begin
        VALUE_Q <= { 7'b0, DIG2_TRG_MODE_q };
        if ( SET == 1'b1 )
          DIG2_TRG_MODE_d <= VALUE_D[2:0];
        if ( CLR == 1'b1 )
          DIG2_TRG_MODE_d <= 'b0;
        if ( INC_p == 1'b1 )
          DIG2_TRG_MODE_d <= DIG2_TRG_MODE_q + 1; 
        if ( DEC_p == 1'b1 )
          DIG2_TRG_MODE_d <= DIG2_TRG_MODE_q - 1;
      end
      DIG3_TDIV_REG : begin
        VALUE_Q <= { 9'b0, DIG3_TDIV_q };
        if ( SET == 1'b1 )
          DIG3_TDIV_d <= VALUE_D[0:0];
        if ( CLR == 1'b1 )
          DIG3_TDIV_d <= 'b0;
        if ( INC_p == 1'b1 )
          DIG3_TDIV_d <= DIG3_TDIV_q + 1; 
        if ( DEC_p == 1'b1 )
          DIG3_TDIV_d <= DIG3_TDIV_q - 1;
      end
      DIG3_VSHIFT_REG : begin
        VALUE_Q <= { 2'b0, DIG3_VSHIFT_q };
        if ( SET == 1'b1 )
          DIG3_VSHIFT_d <= VALUE_D[7:0];
        if ( CLR == 1'b1 )
          DIG3_VSHIFT_d <= 120;
        if ( INC_p == 1'b1 )
          DIG3_VSHIFT_d <= DIG3_VSHIFT_q + 1; 
        if ( DEC_p == 1'b1 )
          DIG3_VSHIFT_d <= DIG3_VSHIFT_q - 1;
      end
      DIG3_PAT_REG : begin
        VALUE_Q <= { DIG3_PAT_q };
        if ( SET == 1'b1 ) begin
          DIG3_PAT_d <= VALUE_D[9:0];
          DIG3_CFG <= 1'b1;
        end
        if ( CLR == 1'b1 ) begin
          DIG3_PAT_d <= 'b0;
          DIG3_CFG <= 1'b1;
        end
        if ( INC_p == 1'b1 )
          DIG3_PAT_d <= DIG3_PAT_q + 1; 
        if ( DEC_p == 1'b1 )
          DIG3_PAT_d <= DIG3_PAT_q - 1;
      end
      DIG3_PDCC_REG : begin
        VALUE_Q <= { DIG3_PDCC_q };
        if ( SET == 1'b1 ) begin
          DIG3_PDCC_d <= VALUE_D[9:0];
          DIG3_CFG <= 1'b1;
        end
        if ( CLR == 1'b1 ) begin
          DIG3_PDCC_d <= 'b0;
          DIG3_CFG <= 1'b1;
        end
        if ( INC_p == 1'b1 )
          DIG3_PDCC_d <= DIG3_PDCC_q + 1; 
        if ( DEC_p == 1'b1 )
          DIG3_PDCC_d <= DIG3_PDCC_q - 1;
      end
      DIG3_TRG_LVL_REG : begin
        VALUE_Q <= { 9'b0, DIG3_TRG_LVL_q };
        if ( SET == 1'b1 )
          DIG3_TRG_LVL_d <= VALUE_D[0];
        if ( CLR == 1'b1 )
          DIG3_TRG_LVL_d <= 'b0;
        if ( INC_p == 1'b1 )
          DIG3_TRG_LVL_d <= DIG3_TRG_LVL_q + 1; 
        if ( DEC_p == 1'b1 )
          DIG3_TRG_LVL_d <= DIG3_TRG_LVL_q - 1;
      end
      DIG3_TRG_MODE_REG : begin
        VALUE_Q <= { 7'b0, DIG3_TRG_MODE_q };
        if ( SET == 1'b1 )
          DIG3_TRG_MODE_d <= VALUE_D[2:0];
        if ( CLR == 1'b1 )
          DIG3_TRG_MODE_d <= 'b0;
        if ( INC_p == 1'b1 )
          DIG3_TRG_MODE_d <= DIG3_TRG_MODE_q + 1; 
        if ( DEC_p == 1'b1 )
          DIG3_TRG_MODE_d <= DIG3_TRG_MODE_q - 1;
      end
      DIG4_TDIV_REG : begin
        VALUE_Q <= { 9'b0, DIG4_TDIV_q };
        if ( SET == 1'b1 )
          DIG4_TDIV_d <= VALUE_D[0:0];
        if ( CLR == 1'b1 )
          DIG4_TDIV_d <= 'b0;
        if ( INC_p == 1'b1 )
          DIG4_TDIV_d <= DIG4_TDIV_q + 1; 
        if ( DEC_p == 1'b1 )
          DIG4_TDIV_d <= DIG4_TDIV_q - 1;
      end
      DIG4_VSHIFT_REG : begin
        VALUE_Q <= { 2'b0, DIG4_VSHIFT_q };
        if ( SET == 1'b1 )
          DIG4_VSHIFT_d <= VALUE_D[7:0];
        if ( CLR == 1'b1 )
          DIG4_VSHIFT_d <= 120;
        if ( INC_p == 1'b1 )
          DIG4_VSHIFT_d <= DIG4_VSHIFT_q + 1; 
        if ( DEC_p == 1'b1 )
          DIG4_VSHIFT_d <= DIG4_VSHIFT_q - 1;
      end
      DIG4_PAT_REG : begin
        VALUE_Q <= { DIG4_PAT_q };
        if ( SET == 1'b1 ) begin
          DIG4_PAT_d <= VALUE_D[9:0];
          DIG4_CFG <= 1'b1;
        end
        if ( CLR == 1'b1 )begin
          DIG4_PAT_d <= 'b0;
          DIG4_CFG <= 1'b1;
        end
        if ( INC_p == 1'b1 )
          DIG4_PAT_d <= DIG4_PAT_q + 1; 
        if ( DEC_p == 1'b1 )
          DIG4_PAT_d <= DIG4_PAT_q - 1;
      end
      DIG4_PDCC_REG : begin
        VALUE_Q <= { DIG4_PDCC_q };
        if ( SET == 1'b1 ) begin
          DIG4_PDCC_d <= VALUE_D[9:0];
          DIG4_CFG <= 1'b1;
        end
        if ( CLR == 1'b1 ) begin
          DIG4_PDCC_d <= 'b0;
          DIG4_CFG <= 1'b1;
        end
        if ( INC_p == 1'b1 )
          DIG4_PDCC_d <= DIG4_PDCC_q + 1; 
        if ( DEC_p == 1'b1 )
          DIG4_PDCC_d <= DIG4_PDCC_q - 1;
      end
      DIG4_TRG_LVL_REG : begin
        VALUE_Q <= { 9'b0, DIG4_TRG_LVL_q };
        if ( SET == 1'b1 )
          DIG4_TRG_LVL_d <= VALUE_D[0];
        if ( CLR == 1'b1 )
          DIG4_TRG_LVL_d <= 'b0;
        if ( INC_p == 1'b1 )
          DIG4_TRG_LVL_d <= DIG4_TRG_LVL_q + 1; 
        if ( DEC_p == 1'b1 )
          DIG4_TRG_LVL_d <= DIG4_TRG_LVL_q - 1;
      end
      DIG4_TRG_MODE_REG : begin
        VALUE_Q <= { 7'b0, DIG4_TRG_MODE_q };
        if ( SET == 1'b1 )
          DIG4_TRG_MODE_d <= VALUE_D[2:0];
        if ( CLR == 1'b1 )
          DIG4_TRG_MODE_d <= 'b0;
        if ( INC_p == 1'b1 )
          DIG4_TRG_MODE_d <= DIG4_TRG_MODE_q + 1; 
        if ( DEC_p == 1'b1 )
          DIG4_TRG_MODE_d <= DIG4_TRG_MODE_q - 1;
      end
      default : begin
      end
    endcase
    
  end

  always @ (posedge Clock or negedge Reset_n) begin
    if ( Reset_n == 1'b0 ) begin
      DEC_q <= 1'b0;
      DEC_q <= 1'b0;
      
      DISP_VMRK1_q <= 'b0;
      DISP_VMRK2_q <= 'b0;
      DISP_HMRK1_q <= 'b0;
      DISP_HMRK2_q <= 'b0;
      
      INPUT_SELECT_q <= 'b0;
      
      ADC1_TDIV_q <= 'b0;
      ADC1_VDIV_q <= 'b0;
      ADC1_VSHIFT_q <= 120;
      ADC1_TRG_LVL_q <= 'b0;
      ADC1_TRG_MODE_q <= 'b0;
      
      ADC2_TDIV_q <= 'b0;
      ADC2_VDIV_q <= 'b0;
      ADC2_VSHIFT_q <= 120;
      ADC2_TRG_LVL_q <= 'b0;
      ADC2_TRG_MODE_q <= 'b0;
      
      DIG1_TDIV_q <= 'b0;
      DIG1_VSHIFT_q <= 120;
      DIG1_PAT_q <= 'b0;
      DIG1_PDCC_q <= 'b0;
      DIG1_TRG_LVL_q <= 'b0;
      DIG1_TRG_MODE_q <= 'b0;
      
      DIG2_TDIV_q <= 'b0;
      DIG2_VSHIFT_q <= 120;
      DIG2_PAT_q <= 'b0;
      DIG2_PDCC_q <= 'b0;
      DIG2_TRG_LVL_q <= 'b0;
      DIG2_TRG_MODE_q <= 'b0;
      
      DIG3_TDIV_q <= 'b0;
      DIG3_VSHIFT_q <= 120;
      DIG3_PAT_q <= 'b0;
      DIG3_PDCC_q <= 'b0;
      DIG3_TRG_LVL_q <= 'b0;
      DIG3_TRG_MODE_q <= 'b0;
      
      DIG4_TDIV_q <= 'b0;
      DIG4_VSHIFT_q <= 120;
      DIG4_PAT_q <= 'b0;
      DIG4_PDCC_q <= 'b0;
      DIG4_TRG_LVL_q <= 'b0;
      DIG4_TRG_MODE_q <= 'b0;
    end
    else begin
      INC_q <= INC_d;
      DEC_q <= DEC_d;
      
      DISP_VMRK1_q <= DISP_VMRK1_d;
      DISP_VMRK2_q <= DISP_VMRK2_d;
      DISP_HMRK1_q <= DISP_HMRK1_d;
      DISP_HMRK2_q <= DISP_HMRK2_d;
      
      INPUT_SELECT_q <= INPUT_SELECT_d;
      
      ADC1_TDIV_q <= ADC1_TDIV_d;
      ADC1_VDIV_q <= ADC1_VDIV_d;
      ADC1_VSHIFT_q <= ADC1_VSHIFT_d;
      ADC1_TRG_LVL_q <= ADC1_TRG_LVL_d;
      ADC1_TRG_MODE_q <= ADC1_TRG_MODE_d;
      
      ADC2_TDIV_q <= ADC2_TDIV_d;
      ADC2_VDIV_q <= ADC2_VDIV_d;
      ADC2_VSHIFT_q <= ADC2_VSHIFT_d;
      ADC2_TRG_LVL_q <= ADC2_TRG_LVL_d;
      ADC2_TRG_MODE_q <= ADC2_TRG_MODE_d;
      
      DIG1_TDIV_q <= DIG1_TDIV_d;
      DIG1_VSHIFT_q <= DIG1_VSHIFT_d;
      DIG1_PAT_q <= DIG1_PAT_d;
      DIG1_PDCC_q <= DIG1_PDCC_d;
      DIG1_TRG_LVL_q <= DIG1_TRG_LVL_d;
      DIG1_TRG_MODE_q <= DIG1_TRG_MODE_d;
      
      DIG2_TDIV_q <= DIG2_TDIV_d;
      DIG2_VSHIFT_q <= DIG2_VSHIFT_d;
      DIG2_PAT_q <= DIG2_PAT_d;
      DIG2_PDCC_q <= DIG2_PDCC_d;
      DIG2_TRG_LVL_q <= DIG2_TRG_LVL_d;
      DIG2_TRG_MODE_q <= DIG2_TRG_MODE_d;
      
      DIG3_TDIV_q <= DIG3_TDIV_d;
      DIG3_VSHIFT_q <= DIG3_VSHIFT_d;
      DIG3_PAT_q <= DIG3_PAT_d;
      DIG3_PDCC_q <= DIG3_PDCC_d;
      DIG3_TRG_LVL_q <= DIG3_TRG_LVL_d;
      DIG3_TRG_MODE_q <= DIG3_TRG_MODE_d;
      
      DIG4_TDIV_q <= DIG4_TDIV_d;
      DIG4_VSHIFT_q <= DIG4_VSHIFT_d;
      DIG4_PAT_q <= DIG4_PAT_d;
      DIG4_PDCC_q <= DIG4_PDCC_d;
      DIG4_TRG_LVL_q <= DIG4_TRG_LVL_d;
      DIG4_TRG_MODE_q <= DIG4_TRG_MODE_d;
    end
  end

endmodule