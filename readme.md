tl;dr, we use scala and chisel, generate our netlist with yosys, synthesize our bitfiles with Vivado.

	make && make upload

# running tests

	sbt test


# using the Vivado gui

We have our vivado project in `vivado/tut01`

to update the files there with our code from chisel, run this

	make vivado

