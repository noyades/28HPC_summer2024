#################################################################################
#
# Created by Genus(TM) Synthesis Solution 21.11-s126_1 on Wed May 08 11:54:57 EDT 2024
#
#################################################################################

## library_sets
create_library_set -name wcl_slow \
    -timing { /software/RFIC/PDK/globalFoundries/22FDX-EXT/std_cells/v-logic_gf22nsdvlogl28edl116a/DesignWare_logic_libs/globalfoundaries22nhsda/28hd/edl/ulvt/latest/liberty/logic_synth_lvf/gf22nsdvlogl28edl116a_SSG_0P72V_0P00V_0P00V_0P00V_125C.lib }
create_library_set -name wcl_fast \
    -timing { /software/RFIC/PDK/globalFoundries/22FDX-EXT/std_cells/v-logic_gf22nsdvlogl28edl116a/DesignWare_logic_libs/globalfoundaries22nhsda/28hd/edl/ulvt/latest/liberty/logic_synth_lvf/gf22nsdvlogl28edl116a_FFG_0P88V_0P00V_0P00V_0P00V_M40C.lib }
create_library_set -name wcl_typical \
    -timing { /software/RFIC/PDK/globalFoundries/22FDX-EXT/std_cells/v-logic_gf22nsdvlogl28edl116a/DesignWare_logic_libs/globalfoundaries22nhsda/28hd/edl/ulvt/latest/liberty/logic_synth_lvf/gf22nsdvlogl28edl116a_TT_0P80V_0P00V_0P00V_0P00V_25C.lib }

## opcond
create_opcond -name op_cond_wcl_slow \
    -process 1.0 \
    -voltage 0.72 \
    -temperature 125.0
create_opcond -name op_cond_wcl_fast \
    -process 1.0 \
    -voltage 0.88 \
    -temperature -40.0
create_opcond -name op_cond_wcl_typical \
    -process 1.0 \
    -voltage 0.8 \
    -temperature 25.0

## timing_condition
create_timing_condition -name timing_cond_wcl_slow \
    -opcond op_cond_wcl_slow \
    -library_sets { wcl_slow }
create_timing_condition -name timing_cond_wcl_fast \
    -opcond op_cond_wcl_fast \
    -library_sets { wcl_fast }
create_timing_condition -name timing_cond_wcl_typical \
    -opcond op_cond_wcl_typical \
    -library_sets { wcl_typical }

## rc_corner
create_rc_corner -name worst \
    -temperature 125.0 \
    -qrc_tech /software/RFIC/PDK/globalFoundries/22FDX-EXT/release/PEX/QRC/9M_2Mx_5Cx_1Jx_1Ox_LBthick/FuncRCmax/qrcTechFile \
    -pre_route_res 1.0 \
    -pre_route_cap 1.0 \
    -pre_route_clock_res 0.0 \
    -pre_route_clock_cap 0.0 \
    -post_route_res {1.0 1.0 1.0} \
    -post_route_cap {1.0 1.0 1.0} \
    -post_route_cross_cap {1.0 1.0 1.0} \
    -post_route_clock_res {1.0 1.0 1.0} \
    -post_route_clock_cap {1.0 1.0 1.0}
create_rc_corner -name best \
    -temperature -40.0 \
    -qrc_tech /software/RFIC/PDK/globalFoundries/22FDX-EXT/release/PEX/QRC/9M_2Mx_5Cx_1Jx_1Ox_LBthick/FuncRCmin/qrcTechFile \
    -pre_route_res 1.0 \
    -pre_route_cap 1.0 \
    -pre_route_clock_res 0.0 \
    -pre_route_clock_cap 0.0 \
    -post_route_res {1.0 1.0 1.0} \
    -post_route_cap {1.0 1.0 1.0} \
    -post_route_cross_cap {1.0 1.0 1.0} \
    -post_route_clock_res {1.0 1.0 1.0} \
    -post_route_clock_cap {1.0 1.0 1.0}
create_rc_corner -name typical \
    -temperature 25.0 \
    -qrc_tech /software/RFIC/PDK/globalFoundries/22FDX-EXT/release/PEX/QRC/9M_2Mx_5Cx_1Jx_1Ox_LBthick/nominal/qrcTechFile \
    -pre_route_res 1.0 \
    -pre_route_cap 1.0 \
    -pre_route_clock_res 0.0 \
    -pre_route_clock_cap 0.0 \
    -post_route_res {1.0 1.0 1.0} \
    -post_route_cap {1.0 1.0 1.0} \
    -post_route_cross_cap {1.0 1.0 1.0} \
    -post_route_clock_res {1.0 1.0 1.0} \
    -post_route_clock_cap {1.0 1.0 1.0}

## delay_corner
create_delay_corner -name delay_corner_wcl_slow \
    -early_timing_condition { timing_cond_wcl_slow } \
    -late_timing_condition { timing_cond_wcl_slow } \
    -early_rc_corner worst \
    -late_rc_corner worst
create_delay_corner -name delay_corner_wcl_typical \
    -early_timing_condition { timing_cond_wcl_typical } \
    -late_timing_condition { timing_cond_wcl_typical } \
    -early_rc_corner typical \
    -late_rc_corner typical
create_delay_corner -name delay_corner_wcl_fast \
    -early_timing_condition { timing_cond_wcl_fast } \
    -late_timing_condition { timing_cond_wcl_fast } \
    -early_rc_corner best \
    -late_rc_corner best

## constraint_mode
create_constraint_mode -name functional_wcl_typical \
    -sdc_files { INVS/cmn/topPLLDigital.mmmc/modes/functional_wcl_typical/functional_wcl_typical.sdc.gz }
create_constraint_mode -name functional_wcl_fast \
    -sdc_files { INVS/cmn/topPLLDigital.mmmc/modes/functional_wcl_fast/functional_wcl_fast.sdc.gz }
create_constraint_mode -name functional_wcl_slow \
    -sdc_files { INVS/cmn/topPLLDigital.mmmc/modes/functional_wcl_slow/functional_wcl_slow.sdc.gz }

## analysis_view
create_analysis_view -name view_wcl_slow \
    -constraint_mode functional_wcl_slow \
    -delay_corner delay_corner_wcl_slow
create_analysis_view -name view_wcl_typical \
    -constraint_mode functional_wcl_typical \
    -delay_corner delay_corner_wcl_typical
create_analysis_view -name view_wcl_fast \
    -constraint_mode functional_wcl_fast \
    -delay_corner delay_corner_wcl_fast

## set_analysis_view
set_analysis_view -setup { view_wcl_slow view_wcl_fast view_wcl_typical } \
                  -hold { view_wcl_slow view_wcl_fast view_wcl_typical }

## latency
