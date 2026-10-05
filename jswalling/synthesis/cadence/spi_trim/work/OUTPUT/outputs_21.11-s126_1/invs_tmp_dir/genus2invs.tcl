# (C) 2024 Cadence Design Systems, Inc.  All rights reserved.
# Created by Genus(TM) Synthesis Solution on 05/10/2024 16:54:20
# This script uses internal commands and variables that may change without notice.


#####################################################################
#
# Innovus batch script file
# Created by Genus(TM) Synthesis Solution on 05/10/2024 16:54:20
#
#####################################################################
set_db source_verbose false

      if { [file isdirectory [set tmpdir /tmp/genus_temp_19998_cluster12_jswalling_lSFzBJ]] && [file writable $tmpdir] } {
        set ::env(TMPDIR) $tmpdir
        set ::syn2ambit_tmp_dir $tmpdir
      }
    


# Version Check
###########################################################

      namespace eval ::genus_innovus_version_check { 
        set minimum_version 21
        set maximum_version 22
        regexp {\d\d} [get_db program_version] this_version
        puts "Checking Innovus major version against Genus expectations ..."
        if { $this_version < $minimum_version || $this_version > $maximum_version } {
          puts "**ERROR: this operation requires Innovus major version to be between '$minimum_version' and '$maximum_version'."
          exec touch ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/.invs2genus.encVerFail 
          puts "**ERROR: Batch process failed."
          exit 1
        }
      }
    
###########################################################


# Source Innovus helper procs

      set ::genus_invs_scripts /software/RFIC/cadtools/cadence/genus/GENUS211/tools.lnx86/lib/cdn/rc/edi
      eval_legacy {
        namespace eval ::rcp {
          variable failedOnFile ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.cmdFail
        }
        set ::genus_invs_scripts /software/RFIC/cadtools/cadence/genus/GENUS211/tools.lnx86/lib/cdn/rc/edi
      }
      source -quiet [file join $::genus_invs_scripts innovus_procs_services.tcl]
    
pqos_eval {set rcp::ispatial_outputs 1}
pqos_eval {array set rcp::bat_state {fe_view_list {view_wcl_slow view_wcl_fast view_wcl_typical} flow ispatial do_fe_pd 0 do_fp 0 wnm_flow 1 do_sdp 0 incr_plc 0 shep_write_congestion 1 place_effort ispatial no_spef 0 no_msv 1 invs_ld_pd 1 fp_mode 0 eco_mode 0 tdrc_valid 0 des_str topVcoDigital x2def_mode 0 spatial 0 save_fe_db 1 iprefix genus2invs cts_effort {} ispatial 1 congestion_3d 0 idir ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir opt_effort high fe_use_um 1 no_scan 1 fe_consistency_check 0 design design:topVcoDigital cts_clk {} do_stylus_db 0 mem_mode 1 chk_fp 0 congestion_include_blockage 0 shep_save_only_db 0 oprefix invs2genus ndr_only 0 del_corner {} innovus_constraint_interface mmmc2 genus_constraint_interface mmmc2 odir ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir tim_mode {} hdl_name_flow 0 qos_mode 1 no_update 0 2d_compression 0}}
pqos_source [file join $::genus_invs_scripts innovus_procs_common_ui.tcl]


# User Specified CPU usage for Innovus
################################################################################
set_multi_cpu_usage -local_cpu 8
::enable_metrics -on
pqos_eval {set ::rcp::custom_cg_timing 1}


# Design Import
################################################################################
pqos_eval {rcp::print_time_stamp "Design Import Start"}
pqos_source -verbose ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/genus2invs.invs_setup.tcl
::create_snapshot -name genus2invs_setup -auto min
pqos_eval {rcp::print_time_stamp "Design Import Complete"}


# Additional Setup
################################################################################
pqos_eval {set dbgLefDefOutVersion 5.8}

        pqos_eval {
          if { [info exists ::timing_spatial_derate_calculation_mode] && ($::timing_spatial_derate_calculation_mode ne "multiplicative") } {
            Puts "WARNING: Adjusting a user override of 'timing_spatial_derate_calculation_mode' from '$::timing_spatial_derate_calculation_mode' to be 'multiplicative'."
            set ::timing_spatial_derate_calculation_mode "multiplicative"
          }
          if { [info exists ::timing_aocv_derate_mode] && ($::timing_aocv_derate_mode ne "aocv_multiplicative") } {
            Puts "WARNING: Adjusting a user override of 'timing_aocv_derate_mode' from '$::timing_aocv_derate_mode' to be 'aocv_multiplicative'."
            set ::timing_aocv_derate_mode "aocv_multiplicative"
          }
        }
      


