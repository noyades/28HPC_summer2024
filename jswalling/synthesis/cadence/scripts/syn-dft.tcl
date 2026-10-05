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
	set DESIGN pp_int_x4
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
	set_db invs_temp_dir ${_OUTPUTS_PATH}/invs_tmp_dir

##################################################################
## Library and MMMC Settings
##################################################################
	## Read in the MMMC setup
	read_mmmc ../scripts/mmmc_syn.tcl

	read_physical -lefs { \
	  /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/arm_tech/r1p0/lef/1p9m_6x2z_utalrdl/sc9mcpp140z_tech.lef \
	  /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_lvt_c30/r0p0/lef/sc9mcpp140z_cln28ht_base_lvt_c30.lef \
	  /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_lvt_c30/r0p0/lef/sc9mcpp140z_cln28ht_hpk_lvt_c30.lef
	  /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_svt_c30/r0p0/lef/sc9mcpp140z_cln28ht_base_svt_c30.lef \
	  /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_svt_c30/r0p0/lef/sc9mcpp140z_cln28ht_hpk_svt_c30.lef
	  /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_ulvt_c30/r0p0/lef/sc9mcpp140z_cln28ht_base_ulvt_c30.lef \
	  /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_ulvt_c30/r0p0/lef/sc9mcpp140z_cln28ht_hpk_ulvt_c30.lef
	}

        set_db dft_scan_style muxed_scan
        set_db dft_prefix dft_
        
        check_dft_rules

##################################################################
## Read in Design and Initialize it
##################################################################
	puts "Now load RTL LIST"
	set rtlList "\
        ${rtlDir}/mc/clkDiv.v \
	${rtlDir}/mc/pp_int_x4.v \
	${rtlDir}/mc/pp_int_x4_tc.v \
	${rtlDir}/mc/fir_int_p3.v \
	${rtlDir}/mc/fir_int_p2.v \
	${rtlDir}/mc/fir_int_p1.v \
	${rtlDir}/mc/fir_int_p0.v \
	${rtlDir}/pp_fir.v \
	${rtlDir}/pp_fir_7.v \
	${rtlDir}/pp_fir_6.v \
	${rtlDir}/pp_fir_5.v \
	${rtlDir}/pp_fir_4.v \
	${rtlDir}/pp_fir_3.v \
	${rtlDir}/pp_fir_2.v \
	${rtlDir}/pp_fir_1.v \
	${rtlDir}/pp_fir_0.v \
	${rtlDir}/signed_mag_unary.v \
	${rtlDir}/b2u_8to255_quad.v \
	"
	#suspend

	read_hdl $rtlList
	elaborate $DESIGN

        set_db dft_scan_style muxed_scan
        set_db dft_prefix dft_
        define_shift_enable -name SE -active high -create_port SE

        check_dft_rules

	set init_pwr_net {VDD}
	set init_gnd_net {VSS}
	init_design

	time_info init_design
	check_design -unresolved
	check_timing_intent

	report_ple > ${_REPORTS_PATH}/ple.rpt

##################################################################
## Initial Synthesis (To estimate placement area
##################################################################
	syn_generic
	puts "Runtime & Memory after 'syn_generic'"
	time_info GENERIC
	write_reports -directory $_REPORTS_PATH -tag generic
	write_db ${_OUTPUTS_PATH}/${DESIGN}_generic.db
	
	puts "End syn_generic"
	suspend

	syn_map
	puts "Runtime & Memory after 'syn_map'"
	time_info MAPPED
	write_reports -directory $_REPORTS_PATH -tag map
	write_db ${_OUTPUTS_PATH}/${DESIGN}_map.db

	syn_opt
	puts "Runtime & Memory after 'syn_opt'"
	time_info OPT

        check_dft_rules

        set_db design:$DESIGN .dft_min_number_of_scan_chains 1
        define_scan_chain -name top_chain -sdi scan_in -sdo scan_out -create_ports
        connect_scan_chains -auto_create_chains

        syn_opt -incr

        report_scan_chains

##################################################################
## Write Reports
##################################################################
	report_messages > $_REPORTS_PATH/${DESIGN}_messages.rpt
	report_gates > $_REPORTS_PATH/${DESIGN}_gates.rpt
	report_power > $_REPORTS_PATH/${DESIGN}_power.rpt
	write_reports -directory $_REPORTS_PATH -tag final
        write_scandef > $_OUTPUTS_PATH/${DESIGN}_scanDEF.scandef

##################################################################
## Write Database Handoff to Innovus preCTS and Verilog Netlist
##################################################################
	write_hdl > ${DESIGN}_struct.v

	puts "End syn_opt"
