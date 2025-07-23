In order for the Makefile to work correctly in NixOS, Vivado needs to be sourced.

Something like (or wherever Vivado is installed):
`source ~/opt/Xilinx/Vivado/2019.2/settings64.sh`

You could also use the Vivado GUI to generate the bitstream, but the GUI doesn't work in Wayland (GUI sucks anyways)
