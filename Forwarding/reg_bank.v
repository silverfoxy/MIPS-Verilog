// Simple Register file model by Ali Jahanian
// Students should not used reg_bank as a descrete moule. It is recommended to use the internal part of the code inside mips_core module.
// In this model, only writing to register bank is synchronized with clock and reading  is not synchonized with clock.
// For any problem, contact jahanian@sbu.ac.ir
module regfile(clk, raddr1, dout1, raddr2, dout2, wr, waddr, din, nrst, ram1, ram2, ram3);
	input 			clk;
	input 			wr;
	input	[4:0] 	raddr1, raddr2, waddr;
	input	[31:0] 	din;
	input nrst;
	output	reg[31:0] 	dout1, dout2;
	output wire[31:0] ram1;
	output wire[31:0] ram2;
	output wire[31:0] ram3;
	reg [31:0] ram [0:31];
	assign ram1 = ram[5'b00001];
	assign ram2 = ram[5'b00010];
	assign ram3 = ram[5'b00011];
	/*always @(posedge nrst)
	begin
		ram[5'b00001] = 32'b1;
		ram[5'b00010] = 32'b10;
		ram[5'b00011] = 32'b11;
		ram[5'b00100] = 32'b100;
		ram[5'b00101] = 32'b101;
		ram[5'b00110] = 32'b110;
		ram[5'b00111] = 32'b111;
		ram[5'b01000] = 32'b1000;
		ram[5'b01001] = 32'b1001;
		ram[5'b01010] = 32'b1010;
	end*/
	// Start of internal part
	always @(posedge clk)
	begin
	
	//ram[5'b00001] = 32'd3;
	//ram[5'b00010] = 32'd5;
		if (wr == 1'b1)
		begin
			ram[waddr] = din;
		end
	end
	always @(negedge clk)
	begin
		dout1 <= (raddr1 == 5'b0) ? 32'b0 : ram[raddr1];
		dout2 <= (raddr2 == 5'b0) ? 32'b0 : ram[raddr2];
	end
	// End  of internal part
	
endmodule
