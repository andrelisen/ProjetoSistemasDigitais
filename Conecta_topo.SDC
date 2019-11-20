create_clock -period 7.000 -name osc_clk clk
set_input_delay -clock osc_clk 0.1 [all_inputs]
set_output_delay -clock osc_clk 0.1 [all_outputs]
derive_pll_clocks
derive_clock_uncertainty