include synthesizer/config.sh
export
SCALA_TARGETS   := $(shell find src/main/ -type f -name '*.scala')
FIRRTL_TARGETS  := $(wildcard synthesizer/*.fir)
VERILOG_TARGETS := $(patsubst %.fir,%.v,$(FIRRTL_TARGETS))


.PHONY: all
all: bitfile

.PHONY: bitfile
bitfile: synthesizer/$(TOP_MODULE).bit

.PHONY: upload
upload:
	cd synthesizer; ./upload_bitfile.sh

.PHONY: graphs
graphs: synthesizer/$(TOP_MODULE).v synthesizer/$(TOP_MODULE).fir
	cd graphs;     ./make_yosys.sh ../synthesizer/$(TOP_MODULE).v
	cd diagrammer; ./diagram.sh -i ../synthesizer/$(TOP_MODULE).fir -t ../graphs/diagrammer -o '""'

synthesizer/$(TOP_MODULE).fir: $(SCALA_TARGETS)
	sbt run

synthesizer/$(TOP_MODULE).bit: $(VERILOG_TARGETS) synthesizer/constraints-$(XILINX_PART).xdc synthesizer/$(TOP_MODULE).fir synthesizer/$(TOP_MODULE).v
ifdef FAST
	cd synthesizer; ./synth_verilog.sh FAST
else
	cd synthesizer; ./synth_verilog.sh
endif

synthesizer/%.v: synthesizer/%.fir
	firrtl -i $< -o $@ --info-mode=ignore

.PHONY: clean
clean:
	rm -v -r \
		graphs/yosys/*        \
		graphs/diagrammer/*   \
		synthesizer/.Xil      \
		synthesizer/*.bit     \
		synthesizer/*.edif    \
		synthesizer/*.fir     \
		synthesizer/*.html    \
		synthesizer/*.jou     \
		synthesizer/*.v       \
		synthesizer/*.log     \
		synthesizer/*.xml
