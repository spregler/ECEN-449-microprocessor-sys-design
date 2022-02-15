##Switches

set_property PACKAGE_PIN G15 [get_ports {SWITCHES[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SWITCHES[0]}]

set_property PACKAGE_PIN P15 [get_ports {SWITCHES[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SWITCHES[1]}]

set_property PACKAGE_PIN W13 [get_ports {SWITCHES[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SWITCHES[2]}]

set_property PACKAGE_PIN T16 [get_ports {SWITCHES[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SWITCHES[3]}]

##LEDs

set_property PACKAGE_PIN M14 [get_ports {out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {out[0]}]

set_property PACKAGE_PIN M15 [get_ports {out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {out[1]}]

set_property PACKAGE_PIN G14 [get_ports {out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {out[2]}]

set_property PACKAGE_PIN D18 [get_ports {out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {out[3]}]

##Buttons
set_property -dict { PACKAGE_PIN K18   IOSTANDARD LVCMOS33 } [get_ports { up }]; #IO_L12N_T1_MRCC_35 Sch=btn[0]
set_property -dict { PACKAGE_PIN P16   IOSTANDARD LVCMOS33 } [get_ports { down }]; #IO_L24N_T3_34 Sch=btn[1]
set_property -dict { PACKAGE_PIN K19   IOSTANDARD LVCMOS33 } [get_ports { rst }]; #IO_L10P_T1_AD11P_35 Sch=btn[2]

##Clock
set_property PACKAGE_PIN K17 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
