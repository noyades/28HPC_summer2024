if {[file exists /proc/cpuinfo]} {
  sh grep "model name" /proc/cpuinfo
  sh grep "cpu MHz"    /proc/cpuinfo
}

puts "Hostname : [info hostname]"

set DESIGN pp_fir_u_0
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
                               /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_lvt_c30/ \
                               /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_svt_c30/ \
                               /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_svt_c30/ \
                               /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_ulvt_c30/ \
                               /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_ulvt_c30/}
set_db script_search_path { . }
set_db init_hdl_search_path {. ../rtl}

set_db max_cpus_per_server 8

set_db syn_generic_effort $SYN_EFF
set_db syn_map_effort $MAP_EFF
set_db syn_opt_effort $OPT_EFF

set_db information_level 9

#set_db tns_opto true
#set_db lp_insert_clock_gating true

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
#suspend
##################################################################
## iSpatial
##################################################################
set_db opt_spatial_effort standard
set_db invs_temp_dir ${_OUTPUTS_PATH}/invs_tmp_dir

##################################################################
## MMMC Settings and LEFS
##################################################################
read_mmmc ../scripts/mmmc_iSpatial.tcl
read_physical -lefs { \
  /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/arm_tech/r1p0/lef/1p9m_6x2z_utalrdl/sc9mcpp140z_tech.lef \
  /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_lvt_c30/r0p0/lef/sc9mcpp140z_cln28ht_base_lvt_c30.lef \
  /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_lvt_c30/r0p0/lef/sc9mcpp140z_cln28ht_hpk_lvt_c30.lef
  /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_svt_c30/r0p0/lef/sc9mcpp140z_cln28ht_base_svt_c30.lef \
  /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_svt_c30/r0p0/lef/sc9mcpp140z_cln28ht_hpk_svt_c30.lef
  /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_ulvt_c30/r0p0/lef/sc9mcpp140z_cln28ht_base_ulvt_c30.lef \
  /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_ulvt_c30/r0p0/lef/sc9mcpp140z_cln28ht_hpk_ulvt_c30.lef
}

##################################################################
## Load and Elaborate the Design
##################################################################
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

report_ple > ${_REPORTS_PATH}/ple.rpt

##################################################################
## Read DEF
##################################################################
read_def -fuzzy_match ../../pp_fir_u_0_power.def
check_floorplan

##################################################################
## Constraints
##################################################################
# Define Cost Groups
foreach view [get_db analysis_views -if {.is_setup == true}] {
    if {[llength [all_registers]] > 0} {
    define_cost_group -name I2C -design $DESIGN
    define_cost_group -name C2O -design $DESIGN
    path_group -from [all_registers] -to [all_outputs] -group C2O -name C2O -view $view
    path_group -from [all_inputs] -to [all_registers] -group I2C -name I2C -view $view
    }

    define_cost_group -name I2O -design $DESIGN
    path_group -from [all_inputs] -to [all_outputs] -group I2O -name I2O -view $view
}

foreach cg [get_db cost_groups *] {
    report_timing -group [list $cg] >> $_REPORTS_PATH/${DESIGN}_pretim.rpt
}

#suspend

##################################################################
## Physical Aware Synthesis
##################################################################
setPlaceMode -place_global_ignore_scan false
syn_generic -physical
puts "Runtime & Memory after 'syn_generic -physical'"
time_info GENERIC
write_reports -directory $_REPORTS_PATH -tag generic
write_db ${_OUTPUTS_PATH}/${DESIGN}_generic.db
gui_show
puts "End syn_generic"
#suspend

set_db syn_map_effort high
set_db syn_opt_effort high

syn_map -physical
puts "Runtime & Memory after 'syn_map -physical'"
time_info MAPPED
write_reports -directory $_REPORTS_PATH -tag map
write_db ${_OUTPUTS_PATH}/${DESIGN}_map.db

foreach cg [get_db cost_groups *] {
    report_timing -group [list $cg] > $_REPORTS_PATH/${DESIGN}_[vbasename $cg]_postmap.rpt
}

write_do_lec -golden_design rtl -revised_design fv_map -no_exit -logfile ${_LOG_PATH}/rtl_2_fv_map.lec.log > ${_OUTPUTS_PATH}/rtl_2_fv_map.lec.do

puts "End syn_map"
#suspend

##################################################################
## DB Handoff to Innnovus
##################################################################
set_db invs_save_db true
def_move -initialize

##################################################################
## iSpatial Synthesis
##################################################################
syn_opt -spatial
puts "Runtime & Memory after 'syn_opt -spatial'"
time_info ISPATIAL
def_move -highlight
write_db -common INVS -design pp_fir_u_0

##################################################################
## Write Reports and Verilog
##################################################################
report_messages > $_REPORTS_PATH/${DESIGN}_messages.rpt
report_gates > $_REPORTS_PATH/${DESIGN}_gates.rpt
report_power > $_REPORTS_PATH/${DESIGN}_power.rpt
write_reports -directory $_REPORTS_PATH -tag final

write_do_lec -golden_design fv_map -revised_design ${_OUTPUTS_PATH}/final/${DESIGN}.v.gz -no_exit -logfile ${_LOG_PATH}/fv_map_2_final.lec.log > ${_OUTPUTS_PATH}/fv_map_2_final.lec.do

write_hdl > pp_fir_u_0_struct.v

time_info FINAL
puts "Synthesis Finished"
file copy [get_db stdout ] ${_LOG_PATH}/.

suspend
