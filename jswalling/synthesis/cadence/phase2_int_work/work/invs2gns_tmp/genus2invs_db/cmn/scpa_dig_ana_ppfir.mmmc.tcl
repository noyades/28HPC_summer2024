#################################################################################
#
# Created by Genus(TM) Synthesis Solution 23.14-s090_1 on Mon Jan 26 12:14:29 EST 2026
#
#################################################################################

## library_sets
create_library_set -name PVT_0P90V_25C \
    -timing { /data/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_lvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_base_lvt_c30_tt_ctypical_max_0p90v_25c.lib \
              /data/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_lvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_hpk_lvt_c30_tt_ctypical_max_0p90v_25c.lib \
              /data/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_svt_c30/r0p0/lib/sc9mcpp140z_cln28ht_base_svt_c30_tt_ctypical_max_0p90v_25c.lib \
              /data/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_svt_c30/r0p0/lib/sc9mcpp140z_cln28ht_hpk_svt_c30_tt_ctypical_max_0p90v_25c.lib \
              /data/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_ulvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_base_ulvt_c30_tt_ctypical_max_0p90v_25c.lib \
              /data/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_ulvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_hpk_ulvt_c30_tt_ctypical_max_0p90v_25c.lib }
create_library_set -name PVT_0P81V_125C \
    -timing { /data/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_lvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_base_lvt_c30_ssg_cworstt_max_0p81v_125c.lib \
              /data/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_lvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_hpk_lvt_c30_ssg_cworstt_max_0p81v_125c.lib \
              /data/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_svt_c30/r0p0/lib/sc9mcpp140z_cln28ht_base_svt_c30_ssg_cworstt_max_0p81v_125c.lib \
              /data/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_svt_c30/r0p0/lib/sc9mcpp140z_cln28ht_hpk_svt_c30_ssg_cworstt_max_0p81v_125c.lib \
              /data/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_ulvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_base_ulvt_c30_ssg_cworstt_max_0p81v_125c.lib \
              /data/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_ulvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_hpk_ulvt_c30_ssg_cworstt_max_0p81v_125c.lib }
create_library_set -name PVT_0P99V_m40C \
    -timing { /data/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_lvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_base_lvt_c30_ffg_cbestt_min_0p99v_m40c.lib \
              /data/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_lvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_hpk_lvt_c30_ffg_cbestt_min_0p99v_m40c.lib \
              /data/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_svt_c30/r0p0/lib/sc9mcpp140z_cln28ht_base_svt_c30_ffg_cbestt_min_0p99v_m40c.lib \
              /data/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_svt_c30/r0p0/lib/sc9mcpp140z_cln28ht_hpk_svt_c30_ffg_cbestt_min_0p99v_m40c.lib \
              /data/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_ulvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_base_ulvt_c30_ffg_cbestt_min_0p99v_m40c.lib \
              /data/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_ulvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_hpk_ulvt_c30_ffg_cbestt_min_0p99v_m40c.lib }

## opcond
create_opcond -name max \
    -process 1.0 \
    -voltage 0.81 \
    -temperature 125.0
create_opcond -name min \
    -process 1.0 \
    -voltage 0.99 \
    -temperature -40.0
create_opcond -name typ \
    -process 1.0 \
    -voltage 0.9 \
    -temperature 25.0

## timing_condition
create_timing_condition -name slow \
    -opcond max \
    -library_sets { PVT_0P81V_125C }
create_timing_condition -name fast \
    -opcond min \
    -library_sets { PVT_0P99V_m40C }
create_timing_condition -name nom \
    -opcond typ \
    -library_sets { PVT_0P90V_25C }

## rc_corner
create_rc_corner -name rc_max \
    -temperature 125.0 \
    -qrc_tech /data/PDK/tsmc/28nm/tsri/RC_Extraction/Cadence/rcworst/qrcTechFile \
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
create_rc_corner -name rc_min \
    -temperature -40.0 \
    -qrc_tech /data/PDK/tsmc/28nm/tsri/RC_Extraction/Cadence/rcbest/qrcTechFile \
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
create_rc_corner -name rc_typ \
    -temperature 25.0 \
    -qrc_tech /data/PDK/tsmc/28nm/tsri/RC_Extraction/Cadence/nominal/qrcTechFile \
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
create_delay_corner -name slow_maxrc \
    -early_timing_condition { slow } \
    -late_timing_condition { slow } \
    -early_rc_corner rc_max \
    -late_rc_corner rc_max
create_delay_corner -name fast_minrc \
    -early_timing_condition { fast } \
    -late_timing_condition { fast } \
    -early_rc_corner rc_min \
    -late_rc_corner rc_min
create_delay_corner -name typ_typ \
    -early_timing_condition { nom } \
    -late_timing_condition { nom } \
    -early_rc_corner rc_typ \
    -late_rc_corner rc_typ

## constraint_mode
create_constraint_mode -name func \
    -sdc_files { ./invs2gns_tmp/genus2invs_db/cmn/scpa_dig_ana_ppfir.mmmc/modes/func/func.sdc.gz }
create_constraint_mode -name slow \
    -sdc_files { ./invs2gns_tmp/genus2invs_db/cmn/scpa_dig_ana_ppfir.mmmc/modes/slow/slow.sdc.gz }
create_constraint_mode -name fast \
    -sdc_files { ./invs2gns_tmp/genus2invs_db/cmn/scpa_dig_ana_ppfir.mmmc/modes/fast/fast.sdc.gz }

## analysis_view
create_analysis_view -name slow-slow-maxrc \
    -constraint_mode func \
    -delay_corner slow_maxrc \
    -latency_file ./invs2gns_tmp/genus2invs_db/cmn/scpa_dig_ana_ppfir.mmmc/views/slow-slow-maxrc/latency.sdc.gz
create_analysis_view -name fast-fast-minrc \
    -constraint_mode func \
    -delay_corner fast_minrc \
    -latency_file ./invs2gns_tmp/genus2invs_db/cmn/scpa_dig_ana_ppfir.mmmc/views/fast-fast-minrc/latency.sdc.gz
create_analysis_view -name func-typ-typ \
    -constraint_mode func \
    -delay_corner typ_typ \
    -latency_file ./invs2gns_tmp/genus2invs_db/cmn/scpa_dig_ana_ppfir.mmmc/views/func-typ-typ/latency.sdc.gz

## set_analysis_view
set_analysis_view -setup { slow-slow-maxrc fast-fast-minrc func-typ-typ } \
                  -hold { slow-slow-maxrc fast-fast-minrc func-typ-typ }
