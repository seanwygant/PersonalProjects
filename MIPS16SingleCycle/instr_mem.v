`timescale 1ns / 1ps
// Verilog code for instruction memory
 module instr_mem // a synthesisable rom implementation  
 (  
      input [15:0] pc,  
      output wire [15:0] instruction  
 );  
      wire [3 : 0] rom_addr = pc[4 : 1];  
      /*
      Nested for loop
      for (i=0, i<64, ++i) begin
        k = 0;
        for (j=0, j<64, ++j) begin
            k = k + j;
        end
      LED = i;
      end
      */
      reg [15:0] rom[15:0];  
      initial  
      begin  
                rom[0] = 16'b1000001010000000; //LW $5 0($0) Set Register 5 to 0
                rom[1] = 16'b0011010100111111; //SLTI $2 $5 10 Set register 2 to 1 if register 5 is less than 63 
                rom[2] = 16'b1000000110000000; //LW $3 0($0) Set Register 3 to 0
                rom[3] = 16'b1000001000000000; //LW $4 0($0) Set Register 4 to 0
                rom[4] = 16'b1100100000001000; //BEQ $2 $0 (branch to ROM13) 
                rom[5] = 16'b0010110010111111; //SLTI $1 $3 50Set register 1 to 1 if register 3 is less than 63 
                rom[6] = 16'b1100010000000011; //BEQ $1 $0 (branch to ROM10) 
                rom[7] = 16'b0001000111000000; //ADD $4 $4 $3 (Register 4 counts to 2016)
                rom[8] = 16'b1110110110000001; //ADDi $3 $3 1 (add 1 to register 3 and store in register 3)
                rom[9] = 16'b1100000001111011; //BEQ $0 $0 (branch to ROM5)
                rom[10] = 16'b1111011010000001;//ADDi $5 $5 1 (add 1 to register 5 and store in register 5)  
                rom[11] = 16'b1100000001110101;//BEQ $0 $0 (branch to ROM1)  
                rom[12] = 16'b0000000000000000;  
                rom[13] = 16'b0000000000000000;  
                rom[14] = 16'b0000000000000000;  
                rom[15] = 16'b0000000000000000;  
      end  
      assign instruction = (pc[15:0] < 32 )? rom[rom_addr[3:0]] : 16'd0;  
 endmodule  






