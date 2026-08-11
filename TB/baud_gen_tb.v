`timescale 1ns / 1ps

module baud_gen_tb;
reg clk,rst;
wire baud_tick;
 
// module instantiation
baud_gen dut(.clk(clk),.rst(rst),.baud_tick(baud_tick));

//clk generation
initial clk=0;
always #5 clk = ~clk;

initial
begin
rst=1;
#20
rst=0;
#53000
$finish;
end
endmodule
