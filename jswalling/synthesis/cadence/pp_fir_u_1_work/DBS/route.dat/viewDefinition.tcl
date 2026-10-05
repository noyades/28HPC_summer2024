if {![namespace exists ::IMEX]} { namespace eval ::IMEX {} }
set ::IMEX::dataVar [file dirname [file normalize [info script]]]
set ::IMEX::libVar ${::IMEX::dataVar}/libs

create_library_set -name wcl_fast\
   -timing\
    [list ${::IMEX::libVar}/mmmc/sc9mcpp140z_cln28ht_base_lvt_c30_ffg_cbestt_min_0p99v_m40c.lib]
create_library_set -name wcl_slow\
   -timing\
    [list ${::IMEX::libVar}/mmmc/sc9mcpp140z_cln28ht_base_lvt_c30_ssg_cworstt_max_0p81v_125c.lib]
create_library_set -name wcl_typical\
   -timing\
    [list ${::IMEX::libVar}/mmmc/sc9mcpp140z_cln28ht_base_lvt_c30_tt_ctypical_max_0p90v_25c.lib]
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
   -post_route_clock_cross_cap {1 1 1}\
   -temperature 125\
   -qrc_tech ${::IMEX::libVar}/mmmc/worst/qrcTechFile
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
   -post_route_clock_cross_cap {1 1 1}\
   -temperature -40\
   -qrc_tech ${::IMEX::libVar}/mmmc/best/qrcTechFile
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
   -post_route_clock_cross_cap {1 1 1}\
   -temperature 25\
   -qrc_tech ${::IMEX::libVar}/mmmc/typical/qrcTechFile
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
    [list ${::IMEX::dataVar}/mmmc/modes/functional_wcl_typical/functional_wcl_typical.sdc.gz]
create_constraint_mode -name functional_wcl_fast\
   -sdc_files\
    [list ${::IMEX::libVar}/mmmc/functional_wcl_fast.sdc.gz]
create_constraint_mode -name functional_wcl_slow\
   -sdc_files\
    [list ${::IMEX::libVar}/mmmc/functional_wcl_slow.sdc.gz]
create_analysis_view -name view_wcl_slow -constraint_mode functional_wcl_typical -delay_corner delay_corner_wcl_slow -latency_file ${::IMEX::dataVar}/mmmc/views/view_wcl_slow/latency.sdc.gz
create_analysis_view -name view_wcl_typical -constraint_mode functional_wcl_typical -delay_corner delay_corner_wcl_typical -latency_file ${::IMEX::dataVar}/mmmc/views/view_wcl_typical/latency.sdc.gz
create_analysis_view -name view_wcl_fast -constraint_mode functional_wcl_typical -delay_corner delay_corner_wcl_fast -latency_file ${::IMEX::dataVar}/mmmc/views/view_wcl_fast/latency.sdc.gz
set_analysis_view -setup [list view_wcl_slow view_wcl_fast view_wcl_typical] -hold [list view_wcl_slow view_wcl_fast view_wcl_typical]
