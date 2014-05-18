MIPS-Verilog
============

mips r3000 processor verilog code to be synthesized on Spartan 3E FPGA.

<h2>This project consists of 4 Parts :</h2>
<ul>
  <li>Single Cycle Processor</li>
  <li>Multi Cycle Pipelined Processor (Without Forwarding)</li>
  <li>Hazard Free Multi Cycle Processor (With Forwarding)</li>
  <li>.coe TestCases</li>
</ul>

In order to run this project, you might need to regenerate memories for Instruction and Data Memory using IPCore in Xilinx. You can then load the coe files in your Instruction memory.

<h3>Single Cycle Processor</h3>
This part lacks unaligned load in memory and lh sh instructions.
<h3>Multi Cycle Processor</h3>
This part lacks jump instructions and lh, sh and unaligned load.
<h3>Multi Cycle with Forwarding Processor</h3>
This part lacks jump instructions and lh, sh and unaligned load.
