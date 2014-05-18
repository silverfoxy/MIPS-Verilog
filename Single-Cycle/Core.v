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
	 input [2:0] R1,
	 output wire[7:0] R2
	 /*
	 ,
	 output[31:0] instr,
    //output reg[31:0] iaddr,
    output daddr,
    output dout,
    output wr, 
	 output pc, 
	 output reg_din,
	 output reg_raddr1,
	 output reg_dout1,
	 output reg_raddr2,
	 output reg_dout2,
	 output wr_reg,
	 output reg_wr_addr,
	 output ALUOut,
	 output ALUOp,
	 output ALUSrc,
	 output ALUIn2,
	 output MemToReg,
	 output RegDst,
	 output PCSrc,
	 output wire[31:0] ram1,
	 output wire[31:0] ram2,
	 output wire[31:0] ram3,
	 output Zero,
	 output Branch,
	 output Jump,
	 output HI,
	 output LO
	 */
	 );

	 reg[31:0] ALUOut;
	 wire[31:0] instr;
    reg[5:0] daddr;
    wire[31:0] dout;
    reg[3:0] wr;
	 reg[31:0] pc; 
	 wire[31:0] reg_din;
	 wire[4:0] reg_raddr1;
	 wire[31:0] reg_dout1;
	 wire[4:0] reg_raddr2;
	 wire[31:0] reg_dout2;
	 reg wr_reg;
	 wire[4:0] reg_wr_addr;
	 reg[3:0] ALUOp;
	 reg ALUSrc;
	 wire[31:0] ALUIn2;
	 reg MemToReg;
	 reg RegDst;
	 wire PCSrc;
	 wire Zero;
	 reg Branch;
	 reg Jump;
	 

   //Wires & Regs definitions
	//wire[31:0] instr; ->moved to module inputs for debug purposes
	//reg[31:0] ALUOut;
	//reg[3:0] ALUOp;
	//reg ALUSrc;
	//reg Carry;
	//reg RegDst;
	//reg MemToReg;
	//reg[31:0] ALUIn2;
	//wire[7:0] din[0:3];
	//reg[7:0] pc = 8'b00000000;
	//reg[31:0] immediate_extended;
	wire[31:0] next_pc;
	//reg[31:0] j_pc;
	//reg[31:0] shifted_pc;
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
					R1,
					R2,
					nrst
					/*ram1,
					ram2,
					ram3*/
					);
	
	
	//Memory instantiations
	//wire[31:0] dina; //not used since we don't write to imem
	//wire[31:0] tmp_instr;
	IMem imem (
				  nclk, // input clka
				  1'b0, // input [0 : 0] wea
				  pc[7:2], // input [5 : 0] addra
				  32'b0, // input [31 : 0] dina
				  instr // output [31 : 0] douta
					);
	DMem dmem_0 (
					  nclk, // input clka
					  wr[0], // input [0 : 0] wea
					  daddr[5:0], // input [5 : 0] addra
					  reg_dout2[7:0], // input [7 : 0] dina
					  dout[7:0] // output [7 : 0] douta
					);
	DMem dmem_1 (
					  nclk, // input clka
					  wr[1], // input [0 : 0] wea
					  daddr[5:0], // input [5 : 0] addra
					  reg_dout2[15:8], // input [7 : 0] dina
					  dout[15:8] // output [7 : 0] douta
					);
	DMem dmem_2 (
					  nclk, // input clka
					  wr[2], // input [0 : 0] wea
					  daddr[5:0], // input [5 : 0] addra
					  reg_dout2[23:16], // input [7 : 0] dina
					  dout[23:16] // output [7 : 0] douta
					);
	DMem dmem_3 (
					  nclk, // input clka
					  wr[3], // input [0 : 0] wea
					  daddr[5:0], // input [5 : 0] addra
					  reg_dout2[31:24], // input [7 : 0] dina
					  dout[31:24] // output [7 : 0] douta
					);	
	wire[31:0] JDest;
	reg JR;
	//PCSrc Mux & Jump
		//4'b0000 because our memory real pc is 8 bits and 4 MSBs are always 0 in our case
		assign JDest = JR ? (reg_dout1 << 2) : {4'b0000, instr[25:0], 2'b00};
		//j_pc <= Jump ? JDest : (pc + 32'b100);
		//shifted_pc <= (({{16{instr[15]}}, instr[15:0]}) << 2) + (pc + 32'b100);
		assign PCSrc = Branch & Zero;
		assign next_pc = PCSrc ? ((({{16{instr[15]}}, instr[15:0]}) << 2) + (pc + 32'b100)) : (Jump ? JDest : (pc + 32'b100));
	//RegDst Mux
		assign reg_wr_addr = RegDst ? instr[15:11] : instr[20:16];
		assign reg_raddr1 = instr[25:21];
		assign reg_raddr2 = instr[20:16];
	//ALUSrc Mux
		assign ALUIn2 = ALUSrc ? {{16{instr[15]}}, instr[15:0]} : reg_dout2; //sign extended
	//MemToReg Mux
		assign reg_din = MemToReg ? dout : ALUOut;				
		
		assign Zero = (ALUOut == 32'b0) ? 1 : 0;
	//PC
	always @(posedge clk or negedge nrst)
	begin
		if (~nrst)
		begin
			pc = 32'b0;
			//ALUOut <= 32'b0;
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
				11'b00000100110: // XOR
					begin
						ALUOp = 4'b0111;
					end
				11'b00000011010, 11'b00000011011 : // Div, Divu
				begin
					ALUOp = 4'b0101;
				end
				11'b00000011000, 11'b00000011001 : // Mult, Multu
				begin
					ALUOp = 4'b0110;
				end
				default :
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
		6'b001101 : //ORI
			ALUOp = 4'b0010;
		6'b001110 : //XORI
			ALUOp = 4'b0111;
		6'b001100 : //ANDI
			ALUOp = 4'b0001;
		6'b001000 , 6'b001001 :
			ALUOp = 4'b0000; // ADDI
		6'b00100, 6'b000001, 6'b000111, 6'b000110, 6'b000001, 6'b000101 : // BEQ, BGEZ, BGEZAL, BGTZ, BLEZ, BLTZ, BLTZAL, BNE
			ALUOp = 4'b0100; // (uses Sub)			
		6'b100000 :  //  	LB
			ALUOp = 4'b0000;
		6'b001111 :  //  	LUI
			ALUOp = 4'b0000;
		6'b100011 :  //	LW
			ALUOp = 4'b0000;
		6'b101000 :  //	SB
			ALUOp = 4'b0000;
		6'b101011 :  //  	SW
			ALUOp = 4'b0000;
		/*6'b000011 : //JAL (Save ret addr in $31) Needs Fix
		begin
			//reg_din <= pc + 3'b100;
			//reg_wr_addr = 5'b11111;
			wr_reg <= 1;
		end*/
		default :
			//6'b000010 : // Jump
			//Nothing (we don't need the alu)
			;
		endcase
	end
	//Control
	always @(posedge clk)
	begin
		if (instr == 32'b0) //NOP
		begin
			wr_reg <= 0;
			wr <= 4'b0000;
			Branch <= 0;
			Jump <= 0;
			Branch <= 0;
		end
		else
		begin
			case (instr[31:26])
			6'b000000 :
			begin
				//func
				case (instr[10:0])
					11'b00000100000, 11'b00000100001, 11'b00000100010, 00000100011, 11'b00000100100, 11'b00000100101, 11'b00000100110 : //Add, Addu, Sub, Subu , And, Or, XOR
					/*(Note: ALL arithmetic immediate values are sign-extended. After that, they are handled as
					  signed or unsigned 32 bit numbers, depending upon the instruction. The only difference between
					  signed and unsigned instructions is that signed instructions can generate an overflow exception
					  and unsigned instructions can not. )
					*/
					begin
						RegDst <= 1;
						ALUSrc <= 0;
						//reg_raddr1 <= instr[25:21];
						//reg_raddr2 <= instr[20:16];
						//reg_wr_addr <<= instr[15:11];
						wr_reg <= 1;
						MemToReg <= 0;
						Branch <= 0;
						Jump <= 0;
					end
					11'b00000000000 :
					case(instr[5:0])
						6'b000000 : //SLL
						begin
							RegDst <= 1;
							ALUSrc <= 0;
							//reg_raddr1 <= instr[20:16];
							//reg_wr_addr <= instr[15:11];
							wr_reg <= 1;
							MemToReg <= 0;
							Branch <= 0;
							Jump <= 0;
							shamt <= instr[10:6];
						end
					endcase
					11'b00000001000 : //JR
						if (instr[20:0] == 21'b1000)
						begin
							//reg_raddr1 <= instr[25:21];
							wr_reg <= 0;
							wr <= 4'b0000;
							Branch <= 0;
							Jump <= 1;
							JR <= 1;
						end
					default:
						;
				endcase
			end
			6'b001000, 6'b001001, 6'b001100, 6'b001101, 6'b001101 : //Addi, Addiu, Andi, Ori, Xori
			begin
				RegDst <= 0;
				ALUSrc <= 1; //immediate
				//reg_wr_addr <= instr[20:16];
				wr_reg <= 1;
				MemToReg <= 0;
				Branch <= 0;
				Jump <= 0;
			end
			//======================= MEMORY ==========================
			6'b100000 :  //  	LB
				begin
					RegDst <= 0;
					ALUSrc <= 1; // immediate
					wr[0] <= 0;
					wr[1] <= 0;
					wr[2] <= 0;
					wr[3] <= 0;
					daddr[5:0] <= ALUOut[5:0];
					//reg_wr_addr <= instr[20:16];
					wr_reg <= 1;
					MemToReg <= 1;
					Branch <= 0;
					Jump <= 0;
				end
			6'b100011 :  //	LW
				begin
					RegDst <= 0;
					ALUSrc <= 1; //if i=2 
					wr[0] <= 0;
					wr[1] <= 0;
					wr[2] <= 0;
					wr[3] <= 0;
					daddr[5:0] <= ALUOut[5:0];
					//reg_wr_addr <= instr[20:16];
					wr_reg <= 1;
					MemToReg <= 1;
					Branch <= 0;
					Jump <= 0;
				end
			6'b101000 :  //	SB
				begin
					ALUSrc <= 1; // immediate
					wr[0] <= 1;
					wr[1] <= 0;
					wr[2] <= 0;
					wr[3] <= 0;
					//reg_raddr2 <= instr[20:16];
					daddr[5:0] <= ALUOut[5:0];
					wr_reg <= 0;
					MemToReg <= 0;
					Branch <= 0;
					Jump <= 0;
				end
			6'b101011 :  //  	SW
				begin
					ALUSrc <= 1; // immediate
					wr[0] <= 1;
					wr[1] <= 1;
					wr[2] <= 1;
					wr[3] <= 1;
					//reg_raddr2 <= instr[20:16];
					daddr[5:0] <= ALUOut[5:0];
					wr_reg <= 0;
					MemToReg <= 0;
					Branch <= 0;
					Jump <= 0;
				end
			6'b000010 : // Jump
			begin
				wr_reg <= 0;
				wr <= 4'b0000;
				Branch <= 0;
				Jump <= 1;
				JR <= 0;
			end
			/*6'b000011 : // JAL
			begin
				wr_reg <= 0;
				wr <= 4'b0000;
				Branch <= 0;
				Jump <= 1;
				JR <= 0;
			end*/
			default :
				;
			endcase
		end
	end
	//ALU
	//reg[32:0] tmp; //used in add, to compute carry
	always @(ALUOp, reg_dout1, ALUIn2, shamt)
	begin
		/*
		0000 : add/i/ui/u
		0001 : and/i
		0010 : or
		0011 : sll
		0100 : Sub/u
		0101 : Div
		0110 : Mult
		0111 : xor/i
		 : sllv
		 : sra
		 : srl
		 : srlv
		*/
		case (ALUOp)
		4'b0000 : //Add
		begin
			ALUOut <= ALUIn2 + reg_dout1;
			//tmp <= ALUIn2 + reg_dout1;
			//ALUOut <= tmp[31:0];
			//Carry = tmp[32];
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
			ALUOut <= ALUIn2 << shamt;
		end
		4'b0100 : // Sub
		begin
			ALUOut <= reg_dout1 - ALUIn2;
		end
		/*4'b0101 : // Div, Divu
		begin
			HI <= reg_dout1 / ALUIn2;
			LO <= reg_dout1 % ALUIn2;
		end*/
		/*4'b0110 : // Mult, Multu
		begin
			{HI, LO} <= reg_dout1 * ALUIn2;
		end*/
		4'b0111 : // Xor, Xori
		begin
			ALUOut <= reg_dout1 ^ ALUIn2;
		end
		default :
			;
		endcase
	end

endmodule
