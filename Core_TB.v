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
	 wire[31:0] instr;
	 wire[31:0] iaddr;
    wire[7:0] daddr;
    wire[31:0] dout;
    wire[3:0] wr;
	 wire[7:0] pc;
	 wire[31:0] reg_din;
	 wire[4:0] reg_raddr1;
	 wire[31:0] reg_dout1;
	 wire[4:0] reg_raddr2;
	 wire[31:0] reg_dout2;
	 wire wr_reg;
	 wire[4:0] reg_wr_addr;
	 wire[31:0] ALUOut;
	 wire[3:0] ALUOp;
	 wire ALUSrc;
	 wire[31:0] ALUIn1;
	 wire[31:0] ALUIn2;
	 Core c (
				clk,
				nrst,
				instr,
				iaddr,
				daddr,
				dout,
				wr,
				pc,
				reg_din,
				reg_raddr1,
				reg_dout1,
				reg_raddr2,
				reg_dout2,
				wr_reg,
				reg_wr_addr,
				ALUOut,
				ALUOp,
				ALUSrc,
				ALUIn1,
				ALUIn2
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
			nrst = 0;
			#100
			nrst = 1;
		end
	
endmodule
