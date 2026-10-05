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
create_op_cond -name wcl_fast -library_file ${::IMEX::libVar}/mmmc/sc9mcpp140z_cln28ht_base_lvt_c30_ffg_cbestt_min_0p99v_m40c.lib -P 1 -V 0.99 -T -40
create_op_cond -name wcl_slow -library_file ${::IMEX::libVar}/mmmc/sc9mcpp140z_cln28ht_base_lvt_c30_ssg_cworstt_max_0p81v_125c.lib -P 1 -V 0.81 -T 125
create_op_cond -name wcl_typical -library_file ${::IMEX::libVar}/mmmc/sc9mcpp140z_cln28ht_base_lvt_c30_tt_ctypical_max_0p90v_25c.lib -P 1 -V 0.9 -T 25
create_rc_corner -name worst\
   -cap_table ${::IMEX::libVar}/mmmc/crn28hpc+_1p09m+ut-alrdl_6x1z1u_rcworst.captab\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0\
   -T 125\
   -qx_tech_file ${::IMEX::libVar}/mmmc/worst/qrcTechFile
create_rc_corner -name best\
   -cap_table ${::IMEX::libVar}/mmmc/crn28hpc+_1p09m+ut-alrdl_6x1z1u_rcbest.captab\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0\
   -T -40\
   -qx_tech_file ${::IMEX::libVar}/mmmc/best/qrcTechFile
create_rc_corner -name typical\
   -cap_table ${::IMEX::libVar}/mmmc/crn28hpc+_1p09m+ut-alrdl_6x1z1u_typical.captab\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0\
   -T 25\
   -qx_tech_file ${::IMEX::libVar}/mmmc/typical/qrcTechFile
create_delay_corner -name delay_corner_wcl_slow\
   -library_set wcl_slow\
   -rc_corner worst
create_delay_corner -name delay_corner_wcl_typical\
   -library_set wcl_typical\
   -rc_corner typical
create_delay_corner -name delay_corner_wcl_fast\
   -library_set wcl_fast\
   -rc_corner best
create_constraint_mode -name functional_wcl_typical\
   -sdc_files\
    [list ${::IMEX::libVar}/mmmc/pp_fir_u_0_struct.sdc]
create_constraint_mode -name functional_wcl_fast\
   -sdc_files\
    [list ${::IMEX::libVar}/mmmc/pp_fir_u_0_struct_fast.sdc]
create_constraint_mode -name functional_wcl_slow\
   -sdc_files\
    [list ${::IMEX::libVar}/mmmc/pp_fir_u_0_struct_slow.sdc]
create_analysis_view -name view_wcl_slow -constraint_mode functional_wcl_slow -delay_corner delay_corner_wcl_slow
create_analysis_view -name view_wcl_typical -constraint_mode functional_wcl_typical -delay_corner delay_corner_wcl_typical
create_analysis_view -name view_wcl_fast -constraint_mode functional_wcl_fast -delay_corner delay_corner_wcl_fast
set_analysis_view -setup [list view_wcl_slow view_wcl_fast view_wcl_typical] -hold [list view_wcl_slow view_wcl_fast view_wcl_typical]
