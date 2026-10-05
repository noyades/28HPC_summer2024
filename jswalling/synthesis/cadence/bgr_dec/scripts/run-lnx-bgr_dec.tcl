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
	set DESIGN b2u_3b_static
	set GEN_EFF medium
	set MAP_EFF high

	set_db init_lib_search_path {. /data/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/arm_tech/ \
		                       /data/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_svt_c30/ \
		                       /data/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_svt_c30/}
	set rtlDir ../rtl
	set_db init_hdl_search_path {. $rtlDir}
	set_db script_search_path { . }

	set_db syn_generic_effort $GEN_EFF
	set_db syn_map_effort $MAP_EFF
	
	set _OUTPUTS_PATH iSpatial_outputs
	set _REPORTS_PATH iSpatial_reports
	set _LOG_PATH     iSpatial_logs

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
        
        
	set_db max_cpus_per_server 8

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
	read_mmmc ../scripts/mmmc_syn_bgr_dec.tcl

	read_physical -lefs { \
	  /data/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/arm_tech/r1p0/lef/1p9m_6x2z_utalrdl/sc9mcpp140z_tech.lef \
	  /data/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_svt_c30/r0p0/lef/sc9mcpp140z_cln28ht_base_svt_c30.lef \
	  /data/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_svt_c30/r0p0/lef/sc9mcpp140z_cln28ht_hpk_svt_c30.lef \
	}

    set_db use_scan_seqs_for_non_dft false

##################################################################
## Read in Design and Initialize it
##################################################################
	puts "Now load RTL LIST"
	set rtlList "\
        ${rtlDir}/b2u_3b_static.v \
	"
	#suspend

	read_hdl $rtlList
	elaborate $DESIGN
	set init_pwr_net {VDD}
	set init_gnd_net {VSS}
	time_info init_design

	init_design
    puts "The number of exceptions is [llength [vfind /designs/$DESIGN -exception *]]"	
	check_design -unresolved

	check_timing_intent
	report_ple > ${_REPORTS_PATH}/ple.rpt

##################################################################
## Read Floorplan DEF
##################################################################
	read_def -fuzzy_match ../def/bin2thermo_presyn.def
	check_floorplan -detailed
	suspend

##################################################################
## Physical Aware Synthesis
##################################################################
	syn_generic -physical
	puts "Runtime & Memory after 'syn_generic -physical'"
	time_info GENERIC
	
	write_reports -directory $_REPORTS_PATH -tag generic
	write_db ${_OUTPUTS_PATH}/${DESIGN}_generic.db

	#set_db syn_map_effort high
	#set_db syn_opt_effort high
        #set_db dft_scan_map_mode preserve
	#setPlaceMode -place_global_ignore_scan false

        # Exclude scan flip-flops from library to prevent undefined SE signals
	#set_dont_use [get_lib_cells */SDFF*]
	
	syn_map -physical
	puts "Runtime & Memory after 'syn_map -physical'"
	time_info MAPPED

	write_reports -directory $_REPORTS_PATH -tag map
	write_db ${_OUTPUTS_PATH}/${DESIGN}_map.db

	write_do_lec -golden_design rtl -revised_design fv_map -no_exit -logfile ${_LOG_PATH}/rtl_2_fv_map.lec.log > ${_OUTPUTS_PATH}/rtl_2_fv_map.lec.do
        #write_scandef > pp_int_x4.scandef
	puts "End syn_map"

	#syn_opt
	#puts "Runtime & Memory after 'syn_opt'"
	#time_info OPT

##################################################################
## DB Handoff to Innovus preCTS
##################################################################
	set_db invs_save_db true
	set_db invs_temp_dir invs2gns_tmp
	#def_move -initialize
        #suspend

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
	write_hdl > ${DESIGN}_struct_iSpatial.v

	puts "End syn_opt"
	#suspend
