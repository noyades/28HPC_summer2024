# (C) 2025 Cadence Design Systems, Inc.  All rights reserved.
# Created by Genus(TM) Synthesis Solution on 01/12/2025 18:39:02
# This script uses internal commands and variables that may change without notice.


#####################################################################
#
# Innovus batch script file
# Created by Genus(TM) Synthesis Solution on 01/12/2025 18:39:02
#
#####################################################################
set_db source_verbose false

      if { [file isdirectory [set tmpdir /tmp/genus_temp_44204_cluster15_jswalling_JZroWO]] && [file writable $tmpdir] } {
        set ::env(TMPDIR) $tmpdir
        set ::syn2ambit_tmp_dir $tmpdir
      }
    


# Version Check
###########################################################

      namespace eval ::genus_innovus_version_check { 
        set minimum_version 22
        set maximum_version 23
        regexp {\d\d} [get_db program_version] this_version
        puts "Checking Innovus major version against Genus expectations ..."
        if { $this_version < $minimum_version || $this_version > $maximum_version } {
          puts "**ERROR: this operation requires Innovus major version to be between '$minimum_version' and '$maximum_version'."
          exec touch ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/.invs2genus.encVerFail 
          puts "**ERROR: Batch process failed."
          exit 1
        }
      }
    
###########################################################


# Source Innovus helper procs

      set ::genus_invs_scripts /software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/GENUS221/tools.lnx86/lib/cdn/rc/edi
      eval_legacy {
        namespace eval ::rcp {
          variable failedOnFile ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/invs2genus.cmdFail
        }
        set ::genus_invs_scripts /software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/GENUS221/tools.lnx86/lib/cdn/rc/edi
      }
      source -quiet [file join $::genus_invs_scripts innovus_procs_services.tcl]
    
pqos_eval {set rcp::ispatial_outputs 1}
pqos_eval {array set rcp::bat_state {flow ispatial fe_view_list {view_wcl_slow view_wcl_fast view_wcl_typical} wnm_flow 1 shep_write_congestion 1 x2def_mode 0 iprefix genus2invs idir ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir design design:pp_fir_u_2 congestion_include_blockage 0 chk_fp 0 shep_save_only_db 0 fe_colorized 0 ndr_only 0 tim_mode {} innovus_constraint_interface mmmc2 do_fp 0 des_str pp_fir_u_2 spatial 0 congestion_3d 0 cts_effort {} fe_use_um 1 odir ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir 2d_compression 0 do_fe_pd 0 fp_mode 0 incr_plc 0 eco_mode 0 cts_clk {} oprefix invs2genus genus_constraint_interface mmmc2 no_update 0 do_sdp 0 invs_ld_pd 1 no_msv 1 no_spef 0 place_effort ispatial tdrc_valid 0 save_fe_db 0 ispatial 1 opt_effort high fe_consistency_check 0 no_scan 1 mem_mode 0 do_stylus_db 1 del_corner {} write_pin_properties 0 qos_mode 1 hdl_name_flow 0}}
pqos_source [file join $::genus_invs_scripts innovus_procs_common_ui.tcl]


# User Specified CPU usage for Innovus
################################################################################
set_multi_cpu_usage -local_cpu 8
::enable_metrics -on
pqos_eval {set ::rcp::custom_cg_timing 1}


# Design Import
################################################################################
pqos_eval {rcp::print_time_stamp "Design Import Start"}
pqos_eval {source ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/genus2invs_db.flow_globals}

      set cmd {read_db -common ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/genus2invs_db}
      if { {-design} in [eval_legacy {TCM::findCommandArgs read_common_db}] } {
        lappend cmd -design pp_fir_u_2
      }
      
      eval $cmd
      # FIXME: remove - I think not always calling init_design is an old bug now
      if { [is_common_ui_mode] &&
           [eval_legacy {expr {![info exists ::init_state] || ($::init_state ne "initialization_complete")}}] } {
        puts "Calling init_design to complete 'read_db -common'"
        init_design
      }
    
