`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.08.2026 13:27:39
// Design Name: 
// Module Name: uart_tx_tb
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


module uart_tx_tb;
reg clk,rst,tx_start;
reg [7:0]data;
wire tx,busy,baud_tick;

//module instantiation
uart_tx dut(.clk(clk),.rst(rst),.tx_start(tx_start),.baud_tick(baud_tick),.data(data),.tx(tx),.busy(busy));
//for baud_tick from baud_gen
baud_gen uut(.clk(clk),.rst(rst),.baud_tick(baud_tick));

//clk generation
initial clk=0;
always #5 clk = ~clk;

initial
begin
rst=1;
tx_start=0;
#20
rst=0;
#20
data=8'hA5;
#10
tx_start=1;
#10
tx_start=0;
#550000
$finish;
end
endmodule
