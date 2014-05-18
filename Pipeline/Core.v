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
	 output instr,
	 output IFID_instr,
	 output IDEX_instr,
	 output EXMEM_instr,
	 output MEMWB_instr,
    //output reg[31:0] iaddr,
    output daddr,
    output dout,
	 output MEMWB_dout,
    output wr, 
	 output EXMEM_wr,
	 output pc,
	 output IFID_pc, 
	 output IDEX_pc, 
	 output EXMEM_pc, 
	 output reg_din,
	 output reg_raddr1,
	 output reg_dout1,
	 output IDEX_reg_dout1,
	 output reg_raddr2,
	 output reg_dout2,
	 output IDEX_reg_dout2,
	 output EXMEM_reg_dout2,
	 output wr_reg,
	 output EXMEM_wr_reg,
	 output MEMWB_wr_reg,
	 output reg_wr_addr,
	 output ALUOut,
	 output EXMEM_ALUOut,
	 output MEMWB_ALUOut,
	 output ALUOp,
	 output ALUSrc,
	 output ALUIn2,
	 output MemToReg,
	 output EXMEM_MemToReg,
	 output MEMWB_MemToReg,
	 output RegDst,
	 output EXMEM_RegDst,
	 output MEMWB_RegDst,
	 output PCSrc,
	 output wire[31:0] ram1,
	 output wire[31:0] ram2,
	 output wire[31:0] ram3,
	 output Zero,
	 output Branch,
	 output Jump
	 );

	
	 wire[31:0] instr;
	 reg[31:0] IFID_instr;
	 reg[31:0] IDEX_instr;
	 reg[31:0] EXMEM_instr;
	 reg[31:0] MEMWB_instr;
    reg[5:0] daddr;
    wire[31:0] dout;
	 reg[31:0] MEMWB_dout;
    reg[3:0] wr;
	 reg[3:0] EXMEM_wr;
	 reg[31:0] pc; 
	 reg[31:0] IFID_pc; 
	 reg[31:0] IDEX_pc; 
	 reg[31:0] EXMEM_pc; 
	 wire[31:0] reg_din;
	 reg[4:0] reg_raddr1;
	 wire[31:0] reg_dout1;
	 reg[31:0] IDEX_reg_dout1;
	 reg[4:0] reg_raddr2;
	 wire[31:0] reg_dout2;
	 reg[31:0] IDEX_reg_dout2;
	 reg[31:0] EXMEM_reg_dout2;
	 reg wr_reg;
	 reg EXMEM_wr_reg;
	 reg MEMWB_wr_reg;
	 reg[4:0] reg_wr_addr;
	 reg[31:0] ALUOut;
	 reg[31:0] EXMEM_ALUOut;
	 reg[31:0] MEMWB_ALUOut;
	 reg[3:0] ALUOp;
	 reg ALUSrc;
	 reg[31:0] ALUIn2;
	 reg MemToReg;
	 reg EXMEM_MemToReg;
	 reg MEMWB_MemToReg;
	 reg RegDst;
	 reg EXMEM_RegDst;
	 reg MEMWB_RegDst;
	 reg PCSrc;
	 reg Zero;
	 reg Branch;
	 reg Jump;
	 

   //Wires & Regs definitions
	//wire[31:0] instr; ->moved to module inputs for debug purposes
	//reg[31:0] ALUOut;
	//reg[3:0] ALUOp;
	//reg ALUSrc;
	reg Carry;
	//reg RegDst;
	//reg MemToReg;
	//reg[31:0] ALUIn2;
	wire[7:0] din[0:3];
	//reg[7:0] pc = 8'b00000000;
	//reg[31:0] immediate_extended;
	reg[31:0] next_pc;
	reg[31:0] j_pc;
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
					clk,
					reg_raddr1,
					reg_dout1,
					reg_raddr2,
					reg_dout2,
					MEMWB_wr_reg,
					reg_wr_addr,
					reg_din,
					ram1,
					ram2,
					ram3
					);
	
	
	//Memory instantiations
	wire[31:0] dina; //not used since we don't write to imem
	//wire[31:0] tmp_instr;
	wire z;
	assign z = 0;
	IMem imem (
				  nclk, // input clka
				  z, // input [0 : 0] wea
				  pc[7:2], // input [5 : 0] addra
				  dina, // input [31 : 0] dina
				  instr // output [31 : 0] douta
					);
	DMem dmem_0 (
					  nclk, // input clka
					  EXMEM_wr[0], // input [0 : 0] wea
					  daddr[5:0], // input [5 : 0] addra
					  EXMEM_reg_dout2[7:0], // input [7 : 0] dina
					  dout[7:0] // output [7 : 0] douta
					);
	DMem dmem_1 (
					  nclk, // input clka
					  EXMEM_wr[1], // input [0 : 0] wea
					  daddr[5:0], // input [5 : 0] addra
					  EXMEM_reg_dout2[15:8], // input [7 : 0] dina
					  dout[15:8] // output [7 : 0] douta
					);
	DMem dmem_2 (
					  nclk, // input clka
					  EXMEM_wr[2], // input [0 : 0] wea
					  daddr[5:0], // input [5 : 0] addra
					  EXMEM_reg_dout2[23:16], // input [7 : 0] dina
					  dout[23:16] // output [7 : 0] douta
					);
	DMem dmem_3 (
					  nclk, // input clka
					  EXMEM_wr[3], // input [0 : 0] wea
					  daddr[5:0], // input [5 : 0] addra
					  EXMEM_reg_dout2[31:24], // input [7 : 0] dina
					  dout[31:24] // output [7 : 0] douta
					);	
	reg[31:0] JDest;
	reg JR;
	always @*
	begin
	//PCSrc Mux & Jump
		//4'b0000 because our memory real pc is 8 bits and 4 MSBs are always 0 in our case
		JDest <= JR ? (reg_dout1 << 2) : {4'b0000, instr[25:0], 2'b00};
		j_pc <= Jump ? JDest : pc + 32'b100;
		shifted_pc <= (({{16{instr[15]}}, instr[15:0]}) << 2) + (pc + 32'b100);
		PCSrc <= Branch & Zero;
		next_pc <= PCSrc ? shifted_pc : j_pc;
	//RegDst Mux
		reg_wr_addr <= MEMWB_RegDst ? MEMWB_instr[15:11] : MEMWB_instr[20:16];
		reg_raddr1 <= IFID_instr[25:21];
		reg_raddr2 <= IFID_instr[20:16];
	//ALUSrc Mux
		ALUIn2 <= ALUSrc ? {{16{IDEX_instr[15]}}, IDEX_instr[15:0]} : IDEX_reg_dout2; //sign extended
	end
	//MemToReg Mux
		assign reg_din = MEMWB_MemToReg ? MEMWB_dout : MEMWB_ALUOut;				
	//PC
	always @(posedge clk)
	begin
		if (~nrst)
		begin
			 pc = 32'b0;
			 Branch <= 0;
			 Jump <= 0;
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
		if (IFID_instr[31:26] == 6'b001000)
			ALUOp = 4'b0000;
		case (IDEX_instr[31:26])
		6'b000000 :
		begin
			//func
			case (IFID_instr[10:0])
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
					/*case(IFID_instr[5:0])
							6'b000000 : //SLL
							begin
								ALUOp = 4'b0011;
							end
					endcase*/
				end
			endcase
		end
		6'b001101 : //ORI
			ALUOp = 4'b0010;
		6'b001110 : //XORI
			ALUOp = 4'b0111;
		6'b001100 : //ANDI
			ALUOp = 4'b0000;
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
		if (IFID_instr == 32'b0) //NOP
		begin
			wr_reg <= 0;
			wr <= 4'b0000;
			Branch <= 0;
			Jump <= 0;
			Branch <= 0;
		end
		else
		begin
			case (IFID_instr[31:26])
			6'b000000 :
			begin
				//func
				case (IFID_instr[10:0])
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
					11'b00000000000 : //???????????????
					case(IFID_instr[5:0])
						6'b000000 : //SLL
						begin
							RegDst <= 1;
							ALUSrc <= 0;
							wr_reg <= 1;
							MemToReg <= 0;
							Branch <= 0;
							Jump <= 0;
							shamt <= IDEX_instr[10:6];
						end
					endcase
					11'b00000001000 : //JR
						if (IFID_instr[20:0] == 21'b1000)
						begin
							reg_raddr1 <= instr[25:21];
							wr_reg <= 0;
							wr <= 4'b0000;
							Branch <= 0;
							Jump <= 1;
							//JR <= 1;
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
					//daddr[5:0] <= ALUOut[5:0];
					//reg_wr_addr <= instr[20:16];
					wr_reg <= 1;
					MemToReg <= 1;
					PCSrc <= 0;
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
					//daddr[5:0] <= ALUOut[5:0];
					//reg_wr_addr <= instr[20:16];
					wr_reg <= 1;
					MemToReg <= 1;
					PCSrc <= 0;
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
					reg_raddr2 <= IFID_instr[20:16];
					wr_reg <= 0;
					MemToReg <= 0;
					PCSrc <= 0;
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
					reg_raddr2 <= IFID_instr[20:16];
					wr_reg <= 0;
					MemToReg <= 0;
					PCSrc <= 0;
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
	//Pipeline
	always @(posedge clk)
	begin
		if (nrst)
		begin
			MEMWB_instr <= EXMEM_instr;
			EXMEM_instr <= IDEX_instr;
			IDEX_instr <= IFID_instr;
			IFID_instr <= instr;
		
			EXMEM_pc <= IDEX_pc;
			IDEX_pc <= IFID_pc;
			IFID_pc <= pc;
			
			MEMWB_ALUOut <= EXMEM_ALUOut;
			EXMEM_ALUOut <= ALUOut;
			
			IDEX_reg_dout1 <= reg_dout1;
			EXMEM_reg_dout2 <= IDEX_reg_dout2;
			IDEX_reg_dout2 <= reg_dout2;
			
			MEMWB_wr_reg <= EXMEM_wr_reg;
			EXMEM_wr_reg <= wr_reg;
			
			MEMWB_MemToReg <= EXMEM_MemToReg;
			EXMEM_MemToReg <= MemToReg;
			
			MEMWB_RegDst <= EXMEM_RegDst;
			EXMEM_RegDst <= RegDst;
			
			daddr[5:0] <= ALUOut[5:0];
			
			MEMWB_dout <= dout;
			
			EXMEM_wr <= wr;
		end
	end
	//ALU
	//reg[32:0] tmp; //used in add, to compute carry
	always @(*)
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
			ALUOut <= ALUIn2 + IDEX_reg_dout1;
			//tmp <= ALUIn2 + reg_dout1;
			//ALUOut <= tmp[31:0];
			//Carry = tmp[32];
			//Set Carry flag if signed!
		end
		4'b0001 : //And
		begin
			ALUOut <= IDEX_reg_dout1 & ALUIn2;
		end
		4'b0010 : // OR
		begin
			ALUOut <= IDEX_reg_dout1 | ALUIn2;
		end
		4'b0011 : // SLL
		begin
			ALUOut <= ALUIn2 << shamt;
		end
		4'b0100 : // Sub
		begin
			ALUOut <= IDEX_reg_dout1 - ALUIn2;
			Zero <= (ALUOut == 32'b0) ? 1 : 0;
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
			ALUOut <= IDEX_reg_dout1 ^ ALUIn2;
		end
		default :
			;
		endcase
	end

endmodule
