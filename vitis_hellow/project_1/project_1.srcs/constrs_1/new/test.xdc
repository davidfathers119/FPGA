## ============================================================
## test.vhd pin constraint template (fill PACKAGE_PIN by yourself)
## Top ports: clk, reset_n, btn, uart_txd
## ============================================================

## ---------- Clock input ----------
## Replace <CLK_PIN> with your board clock pin, e.g. E3
set_property PACKAGE_PIN D18 [get_ports CK_P]
set_property PACKAGE_PIN C19 [get_ports CK_N]
create_clock -name sys_clk -period 5.000 [get_ports CK_P]

## ---------- Active-low reset bu   tton/signal ----------
## Replace <RESET_N_PIN> with your reset source pin
set_property PACKAGE_PIN G19 [get_ports reset_n]
set_property IOSTANDARD LVCMOS25 [get_ports reset_n]

## Optional if your reset source is a mechanical button:
##set_property PULLUP true [get_ports reset_n]

## ---------- User button input ----------
## Replace <BTN_PIN> with your user button pin
set_property PACKAGE_PIN F19 [get_ports btn]
set_property IOSTANDARD LVCMOS25 [get_ports btn]

## Optional: keep button stable when released (depends on board circuit)
## set_property PULLDOWN true [get_ports btn]

## ---------- UART TX output ----------
## Replace <UART_TXD_PIN> with your UART transmit pin
## This signal should connect to USB-UART RX side on board-level routing
set_property PACKAGE_PIN D11 [get_ports uart_txd]
set_property IOSTANDARD LVCMOS25 [get_ports uart_txd]
set_property DRIVE 8 [get_ports uart_txd]
set_property SLEW SLOW [get_ports uart_txd]
