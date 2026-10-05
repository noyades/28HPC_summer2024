if {[file exists /proc/cpuinfo]} {
  sh grep "model name" /proc/cpuinfo
  sh grep "cpu MHz"    /proc/cpuinfo
}

puts "Hostname : [info hostname]"

set DESIGN pp_fir_u_2
set SYN_EFF medium
set MAP_EFF medium
set OPT_EFF medium

set RELEASE [lindex [get_db program_version] end]
set _OUTPUTS_PATH OUTPUT/outputs_${RELEASE}
set _REPORTS_PATH OUTPUT/reports_${RELEASE}
set _LOG_PATH OUTPUT/logs_${RELEASE}

if {![file exists ${_OUTPUTS_PATH}]} {
  file mkdir ${_OUTPUTS_PATH}
  puts "Creating directory ${_OUTPUTS_PATH}"
}

if {![file exists ${_REPORTS_PATH}]} {
  file mkdir ${_REPORTS_PATH}
  puts "Creating directory ${_REPORTS_PATH}"
}

if {![file exists ${_LOG_PATH}]} {
  file mkdir ${_LOG_PATH}
  puts "Creating directory ${_REPORTS_PATH}"
}

set rtlDir ../rtl

set_db init_lib_search_path {. /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/arm_tech/ \
                               /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_lvt_c30/ \
                               /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_lvt_c30/ }
set_db script_search_path { . }
set_db init_hdl_search_path {. ../rtl}

set_db max_cpus_per_server 8

set_db syn_generic_effort $SYN_EFF
set_db syn_map_effort $MAP_EFF
set_db syn_opt_effort $OPT_EFF

set_db information_level 9

set_db tns_opto true
#set_db lp_insert_clock_gating true
set_db opt_spatial_effort standard

set_db invs_temp_dir ${_OUTPUTS_PATH}/invs_tmp_dir

puts "Now load RTL LIST"
set rtlList "\
${rtlDir}/pp_fir.v \
${rtlDir}/pp_fir_u_7.v \
${rtlDir}/pp_fir_u_6.v \
${rtlDir}/pp_fir_u_5.v \
${rtlDir}/pp_fir_u_4.v \
${rtlDir}/pp_fir_u_3.v \
${rtlDir}/pp_fir_u_2.v \
${rtlDir}/pp_fir_u_1.v \
${rtlDir}/pp_fir_u_0.v \
${rtlDir}/pp_fir_7.v \
${rtlDir}/pp_fir_6.v \
${rtlDir}/pp_fir_5.v \
${rtlDir}/pp_fir_4.v \
${rtlDir}/pp_fir_3.v \
${rtlDir}/pp_fir_2.v \
${rtlDir}/pp_fir_1.v \
${rtlDir}/pp_fir_0.v \
${rtlDir}/signed_mag.v \
${rtlDir}/b2u_8to255_quad.v \
"
suspend

## Read in the MMMC setup
read_mmmc ../scripts/mmmc.tcl

read_physical -lefs { \
  /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/arm_tech/r1p0/lef/1p10m_7x2r_utalrdl/sc9mcpp140z_tech.lef \
  /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_lvt_c30/r0p0/lef/sc9mcpp140z_cln28ht_base_lvt_c30.lef \
  /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_lvt_c30/r0p0/lef/sc9mcpp140z_cln28ht_hpk_lvt_c30.lef
}

read_hdl $rtlList
elaborate $DESIGN

set init_pwr_net {VDD}
set init_gnd_net {VSS}
init_design
#globalNetConnect VSS -type tielo -pin VSS -all verbose
#globalNetConnect VSS -type pgpin -pin VSS -all verbose
#globalNetConnect VDD -type tiehi -pin VDD -all verbose
#globalNetConnect VDD -type pgpin -pin VDD -all verbose
time_info init_design
check_design -unresolved
check_timing_intent

#
#set_db [get_db modules Discrete_FIR_Filter_1] .retime true
#set_db [get_db modules Discrete_FIR_Filter_1] .ungroup_ok false
#set_db [get_db modules Discrete_FIR_Filter_1] .retime_hard_region true
#set_db retime_verification_flow true
#set_db syn_generic_effort high

#Initial Synthesis of the design
syn_generic
write_snapshot -directory $_OUTPUTS_PATH -tag syn_generic
report_summary -directory $_REPORTS_PATH
time_info GENERIC

#suspend 

set_db syn_map_effort high
set_db syn_opt_effort high

syn_map
write_snapshot -directory $_OUTPUTS_PATH -tag syn_map
report_summary -directory $_REPORTS_PATH
time_info MAP

#suspend 

syn_opt
write_snapshot -innovus -directory $_OUTPUTS_PATH -tag syn_opt
report_summary -directory $_REPORTS_PATH
time_info OPT

#suspend 

syn_opt -incremental

write_db -common INVS -design pp_fir_u_2
write_hdl > pp_fir_u_2_struct.v

suspend

exit
