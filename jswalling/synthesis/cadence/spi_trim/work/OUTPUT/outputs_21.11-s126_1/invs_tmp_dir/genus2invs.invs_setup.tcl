################################################################################
#
# Innovus setup file
# Created by Genus(TM) Synthesis Solution 21.11-s126_1
#   on 05/10/2024 16:54:19
#
################################################################################
#
# Genus(TM) Synthesis Solution setup file
# This file can only be run in Innovus Common UI mode.
#
################################################################################


# Version Check
###########################################################

      namespace eval ::genus_innovus_version_check { 
        set minimum_version 21
        set maximum_version 22
        regexp {\d\d} [get_db program_version] this_version
        puts "Checking Innovus major version against Genus expectations ..."
        if { $this_version < $minimum_version || $this_version > $maximum_version } {
          error "**ERROR: this operation requires Innovus major version to be between '$minimum_version' and '$maximum_version'."
        }
      }
    
set _t0 [clock seconds]
puts [format  {%%%s Begin Genus to Innovus Setup (%s)} \# [clock format $_t0 -format {%m/%d %H:%M:%S}]]
set_db read_physical_allow_multiple_port_pin_without_must_join true
set_db must_join_all_ports true
set_db timing_enable_latch_thru_mode false
eval_legacy {set_global timing_library_convert_n_piece_cap_to_2_piece false}
set_db timing_cap_unit 1pf
set_db timing_time_unit 1ns
eval_legacy {setMultiCpuUsage -localCpu 8}


# Design Import
################################################################################
source -quiet /software/RFIC/cadtools/cadence/genus/GENUS211/tools.lnx86/lib/cdn/rc/edi/innovus_procs_common_ui.tcl
## Reading FlowKit settings file
source ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/genus2invs.flowkit_settings.tcl

source ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/genus2invs.invs_init.tcl
## Reading Attributes file
set starting_source_continue_on_error [get_db source_continue_on_error]
set_db -quiet source_continue_on_error true 
source ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/genus2invs.user_attrs.tcl
set_db -quiet source_continue_on_error $starting_source_continue_on_error
## Reading Innovus Mode attributes file
pqos_eval {rcp::read_taf ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/genus2invs.mode_attributes.taf.gz}

## Reading common preserve file for dont_touch and dont_use preserve settings
pqos_eval {rcp::read_taf ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/genus2invs.preserve.taf.gz}
read_def /home/micsTapeouts/projects/22FDX_winter2023/jswalling/genus/spi_trim/work/OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/genus2invs.def.gz


# Blockages that cannot be fully represented in DEF.
################################################################################
if {[file isfile ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/genus2invs.blkgs.tcl]} { source ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/genus2invs.blkgs.tcl }


# Groups that cannot be fully represented in DEF.
################################################################################
if {[file isfile ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/genus2invs.groups.tcl]} { source ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/genus2invs.groups.tcl }


# Mode Setup
################################################################################
source ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/genus2invs.mode


# MSV Setup
################################################################################

# Reading write_name_mapping file
################################################################################

      if { [is_attribute -obj_type port original_name] &&
           [is_attribute -obj_type pin original_name] &&
           [is_attribute -obj_type pin is_phase_inverted]} {
        pqos_eval {rcp::read_taf ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/genus2invs.wnm_attrs.taf.gz}
      }
    

# Read path adjust constraints
source ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/genus2invs.path_adjust.tcl 


# Generation of NanoRoute advanced rule vias
eval_legacy {generateVias -advanced_rule -restore_design}

# Reading Net Attributes
pqos_eval { rcp::read_taf ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/genus2invs.net_attributes.taf.gz}

# Reading minimum routing layer data file
################################################################################
eval_legacy {gpsPrivate::readMinLayerCstr -file ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/genus2invs.min_layer} 

eval_legacy {set edi_pe::pegConsiderMacroLayersUnblocked 1}
eval_legacy {set edi_pe::pegPreRouteWireWidthBasedDensityCalModel 1}

        pqos_eval {
          Puts "Creating route_types"
          rcp::create_route_types ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/genus2invs.route_types.taf.gz
        }
      
pqos_eval { rcp::read_taf ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/genus2invs.cts.taf.gz}
pqos_eval { rcp::read_taf ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/genus2invs.lec.taf.gz}

      set _t1 [clock seconds]
      puts [format  {%%%s End Genus to Innovus Setup (%s, real=%s)} \# [clock format $_t1 -format {%m/%d %H:%M:%S}] [clock format [expr {28800 + $_t1 - $_t0}] -format {%H:%M:%S}]]
    
