
set config_proj_name project_StreamingMaxPool_hls_2
puts "HLS project: $config_proj_name"
set config_hwsrcdir "/home/phu/repos/PytorchModClassNew/finn/notebooks/Radio_27ML/tmp//code_gen_ipgen_StreamingMaxPool_hls_2_mdqppi07"
puts "HW source dir: $config_hwsrcdir"
set config_proj_part "xczu7ev-ffvc1156-2-e"
set config_bnnlibdir "$::env(FINN_ROOT)/deps/finn-hlslib"
puts "finn-hlslib dir: $config_bnnlibdir"
set config_customhlsdir "$::env(FINN_ROOT)/custom_hls"
puts "custom HLS dir: $config_customhlsdir"
set config_toplevelfxn "StreamingMaxPool_hls_2"
set config_clkperiod 4.0

open_project $config_proj_name
add_files $config_hwsrcdir/top_StreamingMaxPool_hls_2.cpp -cflags "-std=c++14 -I$config_bnnlibdir -I$config_customhlsdir"

set_top $config_toplevelfxn
open_solution sol1
set_part $config_proj_part

set_param hls.enable_hidden_option_error false
config_compile -disable_unroll_code_size_check -pipeline_style flp
config_interface -m_axi_addr64
config_rtl -module_auto_prefix
config_rtl -deadlock_detection none


create_clock -period $config_clkperiod -name default
csynth_design
export_design -format ip_catalog
exit 0
