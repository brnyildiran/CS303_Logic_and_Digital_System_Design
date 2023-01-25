`timescale 1ms /1ms
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/22/2023 01:53:24 PM
// Design Name: 
// Module Name: sim_elevator
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


module sim_elevator();

reg clk_in, rst,
floor_0_p,
floor_1_p, 
floor_2_p,
floor_3_p,
floor_4_p,

direction_1, 
direction_2, 
direction_3,

floor_0_d, 
floor_1_d,  
floor_2_d, 
floor_3_d, 
floor_4_d;
 
wire led_inside_0, 
led_inside_1,  
led_inside_2, 
led_inside_3,  
led_inside_4,
 
led_outside_0,   
led_outside_1,  
led_outside_2, 
led_outside_3,   
led_outside_4;

wire led_busy;
wire [7:0] a, b, c, d, e, f, g, p;
  
// initialize module 
elevator top_m(
clk_in, rst,
floor_0_p,
floor_1_p, 
floor_2_p,
floor_3_p,
floor_4_p,

direction_1, 
direction_2, 
direction_3,

floor_0_d, 
floor_1_d,  
floor_2_d, 
floor_3_d, 
floor_4_d,

led_inside_0, 
led_inside_1,  
led_inside_2, 
led_inside_3,  
led_inside_4,

led_outside_0,   
led_outside_1,  
led_outside_2, 
led_outside_3,   
led_outside_4,

led_busy,

a, b, c, d, e, f, g, p
);

// Alternate clock every 10 ms
always #10 clk_in = ~clk_in;
initial begin
    clk_in = 1;     // set clock high
    rst = 0;        // start reset sequence
    
    // set initial values

    floor_0_p = 0;  
    floor_1_p = 0; 
    floor_2_p = 0;
    floor_3_p = 0; 
    floor_4_p = 0;
    
    direction_1 = 0; 
    direction_2 = 0; 
    direction_3 = 0;
    
    floor_0_d = 0; 
    floor_1_d = 0; 
    floor_2_d = 0; 
    floor_3_d = 0; 
    floor_4_d = 0;
    
    #10             // wait for reset 
    rst = 1;        // stop reset sequence
    #10             

    
    floor_4_p = 1;      // [4-] push request elevator button at floor 4 (direction down)

    #30                 // wait for 0.03 seconds

    floor_4_p = 0;      // release request elevator button at floor 4

    #30                 // wait for 0.03 seconds

    direction_2 = 1;    // set direction to up at floor 2

    #30                 // wait for 0.03 seconds

    floor_2_p = 1;      // [2+] push request elevator button at floor 4 (direction up)

    #30                 // wait for 0.03 seconds

    floor_2_p = 0;      // release request elevator button at floor 2

    #10100              // wait for 10 seconds (currently on floor 2)

    floor_3_d = 1;      // {3} push destination button to go to floor 3

    #30                 // wait for 0.03 seconds

    floor_0_p = 1;      // [0+] push request elevator button at floor 0 (direction up)

    #30                 // wait for 0.03 seconds

    floor_3_d = 0;      // release destination button to go to floor 3

    #30                 // wait for 0.03 seconds

    floor_0_p = 0;      // release request elevator button at floor 0

    #10100              // wait for 10 seconds (currently on floor 4)

    direction_3 = 1;    // set direction to up at floor 1
    floor_3_p = 1;      // [1+] push request elevator button at floor 1 (direction up)

    #30                 // wait for 0.03 seconds

    floor_3_p = 0;      // release request elevator button at floor 1

    #15000             // wait for 15 seconds

    floor_1_d = 1;      // {1} push destination button to go to floor 1

    #30                 // wait for 0.03 seconds

    floor_1_d = 0;      // release destination button to go to floor 1

    #10000;
end
endmodule
