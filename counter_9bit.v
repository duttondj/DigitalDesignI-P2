////////////////////////////////////////////////////////////////////////////////////////////////////
//  Filename:    counter_9bit.v
//  Author:      T. Martin, Danny Dutton
//  Date:        09/07/04
//  Version:     4
//  Description: This module is a behavioral description of a nine-bit counter with enable and
//               asynchronous clear.
//
// 		 This module has three inputs and one output:
//		 
//               clk:    (input)  system clock
//		         clear:	 (input)  active-high asynchronous clear
//               enable: (input)  count advances when asserted high
//               cout:	 (output) 9-bit counter output
//
//               This module has two parameters:
//
//               CLRDEL: delay from clear asserted to output valid
//               CLKDEL: delay from clk rising to output valid
//
//               This module is not synthesizable.  It is intended for modeling only and should not
//               be used as a template for synthesizable modules. 
//
//  Modification History:
//  Date        By   Version  Change Description
// ========================================================
//  09/07/2004	TLM  1        Original
//  08/24/2005	PMA  2        Restructured for Fall 2005
//  10/03/2013	TLM  3        Revised for DD 1, Fall 2013
//	03/23/2015 	DJD	 4 		  Modified for 9-bit counter

`timescale 1 ns/100 ps
module counter_9bit (enable, clear, clk, cout);
	parameter CLRDEL = 10;	// delay from clear asserted to output valid
  	parameter CLKDEL = 15;	// delay from clk rising to output valid

	input enable;		// count advances when asserted high
	input clear;		// asynchronous clear (active high)
  	input clk;			// system clock
	output [8:0] cout;	// 9-bit counter output
	reg [8:0] cout;		// cout is a reg

	// Locally declared nets
	reg [8:0] count;	// local count holder register

	initial count = 0;

	// Build behavioral 4-bit up-counter with asynchronous clear
	always @(posedge clk or clear) begin
		if (clear == 1) begin
			count = 9'b0;
			cout = #CLRDEL count;
		end
		else if (clk == 1) begin
			if (enable == 1) begin
				if (count == 9'd15) begin 
					count = 0;
				end
				else begin
					count = count + 9'd1;
				end
			end	
			cout =  #CLKDEL count;
		end
	end

endmodule