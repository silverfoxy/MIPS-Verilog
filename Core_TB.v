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

//baraye test khate 152 Core.v ro uncomment konid ta src register meghdar begire ke addi anjam beshe
//run for 7000ns
/*
coe file contains:
00000000000000000000000000000000,
00000000000000000000000000000001,
00000000000000000000000000000010,
00000000000000000000000000000011,
00000000000000000000000000000100,
00000000000000000000000000000101,
00000000000000000000000000000110,
00000000000000000000000000000111,
00100000000000010000000000000011;
last instruction is addi
*/
module Core_TB(
    );
	 reg clk;
	 reg nrst;
	 wire[31:0] iaddr;
    wire[7:0] daddr;
    wire[7:0] dout;
    wire[3:0] wr;
	 wire[7:0] pc;
	 wire[31:0] instr;
	 wire[31:0] reg_din;
	 Core c (
				clk,
				nrst,
				iaddr,
				daddr,
				dout,
				wr,
				pc,
				instr,
				reg_din
				);
		
		initial
		begin
			clk = 0;
			forever begin
				#200  clk = ~clk;
			end
		end
		
		initial
		begin
			nrst = 0;
			#1000
			nrst = 1;
		end
	
endmodule
