set topModule "mkTop"
#WIP: https://docs.amd.com/r/en-US/ug994-vivado-ip-subsystems/Non-Project-Script
#Since there isn't a Vivado project these command objects point towards an in-memory project
set_part xc7z020clg400-1
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:arty-z7-20:part0:1.1 [current_project]
set_property default_lib work [current_project]
set_property source_mgmt_mode All [current_project]

# read design sources (add one line for each file)
read_verilog "verilog/mkTop.v"

# read constraints
read_xdc "arty.xdc"

# create block design
source ./bd/create_bd.tcl

# synth
# synth_design -top "mkTop" -part "xc7z020-1clg400c"
synth_design -top $topModule

# place and route
opt_design
place_design
route_design

# write bitstream
write_bitstream -force "bitstream.bit"

# TODO: Write the .xsa file here for use within Vitis/PetaLinux
