create_library_set -name wcl_fast\
   -timing\
    [list /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_lvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_base_lvt_c30_ffg_cbestt_min_0p99v_m40c.lib]
create_library_set -name wcl_slow\
   -timing\
    [list /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_lvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_base_lvt_c30_ssg_cworstt_max_0p81v_125c.lib]
create_library_set -name wcl_typical\
   -timing\
    [list /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_lvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_base_lvt_c30_tt_ctypical_max_0p90v_25c.lib]
create_opcond -name op_cond_wcl_fast -process 1 -voltage 0.99 -temperature -40
create_opcond -name op_cond_wcl_typical -process 1 -voltage 0.9 -temperature 25
create_opcond -name op_cond_wcl_slow -process 1 -voltage 0.81 -temperature 125
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
   -qrc_tech /software/RFIC/PDK/tsmc/28nm/v1.8_2p3a_10M/RC_Extraction/Cadence/rcworst/qrcTechFile
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
   -qrc_tech /software/RFIC/PDK/tsmc/28nm/v1.8_2p3a_10M/RC_Extraction/Cadence/rcbest/qrcTechFile
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
   -qrc_tech /software/RFIC/PDK/tsmc/28nm/v1.8_2p3a_10M/RC_Extraction/Cadence/nominal/qrcTechFile
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
    [list /home/micsTapeouts/projects/28HPC_summer2024/jswalling/synthesis/cadence/pp_fir_u_7_work/OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/invs2genus_final_db/cmn/pp_fir_u_7.mmmc/modes/functional_wcl_typical/functional_wcl_typical.sdc]
create_constraint_mode -name functional_wcl_fast\
   -sdc_files\
    [list /home/micsTapeouts/projects/28HPC_summer2024/jswalling/synthesis/cadence/pp_fir_u_7_work/OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/invs2genus_final_db/cmn/pp_fir_u_7.mmmc/modes/functional_wcl_fast/functional_wcl_fast.sdc.gz]
create_constraint_mode -name functional_wcl_slow\
   -sdc_files\
    [list /home/micsTapeouts/projects/28HPC_summer2024/jswalling/synthesis/cadence/pp_fir_u_7_work/OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/invs2genus_final_db/cmn/pp_fir_u_7.mmmc/modes/functional_wcl_slow/functional_wcl_slow.sdc.gz]
create_analysis_view -name view_wcl_slow -constraint_mode functional_wcl_typical -delay_corner delay_corner_wcl_slow -latency_file /home/micsTapeouts/projects/28HPC_summer2024/jswalling/synthesis/cadence/pp_fir_u_7_work/OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/invs2genus_final_db/cmn/pp_fir_u_7.mmmc/views/view_wcl_slow/latency.sdc
create_analysis_view -name view_wcl_typical -constraint_mode functional_wcl_typical -delay_corner delay_corner_wcl_typical -latency_file /home/micsTapeouts/projects/28HPC_summer2024/jswalling/synthesis/cadence/pp_fir_u_7_work/OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/invs2genus_final_db/cmn/pp_fir_u_7.mmmc/views/view_wcl_typical/latency.sdc
create_analysis_view -name view_wcl_fast -constraint_mode functional_wcl_typical -delay_corner delay_corner_wcl_fast -latency_file /home/micsTapeouts/projects/28HPC_summer2024/jswalling/synthesis/cadence/pp_fir_u_7_work/OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/invs2genus_final_db/cmn/pp_fir_u_7.mmmc/views/view_wcl_fast/latency.sdc
set_analysis_view -setup [list view_wcl_slow view_wcl_fast view_wcl_typical] -hold [list view_wcl_slow view_wcl_fast view_wcl_typical]
