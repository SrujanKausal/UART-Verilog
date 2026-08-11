`timescale 1ns / 1ps

module uart_tx(input clk,rst,tx_start,baud_tick,input [7:0] data,output reg tx,busy);
reg [7:0]tx_shift_reg;
reg [2:0]bit_count;
reg[1:0]state;
localparam IDLE = 2'b00;
localparam START = 2'b01;
localparam DATA = 2'b10;
localparam STOP = 2'b11;
always@(posedge clk)
begin
if(rst)
begin 
tx_shift_reg<=8'b0;
bit_count<=3'b0;
tx<=1;
busy<=0;
state<=IDLE;
end
else
begin
case(state)
       IDLE:
       begin
       tx<=1'b1;
       busy<=1'b0;
       if(tx_start)
       begin
       tx_shift_reg<=data;
       bit_count<=3'b0;
       busy<=1'b1;
       state<=START;
       end
       end
       START:
       begin
       tx<=1'b0;
       if(baud_tick)
       begin
       state<=DATA;
       end
       end
       DATA:
       begin
       tx<=tx_shift_reg[0];
       if(baud_tick)
       begin
       if(bit_count==7)
       begin
       state<=STOP;
       end
       else
       begin
       bit_count<=bit_count+1;
       tx_shift_reg<=tx_shift_reg>>1;
       end
       end       
       end   
       STOP:
       begin
       tx<=1'b1;
       if(baud_tick)
       begin
       busy<=1'b0;
       state<=IDLE;
       end
       end
       default:
       state<=IDLE;
endcase
end
end
endmodule
