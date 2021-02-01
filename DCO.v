`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2020 17:18:07
// Design Name: 
// Module Name: DCO
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DCO
	#(parameter sel_len = 8)
	(
	input rst,
	input clk,		// Must receive the PLL's generated clock signal
	input enable,
	input [sel_len:0] sel,
	output out
	);

	// Reset synchronizer 
	reg [1:0] reset_reg;
	wire reset_sync;

	always @(negedge clk)
		begin
			reset_reg <= {reset_reg[0], rst};
		end

	assign reset_sync = reset_reg[1];


	// Enable Logic

	wire enable_dcro;

	assign enable_dcro = enable | rst;


	// Circuit instantiation

	wire [sel_len-1:0] sel_intr;

	DCRO_ctrl DCRO_ctrl_0(
		.rst(reset_sync),
		.clk(clk),
		.mode(1'b1),
		.sel_in(sel),
		.sel_out(sel_intr)
		);

	DCRO DCRO_0(
		.rst(reset_sync),
		.enable(enable_dcro),
		.sel(sel_intr),
		.out(out)
		);




endmodule
