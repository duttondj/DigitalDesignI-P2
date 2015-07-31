// Filename:    hc280.v
// Author:      Danny Dutton
// Date:        03/23/15
// Version:     1
// Description: 9-bit odd/even parity generator/checker

`timescale 1 ns/100 ps
module hc280(data_in, sigma_even, sigma_odd);
	input [8:0] data_in;
	output sigma_even, sigma_odd;
	reg sigma_even, sigma_odd;

	// Typical propagation delays at 25C, 4.5V for 74HC280
	specify
		(data_in *> sigma_even, sigma_odd) = (20,23);
	endspecify

	// On change of data_in, find parity bits
	always @(data_in) begin
		sigma_even = ~^data_in;
		sigma_odd = ^data_in;
	end
endmodule