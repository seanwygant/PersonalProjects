`timescale 1ns / 1ps
//fpga4student.com: FPGA projects, Verilog projects, VHDL projects
// Verilog project: Verilog code for 16-bit MIPS Processor
// Testbench Verilog code for 16 bit single cycle MIPS CPU  
 module tb_mips16;  
      // Inputs  
      reg clk;  
      reg reset;  
      // Outputs  
      wire [15:0] pc_out;  
      wire [15:0] alu_result;//,reg3,reg4;  
      // Instantiate the Unit Under Test (UUT)
      wire [15:0] reg2,reg3,reg4,reg5;  
      mips_16 uut (  
           .clk(clk),   
           .reset(reset),   
           .pc_out(pc_out),   
           .alu_result(alu_result),  
           .reg3(reg3),  
           .reg4(reg4),
           .reg2(reg2),  
           .reg5(reg5)    
      );  
      initial begin  
           clk = 0;  
           forever #10 clk = ~clk;  
      end  
      initial begin  
           // Initialize Inputs  
           $monitor ("register 3=%d, register 4=%d", reg3,reg4);
           $monitor ("register 2=%d, register 5=%d", reg2,reg5);  
           reset = 1;  
           // Wait 100 ns for global reset to finish  
           #100;  
     reset = 0;  
           // Add stimulus here  
      end  
 endmodule  