#set_property BEL B6LUT [get_cells {mu_u/genblk3[5].SnS_box_u_prod_l/LUT6_2_SnS_box}]
#set_property BEL A6LUT [get_cells mu_u/comp32_u_s1_15_2/LUT6_2_comp32_box]
#set_property LOC SLICE_X7Y32 [get_cells {mu_u/genblk3[5].SnS_box_u_prod_l/LUT6_2_SnS_box/LUT5}]
#set_property LOC SLICE_X7Y32 [get_cells {mu_u/genblk3[5].SnS_box_u_prod_l/LUT6_2_SnS_box/LUT6}]
create_clock -period 6.500 -name clk -waveform {0.000 3.250} -add [get_ports clk]











#set_property BEL A6LUT [get_cells mu_u/comp233_u_s1_16/LUT5_comp233_2_box]
#set_property LOC SLICE_X2Y31 [get_cells mu_u/comp233_u_s1_16/LUT5_comp233_2_box]
#set_property BEL D6LUT [get_cells mu_u/comp153_u_s2_16/LUT6_comp153_1_box]
#set_property LOC SLICE_X2Y29 [get_cells mu_u/comp153_u_s2_16/LUT6_comp153_1_box]
#set_property BEL C6LUT [get_cells {mu_u/genblk3[1].genblk1[6].A_box_u_prod_l/LUT5_A_box}]
#set_property LOC SLICE_X7Y27 [get_cells {mu_u/genblk3[1].genblk1[6].A_box_u_prod_l/LUT5_A_box}]
#set_property BEL DFF [get_cells {b_i_reg[1]}]
#set_property LOC SLICE_X7Y28 [get_cells {b_i_reg[1]}]
#set_property BEL A5LUT [get_cells {mu_u/genblk3[2].genblk1[10].A_box_u_prod_l/LUT5_A_box}]
#set_property LOC SLICE_X7Y28 [get_cells {mu_u/genblk3[2].genblk1[10].A_box_u_prod_l/LUT5_A_box}]
#set_property BEL DFF [get_cells {b_i_reg[2]}]
#set_property LOC SLICE_X7Y27 [get_cells {b_i_reg[2]}]
#set_property BEL CFF [get_cells {b_i_reg[6]}]
#set_property LOC SLICE_X6Y27 [get_cells {b_i_reg[6]}]
#set_property BEL D6LUT [get_cells mu_u/comp32_u_s2_13_2/LUT6_2_comp32_box]
#set_property LOC SLICE_X6Y26 [get_cells mu_u/comp32_u_s2_13_2/LUT6_2_comp32_box]
#set_property BEL B6LUT [get_cells {mu_u/genblk8[13].comp32_u_s3_11_26/LUT6_2_comp32_box}]
#set_property LOC SLICE_X3Y29 [get_cells {mu_u/genblk8[13].comp32_u_s3_11_26/LUT6_2_comp32_box}]
#set_property BEL C6LUT [get_cells mu_u/comp32_u_s1_12_2/LUT6_2_comp32_box]
#set_property LOC SLICE_X7Y26 [get_cells mu_u/comp32_u_s1_12_2/LUT6_2_comp32_box]
#set_property BEL D6LUT [get_cells {mu_u/genblk3[4].genblk1[6].A_box_u_prod_l/LUT5_A_box}]
#set_property LOC SLICE_X7Y26 [get_cells {mu_u/genblk3[4].genblk1[6].A_box_u_prod_l/LUT5_A_box}]
#set_property BEL C6LUT [get_cells {mu_u/genblk3[5].genblk1[4].A_box_u_prod_l/LUT5_A_box}]
#set_property LOC SLICE_X6Y26 [get_cells {mu_u/genblk3[5].genblk1[4].A_box_u_prod_l/LUT5_A_box}]
#set_property BEL BFF [get_cells {b_i_reg[5]}]
#set_property LOC SLICE_X7Y28 [get_cells {b_i_reg[5]}]
#set_property BEL D6LUT [get_cells {mu_u/genblk3[4].genblk1[9].A_box_u_prod_l/LUT5_A_box}]
#set_property LOC SLICE_X6Y25 [get_cells {mu_u/genblk3[4].genblk1[9].A_box_u_prod_l/LUT5_A_box}]
#set_property BEL B6LUT [get_cells {mu_u/genblk3[6].genblk1[5].A_box_u_prod_l/LUT5_A_box}]
#set_property LOC SLICE_X7Y26 [get_cells {mu_u/genblk3[6].genblk1[5].A_box_u_prod_l/LUT5_A_box}]
#set_property BEL D6LUT [get_cells {mu_u/genblk3[5].genblk1[7].A_box_u_prod_l/LUT5_A_box}]
#set_property LOC SLICE_X7Y25 [get_cells {mu_u/genblk3[5].genblk1[7].A_box_u_prod_l/LUT5_A_box}]
#set_property BEL BFF [get_cells {b_i_reg[10]}]
#set_property LOC SLICE_X7Y27 [get_cells {b_i_reg[10]}]
#set_property BEL BFF [get_cells {b_i_reg[0]}]
#set_property LOC SLICE_X3Y30 [get_cells {b_i_reg[0]}]
#set_property BEL CFF [get_cells {b_i_reg[13]}]
#set_property LOC SLICE_X3Y30 [get_cells {b_i_reg[13]}]
#set_property BEL A5FF [get_cells {A_reg[3]}]
#set_property LOC SLICE_X6Y28 [get_cells {A_reg[3]}]
#set_property BEL RAMB18E1 [get_cells {your_itance_name/U0/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM18.ram}]
#set_property LOC RAMB18_X0Y10 [get_cells {your_itance_name/U0/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM18.ram}]
#set_property BEL CFF [get_cells {b_i_reg[7]}]
#set_property LOC SLICE_X7Y28 [get_cells {b_i_reg[7]}]
#set_property BEL C6LUT [get_cells {mu_u/genblk3[5].genblk1[12].A_box_u_prod_l/LUT5_A_box}]
#set_property LOC SLICE_X7Y32 [get_cells {mu_u/genblk3[5].genblk1[12].A_box_u_prod_l/LUT5_A_box}]
#set_property BEL B6LUT [get_cells {mu_u/genblk3[6].genblk1[2].A_box_u_prod_l/LUT5_A_box}]
#set_property LOC SLICE_X7Y27 [get_cells {mu_u/genblk3[6].genblk1[2].A_box_u_prod_l/LUT5_A_box}]

#set_property BEL C5FF [get_cells {b_i_reg[3]}]
#set_property LOC SLICE_X7Y28 [get_cells {b_i_reg[3]}]



