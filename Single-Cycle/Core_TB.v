`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:50:37 03/16/2014 
// Design Name: 
// Module Name:    Core_TB 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module Core_TB(
    );
	 reg clk;
	 reg nrst;
	 reg[2:0] in;
	 wire[7:0] out;
	 Core c (
				clk,
				nrst,
				in,
				out
				);
		
		initial
		begin
			clk = 0;
			forever begin
				#20  clk = ~clk;
			end
		end
		
		initial
		begin
			in = 3'b010;
			nrst = 0;
			#75
			nrst = 1;
		end
	
endmodule
