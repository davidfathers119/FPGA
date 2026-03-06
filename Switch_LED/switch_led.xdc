## ============================================================
## XDC Template for entity: test
## 請把 PACKAGE_PIN 的 <TODO_...> 改成你板子的實際腳位
## ============================================================

## ------------------------------
## Differential clock input (IBUFDS)
## ------------------------------
set_property PACKAGE_PIN D18 [get_ports CK_P]
set_property PACKAGE_PIN C19 [get_ports CK_N]
set_property IOSTANDARD LVDS_25 [get_ports {CK_P CK_N}]

## 請依你的外部時脈頻率修改週期 (目前先用 10ns = 100MHz)
create_clock -name sys_clk -period 5.000 [get_ports CK_P]

## ------------------------------
## Reset input
## ------------------------------
set_property PACKAGE_PIN G19 [get_ports S_RESET]
set_property IOSTANDARD LVCMOS25 [get_ports S_RESET]

## ------------------------------
## Switch inputs: switch[1:0] 板子上的sw12[1;0]
## ------------------------------
set_property PACKAGE_PIN W6 [get_ports {switch[0]}]
set_property PACKAGE_PIN W7 [get_ports {switch[1]}]

set_property IOSTANDARD LVCMOS25 [get_ports {switch[0] switch[1]}]

## ------------------------------
## LED outputs: Led[1:0]
## ------------------------------
set_property PACKAGE_PIN E15 [get_ports {Led[0]}]
set_property PACKAGE_PIN D15 [get_ports {Led[1]}]

set_property IOSTANDARD LVCMOS25 [get_ports {Led[0] Led[1]}]

## 需要限制驅動能力時可取消註解 (視板子需求)
## set_property DRIVE 8 [get_ports {Led[0] Led[1] }]
## set_property SLEW SLOW [get_ports {Led[0] Led[1] }]
