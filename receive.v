// Filename:    receive.v
// Author:      Danny Dutton
// Date:        03/23/15
// Version:     1
// Description: Module that receives a 10-bit bus which is fed into a register.
//				This data is also fed into a 9-bit parity generator. The ODD ouput
//				is compared to the 10th data bit which is an even parity bit.

module receive(clk, data_in, data_out, data_valid);
	input clk;				// Clock to be generated in test bench with clk module
	input[9:0] data_in;		// Data coming from transmit, into reg and parity gen
	output[8:0] data_out;	// 9-bit bus coming out of reg
	output data_valid;		// Output of comparator
	wire[8:0] data_out;
	wire data_valid;
	wire odd_in;			// Even parity bit going to comparator
	wire odd, even;			// Outputs of parity generator

	// 10-bit register
	// Input from transmit module, output goes to output, parity gen, and comparator
	register_10bit U4(clk, data_in, {odd_in, data_out});

	// 9-bit parity generator
	// Input from data_out, output to comparator
	hc280 U5(data_out, even, odd);

	// Parity bit comparator (XNOR gate). Since the hc280 outputs high on odd when
	// there is an odd number of 1s in its input, this odd output is used as an even
	// parity bit (odd number of 1s plus another 1 = even number of ones). So XNOR is
	// used to check if there is either an odd number of ones and a high even parity
	// bit or an even number of ones and a low even parity bit.
	xnor U6(data_valid, odd, odd_in);
endmodule