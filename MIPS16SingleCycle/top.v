`timescale 1ns / 1ps
module top(
    input  wire        clk_100mhz,
    input  wire        btn_reset,
    input  wire [2:0]  SW,
    output reg  [15:0] LED
);

    wire clk_100hz;
    clock_div_100hz u_clkdiv (
        .clk_in   (clk_100mhz),
        .clk_100hz(clk_100hz)
    );

    wire cpu_reset = ~btn_reset;

    wire [15:0] pc_out, alu_result, reg2, reg3, reg4, reg5;

    mips_16 cpu (
        .clk        (clk_100hz),
        .reset      (cpu_reset),
        .pc_out     (pc_out),
        .alu_result (alu_result),
        .reg3       (reg3),
        .reg4       (reg4),
        .reg5       (reg5),
        .reg2       (reg2)
    );

    always @(*) begin
        case (SW)
            3'b000: LED = pc_out;
            3'b001: LED = alu_result;
            3'b010: LED = reg2;
            3'b011: LED = reg3;
            3'b100: LED = reg4;
            3'b101: LED = reg5;
            default: LED = 16'hF626;
        endcase
    end
endmodule

module clock_div_100hz(
    input  wire clk_in,
    output reg  clk_100hz = 1'b0
);
    localparam integer HALF_CYCLES = 5000;
    localparam integer CNT_MAX = HALF_CYCLES - 1;
    reg [18:0] cnt = 19'd0;

    always @(posedge clk_in) begin
        if (cnt == CNT_MAX) begin
            cnt <= 19'd0;
            clk_100hz <= ~clk_100hz;
        end else begin
            cnt <= cnt + 19'd1;
        end
    end
endmodule
