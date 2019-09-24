include synthesizer/config.sh
export
SCALA_TARGETS   := $(shell find src/main/ -type f -name '*.scala')

ifdef FAST
	FLAGS := "FAST"
else
	FLAGS := ""
endif


.PHONY: all
all: bitfile

.PHONY: bitfile
bitfile: synthesizer/$(TOP_MODULE).bit

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


synthesizer/$(TOP_MODULE).fir: $(SCALA_TARGETS)
	sbt run


synthesizer/$(TOP_MODULE).edif: synthesizer/$(TOP_MODULE).v synthesizer/config.sh
	cd synthesizer; ./synth_netlist.sh $(FLAGS)


synthesizer/$(TOP_MODULE).bit: synthesizer/constraints-$(XILINX_PART).xdc synthesizer/$(TOP_MODULE).edif synthesizer/config.sh
	cd synthesizer; ./synth_bitfile.sh $(FLAGS)


synthesizer/%.v: synthesizer/%.fir
	firrtl -i $< -o $@ --info-mode=ignore


.PHONY: clean
clean:
	rm -v -r \
		synthesizer/.Xil      \
		synthesizer/*.bit     \
		synthesizer/*.edif    \
		synthesizer/*.fir     \
		synthesizer/*.html    \
		synthesizer/*.jou     \
		synthesizer/*.v       \
		synthesizer/*.log     \
		synthesizer/*.xml
