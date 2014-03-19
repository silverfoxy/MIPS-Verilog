// Simple Register file model by Ali Jahanian
// Students should not used reg_bank as a descrete moule. It is recommended to use the internal part of the code inside mips_core module.
// In this model, only writing to register bank is synchronized with clock and reading  is not synchonized with clock.
// For any problem, contact jahanian@sbu.ac.ir
module regfile(clk, raddr1, dout1, raddr2, dout2, wr, waddr, din);
	input 			clk;
	input 			wr;
	input	[4:0] 	raddr1, raddr2, waddr;
	input	[31:0] 	din;
	output	[31:0] 	dout1, dout2;
	
	reg [31:0] ram [0:31];
	
	// Start of internal part
	always @(posedge clk)
	begin
		if (wr == 1'b1)
			ram[waddr] = din;
	end
	
	assign dout1 = ram[raddr1];
	assign dout2 = ram[raddr2];
	// End  of internal part
	
endmodule
