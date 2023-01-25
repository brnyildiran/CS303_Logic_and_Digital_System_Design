`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: Sabanci University PRE-LAB 4
// Engineer: Berna Yildiran
//////////////////////////////////////////////////////////////////////////////////

module Mod7(
    input clk, 
    input reset,
    input enable,
    
    // 3-bit configuration input 
    input [2:0] configure,
    
    // 32-bit serial input 
    input [31:0] serial_in,
    
    // 3-bit mod 7 result output 
    output reg [2:0] out, 
    output reg cnt_out, 
    output reg led
    );

// 32-bit register used to store a value that will modified in the code
reg [31:0] x;

// 5-bit register used to store a count value
reg [4:0] cnt;

// Always block triggered on the rising edge of the clock or reset signals
always @(posedge clk or posedge reset) 
    begin
        // Check the value of the reset signal
        // If reset is 1, initialize values to 0
        if (reset) begin
          x <= 0;
          cnt <= 0;
          out <= 0;
          cnt_out <= 0;
          led <= 0;
        end
        
        // If reset is 0, execute the following code 
        else begin
          // Increment the count value
          cnt <= cnt + 1;
          
          // Check if the count value is equal to the configuration value
          // If so, reset the count value to 0 and set cnt_out to 1
          if (cnt == configure) begin
            cnt <= 0;
            cnt_out <= 1;
          end
          
          // If cnt_out is 1, toggle the value of led
          if (cnt_out) begin
            cnt_out <= 0;
            led <= ~led;
          end
          
          // Concatenate the lower 30 bits of x with the serial input value and store the result in x
          // Perform a mod 7 operation on x and store the result in out
          x <= {x[30:0], serial_in};
          out <= x % 7;
        end
    end
endmodule