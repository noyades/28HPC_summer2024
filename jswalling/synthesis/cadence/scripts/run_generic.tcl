##################################################################
## System Info
##################################################################
	if {[file exists /proc/cpuinfo]} {
	  sh grep "model name" /proc/cpuinfo
	  sh grep "cpu MHz"    /proc/cpuinfo
	}

	puts "Hostname : [info hostname]"

##################################################################
## Global Variables and Settings (Report Paths, Effort, etc.)
##################################################################
	set DESIGN YOUR_TOP_LEVEL_DESIGN_NAME
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

	set_db init_lib_search_path {. PATH_1 \
		                       PATH_2 \
                                       PATH_N}
	set_db script_search_path { . }
	set_db init_hdl_search_path {. ../rtl}

	set_db max_cpus_per_server 8

	set_db syn_generic_effort $SYN_EFF
	set_db syn_map_effort $MAP_EFF
	set_db syn_opt_effort $OPT_EFF

	set_db information_level 9

	#set_db tns_opto true
	#set_db lp_insert_clock_gating true

##################################################################
## iSpatial Setup
##################################################################
	set_db opt_spatial_effort extreme

	set_db invs_temp_dir ${_OUTPUTS_PATH}/invs_tmp_dir

##################################################################
## Library and MMMC Settings
##################################################################
	## Read in the MMMC setup
	read_mmmc ../scripts/mmmc.tcl

	read_physical -lefs { PATH_1 \
		              PATH_2 \
                              PATH_N}

        # This works to stop scan from being inserted
        set_db use_scan_seqs_for_non_dft false 

##################################################################
## Read in Design and Initialize it
##################################################################
	puts "Now load RTL LIST"
	set rtlList "\
        PATH_TO_RTL_1 \
        PATH_TO_RTL_2 \
        PATH_TO_RTL_N \
	"
	#suspend


	read_hdl $rtlList
	elaborate $DESIGN

	set init_pwr_net {VDD}
	set init_gnd_net {VSS}
	init_design
	time_info init_design
	check_design -unresolved
	check_timing_intent

	report_ple > ${_REPORTS_PATH}/ple.rpt

##################################################################
## Read Floorplan DEF
##################################################################
	read_def -fuzzy_match ./pp_int_x4_presyn.def
	check_floorplan -detailed
	#suspend

##################################################################
## Physical Aware Synthesis
##################################################################
	syn_generic -physical
	puts "Runtime & Memory after 'syn_generic -physical'"
	time_info GENERIC
	write_reports -directory $_REPORTS_PATH -tag generic
	write_db ${_OUTPUTS_PATH}/${DESIGN}_generic.db

	puts "End syn_generic"
	#suspend

	set_db syn_map_effort high
	set_db syn_opt_effort high
        #set_db dft_scan_map_mode preserve
	#setPlaceMode -place_global_ignore_scan false

	syn_map -physical
	puts "Runtime & Memory after 'syn_map -physical'"
	time_info MAPPED
	write_reports -directory $_REPORTS_PATH -tag map
	write_db ${_OUTPUTS_PATH}/${DESIGN}_map.db

	write_do_lec -golden_design rtl -revised_design fv_map -no_exit -logfile ${_LOG_PATH}/rtl_2_fv_map.lec.log > ${_OUTPUTS_PATH}/rtl_2_fv_map.lec.do
        #write_scandef > pp_int_x4.scandef
	puts "End syn_map"

##################################################################
## DB Handoff to Innovus preCTS
##################################################################
	set_db invs_save_db true
	def_move -initialize
        suspend 

##################################################################
## iSpatial Synthesis
##################################################################
	syn_opt -spatial
	puts "Runtime & Memory after 'syn_opt -spatial'"
	time_info ISPATIAL
	def_move -highlight

##################################################################
## Write Reports
##################################################################
	report_messages > $_REPORTS_PATH/${DESIGN}_messages.rpt
	report_gates > $_REPORTS_PATH/${DESIGN}_gates.rpt
	report_power > $_REPORTS_PATH/${DESIGN}_power.rpt
	write_reports -directory $_REPORTS_PATH -tag final

	write_do_lec -golden_design fv_map -revised_design ${_OUTPUTS_PATH}/final/${DESIGN}.v.gz -no_exit -logfile ${_LOG_PATH}/fv_map_2_final.lec.log > ${_OUTPUTS_PATH}/fv_map_2_final.lec.do

##################################################################
## Write Database Handoff to Innovus preCTS and Verilog Netlist
##################################################################
	write_db -common INVS -design $DESIGN
	write_hdl > ${DESIGN}_struct.v

	puts "End syn_opt"
	#suspend
