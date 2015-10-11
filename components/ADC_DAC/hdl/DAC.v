// CODE TO INTERFACE WITH THE DSP BOARD
module DAC(
		DAC_CLK,		//Internal DAC clock
		
		DAC_CLKA,		//Output to GPIO
		DAC_CLKB,		//Output to GPIO

		DAC_DA,			//Output to GPIO
		DAC_WRTA,		//Output to GPIO
		
		DAC_DB,			//Output to GPIO				
		DAC_WRTB,		//Output to GPIO
		
		DAC_MODE,		//Output to GPIO
				
		DAC_DATA_A,		//Internal ADC data
		DAC_DATA_B);	//Internal ADC data
				

//////////////////////// ADC Physical Pins ////////////////////
output reg	[13:0] DAC_DA;	//Output to GPIO
output DAC_WRTA;			//Output to GPIO
output DAC_CLKA;			//Output to GPIO
				
output reg	[13:0] DAC_DB;	//Output to GPIO
output DAC_WRTB;			//Output to GPIO
output DAC_CLKB;			//Output to GPIO
		
output DAC_MODE;			//Output to GPIO

////////////////////////  ADC Internal Port //////////////////
input 	DAC_CLK;
input  [13:0] DAC_DATA_A;
input  [13:0] DAC_DATA_B;

assign DAC_MODE = 1;
assign DAC_WRTA = ~DAC_CLK;
assign DAC_CLKA = ~DAC_CLK;
assign DAC_WRTB = ~DAC_CLK;
assign DAC_CLKB = ~DAC_CLK;

always @( posedge DAC_CLK )
	begin
		DAC_DA <= DAC_DATA_A;
		DAC_DB <= DAC_DATA_B;
	end

endmodule 
