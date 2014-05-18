// Simple Register file model by Ali Jahanian
// Students should not used reg_bank as a descrete moule. It is recommended to use the internal part of the code inside mips_core module.
// In this model, only writing to register bank is synchronized with clock and reading  is not synchonized with clock.
// For any problem, contact jahanian@sbu.ac.ir
module regfile(clk, raddr1, dout1, raddr2, dout2, wr, waddr, din, R1, R2, nrst);//, ram1, ram2, ram3);
	input 			clk;
	input 			wr;
	input	[4:0] 	raddr1, raddr2, waddr;
	input	[31:0] 	din;
	output	[31:0] 	dout1, dout2;
	output [7:0] R2;
	input [2:0] R1;
	input nrst;
	/*output wire[31:0] ram1;
	output wire[31:0] ram2;
	output wire[31:0] ram3;*/
	//assign ram1 = ram[5'b00001];
	//assign ram2 = ram[5'b00010];
	//assign ram3 = ram[5'b00011];
	reg [31:0] ram [0:31];
	
	always @(posedge clk or negedge nrst)
	begin
		if(~nrst)
		begin
			ram[5'b00001] = {29'b0, R1};
		end
		else
		begin
			if (wr == 1'b1)
			begin
				ram[waddr] = din;
			end
		end
	end
	// Start of internal part
	always @(posedge clk)
	begin
		
	//ram[5'b00001] = 32'd3;
	//ram[5'b00010] = 32'd5;

	end
	assign dout1 = (raddr1 == 5'b0) ? 32'b0 : ram[raddr1];
	assign dout2 = (raddr2 == 5'b0) ? 32'b0 : ram[raddr2];
	assign R2 = ram[4'b0010][7:0];
	// End  of internal part
	
endmodule
