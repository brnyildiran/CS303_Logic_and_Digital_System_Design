`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: Sabanci University
// Engineer: Berna Yildiran
//////////////////////////////////////////////////////////////////////////////////

module sim_Mod7;
  reg clk;
  reg reset;
  reg enable;
  reg [2:0] configure;
  reg [31:0] serial_in;
  wire [2:0] out;
  wire cnt_out;
  wire led;

  // Instantiate the div7 module
  Mod7 UUT (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .configure(configure),
    .serial_in(serial_in),
    .out(out),
    .cnt_out(cnt_out),
    .led(led)
  );

  // Initialize inputs
  initial begin
    clk = 0;
    reset = 0;
    enable = 1;
    configure = 0;
    serial_in = 0;
  end

  // Generate clock signal
  always #5 clk = ~clk;

  // Test case 1: Reset
  initial begin
    #100;
    reset = 1;
    #100;
    reset = 0;
  end

  
  initial begin
      // Test case 2: Mod 7 of a 4-bit number
      #200;
      serial_in = 4'b0010; //2 --> 1
      #100;
      serial_in = 4'b0101; //5 --> 2
      #100;
      serial_in = 4'b1010; //10 --> 3
      #100;
      serial_in = 4'b1110; //14 --> 0 
  
      //Test case 3: Mod 7 of a 5-bit number
      #100;
      serial_in = 5'b01011; //11 --> 4
      #100;
      serial_in = 5'b10011; //19 --> 5 
      #100;
      serial_in = 5'b00011; //20 --> 6
      #100;
      serial_in = 5'b11000; //24 --> 0
      #100;
      serial_in = 5'b11110; //30 --> 2  

      //Test case 4: Mod 7 of a 6-bit number
      #100;
      serial_in = 6'b011111; //31 --> 3
      #100;
      serial_in = 6'b100010; //34 --> 6
      #100;
      serial_in = 6'b101010; //42 --> 0
      #100;
      serial_in = 6'b101110; //46 --> 4
      #100;
      serial_in = 6'b111010; //58 --> 2
      #100;
      serial_in = 6'b111111; //63 --> 0
  
  end
endmodule