## Arty Board Constraints

## Clock
set_property -dict {PACKAGE_PIN E3  IOSTANDARD LVCMOS33} [get_ports {clock}];
create_clock -add -name sys_clk_pin -period 10.00 \
    -waveform {0 5} [get_ports {clock}];

## Switches
set_property -dict {PACKAGE_PIN A8  IOSTANDARD LVCMOS33} [get_ports {io_sw[0]}];
set_property -dict {PACKAGE_PIN C11 IOSTANDARD LVCMOS33} [get_ports {io_sw[1]}];
set_property -dict {PACKAGE_PIN C10 IOSTANDARD LVCMOS33} [get_ports {io_sw[2]}];
set_property -dict {PACKAGE_PIN A10 IOSTANDARD LVCMOS33} [get_ports {io_sw[3]}];

## LEDs
set_property -dict {PACKAGE_PIN H5  IOSTANDARD LVCMOS33} [get_ports {io_led[0]}];
set_property -dict {PACKAGE_PIN J5  IOSTANDARD LVCMOS33} [get_ports {io_led[1]}];
set_property -dict {PACKAGE_PIN T9  IOSTANDARD LVCMOS33} [get_ports {io_led[2]}];
set_property -dict {PACKAGE_PIN T10 IOSTANDARD LVCMOS33} [get_ports {io_led[3]}];

## Buttons
set_property -dict {PACKAGE_PIN D9  IOSTANDARD LVCMOS33} [get_ports {io_btn[0]}];z
set_property -dict {PACKAGE_PIN C9  IOSTANDARD LVCMOS33} [get_ports {io_btn[1]}];
set_property -dict {PACKAGE_PIN B9  IOSTANDARD LVCMOS33} [get_ports {io_btn[2]}];
set_property -dict {PACKAGE_PIN B8  IOSTANDARD LVCMOS33} [get_ports {io_btn[3]}];