# Configure iSpatial within Innovus
################################################################################
pqos_source ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/genus2invs.ispatial_setup.tcl
pqos_eval { rcp::push_and_set_state  -format 3 -set_name "genus2invs" {
{setPlaceMode -placeIoPins true}
{setPlaceMode -reorderScan false}
{setOptMode -simplifyNetlist false}
}}
pqos_eval {setOptMode -usefulSkewPreCTS true}
pqos_eval {setOptMode -usefulSkew true}
pqos_eval {setOptMode -multiBitFlopOpt false}
pqos_eval { rcp::push_and_set_state  -format 3 -set_name "genus2invs_place_opt" {
}}
puts "There are [sizeof_collection [get_path_groups -quiet]] path_groups defined before optimization."
pqos_eval { rcp::ispatial_control }


# iSpatial place_opt_design
pqos_eval {
        set stage_opt_rtime [feResource real] 
        set stage_opt_cpu_rtime [feResource cpu]
      }
# pqos_eval {place_opt_design -phys_syn -out_dir ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir -prefix invs2genus_final}

      pqos_eval {
        if { ![info exists rcp::using_genus_license] } {
          place_opt_design -phys_syn -out_dir ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir -prefix invs2genus_final
        } else {
          rcp::optimization1_place_opt_design__phys_syn__out_dir___OUTPUT_outputs_21_11_s126_1_invs_tmp_dir__prefix_invs2genus_final.3442980993279713
        }
      }
    
pqos_eval {
        set stage_opt_rtime [list [expr {[feResource real]-$stage_opt_rtime}] [feResource real] [expr {[feResource cpu]-$stage_opt_cpu_rtime}] [feResource cpu]]
      }


# Writing out interface files..
pqos_eval {Puts {save_interface_files ...}}
pqos_eval {::rcp::save_interface_files {fe_view_list {view_wcl_slow view_wcl_fast view_wcl_typical}} {flow ispatial} {do_fe_pd 0} {do_fp 0} {wnm_flow 1} {do_sdp 0} {incr_plc 0} {shep_write_congestion 1} {place_effort ispatial} {no_spef 0} {no_msv 1} {invs_ld_pd 1} {fp_mode 0} {eco_mode 0} {tdrc_valid 0} {des_str topVcoDigital} {x2def_mode 0} {spatial 0} {save_fe_db 1} {iprefix genus2invs} {cts_effort {}} {ispatial 1} {congestion_3d 0} {idir ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir} {opt_effort high} {fe_use_um 1} {no_scan 1} {fe_consistency_check 0} {design design:topVcoDigital} {cts_clk {}} {mem_mode 1} {chk_fp 0} {congestion_include_blockage 0} {shep_save_only_db 0} {oprefix invs2genus} {ndr_only 0} {del_corner {}} {innovus_constraint_interface mmmc2} {genus_constraint_interface mmmc2} {odir ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir} {tim_mode {}} {hdl_name_flow 0} {qos_mode 1} {no_update 0} {2d_compression 0} {fe_wnm_file ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.wnm.taf.gz} {fe_mcmd ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.cmdWarn} {fe_pwr {}} {fe_1801 {}} {fe_flag ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/.invs2genus.encDone} {fe_xdata ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.xdata} {fe_fcmd ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.cmdFail} {fe_sdef ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.scan.def} {fe_load_stat ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus_load.stat} {fe_def_lnk ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.def.gz} {fe_ndr ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.ndr.tcl} {fe_pd {}} {fe_globals ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.globals} {fe_tcf ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.tcf} {fe_rc ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus_final.avgRC} {fe_load_rpt ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus_load} {fe_db ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus_db} {fe_rpt ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus_final} {fe_metrics ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.metrics.json} {fe_sdp {}} {fe_def ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.def.gz} {fe_vflag ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/.invs2genus.encVerFail} {fe_con ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.sdc} {fe_cpf {}} {fe_mmmc ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.mmmc.tcl} {fe_gridinfo ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.gridinfo} {fe_log ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/innovus} {fe_cts ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.ctstch} {fe_nl ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.v.gz} {fe_reportwire ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.reportwire.txt} {fe_svr ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.svr.tcl} {fe_lec ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.lec.taf.gz} {fe_stat ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus_final.stat} {fe_basename ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus} {fe_lflag ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/.invs2genus.encLicFail} {fe_spef {}} {fe_dotg ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.g.gz} {fe_ndr_taf ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.ndr.taf.gz} {fe_final_db {}} {fe_route_cmap ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.route.congestion.gz} {fe_aae ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.aae_globals.tcl}}

        ## Generate extraction data
        if { ![file exists [set xdata_fname ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/invs2genus.xdata]] } {
          pqos_eval "::rcp::generate_enc_xdata -qrc $xdata_fname"
        }
      

exec touch ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/.invs2genus.encDone
exit
