`timescale 1ns / 1ns

module wrapper_tb();

`define clk 10

	logic clk_i = 1'b0;
	logic [17:0] SW;
	logic KEY;
	logic [16:0] LEDR;
	logic [7:0] LEDG;
	logic [6:0] HEX0;
	logic [6:0] HEX1;
	logic [6:0] HEX2;
	logic [6:0] HEX3;
	logic [6:0] HEX4;
	logic [6:0] HEX5;
	logic [6:0] HEX6;
	logic [6:0] HEX7;
	logic LCD_EN;
	logic LCD_RW;
	logic LCD_RS;
	logic LCD_ON;
	logic [7:0] LCD_DATA;

	
	wrapper dut(
		.CLOCK_50(clk_i),
		.SW(SW),
		.KEY(KEY),
		.LEDR(LEDR),
		.LEDG(LEDG),
		.HEX0(HEX0),
		.HEX1(HEX1),
		.HEX2(HEX2),
		.HEX3(HEX3),
		.HEX4(HEX4),
		.HEX5(HEX5),
		.HEX6(HEX6),
		.HEX7(HEX7),
		.LCD_EN(LCD_EN),
		.LCD_RW(LCD_RW),
		.LCD_RS(LCD_RS),
		.LCD_ON(LCD_ON),
		.LCD_DATA(LCD_DATA)
		);
	
	initial begin
		$dumpfile("Risc-v_processor.vcd");
		$dumpvars(0);
	end
	
	initial begin
		//SW[16] <= 1'b0;
		SW[17] <= 1'b0;
		#150;
		SW[16] <= 1'b0;
		
		SW[17] <= 1'b1;
		#100;
		
		SW[15:0] = 16'b0100_0101_0101_1011;
		#10000;
		
		SW[15:0] = 16'b1110_0001_0001_1111;
		#20000;
		
		
		
		$finish;
	end
	
	always #(`clk) clk_i = ~clk_i;

endmodule

