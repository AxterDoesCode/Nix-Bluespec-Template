set_part xc7z020clg400-1
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:arty-z7-20:part0:1.1 [current_project]

# read design sources (add one line for each file)
read_verilog "verilog/mkTop.v"

# read constraints
read_xdc "arty.xdc"

# synth
# synth_design -top "mkTop" -part "xc7z020-1clg400c"
synth_design -top "mkTop" -part "xc7z020clg400-1"

# place and route
opt_design
place_design
route_design

# write bitstream
write_bitstream -force "bitstream.bit"
