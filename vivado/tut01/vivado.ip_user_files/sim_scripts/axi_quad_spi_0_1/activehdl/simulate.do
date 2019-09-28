onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+axi_quad_spi_0 -L dist_mem_gen_v8_0_13 -L lib_pkg_v1_0_2 -L lib_cdc_v1_0_2 -L lib_srl_fifo_v1_0_2 -L fifo_generator_v13_2_4 -L lib_fifo_v1_0_13 -L axi_lite_ipif_v3_0_4 -L interrupt_control_v3_1_4 -L axi_quad_spi_v3_2_18 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.axi_quad_spi_0 xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {axi_quad_spi_0.udo}

run -all

endsim

quit -force
