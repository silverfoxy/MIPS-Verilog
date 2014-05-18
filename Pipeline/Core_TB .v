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
	 wire[31:0] IFID_instr;
	 wire[31:0] IDEX_instr;
	 wire[31:0] EXMEM_instr;
	 wire[31:0] MEMWB_instr;
	 wire[31:0] iaddr;
    wire[5:0] daddr;
    wire[31:0] dout;
	 wire[31:0] MEMWB_dout;
    wire[3:0] wr;
	 wire[3:0] EXMEM_wr;
	 wire[31:0] pc; 
	 wire[31:0] IFID_pc; 
	 wire[31:0] IDEX_pc;
	 wire[31:0] EXMEM_pc; 
	 wire[31:0] reg_din;
	 wire[4:0] reg_raddr1;
	 wire[31:0] reg_dout1;
	 wire[31:0] IDEX_reg_dout1;
	 wire[4:0] reg_raddr2;
	 wire[31:0] reg_dout2;
	 wire[31:0] IDEX_reg_dout2;
	 wire[31:0] EXMEM_reg_dout2;
	 wire wr_reg;
	 wire EXMEM_wr_reg;
	 wire MEMWB_wr_reg;
	 wire[4:0] reg_wr_addr;
	 wire[31:0] ALUOut;
	 wire[31:0] EXMEM_ALUOut;
	 wire[31:0] MEMWB_ALUOut;
	 wire[3:0] ALUOp;
	 wire ALUSrc;
	 wire[31:0] ALUIn2;
	 wire MemToReg;
	 wire EXMEM_MemToReg;
	 wire MEMWB_MemToReg;
	 wire RegDst;
	 wire EXMEM_RegDst;
	 wire MEMWB_RegDst;
	 wire PCSrc;
	 wire[31:0] ram1;
	 wire[31:0] ram2;
	 wire[31:0] ram3;
	 wire Zero;
	 wire Branch;
	 wire Jump;
	 Core c (
				clk,
				nrst,
				instr,
				IFID_instr,
				IDEX_instr,
				EXMEM_instr,
				MEMWB_instr,
				//iaddr,
				daddr,
				dout,
				MEMWB_dout,
				wr,
				EXMEM_wr,
				pc,
				IFID_pc,
				IDEX_pc,
				EXMEM_pc,
				reg_din,
				reg_raddr1,
				reg_dout1,
				IDEX_reg_dout1,
				reg_raddr2,
				reg_dout2,
				IDEX_reg_dout2,
				EXMEM_reg_dout2,
				wr_reg,
				EXMEM_wr_reg,
				MEMWB_wr_reg,
				reg_wr_addr,
				ALUOut,
				EXMEM_ALUOut,
	         MEMWB_ALUOut,
				ALUOp,
				ALUSrc,
				ALUIn2,
				MemToReg,
				EXMEM_MemToReg,
				MEMWB_MemToReg,
				RegDst,
				EXMEM_RegDst,
				MEMWB_RegDst,
				PCSrc,
				ram1,
				ram2,
				ram3,
				Zero,
				Branch,
				Jump
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
			#75
			nrst = 1;
		end
	
endmodule
