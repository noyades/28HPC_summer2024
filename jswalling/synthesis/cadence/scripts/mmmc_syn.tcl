##################################################################
## LIBRARY SETS
##################################################################
create_library_set \
    -name          PVT_0P90V_25C \
    -timing \
                   [list \
             /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_lvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_base_lvt_c30_tt_ctypical_max_0p90v_25c.lib \
             /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_lvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_hpk_lvt_c30_tt_ctypical_max_0p90v_25c.lib \
             /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_svt_c30/r0p0/lib/sc9mcpp140z_cln28ht_base_svt_c30_tt_ctypical_max_0p90v_25c.lib \
             /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_svt_c30/r0p0/lib/sc9mcpp140z_cln28ht_hpk_svt_c30_tt_ctypical_max_0p90v_25c.lib \
             /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_ulvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_base_ulvt_c30_tt_ctypical_max_0p90v_25c.lib \
             /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_ulvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_hpk_ulvt_c30_tt_ctypical_max_0p90v_25c.lib \
                   ]

create_library_set \
    -name          PVT_0P81V_125C \
    -timing \
                   [list \
             /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_lvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_base_lvt_c30_ssg_cworstt_max_0p81v_125c.lib \
             /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_lvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_hpk_lvt_c30_ssg_cworstt_max_0p81v_125c.lib \
             /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_svt_c30/r0p0/lib/sc9mcpp140z_cln28ht_base_svt_c30_ssg_cworstt_max_0p81v_125c.lib \
             /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_svt_c30/r0p0/lib/sc9mcpp140z_cln28ht_hpk_svt_c30_ssg_cworstt_max_0p81v_125c.lib \
             /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_ulvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_base_ulvt_c30_ssg_cworstt_max_0p81v_125c.lib \
             /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_ulvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_hpk_ulvt_c30_ssg_cworstt_max_0p81v_125c.lib \
                   ]

create_library_set \
    -name          PVT_0P99V_m40C \
    -timing \
                   [list \
             /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_lvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_base_lvt_c30_ffg_cbestt_min_0p99v_m40c.lib \
             /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_lvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_hpk_lvt_c30_ffg_cbestt_min_0p99v_m40c.lib \
             /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_svt_c30/r0p0/lib/sc9mcpp140z_cln28ht_base_svt_c30_ffg_cbestt_min_0p99v_m40c.lib \
             /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_svt_c30/r0p0/lib/sc9mcpp140z_cln28ht_hpk_svt_c30_ffg_cbestt_min_0p99v_m40c.lib \
             /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_ulvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_base_ulvt_c30_ffg_cbestt_min_0p99v_m40c.lib \
             /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_ulvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_hpk_ulvt_c30_ffg_cbestt_min_0p99v_m40c.lib \
                   ]
##################################################################
## OP CONDITIONS
##################################################################

create_opcond \
     -name          max \
     -process       1 \
     -voltage       0.81 \
     -temperature   125

create_opcond \
     -name          min \
     -process       1 \
     -voltage       0.99 \
     -temperature   -40

create_opcond \
     -name          typ \
     -process       1 \
     -voltage       0.90 \
     -temperature   25

##################################################################
## OP CONDITIONS
##################################################################
create_timing_condition \
     -name          slow \
     -library_sets  [list PVT_0P81V_125C ] \
     -opcond        max


create_timing_condition \
     -name          fast \
     -library_sets  [list PVT_0P99V_m40C ] \
     -opcond        min


create_timing_condition \
     -name          nom \
     -library_sets  [list PVT_0P90V_25C ] \
     -opcond        typ


##################################################################
## RC CORNER
##################################################################
create_rc_corner \
     -name          rc_max \
     -temperature   125 \
     -qrc_tech /software/RFIC/PDK/tsmc/28nm/tsri/RC_Extraction/Cadence/rcworst/qrcTechFile

create_rc_corner \
     -name          rc_min \
     -temperature   -40 \
     -qrc_tech /software/RFIC/PDK/tsmc/28nm/tsri/RC_Extraction/Cadence/rcbest/qrcTechFile

create_rc_corner \
     -name          rc_typ \
     -temperature   25 \
     -qrc_tech /software/RFIC/PDK/tsmc/28nm/tsri/RC_Extraction/Cadence/nominal/qrcTechFile

##################################################################
## DELAY CORNER
##################################################################
create_delay_corner \
     -name             slow_maxrc \
     -timing_condition slow \
     -rc_corner        rc_max

create_delay_corner \
     -name             fast_minrc \
     -timing_condition fast \
     -rc_corner        rc_min

create_delay_corner \
     -name             typ_typ \
     -timing_condition nom \
     -rc_corner        rc_typ

##################################################################
## CONSTRAINT MODES
##################################################################
create_constraint_mode \
     -name             func \
     -sdc_files        [list \
                        ../constraints/pp_int_x4_struct.sdc \
                       ]

##################################################################
## ANALYSIS VIEWS
##################################################################
create_analysis_view \
     -name           func-slow-maxrc \
     -constraint_mode func \
     -delay_corner slow_maxrc

create_analysis_view \
     -name           func-fast-minrc \
     -constraint_mode func \
     -delay_corner fast_minrc

create_analysis_view \
     -name           func-typ-typ \
     -constraint_mode func \
     -delay_corner typ_typ

##################################################################
## ACTIVE VIEWS
##################################################################
set_analysis_view \
     -setup          [list func-slow-maxrc func-fast-minrc func-typ-typ]
     #-hold           [list func-fast-minrc] \
     #-leakage        [list func-typ-typ] \
     #-dynamic        [list func-typ-typ]
