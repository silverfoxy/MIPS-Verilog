`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:54:16 03/16/2014 
// Design Name: 
// Module Name:    Core 
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
module Core(
    input clk,
    input nrst,
    output reg[31:0] iaddr,
    output[7:0] daddr,
    output reg[31:0] dout,
    output reg[3:0] wr, output reg[7:0] pc, output[31:0] instr, output reg[31:0] reg_din
    );

   //Wires & Regs definitions
	//wire[31:0] instr; ->moved to module outputs for debug purposes
	reg[31:0] ALUOut;
	reg[3:0] ALUOp;
	reg ALUSrc;
	reg Carry;
	reg RegDst
	//ALUIn1 <= reg_dout1
	reg[31:0] ALUIn2;
	wire[7:0] din[0:3];
	//reg[7:0] pc = 8'b00000000; ->moved to module outputs for debug purposes
	reg[31:0] immediate_extended;
	reg[4:0] reg_raddr1;
	wire[31:0] reg_dout1;
	reg[4:0] reg_raddr2;
	wire[31:0] reg_dout2;
	wire wr_reg;
	reg[4:0] reg_wr_addr;
	//reg[31:0] reg_din; ->moved to module outputs for debug purposes
	regfile registers(
					clk,
					reg_raddr1,
					reg_dout1,
					reg_raddr2,
					reg_dout2,
					wr_reg,
					reg_wr_addr,
					reg_din
					);
	
	
	//Memory instantiations
	wire[31:0] dina; //not used since we don't write to imem
	IMem imem (
				  clk, // input clka
				  0, // input [0 : 0] wea
				  pc[7:2], // input [5 : 0] addra
				  dina, // input [31 : 0] dina
				  instr // output [31 : 0] douta
					);
	DMem dmem_0 (
					  clk, // input clka
					  wr[0], // input [0 : 0] wea
					  daddr[5:0], // input [5 : 0] addra
					  dout[7:0], // input [7 : 0] dina
					  din[0] // output [7 : 0] douta
					);
	DMem dmem_1 (
					  clk, // input clka
					  wr[1], // input [0 : 0] wea
					  daddr[5:0], // input [5 : 0] addra
					  dout[15:8], // input [7 : 0] dina
					  din[1] // output [7 : 0] douta
					);
	DMem dmem_2 (
					  clk, // input clka
					  wr[2], // input [0 : 0] wea
					  daddr[5:0], // input [5 : 0] addra
					  dout[23:16], // input [7 : 0] dina
					  din[2] // output [7 : 0] douta
					);
	DMem dmem_3 (
					  clk, // input clka
					  wr[3], // input [0 : 0] wea
					  daddr[5:0], // input [5 : 0] addra
					  dout[31:24], // input [7 : 0] dina
					  din[3] // output [7 : 0] douta
					);	

	//RegDst Mux
	if (RegDst == 1'b0)
		reg_wr_addr <= instr[20:16];
	else
		reg_wr_addr <= instr[15:11];
	//MemToReg Mux
	if (MemToReg == 1'b0)
		reg_din <= ALUOut;
	else
		reg_din <= dout;
	//ALUSrc Mux
	if (ALUSrc == 1'b0)
		ALUIn2 <= reg_raddr1;
	else
		ALUIn2 <= {{16{instr[15]}}, instr[15:0]}; //sign extended

					
	//PC
	always @(posedge clk)
	begin
		if (~nrst)
		begin
			pc = 8'b00000000;
			dout = 8'b00000000;
		end
		else
		begin
			pc = pc + 8'b00000100;
		end
	end
	//Decode
	always @(instr)
	begin
		if (instr[31:26] == 6'b001000)
			ALUOp = 4'b0001;
	end
	//Control
	always @(posedge clk)
	begin
		if (instr[31:26] == 6'b001000)
		begin
			RegDst = 0;
			reg_raddr1 <= instr[25:21]; //should be here or out of using!?
		end
	end
	//ALU
	always @(posedge clk)
	begin
		/*
		0000 : add/i/ui/u
		 : and/i
		 : or
		 : sll
		 : sllv
		 : sra
		 : srl
		 : srlv
		 : sub/u
		 : xor/i
		*/
		if (ALUOp == 4'b0000) //add
		begin
			wire[8:0] tmp;
			tmp <= ALUIn2 + reg_dout1;
			ALUOut = tmp[7:0];
			Carry = tmp[8];
			//Set Carry flag if signed!
		end
	end

endmodule
