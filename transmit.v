// Filename:    transmit.v
// Author:      Danny Dutton
// Date:        03/23/15
// Version:     1
// Description: Module containing a counter feeding into a 9-bit parity generator 
//				and 10-bit register. The even parity bit is also fed into the reg.

module transmit(enable, clear, clk, data_out);
	input enable;			// Counter input which pauses counter
	input clear;			// Counter input which resets count to zero
	input clk;				// Clock to be generated in test bench with clk module
	output[9:0] data_out;	// Output of register
	wire[9:0] data_out;
	wire[8:0] count;		// Output of counter
	wire even, odd;			// Output of parity generator

	// 9-bit counter
	counter_9bit U1(enable, clear, clk, count);

	// Parity generator that counts up number of 1s and if odd, is high on odd output.
	hc280 U2(count, even, odd);

	// Since the hc280's odd output is used, this will be an even parity bit fed into
	// the register along with the counter output.
	register_10bit U3(clk, {odd, count}, data_out);
endmodule