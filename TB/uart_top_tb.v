`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.08.2026 19:14:48
// Design Name: 
// Module Name: uart_top_tb
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


module uart_top_tb;
reg clk,rst,tx_start;
reg [7:0]data;
wire busy,tx,data_valid;
wire [7:0]out;
integer i;
reg [7:0]expected;
//instantiation
uart_top dut(.clk(clk),.rst(rst),.tx_start(tx_start),.data(data),.busy(busy),.tx(tx),.data_valid(data_valid),.out(out));

//clock generation
initial clk=0;
always #5 clk = ~clk;

initial
begin
rst=1;
tx_start=0;
#10
rst=0;
for(i=0;i<20;i=i+1)
begin
wait(!busy);
expected=$random;
data=expected;
@(posedge clk);
tx_start=1;
@(posedge clk);
tx_start=0;
@(posedge data_valid);
if(out==expected)
begin
$display("TEST %0d PASS---sent=%h received=%h",i+1,expected,out);
end
else
begin
$display("TEST %0d FAIL---sent=%h received=%h",i+1,expected,out);
end
end
#20
$finish;
end
endmodule
