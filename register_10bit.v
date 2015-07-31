// Filename:    register_10bit.v
// Author:      Danny Dutton
// Date:        03/23/15
// Version:     1
// Description: 10-bit bus interface register.

module register_10bit(clk, d_in, q_out);
	input clk; 
	input [9:0] d_in;
	output[9:0] q_out;
	reg[9:0] q_out;

	// Set input to output on rising edge clock
	always @(posedge clk) begin
		q_out = d_in;
	end
endmodule