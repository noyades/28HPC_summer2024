#################################################################################
#
# Created by Genus(TM) Synthesis Solution 23.10-p004_1 on Mon Feb 17 21:07:15 EST 2025
#
#################################################################################

## library_sets
create_library_set -name wcl_fast \
    -timing { /projects/eddie_pritchard/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_lvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_base_lvt_c30_ffg_cbestt_min_0p99v_m40c.lib }
create_library_set -name wcl_slow \
    -timing { /projects/eddie_pritchard/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_lvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_base_lvt_c30_ssg_cworstt_max_0p81v_125c.lib }
create_library_set -name wcl_typical \
    -timing { /projects/eddie_pritchard/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_lvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_base_lvt_c30_tt_ctypical_max_0p90v_25c.lib }

## opcond
create_opcond -name op_cond_wcl_fast \
    -process 1.0 \
    -voltage 0.99 \
    -temperature -40.0
create_opcond -name op_cond_wcl_typical \
    -process 1.0 \
    -voltage 0.9 \
    -temperature 25.0
create_opcond -name op_cond_wcl_slow \
    -process 1.0 \
    -voltage 0.81 \
    -temperature 125.0

## timing_condition
create_timing_condition -name timing_cond_wcl_typical \
    -opcond op_cond_wcl_typical \
    -library_sets { wcl_typical }
create_timing_condition -name timing_cond_wcl_slow \
    -opcond op_cond_wcl_slow \
    -library_sets { wcl_slow }
create_timing_condition -name timing_cond_wcl_fast \
    -opcond op_cond_wcl_fast \
    -library_sets { wcl_fast }

## rc_corner
create_rc_corner -name worst \
    -temperature 125.0 \
    -qrc_tech /projects/eddie_pritchard/RFIC/PDK/tsmc/28nm/v1.8_2p3a_10M/RC_Extraction/Cadence/rcworst/qrcTechFile \
    -pre_route_res 1.0 \
    -pre_route_cap 1.0 \
    -pre_route_clock_res 0.0 \
    -pre_route_clock_cap 0.0 \
    -post_route_res {1.0 1.0 1.0} \
    -post_route_cap {1.0 1.0 1.0} \
    -post_route_cross_cap {1.0 1.0 1.0} \
    -post_route_clock_res {1.0 1.0 1.0} \
    -post_route_clock_cap {1.0 1.0 1.0} \
    -post_route_clock_cross_cap {1.0 1.0 1.0}
create_rc_corner -name best \
    -temperature -40.0 \
    -qrc_tech /projects/eddie_pritchard/RFIC/PDK/tsmc/28nm/v1.8_2p3a_10M/RC_Extraction/Cadence/rcbest/qrcTechFile \
    -pre_route_res 1.0 \
    -pre_route_cap 1.0 \
    -pre_route_clock_res 0.0 \
    -pre_route_clock_cap 0.0 \
    -post_route_res {1.0 1.0 1.0} \
    -post_route_cap {1.0 1.0 1.0} \
    -post_route_cross_cap {1.0 1.0 1.0} \
    -post_route_clock_res {1.0 1.0 1.0} \
    -post_route_clock_cap {1.0 1.0 1.0} \
    -post_route_clock_cross_cap {1.0 1.0 1.0}
create_rc_corner -name typical \
    -temperature 25.0 \
    -qrc_tech /projects/eddie_pritchard/RFIC/PDK/tsmc/28nm/v1.8_2p3a_10M/RC_Extraction/Cadence/nominal/qrcTechFile \
    -pre_route_res 1.0 \
    -pre_route_cap 1.0 \
    -pre_route_clock_res 0.0 \
    -pre_route_clock_cap 0.0 \
    -post_route_res {1.0 1.0 1.0} \
    -post_route_cap {1.0 1.0 1.0} \
    -post_route_cross_cap {1.0 1.0 1.0} \
    -post_route_clock_res {1.0 1.0 1.0} \
    -post_route_clock_cap {1.0 1.0 1.0} \
    -post_route_clock_cross_cap {1.0 1.0 1.0}

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
    -sdc_files { INVS/cmn/pp_fir_u_6.mmmc/modes/functional_wcl_typical/functional_wcl_typical.sdc.gz }
create_constraint_mode -name functional_wcl_fast \
    -sdc_files { INVS/cmn/pp_fir_u_6.mmmc/modes/functional_wcl_fast/functional_wcl_fast.sdc.gz }
create_constraint_mode -name functional_wcl_slow \
    -sdc_files { INVS/cmn/pp_fir_u_6.mmmc/modes/functional_wcl_slow/functional_wcl_slow.sdc.gz }

## analysis_view
create_analysis_view -name view_wcl_slow \
    -constraint_mode functional_wcl_typical \
    -delay_corner delay_corner_wcl_slow
create_analysis_view -name view_wcl_typical \
    -constraint_mode functional_wcl_typical \
    -delay_corner delay_corner_wcl_typical
create_analysis_view -name view_wcl_fast \
    -constraint_mode functional_wcl_typical \
    -delay_corner delay_corner_wcl_fast

## set_analysis_view
set_analysis_view -setup { view_wcl_slow view_wcl_fast view_wcl_typical } \
                  -hold { view_wcl_slow view_wcl_fast view_wcl_typical }

## latency
update_analysis_view -name view_wcl_slow -constraint_mode functional_wcl_typical -latency_file INVS/cmn/pp_fir_u_6.mmmc/views/view_wcl_slow/latency.sdc.gz
update_analysis_view -name view_wcl_typical -constraint_mode functional_wcl_typical -latency_file INVS/cmn/pp_fir_u_6.mmmc/views/view_wcl_typical/latency.sdc.gz
update_analysis_view -name view_wcl_fast -constraint_mode functional_wcl_typical -latency_file INVS/cmn/pp_fir_u_6.mmmc/views/view_wcl_fast/latency.sdc.gz
