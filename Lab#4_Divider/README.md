## Assignment Description
In Lab #4, you are asked to design a circuit that calculates the remainder of an arbitrary-length binary 
number divided by 7, using Verilog HDL. You are also asked to implement the circuit on FPGA board.

The design will have two parts:
- Part #1 will calculate the mod 7 (X) of an arbitrary-length binary input.
- Part #2 will generate the clock signal (cnt_out) for Part #1. It will be a configurable counter which is configured by a 3-bit input (configure [2:0]).

### Part #1: Mod 7 (X) Circuit
The circuit will have four inputs:

- Clock input (cnt_out): At every posedge of the clock signal the circuit will sample the serial input. The clock input (cnt_out) comes from the output of the configurable counter.
- Reset input (reset): Required to reset the state machine.
- Enable input (enable): When enable is active high, circuit will sample the serial input. When enable is low, the circuit does not accept serial input and preserves its current state.
- A serial input (serial_in): You will feed the serial input through this input starting from the least significant bit (LSB) one by one. In n cycles you can feed an n-bit binary number X. 
  X= (xn-1xn-2…………x2x1x0)

The circuit will have one output:
- 3-bit output (out [2:0]): The output will show the remainder of an arbitrary-length binary number divided by 7 in each clock cycle

### Part #2: Configurable Clock Generator
The configurable clock counter has four inputs:
- Clock input (clk): At every posedge of the clock signal the circuit will increment by one. This clock will be the internal clock of the FPGA.
- Reset input (reset): Required to reset the counter. Please note that “reset” input is common with Part#1.
- Enable input (enable): When enable is active high, counter works and LED can be turned on/off. When enable is low, counter stops, and LED preserves its state. Please note that “enable” input is 
common with Part #1.
- 3-bit configuration input (configure [2:0]): The configure [2:0] will determine how many cycles the counter will count with the following configurations:

If (configure = 111), the counter counts to 32’h FFFFFFFF
If (configure = 110), the counter counts to 32’h 80000000
If (configure = 101), the counter counts to 32’h 40000000
If (configure = 100), the counter counts to 32’h 20000000
If (configure = 011), the counter counts to 32’h 10000000
If (configure = 010), the counter counts to 32’h 08000000
If (configure = 001), the counter counts to 32’h 04000000
If (configure = 000), the counter counts to 32’h 02000000

For the simulation purposes on Vivado, you can use the below configuration. Otherwise,
simulation will take a long time. For the real implementation, use the previous configuration.

If (configure = 111), the counter counts to 32’h 0000FFFF
If (configure = 110), the counter counts to 32’h 00008000
If (configure = 101), the counter counts to 32’h 00004000
If (configure = 100), the counter counts to 32’h 00002000
If (configure = 011), the counter counts to 32’h 00001000
If (configure = 010), the counter counts to 32’h 00000800
If (configure = 001), the counter counts to 32’h 00000400
If (configure = 000), the counter counts to 32’h 00000200

The configurable clock counter has two outputs:
- Output showing that counting is done (cnt_out): Every time the counter value reaches the configured value, the cnt_out will be asserted. In the next clock cycle, it will be deasserted.
- LED output (led): Everytime the cnt_out is asserted (posedge cnt_out), the led output will change state meaning that the LED will turn ON and OFF.

For the constraint file, 1 push button, 5 switches and 4 LEDs will be needed. Please use the given constraint file in the lab assignment “LAB4.xdc”. If your design is ready, generate a bitstream file 
for the FPGA before coming to lab to makes it faster to test your design on the FPGA.
