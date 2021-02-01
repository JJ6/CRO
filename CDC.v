`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.02.2020 18:22:45
// Design Name: 
// Module Name: CDC
// Project Name: 
// Target Devices: Nexys 4 (DDR)
// Tool Versions: 
// Description: Controled Delay Cell.
//				If selector is equal to one, the in signal passes through the AND
//				gate and gets fed to the OR gate.
// 				The OR gate, being the selector word a one-hot encoded word, has a
//				zero in the other input, letting that gate too pass the in signal
//				to the out port.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CDC(
    input selector,
    input in,
    input pass_through,
    output out
    );

	assign out = (in && selector) || pass_through;

endmodule
