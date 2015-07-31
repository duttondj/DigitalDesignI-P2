// Filename:    register_10bit_tb.v
// Author:      Danny Dutton
// Date:        03/23/15
// Version:     1
// Description: Test bench for 10-bit register

`timescale 1ns/100ps
module register_10bit_tb();
	reg clk_en;
	reg[9:0] data_in;
	wire[9:0] data_out;
	wire clk;

	register_10bit DUT1(clk, data_in, data_out);

	clk DUT2(clk_en, clk);

	initial begin
		clk_en = 1;
		data_in = 0;
		#85 data_in = 10'd1;
		#50 data_in = 10'd2;
		#50 data_in = 10'd4;
		#50 data_in = 10'd8;
		#50 data_in = 10'd16;
		#50 data_in = 10'd32;
		#50 data_in = 10'd64;
		#50 data_in = 10'd128;
		#50 data_in = 10'd256;
		#50 data_in = 10'd512;
		#50 data_in = 10'd0;
	end
endmodule
