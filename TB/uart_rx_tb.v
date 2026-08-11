`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.08.2026 19:31:07
// Design Name: 
// Module Name: uart_rx_tb
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


module uart_rx_tb;
reg clk,rst,rx;
reg [7:0]d;
wire [7:0]out;
wire data_valid;

//module instantiation
uart_rx dut(.clk(clk),.rst(rst),.rx(rx),.out(out),.data_valid(data_valid));

//clock generation
initial clk=0;
always #5 clk = ~clk;

integer i=0;
initial
begin
d=8'hA5;
rst=1;
rx=1;
#20
rst=0;
#20
rx=0;
#53000
for(i=0;i<8;i=i+1)
begin
rx=d[i];
#53000;
end
#53000
rx=1;
end
always@(posedge data_valid)
begin
if(out==8'hA5)
begin
$display("PASS---out=%h,data_valid=%d",out,data_valid);
end
else
begin
$display("FAIL---out=%h,data_valid=%d",out,data_valid);
end
#53000
$finish;
end
endmodule
