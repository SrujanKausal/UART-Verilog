`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.08.2026 18:47:54
// Design Name: 
// Module Name: uart_top
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


module uart_top(input clk,rst,tx_start,input [7:0]data,output busy,tx,data_valid,output [7:0]out);
wire baud_tick,serial_line;
//instantiation of modules
baud_gen bg(.clk(clk),.rst(rst),.baud_tick(baud_tick));   //generates baud_tick
uart_tx ut(.clk(clk),.rst(rst),.tx_start(tx_start),.data(data),.baud_tick(baud_tick),.busy(busy),.tx(serial_line));
uart_rx ur(.clk(clk),.rst(rst),.rx(serial_line),.out(out),.data_valid(data_valid));

assign tx = serial_line;           //here we are exposing the transmitter output so that we could know the data.
endmodule
