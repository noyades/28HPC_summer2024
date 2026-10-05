create_library_set -name wcl_fast\
   -timing\
    [list /software/RFIC/PDK/globalFoundries/22FDX-EXT/std_cells/v-logic_gf22nsdslogl28edl116a/DesignWare_logic_libs/globalfoundaries22nhsda/28hd/edl/svt/latest/liberty/logic_synth_lvf/gf22nsdslogl28edl116a_FFG_0P88V_0P00V_0P00V_0P00V_M40C.lib]
create_library_set -name wcl_slow\
   -timing\
    [list /software/RFIC/PDK/globalFoundries/22FDX-EXT/std_cells/v-logic_gf22nsdslogl28edl116a/DesignWare_logic_libs/globalfoundaries22nhsda/28hd/edl/svt/latest/liberty/logic_synth_lvf/gf22nsdslogl28edl116a_SSG_0P72V_0P00V_0P00V_0P00V_125C.lib]
create_library_set -name wcl_typical\
   -timing\
    [list /software/RFIC/PDK/globalFoundries/22FDX-EXT/std_cells/v-logic_gf22nsdslogl28edl116a/DesignWare_logic_libs/globalfoundaries22nhsda/28hd/edl/svt/latest/liberty/logic_synth_lvf/gf22nsdslogl28edl116a_TT_0P80V_0P00V_0P00V_0P00V_25C.lib]
create_opcond -name op_cond_wcl_fast -process 1 -voltage 0.88 -temperature -40
create_opcond -name op_cond_wcl_typical -process 1 -voltage 0.8 -temperature 25
create_opcond -name op_cond_wcl_slow -process 1 -voltage 0.72 -temperature 125
create_timing_condition -name timing_cond_wcl_typical\
   -library_sets [list wcl_typical]\
   -opcond op_cond_wcl_typical
create_timing_condition -name timing_cond_wcl_slow\
   -library_sets [list wcl_slow]\
   -opcond op_cond_wcl_slow
create_timing_condition -name timing_cond_wcl_fast\
   -library_sets [list wcl_fast]\
   -opcond op_cond_wcl_fast
create_rc_corner -name worst\
   -pre_route_res 1\
   -post_route_res {1 1 1}\
   -pre_route_cap 1\
   -post_route_cap {1 1 1}\
   -post_route_cross_cap {1 1 1}\
   -pre_route_clock_res 0\
   -pre_route_clock_cap 0\
   -post_route_clock_cap {1 1 1}\
   -post_route_clock_res {1 1 1}\
   -temperature 125\
   -qrc_tech /software/RFIC/PDK/globalFoundries/22FDX-EXT/release/PEX/QRC/9M_2Mx_5Cx_1Jx_1Ox_LBthick/FuncRCmax/qrcTechFile
create_rc_corner -name best\
   -pre_route_res 1\
   -post_route_res {1 1 1}\
   -pre_route_cap 1\
   -post_route_cap {1 1 1}\
   -post_route_cross_cap {1 1 1}\
   -pre_route_clock_res 0\
   -pre_route_clock_cap 0\
   -post_route_clock_cap {1 1 1}\
   -post_route_clock_res {1 1 1}\
   -temperature -40\
   -qrc_tech /software/RFIC/PDK/globalFoundries/22FDX-EXT/release/PEX/QRC/9M_2Mx_5Cx_1Jx_1Ox_LBthick/FuncRCmin/qrcTechFile
create_rc_corner -name typical\
   -pre_route_res 1\
   -post_route_res {1 1 1}\
   -pre_route_cap 1\
   -post_route_cap {1 1 1}\
   -post_route_cross_cap {1 1 1}\
   -pre_route_clock_res 0\
   -pre_route_clock_cap 0\
   -post_route_clock_cap {1 1 1}\
   -post_route_clock_res {1 1 1}\
   -temperature 25\
   -qrc_tech /software/RFIC/PDK/globalFoundries/22FDX-EXT/release/PEX/QRC/9M_2Mx_5Cx_1Jx_1Ox_LBthick/nominal/qrcTechFile
create_delay_corner -name delay_corner_wcl_slow\
   -early_timing_condition {timing_cond_wcl_slow}\
   -late_timing_condition {timing_cond_wcl_slow}\
   -rc_corner worst
create_delay_corner -name delay_corner_wcl_typical\
   -early_timing_condition {timing_cond_wcl_typical}\
   -late_timing_condition {timing_cond_wcl_typical}\
   -rc_corner typical
create_delay_corner -name delay_corner_wcl_fast\
   -early_timing_condition {timing_cond_wcl_fast}\
   -late_timing_condition {timing_cond_wcl_fast}\
   -rc_corner best
create_constraint_mode -name functional_wcl_typical\
   -sdc_files\
    [list /home/micsTapeouts/projects/22FDX_winter2023/jswalling/genus/spi_trim/work/OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.mmmc/modes/functional_wcl_typical/functional_wcl_typical.sdc.gz]
create_constraint_mode -name functional_wcl_fast\
   -sdc_files\
    [list /home/micsTapeouts/projects/22FDX_winter2023/jswalling/genus/spi_trim/work/OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.mmmc/modes/functional_wcl_fast/functional_wcl_fast.sdc.gz]
create_constraint_mode -name functional_wcl_slow\
   -sdc_files\
    [list /home/micsTapeouts/projects/22FDX_winter2023/jswalling/genus/spi_trim/work/OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.mmmc/modes/functional_wcl_slow/functional_wcl_slow.sdc.gz]
create_analysis_view -name view_wcl_slow -constraint_mode functional_wcl_slow -delay_corner delay_corner_wcl_slow -latency_file /home/micsTapeouts/projects/22FDX_winter2023/jswalling/genus/spi_trim/work/OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.mmmc/views/view_wcl_slow/latency.sdc.gz
create_analysis_view -name view_wcl_typical -constraint_mode functional_wcl_typical -delay_corner delay_corner_wcl_typical -latency_file /home/micsTapeouts/projects/22FDX_winter2023/jswalling/genus/spi_trim/work/OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.mmmc/views/view_wcl_typical/latency.sdc.gz
create_analysis_view -name view_wcl_fast -constraint_mode functional_wcl_fast -delay_corner delay_corner_wcl_fast -latency_file /home/micsTapeouts/projects/22FDX_winter2023/jswalling/genus/spi_trim/work/OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.mmmc/views/view_wcl_fast/latency.sdc.gz
set_analysis_view -setup [list view_wcl_slow view_wcl_fast view_wcl_typical] -hold [list view_wcl_slow view_wcl_fast view_wcl_typical]
