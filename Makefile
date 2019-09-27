include synthesizer/config.sh
export
SCALA_TARGETS    := $(shell find src/main/scala/ -type f -name '*.scala')
VHDL_TARGETS     := $(shell find src/main/vhdl/ -mindepth 1 -maxdepth 1 -type d )
VHDL_DESTS       := $(patsubst src/main/vhdl/%,synthesizer/include/%.v,$(VHDL_TARGETS))
VERILOG_TARGETS  := $(shell find src/main/verilog/ -type f | grep \\\.v$ )

ifdef FAST
	FLAGS := "FAST"
else
	FLAGS := ""
endif

.PHONY: all
all: bitfile

.PHONY: bitfile
bitfile: $(VHDL_DESTS) synthesizer/$(TOP_MODULE).bit

.PHONY: upload
upload:
	cd synthesizer; ./upload_bitfile.sh

.PHONY: graphs graphs_yosys graphs_diagrammer
graphs: graphs_yosys graphs_diagrammer
graphs_yosys: synthesizer/$(TOP_MODULE).v
	rm graphs/yosys/* || true
	cd graphs; ./make_yosys.sh ../synthesizer/$(TOP_MODULE).v
graphs_diagrammer: synthesizer/$(TOP_MODULE).fir diagrammer/diagram.sh
	rm graphs/diagrammer/* || true
	cd diagrammer; ./diagram.sh -i ../synthesizer/$(TOP_MODULE).fir -t ../graphs/diagrammer -o '""'
diagrammer/diagram.sh:
	git submodule update --init

# todo: won't re-make on edits for vhdl files
synthesizer/include/%.v: src/main/vhdl/%
	cd synthesizer; mkdir -p include
	cd synthesizer; ./synth_vhdl.sh ../$@ $* ../$</*.vhd


synthesizer/$(TOP_MODULE).fir: $(SCALA_TARGETS)
	sbt run

synthesizer/%.v: synthesizer/%.fir
	firrtl -i $< -o $@ --info-mode=ignore

synthesizer/$(TOP_MODULE).edif: synthesizer/$(TOP_MODULE).v $(VERILOG_TARGETS) synthesizer/config.sh $(wildcard synthesizer/include/*.v)
	cd synthesizer; ./synth_netlist.sh $(FLAGS) ../$(VERILOG_TARGETS)


synthesizer/$(TOP_MODULE).bit: synthesizer/constraints-$(XILINX_PART).xdc synthesizer/$(TOP_MODULE).edif synthesizer/config.sh
	cd synthesizer; ./synth_bitfile.sh $(FLAGS)



.PHONY: clean
clean:
	rm -v -r \
		synthesizer/include/*.v \
		synthesizer/.Xil      \
		synthesizer/*.bit     \
		synthesizer/*.edif    \
		synthesizer/*.fir     \
		synthesizer/*.html    \
		synthesizer/*.jou     \
		synthesizer/*.v       \
		synthesizer/*.log     \
		synthesizer/*.xml
