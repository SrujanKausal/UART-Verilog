`timescale 1ns / 1ps

module uart_rx(input clk,rst,rx,output reg [7:0]out,output reg data_valid);
reg [2:0] bit_count;
reg [7:0] rx_shift_reg;
reg [1:0] state;
reg[12:0] baud_counter;
localparam IDLE = 2'b00;
localparam START = 2'b01;
localparam DATA = 2'b10;
localparam STOP = 2'b11;
always@(posedge clk)
begin
if(rst)
begin
bit_count<=3'b0;
rx_shift_reg<=8'b0;
out<=8'b0;
data_valid<=1'b0;
state<=IDLE;
baud_counter<=13'b0;
end
else
begin
case(state)

           IDLE:
           begin
           data_valid<=1'b0;
           if(!rx)
                begin
                   baud_counter<=13'b0;
                   state<=START;
                end
           end
                    
           START:
           begin
           if(baud_counter==2604)
            begin
                 if(rx==0)
                   begin
                     state<=DATA;
                     baud_counter<=13'b0;
                     bit_count<=3'b0;
                   end
                 else
                   begin
                     state<=IDLE;
                   end
            end
           else
            begin
              baud_counter<=baud_counter+1;
            end
           end         
           
           DATA:
           begin
           if(baud_counter==5207)
                      begin
           rx_shift_reg[bit_count]<=rx;
           baud_counter<=13'b0;
                   if(bit_count==7)
                     begin
                        state<=STOP;
                       end
                     else
                       begin
                         bit_count<=bit_count+1;
                        end
                       end
           else
              begin
                baud_counter<=baud_counter+1;
              end
           end
           
           STOP:
           begin
                 if(baud_counter==5207)
                      begin
                         if(rx==1)
                           begin
                             out<=rx_shift_reg;
                             data_valid<=1'b1;
                             state<=IDLE;
                           end
                         else 
                           begin
                              state<=IDLE;
                           end    
                      end
                 else
                      begin
                         baud_counter<=baud_counter+1;
                      end      
           end
           
           default:
                 state<=IDLE;
endcase
end
end
endmodule
