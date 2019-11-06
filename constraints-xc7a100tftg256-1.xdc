## Artix 7 100T constraints file, autogenerated for SADIE
## Device/Package xc7a100tftg256 6/6/2012 10:19:27

#Copied from the arty one lol
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

set_property -dict {PACKAGE_PIN N6 IOSTANDARD LVCMOS33} [get_ports { reset }];
#Clock
set_property -dict {PACKAGE_PIN N11 IOSTANDARD LVCMOS33} [get_ports { clock }];
create_clock -add -name sys_clk_pin -period 62.5 \
    -waveform {0 31.25} [get_ports { clock }];

#set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33 } [get_ports { mcu[1] }]; #IO_L10N_T1_D15_14
#set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33 } [get_ports { mcu[0] }]; #IO_L10P_T1_D14_14
set_property -dict { PACKAGE_PIN R16   IOSTANDARD LVCMOS33 } [get_ports { io_led_green }]; #IO_L9N_T1_DQS_D13_14
set_property DRIVE 8 [get_ports { io_led_green }]
#set_property -dict { PACKAGE_PIN R15   IOSTANDARD LVCMOS33 } [get_ports { led_red }]; #IO_L9P_T1_DQS_14
#set_property -dict { PACKAGE_PIN P13   IOSTANDARD LVCMOS33 } [get_ports { mcu[2] }]; #IO_L11N_T1_SRCC_14
#
## I2S
set_property -dict { PACKAGE_PIN K13   IOSTANDARD LVCMOS33 } [get_ports { io_DataBit }]; #IO_L4N_T0_D05_14
set_property -dict { PACKAGE_PIN L13   IOSTANDARD LVCMOS33 } [get_ports { io_LeftRightWordClock }]; #IO_L4P_T0_D04_14
set_property -dict { PACKAGE_PIN L14   IOSTANDARD LVCMOS33 } [get_ports { io_SystemClock }]; #IO_L5N_T0_D07_14
set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports { io_BitClock }]; #IO_L5P_T0_D06_14

# SPI
set_property -dict {PACKAGE_PIN M16 IOSTANDARD LVCMOS33} [get_ports { io_spi_mosi }];      #IO_L11P_T1_SRCC_15 Sch=jb_p[1]
set_property -dict {PACKAGE_PIN N16 IOSTANDARD LVCMOS33} [get_ports { io_spi_miso }];      #IO_L11N_T1_SRCC_15 Sch=jb_n[1]
set_property -dict {PACKAGE_PIN P15 IOSTANDARD LVCMOS33} [get_ports { io_spi_clk  }];      #IO_L12P_T1_MRCC_15 Sch=jb_p[2]
set_property -dict {PACKAGE_PIN P16 IOSTANDARD LVCMOS33} [get_ports { io_spi_cs_n }];      #IO_L12N_T1_MRCC_15 Sch=jb_n[2]

# GPIO
set_property -dict { PACKAGE_PIN R10   IOSTANDARD LVCMOS33 } [get_ports { io_gpio }]; 

