`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2020 17:18:07
// Design Name: 
// Module Name: DCRO_ctrl
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


module DCRO_ctrl
    #(parameter sel_len = 8)
	(
	input rst,
	input clk,		// Must receive the PLL's generated clock signal
	input mode,		// Mode = {0 -> Absolute Mode; 1 -> Incremental Mode}
	input [sel_len:0] sel_in,	// sel_in is a signed int
	output [sel_len-1:0] sel_out
    );


	parameter min_value = 1;
	parameter max_value = (2**sel_len)-1;

    wire signed [sel_len:0] in_signed;

    reg signed [sel_len:0] out_signed;
    reg signed [sel_len+1:0] out_signed_aux;
    


    assign in_signed = sel_in; //DOUBT: sel_in should already be a signed integer, can/should this be kept? 

	always @(posedge clk)
		begin
			if (rst)
				begin
					out_signed <= 'sd0;
					out_signed_aux <= 'sd0;
				end

			else
				begin
					if (mode)	// Incremental Mode
						begin
							out_signed_aux <= out_signed + in_signed;	// Adds the previous value with the input
							
							if (out_signed_aux < min_value)	// The FCW cannot be smaller than 1
								out_signed <= min_value;
							
							else if (out_signed_aux > max_value)	// The FCW cannot be bigger than (2**sel_len)-1
								out_signed <= max_value;								

							else
								out_signed <= out_signed_aux;
						end


					else 		// Absolute Mode
						begin
							out_signed <= in_signed;	// Directly feed the input to the output
						end
				end
		end

	assign sel_out = out_signed;	// We can assign directly because we ensured the out_signed was compreended into
									// a certain interval

endmodule