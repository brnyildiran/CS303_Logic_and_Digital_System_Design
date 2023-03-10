## Assignment Description
Design a comparator circuit that takes two 4-bit signed 2’s complement binary numbers, A and B, and turns ON one of the three LEDs by comparing them. 
Possible three scenarios for the comparator output are A>B, A<B and A=B. Only one of these three scenarios will be true for any input combinations and 
only one of the three LEDs will turn ON.

After designing the circuit using Verilog HDL and verifying your design through simulations, the 
design should be mapped to FPGA. A constraint file is required indicating which switches and LEDs 
you will use from the FPGA resources. Please note that your design will be implemented during the lab 
session. However, it is required to prepare the file and upload it to SuCourse as part of the prelab 
asssignment.

For the constraint file, 8 switches and 3 LEDs will be needed. Please use the following switches and 
LEDs in your constraint file.
Switches for the first 4-Bit Number:
- R15, M13, L16, J15
Switches for the second 4-Bit Number:
- T8, R13, U18, T18
LED for A>B: H17
LED for A<B: K15
LED for A=B: J13

3 files will be submitted for prelab assignment:
1. Project folder of your design including your Verilog codes, simulation files.
2. Constraint file for FPGA implementation.
3. A report explaining all your work in detail.
