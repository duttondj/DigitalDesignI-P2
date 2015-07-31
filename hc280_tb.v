// Filename:    hc280_tb.v
// Author:      Danny Dutton
// Date:        03/23/15
// Version:     1
// Description: Test bench for 9-bit odd/even parity generator/checker

`timescale 1ns/100ps
module hc280_tb();
	reg enable;						//Enable for counter
	reg clr;						//Clear signal for counter
	reg clk_en;						//Enable for clock
	wire clk;						//Output of clock
	wire[8:0] count;				//Output of counter, goes to hc280 as input
	wire sigma_even, sigma_odd;		//Output of hc280

	// Parity generator/checker
	hc280 DUT1(count, sigma_even, sigma_odd);

	// 9-bit counter feeding into parity bit generator
	counter_9bit DUT2(enable, clr, clk, count);

	// Clock feeding into counter
	clk DUT3(clk_en, clk);

	// Using similar inputs as ctr_tb.v
	initial begin
		enable = 0;
		clr = 0;
		clk_en = 1;
		#10 clr = 1;
		#40 clr = 0;
		#50 enable = 1;
		#400 enable = 0;
		#100 enable = 1;
		#500 clr = 1;
		#60 clr = 0;
	end
endmodule