#set_property --dict { PACKAGE_PIN T9    IOSTANDARD LVCMOS33 } [get_ports { io_l22p_t3_a05_d21_14 }]; #IO_L22P_T3_A05_D21_14
#set_property --dict { PACKAGE_PIN T8    IOSTANDARD LVCMOS33 } [get_ports { io_l21n_t3_dqs_a06_d22_14 }]; #IO_L21N_T3_DQS_A06_D22_14
#set_property --dict { PACKAGE_PIN T7    IOSTANDARD LVCMOS33 } [get_ports { io_l21p_t3_dqs_14 }]; #IO_L21P_T3_DQS_14
#set_property --dict { PACKAGE_PIN T5    IOSTANDARD LVCMOS33 } [get_ports { io_l23n_t3_a02_d18_14 }]; #IO_L23N_T3_A02_D18_14
#set_property --dict { PACKAGE_PIN T4    IOSTANDARD LVCMOS33 } [get_ports { io_l9p_t1_dqs_34 }]; #IO_L9P_T1_DQS_34
#set_property --dict { PACKAGE_PIN T3    IOSTANDARD LVCMOS33 } [get_ports { io_l9n_t1_dqs_34 }]; #IO_L9N_T1_DQS_34
#set_property --dict { PACKAGE_PIN T2    IOSTANDARD LVCMOS33 } [get_ports { io_l8n_t1_34 }]; #IO_L8N_T1_34
#set_property --dict { PACKAGE_PIN T13   IOSTANDARD LVCMOS33 } [get_ports { io_l16n_t2_a15_d31_14 }]; #IO_L16N_T2_A15_D31_14
#set_property --dict { PACKAGE_PIN T12   IOSTANDARD LVCMOS33 } [get_ports { io_l15n_t2_dqs_dout_cso_b_14 }]; #IO_L15N_T2_DQS_DOUT_CSO_B_14
#set_property --dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33 } [get_ports { io_l22n_t3_a04_d20_14 }]; #IO_L22N_T3_A04_D20_14
#set_property --dict { PACKAGE_PIN R8    IOSTANDARD LVCMOS33 } [get_ports { io_l20n_t3_a07_d23_14 }]; #IO_L20N_T3_A07_D23_14
#set_property --dict { PACKAGE_PIN R7    IOSTANDARD LVCMOS33 } [get_ports { io_l24n_t3_a00_d16_14 }]; #IO_L24N_T3_A00_D16_14
#set_property --dict { PACKAGE_PIN R6    IOSTANDARD LVCMOS33 } [get_ports { io_l24p_t3_a01_d17_14 }]; #IO_L24P_T3_A01_D17_14
#set_property --dict { PACKAGE_PIN R5    IOSTANDARD LVCMOS33 } [get_ports { io_l23p_t3_a03_d19_14 }]; #IO_L23P_T3_A03_D19_14
#set_property --dict { PACKAGE_PIN R3    IOSTANDARD LVCMOS33 } [get_ports { io_l8p_t1_34 }]; #IO_L8P_T1_34
#set_property --dict { PACKAGE_PIN R2    IOSTANDARD LVCMOS33 } [get_ports { io_l7p_t1_34 }]; #IO_L7P_T1_34
#set_property --dict { PACKAGE_PIN R13   IOSTANDARD LVCMOS33 } [get_ports { io_l16p_t2_csi_b_14 }]; #IO_L16P_T2_CSI_B_14
#set_property --dict { PACKAGE_PIN R12   IOSTANDARD LVCMOS33 } [get_ports { io_l15p_t2_dqs_rdwr_b_14 }]; #IO_L15P_T2_DQS_RDWR_B_14
#set_property --dict { PACKAGE_PIN R11   IOSTANDARD LVCMOS33 } [get_ports { io_l17n_t2_a13_d29_14 }]; #IO_L17N_T2_A13_D29_14
#set_property --dict { PACKAGE_PIN R10   IOSTANDARD LVCMOS33 } [get_ports { io_l17p_t2_a14_d30_14 }]; #IO_L17P_T2_A14_D30_14
#set_property --dict { PACKAGE_PIN R1    IOSTANDARD LVCMOS33 } [get_ports { io_l7n_t1_34 }]; #IO_L7N_T1_34
#set_property --dict { PACKAGE_PIN P9    IOSTANDARD LVCMOS33 } [get_ports { io_l18n_t2_a11_d27_14 }]; #IO_L18N_T2_A11_D27_14
#set_property --dict { PACKAGE_PIN P8    IOSTANDARD LVCMOS33 } [get_ports { io_l20p_t3_a08_d24_14 }]; #IO_L20P_T3_A08_D24_14
#set_property --dict { PACKAGE_PIN P6    IOSTANDARD LVCMOS33 } [get_ports { io_25_14 }]; #IO_25_14
#set_property --dict { PACKAGE_PIN P5    IOSTANDARD LVCMOS33 } [get_ports { io_l10p_t1_34 }]; #IO_L10P_T1_34
#set_property --dict { PACKAGE_PIN P4    IOSTANDARD LVCMOS33 } [get_ports { io_l5p_t0_34 }]; #IO_L5P_T0_34
#set_property --dict { PACKAGE_PIN P3    IOSTANDARD LVCMOS33 } [get_ports { io_l5n_t0_34 }]; #IO_L5N_T0_34
#set_property --dict { PACKAGE_PIN P16   IOSTANDARD LVCMOS33 } [get_ports { io_l8n_t1_d12_14 }]; #IO_L8N_T1_D12_14
#set_property --dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports { io_l8p_t1_d11_14 }]; #IO_L8P_T1_D11_14
#set_property --dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports { io_l12n_t1_mrcc_14 }]; #IO_L12N_T1_MRCC_14
#set_property --dict { PACKAGE_PIN P11   IOSTANDARD LVCMOS33 } [get_ports { io_l14n_t2_srcc_14 }]; #IO_L14N_T2_SRCC_14
#set_property --dict { PACKAGE_PIN P10   IOSTANDARD LVCMOS33 } [get_ports { io_l14p_t2_srcc_14 }]; #IO_L14P_T2_SRCC_14
#set_property --dict { PACKAGE_PIN P1    IOSTANDARD LVCMOS33 } [get_ports { io_l4n_t0_34 }]; #IO_L4N_T0_34
#set_property --dict { PACKAGE_PIN N9    IOSTANDARD LVCMOS33 } [get_ports { io_l18p_t2_a12_d28_14 }]; #IO_L18P_T2_A12_D28_14
#set_property --dict { PACKAGE_PIN N6    IOSTANDARD LVCMOS33 } [get_ports { io_l19n_t3_a09_d25_vref_14 }]; #IO_L19N_T3_A09_D25_VREF_14
#set_property --dict { PACKAGE_PIN N4    IOSTANDARD LVCMOS33 } [get_ports { io_l6n_t0_vref_34 }]; #IO_L6N_T0_VREF_34
#set_property --dict { PACKAGE_PIN N3    IOSTANDARD LVCMOS33 } [get_ports { io_l3p_t0_dqs_34 }]; #IO_L3P_T0_DQS_34
#set_property --dict { PACKAGE_PIN N2    IOSTANDARD LVCMOS33 } [get_ports { io_l3n_t0_dqs_34 }]; #IO_L3N_T0_DQS_34
#set_property --dict { PACKAGE_PIN N16   IOSTANDARD LVCMOS33 } [get_ports { io_l7n_t1_d10_14 }]; #IO_L7N_T1_D10_14
#set_property --dict { PACKAGE_PIN N14   IOSTANDARD LVCMOS33 } [get_ports { io_l12p_t1_mrcc_14 }]; #IO_L12P_T1_MRCC_14
#set_property --dict { PACKAGE_PIN N13   IOSTANDARD LVCMOS33 } [get_ports { io_l11p_t1_srcc_14 }]; #IO_L11P_T1_SRCC_14
#set_property --dict { PACKAGE_PIN N12   IOSTANDARD LVCMOS33 } [get_ports { io_l13n_t2_mrcc_14 }]; #IO_L13N_T2_MRCC_14
#set_property --dict { PACKAGE_PIN N11   IOSTANDARD LVCMOS33 } [get_ports { io_l13p_t2_mrcc_14 }]; #IO_L13P_T2_MRCC_14
#set_property --dict { PACKAGE_PIN N1    IOSTANDARD LVCMOS33 } [get_ports { io_l4p_t0_34 }]; #IO_L4P_T0_34
#set_property --dict { PACKAGE_PIN M6    IOSTANDARD LVCMOS33 } [get_ports { io_l19p_t3_a10_d26_14 }]; #IO_L19P_T3_A10_D26_14
#set_property --dict { PACKAGE_PIN M5    IOSTANDARD LVCMOS33 } [get_ports { io_l6p_t0_34 }]; #IO_L6P_T0_34
#set_property --dict { PACKAGE_PIN M4    IOSTANDARD LVCMOS33 } [get_ports { io_l1n_t0_34 }]; #IO_L1N_T0_34
#set_property --dict { PACKAGE_PIN M2    IOSTANDARD LVCMOS33 } [get_ports { io_l2p_t0_34 }]; #IO_L2P_T0_34
#set_property --dict { PACKAGE_PIN M16   IOSTANDARD LVCMOS33 } [get_ports { io_l7p_t1_d09_14 }]; #IO_L7P_T1_D09_14
#set_property --dict { PACKAGE_PIN M15   IOSTANDARD LVCMOS33 } [get_ports { io_l3n_t0_dqs_emcclk_14 }]; #IO_L3N_T0_DQS_EMCCLK_14
#set_property --dict { PACKAGE_PIN M12   IOSTANDARD LVCMOS33 } [get_ports { io_l6n_t0_d08_vref_14 }]; #IO_L6N_T0_D08_VREF_14
#set_property --dict { PACKAGE_PIN M1    IOSTANDARD LVCMOS33 } [get_ports { io_l2n_t0_34 }]; #IO_L2N_T0_34
#set_property --dict { PACKAGE_PIN L5    IOSTANDARD LVCMOS33 } [get_ports { io_0_34 }]; #IO_0_34
#set_property --dict { PACKAGE_PIN L4    IOSTANDARD LVCMOS33 } [get_ports { io_l1p_t0_34 }]; #IO_L1P_T0_34
#set_property --dict { PACKAGE_PIN L3    IOSTANDARD LVCMOS33 } [get_ports { io_l23p_t3_35 }]; #IO_L23P_T3_35
#set_property --dict { PACKAGE_PIN L2    IOSTANDARD LVCMOS33 } [get_ports { io_l23n_t3_35 }]; #IO_L23N_T3_35
#set_property --dict { PACKAGE_PIN L15   IOSTANDARD LVCMOS33 } [get_ports { io_l3p_t0_dqs_pudc_b_14 }]; #IO_L3P_T0_DQS_PUDC_B_14
#set_property --dict { PACKAGE_PIN L12   IOSTANDARD LVCMOS33 } [get_ports { io_l6p_t0_fcs_b_14 }]; #IO_L6P_T0_FCS_B_14
#set_property --dict { PACKAGE_PIN K5    IOSTANDARD LVCMOS33 } [get_ports { io_25_35 }]; #IO_25_35
#set_property --dict { PACKAGE_PIN K3    IOSTANDARD LVCMOS33 } [get_ports { io_l24p_t3_35 }]; #IO_L24P_T3_35
#set_property --dict { PACKAGE_PIN K2    IOSTANDARD LVCMOS33 } [get_ports { io_l24n_t3_35 }]; #IO_L24N_T3_35
#set_property --dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS33 } [get_ports { io_l2n_t0_d03_14 }]; #IO_L2N_T0_D03_14
#set_property --dict { PACKAGE_PIN K15   IOSTANDARD LVCMOS33 } [get_ports { io_l2p_t0_d02_14 }]; #IO_L2P_T0_D02_14
#set_property --dict { PACKAGE_PIN K12   IOSTANDARD LVCMOS33 } [get_ports { io_0_14 }]; #IO_0_14
#set_property --dict { PACKAGE_PIN K1    IOSTANDARD LVCMOS33 } [get_ports { io_l22p_t3_35 }]; #IO_L22P_T3_35
#set_property --dict { PACKAGE_PIN J5    IOSTANDARD LVCMOS33 } [get_ports { io_l19p_t3_35 }]; #IO_L19P_T3_35
#set_property --dict { PACKAGE_PIN J4    IOSTANDARD LVCMOS33 } [get_ports { io_l19n_t3_vref_35 }]; #IO_L19N_T3_VREF_35
#set_property --dict { PACKAGE_PIN J3    IOSTANDARD LVCMOS33 } [get_ports { io_l21p_t3_dqs_35 }]; #IO_L21P_T3_DQS_35
#set_property --dict { PACKAGE_PIN J16   IOSTANDARD LVCMOS33 } [get_ports { io_l23n_t3_fwe_b_15 }]; #IO_L23N_T3_FWE_B_15
#set_property --dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { io_l23p_t3_foe_b_15 }]; #IO_L23P_T3_FOE_B_15
#set_property --dict { PACKAGE_PIN J14   IOSTANDARD LVCMOS33 } [get_ports { io_l1n_t0_d01_din_14 }]; #IO_L1N_T0_D01_DIN_14
#set_property --dict { PACKAGE_PIN J13   IOSTANDARD LVCMOS33 } [get_ports { io_l1p_t0_d00_mosi_14 }]; #IO_L1P_T0_D00_MOSI_14
#set_property --dict { PACKAGE_PIN J1    IOSTANDARD LVCMOS33 } [get_ports { io_l22n_t3_35 }]; #IO_L22N_T3_35
#set_property --dict { PACKAGE_PIN H5    IOSTANDARD LVCMOS33 } [get_ports { io_l18p_t2_35 }]; #IO_L18P_T2_35
#set_property --dict { PACKAGE_PIN H4    IOSTANDARD LVCMOS33 } [get_ports { io_l18n_t2_35 }]; #IO_L18N_T2_35
#set_property --dict { PACKAGE_PIN H3    IOSTANDARD LVCMOS33 } [get_ports { io_l21n_t3_dqs_35 }]; #IO_L21N_T3_DQS_35
#set_property --dict { PACKAGE_PIN H2    IOSTANDARD LVCMOS33 } [get_ports { io_l20p_t3_35 }]; #IO_L20P_T3_35
#set_property --dict { PACKAGE_PIN H16   IOSTANDARD LVCMOS33 } [get_ports { io_l22p_t3_a17_15 }]; #IO_L22P_T3_A17_15
#set_property --dict { PACKAGE_PIN H14   IOSTANDARD LVCMOS33 } [get_ports { io_l24p_t3_rs1_15 }]; #IO_L24P_T3_RS1_15
#set_property --dict { PACKAGE_PIN H13   IOSTANDARD LVCMOS33 } [get_ports { io_l20n_t3_a19_15 }]; #IO_L20N_T3_A19_15
#set_property --dict { PACKAGE_PIN H12   IOSTANDARD LVCMOS33 } [get_ports { io_l20p_t3_a20_15 }]; #IO_L20P_T3_A20_15
#set_property --dict { PACKAGE_PIN H11   IOSTANDARD LVCMOS33 } [get_ports { io_l19p_t3_a22_15 }]; #IO_L19P_T3_A22_15
#set_property --dict { PACKAGE_PIN H1    IOSTANDARD LVCMOS33 } [get_ports { io_l20n_t3_35 }]; #IO_L20N_T3_35
#set_property --dict { PACKAGE_PIN G5    IOSTANDARD LVCMOS33 } [get_ports { io_l16p_t2_35 }]; #IO_L16P_T2_35
#set_property --dict { PACKAGE_PIN G4    IOSTANDARD LVCMOS33 } [get_ports { io_l16n_t2_35 }]; #IO_L16N_T2_35
#set_property --dict { PACKAGE_PIN G2    IOSTANDARD LVCMOS33 } [get_ports { io_l17p_t2_35 }]; #IO_L17P_T2_35
#set_property --dict { PACKAGE_PIN G16   IOSTANDARD LVCMOS33 } [get_ports { io_l22n_t3_a16_15 }]; #IO_L22N_T3_A16_15
#set_property --dict { PACKAGE_PIN G15   IOSTANDARD LVCMOS33 } [get_ports { io_l24n_t3_rs0_15 }]; #IO_L24N_T3_RS0_15
#set_property --dict { PACKAGE_PIN G14   IOSTANDARD LVCMOS33 } [get_ports { io_l21p_t3_dqs_15 }]; #IO_L21P_T3_DQS_15
#set_property --dict { PACKAGE_PIN G12   IOSTANDARD LVCMOS33 } [get_ports { io_l19n_t3_a21_vref_15 }]; #IO_L19N_T3_A21_VREF_15
#set_property --dict { PACKAGE_PIN G11   IOSTANDARD LVCMOS33 } [get_ports { io_25_15 }]; #IO_25_15
#set_property --dict { PACKAGE_PIN G1    IOSTANDARD LVCMOS33 } [get_ports { io_l17n_t2_35 }]; #IO_L17N_T2_35
#set_property --dict { PACKAGE_PIN F5    IOSTANDARD LVCMOS33 } [get_ports { io_l13p_t2_mrcc_35 }]; #IO_L13P_T2_MRCC_35
#set_property --dict { PACKAGE_PIN F4    IOSTANDARD LVCMOS33 } [get_ports { io_l14p_t2_srcc_35 }]; #IO_L14P_T2_SRCC_35
#set_property --dict { PACKAGE_PIN F3    IOSTANDARD LVCMOS33 } [get_ports { io_l14n_t2_srcc_35 }]; #IO_L14N_T2_SRCC_35
#set_property --dict { PACKAGE_PIN F2    IOSTANDARD LVCMOS33 } [get_ports { io_l15p_t2_dqs_35 }]; #IO_L15P_T2_DQS_35
#set_property --dict { PACKAGE_PIN F15   IOSTANDARD LVCMOS33 } [get_ports { io_l18p_t2_a24_15 }]; #IO_L18P_T2_A24_15
#set_property --dict { PACKAGE_PIN F14   IOSTANDARD LVCMOS33 } [get_ports { io_l21n_t3_dqs_a18_15 }]; #IO_L21N_T3_DQS_A18_15
#set_property --dict { PACKAGE_PIN F13   IOSTANDARD LVCMOS33 } [get_ports { io_l16n_t2_a27_15 }]; #IO_L16N_T2_A27_15
#set_property --dict { PACKAGE_PIN F12   IOSTANDARD LVCMOS33 } [get_ports { io_l16p_t2_a28_15 }]; #IO_L16P_T2_A28_15
#set_property --dict { PACKAGE_PIN E6    IOSTANDARD LVCMOS33 } [get_ports { io_0_35 }]; #IO_0_35
#set_property --dict { PACKAGE_PIN E5    IOSTANDARD LVCMOS33 } [get_ports { io_l13n_t2_mrcc_35 }]; #IO_L13N_T2_MRCC_35
#set_property --dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { io_l11p_t1_srcc_35 }]; #IO_L11P_T1_SRCC_35
#set_property --dict { PACKAGE_PIN E2    IOSTANDARD LVCMOS33 } [get_ports { io_l10p_t1_ad15p_35 }]; #IO_L10P_T1_AD15P_35
#set_property --dict { PACKAGE_PIN E16   IOSTANDARD LVCMOS33 } [get_ports { io_l17p_t2_a26_15 }]; #IO_L17P_T2_A26_15
#set_property --dict { PACKAGE_PIN E15   IOSTANDARD LVCMOS33 } [get_ports { io_l18n_t2_a23_15 }]; #IO_L18N_T2_A23_15
#set_property --dict { PACKAGE_PIN E13   IOSTANDARD LVCMOS33 } [get_ports { io_l13n_t2_mrcc_15 }]; #IO_L13N_T2_MRCC_15
#set_property --dict { PACKAGE_PIN E12   IOSTANDARD LVCMOS33 } [get_ports { io_l13p_t2_mrcc_15 }]; #IO_L13P_T2_MRCC_15
#set_property --dict { PACKAGE_PIN E11   IOSTANDARD LVCMOS33 } [get_ports { io_l14p_t2_srcc_15 }]; #IO_L14P_T2_SRCC_15
#set_property --dict { PACKAGE_PIN E1    IOSTANDARD LVCMOS33 } [get_ports { io_l15n_t2_dqs_35 }]; #IO_L15N_T2_DQS_35
#set_property --dict { PACKAGE_PIN D9    IOSTANDARD LVCMOS33 } [get_ports { io_l6n_t0_vref_15 }]; #IO_L6N_T0_VREF_15
#set_property --dict { PACKAGE_PIN D8    IOSTANDARD LVCMOS33 } [get_ports { io_l6p_t0_15 }]; #IO_L6P_T0_15
#set_property --dict { PACKAGE_PIN D6    IOSTANDARD LVCMOS33 } [get_ports { io_l6p_t0_35 }]; #IO_L6P_T0_35
#set_property --dict { PACKAGE_PIN D5    IOSTANDARD LVCMOS33 } [get_ports { io_l6n_t0_vref_35 }]; #IO_L6N_T0_VREF_35
#set_property --dict { PACKAGE_PIN D4    IOSTANDARD LVCMOS33 } [get_ports { io_l12p_t1_mrcc_35 }]; #IO_L12P_T1_MRCC_35
#set_property --dict { PACKAGE_PIN D3    IOSTANDARD LVCMOS33 } [get_ports { io_l11n_t1_srcc_35 }]; #IO_L11N_T1_SRCC_35
#set_property --dict { PACKAGE_PIN D16   IOSTANDARD LVCMOS33 } [get_ports { io_l17n_t2_a25_15 }]; #IO_L17N_T2_A25_15
#set_property --dict { PACKAGE_PIN D15   IOSTANDARD LVCMOS33 } [get_ports { io_l15n_t2_dqs_adv_b_15 }]; #IO_L15N_T2_DQS_ADV_B_15
#set_property --dict { PACKAGE_PIN D14   IOSTANDARD LVCMOS33 } [get_ports { io_l15p_t2_dqs_15 }]; #IO_L15P_T2_DQS_15
#set_property --dict { PACKAGE_PIN D13   IOSTANDARD LVCMOS33 } [get_ports { io_l12p_t1_mrcc_15 }]; #IO_L12P_T1_MRCC_15
#set_property --dict { PACKAGE_PIN D11   IOSTANDARD LVCMOS33 } [get_ports { io_l14n_t2_srcc_15 }]; #IO_L14N_T2_SRCC_15
#set_property --dict { PACKAGE_PIN D10   IOSTANDARD LVCMOS33 } [get_ports { io_0_15 }]; #IO_0_15
#set_property --dict { PACKAGE_PIN D1    IOSTANDARD LVCMOS33 } [get_ports { io_l10n_t1_ad15n_35 }]; #IO_L10N_T1_AD15N_35
#set_property --dict { PACKAGE_PIN C9    IOSTANDARD LVCMOS33 } [get_ports { io_l1n_t0_ad0n_15 }]; #IO_L1N_T0_AD0N_15
#set_property --dict { PACKAGE_PIN C8    IOSTANDARD LVCMOS33 } [get_ports { io_l1p_t0_ad0p_15 }]; #IO_L1P_T0_AD0P_15
#set_property --dict { PACKAGE_PIN C7    IOSTANDARD LVCMOS33 } [get_ports { io_l5p_t0_ad13p_35 }]; #IO_L5P_T0_AD13P_35
#set_property --dict { PACKAGE_PIN C6    IOSTANDARD LVCMOS33 } [get_ports { io_l5n_t0_ad13n_35 }]; #IO_L5N_T0_AD13N_35
#set_property --dict { PACKAGE_PIN C4    IOSTANDARD LVCMOS33 } [get_ports { io_l12n_t1_mrcc_35 }]; #IO_L12N_T1_MRCC_35
#set_property --dict { PACKAGE_PIN C3    IOSTANDARD LVCMOS33 } [get_ports { io_l7p_t1_ad6p_35 }]; #IO_L7P_T1_AD6P_35
#set_property --dict { PACKAGE_PIN C2    IOSTANDARD LVCMOS33 } [get_ports { io_l7n_t1_ad6n_35 }]; #IO_L7N_T1_AD6N_35
#set_property --dict { PACKAGE_PIN C16   IOSTANDARD LVCMOS33 } [get_ports { io_l10p_t1_ad11p_15 }]; #IO_L10P_T1_AD11P_15
#set_property --dict { PACKAGE_PIN C14   IOSTANDARD LVCMOS33 } [get_ports { io_l8p_t1_ad10p_15 }]; #IO_L8P_T1_AD10P_15
#set_property --dict { PACKAGE_PIN C13   IOSTANDARD LVCMOS33 } [get_ports { io_l12n_t1_mrcc_15 }]; #IO_L12N_T1_MRCC_15
#set_property --dict { PACKAGE_PIN C12   IOSTANDARD LVCMOS33 } [get_ports { io_l11n_t1_srcc_15 }]; #IO_L11N_T1_SRCC_15
#set_property --dict { PACKAGE_PIN C11   IOSTANDARD LVCMOS33 } [get_ports { io_l11p_t1_srcc_15 }]; #IO_L11P_T1_SRCC_15
#set_property --dict { PACKAGE_PIN C1    IOSTANDARD LVCMOS33 } [get_ports { io_l9p_t1_dqs_ad7p_35 }]; #IO_L9P_T1_DQS_AD7P_35
#set_property --dict { PACKAGE_PIN B9    IOSTANDARD LVCMOS33 } [get_ports { io_l3p_t0_dqs_ad1p_15 }]; #IO_L3P_T0_DQS_AD1P_15
#set_property --dict { PACKAGE_PIN B7    IOSTANDARD LVCMOS33 } [get_ports { io_l1p_t0_ad4p_35 }]; #IO_L1P_T0_AD4P_35
#set_property --dict { PACKAGE_PIN B6    IOSTANDARD LVCMOS33 } [get_ports { io_l2p_t0_ad12p_35 }]; #IO_L2P_T0_AD12P_35
#set_property --dict { PACKAGE_PIN B5    IOSTANDARD LVCMOS33 } [get_ports { io_l2n_t0_ad12n_35 }]; #IO_L2N_T0_AD12N_35
#set_property --dict { PACKAGE_PIN B4    IOSTANDARD LVCMOS33 } [get_ports { io_l4p_t0_35 }]; #IO_L4P_T0_35
#set_property --dict { PACKAGE_PIN B2    IOSTANDARD LVCMOS33 } [get_ports { io_l8p_t1_ad14p_35 }]; #IO_L8P_T1_AD14P_35
#set_property --dict { PACKAGE_PIN B16   IOSTANDARD LVCMOS33 } [get_ports { io_l10n_t1_ad11n_15 }]; #IO_L10N_T1_AD11N_15
#set_property --dict { PACKAGE_PIN B15   IOSTANDARD LVCMOS33 } [get_ports { io_l9p_t1_dqs_ad3p_15 }]; #IO_L9P_T1_DQS_AD3P_15
#set_property --dict { PACKAGE_PIN B14   IOSTANDARD LVCMOS33 } [get_ports { io_l8n_t1_ad10n_15 }]; #IO_L8N_T1_AD10N_15
#set_property --dict { PACKAGE_PIN B12   IOSTANDARD LVCMOS33 } [get_ports { io_l5p_t0_ad9p_15 }]; #IO_L5P_T0_AD9P_15
#set_property --dict { PACKAGE_PIN B11   IOSTANDARD LVCMOS33 } [get_ports { io_l4n_t0_15 }]; #IO_L4N_T0_15
#set_property --dict { PACKAGE_PIN B10   IOSTANDARD LVCMOS33 } [get_ports { io_l4p_t0_15 }]; #IO_L4P_T0_15
#set_property --dict { PACKAGE_PIN B1    IOSTANDARD LVCMOS33 } [get_ports { io_l9n_t1_dqs_ad7n_35 }]; #IO_L9N_T1_DQS_AD7N_35
#set_property --dict { PACKAGE_PIN A9    IOSTANDARD LVCMOS33 } [get_ports { io_l2n_t0_ad8n_15 }]; #IO_L2N_T0_AD8N_15
#set_property --dict { PACKAGE_PIN A8    IOSTANDARD LVCMOS33 } [get_ports { io_l2p_t0_ad8p_15 }]; #IO_L2P_T0_AD8P_15
#set_property --dict { PACKAGE_PIN A7    IOSTANDARD LVCMOS33 } [get_ports { io_l1n_t0_ad4n_35 }]; #IO_L1N_T0_AD4N_35
#set_property --dict { PACKAGE_PIN A5    IOSTANDARD LVCMOS33 } [get_ports { io_l3p_t0_dqs_ad5p_35 }]; #IO_L3P_T0_DQS_AD5P_35
#set_property --dict { PACKAGE_PIN A4    IOSTANDARD LVCMOS33 } [get_ports { io_l3n_t0_dqs_ad5n_35 }]; #IO_L3N_T0_DQS_AD5N_35
#set_property --dict { PACKAGE_PIN A3    IOSTANDARD LVCMOS33 } [get_ports { io_l4n_t0_35 }]; #IO_L4N_T0_35
#set_property --dict { PACKAGE_PIN A2    IOSTANDARD LVCMOS33 } [get_ports { io_l8n_t1_ad14n_35 }]; #IO_L8N_T1_AD14N_35
#set_property --dict { PACKAGE_PIN A15   IOSTANDARD LVCMOS33 } [get_ports { io_l9n_t1_dqs_ad3n_15 }]; #IO_L9N_T1_DQS_AD3N_15
#set_property --dict { PACKAGE_PIN A14   IOSTANDARD LVCMOS33 } [get_ports { io_l7n_t1_ad2n_15 }]; #IO_L7N_T1_AD2N_15
#set_property --dict { PACKAGE_PIN A13   IOSTANDARD LVCMOS33 } [get_ports { io_l7p_t1_ad2p_15 }]; #IO_L7P_T1_AD2P_15
#set_property --dict { PACKAGE_PIN A12   IOSTANDARD LVCMOS33 } [get_ports { io_l5n_t0_ad9n_15 }]; #IO_L5N_T0_AD9N_15
#set_property --dict { PACKAGE_PIN A10   IOSTANDARD LVCMOS33 } [get_ports { io_l3n_t0_dqs_ad1n_15 }]; #IO_L3N_T0_DQS_AD1N_15
