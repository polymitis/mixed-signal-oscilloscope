//% @file VGA_LCD_Driver_DE270_Top.v
//% @author Petros Fountas
//% @brief Module provided VGA LCD Driver for Terrasic DE2 series boards.

module VGA_LCD_Driver_DE270_Top (
  // Oscillator (50 MHz)
  input CLOCK_50,
  
  // Reset_n
  input SW_17,
  
  // [Active] indicator
  output LEDR_17,

  // VGA Interface
  output       VGA_CLK,
  output       VGA_HS,
  output       VGA_VS,
  output       VGA_BLANK,
  output       VGA_SYNC,
  output [9:0] VGA_R,
  output [9:0] VGA_G,
  output [9:0] VGA_B
  
);

  // Reset_n
  wire Reset_n;

  assign Reset_n = SW_17;
  assign LEDR_17 = SW_17; 

  // 25 MHz clock
  wire Clock_25;

  // PLL
  VIDEO_PLL video_pll (
    .inclk0 ( CLOCK_50 ),
    .c0     ( Clock_25 ),
    .c1     ( VGA_CLK  ));
       
  // VGA Driver
  VGA_LCD_Driver vga_driver ( 
    .CLOCK_25 ( Clock_25 ), // 25 MHz 
    .RESET_N  ( Reset_n  ), // Reset_N

    // User interface 
    .X   ( ), // X Pixel
    .Y   ( ), // Y Pixel
    .WR  ( ), // Write Enable
    .RGB ( ), // Colour
    
    // VGA interface
    .VGA_HSYNC ( VGA_HS    ),  // VGA H_SYNC
    .VGA_VSYNC ( VGA_VS    ),  // VGA V_SYNC
    .VGA_BLANK ( VGA_BLANK ),  // VGA BLANK
    .VGA_SYNC  ( VGA_SYNC  ),  // VGA SYNC
    .VGA_R     ( VGA_R     ),  // VGA Red[9:0]
    .VGA_G     ( VGA_G     ),  // VGA Green[9:0]
    .VGA_B     ( VGA_B     )); // VGA Blue[9:0]

endmodule