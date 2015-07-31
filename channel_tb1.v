// Filename:    channel_tb1.v
// Author:      Danny Dutton
// Date:        03/23/15
// Version:     1
// Description: Module connecting transmit to receive. This uses a clock of
// 				sufficent period to ensure that the parity gen can keep up.

`timescale 1ns/100ps
module channel_tb1();
	reg enable;				// Enable for counter
	reg clear;				// Clear for counter
	reg clk_en;				// Clock enable
	wire clk;				// Wire connecting clock to counter and both regs
	wire[9:0] data;			// Bus connecting transmit and receive modules
	wire[8:0] data_out;		// Data output of receive
	wire data_valid;		// Output of comparator from receive module

	// Transmit module containing counter and parity gen.
	transmit DUT1(enable, clear, clk, data);

	// Receive module containing reg, parity gen, and comparator
	receive DUT2(clk, data, data_out, data_valid);

	// Clock feeding counter and both regs, period set to 100
	clk #(100) DUT3(clk_en, clk);

	// Using similar inputs as ctr_tb.v
	initial begin
		enable = 0;
		clear = 0;
		clk_en = 1;
		#10 clear = 1;
		#40 clear = 0;
		#50 enable = 1;
		#400 enable = 0;
		#100 enable = 1;
		#500 clear = 1;
		#60 clear = 0;
	end
endmodule