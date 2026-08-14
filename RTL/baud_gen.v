`timescale 1ns / 1ps
// for the generation of baud_tick
module baud_gen(input clk,rst,output reg baud_tick);
reg [12:0]baud_count;
localparam baud_count_max = 5207;
always@(posedge clk)
begin
if(rst)
begin
baud_count<=0;
baud_tick<=0;
end
else
begin
if(baud_count==baud_count_max)
begin
baud_tick<=1;
baud_count<=0;
end
else
begin
baud_count<=baud_count+1;
baud_tick<=0;
end
end
end
endmodule
