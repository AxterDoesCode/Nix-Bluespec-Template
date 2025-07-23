TOPFILE   ?= src_BSV/Top.bsv
TOPMODULE ?= mkTop
BSCDIRS_VSIM = -bdir build_v  -info-dir build_v  -vdir verilog

build_v:
	mkdir -p $@

verilog:
	mkdir -p $@

compile: build_v verilog
	# bsc -verilog -g mkTop src_BSV/Top.bsv
	bsc -u -verilog $(BSCDIRS_VSIM) -g $(TOPMODULE) $(TOPFILE)

build:
	vivado -mode batch -nolog -nojournal -source build.tcl
	rm usage_statistics_webtalk.html usage_statistics_webtalk.xml

program:
	openFPGALoader -b arty_z7_20 bitstream.bit