pqos_eval {source ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/genus2invs_db.flow_mode}
::create_snapshot -name genus2invs_setup -auto min

      # Resetting placement for unfixed instances
      reset_db -quiet [get_db insts -if {.place_status == placed}] .place_status
    
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
pqos_source ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/genus2invs.ispatial_setup.tcl
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
# pqos_eval {place_opt_design -phys_syn -out_dir ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir -prefix invs2genus_final}

      pqos_eval {
        if { ![info exists rcp::using_genus_license] } {
          place_opt_design -phys_syn -out_dir ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir -prefix invs2genus_final
        } else {
          rcp::optimization1_place_opt_design__phys_syn__out_dir___OUTPUT_outputs_22_10_p001_1_invs_tmp_dir__prefix_invs2genus_final.3639060484077344
        }
      }
    
pqos_eval {
        set stage_opt_rtime [list [expr {[feResource real]-$stage_opt_rtime}] [feResource real] [expr {[feResource cpu]-$stage_opt_cpu_rtime}] [feResource cpu]]
      }


# Writing out interface files..
pqos_eval {Puts {save_interface_files ...}}
pqos_eval {::rcp::save_interface_files {flow ispatial} {fe_view_list {view_wcl_slow view_wcl_fast view_wcl_typical}} {wnm_flow 1} {shep_write_congestion 1} {x2def_mode 0} {iprefix genus2invs} {idir ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir} {design design:pp_fir_u_2} {congestion_include_blockage 0} {chk_fp 0} {shep_save_only_db 0} {fe_colorized 0} {ndr_only 0} {tim_mode {}} {innovus_constraint_interface mmmc2} {do_fp 0} {des_str pp_fir_u_2} {spatial 0} {congestion_3d 0} {cts_effort {}} {fe_use_um 1} {odir ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir} {2d_compression 0} {do_fe_pd 0} {fp_mode 0} {incr_plc 0} {eco_mode 0} {cts_clk {}} {oprefix invs2genus} {genus_constraint_interface mmmc2} {no_update 0} {do_sdp 0} {invs_ld_pd 1} {no_msv 1} {no_spef 0} {place_effort ispatial} {tdrc_valid 0} {save_fe_db 0} {ispatial 1} {opt_effort high} {fe_consistency_check 0} {no_scan 1} {mem_mode 0} {do_stylus_db 1} {del_corner {}} {write_pin_properties 0} {qos_mode 1} {hdl_name_flow 0} {fe_wnm_file {}} {fe_mcmd ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/invs2genus.cmdWarn} {fe_pwr {}} {fe_1801 {}} {fe_flag ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/.invs2genus.encDone} {fe_xdata ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/invs2genus.xdata} {fe_fcmd ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/invs2genus.cmdFail} {fe_sdef {}} {fe_load_stat ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/invs2genus_load.stat} {fe_def_lnk {}} {fe_ndr {}} {fe_pd {}} {fe_globals {}} {fe_tcf {}} {fe_rc {}} {fe_load_rpt ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/invs2genus_load} {fe_db ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/invs2genus_db} {fe_rpt ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/invs2genus_final} {fe_metrics ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/invs2genus.metrics.json} {fe_sdp {}} {fe_def {}} {fe_vflag ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/.invs2genus.encVerFail} {fe_inst_taf {}} {fe_con {}} {fe_cpf {}} {fe_mmmc {}} {fe_gridinfo {}} {fe_log ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/innovus} {fe_cts {}} {fe_nl {}} {fe_reportwire ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/invs2genus.reportwire.txt} {fe_svr {}} {fe_lec {}} {fe_stat ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/invs2genus_final.stat} {fe_basename ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/invs2genus} {fe_lflag ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/.invs2genus.encLicFail} {fe_spef {}} {fe_dotg {}} {fe_ndr_taf {}} {fe_final_db ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/invs2genus_final_db} {fe_route_cmap ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/invs2genus.route.congestion.gz} {fe_aae ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/invs2genus_final_db/cmn/pp_fir_u_2.aae}}

exec touch ./OUTPUT/outputs_22.10-p001_1/invs_tmp_dir/.invs2genus.encDone
exit
