# I changed "CLK100MHZ" to "clk"
# ------------------------------------------------------------------------------------------
# set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { CLK100MHZ }];
# create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {CLK100MHZ}];
# ------------------------------------------------------------------------------------------

set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { clk }];
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk}];

set_property -dict { PACKAGE_PIN H6  IOSTANDARD LVCMOS33 } [get_ports { serial_in }];
set_property -dict { PACKAGE_PIN P18  IOSTANDARD LVCMOS33 } [get_ports { reset }];

set_property -dict { PACKAGE_PIN M13  IOSTANDARD LVCMOS33 } [get_ports { configure[2] }];
set_property -dict { PACKAGE_PIN L16  IOSTANDARD LVCMOS33 } [get_ports { configure[1] }];
set_property -dict { PACKAGE_PIN J15  IOSTANDARD LVCMOS33 } [get_ports { configure[0] }];

set_property -dict { PACKAGE_PIN H17  IOSTANDARD LVCMOS33 } [get_ports { out[0] }];
set_property -dict { PACKAGE_PIN K15  IOSTANDARD LVCMOS33 } [get_ports { out[1] }];
set_property -dict { PACKAGE_PIN J13  IOSTANDARD LVCMOS33 } [get_ports { out[2] }];
set_property -dict { PACKAGE_PIN V11  IOSTANDARD LVCMOS33 } [get_ports { led }];

set_property -dict { PACKAGE_PIN V10  IOSTANDARD LVCMOS33 } [get_ports { enable }];