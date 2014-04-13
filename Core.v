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
	 output reg[31:0] pc, 
	 output wire[31:0] reg_din,
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
	 output reg[31:0] ALUIn2,
	 output reg MemToReg,
	 output reg RegDst,
	 output reg PCSrc,
	 output wire[31:0] ram1,
	 output wire[31:0] ram2,
	 output wire[31:0] ram3,
	 output reg Zero,
	 output reg Branch,
	 output reg Jump
	 );

   //Wires & Regs definitions
	//wire[31:0] instr; ->moved to module inputs for debug purposes
	//reg[31:0] ALUOut;
	//reg[3:0] ALUOp;
	//reg ALUSrc;
	reg Carry;
	//reg RegDst;
	//reg MemToReg;
	assign ALUIn1 = reg_dout1;
	//reg[31:0] ALUIn2;
	wire[7:0] din[0:3];
	//reg[7:0] pc = 8'b00000000;
	reg[31:0] immediate_extended;
	reg[31:0] next_pc;
	reg[31:0] shifted_pc;
	reg[4:0] shamt;
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
	wire nclk;
	assign nclk = !(clk);
	regfile registers(
					nclk,
					reg_raddr1,
					reg_dout1,
					reg_raddr2,
					reg_dout2,
					wr_reg,
					reg_wr_addr,
					reg_din,
					ram1,
					ram2,
					ram3
					);
	
	
	//Memory instantiations
	wire[31:0] dina; //not used since we don't write to imem
	//wire[31:0] tmp_instr;
	IMem imem (
				  nclk, // input clka
				  1'b0, // input [0 : 0] wea
				  pc[7:2], // input [5 : 0] addra
				  dina, // input [31 : 0] dina
				  instr // output [31 : 0] douta
					);
	DMem dmem_0 (
					  nclk, // input clka
					  wr[0], // input [0 : 0] wea
					  daddr[5:0], // input [5 : 0] addra
					  dout[7:0], // input [7 : 0] dina
					  din[0] // output [7 : 0] douta
					);
	DMem dmem_1 (
					  nclk, // input clka
					  wr[1], // input [0 : 0] wea
					  daddr[5:0], // input [5 : 0] addra
					  dout[15:8], // input [7 : 0] dina
					  din[1] // output [7 : 0] douta
					);
	DMem dmem_2 (
					  nclk, // input clka
					  wr[2], // input [0 : 0] wea
					  daddr[5:0], // input [5 : 0] addra
					  dout[23:16], // input [7 : 0] dina
					  din[2] // output [7 : 0] douta
					);
	DMem dmem_3 (
					  nclk, // input clka
					  wr[3], // input [0 : 0] wea
					  daddr[5:0], // input [5 : 0] addra
					  dout[31:24], // input [7 : 0] dina
					  din[3] // output [7 : 0] douta
					);	
	always @*
	begin
	//PCSrc Mux & Jump
		//4'b0000 because our memory real pc is 8 bits and 4 MSBs are always 0 in our case
		next_pc = Jump ? {4'b0000, instr[25:0], 2'b00} : pc + 32'b100;
		shifted_pc = (({{16{instr[15]}}, instr[15:0]}) << 2) + (pc + 32'b100);
		PCSrc = Branch & Zero;
		next_pc = PCSrc ? shifted_pc : next_pc;
	//RegDst Mux
		reg_wr_addr = RegDst ? instr[15:11] : instr[20:16];
	//ALUSrc Mux
		assign ALUIn2 = ALUSrc ? {{16{instr[15]}}, instr[15:0]} : reg_dout2; //sign extended
	end
	//MemToReg Mux
		assign reg_din = MemToReg ? dout : ALUOut;				
	//PC
	always @(posedge clk)
	begin
		if (~nrst)
		begin
			pc = 32'b0;
			dout = 8'b00000000;
		end
		else
		begin
			pc = next_pc;
		end
	end
	
	//Decode
	always @(posedge clk)
	begin
		if (instr[31:26] == 6'b001000)
			ALUOp = 4'b0000;
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
				11'b00000100101: // OR
					begin
						ALUOp = 4'b0010;
					end
				11'b00000000000 :
				begin
					case(instr[5:0])
						6'b000000 : //SLL
						begin
							ALUOp = 4'b0011;
						end
					endcase
				end
			endcase
		end
		6'b001000 , 6'b001001 :
			ALUOp = 4'b0000; // ADDI
		6'b00100 : // BEQ
			ALUOp = 4'b0100; // (BEQ uses Sub)
		default :
			//6'b000010 : // Jump
			//Nothing (we don't need the alu)
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
					Branch <= 0;
					Jump <= 0;
				end
				11'b00000100100 : //And
				begin
					RegDst = 1;
					ALUSrc = 0;
					reg_raddr1 <= instr[25:21];
					reg_raddr2 <= instr[20:16];
					reg_wr_addr <= instr[15:11];
					wr_reg <= 1;
					MemToReg <= 0;
					Branch <= 0;
					Jump <= 0;
				end
				
				11'b00000100101 : // OR
				begin
					RegDst = 1;
					ALUSrc = 0;
					reg_raddr1 <= instr[25:21];
					reg_raddr2 <= instr[20:16];
					reg_wr_addr <= instr[15:11];
					wr_reg <= 1;
					MemToReg <= 0;
					Branch <= 0;
					Jump <= 0;
				end
				11'b00000000000 :
				case(instr[5:0])
					6'b000000 : //SLL
					begin
						RegDst = 1;
						ALUSrc = 0;
						reg_raddr1 <= instr[20:16];
						reg_wr_addr <= instr[15:11];
						wr_reg <= 1;
						MemToReg <= 0;
						Branch <= 0;
						Jump <= 0;
						shamt <= instr[10:6];
					end
				endcase
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
			Branch <= 0;
			Jump <= 0;
		end
		6'b001100 : //Andi
		begin
			RegDst = 0;
			ALUSrc = 1; //immediate
			reg_raddr1 <= instr[25:21];
			reg_wr_addr <= instr[20:16];
			wr_reg <= 1;
			MemToReg <= 0;
			Branch <= 0;
			Jump <= 0;
		end
		6'b000100 : //BEQ
		begin
			reg_raddr1 <= instr[25:21];
			reg_raddr2 <= instr[20:16];
			wr_reg <= 0;
			ALUSrc <= 0;
			wr <= 4'b0000;
			MemToReg <= 0;
			Branch <= 1;
			Jump <= 0;
		end
		6'b000010 : // Jump
		begin
			wr_reg <= 0;
			wr <= 4'b0000;
			Branch <= 0;
			Jump <= 1;
		end
		default :
			;
		endcase
		if (instr == 32'b0) //NOP
		begin
			wr_reg <= 0;
			wr <= 4'b0000;
			PCSrc <= 0;
			Jump <= 0;
			Branch <= 0;
		end
	end
	//ALU
	reg[32:0] tmp; //used in add, to compute carry
	always @*
	begin
		/*
		0000 : add/i/ui/u
		0001 : and/i
		0010 : or
		0011 : sll
		0100 : Sub
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
		4'b0010 : // OR
		begin
			ALUOut <= reg_dout1 | ALUIn2;
		end
		4'b0011 : // SLL
		begin
			ALUOut <= reg_dout1 << shamt;
		end
		4'b0100 : // Sub
		begin
			ALUOut <= reg_dout1 - ALUIn2;
			Zero <= (ALUOut == 32'b0) ? 1 : 0;
		end
		default :
			;
		endcase
	end

endmodule
