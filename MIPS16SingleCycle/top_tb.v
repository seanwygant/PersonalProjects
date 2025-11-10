`timescale 1ns / 1ps

//------------------------------------------------------------
// Testbench for Nexys A7-100T top module
//------------------------------------------------------------
module top_tb;

    // Board-level signals
    reg clk_100mhz = 0;
    reg btn_reset  = 1;
    reg [2:0] SW;
    wire [15:0] LED;

    // Generate 100 MHz clock (10 ns period)
    always #5 clk_100mhz = ~clk_100mhz;

    // Instantiate the DUT (Device Under Test)
    top dut (
        .clk_100mhz(clk_100mhz),
        .btn_reset(btn_reset),
        .LED(LED),
        .SW(SW)
    );

    // VCD waveform dump for simulation viewing
    initial begin
        $dumpfile("top_tb.vcd");
        $dumpvars(0, top_tb);
    end

    // Display LED values whenever they change
    initial begin
        $display("time(ns)\tSW\tLED");
        $monitor("%8t\t%b\t%h", $time, SW, LED);
    end

    // Stimulus
    initial begin
        // Hold reset active for a few cycles
        repeat (10) @(posedge clk_100mhz);
        btn_reset = 0;

        // Wait some time for CPU init
        repeat (50) @(posedge clk_100mhz);

        // Select reg5 output on LEDs
        SW = 3'b101;  // reg5
        repeat (200) @(posedge clk_100mhz);

        // Select reg3 output
        SW = 3'b011;  // reg3
        repeat (200) @(posedge clk_100mhz);

        // Select reg4 output
        SW = 3'b100;  // reg4
        repeat (200) @(posedge clk_100mhz);

        // End simulation
        $finish;
    end

endmodule
