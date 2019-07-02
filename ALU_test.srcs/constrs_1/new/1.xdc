set_property BEL C5LUT [get_cells {u/your_instance_name/U0/xst_addsub/i_baseblox.i_baseblox_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[1].carryxor_i_1}]
set_property LOC SLICE_X48Y19 [get_cells {u/your_instance_name/U0/xst_addsub/i_baseblox.i_baseblox_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[1].carryxor_i_1}]
create_clock -period 5.000 -name clk -waveform {0.000 2.500} [get_ports clk]

set_property BEL B6LUT [get_cells i_1]
set_property LOC SLICE_X0Y2 [get_cells i_1]
set_property BEL D6LUT [get_cells i_0]
set_property LOC SLICE_X0Y2 [get_cells i_0]
set_property BEL D5LUT [get_cells {u/your_instance_name/U0/xst_addsub/i_baseblox.i_baseblox_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[2].carryxor_i_1}]
set_property LOC SLICE_X48Y19 [get_cells {u/your_instance_name/U0/xst_addsub/i_baseblox.i_baseblox_addsub/no_pipelining.the_addsub/i_lut6.i_lut6_addsub/i_simple_model.i_gt_1.carrychaingen[2].carryxor_i_1}]

set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk_IBUF_BUFG]

