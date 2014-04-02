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
	 output[31:0] instr,
    output reg[31:0] iaddr,
    output[7:0] daddr,
    output reg[31:0] dout,
    output reg[3:0] wr, 
	 output reg[7:0] pc, 
	 output reg[31:0] reg_din,
	 output reg[4:0] reg_raddr1,
	 output[31:0] reg_dout1,
	 output reg[4:0] reg_raddr2,
	 output[31:0] reg_dout2,
	 output reg wr_reg,
	 output reg[4:0] reg_wr_addr,
	 output reg[31:0] ALUOut,
	 output reg[3:0] ALUOp,
	 output reg ALUSrc,
	 output[31:0] ALUIn1,
	 output reg[31:0] ALUIn2
    );

   //Wires & Regs definitions
	//wire[31:0] instr; ->moved to module inputs for debug purposes
	//reg[31:0] ALUOut;
	//reg[3:0] ALUOp;
	//reg ALUSrc;
	reg Carry;
	reg RegDst;
	reg MemToReg;
	assign ALUIn1 = reg_dout1;
	//reg[31:0] ALUIn2;
	wire[7:0] din[0:3];
	//reg[7:0] pc = 8'b00000000;
	reg[31:0] immediate_extended;
	/*
	reg[4:0] reg_raddr1;
	wire[31:0] reg_dout1;
	reg[4:0] reg_raddr2;
	wire[31:0] reg_dout2;
	wire wr_reg;
	reg[4:0] reg_wr_addr;
	reg[31:0] reg_din; 
	moved to module outputs for debug purposes
	*/
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
				  1'b0, // input [0 : 0] wea
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

	always @*
	begin
	//RegDst Mux
		reg_wr_addr = RegDst ? instr[15:11] : instr[20:16];
	//MemToReg Mux
		assign reg_din = MemToReg ? dout : ALUOut;
	//ALUSrc Mux
		assign ALUIn2 = ALUSrc ? {{16{instr[15]}}, instr[15:0]} : reg_dout2; //sign extended
	end
					
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
		case (instr[31:26])
		6'b000000 :
		begin
			//func
			case (instr[10:0])
				11'b00000100000 : //Add
				begin
					ALUOp = 4'b0000;
				end
				11'b00000100100 : //And
				begin
					ALUOp = 4'b0001;
				end
			endcase
		end
		6'b001000 :
			ALUOp = 4'b0000;
		default :
			;
		endcase
	end
	//Control
	always @(posedge clk)
	begin
		case (instr[31:26])
		6'b000000 :
		begin
			//func
			case (instr[10:0])
				11'b00000100000, 11'b00000100001 : //Add, Addu
				/*(Note: ALL arithmetic immediate values are sign-extended. After that, they are handled as
				  signed or unsigned 32 bit numbers, depending upon the instruction. The only difference between
				  signed and unsigned instructions is that signed instructions can generate an overflow exception
				  and unsigned instructions can not. )
				*/
				begin
					RegDst = 0;
					ALUSrc = 0;
					reg_raddr1 <= instr[25:21];
					reg_raddr2 <= instr[20:16];
					reg_wr_addr <= instr[15:11];
					wr_reg <= 1;
					MemToReg <= 0;
				end
				11'b00000100100 : //And
				begin
					RegDst = 0;
					ALUSrc = 0;
					reg_raddr1 <= instr[25:21];
					reg_raddr2 <= instr[20:16];
					reg_wr_addr <= instr[15:11];
					wr_reg <= 1;
					MemToReg <= 0;
				end
			default:
				;
			endcase
		end
		6'b001000, 6'b001001 : //Addi, Addiu
		begin
			RegDst = 0;
			ALUSrc = 1; //immediate
			reg_raddr1 <= instr[25:21]; //should be here or out of using statement!?
			reg_wr_addr <= instr[20:16];
			wr_reg <= 1;
			MemToReg <= 0;
		end
		6'b001100 : //Andi
		begin
			RegDst = 0;
			ALUSrc = 1; //immediate
			reg_raddr1 <= instr[25:21];
			reg_wr_addr <= instr[20:16];
			wr_reg <= 1;
			MemToReg <= 0;
		end
		default :
			;
		endcase
	end
	//ALU
	reg[32:0] tmp; //used in add, to compute carry
	always @*
	begin
		/*
		0000 : add/i/ui/u
		0001 : and/i
		 : or
		 : sll
		 : sllv
		 : sra
		 : srl
		 : srlv
		 : sub/u
		 : xor/i
		*/
		case (ALUOp)
		4'b0000 : //Add
		begin
			tmp <= ALUIn2 + reg_dout1;
			ALUOut <= tmp[31:0];
			Carry = tmp[32];
			//Set Carry flag if signed!
		end
		4'b0001 : //And
		begin
			ALUOut <= reg_dout1 & ALUIn2;
		end
		default :
			;
		endcase
	end

endmodule
