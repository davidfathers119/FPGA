## ============================================================================
## GOLD_SEQUENCE.xdc (template)
## 請先依你的 FPGA 開發板/原理圖填入 PACKAGE_PIN。
## ============================================================================

## =====================
## Clock (Differential)
## =====================
# set_property PACKAGE_PIN <CLK_P_PIN> [get_ports CK_P]
# set_property PACKAGE_PIN <CLK_N_PIN> [get_ports CK_N]
set_property PACKAGE_PIN D18 [get_ports CK_P]
set_property PACKAGE_PIN C19 [get_ports CK_N]
set_property IOSTANDARD LVDS_25 [get_ports {CK_P CK_N}]

## 100 MHz 差動時脈 (可依實際修改 period)
create_clock -name sys_clk -period 5.000 [get_ports CK_P]

## =====================
## Inputs
## =====================
set_property PACKAGE_PIN G19 [get_ports S_RESET]
set_property PACKAGE_PIN F19 [get_ports EN]
set_property IOSTANDARD LVCMOS25 [get_ports {S_RESET EN}]

## =====================
## Outputs
## =====================
set_property PACKAGE_PIN E15 [get_ports GOLD_BIT]
set_property PACKAGE_PIN D15 [get_ports VALID]
set_property IOSTANDARD LVCMOS25 [get_ports {GOLD_BIT VALID}]
set_property DRIVE 8 [get_ports {GOLD_BIT VALID}]
set_property SLEW SLOW [get_ports {GOLD_BIT VALID}]

## =====================
## Optional timing hints
## =====================
## S_RESET 為非同步 reset，可視需求放寬 timing 分析
#set_false_path -from [get_ports S_RESET]
