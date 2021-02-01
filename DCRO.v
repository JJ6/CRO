`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.03.2020 14:55:56
// Design Name: 
// Module Name: DCRO
// Project Name: 
// Target Devices: Nexys 4 (DDR)
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


module DCRO
	#(parameter sel_len = 8)
	(
	input rst,
	input enable,
	input [sel_len-1:0] sel,
	output out
	);


	localparam cell_number = (2**sel_len);


	wire [cell_number-1:0] selOH;
	wire [cell_number-1:0] loop_p;
	wire nand_out;


	OneHotEncoder OneHotEncoder_0(
		.rst(rst),
		.clk(nand_out),
		.sel(sel),
		.selOH(selOH)
		);


	genvar i;

	generate
		for(i=0; i<cell_number; i=i+1)
		begin:cdc_label
			if (i != (cell_number-1))
			begin
				CDC CDC0(
				.selector(selOH[i]),
				.in(nand_out),
				.pass_through(loop_p[i+1]),
				.out(loop_p[i])
				);
			end

			else
			begin
				CDC CDC0(
				.selector(selOH[i]),
				.in(nand_out),
				.pass_through(1'b0),
				.out(loop_p[i])
				);
			end
		end
	endgenerate


	assign nand_out = !(loop_p[0] && enable);

	assign out = nand_out;

endmodule