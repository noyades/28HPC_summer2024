if {[file exists /proc/cpuinfo]} {
  sh grep "model name" /proc/cpuinfo
  sh grep "cpu MHz"    /proc/cpuinfo
}

puts "Hostname : [info hostname]"

set DESIGN topVcoDigital
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

set_db init_lib_search_path {. /software/RFIC/PDK/globalFoundries/22FDX-EXT/std_cells/}
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
${rtlDir}/topVcoDigital.v \
${rtlDir}/vcoDecoder.v \
${rtlDir}/spi_slave.v \
${rtlDir}/fifo_32b.v \
${rtlDir}/fifoDataRegister.v \
${rtlDir}/clkDiv.v \
${rtlDir}/trimRegs.v \
"

suspend

## Read in the MMMC setup
read_mmmc ../scripts/mmmc.tcl

read_physical -lefs { \
  /software/RFIC/PDK/globalFoundries/22FDX-EXT/std_cells/v-logic_gf22nsdslogl28edl116a/DesignWare_logic_libs/globalfoundaries22nhsda/28hd/edl/svt/latest/lef/5.8/gf22nsdslogl28edl116a_9M_2Mx_5Cx_1Jx_1Ox_LB.lef \
  /software/RFIC/PDK/globalFoundries/22FDX-EXT/std_cells/v-logic_gf22nsdslogl28edl116a/DesignWare_logic_libs/globalfoundaries22nhsda/28hd/edl/svt/latest/lef/5.8/gf22nsdslogl28edl116a.lef
}

set_dont_use [get_lib_cells */*FD*] ;
set_dont_use [get_lib_cells */*FSD*] ;
set_db [get_lib_cells */*_FSDPQ_*] .avoid false
set_db [get_lib_cells */*_FSDPRBQ_*] .avoid false
set_dont_use [list *_0P* *_16 *_16P5 *_17 *_18 *_20 *_24 *_32 *_33 *_65 *_DEL* *_TIE* *ECO* *CLAMP* *DICE*]
set_db [get_lib_cells */*FSDPSBQ_*_4] .avoid false ;

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

read_def -fuzzy_match ../def/topVcoDigital_presynth.def

check_floorplan

suspend

syn_generic -physical
puts "Runtime & Memory after 'syn_generic -physical'"
time_info GENERIC
write_reports -directory $_REPORTS_PATH -tag generic
write_db ${_OUTPUTS_PATH}/${DESIGN}_generic.db

suspend

syn_map -physical
puts "Runtime & Memory after 'syn_map -physical'"
time_info MAPPED
write_reports -directory $_REPORTS_PATH -tag map
write_db ${_OUTPUTS_PATH}/${DESIGN}_map.db

write_do_lec -golden_design rtl -revised_design fv_map -no_exit -logfile ${_LOG_PATH}/rtl_2_fv_map.lec.log > ${_OUTPUTS_PATH}/rtl_2_fv_map.lec.do

set_db invs_save_db true
def_move -initialize

syn_opt -spatial
puts "Runtime & Memory after 'syn_opt -spatial'"
time_info ISPATIAL
def_move -highlight
write_db -common INVS -design topVcoDigital

report_messages > $_REPORTS_PATH/${DESIGN}_messages.rpt
report_gates > $_REPORTS_PATH/${DESIGN}_gates.rpt
report_power > $_REPORTS_PATH/${DESIGN}_power.rpt
write_reports -directory $_REPORTS_PATH -tag final

write_do_lec -golden_design fv_map -revised_design ${_OUTPUTS_PATH}/final/${DESIGN}.v.gz -no_exit -logfile ${_LOG_PATH}/fv_map_2_final.lec.log > ${_OUTPUTS_PATH}/fv_map_2_final.lec.do
