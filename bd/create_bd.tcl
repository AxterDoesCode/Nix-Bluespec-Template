# Create the block design
set bdname "yep"
create_bd_design $bdname

# Add Zynq-7000 PS IP
set processing_system [
    create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7
]

apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {
    make_external "FIXED_IO, DDR"
    Master "Disable"
    Slave "Disable"
} $processing_system

set_property -dict [list \
    CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {125} \
    CONFIG.PCW_USE_M_AXI_GP0 {0} 
] $processing_system

set module_led [
    create_bd_cell -type module -reference mkTop top_0
]

set reset_system [
    create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset
]

set clock_generator [
    create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz
]

set_property -dict [list \
    CONFIG.PRIM_SOURCE {Single_ended_clock_capable_pin} \
    CONFIG.PRIM_IN_FREQ {125.000} \
    CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {25.000} \
    CONFIG.USE_LOCKED {true} \
    CONFIG.LOCKED_PORT {locked} \
    CONFIG.USE_RESET {true} \
    CONFIG.RESET_TYPE {ACTIVE_LOW} \
    CONFIG.RESET_PORT {resetn}
] $clock_generator

create_bd_port -dir O led


connect_bd_net [get_bd_pins proc_sys_reset/slowest_sync_clk] [get_bd_pins processing_system7/FCLK_CLK0]
connect_bd_net [get_bd_pins proc_sys_reset/ext_reset_in] [get_bd_pins processing_system7/FCLK_RESET0_N]

connect_bd_net [get_bd_pins processing_system7/FCLK_CLK0] [get_bd_pins clk_wiz/clk_in1]
connect_bd_net [get_bd_pins clk_wiz/clk_out1] [get_bd_pins top_0/CLK]

connect_bd_net [get_bd_pins proc_sys_reset/peripheral_aresetn] [get_bd_pins top_0/RST_N]
connect_bd_net [get_bd_pins proc_sys_reset/peripheral_aresetn] [get_bd_pins clk_wiz/resetn]
connect_bd_net [get_bd_ports led] [get_bd_pins top_0/led]

regenerate_bd_layout
save_bd_design

set bdpath [file dirname [get_files [get_property FILE_NAME [current_bd_design]]]]
