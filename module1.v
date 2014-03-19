`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:37:53 03/15/2014 
// Design Name: 
// Module Name:    module1 
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
module module1(
    input clk,
    input wea,
    input[5:0] addra,
    input[31:0] dina,
    output[31:0] douta
    );
//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
SPRAM your_instance_name (
  .clka(clka), // input clka
  .wea(wea), // input [0 : 0] wea
  .addra(addra), // input [5 : 0] addra
  .dina(dina), // input [31 : 0] dina
  .douta(douta) // output [31 : 0] douta
);
// INST_TAG_END ------ End INSTANTIATION Template ---------

endmodule
