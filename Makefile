TOP_MODULE  := TopWithResetFlipped# Use this for the arty 7
#TOP_MODULE  := Top# Use this for the pcb thingy
XILINX_PART := xc7a35ticsg324-1L# the arty 7 dev kit
#XILINX_PART := xc7a100tftg256-1#the artix on our pcb
BUILD_DIR   := synthesize
SCALA_TARGETS    := $(shell find src/main/scala/             -type f -name '*.scala')
VERILOG_TARGETS  := $(shell find src/main/resources/verilog/ -type f -name '*.v')
VHDL_TARGETS     := $(shell find src/main/resources/vhdl/ -mindepth 1 -maxdepth 1 -type d )
VHDL_DESTS       := $(patsubst src/main/resources/vhdl/%,$(BUILD_DIR)/include/%.v,$(VHDL_TARGETS))

FLAGS := ""
ifdef FAST
	FLAGS += FAST
endif
ifdef NO_EDIF # only relevant for USE_YOSYS
	FLAGS += NO_EDIF
	NETLIST_FORMAT := sv
else
	NETLIST_FORMAT := edif
endif

TOP_MODULE_FIRRTL_TARGET  := $(BUILD_DIR)/$(TOP_MODULE).fir
TOP_MODULE_VERILOG_TARGET := $(BUILD_DIR)/$(TOP_MODULE).v
TOP_MODULE_NETLIST_TARGET := $(BUILD_DIR)/$(TOP_MODULE).$(NETLIST_FORMAT)
TOP_MODULE_BITFILE_TARGET := $(BUILD_DIR)/$(TOP_MODULE).bit
CONSTRAINTS_FILE := constraints-$(XILINX_PART).xdc
All_VERILOG_TARGETS := $(TOP_MODULE_VERILOG_TARGET) $(VERILOG_TARGETS) $(VHDL_DESTS)


.PHONY: all
all: bitfile

all.v: $(All_VERILOG_TARGETS)
	cat $(All_VERILOG_TARGETS) > all.v

.PHONY: vivado
vivado: all.v $(CONSTRAINTS_FILE)
	cp -v all.v vivado/tut01/vivado.srcs/sources_1/new/top.v
	cp -v $(CONSTRAINTS_FILE) vivado/tut01/vivado.srcs/constrs_1/new/arty.xdc
	@echo Updated the vivado project named tut01 in vivado/tut01!

.PHONY: chisel
chisel: $(TOP_MODULE_VERILOG_TARGET)
	@echo Results are available in:
	@echo " " $(TOP_MODULE_FIRRTL_TARGET)
	@echo " " $(TOP_MODULE_VERILOG_TARGET)

.PHONY: bitfile
bitfile: $(VHDL_DESTS) $(TOP_MODULE_BITFILE_TARGET)

.PHONY: upload
upload:
	cd $(BUILD_DIR); ../scripts/upload_bitfile.sh ../$(TOP_MODULE_BITFILE_TARGET)

.PHONY: flash
flash:
	cd $(BUILD_DIR); ../scripts/flash_bitfile.sh ../$(TOP_MODULE_BITFILE_TARGET)

.PHONY: graphs graphs_yosys graphs_diagrammer
graphs: graphs_yosys graphs_diagrammer
graphs_yosys: $(TOP_MODULE_VERILOG_TARGET) $(VERILOG_TARGETS) $(VHDL_DESTS)
	rm -v graphs/yosys/* || true
	cd graphs; ../scripts/make_yosys_graphs.sh $(patsubst %,../%,$^)
graphs_diagrammer: $(TOP_MODULE_FIRRTL_TARGET) diagrammer/diagram.sh
	rm graphs/diagrammer/* || true
	cd diagrammer; ./diagram.sh -i ../$(TOP_MODULE_FIRRTL_TARGET) -t ../graphs/diagrammer  --dot-timeout-seconds 1000 -o '""'
diagrammer/diagram.sh:
	git submodule update --init

# todo: this won't re-make on edits for vhdl files
$(BUILD_DIR)/include/%.v: src/main/resources/vhdl/%
	cd $(BUILD_DIR); mkdir -p include
	cd $(BUILD_DIR); ../scripts/synth_vhdl.sh ../$@ $* ../$</*.vhd


$(TOP_MODULE_FIRRTL_TARGET): $(SCALA_TARGETS)
	sbt "run $(TOP_MODULE) $(TOP_MODULE_FIRRTL_TARGET)"

#%.v: %.fir
$(TOP_MODULE_VERILOG_TARGET): $(TOP_MODULE_FIRRTL_TARGET)
	firrtl -i $< -o $@ --info-mode=ignore -ll Info


ifdef USE_YOSYS  #========


$(TOP_MODULE_NETLIST_TARGET): $(TOP_MODULE_VERILOG_TARGET) $(VERILOG_TARGETS) $(VHDL_DESTS)
	cd $(BUILD_DIR); \
	../scripts/synth_netlist.sh $(FLAGS) $(TOP_MODULE) ../$(TOP_MODULE_NETLIST_TARGET) $(patsubst %,../%,$^)

$(TOP_MODULE_BITFILE_TARGET): $(CONSTRAINTS_FILE) $(TOP_MODULE_NETLIST_TARGET)
	cd $(BUILD_DIR); \

	../scripts/synth_bitfile.sh $(FLAGS) $(TOP_MODULE) $(XILINX_PART) ../$(CONSTRAINTS_FILE) ../$(TOP_MODULE_NETLIST_TARGET) ../$@

else # USE VIVADO ========


$(TOP_MODULE_BITFILE_TARGET): $(CONSTRAINTS_FILE) $(All_VERILOG_TARGETS)
	cd $(BUILD_DIR); \
	../scripts/synth_netlist_and_bitfile.sh $(FLAGS) $(TOP_MODULE) $(XILINX_PART) ../$(CONSTRAINTS_FILE) ../$@ $(patsubst %,../%,$(All_VERILOG_TARGETS))


endif # USE YOSYS/VIVADO ========


.PHONY: clean
clean:
	rm -vf all.v || true
	rm -vf $(TOP_MODULE_VERILOG_TARGET) || true
	rm -vf $(TOP_MODULE_FIRRTL_TARGET)  || true
	rm -vf $(TOP_MODULE_NETLIST_TARGET) || true
	rm -vf $(TOP_MODULE_BITFILE_TARGET) || true
	rm -v -rf \
		$(BUILD_DIR)/.Xil      \
		$(BUILD_DIR)/*.html    \
		$(BUILD_DIR)/*.jou     \
		$(BUILD_DIR)/*.log     \
		$(BUILD_DIR)/*.xml

.PHONY: clean_all
clean_all: clean
	rm -v -rf $(VHDL_DESTS)
