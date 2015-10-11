// CODE TO INTERFACE WITH THE DSP BOARD
module ADC(
		ADC_CLK,		//Internal ADC clock
		
		ADC_CLKA,		//Output to GPIO
		ADC_CLKB,		//Output to GPIO

		ADC_DA,			//Input from GPIO
		ADC_OTRA,		//Input from GPIO
		ADC_OEA,		//Output to GPIO
				
		ADC_DB,			//Input from GPIO
		ADC_OTRB,		//Input from GPIO
		ADC_OEB,		//Output to GPIO
		
		ADC_PWDN_AB,	//Output to GPIO
		
		ADC_DATA_A,			//Internal ADC data
		ADC_DATA_B);			//Internal ADC data
				

//////////////////////// ADC Physical Pins ////////////////////
input		[13:0] ADC_DA;	//Input from GPIO
input		ADC_OTRA;		//Input from GPIO
output		ADC_OEA;		//Output to GPIO
output		ADC_CLKA;		//Output to GPIO
				
input		[13:0] ADC_DB;	//Input from GPIO
input		ADC_OTRB;		//Input from GPIO
output		ADC_OEB;		//Output to GPIO
output		ADC_CLKB;		//Output to GPIO
		
output		ADC_PWDN_AB;	//Output to GPIO

////////////////////////  ADC Internal Port //////////////////
input ADC_CLK;
output reg  [13:0]ADC_DATA_A;
output reg  [13:0]ADC_DATA_B;

assign ADC_CLKA = ADC_CLK;
assign ADC_CLKB = ADC_CLK;
assign ADC_OEA = 0;
assign ADC_OEB = 0;
assign ADC_PWDN_AB = 1;

always @( posedge ADC_CLK )
	begin
		ADC_DATA_A <= ADC_DA;
		ADC_DATA_B <= ADC_DB;
	end

endmodule 
