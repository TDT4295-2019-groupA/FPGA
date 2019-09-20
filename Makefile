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

.PHONY: diagrams
diagrams:
	echo todo

synthesizer/$(TOP_MODULE).fir: $(SCALA_TARGETS)
	sbt run

synthesizer/$(TOP_MODULE).bit: $(VERILOG_TARGETS) synthesizer/constraints.xdc synthesizer/config.sh synthesizer/$(TOP_MODULE).fir synthesizer/$(TOP_MODULE).v
	cd synthesizer; ./synth_verilog.sh

synthesizer/%.v: synthesizer/%.fir
	firrtl -i $< -o $@ --info-mode=ignore

.PHONY: clean
clean:
	rm -r synthesizer/.Xil    \
		synthesizer/*.bit     \
		synthesizer/*.edif    \
		synthesizer/*.fir     \
		synthesizer/*.html    \
		synthesizer/*.jou     \
		synthesizer/*.v       \
		synthesizer/*.log     \
		synthesizer/*.xml
