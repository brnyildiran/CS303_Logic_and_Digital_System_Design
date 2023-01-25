# For the constraint file, 8 switches and 3 LEDs will be needed.
# Switches for the first 4-Bit Number --> R15, M13, L16, J15
# Switches for the second 4-Bit Number --> T8, R13, U18, T18
# LED for A>B: H17
# LED for A<B: K15
# LED for A=B: J13

# --------------------------------
# INPUT SWITCHES A
# --------------------------------
# SW A3
set_property -dict { PACKAGE_PIN R15 IOSTANDARD LVCMOS33 } [get_ports { A3 }];
# SW A2
set_property -dict { PACKAGE_PIN M13 IOSTANDARD LVCMOS33 } [get_ports { A2 }];
# SW A1
set_property -dict { PACKAGE_PIN L16 IOSTANDARD LVCMOS33 } [get_ports { A1 }];
# SW A0
set_property -dict { PACKAGE_PIN J15 IOSTANDARD LVCMOS33 } [get_ports { A0 }];


# --------------------------------
# INPUT SWITCHES B
# --------------------------------
# SW B3
set_property -dict { PACKAGE_PIN T8 IOSTANDARD LVCMOS33 } [get_ports { B3 }];
# SW B2
set_property -dict { PACKAGE_PIN R13 IOSTANDARD LVCMOS33 } [get_ports { B2 }];
# SW B1
set_property -dict { PACKAGE_PIN U18 IOSTANDARD LVCMOS33 } [get_ports { B1 }];
# SW B0
set_property -dict { PACKAGE_PIN T18 IOSTANDARD LVCMOS33 } [get_ports { B0 }];


# --------------------------------
# OUTPUT LEDS
# --------------------------------
# LED A_GREATER_B
set_property -dict { PACKAGE_PIN H17 IOSTANDARD LVCMOS33 } [get_ports { A_GREATER_B }];
# LED A_LESS_B
set_property -dict { PACKAGE_PIN K15 IOSTANDARD LVCMOS33 } [get_ports { A_LESS_B }];
# LED A_EQUAL_B
set_property -dict { PACKAGE_PIN J13 IOSTANDARD LVCMOS33 } [get_ports { A_EQUAL_B }];