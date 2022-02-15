`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// ECEN 489
// Engineer: Seth Pregler
// Create Date: 01/28/2022 01:13:33 AM
// Module Name: jackpot
// Project Name: LAB1
// Target Devices: ZYBO Z7-20
// 
// Description: 
// This module implements a jackpot game in which LEDS glow in a 
// one-hot fashion at a high frequency. On the development board are 4 DIP 
// switches, one for each LED, and the player must select the DIP switch 
// corresponding to the flashing LED. If the player can do this, they win!
// 
//////////////////////////////////////////////////////////////////////////////////

module jackpot(
    output reg [3:0] LEDS,
    input [3:0] SWITCHES,
    input rst,
    input clk
    );
    
    // Instantiate clock divider
    wire clk_out;
    clock_divider clk1(clk_out, clk);
    
    reg [4:0] state, next;
    wire flag;
    // Define one-hot encoding states
    parameter
        IDLE = 5'd0,
        S1 = 5'd1,  // 1st LED
        S2 = 5'd2,  // 2nd LED
        S3 = 5'd4,  // 3rd LED
        S4 = 5'd8,  // 4th LED
        YOUWIN = 5'd15;
        
    // Attempt to implement pulses corresponding to switches
    wire flag1, flag2, flag3, flag4;
    edge_detect edge1(flag1, clk_out, SWITCHES[0]);
    edge_detect edge2(flag2, clk_out, SWITCHES[1]);
    edge_detect edge3(flag3, clk_out, SWITCHES[2]);
    edge_detect edge4(flag4, clk_out, SWITCHES[3]);
    
    // Define sequential  
    always@(posedge clk_out) begin
		//reset condition
        if (rst) begin 
            state <= IDLE;
            LEDS <= IDLE;
        end
        
        else begin
            case(state)
            // If pulse was detected, youwin, else next state
                S1: begin
                    LEDS <= (flag1) ? YOUWIN : next;
                end
                
                S2: begin
                    LEDS <= (flag2) ? YOUWIN : next;
                end
                
                S3: begin
                    LEDS <= (flag3) ? YOUWIN : next;
                end
                
                S4: begin
                    LEDS <= (flag4) ? YOUWIN : next;
                end
                default: state <= IDLE;
            endcase
        end
        state <= next;
     end
     
     // Define next state logic
     always @(posedge clk_out) begin
        case(state)
            IDLE: next = S1;
            S1: begin
               next = S2;
            end
            S2: begin
               next = S3;
            end
            S3: begin
               next = S4;
            end
            S4: begin
               next = S1;
            end
        endcase
    end
endmodule

module edge_detect(
    output OUT,
    input clk,
    input L     // Switch input
    );
    
    reg A, B;
    
    always@(posedge clk) begin
        A <= L;
    end
    
    always@(posedge clk) begin
        B <= L && A;
    end
    
    assign OUT = A && B;  
endmodule

module clock_divider(
    output reg clk_out,
    input clk_in
    );
    // Set bit width to 28 bit decimal, 2^28 is just greater than the frequency of the chip (250MHz)
    reg[27:0] counter = 28'd0;
    // Frequency of clk_out is clk_in divided by 2.083.333 i.e. ~60Hz which should be quite difficult
    parameter DIVISOR = 28'd200000000;
    
    always@(posedge clk_in)
    begin
        counter <= counter + 28'd1; // Enumerate counter
        if (counter == (DIVISOR - 1)) begin
            counter <= 28'd0;
        end 
        
        clk_out <= (counter < DIVISOR/2) ? 1'b0 : 1'b1;
    end
endmodule
