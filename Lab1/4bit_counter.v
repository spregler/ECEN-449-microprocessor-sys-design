`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// ECEN 489
// Engineer: Seth Pregler
// Create Date: 01/28/2022 01:13:33 AM
// Module Name: four_bit_counter
// Project Name: LAB1
// Target Devices: ZYBO Z7-20
// 
// Description: 
// This module implements a simple 4-bit counter and a clock divider that decreases
// the frequency of flashing LEDS from 125MHz to 1Hz.
// 
//////////////////////////////////////////////////////////////////////////////////
    

module four_bit_counter(
    input clk,
    input rst,
    input down, up,    // input buttons to control direction of count
    output reg [3:0] out
    );
    wire clk_out;
    
    // Instantiate clk divider
    clock_divider clk1(clk_out, clk);
    
    // Always on the posedge of clk
    always@(posedge clk_out) begin
        if (rst) begin
            out <= 4'b0000;
        end
        
        else 
            if (up) begin
                out <= out + 1;
            end
            
            if (down) begin
                out <= out - 1;
            end
    end
endmodule

module clock_divider(
    output reg clk_out,
    input clk_in
    );
    // Set bit width to 28 bit decimal, 2^28 is just greater than the frequency of the chip (250MHz)
    reg[27:0] counter = 28'd0;
    // Frequency of clk_out is clk_in divided by 125MHz, i.e. 1Hz
    parameter DIVISOR = 28'd125000000;
    
    always@(posedge clk_in)
    begin
        counter <= counter + 28'd1; // Enumerate counter
        if (counter == (DIVISOR - 1)) begin
            counter <= 28'd0;
        end 
        
        clk_out <= (counter < DIVISOR/2) ? 1'b0 : 1'b1;
    end
endmodule


    
    
    
    
    
    
    
