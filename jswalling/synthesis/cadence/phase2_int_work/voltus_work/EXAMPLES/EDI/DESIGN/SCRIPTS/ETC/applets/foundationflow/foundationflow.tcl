#===========================================================================
# File Name     : @Source: /grid/tfo/vol112/pctvault/cvs/ae-ware/rc/foundationflow.tcl,v @
# Date Created  : 2011/04/05 17:00:00
# Date Modified : @Date: 2012/08/10 03:08:16 @
# Version       : @Revision: 1.162 @
# Summary       : Foundation Flow Applet
# Keywords      : foundation flow FCF create_flow insert_flow create_step insert_step
#
# Description   : This file comprises the entire Frontend Foundation Flow Application.
#                 It defines the following:
#                   * FCF commands (create_step, insert_step, etc.)
#                   * Basic User Interface (flows setup, flows write, etc.)
#                   * Advanced User Interface (read_foundation, write_foundation, etc.)
#                   * Flow database with query commands (get_flow, get_stage, get_step, etc.)
#                   * FCF linter/parser
#
#                 This file does not define any default flows. The user must use default
#                 flows from the Foundation Flow tool, or create their own FCF.
#
# Assumptions:
#       This script requires TCL 8.4 or later.
#       This script will execute in all 10.1 series Cadence tools.
#       This script includes t++ infrastructure for object oriented TCL
#       programming, as well as the RC compatilibility layer.
#       Note that t++ is integrated natively into RC 11.20 and later versions.
#===========================================================================
namespace eval FFF_OPEN {
  set vars(foundation_flow_applet) [file normalize [info script]]
}
# pragma protect
# pragma protect begin
# Note: move FFF_OPEN code above to protected section when rc's source ns issue is fixed:
# -------------------------------------------------------------------------------------
# Foundation Flow Applet Bill of Materials
# Automatically generated on: Thu Aug 09 08:07:28 PM PDT 2012 by build_cvs_bom.tcl
# (DO NOT MANUALLY MODIFY THE BOM CONTENTS. TO UPDATE THE BOM, run 'make bom' from the ff/applets directory)
# BOM Revision: 1.146
# BOM Date: 2012/08/10 03:07:28 
# -----------------------------------------+---------+---------------------------------
#                File Name                 | Version | Description
# -----------------------------------------+---------+---------------------------------
#                src/adjustClockPeriod.tcl |     1.8 |  Adjust the period of all clocks by a scale factor            
#                   src/appletDefaults.tcl |     1.4 | 
#         src/appletInitFoundationFlow.tcl |     1.6 | 
#                      src/arraySearch.tcl |     1.1 | 
#            src/checkMinAppletVersion.tcl |     1.2 | 
#              src/checkMinToolVersion.tcl |     1.2 | 
#           src/configurationT++Object.tcl |     1.1 | 
#              src/createConfiguration.tcl |     1.1 | 
#                   src/createEllipsis.tcl |     1.1 | 
#                       src/createFlow.tcl |     1.5 | 
#               src/createICGPathGroup.tcl |     1.2 | 
#                      src/createStage.tcl |     1.5 | 
#                       src/createStep.tcl |     1.7 | 
#                   src/dbgMemberClose.tcl |     1.2 | 
#                    src/dbgMemberInit.tcl |     1.2 | 
#                     src/dbgProcClose.tcl |     1.1 | 
#                      src/dbgProcInit.tcl |     1.1 | 
#                          src/dbgPuts.tcl |     1.9 | 
#                          src/ediPuts.tcl |     1.1 | 
#                         src/ediUtils.tcl |     1.3 | 
#                         src/elabFlow.tcl |     1.4 | 
#              src/elaborateFoundation.tcl |     1.3 | 
#                        src/elabStage.tcl |     1.4 | 
#                         src/elabStep.tcl |     1.4 | 
#                            src/fcfQc.tcl |     1.1 | 
#                       src/fcfTclLint.tcl |    1.11 | 
#      src/fffGetDefaultConstraintMode.tcl |     1.1 | 
#            src/fffGetDefaultRcCorner.tcl |     1.1 | 
#                  src/fffWriteMetrics.tcl |     1.3 | 
#             src/fixDefaultConfigName.tcl |     1.1 | 
#                      src/flattenList.tcl |     1.1 | 
#                            src/flows.tcl |    1.13 | 
#                    src/flowT++Object.tcl |     1.3 | 
#                           src/footer.tcl |     1.8 | Foundation Flow Applet
#       src/generateNextOutputFilename.tcl |     1.1 | 
#                       src/genRandInt.tcl |     1.2 | Generate a random integer
#                 src/getConfiguration.tcl |     1.1 | 
#                          src/getFlow.tcl |     1.2 | 
#                      src/getProcName.tcl |     1.1 | 
#                         src/getStage.tcl |     1.2 | 
#                          src/getStep.tcl |     1.3 | 
#                          src/getTool.tcl |     1.1 | 
#                   src/getToolRelease.tcl |     1.2 | 
#                   src/getToolVersion.tcl |     1.2 | 
#                           src/getVar.tcl |     1.1 | 
#                       src/headerText.tcl |    1.11 | Foundation Flow Applet
#          src/initCreateConfiguration.tcl |     1.1 | 
#                   src/initCreateFlow.tcl |     1.1 | 
#                  src/initCreateStage.tcl |     1.1 | 
#                   src/initCreateStep.tcl |     1.1 | 
#                       src/initElabDB.tcl |     1.1 | 
#          src/initElaborateFoundation.tcl |     1.1 | 
#                 src/initializeApplet.tcl |     1.1 | 
#           src/initSetWrapperInElabns.tcl |     1.4 | 
#        src/initSetWrapperInNonelabns.tcl |     1.2 | 
#                       src/insertFlow.tcl |     1.3 | 
#                      src/insertStage.tcl |     1.5 | 
#                       src/insertStep.tcl |     1.4 | 
#                       src/isVarAList.tcl |     1.1 | 
#                   src/lintCheckUtils.tcl |     1.1 | 
#                  src/listToPrettyArr.tcl |     1.1 | 
#                       src/loadApplet.tcl |     1.4 | 
#                       src/loadPlugin.tcl |     1.9 | 
#                  src/objectArrayInit.tcl |     1.1 | 
#  src/parameterConfigurationT++Object.tcl |     1.1 | 
#          src/pluginInstanceT++Object.tcl |     1.4 | 
#                  src/pluginT++Object.tcl |    1.18 | 
#                   src/readFoundation.tcl |    1.11 | 
#                       src/readmeText.tcl |     1.1 | 
#                      src/rel_path_to.tcl |     1.1 | 
#              src/relativizeFileOrDir.tcl |     1.1 | 
#                        src/relPathTo.tcl |     1.1 | 
#                src/removeOuterBraces.tcl |     1.2 | 
#                       src/removeStep.tcl |     1.1 | 
# src/removeTimingConstraintsExceptClock.tcl |     1.1 | 
#             src/reportConfigurations.tcl |     1.2 | 
#                      src/reportFlows.tcl |     1.2 | 
#                 src/reportFoundation.tcl |     1.3 | 
#                     src/reportStages.tcl |     1.2 | 
#                      src/reportSteps.tcl |     1.6 | 
#                     src/reportUptime.tcl |     1.1 | 
#                 src/requiredPackages.tcl |     1.2 | 
#                  src/resetFoundation.tcl |     1.1 | 
#                    src/runFoundation.tcl |     1.3 | 
#                 src/setConfiguration.tcl |     1.1 | 
#                    src/setFCFVersion.tcl |     1.1 | 
#                    src/setScriptName.tcl |     1.1 | 
#                    src/setScriptType.tcl |     1.1 | 
#                          src/setTool.tcl |     1.1 | 
#                       src/sourcePlug.tcl |     1.1 | 
#           src/stageInstanceT++Object.tcl |     1.1 | 
#           src/stageIteratorT++Object.tcl |     1.1 | 
#                   src/stageT++Object.tcl |    1.20 | 
#            src/stepInstanceT++Object.tcl |     1.1 | 
#                    src/stepT++Object.tcl |    1.20 | 
#          src/stripElabAndColonPrefix.tcl |     1.1 | 
#                        src/tPlusPlus.tcl |     1.2 | 
#               src/updateFoundationDb.tcl |     1.1 | 
#                      src/updateStage.tcl |     1.1 | 
#                    src/writeEllipsis.tcl |     1.1 | 
#                  src/writeFoundation.tcl |     1.2 | 
#          src/writeFoundationTemplate.tcl |     1.6 | 
# -------------------------------------------------------------------------------------
namespace eval fcf_header {
  variable README {
##############################################################################
#                                README                                      #
##############################################################################
# This is an early release. Expect problems!
# If you do run into any issues, please contact Buda Leung with details.
# 
##############################################################################
# 1. General Use Model
##############################################################################
# 
# The Foundation Flow System has been implemented as a prototype in this
# single TCL script. To enable the system, simply source this tcl script.
#
# This script uses t++ (developed by John Croix) and tcllib1.12. The paths
# have been set to a temporary location on /net/alexius. If you do not have
# access to these directories, let buda know and he will package those
# libraries up.
# 
# The Foundation Flow System allows the user to maintain a configuration
# file which defines flow inputs (source files, constraint files), as well 
# as flow configuration variables (synthesis effort, mbist or not, etc.)
#
# The user may also develope their own 100% customizable flows which use
# the variables in the configuration file. Flows are normally defined
# separately from configuration files, and are saved in "flow definition files."
#
# Configuration files and Flow Definition files may be read in to the
# system in any arbitrary order using the command:
# 
# read_foundation {file list}
#
# Once the user has read in their configuration and flow files, they can
# view data in the Foundation Flow System Database using the following commands:
#
# report_foundation : report on all config variables
# report_steps      : report all step definitions
# report_stages     : report all stage definitions
#
# In addition, there are several APIs provided to allow the user to develope
# plugins for 3rd party tools:
#
# get_flow
# get_stage
# get_step
# get_var
#
# The user can at any time update Foundation Flow variables, stages, steps,
# and flows by simply reading in another configuration file which updates
# the object.
# 
# Once the user is satisfied with the configuration, they write out
# a tool script using the command:
#
# write_foundation_template <flowName>
#
# This writes out a tool run script for each stage defined.
# 
# The user can also write out a Foundation Configuration File using:
# write_foundation -file <filename>
#
##############################################################################
# 2. Foundation Configuration File
##############################################################################
# The Foundation flow is generally started by writing a configuration file.
# The configuration file is read into the tool using
#
# This file contains variables with the following syntax:
#
# set vars(name) value | list
#
# While the Frontend Foundation Config file 1.0 syntax is 100% backward compatible
# with the EDI flow, it is also a superset and supports many other variables
# not used in EDI.
#
# Here are the current Frontend Foundation Flow Configuration Variables
# 
# $vars(hdl_file_set,<name>)
# 	 
#    Detailed Description
#
#    Syntax: set vars(hdl_file_set,<name>) {<list>}
#    Example:
#
#    set vars(hdl_file_set,my_first_list) {/net/proj/chip.v /net/proj/top.v ...}
#
# $vars(<hdl_file_set>,language)
# 	 
#    Detailed Description
#
#    Language Type of an HDL file set (one or more hdl files).
#    Syntax: set vars(<hdl_file_set>,language) = [Verilog95 | Verilog01 | SystemVerilog05 | VHDL87 | VHDL93]
#
#    Examples:
#    
#    set vars(default_fileset,language) Verilog95
#    set vars(arm_core_fileset,language) Verilog01
#    set vars(tb_fileset,language) SystemVerilog05
#    set vars(mac_fileset,language) VHDL87
#    set vars(phy_fileset,language) VHDL93
#
# $vars(<hdl_file_set>,defines)
# 	 
#    Detailed Description
#
#    List of compiler defines to be applied to the HDL file.
#    Syntax:
#    set vars(<hdl_file_set>,defines) {{definition1=value1} {[definition2=value2]} ...} 
#    
#    The argument passed to this variable is a TCL list of definition=value pairs.
#    
#    Examples:
# 
#    set vars(default_fileset,defines) {{LOW_POWER=true} {MAC_CONFIG=BT}}
# 
# $vars(<hdl_file_set>,search_path)
#  	 
#    Detailed Description
#    
#    List of paths to search to resolve an hdl file.
#    Syntax: set vars(<hdl_file_set>,search_path) <list>
#    Example:
#    set vars(default_fileset,search_path) {/net/proj/foo /net/proj/bar}
#    
# $vars(<hdl_file_set>,lib_map)
#     	 
#    Detailed Description
#    
#    Definition to assign a file to a given library for compilation.
#    Also used to assign any files compiled from a library path to a logical library definition.
#    Typically used with VHDL or mixed language designs.
#    Syntax: set vars(<hdl_file_set>,lib_map) {<LIBRARY_NAME1>=<LIBRARY_PATH1>[ <LIBRARY_NAME2>=<LIBRARY_PATH2> ...}
#    
#    Example:
#    
#    set vars(top_fileset,lib_map) {TOP=/net/proj/designlib/top}
#    set vars(mac_fileset,lib_map) {MAC=/designs/mac}
#    set vars(phy_fileset,lib_map) {PHY=/designs/phy}
#    set vars(tb_fileset,lib_map) {{TB=/net/tbfiles}{TB2=/net/tb2files}}
# 
# $vars(hdl_file_sets)
#  	 
#    Detailed Description
#    
#    List of hdl file sets.
#    The file sets must be defined in the Configuration in order to be resolved.
#    
#    Example:
#    set vars(hdl_file_set,arm_core_file_set) {arm_top.v}
#    set vars(hdl_file_set,mem_file_set) {mem.v}
#    set vars(hdl_file_set,dsp_file_set) {dsp.v}
#    
#    set vars(hdl_file_sets) {arm_core_file_set mem_file_set dsp_file_set}
#
##############################################################################
# 3. Foundation Flow Definition Files
##############################################################################
#
# To create a new flow, use the following:
#
# set_flow <flowname> {
#    insert_stage ...
# }
#
# It is not necessary to insert_stages in the initial flow definition block
# but it is allowed.
#
# To create a new stage, use the following;
#
# set_stage <stagename> {
#    insert_step { ... }
# }
#
# The commands that you wish to be printed should go in a step definition
#
# This is the canonical hello world example:
#
# set_flow hello_world {
#     insert_stage hello
# }
# 
# set_stage hello {
#       insert_step {puts "hello world" }
# }
#################################################
# User API
#################################################
#
# This section describes the API commands used to interact with the Frontend Foundation Database
# The API is as follows:
#
# read_foundation - read a foundation config file
# write_foundation - write out a Foundation config
# report_foundation - report stats on database
# update_foundation_db - update database from tool
# write_foundation_template - write run script from Foundation DB and flow config
#
#################################################

##############################################################################
# 4. EDI Dictionary
##############################################################################
# This section documents the known EDI Foundation Flow Configuration Variables
# which are considered 'predefined' variables for all Cadence Frontend 
# Foundation Flows (i.e., FED flows shipped by the Product Core Team).
#  
# vars(version)
# vars(design_root)
# vars(script_root)
# vars(dbs_dir)
# vars(rpt_dir) 
# vars(html_dir) 
# vars(plug_di)r
# vars(flow) 
# vars(abort) 
# vars(netlist) 
# vars(design) 
# vars(fp_file)   
# vars(def_files) 
# vars(cts_spec) 
# vars(cpf_file)
# vars(cpf_keep_rows)
# vars(activity_file)
# vars(activity_file_type)
# vars(power_nets)
# vars(ground_nets)
# vars(process) 
# vars(max_route_layer)
# vars(lef_files)  
# vars(library_sets) 
# vars(<library_set>,si)  
# vars(<library_set>,timing)  
# vars(rc_corners) 
# vars(<rc_corner>,T) 
# vars(<rc_corner>,cap_table) 
# vars(<rc_corner>,qx_tech_file) 
# vars(<rc_corner>,pre_route_cap_factor) 
# vars(<rc_corner>,pre_route_clk_cap_factor) 
# vars(<rc_corner>,pre_route_clk_res_factor) 
# vars(<rc_corner>,pre_route_res_factor) 
# vars(<rc_corner>,post_route_cap_factor) 
# vars(<rc_corner>,post_route_clk_cap_factor) 
# vars(<rc_corner>,post_route_clk_res_factor)
# vars(<rc_corner>,post_route_res_factor) 
# vars(<rc_corner>,post_route_xcap_factor) 
# vars(delay_corners) 
# vars(<delay_corner>,library_set) 
# vars(<delay_corner>,rc_corner) 
# vars(<delay_corner>,clock_cell_early) 
# vars(<delay_corner>,clock_cell_late)
# vars(<delay_corner>,clock_net_early) 
# vars(<delay_corner>,clock_net_late) 
# vars(<delay_corner>,data_cell_early)
# vars(<delay_corner>,data_cell_late) 
# vars(<delay_corner>,data_net_early) 
# vars(<delay_corner>,data_net_late) 
# vars(constraint_modes) 
# vars(<constraint_mode>,pre_cts)
# vars(<constraint_mode>,incr_cts)
# vars(<constraint_mode>,post_cts)
# vars(hold_analysis_views)
# vars(setup_analysis_views) 
# vars(<analysis_view>,constraint_mode) 
# vars(<analysis_view>,delay_corner) 
# vars(default_hold_view) 
# vars(default_setup_view) 
# vars(active_hold_views)  
# vars(active_setup_views) 
# vars(power_analysis_view) 
# vars(report_power) 
# vars(assign_buffer) 
# vars(high_timing_effort)  
# vars(congestion_effort)
# vars(dont_use_list)
# vars(use_list)
# vars(generate_tracks) 
# vars(welltaps)
# vars(jtag_cells)
# vars(jtag_rows)
# vars(enable_cppr) 
# vars(enable_ocv) 
# vars(enable_ss) 
# vars(in_place_opt) 
# vars(place_io_pins) 
# vars(clock_gate_aware)
# vars(resize_shifter_and_iso_insts) 
# vars(tie_cells)
# vars(critical_range)
# vars(useful_skew)
# vars(preserve_assertions)
# vars(leakage_power_effort)
# vars(dynamic_power_effort)
# vars(clock_gate_aware)
# vars(resize_shifter_and_iso_insts) 
# vars(cts_cells)
# vars(skew_buffers)
# vars(route_clock_nets) 
# vars(clock_eco) 
# vars(clock_gate_aware)
# vars(clock_gate_clone) 
# vars(fix_hold) 
# vars(fix_hold_ignore_ios) 
# vars(filler_cells)
# vars(postroute_extraction_effort)
# vars(multicut_via_effort)
# vars(litho_driven_routing)
# vars(postroute_spread_wires) 
# vars(delta_delay_threshold)
# vars(celtic_settings)
# vars(coupling_c_thresh)
# vars(relative_c_thresh)
# vars(total_c_thresh)
# vars(si_analysis_mode)
# vars(metalfill) 
# vars(metalfill_tcl)
# vars(gds_files)
# vars(gds_map_file)
# vars(oa_abstract_name) 
# vars(oa_layout_name) 
# vars(oa_ref_lib) 
# vars(local_cpus)
# vars(remote_hosts) 
# vars(cpu_per_remote_host)
# vars(always_source_tcl) 
# vars(pre_init_tcl) 
# vars(post_init_tcl) 
# vars(pre_place_tcl) 
# vars(place_tcl)
# vars(post_place_tcl) 
# vars(pre_cts_tcl) 
# vars(cts_tcl)
# vars(post_cts_tcl) 
# vars(pre_postcts_tcl) 
# vars(post_postcts_tcl) 
# vars(pre_postcts_hold_tcl) 
# vars(post_postcts_hold_tcl) 
# vars(pre_prects_tcl) 
# vars(post_prects_tcl) 
# vars(pre_route_tcl) 
# vars(post_route_tcl) 
# vars(pre_postroute_tcl) 
# vars(post_postroute_tcl) 
# vars(pre_postroute_hold_tcl) 
# vars(post_postroute_hold_tcl) 
# vars(pre_postroute_si_hold_tcl) 
# vars(post_postroute_si_hold_tcl) 
# vars(pre_postroute_si_tcl) 
# vars(post_postroute_si_tcl) 
# vars(pre_signoff_tcl) 
# vars(post_signoff_tcl) 
# vars(pre_assemble_tcl)
# vars(post_assemble_tcl) 
# vars(exit_on_finish)

##############################################################################
# 5. RC Dictionary
##############################################################################
# The following were added in for synthesis.
#
# vars(activity_file_modes)  <list of modes>
# vars(<activity_file_mode>,activity_file_type) [tcf|saif|vcd]
# vars(<activity_file_mode>,activity_files) <file list>
#
##############################################################################
  }
}
namespace eval FFF {
  namespace export get_tool
  proc get_tool {} {
    set tool_name ""
    set path_to_exe [info nameofexecutable]
    if {[regexp {/rc(64)?(-\w)?$} $path_to_exe]} {
      set tool_name "rc"
    } elseif {[regexp {.*\/(LEC|lec)} $path_to_exe]} {
      set tool_name "lec"
    } elseif {[regexp {.*\/verify} $path_to_exe]} {
      set tool_name "clp"
    } elseif {[regexp {.*\/CCD} $path_to_exe]} {
      set tool_name "ccd"
    } elseif {[regexp {.*\/ctos} $path_to_exe]} {
      set tool_name "ctos"
    } elseif {[regexp {.*\/tclsh} $path_to_exe]} {
      set tool_name "tclsh"
    } elseif {[regexp {.*\/encounter} $path_to_exe]} {
      set tool_name "edi"
    } elseif {[regexp {.*\/velocity} $path_to_exe]} {
      set tool_name "edi"
    } elseif {[regexp {.*\/ncsim} $path_to_exe]} {
      set tool_name "ies"
    }
    return $tool_name
  }
}
if {[::FFF::get_tool] ne "rc" } {
  package require compatibility
}
namespace eval FFF {
  namespace export flatten_list
  proc flatten_list list {string map {\{ "" \} ""} $list}
}
namespace eval FFF {
  proc remove_outer_braces {args} {
    #while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $args full args ]} {}
    regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $args full args
    #regsub {^\s*\{} $args "" args
    #regsub {\}\s*$} $args "" args
    return $args
  }
  namespace export remove_outer_braces
}
namespace eval FFF {
  namespace export relativizeFileOrDir
  proc relativizeFileOrDir {args} {
    #puts "relativizeFileOrDir $args"
    set NewDirName ""
    set arrName "vars"
    set VarDirName ""
    set skipVariableUsageInReference 0
    set mustExist 0
    set skipList {}
    set exactVar ""
    set exactSubDirMatch ""
    set varToSub ""
    set skipDirList ""

    while {[llength $args] > 0} {
      set option [lindex $args 0]
      set args [lreplace $args 0 0]
      switch -exact -- $option {
         -arr {
            set arrName [lindex $args 0]
            set args [lreplace $args 0 0]
         }
         -vardir {
            set VarDirName [lindex $args 0]
            set args [lreplace $args 0 0]
         }
         -newdir {
           set NewDirName [lindex $args 0]
           set args [lreplace $args 0 0]
         }
         -skipVariableUsageInReference {
            set skipVariableUsageInReference 1
         }
         -mustExist {
            set mustExist 1
         }
	 -skipVar {
	    lappend skipList [lindex $args 0]
            set args [lreplace $args 0 0]
         }
	 -skipDir {
	    lappend skipDirList [lindex $args 0]
            set args [lreplace $args 0 0]
         }
         -var {
	    set varToSub [lindex $args 0]
            set args [lreplace $args 0 0]
         }
	 -exactSubDirMatch {
	    set exactSubDirMatch [lindex $args 0]
            set args [lreplace $args 0 0]
	 }
      }
    };# end while (processing args)

    # Always skip the VarDirName when analyzing variables in the array
    lappend skipList $VarDirName

    # Need to convert a list of files to relative paths (TBD)
    global $arrName
    # Check if the vardir (key) exists in the array. If not, exit
    if {$VarDirName eq ""} {
      return -code error "relativizeFileOrDir() called w/out -vardir argument. Exiting ..."
    }
    if {$NewDirName eq ""} {
      set NewDirName $VarDirName
    }

    set relativizeConvMesgList {}
    if {[info exists ${arrName}($VarDirName)]} {
      foreach arg [lsort -dictionary [array names $arrName]] {
	if {$varToSub eq "" || $varToSub eq $arg} {
          # foreach key (entry) in the array, look for files/folders
          set re ""
          #puts "lsearch $skipList $arg"
	  # First check black list
          if {[lsearch $skipList $arg] == -1} {
	    if {![regexp {\[} [set ${arrName}($arg)]]} {
              # only continue if the variable is not the vardir (key) itself, and the value of the variable doesn't have a $ in it
              #puts "relativizeFileOrDir() checking ${arrName}($arg) (current: ->[set ${arrName}($arg)]<-)"
              set tmpValue ""
              #
              # Process all members of the $arrName(arg) (could be a list), and subst each one
              #
              set fileFound 0
              set re "[file normalize [set ${arrName}($VarDirName)]]\/(.*)"
              foreach possibleFile [set ${arrName}($arg)] {
	        if {$mustExist} {
                  # The file or dir must exist after normalization
	  	  #puts "Checking for existence of [file normalize [subst $possibleFile]]"
                  if {![catch {file exists [file normalize [subst $possibleFile]]}]} {
	            if {[file exists [file normalize [subst $possibleFile]]]} {
	  	      #puts "Exists: [file normalize [subst $possibleFile]]"
	  	      set file [file normalize [subst $possibleFile]]
	  	      set size [file size $file]
	  	      set mtime [file mtime $file]
	  	      set type [file type $file]
	  	      #puts "file $file size: $size, mtime: $mtime type: $type"
                      set fileFound 1
	              #puts "Checking for path to file: ->[file normalize [subst $possibleFile]]<- from ->[file normalize [set ${arrName}($VarDirName)]]<-"
	              set relPathValue [relPathTo [file normalize [subst $possibleFile]] [file normalize [subst [set ${arrName}($VarDirName)]]]]
	  	      #puts "relPathValue: $relPathValue"
		      set skipDueToSkipDir 0
		      if {$skipDirList ne ""} {
		        foreach dir $skipDirList {
		          set re3 "[file normalize [subst $dir]]/(.*)"
		          if {[regexp $re3 [file normalize [subst $possibleFile]] full relativePortion]} {
		            set skipDueToSkipDir 1
		          }
		        }
		      }
		      if {!$skipDueToSkipDir} {
	  	        if {$exactSubDirMatch ne ""} {
	  	          set re2 "$exactSubDirMatch/(.*)"
	  	          # the normalized path of the possible file has to match the normalized path of the subdir...
                          if {[regexp $re2 [file normalize [subst $possibleFile]] full relativePortion]} {
	  	            if {$relPathValue ne [file normalize $possibleFile]} {
                              if {$skipVariableUsageInReference} {
                                lappend tmpValue $relPathValue
                              } else {
                                lappend tmpValue "\$${arrName}($VarDirName)/$relPathValue"
	                      }
	                    } else {
                              lappend tmpValue $possibleFile
	                    }
                          } else {
	  	            lappend tmpValue $possibleFile
	  	          }
	  	        } else {
	  	          #puts "skipVariableUsageInReference: $skipVariableUsageInReference"
	                    if {$relPathValue ne [file normalize $possibleFile]} {
                              if {$skipVariableUsageInReference} {
                                lappend tmpValue $relPathValue
                              } else {
                                lappend tmpValue "\$${arrName}($VarDirName)/$relPathValue"
	                      }
	                    } else {
                              lappend tmpValue $possibleFile
	                    }
	  	          #puts "final value: ->$tmpValue<-"
	  	        }
		      } else {
                      lappend tmpValue $possibleFile
		      }
	  	    } else {
	  	      # could not be tested as a file, so just lappend the entire string
	  	      lappend tmpValue $possibleFile
	  	    }
	          } else {
	  	    # could not be tested as a file, so just lappend the entire string
	  	    lappend tmpValue $possibleFile
	  	  }
                } else {
                  # The file or dir need not exist, but the vardir must be a subdir (i.e., there must be a subdir that does exist)
	          #puts "Checking possible file: ->[subst $possibleFile]<- against regular expression ->$re<-"
	          if {[regexp $re [subst $possibleFile] full relativizedPortion]} {
	            if {$relativizedPortion eq ""} { set relativizedPortion "."}
                    set fileFound 1
                    if {$skipVariableUsageInReference} {
                      lappend tmpValue $relativizedPortion
                    } else {
                      lappend tmpValue "\$${arrName}($VarDirName)/$relativizedPortion"
                    }
                    if {[flatten_list $possibleFile] ne [flatten_list $tmpValue]} {
                      #puts "<FF> INFO Converted file $possibleFile to use a relative path to determine it's location: $tmpValue"
                    }
                  } else {
                    lappend tmpValue $possibleFile
                  }
                }
              }
              # If the above for loop didn't find any files, simply reset the arrName(arg) statement
              if {$fileFound} {
                # Clean up original arrName(arg) and subb'ed value to prepare for comparison
                set testArg [flatten_list [set ${arrName}($arg)]]
                regsub -all {[ \r\t\n\\]+} $testArg " " testArg
                regsub {^\s+(.*)} $testArg {\1} testArg
                regsub {(.*)\s+$} $testArg {\1} testArg

                set tmpValue [flatten_list $tmpValue]
                regsub -all {[ \r\t\n]+} $tmpValue " " tmpValue
                regsub {^\s+(.*)} $tmpValue {\1} tmpValue
                regsub {(.*)\s+$} $tmpValue {\1} tmpValue
                if {$tmpValue ne "" && $tmpValue ne $testArg} {
                  #puts "<FF> INFO Original value for arrName($arg): ->$testArg<-"
		  if {$relativizeConvMesgList eq ""} {
	 	    lappend relativizeConvMesgList "# Variable conversion for paths relative to \$${arrName}($VarDirName) ([set ${arrName}($VarDirName)])"
		  }
                  lappend relativizeConvMesgList "<FF> INFO Converted file variable [subst $arrName]($arg) from [set ${arrName}($arg)] to $tmpValue"
                  set ${arrName}($arg) $tmpValue
                  #puts "<FF> INFO Final value for arrName($arg):    ->$tmpValue<-"
                }
              }
	    }
          }
	}
      }
    }
    if {[llength $relativizeConvMesgList] > 1} {
      lappend relativizeConvMesgList "# Total converted for variable \$${arrName}($VarDirName):[expr {[llength $relativizeConvMesgList]-1}]\n"
    }
    return $relativizeConvMesgList
  }
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [get_tool_version.tcl]                                                 #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
#For Global Namespace:

##########################################################
# proc get_tool_version
##########################################################
# Attempts to determine what tool this script is loaded into
# Known executables (Cadence)
# RC: .*\/rc
# LEC: .*\/LEC
# CLP: .*\/verify
# CCD: .*\/CCD
# ET:
# IES:
# CtoS:
# tclsh: .*\/tclsh
namespace eval FFF {
  namespace export get_tool_version
  proc get_tool_version {} {
    set tool_version ""
    #set path_to_exe [exec basename [info nameofexecutable]]
    ##nagelfar syntax get_version
    ##nagelfar syntax getVersion
    switch -- [get_tool] {
      rc {
        set tool_version [get_attribute program_version /]
	if {[regexp {^(\d+)\.(\d+)$} $tool_version]} {
	  set tool_version ${tool_version}.001
        }
      }
      lec { upvar env(LEC_VERSION) version; set tool_version $version }
      verify { upvar env(VERIFY_VERSION) version; set tool_version $version }
      ccd { upvar env(CCD_VERSION) version; set tool_version $version }
      ctos {
        set tmpstr [regsub {Internal.} [join [get_version] "."] ""]
        regexp {(\S+)(.32|.64)\s.*} $tmpstr full tmp2str
        regsub -all {\.} $tmp2str {_} tool_version
      }
      tclch {  set tool_version [info patchlevel] }
      encounter { set tool_version [getVersion] }
      velocity { set tool_version [getVersion] }
      ncsim { set tool_version "default" } 
    }
    return $tool_version
  }
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [get_tool_release.tcl]                                                 #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
#For Global Namespace:

##########################################################
# proc get_tool_release
##########################################################
# Attempts to determine what tool release this script is loaded into
# Known executables (Cadence)
# RC: .*\/rc
# LEC: .*\/LEC
# CLP: .*\/verify
# CCD: .*\/CCD
# ET:
# IES:
# CtoS:
# tclsh: .*\/tclsh
# 
# Release format is v<major_release>_<minor_release>[_<sub minor release>]
# where the last release string is only currently valid for RC
# 
# Example:
# v10_1, v09_1, v09_11, v11_1, etc.

namespace eval FFF {
  namespace export get_tool_release
  proc get_tool_release {} {
    set tool_version ""
    #set path_to_exe [exec basename [info nameofexecutable]]
    set path_to_exe [info nameofexecutable]
    if {[regexp {.*\/rc$} $path_to_exe]} {
      set tool_version [get_attribute program_version /]
      regexp {v(\d+).(\d)\d-[s|d|p](\d).?} $tool_version full toolV1 toolV2 toolR3
      set tool_release "v${toolV1}_${toolV2}_${toolR3}00"
    } elseif {[regexp {.*\/(LEC|lec)$} $path_to_exe]} {
      # All conformal: 10.10-s260
      # Another bug in LEC's implementation of tcl - not handling namespaces correctly, so i have to upvar to get the environment variable
      upvar env(LEC_VERSION) version
      set tool_version $version
      regexp {(\d+).(\d)\d.?} $tool_version full toolV1 toolV2 
      set tool_release "v${toolV1}_${toolV2}"
    } elseif {[regexp {.*\/verify$} $path_to_exe]} {
      #set tool_version $env(VERIFY_VERSION)
      upvar env(VERIFY_VERSION) version
      set tool_version $version
      regexp {(\d+).(\d)\d.?} $tool_version full toolV1 toolV2 
      set tool_release "v${toolV1}_${toolV2}"
    } elseif {[regexp {.*\/CCD$} $path_to_exe]} {
      upvar env(CCD_VERSION) version
      set tool_version $version
      regexp {(\d+).(\d)\d.?} $tool_version full toolV1 toolV2 
      set tool_release "v${toolV1}_${toolV2}"
    } elseif {[regexp {.*\/ctos$} $path_to_exe]} {
      set tmpstr [regsub {Internal.} [join [get_version] "."] ""]
      regexp {(\S+)(.32|.64)\s.*} $tmpstr full tmp2str
      regsub -all {\.} $tmp2str {_} tool_version
      regexp {(\d+)_(\d).?} $tool_version full toolV1 toolV2 
      # Ctos: 11 1 0 Internal d 002 {32 bit} {}
      set tool_release "v${toolV1}_${toolV2}"
    } elseif {[regexp {.*\/tclsh$} $path_to_exe]} {
      set tool_release [info tclversion]
    } elseif {[regexp {.*\/encounter$} $path_to_exe]} {
      # Encounter: 09.11-s082_1
      set tool_version [getVersion]
      regexp {(\d+).(\d+).?} $tool_version full toolV1 toolV2 
      set tool_release "v${toolV1}_${toolV2}"
    } elseif {[regexp {.*\/velocity$} $path_to_exe]} {
      set tool_version [getVersion]
      regexp {(\d+).(\d+).?} $tool_version full toolV1 toolV2 
      set tool_release "v${toolV1}_${toolV2}"
    } elseif {[regexp {.*\/ncsim$} $path_to_exe]} {
      set tool_version "default"
      set tool_release "default"
    }
    return $tool_release
  }
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [defaults.tcl]                                         	     #
#  Description:                                                              #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################

#
# FFF DB Initialization
# The following arrays are used to track all objects created.
# They are queried by get_flow, get_stage, and get_step.
#
namespace eval ::FFF {
  ##
  ## For Flow Definitions (create_flow)
  ## 
  #array set flow_objid_arr {};
  #
  ##
  ## For Flow Instantiations
  ##
  #array set flowInst_objid_arr {};

  #
  # For Stage Definitions (i.e., defined by create_stage, or insert_stage {block} iff create_stage is missing
  #
  array set stage_objid_arr {};

  #
  # For Stage Instantiations (only defined by insert_stage)
  #
  array set stageInst_objid_arr {};

  #
  # For Step Definitions (i.e., defined by create_step, or by insert_step {block} iff create_step is missing
  #
  array set step_objid_arr {};

  #
  # For Step Instantiations (only by insert_step)
  array set stepInst_objid_arr {};

  #
  # For Step Definitions (i.e., defined by create_step, or by insert_step {block} iff create_step is missing
  #
  array set plugin_objid_arr {};

  #
  # For Step Instantiations (only by insert_step)
  array set pluginInst_objid_arr {};


}
namespace eval ::FFF {
  proc init_elab_db {} {
    # Initialize elabdb namespace
    namespace eval ${::FFF::elabns} {} {
      # Note - we want stubs in the elabns (we never want these eval'd in the elabns, but have
      # workarounds to source files in the elabns to support parameters)
      # FCF/FDF Stubs (basically, ignore these commands)
      foreach cmd $::FFF::FFFCmdList {
        eval {proc $cmd {args} { } };
      }
    }
  }
}
###############################################################################
# Copyright (c) 2010 Cadence Design Systems, Inc.                             #
#                                                                             #
# This code sets up a C++-like object-oriented framework for Tcl.             #
###############################################################################


#
# Calls to the following Tcl procs generate warnings in the Tcl lint checking
# program.  The linter complains that the following commands are not
# recognized:
#     ::object::delete
#     ::object::new
#     ::object::objectExists
#     ::object::debug
#     ::object::createObjectCommands
#     ::object::debugExit
# These are created in the code (below), so they will exist by the time that
# they are invoked.  For some reason, the linter doesn't see them (maybe
# because they're in a namespace?).  To solve the problem, I've placed the
# comment "##nagelfar ignore" before those offending lines of text
#


if {![namespace exists ::object::]} {
   #--------------------------------------------------------------------------#
   # We are going to introduce 3 global commands: new, delete, and object.    #
   # All other object operations are going to occur within the object         #
   # namespace                                                                #
   #                                                                          #
   # NOTE: One additional global command is created that should really be     #
   #       hidden: debugExit.  This is only used during the debug effort for  #
   #       this code and should not be called independently.                  #
   #--------------------------------------------------------------------------#


   proc delete {object} {
      #
      # Delete the passed object.  If no object is passed in (""), we will
      # just return (just like C++ trying to delete a NULL pointer).
      #
      # NOTE: Destructors are always virtual.  Check the object to find out
      #       if it is actually an upcast object and, if so, downcast until
      #       we get to the object that was actually allocated.
      #

      if {$object eq ""} {
         return
      }

      #
      # Make sure that we are actually destroying an object
      #

      if {[catch {$object->typeid}]} {
         error "Attempt to delete something that isn't an object ($object)"
      }
      set object [$object->__getPrivateThis__]

      #
      # Virtual destruction.  We may have been passed a "pointer" to something
      # that the object inherited instead of the original object that was
      # allocated.  We need to work back through the inheritance tree to get
      # to the root object and delete that (see the inheritance mechanism to
      # find out how this variable was set).
      #

      while {1} {
         set objectSpace [$object->__getPrivateSpace__]
         set var "${objectSpace}::_downcast_obj"
         if {[info exists $var]} {
            set object [subst "\$$var"]
         } else {
            break
         }
      }

      ##nagelfar ignore
      ::object::delete $object
   }


   proc new {objectName args} {
      #
      # We want to create a new instance of an object (named objectName).  If
      # there are any arguments, they are in args
      #
      # NOTE: Because we need to be aware of namespaces, we need to pass in the
      #       callers namespace to the actual routine that performs the
      #       instance allocation and creation.  At the moment we know that the
      #       caller's namespace is one level up
      #

      set callerNS [uplevel 1 namespace current]
      ##nagelfar ignore
      return [::object::new $objectName $callerNS $args]
   }


   proc object {objectName members} {
      #
      # The object command has multiple forms.  In the first form, we are
      # creating an object, so the first list after the keyword "object" is
      # the name of an object that we are creating.
      #
      # In the second form, we are checking to see if an object exists.  In
      # that case, $objectName will be "exists" and $members will be the name
      # of an object we are checking on.
      #

      set ns [uplevel 1 namespace current]
      if {$objectName eq "exists"} {
         ##nagelfar ignore
         return [::object::objectExists $members $ns]
      } elseif {$objectName eq "debug"} {
         ##nagelfar ignore
         ::object::debug $members
      } else {
         ##nagelfar ignore
         ::object::createObjectCommands $objectName $ns $members
      }
   }


   #--------------------------------------------------------------------------#
   # Everything within the object namespace is responsible for creating,      #
   # maniuplating, and destroying objects.  The only routines that should     #
   # ever access this namespace are the routines above and built-in object    #
   # APIs.                                                                    #
   #--------------------------------------------------------------------------#


   namespace eval ::object:: {
      #-----------------------------------------------------------------------#
      # Variables used to create and manipulate objects.                      #
      #-----------------------------------------------------------------------#

      #
      # Information about specific object variables and procs are held in
      # the variables apiProperties and varProperties
      #

      variable apiProperties
      variable varProperties

      array set apiProperties {}
      array set varProperties {}

      #
      # The body of a member API is held in the array apiBody.  The calling
      # arguments are in the array apiArgs
      #

      variable apiArgs
      variable apiBody

      array set apiArgs {}
      array set apiBody {}

      #
      # If a variable is declared with a value, that value is held in the
      # array varValues
      #

      variable varValues

      array set varValues {}

      #
      # The variable isConst is 1 if the variable or API should be CV qualified
      # as const, 0 otherwise
      #

      variable isConst 0

      #
      # The variable isStatic is 1 of the variable or API is staticly
      # qualified, 0 otherwise
      #

      variable isStatic 0

      #
      # The variable isVirtual is 1 if the API is qualified as virtual, false
      # otherwise
      #

      variable isVirtual 0

      #
      # The visibility of an API or variable is recorded within the variable
      # visibility (private, protected, and public)
      #

      variable visibility "public"

      #
      # The name of the object we are trying to define is held in $definingName
      #

      variable definingName ""

      #
      # The array "objectBuildCommands" contains the Tcl code that, when
      # executed, will create a new instance of an object.  Build commands are
      # stored in the array using an array index of the form:
      #     objectBuildCommands(<namespace>,<obj name>)
      # where <namespace> is the namespace that the object is defined within
      # (for example, "::" for the global namespace) and <obj name> is the
      # name of the object
      #

      variable objectBuildCommands

      array set objectBuildCommands {}

      #
      # The variable instanceCount holds the total number of all objects
      # created by the system.  It is used to create a unique numeric ID for
      # every object (see the built-in API objectid)
      #

      variable instanceCount -1

      #
      # The list of built-ins that will be supplied for the object
      # automatically are in objectBuiltins
      #

      variable objectBuiltins [list "new" "delete" "typeid" "getVarPath" \
                                  "getProcPath" "objectSpace" "obj" \
                                  "const" "constCast" "isConst" \
                                  "inherit" "friend" "downcast" "objectid" \
                                  "__getPrivateSpace__" "__getPrivateThis__" \
                                  "__getPublicSpace__" "__getPublicThis__" \
                                  "__start_const__" "__end_const__" \
                                  "__start_inst__"]

      #
      # The system also reserves certain variable names for internal uses
      #

      variable objectReservedVars [list "_priv_procs" "_prot_procs" \
                                      "_pub_procs" "_priv_vars" "_prot_vars" \
                                      "_pub_vars" "_virtual_procs" \
                                      "_const_vars" "_ref_count" "_super" \
                                      "_priv_super" "_const_procs" \
                                      "_downcast_obj" "_friends"]

      #
      # Used to debug object allocations and deallocations
      #

      variable debugAllocations
      variable debugExit ""
      variable debugObjects 0

      array set debugAllocations {}


      #-----------------------------------------------------------------------#
      # Objects are defined by creating procs for the object keywords and     #
      # evaluating the object definition, letting Tcl invoke the procs as     #
      # the keywords are parsed.  The procs record information about the      #
      # object so that, when an object needs to be created, the proper Tcl    #
      # procs can be created that the object requires.                        #
      #                                                                       #
      # The following keywords are currently recognized:                      #
      #    o const - Create const variables or APIs                           #
      #    o member - Create an object member function                        #
      #    o private, protected, and public - Create scoped variables and     #
      #      member APIs.  Scoping corresponds to the C++ scoping for         #
      #      functions and variables.                                         #
      #    o static - Create APIs and variables are are scoped within an      #
      #      object but are shared across all object instances                #
      #    o var - Create an uninitialized or initialized variable            #
      #    o virtual - Create a virtual API (just as C++ does)                #
      #                                                                       #
      # Note that qualifiers can be grouped.  For example, the const          #
      # qualifier can be applied against a single element or a block of       #
      # elements:                                                             #
      #     const var x                                                       #
      #     const {                                                           #
      #        var y                                                          #
      #        var z                                                          #
      #     }                                                                 #
      #                                                                       #
      # Also note that, the way that the implementation is defined now, an    #
      # API within a private block can be stored as public by providing the   #
      # "public" qualifier:                                                   #
      #       private {                                                       #
      #          member x {} {...}                                            #
      #          public member y {} {...}                                     #
      #       }                                                               #
      # However, there is no way to make something "un-static" or             #
      # "un-virtual", so those are effectively "sticky" properties.           #
      #-----------------------------------------------------------------------#


      proc const {args} {
         #
         # Set the const flag for the variables and/or APIs to be processed
         # in $args
         #

         variable isConst

         set saveIsConst $isConst
         set isConst 1
         if {[llength $args] == 1} {
            eval [lindex $args 0]
         } else {
            eval $args
         }
         set isConst $saveIsConst
      }


      proc getProperties {} {
         #
         # Examine all of the various qualifiers and create a list that
         # provides all of the properties in force when this API is called
         #

         variable isConst
         variable isStatic
         variable isVirtual
         variable visibility

         set properties [list]
         if {$isConst} {
            lappend properties "const"
         }
         if {$isVirtual} {
            lappend properties "virtual"
         }
         if {$isStatic} {
            lappend properties "static"
         }
         lappend properties $visibility
      }


      proc member {name memberArgs {body ""}} {
         #
         # We need to define a member function for the object.  The API name
         # is, obviously, in $name while the API arguments (including
         # default arguments) are in $memberArgs.  Save this information, plus
         # the API body, for later processing
         #

         variable apiArgs
         variable apiBody
         variable apiProperties
         variable definingName
         variable isConst
         variable isStatic
         variable isVirtual
         variable objectBuiltins

         #
         # Make sure that we don't have an error situation:
         #   - We are not redefining an API
         #   - We are not redefining a built-in
         #

         if {[lsearch [array names apiProperties] $name] != -1} {
            error "Error: duplicate member function ($name) found"
         }
         if {[lsearch $objectBuiltins $name] != -1} {
            error "Error: object builtin \"${name}\" cannot be redefined"
         }

         #
         # We can't have a constant or virtual static API
         #

         if {$isStatic} {
            if {$isConst} {
               error "Error: static member \"${name}\" cannot be constant"
            }
            if {$isVirtual} {
               error "Error: static member \"${name}\" cannot be virtual"
            }
         }

         #
         # If the first character is a "~", this had better be the destructor
         # for the object
         #

         if {[string index $name 0] eq "~"} {
            if {[string range $name 1 end] ne $definingName} {
               error "Error: destructor misspelled for $definingName ($name)"
            }
         }

         #
         # This may be a pure-virtual function
         #

         if {($body eq "") && $isVirtual} {
            set body "error \"Error: attempt to invoke pure virtual ($name)\""
         }

         #
         # Save the arguments and body of the API and it's properties
         #

         set apiProperties($name) [getProperties]
         set apiArgs($name) $memberArgs
         set apiBody($name) $body
      }


      proc private {args} {
         #
         # Subsequent APIs and variables are private to the object
         #

         variable visibility

         set saveVisibility $visibility
         set visibility "private"
         if {[llength $args] == 1} {
            eval [lindex $args 0]
         } else {
            eval $args
         }
         set visibility $saveVisibility
      }


      proc protected {args} {
         #
         # Subsequent APIs and variables are protected to the object
         #

         variable visibility

         set saveVisibility $visibility
         set visibility "protected"
         if {[llength $args] == 1} {
            eval [lindex $args 0]
         } else {
            eval $args
         }
         set visibility $saveVisibility
      }


      proc public {args} {
         #
         # Subsequent APIs and variables are public to the object
         #

         variable visibility

         set saveVisibility $visibility
         set visibility "public"
         if {[llength $args] == 1} {
            eval [lindex $args 0]
         } else {
            eval $args
         }
         set visibility $saveVisibility
      }


      proc static {args} {
         #
         # Variables and APIs can be static (global to all instances of an
         # object)
         #

         variable isStatic

         set saveIsStatic $isStatic
         set isStatic 1
         if {[llength $args] == 1} {
            eval [lindex $args 0]
         } else {
            eval $args
         }
         set isStatic $saveIsStatic
      }


      proc var {name args} {
         #
         # Process a variable declaration.  Variables may be initialized with
         # content or simply declared:
         #      var x
         #      var y 0
         #

         variable isConst
         variable isStatic
         variable isVirtual
         variable objectReservedVars
         variable varProperties
         variable varValues

         #
         # Make sure that the variable declaration is not illegal and that
         # we are not redeclaring the variable
         #

         if {$isVirtual} {
            error "Error: variables cannot be virtual ($name)"
         }
         if {[lsearch [array names varProperties] $name] != -1} {
            error "Error: duplicate member variable ($name) found"
         }
         if {[lsearch $objectReservedVars $name] != -1} {
            error "Error: attempting to redefine reserved variable ($name)"
         }

         #
         # If we have an initial value for the variable, save it.  If we do
         # not, make sure that the variable was not declared "const" (what
         # is a const uninitialized variable?)
         #
         # NOTE: Pay attention to the way that static variables and non-static
         #       variables store their initializers.  The static variables
         #       need to get the first argument out of args.  However,
         #       because non-static variables do an evaluation of the
         #       value, we can just keep the arguments
         #

         if {[llength $args]} {
            if {$args eq "{}"} {
               if {$isStatic} {
                  set varValues($name) ""
               } else {
                  set varValues($name) "\"\""
               }
            } elseif {$isStatic} {
               set varValues($name) [lindex $args 0]
            } else {
               set varValues($name) $args
            }
         } else {
            if {$isConst} {
               error "Error: Uninitialized variable cannot be const ($name)"
            }
         }
         set varProperties($name) [getProperties]
      }


      proc virtual {args} {
         #
         # Record the fact that we have found a virtual keyword.
         #

         variable isVirtual

         set saveIsVirtual $isVirtual
         set isVirtual 1
         if {[llength $args] == 1} {
            eval [lindex $args 0]
         } else {
            eval $args
         }
         set isVirtual $saveIsVirtual
      }


      #-----------------------------------------------------------------------#
      # The following Tcl procs are used to record an object definition and   #
      # create the static data for the object (once an object is defined, its #
      # static variables and APIs should be available, even if no instance    #
      # of the object has been created yet.                                   #
      #                                                                       #
      # Objects are supported through the use of namespaces.  Each object has #
      # its own set of namespaces, with children namespaces used to           #
      # differentiate between public APIs exposed to the user, const APIs,    #
      # qualified API invocations (when you prepend the API with the object   #
      # name, for example when calling an inherited API), etc.  Furthermore,  #
      # each namespace has its own instance identifier, unique to that        #
      # instance, so that there could be no namespace overlap possible.  This #
      # also makes it easy to remove the entire namespace when an object is   #
      # deleted.  Instead of having to remember the different namespaces, the #
      # following symbolic constants will be used.  Then, when the object is  #
      # instantiated, the symbolic constants will be replaced with the actual #
      # names.  The following constants are used.  To explain the constants,  #
      # consider object "b" created in namespace "::a".  The unique namespace #
      # identifier is "inst###" where "###" corresponds to the unique value   #
      # returned by the API objectid.                                         #
      #   o @publicNS@ ---------> The namespace that contains APIs for all    #
      #                           non-const member APIs that are public.  The #
      #                           API implementations in this namespace just  #
      #                           call the APIs in @instNS@ (below) for the   #
      #                           most part                                   #
      #   o @staticNS@ ---------> The namespace where the APIs and variables  #
      #                           for static members are defined, both public #
      #                           and non-public.  We don't need a separate   #
      #                           constant for public static APIs and         #
      #                           variables because we know exactly what they #
      #                           are.  For our example, it would be ::a::b.  #
      #                           Like @publicNS@, the APIs in ::a::b just    #
      #                           invoke routines in @staticNS@               #
      #   o @instNS@ -----------> Where the actual implementation of all      #
      #                           defined (non-const) object member functions #
      #                           reside                                      #
      #   o @constNS@ ----------> Where the implementations are held for all  #
      #                           const APIs                                  #
      #   o @pubConstNS@ -------> The namespace where all public APIs reside. #
      #                           Their implementation just invokes the APIs  #
      #                           in @constNS@                                #
      #   o @qualifiedNS@ ------> The actual API code defined for the object  #
      #                           (b) can actually invoke another API by      #
      #                           prepending the object name.  For example,   #
      #                           API "c" might invoke API "d" using any of   #
      #                           the following methods:                      #
      #                                  d <args>                             #
      #                                  $this->d <args>                      #
      #                                  $this d <args>                       #
      #                                  b::d <args>                          #
      #                           All of these are valid.  The first three    #
      #                           can be defined within @instNS@/@constNS@.   #
      #                           The last one, however, requires another     #
      #                           child namespace under @instNS@ or           #
      #                           @constNS@ (depending on where API c is      #
      #                           defined).  The symbol @qualifiedNS@ is the  #
      #                           child namespace under @instNS@.             #
      #   o @qualifiedConstNS@ -> See @qualifiedNS@.  This is the child       #
      #                           namespace under @constNS@.                  #
      # The actual values associated with each are defined as:                #
      #   o @publicNS@ ---------> ::a::b::inst###::__public__                 #
      #   o @staticNS@ ---------> ::a::__private__                            #
      #   o @instNS@ -----------> ::a::b::inst###::__private__                #
      #   o @constNS@ ----------> ::a::b::inst###::__private__::__const__     #
      #   o @pubConstNS@ -------> ::a::b::inst###::__public__::__const__      #
      #   o @qualifiedNS@ ------> ::a::b::inst###::__private__::b             #
      #   o @qualifiedConstNS@ -> ::a::b::inst###::__private__::__const::b    #
      #                                                                       #
      # The object system has the concept of two different versions of "this" #
      # (aka the "this" pointer in C++).  The public version is returned by   #
      # a call to "new" and is used to access public APIs.  The internal      #
      # version of "this" isn't really needed unless the object API invokes   #
      # another object API using the syntax "$this->api <args>" or            #
      # "$this api <args>".  Since the actual API implementation is in        #
      # a namespace different than any of the public namespaces, the value of #
      # "this" in those APIs needs to be different from the value returned by #
      # the call to "new".                                                    #
      #   o @publicThis@ ---> ::a::b::inst###::__public__::obj                #
      #   o @this@ ---------> ::a::b::inst###::__private__::obj               #
      #   o @constThis@ ----> ::a::b::inst###::__private__::__const__::obj    #
      #   o @pubConstThis@ -> ::a::b::inst###::__public__::__const__::obj     #
      #                                                                       #
      # The object system maintains a set of arrays for private, public, and  #
      # protected APIs and variables.                                         #
      #   o @privProcs@ ----> ::a::b::inst###::__private__::_priv_procs       #
      #   o @protProcs@ ----> ::a::b::inst###::__private__::_prot_procs       #
      #   o @pubProcs@ -----> ::a::b::inst###::__private__::_pub_procs        #
      #   o @virtualProcs@ -> ::a::b::inst###::__private__::_virtual_procs    #
      #   o @constProcs@ ---> ::a::b::inst###::__private__::_const_procs      #
      #   o @privVars@ -----> ::a::b::inst###::__private__::_priv_vars        #
      #   o @protVars@ -----> ::a::b::inst###::__private__::_prot_vars        #
      #   o @pubVars@ ------> ::a::b::inst###::__private__::_pub_vars         #
      #   o @constVars@ ----> ::a::b::inst###::__private__::_const_vars       #
      #   o @super@ --------> ::a::b::inst###::__private__::_super            #
      #   o @publicSuper@ --> ::a::b::inst###::__public__::_super             #
      #   o @inheritSuper@ -> ::a::b::inst###::__private__::_inherit_super    #
      #   o @downcast@ -----> ::a::b::inst###::__private__::_downcast_obj     #
      #   o @friends@ ------> ::a::b::inst###::__private__::_friends          #
      #                                                                       #
      # When an object API is created, certain assignments take place so that #
      # the API can work with instance variables and invoke other object      #
      # APIs.  This is done through a call to a preamble block.  Const APIs   #
      # also have a postamble block.                                          #
      #   o @preamble@ ------> Sets the value of "this" and "pubThis" for     #
      #                        instance APIs.  Also makes instance variables  #
      #                        visible to the API.                            #
      #   o @constPreamble@ -> The const API invoked to establish traces on   #
      #                        variables to keep their content up to date (if #
      #                        they are changed in a non-const space) and to  #
      #                        invoke an error if they are written to in the  #
      #                        const space                                    #
      #   o @constPostamble@ > Removes the traces established by the          #
      #                        @constPreamble@                                #
      #   o @refCount@ ------> Used to count the depth of const routine calls #
      #                                                                       #
      # Finally, we use some additional misc. symbolic constants:             #
      #   o @num@ ----------> The numeric value associated with the objectid  #
      #                       API and used to create the unique namespace     #
      #                       (i.e. "inst###")                                #
      #-----------------------------------------------------------------------#


      proc createBuiltInCommands {objectName objectNS} {
         #
         # This routine creates the built-ins that will automatically be
         # generated for any object instance
         #

         set commands ""

         #
         # Create commands that are common to the const space and to the
         # non-const space.
         #
         # (1) objectid -- provides a system-wide unique numeric ID for this
         #     object instance
         #

         set body "return @num@"
         append commands "proc @instNS@::objectid {} { $body }\n"
         append commands "proc @constNS@::objectid {} { $body }\n"
         append commands "proc @qualifiedNS@::objectid {} { $body }\n"
         append commands "proc @qualifiedConstNS@::objectid {} { $body }\n"

         append commands "proc @publicThis@->objectid {} { $body }\n"
         append commands "proc @this@->objectid {} { $body }\n"
         append commands "proc @constThis@->objectid {} { $body }\n"
         append commands "proc @pubConstThis@->objectid {} { $body }\n"

         #
         # (2) typeid -- returns the object class name
         #

         set body "return $objectName"
         append commands "proc @instNS@::typeid {} { $body }\n"
         append commands "proc @constNS@::typeid {} { $body }\n"
         append commands "proc @qualifiedNS@::typeid {} { $body }\n"
         append commands "proc @qualifiedConstNS@::typeid {} { $body }\n"

         append commands "proc @publicThis@->typeid {} { $body }\n"
         append commands "proc @this@->typeid {} { $body }\n"
         append commands "proc @constThis@->typeid {} { $body }\n"
         append commands "proc @pubConstThis@->typeid {} { $body }\n"


         #
         # (3) objectSpace -- return the namespace that the object was
         #     declared within
         #

         set body "return $objectNS"
         append commands "proc @instNS@::objectSpace {} { $body }\n"
         append commands "proc @constNS@::objectSpace {} { $body }\n"
         append commands "proc @qualifiedNS@::objectSpace {} { $body }\n"
         append commands "proc @qualifiedConstNS@::objectSpace {} { $body }\n"

         append commands "proc @publicThis@->objectSpace {} { $body }\n"
         append commands "proc @this@->objectSpace {} { $body }\n"
         append commands "proc @constThis@->objectSpace {} { $body }\n"
         append commands "proc @pubConstThis@->objectSpace {} { $body }\n"

         #
         # Create built-ins that are different for each namespace or unique
         # to a specific namespace
         #
         # (4) obj -- convert from the "$obj api args" syntax to call the
         #     API for this object
         #

         set body "eval \"obj->\$api \$args\""
         append commands "proc @publicThis@ {api args} { $body }\n"
         append commands "proc @pubConstThis@ {api args} { $body }\n"

         set body "eval \"\$api \$args\""
         append commands "proc @this@ {api args} { $body }\n"
         append commands "proc @constThis@ {api args} { $body }\n"

         #
         # (5) new -- create a new object.  This only needs to be in the
         #     namespaces where it can actually be called
         #

         set body "return \[::object::new \$obj $objectNS \$args\]"
         append commands "proc @instNS@::new {obj args} { $body }\n"
         append commands "proc @constNS@::new {obj args} { $body }\n"

         #
         # (6) inherit -- provide a mechanism for the object to inherit from
         #     another object.  This can only be called from the constructor,
         #     so it only needs to be in one location.  Note that we don't
         #     treat this as an API (so you can't use the "$obj->inherit"
         #     syntax
         #
         #     The subclass should use a command of the following form for
         #     inheritance:
         #         inherit <super-class> <args>
         #     where <super-class> is the name of the class we inherit from and
         #     <args> specifies the argument list for the constructor.  The
         #     actual job of inheritance occurs within ::object::inherit
         #     to create inherited variables and inherited member aliases
         #

         set body    "\n"
         append body "   set s \[lindex \$args 0\]\n"
         append body "   set i \[lsearch \"public protected private\" \$s\]\n"
         append body "   if {\$i != -1} {\n"
         append body "      set scope \$s\n"
         append body "      set type \[lindex \$args 1\]\n"
         append body "      set args \[lreplace \$args 0 1\]\n"
         append body "   } else {\n"
         append body "      set scope \"public\"\n"
         append body "      set type \$s\n"
         append body "      set args \[lreplace \$args 0 0\]\n"
         append body "   }\n"
         append body "   ::object::inherit @this@ \$scope \$type \$args\n"
         append commands "proc @instNS@::inherit {args} { $body }\n"

         #
         # (7) getProcPath -- return the path to the member API.  Note that
         #     there are differences between the public version and the private
         #     version in that the public version only returns public API
         #     paths
         #

         set body    "set p \"\"\n"
         append body "catch {set p \$@pubProcs@(\$name)}\n"
         append body "catch {set p \$@protProcs@(\$name)}\n"
         append body "catch {set p \$@privProcs@(\$name)}\n"
	 append body "set ::errorInfo \"\"\n"
         append body "return \$p\n"
         append commands "proc @instNS@::getProcPath {name} { $body }\n"

         set body "return \[@instNS@::getProcPath \$name\]"
         append commands "proc @constNS@::getProcPath {name} { $body }\n"

         set body    "set p \"\"\n"
         append body "catch {set p \$@pubProcs@(\$name)}\n"
	 append body "set ::errorInfo \"\"\n"
         append body "return \$p\n"
         append commands "proc @publicThis@->getProcPath {name} { $body }\n"

         set body "return \[@publicNS@::getProcPath \$name\]"
         append commands "proc @pubConstThis@->getProcPath {name} { $body }\n"

         set body "return \[getProcPath \$name\]"
         append commands "proc @this@->getProcPath {name} { $body }\n"
         append commands "proc @constThis@->getProcPath {name} { $body }\n"

         set body "return \[@instNS@::getProcPath \$name\]"
         append commands \
            "proc @qualifiedConstNS@::getProcPath {name} { $body }\n"

         #
         # (8) getVarPath -- return the path to the passed variable (similar
         #     to getProcPath -- above)
         #

         set body    "set p \"\"\n"
         append body "catch {set p \$@pubVars@(\$name)}\n"
         append body "catch {set p \$@protVars@(\$name)}\n"
         append body "catch {set p \$@privVars@(\$name)}\n"
	 append body "set ::errorInfo \"\"\n"
         append body "return \$p\n"
         append commands "proc @instNS@::getVarPath {name} { $body }\n"

         set body    "set p \"\"\n"
         append body "catch {set p \$@pubVars@(\$name)}\n"
	 append body "set ::errorInfo \"\"\n"
         append body "return \$p\n"
         append commands "proc @publicThis@->getVarPath {name} { $body }\n"

         set body "return \[getVarPath \$name\]"
         append commands "proc @this@->getVarPath {name} { $body }\n"

         #
         # (9) const -- return a const version of "this" that can only
         #     access const routines
         #

         append commands "proc @instNS@::const {} { return @constThis@ }\n"
         append commands \
            "proc @publicNS@::const {} { return @pubConstThis@ }\n"
         append commands "proc @this@->const {} { return @constThis@ }\n"
         append commands \
            "proc @publicThis@->const {} { return @pubConstThis@ }\n"

         #
         # (10) constCast -- Given a const version of "this", return a
         #      non-const version of "this"
         #

         append commands "proc @constThis@->constCast {} { return @this@ }\n"
         append commands "proc @constNS@::constCast {} { return @this@ }\n"
         append commands \
            "proc @qualifiedConstNS@::constCast {} { return @this@ }\n"
         append commands \
            "proc @pubConstThis@->constCast {} { return @publicThis@ }\n"

         #
         # (11) isConst -- returns 1 if the "this" value is const, 0 otherwise
         #

         append commands "proc @this@->isConst {} { return 0 }\n"
         append commands "proc @constThis@->isConst {} { return 1 }\n"
         append commands "proc @publicThis@->isConst {} { return 0 }\n"
         append commands "proc @pubConstThis@->isConst {} { return 1 }\n"

         append commands "proc @instNS@::isConst {} { return 0 }\n"
         append commands "proc @constNS@::isConst {} { return 1 }\n"
         append commands "proc @qualifiedConstNS@::isConst {} { return 1 }\n"

         #
         # (12) Internal Use Only routines
         #

         append commands \
            "proc @this@->__getPrivateSpace__ {} { return @instNS@ }\n"
         append commands \
            "proc @this@->__getPublicSpace__ {} { return @publicNS@ }\n"
         append commands \
            "proc @this@->__getPrivateThis__ {} { return @this@ }\n"
         append commands \
            "proc @this@->__getPublicThis__ {} { return @publicThis@ }\n"
         append commands \
            "proc @publicThis@->__getPrivateSpace__ {} { return @instNS@ }\n"
         append commands \
            "proc @publicThis@->__getPublicSpace__ {} { return @publicNS@ }\n"
         append commands \
            "proc @publicThis@->__getPrivateThis__ {} { return @this@ }\n"
         append commands \
            "proc @publicThis@->__getPublicThis__ {} { return @publicThis@ }\n"

         #
         # (13) peekObj -- returns the private "this" value for the passed
         #      object, as long as this object and the passed object are of
         #      the same type
         #

         set body    "set privSpace \[\$obj->__getPrivateSpace__\]\n"
         append body "set objFriends \"\${privSpace}::_friends\"\n"
         append body "set objFriends \[subst \"\\\$\$objFriends\"\]\n"
         append body "if {\[lsearch \$objFriends $objectName\] != -1} {\n"
         append body "   return \[\$obj->__getPrivateThis__\]\n"
         append body "} else {\n"
         append body "   return \"\"\n"
         append body "}\n"
         append commands "proc @this@->peekObj {obj} { $body }\n"
         append commands "proc @constThis@->peekObj {obj} { $body }\n"
         append commands "proc @instNS@::peekObj {obj} { $body }\n"
         append commands "proc @constNS@::peekObj {obj} { $body }\n"
         append commands "proc @qualifiedNS@::peekObj {obj} { $body }\n"
         append commands "proc @qualifiedConstNS@::peekObj {obj} { $body }\n"

         #
         # (14) friend -- adds the class name(s) to the list of friends classes
         #      that can access protected and private APIs and data members
         #      (through peekObj -- above).  By default, the friends list
         #      includes this class
         #

         set body "set @friends@ \[concat \$@friends@ \$args\]\n"
         append body "set @friends@ \[lsort -unique \$@friends@\]\n"
         append commands "proc @instNS@::friend {args} { $body }\n"

         #
         # Done!
         #

         return $commands
      }


      proc createConstCommands {} {
         #
         # This routine is responsible for creating all routines within a
         # const namespace of an instance.  Variables declared as const are
         # handled by a different routine.
         #
         # Restrictions include the fact that const routines can only
         # call other const routines (without performing a cast to a non-const
         # type).
         #
         # The return value from this routine is a set of commands that can
         # be appended to the set of other commands required to create
         # an instance.  This routine, however, deals *only* with const
         # routines.
         #
         # NOTE: Originally I skipped this code if there wasn't an API that
         #       was const.  The problem is, you can have variables that are
         #       const and that are used by an inheriting object.  In that
         #       case, we need to do this code so that we can note the const
         #       variables in @constVars@.
         #

         variable apiArgs
         variable apiBody
         variable apiProperties

         #
         # Iterate through each routine to create the body of the const
         # API, calling the constPreamble and constPostamble as applicable.
         #

         set commands ""
         foreach api [array names apiProperties] {
            #
            # Skip non-const APIs
            #

            set properties $apiProperties($api)
            if {[lsearch $properties "const"] == -1} {
               continue
            }
            append commands "lappend @constProcs@ $api\n"

            #
            # Create const procs that invoke the constPreamble and
            # constPostamble (if they exist) and invoke the body within
            # a catch statement.  We want to use a catch statement so that
            # any returns are caught and we can execute the constPostamble.
            #

            set body    "@constPreamble@\n"
            append body "set rc \[catch { $apiBody($api) } msg\]\n"
            append body "if {\$rc == 1} {\n"
            append body "   set savedInfo \$::errorInfo\n"
            append body "   @constPostamble@\n"
            append body "   error \$msg \$savedInfo\n"
            append body "} elseif {\$rc == 2} {\n"
            append body "   set rc \$msg\n"
            append body "}\n"
            append body "@constPostamble@\n"
            append body "return \$rc\n"

            #
            # Virtual APIs are named differently and have call throughs to them
            #

            set args $apiArgs($api)
            set argList [createArgList $args]
            if {[lsearch $properties "virtual"] != -1} {
               set target "@constNS@::virtual->$api"
               append commands \
                  "proc @constNS@::$api {$args} { $target $argList }\n"
               append commands \
                  "proc @constThis@->$api {$args} { $target $argList }\n"
            } else {
               set target "@constNS@::$api"
               append commands \
                  "proc @constThis@->$api {$args} { $api $argList }\n"
            }
            append commands "proc $target {$args} { $body }\n"

            #
            # Create call-throughs in the __private__ space.  The public
            # space has already been taken care of
            #

            set body "$target $argList"
            append commands "proc @instNS@::$api {$args} { $body }\n"
            append commands "proc @this@->$api {$args} { $body }\n"
            append commands "proc @qualifiedNS@::$api {$args} { $body }\n"
            append commands "proc @qualifiedConstNS@::$api {$args} { $body }\n"
         }

         return $commands
      }


      proc createObjectCommands {objectName callerSpace members} {
         #
         # The Tcl interpreter has found a call to the object proc (defined
         # above) and we need to record the structure of the object: APIs,
         # variables, and access qualifiers.  When a new instance of the
         # object is created, we will evaluate commands that we record
         # at this point, creating the appropriate Tcl procs in order to
         # create in instance.
         #

         variable apiArgs
         variable apiBody
         variable apiProperties
         variable definingName
         variable isConst
         variable isStatic
         variable isVirtual
         variable objectBuildCommands
         variable varProperties
         variable varValues
         variable visibility

         #
         # First perform some error checking to make sure that the object
         # hasn't already been defined
         #

         set objList [qualifyObject $objectName $callerSpace]
         set objectName [lindex $objList 0]
         set objectNS [lindex $objList 1]
         set objectIndex "${objectNS},${objectName}"
         if {[info exists buildCommands($objectIndex)]} {
            set obj "${objectNS}:${objectName}"
            error "Error: Object ($obj) cannot be redefined"
         }

         #
         # Initialize the system and create a set of commands that, when
         # executed, will reset all variables in this namespace (cleanup
         # commands).
         #

         set cleanupCmds "array unset apiArgs\n"
         append cleanupCmds "array unset apiBody\n"
         append cleanupCmds "array unset apiProperties\n"
         append cleanupCmds "array unset varProperties\n"
         append cleanupCmds "array unset varValues\n"
         append cleanupCmds "unset -nocomplain definingName\n"
         append cleanupCmds "unset -nocomplain isConst\n"
         append cleanupCmds "unset -nocomplain isStatic\n"
         append cleanupCmds "unset -nocomplain isVirtual\n"
         append cleanupCmds "unset -nocomplain visibility\n"

         eval $cleanupCmds
         set isConst 0
         set isStatic 0
         set isVirtual 0
         set visibility "public"
         set definingName $objectName

         #
         # Evaluate the members in order to record information about the
         # APIs and variables.  Wrap the evaluation in a catch statement so
         # that the program doesn't abort without a good error message
         #
         # NOTE: The "##nagelfar ignore" comment proceeds the catch command
         #       because I want to execute the content of the variable
         #       "members".  Putting braces around it, which is what the
         #       linter wants, totally changes the context and will cause T++
         #       to fail
         #

         ##nagelfar ignore
         set code [catch $members result]
         if {$code == 1} {
            set saveInfo $::errorInfo
            eval $cleanupCmds
            error $result $saveInfo
         }

         #
         # Make sure that a constructor exists.  If not, error out
         #

         if {[lsearch [array names apiProperties] $objectName] == -1} {
            eval $cleanupCmds
            error "Error: no constructor found for object $objectName"
         }
         set properties $apiProperties($objectName)
         if {[lsearch $properties "public"] == -1} {
            eval $cleanupCmds
            error "Error: no public constructor found for $objectName"
         }
         if {([lsearch $properties "const"] != -1) ||
             ([lsearch $properties "static"] != -1)} {
            eval $cleanupCmds
            error "Error: constructor for $objectName cannot be cv-qualified"
         }

         #
         # Validate the destructor, if one exists.  Otherwise create one that
         # does nothing (simplifies life later)
         #

         set destructor "~$objectName"
         if {[lsearch [array names apiProperties] $destructor] != -1} {
            set properties $apiProperties($destructor)
            if {[lsearch $properties "public"] == -1} {
               eval $cleanupCmds
               error "Error: destructor for $objectName is not public"
            }
            if {([lsearch $properties "const"] != -1) ||
                ([lsearch $properties "static"] != -1)} {
               eval $cleanupCmds
               error "Error: destructor for $objectName cannot be cv-qualified"
            }
            if {[llength $apiArgs($destructor)]} {
               eval $cleanupCmds
               error "Error: destructors do not take arguments ($objectName)"
            }
         } else {
            set apiProperties($destructor) "public"
            set apiBody($destructor) ""
            set apiArgs($destructor) ""
         }

         #
         # If we made it to this point, we can create and save the commands to
         # create instance APIs, built-ins, and variables
         #

         set instCommands [createVariableCommands $objectName]
         append instCommands [createBuiltInCommands $objectName $objectNS]
         append instCommands [createPrivateAPICommands $objectName $objectNS]
         append instCommands [createPublicAPICommands $objectName $objectNS]
         append instCommands [createConstCommands]
         append instCommands [createVirtualCommands]
         set objectBuildCommands($objectIndex) $instCommands

         #
         # We can also create the static object APIs and variables (before
         # any instance is created)
         #

         createStaticData $objectNS $objectName
         eval $cleanupCmds
      }


      proc createPrivateAPICommands {objectName objectNS} {
         #
         # This routine creates the APIs within the private namespace and
         # const namespace where the API bodies are actually defined and code
         # is executed.
         #

         variable apiArgs
         variable apiProperties
         variable apiBody

         #
         # Initialize the arrays that hold information about the procs
         #

         set instCommands "array set @privProcs@ \[list\]\n"
         append instCommands "array set @protProcs@ \[list\]\n"
         append instCommands "array set @pubProcs@ \[list\]\n"
         append instCommands "array set @virtualProcs@ \[list\]\n"
         append instCommands "set @constProcs@ \[list\]\n"

         #
         # Process each non-const instance API
         #

         foreach api [array names apiArgs] {
            #
            # Constructors and destructors are special-case APIs that are
            # not recorded.  They're just created with the appropriate
            # headers in place
            #
            # NOTE: Constructors and destructors are only in the __private__
            #       space.  The new and delete procs are responsible for
            #       navigating to the right namespace and calling the correct
            #       routine
            #

            set args $apiArgs($api)
            if {($api eq $objectName) || ($api eq "~$objectName")} {
               set body "@preamble@\n"
               append body $apiBody($api)
               append instCommands "proc @this@->$api {$args} { $body }\n"
               continue
            }

            #
            # Record the API locations for the different types of APIs
            #

            set properties $apiProperties($api)
            if {[lsearch $properties "public"] != -1} {
               append instCommands "set @pubProcs@($api) @instNS@::$api\n"
            } elseif {[lsearch $properties "protected"] != -1} {
               append instCommands "set @protProcs@($api) @instNS@::$api\n"
            } else {
               append instCommands "set @privProcs@($api) @instNS@::$api\n"
            }
            if {[lsearch $properties "virtual"] != -1} {
               append instCommands \
                  "set @virtualProcs@($api) @instNS@::virtual->$api\n"
            }

            #
            # Don't do const APIs.  Those are handled separately
            #

            if {[lsearch $properties "const"] != -1} {
               continue
            }

            #
            # Static APIs get a call-through
            #

            set argList [createArgList $args]
            if {[lsearch $properties "static"] != -1} {
               set body "@staticNS@::$api $argList"
               append instCommands "proc @this@->$api {$args} { $body }\n"
               append instCommands "proc @instNS@::$api {$args} { $body }\n"
               append instCommands \
                  "proc @qualifiedNS@::$api {$args} { $body }\n"
               continue
            }

            #
            # All non-const APIs are put into the __private__ space.
            #
            # The body of a non-const API consists of the assignment of the
            # "this" and "pubThis" value as well as importing any instance
            # and static variables into the API
            #

            set body "@preamble@\n"
            append body $apiBody($api)

            #
            # Non-const API.  Create in the __private__ space and a
            # call-through in the qualified namespace
            #
            # NOTE: We are going to embed the actual code within the form
            #       of the API that just uses the name of the API.  That's
            #       because that will be the most common way that the API
            #       is invoked by other routines within this same namespace.
            #       Other methods will map to this one
            #

            append instCommands "proc @instNS@::$api {$args} { $body }\n"
            append instCommands "proc @this@->$api {$args} { $api $argList }\n"
            append instCommands \
               "proc @qualifiedNS@::$api {$args} { @instNS@::$api $argList }\n"
         }

         return $instCommands
      }


      proc createPublicAPICommands {objectName objectNS} {
         #
         # This routine only creates the APIs that are going to be visible
         # as public APIs.  For the most part, it will simply defer calls to
         # the underlying private APIs.  We are going to use the following
         # set of rules:
         #    o We are going to create APIs of the form "$obj->api args" that
         #      invoke the API within the private space.  When calling public
         #      APIs from outside of the object, this will be the most common
         #      form.  When calling public APIs from within other APIs, we'll
         #      already be in the private space.  We need a similar one for
         #      const APIs that are public.
         #    o We are going to create an API of the form "$obj api args" that
         #      will result in a call through to "$obj->api args".  We want
         #      this level of indirection because we are not going to check
         #      the validity of the API prior to calling the call through
         #      API.  We don't want the user to actually use this syntax to
         #      invoke a private or protected API.
         #    o We never need to create an API of the form "api args" in
         #      the public space since there is no way for it to ever be
         #      invoked.
         #    o Some APIs (like getVarPath and getProcPath) behave differently
         #      in the public space than in the private space.  Those will
         #      have actual code associated with them.  For example, from the
         #      public space, you don't want to be able to get the variable
         #      path to a private variable.
         #

         variable apiArgs
         variable apiBody
         variable apiProperties

         #
         # Create all of the public APIs of the form "$obj->api args", skipping
         # the constructor and destructor (those are handled separately)
         #

         set commands ""
         foreach api [array names apiProperties] {
            set properties $apiProperties($api)
            if {[lsearch $properties "public"] == -1} {
               continue
            }

            #
            # Skip over the constructor and destructor.  They are handled in
            # a special fashion within the private namesapce
            #

            if {($api eq $objectName) || ($api eq "~$objectName")} {
               continue
            }

            #
            # Create all other public APIs.  If it's a static API, we make
            # the call through to the static API space.  Otherwise we
            # go to the instance space (const or non-const)
            #

            set args $apiArgs($api)
            set argList [createArgList $args]
            if {[lsearch $properties "static"] == -1} {
               if {[lsearch $properties "const"] == -1} {
                  set body "@instNS@::$api $argList"
               } else {
                  set body "@constNS@::$api $argList"
                  append commands \
                     "proc @pubConstThis@->$api {$args} { $body }\n"
               }
            } else {
               set body "@staticNS@::$api $argList"
            }
            append commands "proc @publicThis@->$api {$args} { $body }\n"
         }

         return $commands
      }


      proc createStaticData {objectNS objectName} {
         #
         # This routine is responsible for creating the static variables and
         # APIs for a defined object.  Once defined, an object's static data
         # and APIs should be available for use, even if an instance has
         # not yet been created.
         #
         # Objects can reside within name spaces, but, for the purpose of
         # illustration, consider an object, "a", created at the global space.
         # Public static variables of "a" should be accessible using standard
         # Tcl variable access methods:
         #      set x $::a::someStaticVar
         # However, variables that are protected or private should not be
         # accessible.  Similarly, protected or private methods should be
         # able to call public methods and visa versa.  So, this implementation
         # create a namespace using the name of the object.  All actual APIs
         # and variables are accessed through a child namespace called
         # __private__.  Public static APIs are placed into the root namespace
         # and are simply invocations of the same API within the __private__
         # namespace.  Similarly, public variables are exposed in the
         # root namespace using the upvar (basically creating a variable alias
         # to the actual variable residing within __private__).
         #
         # Static APIs may call other APIs within the same object by using
         # the standard API syntax or a qualified syntax.  So, for object a,
         # we could use
         #     apiName $arg1 $arg2
         # or
         #     a::apiName $arg1 $arg2
         # You can do it in C++, and you should be able to do it here.  To
         # enable this syntax, another child namespace under __private__ is
         # created, using the object name, that contains all of the static
         # APIs, simply calling back into the __private__ space.  Thus, we
         # might see something like this, if we dump out the code in all of
         # the namespaces:
         #         namespace eval ::a:: {
         #            upvar ::a::__private__::var1 var1
         #            proc api1 {} {
         #               ::a::__private__::api1
         #            }
         #            namespace eval __private__:: {
         #               variable var1 10
         #               variable var2 20
         #               proc api1 {} {
         #                  a::api2
         #                  ...
         #               }
         #               proc api2 {} {
         #                  ...
         #               }
         #               namespace a:: {
         #                  upvar ::a::__private__::var1 var1
         #                  proc api1 {} {
         #                     ::a::__private__::api1
         #                  }
         #                  proc api2 {} {
         #                     ::a::__private__::api2
         #                  }
         #               }
         #            }
         #         }
         # In this case, api1 and var1 are both public.  The member API api2
         # and member variable var2 are either private or protected, depending
         # on how the method and variable are declared.
         #

         variable apiArgs
         variable apiBody
         variable apiProperties
         variable varProperties
         variable varValues

         #
         # Create the static namespace that all routines and variables will
         # go into (a private namespace).  Public static APIs will go into
         # the public static space and invoke routines into the private
         # space
         #

         set publicNS "${objectNS}${objectName}"
         set staticNS "${publicNS}::__private__"
         set qualifiedNS "${staticNS}::${objectName}"
         eval "namespace eval $qualifiedNS {}"

         #
         # We are going to maintain variables in the __private__ space to tell
         # us which static variables are const, what the access rights are
         # for variables, and what the access rights are for APIs
         #

         set privVars ${staticNS}::_priv_vars
         set protVars ${staticNS}::_prot_vars
         set pubVars ${staticNS}::_pub_vars
         set privProcs ${staticNS}::_priv_procs
         set protProcs ${staticNS}::_prot_procs
         set pubProcs ${staticNS}::_pub_procs

         array set $privVars [list]
         array set $protVars [list]
         array set $pubVars [list]
         array set $privProcs [list]
         array set $protProcs [list]
         array set $pubProcs [list]

         #
         # Iterate across each variable.  Create the variable in the proper
         # namespace, store the variable path into the internal arrays we
         # are maintaining, and create traces as necessary for read-only
         # variables
         #

         set traceFormat \
            "trace add variable %s write ::object::readOnlyError\n"
         set allStaticVars [list]
         foreach var [array names varProperties] {
            #
            # Work only with static variables
            #

            set properties $varProperties($var)
            if {[lsearch $properties "static"] == -1} {
               continue
            }
            lappend allStaticVars $var

            #
            # Create the variable within the static space.  Initialize it if
            # a value was passed in with it
            #

            set varPath ${staticNS}::$var
            if {[info exists varValues($var)]} {
               set $varPath $varValues($var)
            } else {
               variable $varPath
            }
            eval "upvar $varPath ${qualifiedNS}::$var"

            #
            # Append the variable name to the list of variables that we
            # maintain for the class (for inheritance purposes).  Also, if
            # the variable is public, we need to use the "upvar" command
            # to alias the variable to the public space that the user
            # can get to without qualification
            #

            if {[lsearch $properties "private"] != -1} {
               set ${privVars}($var) $varPath
            } elseif {[lsearch $properties "protected"] != -1} {
               set ${protVars}($var) $varPath
            } else {
               set ${pubVars}($var) $varPath
               eval "upvar $varPath ${publicNS}::$var"
            }

            #
            # If the variable is a const, put a trace on it so that it cannot
            # be written to (error out in this case)
            #

            if {[lsearch $properties "const"] != -1} {
               eval [format $traceFormat $varPath]
            }
         }

         #
         # Now create static APIs that are defined within the object.  This is
         # similar to, but not identical to, the way in which variables are
         # handled.
         #

         foreach api [array names apiArgs] {
            set properties $apiProperties($api)
            if {[lsearch $properties "static"] == -1} {
               continue
            }

            #
            # By default, all APIs are created in the __private__ space.  If
            # its a public API, we need to call through from the public
            # space to the private space.  Finally, we also want to create
            # a call through for a namespace under __private__ (with the
            # object name) in case a static routine explicitly invokes
            # a call using the "object::api" syntax instead of just "api"
            #

            set args $apiArgs($api)
            set body "{ ${staticNS}::${api} [createArgList $args] }"
            eval "proc ${qualifiedNS}::${api} {$args} $body"
            if {[lsearch $properties "public"] != -1} {
               eval "proc ${publicNS}::${api} {$args} $body"
            }

            #
            # Add the static API to the list of private, protected, and
            # public procs
            #

            set apiPath ${staticNS}::${api}
            if {[lsearch $properties "private"] != -1} {
               set ${privProcs}($api) $apiPath
            } elseif {[lsearch $properties "protected"] != -1} {
               set ${protProcs}($api) $apiPath
            } else {
               set ${pubProcs}($api) $apiPath
            }

            #
            # We need to instantiate the real static API into the __private__
            # namespace (in this case, "real" means the code for the API as
            # defined by the object -- not a pass through -- plus code to
            # manage variables).
            #
            # In a const API, all variables are copied into local variables,
            # and traces are placed on the copy.  In non-const APIs, only
            # const variables are copied/traced while all other static
            # variables are accessed directly (using an upvar aliasing
            # method)
            #
            # Create copies of const variables and trace them.  Non-const
            # variables are aliased to local names in one big upvar
            # command
            #

            set body ""
            set upvarList ""
            foreach var $allStaticVars {
               set varPath ${staticNS}::$var
               append upvarList " $varPath $var"
            }
            if {$upvarList ne ""} {
               append body "upvar${upvarList}\n"
            }
            append body $apiBody($api)
            eval "proc $apiPath {$apiArgs($api)} { $body }"
         }

         #
         # Create built-in static APIs.  The following built-ins are
         # handled (no need to do them in public space since all static
         # routines are actually executed in __public__, and all external
         # callers wouldn't need them):
         #    o typeid -> Return the object name
         #    o getProcPath -> Return the fully-qualified path of the
         #      passed member API (proc)
         #    o getVarPath -> Return the fully-qualified path of the variable
         #      passed in
         #    o objectSpace -> Return the namespace that the object is
         #      defined in
         #    o new -> Make sure that it invokes the system "new" and not
         #      the internal "new" built-in.  Use the namespace of the
         #      object, not the internal namespace from which the call to
         #      new might be made
         #

         eval "proc ${staticNS}::typeid {} { return $objectName }"
         eval "proc ${staticNS}::objectSpace {} { return $objectNS }"

         set body "return \[::object::new \$obj $objectNS \$args\]"
         eval "proc ${staticNS}::new {obj args} { $body }"

         set body "\n"
         set body "set p \"\"\n"
         append body "catch {set p \$${staticNS}::_pub_procs(\$apiName)}\n"
         append body "catch {set p \$${staticNS}::_prot_procs(\$apiName)}\n"
         append body "catch {set p \$${staticNS}::_priv_procs(\$apiName)}\n"
	 append body "set ::errorInfo \"\"\n"
         append body "return \$p\n"
         eval "proc ${staticNS}::getProcPath {apiName} {$body}"

         set body "\n"
         set body "set v \"\"\n"
         append body "catch {set v \$${staticNS}::_pub_vars(\$varName)}\n"
         append body "catch {set v \$${staticNS}::_prot_vars(\$varName)}\n"
         append body "catch {set v \$${staticNS}::_priv_vars(\$varName)}\n"
	 append body "set ::errorInfo \"\"\n"
         append body "return \$v\n"
         eval "proc ${staticNS}::getVarPath {varName} {$body}"
      }


      proc createVariableCommands {objectName} {
         #
         # Create the commands that will create instance variables.
         #

         variable varProperties
         variable varValues

         #
         # Start by creating the commands to create all of the namespaces,
         # even those for procs.  Variable creation is done once, prior to
         # doing any APIs, so placing the namespace commands here ensures that
         # the namespaces will exist when we instantiate variables and APIs
         # moving forward.
         #

         set varCommands ""
         set spaces [list "@instNS@" "@constNS@" "@pubConstNS@" \
                        "@publicNS@" "@qualifiedNS@" "@qualifiedConstNS@"]
         foreach ns $spaces {
            append varCommands "namespace eval $ns {}\n"
         }

         #
         # We maintain variables with information about different APIs and
         # variables in the object.  Create the commands to create and
         # initialize those variables
         #

         append varCommands "array set @privVars@ \[list\]\n"
         append varCommands "array set @protVars@ \[list\]\n"
         append varCommands "array set @pubVars@ \[list\]\n"
         append varCommands "array set @inheritSuper@ \[list\]\n"
         append varCommands "set @friends@ $objectName\n"
         append varCommands "set @constVars@ {}\n"
         append varCommands "set @refCount@ 0\n"

         #
         # Process each variable for the instance
         #

         foreach var [array names varProperties] {
            #
            # Static variables need to be aliased into the qualified namespace,
            # instance namespace, and const namespace
            #

            set properties $varProperties($var)
            if {[lsearch $properties "static"] != -1} {
               #
               # Alias the variables and/or copy into the const namespace as
               # required
               #

               set varPath "@staticNS@::$var"
               append varCommands "upvar $varPath @qualifiedNS@::$var\n"
               append varCommands "upvar $varPath @instNS@::$var\n"

               if {[lsearch $properties "const"] != -1} {
                  append varCommands "upvar $varPath @constNS@::$var\n"
                  append varCommands "lappend @constVars@ $var\n"
               } else {
                  append varCommands "variable @constNS@::$var\n"
               }
               append varCommands \
                  "upvar @constNS@::$var @qualifiedConstNS@::$var\n"

               #
               # Save statics in the instance list of private, public,
               # or protected variables
               #

               if {[lsearch $properties "private"] != -1} {
                  append varCommands "set @privVars@($var) $varPath\n"
               } elseif {[lsearch $properties "protected"] != -1} {
                  append varCommands "set @protVars@($var) $varPath\n"
               } else {
                  append varCommands "set @pubVars@($var) $varPath\n"
               }
               continue
            }

            #
            # Create the command to create the variable and initialize it,
            # if applicable
            #

            set varPath "@instNS@::$var"
            if {[info exists varValues($var)]} {
               append varCommands "variable $varPath $varValues($var)\n"
            } else {
               append varCommands "variable $varPath\n"
            }
            append varCommands "upvar $varPath @qualifiedNS@::$var\n"

            #
            # Add the name of the variable to the appropriate variable list
            # (public, protected, private, and const).  If it is a const
            # variable, put a readOnlyError trace on it
            #

            if {[lsearch $properties "private"] != -1} {
               append varCommands "set @privVars@($var) $varPath\n"
            } elseif {[lsearch $properties "protected"] != -1} {
               append varCommands "set @protVars@($var) $varPath\n"
            } else {
               append varCommands "set @pubVars@($var) $varPath\n"
            }

            if {[lsearch $properties "const"] != -1} {
               append varCommands \
                  "trace add variable $varPath write ::object::readOnlyError\n"
               append varCommands "upvar $varPath @constNS@::$var\n"
               append varCommands "lappend @constVars@ $var\n"
            } else {
               append varCommands "variable @constNS@::$var\n"
            }
            append varCommands \
               "upvar @constNS@::$var @qualifiedConstNS@::$var\n"
         }
         return $varCommands
      }


      proc createVirtualCommands {} {
         #
         # This routine is responsible for creating all routines associated
         # with virtual APIs (at least, routines that are declared as virtual
         # within an object -- APIs deemed to be virtual after inheritance are
         # covered elsewhere).
         #
         # Unlike normal APIs, where the name of the API is given by some
         # namespace qualifier followed by "obj", virtual APIs use the
         # qualifier "virtual".  Call through routines are then created for
         # everything that must reference a virtual API.
         #
         # The return value from this routine is a set of commands that can
         # be appended to the set of other commands required to create
         # an instance.  This routine, however, deals *only* with virtual
         # routines.
         #
         # NOTE: Const routines have additional requirements beyond the scope
         #       of this routine.  Thus, routines that are both const and
         #       virtual are handled within the const command creation code.
         #

         variable apiArgs
         variable apiBody
         variable apiProperties

         #
         # Iterate through the APIs again, this creating the commands
         # to create the virtual bodies
         #

         set commands ""
         foreach api [array names apiProperties] {
            set properties $apiProperties($api)
            if {[lsearch $properties "virtual"] == -1} {
               continue
            }
            if {[lsearch $properties "const"] != -1} {
               continue
            }

            #
            # Extract out all values we need to create the APIs
            #

            set args $apiArgs($api)
            set argList [createArgList $args]
            if {[lsearch $properties "const"] == -1} {
               set apiPath "@instNS@::virtual->$api"
               set body "@preamble@\n"
            } else {
               set apiPath "@constNS@::virtual->$api"
               set body "@constPreamble@\n"
            }

            #
            # Create the virtual API that does the real work
            #

            append body $apiBody($api)
            append commands "proc $apiPath {$args} { $body }\n"

            #
            # Create the call through commands
            #
            # NOTE: We don't worry about const call through APIs since const
            #       are handled in a different routine.  Same with public
            #       call through APIs
            #

            set body "$apiPath $argList"
            append commands "proc @this@->$api {$args} { $body }\n"
            append commands "proc @instNS@::$api {$args} { $body }\n"
            append commands "proc @qualifiedNS@::$api {$args} { $body }\n"
         }
         return $commands
      }


      #-----------------------------------------------------------------------#
      # These are the "real" new and delete commands that do the work of      #
      # creating an instance and deleting an instance.                        #
      #-----------------------------------------------------------------------#


      proc createInstance {objName objNS} {
         #
         # This routine is responsible for performing symbolic substitutions
         # into the build commands to create an instance of the object.  We
         # replace symbolic constants with actual values at this point
         #

         variable instanceCount
         variable objectBuildCommands

         #
         # Make sure that we actually have build commands for the object.  If
         # not, we can't do anything.
         #

         set objIndex "${objNS},${objName}"
         if {![info exists objectBuildCommands($objIndex)]} {
            return ""
         }

         #
         # Perform all variable substitutions using the names created for this
         # instance.  Evaluate each command to create the variables and APIs
         # for the instance
         #

         set num [incr instanceCount]
         array set symbols [createSymbolicConstants $objNS $objName $num]

         set line $objectBuildCommands($objIndex)
         foreach var [array names symbols] {
            regsub -all $var $line $symbols($var) line
         }
         eval $line
         createPreambles $objName $objNS $num
         return [list $symbols(@publicThis@) $symbols(@this@)]
      }


      proc createPreambles {objName objNS num} {
         #
         # This routine creates the preamble (and in the case of const APIs,
         # the postamble).  This routine needs to be called when an object is
         # created and every time that it inherits from another object since
         # variables may have been added to the object.
         #
         # Loop through all of the variables to create prefix commands for
         # the APIs to be able to access variables.
         #

         array set symbols [createSymbolicConstants $objNS $objName $num]

         array set allVarPaths [array get $symbols(@privVars@)]
         array set allVarPaths [array get $symbols(@protVars@)]
         array set allVarPaths [array get $symbols(@pubVars@)]

         set upvarList ""
         foreach var [array names allVarPaths] {
            append upvarList " $allVarPaths($var) $var"
         }

         set body "uplevel 1 set this $symbols(@this@)\n"
         append body "uplevel 1 set pubThis $symbols(@publicThis@)\n"
         if {$upvarList ne ""} {
            append body "uplevel 1 upvar$upvarList\n"
         }
         eval "proc $symbols(@preamble@) {} { $body }\n"

         #
         # Now begin the process of building the preamble and postamble
         # for const APIs
         #
         # If we have non-const variables to track, we need to create
         # a tracking routine that will be invoked when we first enter a const
         # routine and that will be removed when we leave it.  A reference
         # counter will determine when we need to invoke it.
         #
         # This needs to be built from scratch each time because inheritance
         # can change the variable set (expand it) that we need to track
         #

         set constVars [subst "\$$symbols(@constVars@)"]
         set trace1 "trace %s variable %s write ::object::readOnlyError\n"
         set trace2 \
            "trace %s variable %s write \"::object::copyOnWrite %s %s\"\n"

         #
         # Write the code to start tracing non-const variables and perform
         # copy-on-write routines
         #

         set upvarList ""
         set body    "if {!\$$symbols(@refCount@)} {\n"
         append body "   incr $symbols(@refCount@)\n"
         foreach var [array names allVarPaths] {
            set varPath "$symbols(@constNS@)::$var"
            append upvarList " $varPath $var"
            if {[lsearch $constVars $var] != -1} {
               continue
            }
            append body "   set $varPath \$$allVarPaths($var)\n"
            append body [format $trace1 "add" $varPath]
            append body [format $trace2 "add" $allVarPaths($var) \
                            $allVarPaths($var) $varPath]
         }
         append body "}\n"
         append body "uplevel 1 set this $symbols(@constThis@)\n"
         append body "uplevel 1 set pubThis $symbols(@pubConstThis@)\n"
         if {$upvarList ne ""} {
            append body "uplevel 1 upvar$upvarList\n"
         }
         eval "proc $symbols(@constPreamble@) {} { $body }\n"

         #
         # Now put together the code to end tracing non-const variables
         #

         set body    "if {!\[incr $symbols(@refCount@) -1\]} {\n"
         foreach var [array names allVarPaths] {
            if {[lsearch $constVars $var] != -1} {
               continue
            }
            set varPath "$symbols(@constNS@)::$var"
            append body [format $trace1 "remove" $varPath]
            append body [format $trace2 "remove" $allVarPaths($var) \
                            $allVarPaths($var) $varPath]
         }
         append body "}\n"
         eval "proc $symbols(@constPostamble@) {} { $body }\n"
      }


      proc delete {object} {
         #
         # Destroy the object itself.  After destruction, delete all commands
         # and variables that were created for that instance.
         #

         variable debugAllocations
         variable debugObjects

         if {$object eq ""} {
            return
         }

         #
         # If the object inherited from other objects, get the list of those
         # base class instances (supers) since they need to be deleted, too
         #

         set supers [list]
         set superNames ""
         catch {set superNames [$object->getSupers]}
         foreach name $superNames {
            lappend supers [$object->upcast $name]
         }

         #
         # Call the destructor
         #

         if {$debugObjects} {
            unset -nocomplain debugAllocations([$object->__getPublicThis__])
         }
         set objName [$object->typeid]
         $object->~${objName}

         #
         # The easiest way to delete everything (variables, routines, etc) is
         # to delete the instance namespace.  Tcl takes care of everything
         # else for us when we do that.
         #

         namespace delete [$object->__getPublicSpace__]

         #
         # Don't forget to delete any base class.  Note that deletions should
         # go in the order opposite of the construction (in case a destructor
         # uses a super-class inherited API or variable).
         #

         foreach super $supers {
            delete $super
         }
      }


      proc new {objectName callerSpace constructorArgs} {
         #
         # Create a new object of the specified type.  Pass in the arguments
         # (constructorArgs) when creating the class
         #
         # NOTE: Because we need to be namespace aware, we need to do a
         #       namespace search using the following rules:
         #          - If the object name begins with "::", an absolute
         #            namespace path has been given, and we need to use
         #            that path
         #          - If no namespace path is given, or a relative path is
         #            given, check first to see if the caller's namespace has
         #            an object of the correct type.  If no object is returned,
         #            check the global namespace
         #          - If nothing works, we have a failure and error out
         #

         variable debugAllocations
         variable debugObjects

         if {[string range $objectName 0 1] eq "::"} {
            #
            # If we have an absolute namespace as part of the object name,
            # extract it from the base object name
            #

            regexp {(.*::)(.*)} $objectName match ns baseName
            set newObj [createInstance $baseName $ns]
         } else {
            #
            # Use the caller's namespace to check for the object definition
            #

            if {[string range $callerSpace end-1 end] ne "::"} {
               append callerSpace "::"
            }

            #
            # If there is a relative namespace, extract it from the object name
            # and try using that path.  Otherwise, use absolute paths
            #

            set ns ""
            set baseName $objectName
            regexp {(.*::)(.*)} $objectName match ns baseName
            set newObj [createInstance $baseName "${callerSpace}$ns"]
            if {$newObj eq ""} {
               set newObj [createInstance $baseName "::$ns"]
            }
         }

         if {$newObj eq ""} {
            error "Error: No such object ($baseName)"
         }

         set pubThis [lindex $newObj 0]
         set privThis [lindex $newObj 1]
         eval "$privThis->[$pubThis->typeid] $constructorArgs"

         if {$debugObjects} {
            set debugAllocations($pubThis) 1
         }
         return $pubThis
      }


      #-----------------------------------------------------------------------#
      # Routines that deal with object inheritance                            #
      #-----------------------------------------------------------------------#


      proc inherit {object scope superType superArgs} {
         #
         # This routine is invoked when the object (whose private "this" value
         # is passed in $object) inherits from another object whose type is
         # given by $superType.  Arguments to create a new instance of the
         # super object are given in $superArgs.  Finally, the inheritance
         # access rights (private, protected, or public) are given in scope.
         #
         # Since inheritance can only occur from within the constructor,
         # make sure that the calling routine is the constructor.  If not,
         # error out
         #

         set caller [lindex [info level -2] 0]
         regexp {.+->(.+)} $caller match procName
         set objName [$object->typeid]
         if {$procName ne $objName} {
            error "Error: Attempt to inherit in non-constructor ($procName)"
         }

         #
         # The inheritance system supports multiple inheritance, but we cannot
         # inherit from the same class multiple times.
         #

         set objNS [$object->objectSpace]
         set oSupers [getAllSupers $object]
         set superObject [eval "::object::new $superType $objNS {$superArgs}"]
         set superType [$superObject->typeid]
         set sSupers [getAllSupers $superObject]
         if {([lsearch $sSupers $objName] != -1) || ($objName eq $superType)} {
            error "Error: Cannot inherit from base class with same object name ($objName)"
         }
         set conflict [intersect $oSupers $sSupers]
         if {$conflict ne ""} {
            error "Error: Inheriting twice from same base class ($conflict)"
         }

         #
         # Once created, we need to make the new super instance points back to
         # the inheriting object (through the @downcast@ variable) and the
         # inheriting object point to the new super instance (through the
         # @super@ array).
         #

         array set oSymbols [createSymbolicConstants $objNS \
                                $objName [$object->objectid]]
         set object $oSymbols(@this@)

         array set sSymbols [createSymbolicConstants \
                                [$superObject->objectSpace] \
                                $superType [$superObject->objectid]]
         set superObject $sSymbols(@this@)

         set $oSymbols(@super@)($superType) $superObject
         set $sSymbols(@downcast@) $object

         #
         # If we are inheriting from the object using public scoping, we
         # need to put the public "this" value for the super into the public
         # area for the object.  Same for all of it's public supers, etc.
         #

         if {$scope eq "public"} {
            set $oSymbols(@publicSuper@)($superType) $sSymbols(@publicThis@)
         }

         #
         # Track the set of supers that can be inherited from the object.  As
         # long as the scoping is not private, anything that the super had
         # that can be inherited can be inherited by the object, too.  Plus,
         # of course, the super can be inherited.
         #

         if {$scope ne "private"} {
            set $oSymbols(@inheritSuper@)($superType) $sSymbols(@this@)
            array set $oSymbols(@inheritSuper@) \
               [array get $sSymbols(@inheritSuper@)]
         }

         #
         # Now we need to create an additional set of built-ins for the
         # object and the super:
         #    o getSupers -- returns the list of super object names for $object
         #    o upcast -- cast the current $object into one of the instances
         #      it inherits from
         #    o downcast -- convert from the super object back to one of the
         #      object types that inherited it
         #
         # NOTE: Due to multiple inheritance, the "getSupers" and "upcast"
         #       APIs might have already been created through a prior call to
         #       inherit
         #

         if {[info procs "$object->getSupers"] eq ""} {
            #
            # Create the getSupers command.  We will duplicate the code in
            # the public and private space since the @super@ variable contents
            # are different, depending on inheritance mode.
            #
            # This command just returns the names of the super object(s) that
            # $object inherits from
            #

            set body "return \[array names $oSymbols(@publicSuper@)\]"
            eval "proc $oSymbols(@publicThis@)->getSupers {} { $body }"
            eval "proc $oSymbols(@pubConstThis@)->getSupers {} { $body }"

            set body "return \[array names $oSymbols(@super@)\]"
            eval "proc $oSymbols(@instNS@)::getSupers {} { $body }"
            eval "proc $oSymbols(@this@)->getSupers {} { $body }"
            eval "proc $oSymbols(@constThis@)->getSupers {} { $body }"
            eval "proc $oSymbols(@qualifiedNS@)::getSupers {} { $body }"
            eval "proc $oSymbols(@constNS@)::getSupers {} { $body }"
            eval "proc $oSymbols(@qualifiedConstNS@)::getSupers {} { $body }"

            #
            # The upcast API will cast from the current object to one of the
            # supers.  It's tricky for a couple of reasons:
            #   o The public version should only deal with public supers and
            #     return public object values (not values that can be used to
            #     get to the private namespace)
            #   o The private version should deal with all supers and return
            #     object values that are also private
            #   o Const versions of both private and public should return
            #     const versions of the correct type
            #

            set code    "upvar %s super\n"
            append code "set obj \"\"\n"
            append code "foreach n \[array names super\] {\n"
            append code "   if {\$n eq \$type} {\n"
            append code "      set obj \$super(\$n)\n"
            append code "   } else {\n"
            append code "      set s \$super(\$n)\n"
            append code "      catch {set obj \[\$s->upcast \$type\]}\n"
            append code "   }\n"
            append code "   if {\$obj ne \"\"} {\n"
            append code "      break\n"
            append code "   }\n"
            append code "}\n"
            append code "return \$obj\n"

            set body [format $code $oSymbols(@publicSuper@)]
            eval "proc $oSymbols(@publicThis@)->upcast {type} { $body }"

            set body [format $code $oSymbols(@super@)]
            eval "proc $oSymbols(@instNS@)::upcast {type} { $body }"

            set body "return \[upcast \$type\]"
            eval "proc $oSymbols(@this@)->upcast {type} { $body }"
            eval "proc $oSymbols(@constThis@)->upcast {type} { $body }"

            set body "return \[$oSymbols(@instNS@)::upcast \$type\]"
            eval "proc $oSymbols(@qualifiedNS@)::upcast {type} { $body }"

            set body "return \[\[$oSymbols(@instNS@)::upcast \$type\]->const\]::obj"
            eval "proc $oSymbols(@constNS@)::upcast {type} { $body }"

            set body "return \[$oSymbols(@constNS@)::upcast \$type\]"
            eval "proc $oSymbols(@qualifiedConstNS@)::upcast {type} { $body }"

            set body \
               "return \[\[$oSymbols(@publicNS@)::upcast \$type\]->const\]::obj"
            eval "proc $oSymbols(@pubConstThis@)->upcast {type} { $body }"
         }

         #
         # We have to be able to downcast from the super to this object.
         # Like upcast, we need to return the correct type depending on which
         # version of upcast is being called (what namespace it's being called
         # from).
         #

         set body    "set obj \$$sSymbols(@downcast@)\n"
         append body "if {\[\$obj->typeid\] ne \$objType} {\n"
         append body "   set a \"\"\n"
         append body "   catch {set a \[\$obj->downcast \$objType\]}\n"
         append body "   set obj \$a\n"
         append body "}\n"
         append body "return \$obj\n"
         eval "proc $sSymbols(@instNS@)::downcast {objType} { $body }"

         set body "return \[downcast \$objType\]"
         eval "proc $sSymbols(@this@)->downcast {objType} { $body }"

         set call "\[$sSymbols(@instNS@)::downcast \$objType\]"
         set body    "set obj \"\"\n"
         append body "catch {set obj \"\[$call->__getPublicThis__\]\"}\n"
	 append body "set ::errorInfo \"\"\n"
         append body "return \$obj\n"
         eval "proc $sSymbols(@publicThis@)->downcast {objType} { $body }"

         set body    "set obj \"\"\n"
         append body "catch {set obj \"\[$call->const\]::obj\"}\n"
	 append body "set ::errorInfo \"\"\n"
         append body "return \$obj\n"
         eval "proc $sSymbols(@constNS@)::downcast {objType} { $body }"

         set body "return \[downcast \$objType\]"
         eval "proc $sSymbols(@constThis@)->downcast {objType} { $body }"

         set body "return \[$sSymbols(@constNS@)::downcast \$objType\]"
         eval "proc $sSymbols(@qualifiedConstNS@)::downcast {objType} {$body}"

         set call "\[$sSymbols(@publicThis@)->downcast \$objType\]"
         set body    "set obj \"\"\n"
         append body "catch {set obj \"\[$call->const\]::obj\"}\n"
	 append body "set ::errorInfo \"\"\n"
         append body "return \$obj\n"
         eval "proc $sSymbols(@pubConstThis@)->downcast {objType} { $body }"

         set body "return \[$sSymbols(@instNS@)::downcast \$objType\]"
         eval "proc $sSymbols(@qualifiedNS@)::downcast {objType} { $body }"

         #
         # Now we can inherit variables and APIs into $object from $superObject
         # that do not conflict with anything that we already have in place.
         # We need to set the protection on inherited variables and APIs to
         # match the protection rights within the super object and to match
         # the scope passed in.
         #
         # Start inheriting public and protected variables from the super
         # into $object
         #
         # NOTE: We need to make the variables visible in the constructor!
         #

         if {$scope eq "public"} {
            set target(@pubVars@) $oSymbols(@pubVars@)
            set target(@protVars@) $oSymbols(@protVars@)
         } elseif {$scope eq "protected"} {
            set target(@pubVars@) $oSymbols(@protVars@)
            set target(@protVars@) $oSymbols(@protVars@)
         } else {
            set target(@pubVars@) $oSymbols(@privVars@)
            set target(@protVars@) $oSymbols(@privVars@)
         }

         #
         # Now that the scoping has been determined, alias the variables
         #

         set allVars [concat [array names $oSymbols(@pubVars@)] \
                         [array names $oSymbols(@protVars@)] \
                         [array names $oSymbols(@privVars@)]]
         set constVars [subst "\$$sSymbols(@constVars@)"]
         foreach varType [list "@pubVars@" "@protVars@"] {
            set targetVars $target($varType)
            set superVars $sSymbols($varType)
            foreach var [array names $superVars] {
               if {[lsearch $allVars $var] != -1} {
                  continue
               }

               #
               # If it's a const variable, not it in the inheriting object,
               # too
               #

               if {[lsearch $constVars $var] != -1} {
                  lappend $oSymbols(@constVars@) $var
               }

               #
               # Create the variable in all of the private namespaces
               #

               set varPath [subst "\$${superVars}($var)"]
               set spaces [list "@instNS@" "@qualifiedNS@" \
                              "@constNS@" "@qualifiedConstNS@"]
               if {$scope eq "public"} {
                  lappend spaces "@publicNS@" "@pubConstNS@"
               }
               foreach ns $spaces {
                  if {[info vars $sSymbols($ns)::$var] ne ""} {
                     eval "upvar $varPath $oSymbols($ns)::$var"
                  }
               }

               #
               # Expose the variable to the constructor so that it's
               # immediately available.  Save the variable path in the
               # propert array
               #

               uplevel 2 "upvar $varPath $var"
               set ${targetVars}($var) $varPath
            }
         }

         #
         # Basically, we need to repeat the process for all of the APIs in
         # the super object
         #
         # Determine where the procs will be registered
         #

         if {$scope eq "public"} {
            set target(@pubProcs@) $oSymbols(@pubProcs@)
            set target(@protProcs@) $oSymbols(@protProcs@)
         } elseif {$scope eq "protected"} {
            set target(@pubProcs@) $oSymbols(@protProcs@)
            set target(@protProcs@) $oSymbols(@protProcs@)
         } else {
            set target(@pubProcs@) $oSymbols(@privProcs@)
            set target(@protProcs@) $oSymbols(@privProcs@)
         }

         #
         # Process each non-conflicting proc
         #

         set superVirtuals [array names $sSymbols(@virtualProcs@)]
         set allProcs [concat [array names $oSymbols(@pubProcs@)] \
                          [array names $oSymbols(@protProcs@)] \
                          [array names $oSymbols(@privProcs@)]]
         foreach procType [list "@pubProcs@" "@protProcs@"] {
            set targetProcs $target($procType)
            set superProcs $sSymbols($procType)
            foreach p [array names $superProcs] {
               if {[lsearch $allProcs $p] != -1} {
                  continue
               }

               #
               # Create the API in all of the private namespaces
               #

               set procPath [subst "\$${superProcs}($p)"]
               set args [getArguments $procPath]
               set argList [createArgList $args]

               set spaces [list "@instNS@" "@qualifiedNS@" \
                              "@constNS@" "@qualifiedConstNS@"]
               if {$scope eq "public"} {
                  lappend spaces "@publicNS@" "@pubConstNS@"
               }
               if {[lsearch $superVirtuals $p] == -1} {
                  set isVirtual 0
               } else {
                  set isVirtual 1
                  set apiBody [info body $procPath]
               }
               foreach ns $spaces {
                  set api $sSymbols($ns)::$p
                  if {[info procs $api] ne ""} {
                     if {$isVirtual} {
                        eval "proc $oSymbols($ns)::$p {$args} { $apiBody }"
                     } else {
                        eval "proc $oSymbols($ns)::$p {$args} {$api $argList}"
                     }
                  }
               }

               #
               # Do the same for all of the internal "this" variants
               #

               foreach this [list "@this@" "@constThis@"] {
                  set api $sSymbols($this)->$p
                  if {[info procs $api] ne ""} {
                     set newAPI "$oSymbols($this)->$p"
                     if {$isVirtual} {
                        eval "proc $newAPI {$args} { $apiBody }"
                     } else {
                        eval "proc $newAPI {$args} {$api $argList}"
                     }
                  }
               }

               #
               # The public "this" variants always point to the internal
               # "private" variants
               #

               if {$scope eq "public"} {
                  set api $sSymbols(@publicThis@)->$p
                  if {[info procs $api] ne ""} {
                     set newAPI "$oSymbols(@publicThis@)->$p"
                     set body "$oSymbols(@instNS@)::$p $argList"
                     eval "proc $newAPI {$args} { $body }"
                  }

                  set api $sSymbols(@pubConstThis@)->$p
                  if {[info procs $api] ne ""} {
                     set newAPI "$oSymbols(@pubConstThis@)->$p"
                     set body "$oSymbols(@constNS@)::$p $argList"
                     eval "proc $newAPI {$args} { $body }"
                  }
               }

               set ${targetProcs}($p) $procPath
            }
         }

         #
         # Copy the qualified namespaces of the super to the object.  The
         # easiest way to do this is to export all of the commands in the
         # namespace that we want to copy from and import into the namespace
         # we want to copy to.  In this case, none of the namespace procs
         # do anything other than reference other APIs
         #

         set source $sSymbols(@qualifiedNS@)
         set dest $oSymbols(@instNS@)::$superType
         namespace eval $source { namespace export * }
         eval "namespace eval $dest { namespace import ${source}::* }"

         set source $sSymbols(@qualifiedConstNS@)
         set dest $oSymbols(@constNS@)::$superType
         namespace eval $source { namespace export * }
         eval "namespace eval $dest { namespace import ${source}::* }"

         #
         # Any inherited namespaces that the super has (that are not private)
         # also need to be copied
         #

         foreach name [array names $sSymbols(@inheritSuper@)] {
            foreach index [list "@instNS@" "@constNS@"] {
               set source $sSymbols($index)::$name
               set dest $oSymbols($index)::$name
               namespace eval $source { namespace export * }
               eval "namespace eval $dest { namespace import ${source}::* }"
            }
         }

         #
         # Anything that was marked as virtual in the super that is not
         # virtual in the object inheriting from the super needs to become
         # a virtual.
         #
         # NOTE: We need to change any qualified calls so that they access
         #       the virtual API instead of the normal private API since the
         #       private could change as things are inherited (it may end up
         #       pointing to a different virtual function altogether).
         #

         set oConstProcs [subst "\$$oSymbols(@constProcs@)"]
         set sConstProcs [subst "\$$sSymbols(@constProcs@)"]
         set currentVirtuals [array names $oSymbols(@virtualProcs@)]
         set sPrivateProcs [array names $sSymbols(@privProcs@)]
         foreach api $superVirtuals {
            #
            # Skip any virtuals in the super that are private since this
            # object isn't supposed to be able to see them
            #

            if {[lsearch $sPrivateProcs $api] != -1} {
               continue
            }

            #
            # Whether the API in the object was declared virtual or not, it
            # will be virtual since the super has a virtual specification on
            # the API.  Thus, the API arguments MUST match
            #

            set args [getArguments $oSymbols(@instNS@)::$api]
            if {$args ne [getArguments $sSymbols(@instNS@)::$api]}  {
               set objAPI "[$object->typeid]::$api"
               error "Error: virtual API arguments must match ($objAPI)"
            }

            #
            # They must both be constant or non-constant.  There can't be a
            # mixture
            #

            set oIndex [lsearch $oConstProcs $api]
            set sIndex [lsearch $sConstProcs $api]
            if {(($oIndex == -1) && ($sIndex != -1)) ||
                (($oIndex != -1) && ($sIndex == -1))} {
               set objAPI "[$object->typeid]::$api"
               error "Error: different const specs for inherited API ($objAPI)"
            }

            #
            # If the API is not already known to be virtual, fix it
            #

            if {[lsearch $currentVirtuals $api] != -1} {
               continue
            }

            #
            # Make the old APIs, that used to point to the code in the const
            # namespace or instance namespace, now point to the virtual in
            # the const namespace or virtual namespace
            #

            if {$oIndex == -1} {
               set procPath "$oSymbols(@instNS@)::$api"
               set virtPath "$oSymbols(@instNS@)::virtual->$api"
            } else {
               set procPath "$oSymbols(@constNS@)::$api"
               set virtPath "$oSymbols(@constNS@)::virtual->$api"
            }
            rename $procPath $virtPath

            set body "$virtPath [createArgList $args]"
            eval "proc $procPath {$args} { $body }"
            eval "proc $oSymbols(@this@)->$api {$args} { $body }"
            eval "proc $oSymbols(@qualifiedNS@)::$api {$args} { $body }"
            if {$oIndex != -1} {
               eval "proc $oSymbols(@instNS@)::$api {$args} { $body }"
               eval "proc $oSymbols(@constThis@)->$api {$args} { $body }"
               eval "proc $oSymbols(@qualifiedConstNS@)::$api {$args} {$body}"
            }

            eval "set ${oSymbols(@virtualProcs@)}($api) $virtPath"
         }

         #
         # At this point, all virtuals should be known for the object.  Go
         # through the supers and replace their non-qualified virtual calls
         # invoke the objects virtual instead of the super's virtual
         #
         # JFC: We need to avoid doing a fixup of private procs!  Of course, I
         #      don't think that C++ does that....
         #

         foreach api [array names $oSymbols(@virtualProcs@)] {
            if {[lsearch $oConstProcs $api] != -1} {
               set virtPath "$oSymbols(@constNS@)::virtual->$api"
               set isConst 1
            } else {
               set virtPath "$oSymbols(@instNS@)::virtual->$api"
               set isConst 0
            }
            set args [getArguments $oSymbols(@instNS@)::$api]
            set body "$virtPath [createArgList $args]"
            inheritFixup $superObject $api $args $body $isConst
         }

         #
         # Rebuild all preambles as we need to make sure that all inherited
         # variables become part of the object for all APIs called from this
         # point onward
         #

         createPreambles [$object->typeid] $objNS [$object->objectid]
      }


      proc inheritFixup {object api apiArgs newBody isConst} {
         #
         # We need to replace non-qualified API invocations in $object that
         # point to its own virtual with the new body.
         #
         # Make sure that the API is a virtual in this object.  If not, there's
         # nothing left to do
         #

         array set symbols [createSymbolicConstants [$object->objectSpace] \
                               [$object->typeid] [$object->objectid]]
         set virtuals [array names $symbols(@virtualProcs@)]
         if {[lsearch $virtuals $api] == -1} {
            return
         }

         #
         # If it exists within the public space, replace the body
         #

         if {[info procs $symbols(@publicNS@)::$api] ne ""} {
            eval "proc $symbols(@publicNS@)::$api {$apiArgs} { $newBody }"
            eval "proc $symbols(@publicThis@)->$api {$apiArgs} { $newBody }"
         }

         eval "proc $symbols(@instNS@)::$api {$apiArgs} { $newBody }"
         eval "proc $symbols(@this@)->$api {$apiArgs} { $newBody }"
         if {$isConst} {
            eval "proc $symbols(@constNS@)::$api {$apiArgs} { $newBody }"
            eval "proc $symbols(@constThis@)->$api {$apiArgs} { $newBody }"
         }

         #
         # Now do the same for each super of this object, recursively
         #

         foreach super [array names $symbols(@super@)] {
            set obj [subst "\$$symbols(@super@)($super)"]
            inheritFixup $obj $api $apiArgs $newBody $isConst
         }
      }


      #-----------------------------------------------------------------------#
      # Misc. utility routines                                                #
      #-----------------------------------------------------------------------#


      proc copyOnWrite {sourceVar destVar name index type} {
         #
         # This routine is a callback that has been associated with a trace
         # on a variable.  The variable $sourceVar has been written to,
         # and we need to copy it's value to $destVar.  However, the variable
         # referenced by destVar may also have traces on it.  Thus, we need
         # to disable the traces on $destVar, copy from $sourceVar to
         # $destVar, and re-enable traces.
         #
         # This code has been designed for use when copying data from an
         # instance variable to a const copy of that instance variable.
         #
         # NOTE: The last 3 parameters are required by the trace command,
         #       as part of the callback, but they are not used here.
         #

         set traceInfo [trace info variable $destVar]
         foreach trace $traceInfo {
            trace remove variable $destVar [lindex $trace 0] [lindex $trace 1]
         }
         set $destVar [subst "\$$sourceVar"]
         foreach trace $traceInfo {
            trace add variable $destVar [lindex $trace 0] [lindex $trace 1]
         }
      }


      proc createArgList {args} {
         #
         # Given the argument list to an object member function, create the
         # string to use to turn around and use those arguments in another
         # function call.  For example, if a proc looked like the following:
         #        proc a {b c {d ""}} { ... }
         # this function would generate a string that looks like
         #        $b $c $d
         #
         # NOTE: The values in $args may contain another list with (a variable
         #       with a default value).  We take the first element from all
         #       arguments to avoid this issue.
         #

         set callList ""
         foreach arg [lindex $args 0] {
            append callList "\$[lindex $arg 0] "
         }
         return $callList
      }


      proc createSymbolicConstants {objNS objName num} {
         #
         # Given an object namespace, object name, and unique object
         # identifier, create values to replace the symbolic constants
         #

         set base "${objNS}${objName}::inst${num}"

         set publicNS "${base}::__public__"
         set staticNS "${objNS}${objName}::__private__"
         set instNS "${base}::__private__"
         set constNS "${instNS}::__const__"
         set pubConstNS "${publicNS}::__const__"
         set qualifiedNS "${instNS}::${objName}"
         set qualifiedConstNS "${constNS}::${objName}"

         set this "${instNS}::obj"
         set constThis "${constNS}::obj"
         set pubThis "${publicNS}::obj"
         set pubConstThis "${pubConstNS}::obj"

         set privProcs "${instNS}::_priv_procs"
         set protProcs "${instNS}::_prot_procs"
         set pubProcs "${instNS}::_pub_procs"
         set virtualProcs "${instNS}::_virtual_procs"
         set privVars "${instNS}::_priv_vars"
         set protVars "${instNS}::_prot_vars"
         set pubVars "${instNS}::_pub_vars"
         set constVars "${instNS}::_const_vars"
         set constProcs "${instNS}::_const_procs"

         set preamble "${instNS}::__start_inst__"
         set constPreamble "${constNS}::__start_const__"
         set constPostamble "${constNS}::__end_const__"
         set refCount "${constNS}::_ref_count"

         set super "${instNS}::_super"
         set publicSuper "${publicNS}::_super"
         set inheritSuper "${instNS}::_inherit_super"
         set downcast "${instNS}::_downcast_obj"

         set friends "${instNS}::_friends"

         #
         # Now that the variables have been created, store them into an
         # array and return the array
         #

         array set symbols [list]
         set symbols(@num@) $num

         set symbols(@publicNS@) $publicNS
         set symbols(@staticNS@) $staticNS
         set symbols(@instNS@) $instNS
         set symbols(@constNS@) $constNS
         set symbols(@pubConstNS@) $pubConstNS
         set symbols(@qualifiedNS@) $qualifiedNS
         set symbols(@qualifiedConstNS@) $qualifiedConstNS

         set symbols(@this@) $this
         set symbols(@constThis@) $constThis
         set symbols(@publicThis@) $pubThis
         set symbols(@pubConstThis@) $pubConstThis

         set symbols(@privProcs@) $privProcs
         set symbols(@protProcs@) $protProcs
         set symbols(@pubProcs@) $pubProcs
         set symbols(@virtualProcs@) $virtualProcs
         set symbols(@privVars@) $privVars
         set symbols(@protVars@) $protVars
         set symbols(@pubVars@) $pubVars
         set symbols(@constVars@) $constVars
         set symbols(@constProcs@) $constProcs

         set symbols(@super@) $super
         set symbols(@publicSuper@) $publicSuper
         set symbols(@inheritSuper@) $inheritSuper
         set symbols(@downcast@) $downcast

         set symbols(@preamble@) $preamble
         set symbols(@constPreamble@) $constPreamble
         set symbols(@constPostamble@) $constPostamble
         set symbols(@refCount@) $refCount

         set symbols(@friends@) $friends

         return [array get symbols]
      }


      proc getAllSupers {obj} {
         #
         # Recursively return all supers for the passed object
         #

         set supers ""
         array set symbols [createSymbolicConstants [$obj->objectSpace] \
                               [$obj->typeid] [$obj->objectid]]
         set superVar $symbols(@super@)
         foreach super [array names $symbols(@super@)] {
            lappend supers $super
            set superObj [subst "\$$symbols(@super@)($super)"]
            set supers [concat $supers [getAllSupers $superObj]]
         }
         return $supers
      }


      proc getArguments {func} {
         #
         # Return the set of arguments (including default arguments) for
         # the specified function
         #

         set i -1
         set returnString ""
         foreach arg [info args $func] {
            if {[incr i]} {
               append returnString " "
            }
            if {[info default $func $arg value]} {
               append returnString "{$arg \"$value\"}"
            } else {
               append returnString $arg
            }
         }
         return $returnString
      }


      proc intersect {list1 list2} {
         #
         # Functions like the Tclx "intersect" code to produce the
         # intersection of 2 lists.  This is a brute-force methodology
         #

         set overlap [list]
         set list1 [lsort -unique $list1]
         foreach l [lsort -unique $list2] {
            if {[lsearch $list1 $l] != -1} {
               lappend overlap $l
            }
         }
         return $overlap
      }


      proc objectExists {objectName callerSpace} {
         #
         # Determine whether the named object exists or not.  Return 1 if it
         # does, 0 otherwise
         #

         variable objectBuildCommands

         #
         # We can tell if an object has been defined by looking for the
         # namespace qualified entry in the array objectBuildCommands
         #

         set objList [qualifyObject $objectName $callerSpace]
         set objectName [lindex $objList 0]
         set objectNS [lindex $objList 1]
         set objectQualified [lindex $objList 2]
         set objectIndex "${objectNS},${objectName}"

         if {![info exists objecBuildCommands($objectIndex)] &&
             !$objectQualified} {
            set objectNS "::"
            set objectIndex "${objectNS},${objectName}"
         }
         if {[info exists objectBuildCommands($objectIndex)]} {
            return 1
         } else {
            return 0
         }
      }


      proc qualifyObject {objectName callerSpace} {
         #
         # This routine returns a list of values:
         #    o The object name (without any namespace qualifier that might
         #      have been passed in)
         #    o The namespace for the object
         #    o A 1 or 0 value to indicate whether the passed object name
         #      had a namespace qualifier (either fully qualified or
         #      relative to the namespace in $callerSpace)
         #

         if {[string range $callerSpace end-1 end] ne "::"} {
            append callerSpace "::"
         }

         set index [string last "::" $objectName]
         if {$index != -1} {
            #
            # The object name has a namespace within it.  Remove the namespace
            # portion of the name.  If the namespace is relative, prepend the
            # caller's namespace to the relative namespace to obtain an
            # absolute namespace
            #

            set NS [string range $objectName 0 [incr index]]
            set objectName [string range $objectName [incr index] end]
            if {[string range $NS 0 1] ne "::"} {
               append callerSpace $NS
            } else {
               set callerSpace $NS
            }
            set qualified 1
         } else {
            set qualified 0
         }

         return [list $objectName $callerSpace $qualified]
      }


      proc readOnlyError {varName index operation} {
         #
         # This routine is invoked if somebody attempts to write to a
         # read-only variable
         #

         regexp {.*::(.*)} $varName match varName
         error "Error: Attempt to movify const variable ($varName)"
      }


      #-----------------------------------------------------------------------#
      # These utility routines are provided to dump the contents of an object #
      # instance in a formatted manner (mainly for debug purposes).           #
      #-----------------------------------------------------------------------#


      proc dump {objectName} {
         #
         # Dump the contents of the namespace associated with the passed
         # object name.  This is for debug purposes only!
         #

         variable objectBuildCommands

         #
         # We need to look at the array objectBuildCommands to find out if the
         # object exists.  If it doesn't exist, there's nothing to dump.
         #
         # NOTE: The variable objectBuildCommands is indexed into by looking
         #       at the object namespace and object name
         #
         # NOTE: This code is fundamentally the same code found in the
         #       proc objectExists.  It should probably be combined in
         #       some fashion instead of using copy/paste commands
         #

         set objList [qualifyObject $objectName [uplevel 1 namespace current]]
         set objectName [lindex $objList 0]
         set objectNS [lindex $objList 1]
         set objectQualified [lindex $objList 2]
         set objectIndex "${objectNS},${objectName}"

         if {![info exists objectBuildCommands($objectIndex)] &&
             !$objectQualified} {
            set objectNS "::"
            set objectIndex "${objectNS},${objectName}"
         }
         if {![info exists objectBuildCommands($objectIndex)]} {
            return ""
         }

         #
         # We know what the object name and namespace is.  Now dump the
         # namespace
         #

         set objectName "${objectNS}${objectName}"
         set returnString "namespace eval ${objectName}:: {\n"
         append returnString [dumpNameSpace "${objectName}" "   "]
         append returnString "}\n"
         return $returnString
      }


      proc dumpNameSpace {space indent} {
         #
         # Dump the contents of the specified namespace.  Other than the fact
         # that we know about object keywords, this isn't much more than a
         # pretty printer for a namespace.
         #

         set returnString ""

         #
         # Get all variables for the space and dump them first.  If the
         # variable is an array, dump the array contents as a set of
         # comments
         #

         set varsPrinted 0
         foreach var [lsort [info vars "${space}::*"]] {
            set varsPrinted 1
            regexp {.*::(.*)} $var match name
            append returnString "${indent}variable $name"
            if {[array exists $var]} {
               foreach i [array names $var] {
                  set value [subst "\$${var}($i)"]
                  append returnString "\n${indent}# ${name}($i) = $value"
               }
            } elseif {[info exists $var]} {
               set value [subst "\$$var"]
               append returnString " {$value}"
            }

            #
            # If there is a trace on the variable (for example, a read-only
            # trace, display it as a comment
            #

            set traceInfo [trace info variable $var]
            if {$traceInfo ne ""} {
               append returnString " ; # trace -> $traceInfo"
            }
            append returnString "\n"
         }
         if {$varsPrinted} {
            append returnString "\n"
         }

         #
         # Dump each procedure
         #

         set openBrace "{"
         set closeBrace "}"
         set procsPrinted 0
         foreach func [lsort [info procs "${space}::*"]] {
            set procsPrinted 1
            regexp {.*::(.*)} $func match name
            append returnString \
               "${indent}proc $name {[getArguments $func]} {\n"
            set indent "$indent   "
            set funcBody [info body $func]
            while {[string length $funcBody]} {
               set lineEnd [string first "\n" $funcBody]
               if {$lineEnd != -1} {
                  set line [string range $funcBody 0 $lineEnd]
                  set funcBody [string range $funcBody [incr lineEnd] end]
               } else {
                  set line $funcBody
                  set funcBody ""
               }

               set line [string trim $line]
               if {$line eq ""} {
                  continue
               }

               if {$line ne $closeBrace} {
                  if {([string index $line 0] eq $closeBrace) &&
                      ([string index $line end] eq $openBrace)} {
                     append returnString "[string range $indent 0 end-3]"
                  } else {
                     append returnString "$indent"
                  }
                  append returnString "$line\n"
               }

               set opens 0
               set closes 0
               set len [string length $line]
               for {set i 0} {$i < $len} {incr i} {
                  set char [string index $line $i]
                  if {$char eq $openBrace} {
                     incr opens
                  } elseif {$char eq $closeBrace} {
                     incr closes
                  }
               }

               if {$opens > $closes} {
                  set diff [expr {$opens - $closes}]
                  set extra [string repeat "   " $diff]
                  set indent "${indent}${extra}"
               } elseif {$opens < $closes} {
                  set diff [expr {$closes - $opens}]
                  set len [string length $indent]
                  set end [expr {$len - (3 * $diff) - 1}]
                  set indent [string range $indent 0 $end]
               }

               if {$line eq $closeBrace} {
                  append returnString "${indent}${line}\n"
               }
            }
            set indent [string range $indent 0 end-3]
            append returnString "${indent}}\n"
         }
         if {$procsPrinted} {
            append returnString "\n"
         }

         #
         # Process each child namespace
         #

         foreach ns [lsort [namespace children ${space}]] {
            append returnString "$indent"
            regexp {.*::(.*)} $ns match name
            append returnString "namespace eval ${name}:: {\n"
            append returnString [dumpNameSpace $ns "$indent   "]
            append returnString "${indent}}\n"
         }

         return $returnString
      }


      #-----------------------------------------------------------------------#
      # Debugging routines                                                    #
      #-----------------------------------------------------------------------#


      proc debug {status} {
         #
         # Turn debugging on or off
         #

         variable debugAllocations
         variable debugObjects 0

         set debugObjects $status
         if {$status} {
            array set debugAllocations [list]
            rename ::exit ::__debugExit
            rename ::debugExit ::exit
         } else {
            array unset debugAllocations
            rename ::exit ::debugExit
            rename ::__debugExit ::exit
         }
      }


      proc debugExit {args} {
         #
         # If we are in debug mode, we need to call the Tcl exit proc, and
         # that's been renamed to ::__debugExit
         #
         # NOTE: Because of the rename, we need to tell the linter to ignore
         #       errors assicated with the missing command.
         #

         variable debugAllocations

         set stillAllocated [array names debugAllocations]
         if {[llength $stillAllocated]} {
            puts "The following objects have not been deleted:"
            foreach name $stillAllocated {
               puts "\t$name"
            }
         }
         if {[llength [lindex $args 0]]} {
            ##nagelfar ignore
            ::__debugExit [lindex $args 0]
         } else {
            ##nagelfar ignore
            ::__debugExit 0
         }
      }
   }


   proc debugExit {args} {
      ##nagelfar ignore
      ::object::debugExit $args
   }
}
namespace eval FFF {
  proc create_ellipsis {count} {
    return [string repeat "." $count]
  }
}
##############################################################################
#  Copyright (c) 1997-[clock format [clock seconds] -format %Y] Cadence Design Systems, Inc #
#             Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [misc.tcl]                                                    #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {

  variable newEllipsisCommentLine 0;
  variable currentEllipsisCount 0;

  proc write_ellipsis {args} {
    if {[regexp {start} $args]} {
      set ::FFF::newEllipsisCommentLine 1
      set ::FFF::currentEllipsisCount 0
    }
    if {[regexp {end} $args]} {
      set ::FFF::newEllipsisCommentLine 1
      set ::FFF::currentEllipsisCount 0
      puts ""
    } else {
      if {$::FFF::newEllipsisCommentLine} {
        # I'm in a new line. Prefix with comment, and do not write a newline character
        set ellipsis [::FFF::create_ellipsis $::FFF::currentEllipsisCount]
        puts -nonewline "// $ellipsis"
        # Reset this flag since we are no longer in a new line
        set ::FFF::newEllipsisCommentLine 0
      } else {
        # Not in a new line. No prefix, but do not write newline char
        puts -nonewline "."
      }
      incr ::FFF::currentEllipsisCount
    }
    flush stdout
  }
}
##############################################################################
#  Copyright (c) 1997-[clock format [clock seconds] -format %Y] Cadence Design Systems, Inc #
#             Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [misc.tcl]                                                    #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {
  namespace export dbg_puts
  proc dbg_puts {args} {

    if {![llength [info commands parse_options]]} {
      if {[llength [info commands $::ns(compat)::parse_options]]} {
        namespace import $::ns(parse_opt)::parse_options
      } else {
        # Fatal error if cannot find parse_options (this should really be caught earlier in the applet)
        ::puts "ERROR: Cadence Compatibility Layer is required when running the Foundation Flow outside of RC."
        ::puts "       Please make sure the Compatibility Layer is in your TCL Library search path."
        ::puts "       Contact Cadence for assistance."
        ::puts "       Exiting..."
        return -code error
      }
    }

    # Remove curly braces (due to passing argument through a proc)
    #puts "dbg_puts before regsub: ->$args<-"
    #while {[regexp {^\{(.*)\}$} $args full args ]} {}
    #puts "dbg_puts after regsub: ->$args<-"

    switch -- [parse_options [calling_proc] {} $args \
      "-print_stdout bos print to stdout as well as the .fff_debug file" printToStdout \
      "-debug bOs useless no-opt option just so I can always pass some option to this proc" debugOption \
      "srs string to print" stringToPrint \
    ] {
      -2 { return }
      0 { error "Failed on [lindex [info level 0] 0]" }
    }

    #
    # Upvar to get the amount of indent to use (based on proc calling level)
    upvar 1 Debug Debug_local
    upvar 1 msgPrefix msgPrefix_local
    if {![info exists msgPrefix_local]} {
      set msgPrefix_local ""
    } else {
      # Add a trailing space to the prefix if one doesn't exist
      # and the prefix is not empty
      if {![regexp {.*[[:space:]]$} $msgPrefix_local]} {
        set msgPrefix_local "$msgPrefix_local "
      }
    }
    # Flatten the stringToPrint variable to remove extra braces
    set stringToPrint [::FFF::remove_outer_braces $stringToPrint]
    if {$printToStdout} {
      ::puts "${stringToPrint}"
    }
    if {([info exists Debug_local] && $Debug_local) || ([info exists ::FFF::Debug] && $::FFF::Debug)} {
      ::puts $::FFF::DEBUG_OSTREAM "${msgPrefix_local}${stringToPrint}"
    }
  }
}
##############################################################################
#  Copyright (c) 1997-[clock format [clock seconds] -format %Y] Cadence Design Systems, Inc #
#             Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [misc.tcl]                                                    #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {
  proc fff_proc_init {} {
    uplevel 1 {
      set dbgPrefixWs [string repeat " " [info level]]
      set msgPrefix "${dbgPrefixWs}[typeid]():"
      set Debug $::FFF::Debug
      #::FFF::dbg_puts "BEGIN \{"
    }
  }
}
##############################################################################
#  Copyright (c) 1997-[clock format [clock seconds] -format %Y] Cadence Design Systems, Inc #
#             Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [misc.tcl]                                                    #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {
  proc fff_proc_close {} {
    uplevel 1 {
      set dbgPrefixWs [string repeat " " [info level]]
      set msgPrefix "${dbgPrefixWs}[calling_proc]():"
      set Debug $::FFF::Debug
      #::FFF::dbg_puts "\} END [clock format [clock seconds]]"
    }
  }
}
##############################################################################
#  Copyright (c) 1997-[clock format [clock seconds] -format %Y] Cadence Design Systems, Inc #
#             Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [misc.tcl]                                                    #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {
  proc fff_member_init {} {
    uplevel 1 {
      # Set scope variables for debug messaging
      set dbgPrefixWs [string repeat " " [info level]]
      set msgPrefix "${dbgPrefixWs}[typeid]([$this->get_name])->[::FFF::getProcName]():"
      set Debug $::FFF::Debug

      # Import parse_options
      if {![llength [info commands parse_options]]} {
        if {[llength [info commands $::ns(compat)::parse_options]]} {
          namespace import $::ns(parse_opt)::parse_options
        } else {
	  # Fatal error if cannot find parse_options (this should really be caught earlier in the applet)
	  puts "ERROR: Cadence Compatibility Layer is required when running the Foundation Flow outside of RC."
	  puts "       Please make sure the Compatibility Layer is in your TCL Library search path."
	  puts "       Contact Cadence for assistance."
	  puts "       Exiting..."
          return -code error
	}
      }

      # Import flatten_list
      if {![llength [info commands flatten_list]]} {
        namespace import ::FFF::flatten_list
      }

      # Import dbg_puts
      if {![llength [info commands dbg_puts]]} {
        namespace import ::FFF::dbg_puts
      }

    };# end uplevel
  };# end proc
};# end namespace eval FFF
##############################################################################
#  Copyright (c) 1997-[clock format [clock seconds] -format %Y] Cadence Design Systems, Inc #
#             Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [misc.tcl]                                                    #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {
  proc fff_member_close {} {
    uplevel 1 {
      set dbgPrefixWs [string repeat " " [info level]]
      set msgPrefix "${dbgPrefixWs}[typeid]([$this->get_name])->[::FFF::getProcName]():"
      set Debug $::FFF::Debug
      #::FFF::dbg_puts "END"
    }
  }
}
##############################################################################
#  Copyright (c) 1997-[clock format [clock seconds] -format %Y] Cadence Design Systems, Inc #
#             Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [misc.tcl]                                                    #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {
  # This needs expanded support, but should help deal with some of the simple expression usage that Rich requested
  proc fix_default_config_name {FFObjectID} {
    set dbgPrefixWs [string repeat " " [info level]]
    set Debug $::FFF::Debug
    if {[::FFF::flatten_list [$FFObjectID->get_configurations]] ne ""} {
      set str3 {}
      foreach config  [$FFObjectID->get_configurations] {
        lappend str3 [$config->get_name]
      }
      set str3 [::FFF::flatten_list $str3]
    } else {
      set str3 ""
    }
    return $str3
  }
  namespace export fix_default_config_name
}
##############################################################################
#  Copyright (c) 1997-[clock format [clock seconds] -format %Y] Cadence Design Systems, Inc #
#             Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [misc.tcl]                                                    #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {
  proc array_search {searchArr searchString} {
    upvar 1 $searchArr searchArr_local
    set matchList ""
    foreach {key value}  [array get searchArr_local] {
     if {$value eq $searchString} {
       lappend matchList $key
     }
    }
    return $matchList
  }
}
##############################################################################
#  Copyright (c) 1997-[clock format [clock seconds] -format %Y] Cadence Design Systems, Inc #
#             Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [misc.tcl]                                                    #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {
  proc is_var_a_list {args} {
    set args [flatten_list $args]
    if {[llength $args] > 1} {
      return 1
    } else {
      return 0
    }
  }
}
##############################################################################
#  Copyright (c) 1997-[clock format [clock seconds] -format %Y] Cadence Design Systems, Inc #
#             Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [misc.tcl]                                                    #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {
  # Proc to generate new output file names (auto increment based on what
  # files are found in the current working directory.
  # Example: input argument setup.tcl
  # files in dir: setup.tcl setup.tcl1
  # @return: setup.tcl2
  proc generate_next_output_filename {scriptNameBase} {    
    set dbgPrefixWs [string repeat " " [info level]]
    set Debug $::FFF::Debug
    set file_list [glob -nocomplain [set scriptNameBase]*]
    if {[llength $file_list] > 0} {
      set highNum 1
      foreach file $file_list {
        set re "[set scriptNameBase](\[\[:digit:\]\]+)\$"
        if {[regexp $re $file full num]} {
          if {$num >= $highNum} { 
	    set highNum [incr num]
 	  }
        }
      }
      set scriptName $scriptNameBase$highNum
    } else {
      set scriptName "[set scriptNameBase]"
    }
    return $scriptName
  }
}
##############################################################################
#  Copyright (c) 1997-[clock format [clock seconds] -format %Y] Cadence Design Systems, Inc #
#             Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [misc.tcl]                                                    #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {
  set dbgPrefixWs [string repeat " " [info level]]

  proc list2prettyArr {args} {
    set dbgPrefixWs [string repeat " " [info level]]
    # maxCharLength is the maximum length of characters a list should have on one line before breaking it into multiple lines"
    set maxCharLength 70
    set origArgs $args
    set parse_options_args_list {}
    set theListToPrint {}
    #array set returnArr {}
    array unset returnArr
    set token [lindex $origArgs 0]
    while {$token ne ""} {
      if { [string match -* $token] } {
        if { $token eq "-bracetype" } {
	  lappend parse_options_args_list $token
	  lappend parse_options_args_list [lrange $origArgs 1 1]
          set origArgs [lrange $origArgs 2 end]
        } else {
          lappend parse_options_args_list $token
          set origArgs [lrange $origArgs 1 end]
        }
      } else {
        lappend theListToPrint $token
        set origArgs [lrange $origArgs 1 end]
      }
      set token [lindex $origArgs 0]
    };# end while

    # parse_options
    switch -- [parse_options [calling_proc] {} $parse_options_args_list \
      "-bracetype sos Either curly braces or double qutoes to define the brace type" myBraceType \
      ] {
      -2 { return }
      0 { error "Failed on [lindex [info level 0] 0]" }
    }

    set index 0
    # Determine first line:
    switch -exact -- $myBraceType {
      curly { 
	set returnArr($index) "\{ \\"
      }
      quote {
        set returnArr($index) "\" \\"
      }
      default { 
        puts "list2prettyArr() INTERNAL ERROR. Please contact the Applet developer"
      }
    } 

    incr index
    set returnArr($index) ""
    set origList [::FFF::flatten_list [list $theListToPrint]]
    set token_id 0

    # set up a namespace to set the variable
    # this is a safety measure to insure that we don't miss any special characters
    set mVarNamespace [namespace current]::VAR_NS
    set mVarTrackingNamespace [namespace current]::VAR_TRACKING_NS
    namespace eval $mVarTrackingNamespace {
      #set dbgPrefixWs [string repeat " " [info level]]
      variable mVarArray
      variable set_args
      variable myConfigObjNSPath
      variable mArgs
    }

    set token [lindex $origList $token_id]
    set testString "$token"
    while {$token ne ""} {
      if {[string length $testString] <= $maxCharLength} {
	# testString was < maxlength, so this becomes the workingString
	set workingString $testString
        while {[string length $testString] <= $maxCharLength && $token ne "" } {
	  # Add the next token to the testString
          incr token_id
          set token [lindex $origList $token_id]
          set testString [::FFF::flatten_list [list $workingString $token]]
          if {[string length $testString] > $maxCharLength} {
            # back token_id up by 1, back up token 
	    # keep the testString as is, since this will cause the while loop condition to fail, and while loop will end
            incr token_id -1
            set token [lindex $origList $token_id]
          } else {
	    set workingString $testString
 	  }
        };# array item is past maxCharLength
	set returnArr($index) "$returnArr($index) [::FFF::flatten_list [list $workingString ]] \\"
      } else {
	set returnArr($index) "$returnArr($index) [::FFF::flatten_list [list $token ]] \\"
        incr token_id
        set token [lindex $origList $token_id]
      }
      #set returnArr($index) "$item \\"
      incr index
      set returnArr($index) ""
    };# end while

    # Determine first line:
    switch -exact -- $myBraceType {
      curly { 
	set returnArr($index) "\}" 
      }
      quote { 
        set returnArr($index) "\""
      }
    }

    return [array get returnArr]
  }; #end proc
};# end namespace
##############################################################################
#  Copyright (c) 1997-[clock format [clock seconds] -format %Y] Cadence Design Systems, Inc #
#             Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [misc.tcl]                                                    #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {
  proc getProcName {} {
    set name [lindex [info level -1] 0]
    set index [string last ">" $name]
    if {$index != -1} {
       set name [string range $name [incr index] end]
    }
    set index [string last ":" $name]
    if {$index != -1} {
       set name [string range $name [incr index] end]
    }
    return $name
  }
}
##############################################################################
#  Copyright (c) 1997-[clock format [clock seconds] -format %Y] Cadence Design Systems, Inc #
#             Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [misc.tcl]                                                    #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {
  proc strip_elab_and_colon_prefix {arg} {
    regsub {::FFF::elabdb::} $arg {/} arg
    regsub {::} $arg {/} arg
    return $arg
  }
}
##############################################################################
#  Copyright (c) 1997-[clock format [clock seconds] -format %Y] Cadence Design Systems, Inc #
#             Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [misc.tcl]                                                    #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
# Utilities for LINT checking (required by lint.tcl)
# Adapted from cpfreader.tcl, build date 6-14-2011
namespace eval FFF {

  proc is_neg_num {str} {
      set is_neg 0;
      if {$str ne ""} {
        if { [string index $str 0] ne "-" } {
            return $is_neg;
        }
        set num [lindex [split $str ":"] 0];
        if { [string index $num 0] eq "-" } {
            set is_neg [string is double [string range $num 1 end]];
        }
        return $is_neg;
      }
      return $is_neg;	 
  }

  proc is_an_integer {num} {
      set epsilon 1.0e-6;
      set roundnum [expr {round($num)}];
      if { $roundnum < $num+$epsilon && $roundnum > $num-$epsilon } { return true; }
      return false;
  }

  proc need_braces_for_esc_backslash {arg} {
      if { [regexp {\\[\w/]} $arg] } {
          return true;
      } else {
          return false;
      }
  }

  proc need_to_split_option_value_pair {optionName} {
      if {$optionName eq "-domain_conditions" || $optionName eq "-domain_corners" || $optionName eq "-active_state_condition"} {
          return "@";
      }
      return "";
  }

  proc need_braces_for_esc {arg} {
      if { [regexp {\\\w} $arg] } {
          return true;
      } else {
          return false;
      }
  }

  proc strip_extra_spaces {line} {
      set linestr $line;
      regsub -all { {1,}|\t{1,}} $linestr " "    linestr;
      regsub -all { {1,}}        $linestr " "    linestr;
      return $linestr;
  }
  
  proc strip_line_quotes_and_braces {line} {
      set linestr $line;
      regsub -all {[\"\{\}]} $linestr "" linestr;
      return $linestr;
  }
  
  proc strip_leading_hier_seps { str } {
      variable hierarchy_separator;
      variable current_scope_level;
      set hs $hierarchy_separator($current_scope_level);
      if { $hs eq "." || $hs eq "+" } {
          set pat1 "\{\\s*\\$hs";
          set pat2 "^\\s*\\$hs";
          # set pat3 "\\s+\\$hs";
          set pat4 "(\[(@!&|^~\ ])\\s*\\$hs";
      } else {
          set pat1 "\{\\s*$hs";
          set pat2 "^\\s*$hs";
          # set pat3 "\\s+$hs";
          set pat4 "(\[(@!&|^~\ ])\\s*$hs";
      }
      set res "";
      regsub -all $pat1 $str \{ res;
      regsub -all $pat2 $res {} res;
      #regsub -all $pat3 $res { } res;
      regsub -all $pat4 $res {\1} res;
      set res [string trimleft $res];
      set res [string trimright $res];
  
      return $res;
  }

  proc is_list { str } {
      if { [regexp {.\s+.} $str] } {
          return true;
      } else {
          return false;
      }
  }


  proc strip_leading_hierarchy_separator {optionName arg {check_keep 1}} {
      variable hierarchy_separator;
      variable current_scope_level;
      variable current_command;
      variable keep_leading_hierarchy_separator;
  
      if { [string match *file* $optionName] } { return $arg; }
      if { [string match *libraries* $optionName] } { return $arg; }
      if { [string match define_library_set $current_command] } { return $arg; }
      if { $current_scope_level < -1 } { return $arg; }
      if { $check_keep && $keep_leading_hierarchy_separator } { return $arg; }
  
      if { [regexp -all {\{} $arg] != [regexp -all {\}} $arg] } {
          ::FFF::fcfqc::lint_message warn CPF-LINT-246 $optionName;
      }
      set hs $hierarchy_separator($current_scope_level);
      if { [string equal $arg [lindex $arg 0]] } {
          set argitem [lindex $arg 0];
          set split_char [need_to_split_option_value_pair $optionName];
          if { $split_char ne "" } {
              set pair [split $argitem $split_char];
              set first  [strip_leading_hier_seps [lindex $pair 0]];
              set second [strip_leading_hier_seps [lindex $pair 1]];
              return "$first$split_char$second"
          }
          if { $argitem ne "" && $argitem != $hs && ![string is double $argitem] } {
              return [strip_leading_hier_seps $argitem]
          }
  
          return $argitem;
      } else {
          set newarg "";
          if { [::FFF::need_braces_for_esc $arg] && [llength $arg] <= 1 } {
              set arg \{$arg\}
          }
  
          foreach argitem $arg {
              set newitem [strip_leading_hier_seps $argitem];
              if { [is_list $newitem] && ![::FFF::need_braces_for_esc $newitem] } {
                  lappend newarg $newitem;
              } elseif { [is_list $newarg] } {
                  set newarg [string trimright $newarg];
                  append newarg " $newitem " ;
              } else {
                  append newarg "$newitem ";
              }
          }
          regsub -all {^ {1,}| {1,}$} $newarg "" newarg;
          regsub -all {\( } $newarg "(" newarg;
          regsub -all { \)} $newarg ")" newarg;
          return $newarg;
      }
  }

};# End namespace eval FFF (utils for lint checking)
namespace eval FFF {
  namespace export Puts
  proc Puts {args} {
    set re \{(.*)\}
    if {[regexp $re $args full match]} {
      puts $match
    } else {
      puts $args
    }
  }
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [create_configuration.tcl]                                       #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################

###############################################################
# create_configuration
# Usage: set_configuratoin <config_name> {variable list}
# @Return: Configuration Object ID
###############################################################

namespace eval FFF {
  namespace export create_configuration
  # Define proc in FFF namespace
  proc create_configuration {args} {
    puts "create_configuration() Warning: This command will be obsolete in a future release."
    puts "Please use 'set_configuration' instead."
    set dbgPrefixWs [string repeat " " [info level]]
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}create_configuration(API) BEGIN"}
    #puts "calling create_configuration ..."
    #create_configuration $args

    set Debug $::FFF::Debug
    set configName [lindex $args 0]

    if {[llength $configName] > 1} {
      puts "create_configuration ERROR: Name detected is: $configName, which is illegal."
      puts "create_configuration ERROR: Usage: create_configuration <name> { block of set statements}"
      puts "create_configuration ERROR: Contact the Author if you have received this message in error."
      puts "Exiting ..."
      exit 1
    }
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}create_configuration(API): Processing configuration $configName"}

    set args [lrange $args 1 end]
    # Temporarily removing this, so we keep the curly
    #####while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $args full args ]} {
    #####};# end while

    #set args [split $args "\n"]
    array set local_arr {}

#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}create_configuration(API): Config name: $configName"}
    # Process configuration
    if {$configName ne ""} {
      # We have a config name (which is required for now)
      if {[get_config $configName] eq ""} {
        # Configuration does not exist, so create namespace and then configuration object inside namespace
      
        set configObjID [new Configuration $configName $args]
        $configObjID->update_vars $args
        set ::FFF::config_objid_list($configName) $configObjID

      } else {
        # Need to fix this, if the stuff above works
        set configObjID [get_config $configName]
        $configObjID->update_vars $args
      }
    } else {
      puts "ERROR: create_configuration requires a name be supplied for the config"
      return -1
    }
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}create_configuration(API) END"}
  };# end proc create_configuration
}
namespace eval FFF {
  proc init_create_configuration {} {
    namespace eval ${::FFF::elabns} {
      if {![llength [info commands create_configuration]]} {
        namespace import ::FFF::create_configuration
      }
    }
  }
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [create_flow.tcl]                                         #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################

###############################################################
# create_flow
# Usage: create_flow <flow_name> {flow text}
# @Return: Flow Object ID
###############################################################

namespace eval FFF {
  
  namespace export create_flow

  proc create_flow {args} {
    if {[catch {
    set dbgPrefixWs [string repeat " " [info level]]
    set commandName create_flow
    set msgPrefix "${dbgPrefixWs}${commandName}:"

    set Debug $::FFF::Debug
    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}/ - - - - - - - - - - - create_flow() BEGIN - - - - - - - - - - - - - - /"}

    set returnStatus ""
    set parse_options_args_list {}
    set param_args_list {}
    variable paramArray

    set myFlowName [lindex $args 0]

    set myFlowObjID ""
    set myInstanceName ""
    set dash_args_list {}
    set parse_options_args_list {}
    set param_args_list {}
    set flowBlock {}
    set paramConfigObjID ""
    set flowRedefined 0

    set origFlowArgs [lrange $args 1 end]

    #
    # Some basic args checking (more robust solution tbd)
    #
    if {[llength $myFlowName] > 1} {
      puts "${commandName} ERROR CF3: $commandName called with incorrect name argument"
      puts "Usage: $commandName <name> \[-parameter <name>=<value> ...\] { block}"
      puts "Exiting ..."
      exit 1
    } elseif {[llength $myFlowName] == 1} {
      set msgPrefix "${dbgPrefixWs}${commandName}($myFlowName):"
    } else {
      puts "${commandName} ERROR CS1: $commandName called w/out name argument."
      exit 1
    }

    #
    # Define the dynamic proc to execute the flow block commands
    #
    set flow_proc_name $myFlowName
    proc $myFlowName {args} {
      ::set dbgPrefixWs [string repeat " " [info level]]
      ::set msgPrefix "${dbgPrefixWs}create_flow generated proc():"

      # Calling scope (for hierarchical flows)
      upvar 1 myFlowObjID flowObjID

      upvar 1 Debug Debug
      upvar 1 paramArray paramArray_local
      variable vars

      # This can probably be eliminated...
      while {[string match -* [lindex $args 0]] } {
        set option [lindex $args 0]
        set args [lrange $args 1 end]
        switch -exact -- $option {
          -name {
            set flowName [lrange $args 0 0]
            set args [lrange $args 1 end]
          }
        }
      }

      # Clean up the args block
      while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $args full args ]} { }

      #
      # Resolve default and the configuration-bound parameters
      #
      if {[array size paramArray_local] > 0} {
        #
        # Check parameters defined in calling scope. These are default parameters
        #
        foreach param [array names paramArray_local] {
          set evalCmd "::set $param  $paramArray_local($param)"
          eval $evalCmd
        }
        #
        # Check parameters defined in bound configurations
        # Note - we will automatically overwrite any defaults set above
        #
        foreach param [array names paramArray_local] {
          set resolvedValue [::FFF::flatten_list [$flowObjID->resolve_var $param]]
          set evalCmd "::set $param  $resolvedValue"
          eval $evalCmd
        }
      }

      ::FFF::dbg_puts "Executing block commands for flow: $flowName"
      #
      # This is how we "parse" the flow block: use tcl eval
      #
      eval $args
    };# end generated proc


    # #####################################################################
    # The following block processes dash args and extracts the parameter block
    # #####################################################################
    #
    # Pull out name first (default is anonymous)
    # Separate block from dash args
    # Create $FlowBlock (the block) and $dash_args_list (to be passed to parse_options)
    set token [lindex $origFlowArgs 0]
    while {$token ne ""} {
      if { [string match -* $token] } {
        if { $token eq "-parameter" || $token eq "-param" || $token eq "-parameter_map" } {
          lappend param_args_list $token
          lappend param_args_list [lrange $origFlowArgs 1 1]
          set origFlowArgs [lrange $origFlowArgs 2 end]
        } else {
          set origFlowArgs [lrange $origFlowArgs 1 end]
        }
      } else {
        # else this is not a dash argument, but it's a list of more than 1 element, so we assume it is the flow block
        lappend flowBlock $token
        set origFlowArgs [lrange $origFlowArgs 1 end]
      }
      set token [lindex $origFlowArgs 0]
    }
    set msgPrefix "${dbgPrefixWs}${commandName}:($myFlowName):"

    # ################ END dash arg processing ############################


    #
    #                  Parameter Processing
    #
    array set paramArray {}
    set index 0
    set token [lindex $param_args_list $index]
    while {$token ne ""} {
       set paramMap [lindex $param_args_list [incr index]]
       switch -exact -- $token {
         -parameter_map {
           set paramName [lindex [::FFF::flatten_list $paramMap] 0]
           set paramValue [list [lrange [::FFF::flatten_list $paramMap] 1 end]]
           if {$paramValue eq "{{}}" } {
             set paramValue {""}
           }
           set paramArray($paramName) $paramValue
         }
       };# end switch
      incr index
      set token [lindex $param_args_list $index]
    };# end while

    if {$myFlowName eq ""} {
      puts "${commandName} ERROR CF4: create_flow called w/out name argument."
      exit 1
    }
    # ################ END Parameter processing ###########################

    #
    # Check for existing flows instances with same basename
    #
    set flowInstanceObjIDs [get_flow -instances -basename ${myFlowName} -non_elab]

    #
    # Flow definition object only (i.e., previous create_flow command)
    # The presence of the following and the absence of the previous
    # indicates that this flow is a top level flow (it is not instantiated
    # anywhere, but nevertheless exists.
    #
    set flowDefinitionObjID [get_flow -basename ${myFlowName} -non_elab]
    
    ##################################################################      
    # Check parameter mapping passed to flow
    # Build parameter configurations as necessary
    ##################################################################      
    if { [array names paramArray] ne "" } {
      #
      # Create a new default parameter configuration.
      # Then populate the configuration with the variables extracted from the create_step args
      #
      set paramConfigObjID [new Configuration ${myFlowName}.defparam $args]
      foreach paramName [array names paramArray] {
        $paramConfigObjID->update_vars "set $paramName $paramArray($paramName)"
      }
      ##################################################################      
      # If there are no instances, create a new parameter config
      ##################################################################      
      if {$flowInstanceObjIDs ne "-1"} {
        ##################################################################      
        # Flow Instances Exist. For each flow instance, check if the parameter config exists. If not, create one; else add to it
        ##################################################################      
        # flow exists. Need to update existing configuration
        foreach flowObjID $flowInstanceObjIDs {
          $flowObjID->bind_to_param_config $paramConfigObjID
        }
      }
    }

    # ############### END parameter config creation ###################


    #
    # Reset the flow definition if one exists
    #
    if {$flowDefinitionObjID eq "-1"} {
      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} $myFlowName has never been created. Creating new Flow."}
      set myFlowObjID [new Flow $myFlowName]
      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Created new Flow ID ->$myFlowObjID<- of flow ->$myFlowName<-"}
      $myFlowObjID->set_base_name $myFlowName
      set ::FFF::flow_objid_arr($myFlowObjID) $myFlowName
    } else {
      #
      # This is an existing Flow that we are redefining.
      #
      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} $myFlowName has been created before. Overwriting previous definition."}
      #
      # We set the "myFlowObjID" variable, as this is the variable that the dynamic proc will upvar to
      #
      set myFlowObjID $flowDefinitionObjID
      #
      # Check if there are any stage instances defined for the flow. If so, we will delete these instances, as new stage instances
      # will be created when the flow block is executed.
      #
      if {[$myFlowObjID->get_stages] ne ""} {
        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} Stage Instances Currently in this flow:"}
        foreach stageInstObjID [$myFlowObjID->get_stages] {
          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}    [$stageInstObjID->get_name] ($stageInstObjID) .... DELETING THIS INSTANCE"}
	  array unset ::FFF::stageInst_objid_arr $stageInstObjID
	  set baseID [$stageInstObjID->upcast Stage]
	  delete $baseID 
	  array unset ::FFF::stage_objid_arr $baseID
        }
      }
      set flowRedefined 1
      $myFlowObjID->clear_stage_instance_arr
      $myFlowObjID->clear_flow_instance_arr
      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Reset the flow (unset head and tail of linked list)."}
    }
    if {$paramConfigObjID ne ""} {
      #
      # We created a parameter config earlier. Now need to update this new flow with the appropriate parameters
      #
      $myFlowObjID->bind_to_param_config $paramConfigObjID
    }
    #
    # We need to save the original ID as we may have to reset this variable
    # to process flow instances.
    #
    set myFlowDefinitionObjID $myFlowObjID
    #
    # Execute the dynamic proc
    #
    set returnStatus [$myFlowName -name $flow_proc_name $flowBlock]


    ##################################################################      
    # Reset the flow Instances if they exist
    ##################################################################   
    if {$flowInstanceObjIDs ne "-1"} {
      ##################################################################      
      # We have existing flows that match the basename. Need to update each flow
      ##################################################################      
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Found the following instances: ->$flowInstanceObjIDs<-"}
      if {$paramConfigObjID ne ""} {
        foreach flowObjID $flowInstanceObjIDs {
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} ->$myFlowName<- Processing flow instance: $flowObjID [$flowObjID->get_name]"}
          ##################################################################      
          # Bind each flow instance to the parameter config we created above
          ##################################################################      
          $flowObjID->bind_to_config $paramConfigObjID
          #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} bound parameter config $paramConfigObjID ([$paramConfigObjID->get_name]) to flow [$flowObjID->get_name] ($flowObjID) to resolve default parameters"}
        };# end foreach flow ...
      };# if $paramConfigObjID ne ""
      array set flowReportWarningArr {}
      foreach flowObjID $flowInstanceObjIDs {
        ##################################################################
        # Execute flow block under each flow object instance
        # The dynamic proc $myFlowName will upvar the variable $flowObjID.
        ##################################################################
        if {[$flowObjID->is_empty]} {
          # Flow block not yet populated, so simply execute the flow block
          set returnStatus [$myFlowName -name $flow_proc_name $flowBlock]
        } else {
          # Flow has at least one step. Reset head and tail, and warn user
          # that Flow is being redefined
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} NOTE: Redefining Flow [$flowObjID->get_name]"}
          if {![info exists flowReportWarningArr([$flowObjID->get_base_name])]} {
            puts "create_flow() NOTE: Redefining stages for Flow [$flowObjID->get_base_name]"
          }
          set flowReportWarningArr([$flowObjID->get_base_name]) 1
          $flowObjID->reset_steps
	  #
	  # Execute Dynamic Proc
	  # First, set the myFlowObjID variable, as the dynamic proc will upvar to it:
	  set myFlowObjID $flowObjID
          set returnStatus [$myFlowName -name $flow_proc_name $flowBlock]
        }
      };#end foreach flowObjID
    }; # end flowInstanceObjIDs is empty
    # Not possible any more, since create_flow now links to more than 1 instantiated flow
    #return $flowObjID
    if {$returnStatus eq "-1"} {
      puts "create_flow() ERROR: Error processing flow $myFlowName. Please examine the flow definition."
      puts "Exiting..."
      exit -1
    }
    if {$Debug} {puts $::FFF::DEBUG_OSTREAM ""}
    if {$flowRedefined == 0} {
      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} Stats for Created Flow $myFlowName:"}
    } else {
      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} Final Stats for Redefined Flow $myFlowName:"}
    }
    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} ##################################################"}
    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} ID: $myFlowDefinitionObjID"}
    if {[$myFlowDefinitionObjID->get_stages] ne ""} {
      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} Stage Instances in this flow:"}
      foreach stageInstObjID [$myFlowDefinitionObjID->get_stages] {
        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}    [$stageInstObjID->get_name] ($stageInstObjID)   [$stageInstObjID->get_size] Step(s)"}
	foreach stepID [$stageInstObjID->get_steps] {
          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}       [$stepID->get_name] ($stepID)   [$stepID->get_block_size] Line(s)"}
	}
      }
    }
    if {$flowInstanceObjIDs ne "-1"} {
      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} Flow Instances Updated with New Flow Definition:"}
      foreach flowObjID $flowInstanceObjIDs {
        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}    [$flowObjID->get_name] ($flowObjID)"}
      }
    }
    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} ##################################################"}
    if {$Debug} {puts $::FFF::DEBUG_OSTREAM ""}
    #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} END<-"}
    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}/ - - - - - - - - - - - create_flow() END - - - - - - - - - - - - - - /"}
  } errorMsg]} {
    dbg_puts -print_stdout "<FF> INTERNAL-ERROR: create_flow(). Stack Trace:\n$errorMsg"
    dbg_puts -print_stdout "<FF>                 Contact the Cadence Product Core Team for assistance."
  }
  };# end proc create_flow
};# end namespace eval FFF
namespace eval FFF {
  proc init_create_flow {} {
    namespace eval ${::FFF::nonelabns} {
      if {![llength [info commands create_flow]]} {
        namespace import ::FFF::create_flow
      }
    }
  }
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [create_stage.tcl]                                             #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################

namespace eval FFF {
  ###############################################################
  # create_stage
  # Usage: create_stage <stage_name> {stage text}
  ###############################################################
  namespace export create_stage

  proc create_stage {args} {
    if {[catch {
    set dbgPrefixWs [string repeat " " [info level]]
    set commandName create_stage
    set msgPrefix "${dbgPrefixWs}${commandName}:"

    set Debug $::FFF::Debug
    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}/ - - - - - - - - - - - create_stage() BEGIN - - - - - - - - - - - - - - /"}
    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} BEGIN"}

    set returnStatus ""
    set parse_options_args_list {}
    set param_args_list {}
    variable paramArray

    set myStageName [lindex $args 0]

    if {[llength $myStageName] > 1} {
      puts "${commandName} ERROR CS3: $commandName called with incorrect name argument"
      puts "Usage: create_stage <name> \[-parameter <name>=<value> ...\] { block}"
      puts "Exiting ..."
      exit 1
    } elseif {[llength $myStageName] == 1} {
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} create_stage called with name ->$myStageName<-"}
      set msgPrefix "${dbgPrefixWs}${commandName}($myStageName):"
    } else {
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} ERROR CS1: create_stage called w/out name argument. Exiting..."}
      puts "${commandName} ERROR CS1: create_stage called w/out name argument."
      exit 1
    }
    set myStageObjID ""
    set myInstanceName ""
    set dash_args_list {}
    set parse_options_args_list {}
    set param_args_list {}
    set stageBlock {}
    set paramConfigObjID ""

#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Extracting block, pararm_args, and parse_options_args"}
    set origStageArgs [lrange $args 1 end]

    ##################################################################      
    # Define the dynamic proc to execute the stage block commands
    ##################################################################      
    set stage_proc_name $myStageName
    proc $myStageName {args} {
      ::set dbgPrefixWs [string repeat " " [info level]]
      ::set msgPrefix "${dbgPrefixWs}create_stage generated proc():"

      # Before this procedure is called, the stageObjID must be set.
      # That's because insert_step relies upon stageObjID to determine the stage to insert itself into  
      # Likewise, insert_stage will rely on the same.
      upvar 1 myStageObjID stageObjID
      upvar 1 flowObjID flowObjID_local

      upvar 1 Debug Debug
      upvar 1 paramArray paramArray_local
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} BEGIN"}
#      #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} \$stageObjID is $stageObjID"}
#      #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} paramArray_local size: [array size paramArray_local]"}
#      #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} paramArray_local contents: ->[array get paramArray_local]<-"}
      variable vars

      # This can probably be eliminated...
      while {[string match -* [lindex $args 0]] } {
        set option [lindex $args 0]
        set args [lrange $args 1 end]
        switch -exact -- $option {
          -name {
            set stageName [lrange $args 0 0]
            set args [lrange $args 1 end]
          }
        }
      }

      # Clean up the args block
      while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $args full args ]} { }

      # #####################################################################
      # Resolve default and the configuration-bound parameters
      # #####################################################################
      if {[array size paramArray_local] > 0} {
        # #####################################################################
        # Check parameters defined in calling scope. These are default parameters
        # #####################################################################
        foreach param [array names paramArray_local] {
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Setting $param to $paramArray_local($param)"}
          set evalCmd "::set $param  $paramArray_local($param)"
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} evalCmd: ->$evalCmd<-"}
          eval $evalCmd
        }
        # #####################################################################
        # Check parameters defined in bound configurations
	# Note - we will automatically overwrite any defaults set above
        # #####################################################################
        foreach param [array names paramArray_local] {
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Attempting to reconcile $param from bound configurations"}
          set resolvedValue [::FFF::flatten_list [$stageObjID->resolve_var $param]]
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} ResolvedValue: $resolvedValue"}
          set evalCmd "::set $param  $resolvedValue"
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} evalCmd: ->$evalCmd<-"}
          eval $evalCmd
	}
      } else {
#       #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Note - no parameters used in this stage definition"}
      }

#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Executing block commands for stage $stageName, whose parent is ([$stageObjID->get_name])"}
#      #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} args: ->$args<-"}
      eval $args
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} END"}
    };# end generated proc

    # #####################################################################
    # The following block processes dash args and extracts the stage name
    # #####################################################################
    #
    # Pull out name first (default is anonymous)
    # Separate block from dash args
    # Create $stageBlock (the block) and $dash_args_list (to be passed to parse_options)
    set token [lindex $origStageArgs 0]
    while {$token ne ""} {
#      #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} processing token ->$token<-"}
      if { [string match -* $token] } {
        if { $token eq "-parameter" || $token eq "-param" || $token eq "-parameter_map" } {
          lappend param_args_list $token
          lappend param_args_list [lrange $origStageArgs 1 1]
          set origStageArgs [lrange $origStageArgs 2 end]
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} param_args_list ->$param_args_list<-"}
        } else {
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} WARNING: not a recognized option: ->$token<-"}
          set origStageArgs [lrange $origStageArgs 1 end]
        }
      } else {
        # else this is not a dash argument, but it's a list of more than 1 element, so we assume it is the stage block
        lappend stageBlock $token
#        #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} stageBlock ->$stageBlock<-"}
        set origStageArgs [lrange $origStageArgs 1 end]
      }
      set token [lindex $origStageArgs 0]
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} token at end: ->$token<-"}
    }
    set msgPrefix "${dbgPrefixWs}${commandName}:($myStageName):"

    # ################ END dash arg processing ############################


    # #####################################################################
    #                  Parameter Processing
    # #####################################################################
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Extracting parameters from param args->$param_args_list<-"}
    array set paramArray {}
    set index 0
    set token [lindex $param_args_list $index]
    while {$token ne ""} {
       set paramMap [lindex $param_args_list [incr index]]
#       #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Processing token: ->$token<- with possible paramMap: ->$paramMap<-"}
       switch -exact -- $token {
         -parameter_map {
#           if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Parameter Map: ->$paramMap<-"}
           set paramName [lindex [::FFF::flatten_list $paramMap] 0]
#           if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Parameter Name: ->$paramName<-"}
           set paramValue [list [lrange [::FFF::flatten_list $paramMap] 1 end]]
	   if {$paramValue eq "{{}}" } {
	     set paramValue {""}
#             if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Changed from empty set to empty string: Parameter Name: ->$paramValue<-"}
           }
#           if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Parameter Name: ->$paramValue<-"}
#             if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Found Parameter Map: paramName: \
                ->$paramName<- in stage shall be mapped to value: ->$paramValue<-"}
           set paramArray($paramName) $paramValue
         }
       };# end switch
      incr index
      set token [lindex $param_args_list $index]
    };# end while

    if {$myStageName eq ""} {
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} ERROR CS4: create_stage called w/out name argument. Exiting..."}
      puts "${commandName} ERROR CS4: create_stage called w/out name argument."
      exit 1
    }
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Finished Parameter processing."}
    # ################ END Parameter processing ###########################

    ##################################################################      
    # Check for existing stages instances with same basename
    ##################################################################      
    set stageInstanceObjIDs [get_stage -instances -basename ${myStageName} -non_elab]
    if {$stageInstanceObjIDs ne "-1"} {
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Found these stage Instance IDs with basename $myStageName ->$stageInstanceObjIDs<-"}
    } else {
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} No existing stage instances with basename $myStageName"}
    }

    ##################################################################      
    # Check for existing stages definition with same basename
    ##################################################################      
    set stageDefinitionObjID [get_stage -basename ${myStageName} -non_elab]

    if {$stageDefinitionObjID ne "-1"} {
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Found this stage Definition ID with basename $myStageName ->$stageDefinitionObjID<-"}
    } else {
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Stage never created."}
    }

    ##################################################################      
    # Check parameter mapping passed to stage
    # Build parameter configurations as necessary
    ##################################################################      
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Listing parameters passed (current ns: ->[namespace current]<-"}
    if { [array names paramArray] ne "" } {
      if {$Debug} {
        foreach paramName [array names paramArray] {
          #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Parameter Setting: ->$paramName<- mapped to ->$paramArray($paramName)<-"}
        }
      }
      set paramConfigObjID [new Configuration ${myStageName}.param $args]
      foreach paramName [array names paramArray] {
        $paramConfigObjID->update_vars "set $paramName $paramArray($paramName)"
      }
      ##################################################################      
      # If there are no instances, create a new parameter config
      ##################################################################      
      if {$stageInstanceObjIDs ne "-1"} {
        ##################################################################      
        # Stage Instances Exist. For each stage instance, check if the parameter config exists. If not, create one; else add to it
        ##################################################################      
 	# stage exists. Need to update existing configuration
        foreach stageObjID $stageInstanceObjIDs {
	  $stageObjID->bind_to_param_config $paramConfigObjID
	  set paramConfigObjID  [$stageObjID->get_param_config_id]
	}
      }
    }

    # ############### END parameter config creation ###################


    ##################################################################      
    # Reset the stage Definition if one exists
    ##################################################################      
    if {$stageDefinitionObjID eq "-1"} {
      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} $myStageName has never been created. Creating new Stage."}
      set myStageObjID [new Stage $myStageName]
      $myStageObjID->set_base_name $myStageName
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Created new Stage ID ->$myStageObjID<- of stage ->$myStageName<-, basename: [$myStageObjID->get_base_name]"}
      set ::FFF::stage_objid_arr($myStageObjID) $myStageName
    } else {
      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} $myStageName has been created before. Overwriting previous definition."}
      # This is an existing Stage that we are redefining.
      # We set the "myStageObjID" variable, as this is the variable that the dynamic proc will upvar to
      set myStageObjID $stageDefinitionObjID

      if {[$myStageObjID->get_steps] ne ""} {
#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} Step Instances Currently in this stage:"}
        foreach stepInstObjID [$myStageObjID->get_steps] {
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}    [$stepInstObjID->get_name] ($stepInstObjID)"}
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}    Removing ($stepInstObjID) from ::FFF::stepInst_objid_arr"}
          array unset ::FFF::stepInst_objid_arr $stepInstObjID
          set baseID [$stepInstObjID->upcast Step]
          delete $baseID
          array unset ::FFF::step_objid_arr $baseID
        }
      }

      $myStageObjID->clear_step_instance_arr
      $myStageObjID->reset_steps
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Reset the stage (unset head and tail of linked list)."}
    }
    if {$paramConfigObjID ne ""} {
      #
      # We created a parameter config earlier. Now need to update this new stage with the appropriate parameters
      #
      $myStageObjID->bind_to_param_config $paramConfigObjID
    }
    # We need to save the original ID as we may have to reset this variable
    # to process flow instances.
    #
    set myStageDefinitionObjID $myStageObjID

    #
    # Execute the dynamic proc
    #
    set returnStatus [$myStageName -name $stage_proc_name $stageBlock]

    if {$stageDefinitionObjID eq "-1"} {
      #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} $myStageName Defined ($myStageObjID)"}
    } else {
      #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} $myStageName Redefined ($myStageObjID)"}
    }

    ##################################################################      
    # Reset the stage Instances if they exist
    ##################################################################      
    if {$stageInstanceObjIDs ne "-1"} {
      #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Found the following Stage instances: ->$stageInstanceObjIDs<-"}
      if {$paramConfigObjID ne ""} {
        foreach stageObjID $stageInstanceObjIDs {
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} ->$myStageName<- Processing stage instance: $stageObjID [$stageObjID->get_name]"}
          ##################################################################      
          # Bind each stage instance to the parameter config we created above
          ##################################################################      
          $stageObjID->bind_to_config $paramConfigObjID
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} bound parameter config $paramConfigObjID ([$paramConfigObjID->get_name]) to stage [$stageObjID->get_name] ($stageObjID) to resolve default parameters"}
        };# end foreach stage ...
      };# if $paramConfigObjID ne ""
      array set stageReportWarningArr {}
      foreach stageObjID $stageInstanceObjIDs {
        ##################################################################
        # Execute stage block under each stage object instance
	# The dynamic proc $myStageName will upvar the variable $myStageObjID.
        # This in turn has been set to the loop variable $stageObjID
        ##################################################################
	set myStageObjID $stageObjID

	#
	# Error Checking if Stage is not empty
        if {![$myStageObjID->is_empty]} {
          # Stage has at least one step. Reset head and tail, and warn user
          # that Stage is being redefined
#	  if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} NOTE: Redefining Stage [$myStageObjID->get_name]"}
	  if {![info exists stageReportWarningArr([$myStageObjID->get_base_name])]} {
            puts "create_stage() NOTE: Redefining steps for Stage [$myStageObjID->get_base_name]"
          }
	  set stageReportWarningArr([$myStageObjID->get_base_name]) 1
	}

	#
	# We need to save the previous and next steps of the stage we are inserting into.
        # It is ok to insert a stage inside an empty stage.
	# After we process the stage block, we'll relink the stage
	#

	# BUDA: NOTE: need to add code for inserting a stage at the beginning of another stage...
	set StagePrevStepID [$myStageObjID->get_stage_prev_step]
	set StageNextStepID [$myStageObjID->get_stage_next_step]

	#
	# Reset the steps of the stage
        #
        $myStageObjID->clear_step_instance_arr
	$myStageObjID->reset_steps

	#
	# Execute the Stage Block
 	#
        set returnStatus [$myStageName -name $stage_proc_name $stageBlock]

	#
	# Set the saved prev and next steps
	#
	$myStageObjID->set_stage_prev_step $StagePrevStepID
	if {$StagePrevStepID ne $StagePrevStepID} {
	  $myStageObjID->set_stage_next_step $StageNextStepID
 	}
      };#end foreach stageObjID
    }; # end stageInstanceObjIDs is empty
    # Not possible any more, since create_stage now links to more than 1 instantiated stage
    #return $stageObjID
    if {$returnStatus eq "-1"} {
      puts "create_stage() ERROR: Error processing stage $myStageName. Please examine the stage definition."
      puts "Exiting..."
      exit -1
    }
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM ""}
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} Stats for Created Stage $myStageName:"}
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} ##################################################"}
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} $myStageName ($myStageDefinitionObjID)"}
    if {[$myStageDefinitionObjID->get_stages] ne ""} {
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} Stage Instances in this stage (first level of Stage hierarchy):"}
      foreach stageInstObjID [$myStageDefinitionObjID->get_stages] {
#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}    [$stageInstObjID->get_name] ($stageInstObjID)"}
      }
    }
    if {[$myStageDefinitionObjID->get_steps] ne ""} {
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} Step Instances in this stage definition (leaf level of Stage hierarchy):"}
      foreach stepInstObjID [$myStageDefinitionObjID->get_steps] {
#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}    [$stepInstObjID->get_name] ($stepInstObjID)"}
      }
    }
    if {$stageInstanceObjIDs ne "-1"} {
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} Instances of this Stage that were updated:"}
      foreach stageInstObjID $stageInstanceObjIDs {
#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}    [$stageInstObjID->get_name] ($stageInstObjID)"}
        if {[$stageInstObjID->get_steps] ne ""} {
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}    Step Instances in this stage instance:"}
          foreach stepInstObjID [$stageInstObjID->get_steps] {
            set configList ""
            foreach configID [::FFF::flatten_list [$stepInstObjID->get_configurations]] {
              lappend configList [$configID->get_name]
            }
            if {$configList ne ""} {
	      set configList "N/A"
	    }
#            if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}        [$stepInstObjID->get_name] ($stepInstObjID) Configs: $configList"}
            array set resParamConfigArr [$stepInstObjID->get_resolved_param_config_arr]
            array set resParamValueArr [$stepInstObjID->get_resolved_param_value_arr]
#            if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} resParamConfigArr for $stepInstObjID : [$stepInstObjID->get_resolved_param_config_arr]"}
#            if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} resParamValueArr for $stepInstObjID : [$stepInstObjID->get_resolved_param_value_arr]"}
            if {[array size resParamConfigArr] > 0} {
              set str1 "Parameter"
              set str2 "Value"
              set str3 "Configuration"
#              if {$Debug} {puts $::FFF::DEBUG_OSTREAM [format "$dbgPrefixWs    %-*s %-*s %-*s" 30 $str1 20 $str2 20 $str3]}
              foreach var [array names resParamConfigArr] {
                set str1 $var
                set str2 $resParamValueArr($var)
                set str3 [$resParamConfigArr($var)->get_name]
#                if {$Debug} {puts $::FFF::DEBUG_OSTREAM [format "$dbgPrefixWs    %-*s %-*s %-*s" 30 $str1 20 $str2 20 $str3]}
              }
            }
          }
        }
      }
    }
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} ##################################################"}
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM ""}
    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} Final Stage Contents for [$myStageDefinitionObjID->get_name]($myStageDefinitionObjID):"}
    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} ---------------------"}
      foreach stepInstObjID [$myStageDefinitionObjID->get_steps] {
        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}    [$stepInstObjID->get_name] ($stepInstObjID)"}
      }
    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} ---------------------"}
    #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} END<-"}
    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}/ - - - - - - - - - - - create_stage() END - - - - - - - - - - - - - - /"}
  } errorMsg]} {
    dbg_puts -print_stdout "<FF> INTERNAL-ERROR: create_stage(). Stack Trace:\n$errorMsg"
    dbg_puts -print_stdout "<FF>                 Contact the Cadence Product Core Team for assistance."
  }
  };# end proc create_stage
};# end namespace eval FFF
namespace eval FFF {
  proc init_create_stage {} {
    namespace eval ${::FFF::nonelabns} {
      if {![llength [info commands create_stage]]} {
        namespace import ::FFF::create_stage
      }
    }
  }
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [create_step.tcl]                                             #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################

namespace eval FFF {
  ###############################################################
  # create_step
  # Usage: create_step <step_name> {step text}
  ###############################################################
  namespace export create_step

  proc create_step {args} {
    if {[catch {
    set dbgPrefixWs [string repeat " " [info level]]
    set commandName create_step
    set msgPrefix "${dbgPrefixWs}${commandName}:"
    set stepRedefined 0
    set parse_options_args_list {}
    set param_args_list {}
    set myRequireAllVarsFlag 0
    set required_args_list {}
    set myRequireAllVarsSeverity ""

    set Debug $::FFF::Debug
    #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}/ - - - - - - - - - - - create_step() BEGIN - - - - - - - - - - - - - - /"}

    set myStepName [lindex $args 0]
    if {[llength $myStepName] > 1} {
      puts "${commandName} ERROR CS2: $commandName called with incorrect name argument"
      puts "Usage: create_step <name> \[-parameter <name>=<value> ...\] { block}"
      puts "Exiting ..."
      exit 1
    } elseif {[llength $myStepName] == 1} {
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} create_step called w name ->$myStepName<-"}
      set msgPrefix "${dbgPrefixWs}${commandName}($myStepName):"
    } else {
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} ERROR CS1: create_step called w/out name argument. Exiting..."}
      puts "${commandName} ERROR CS1: create_step called w/out name argument."
      exit 1
    }
    set myInstanceName ""
    set dash_args_list {}
    set parse_options_args_list {}
    set param_args_list {}
    set stepBlock {}
    set paramConfigObjID ""

#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Extracting block, pararm_args, and parse_options_args"}
    set origStepArgs [lrange $args 1 end]

    # #####################################################################
    # The following block processes dash args and extracts the step name
    # #####################################################################
    #
    # Pull out name first (default is anonymous)
    # Separate block from dash args
    # Create $stepBlock (the block) and $dash_args_list (to be passed to parse_options)
    set token [lindex $origStepArgs 0]
    while {$token ne ""} {
#      #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} processing token ->$token<-"}
      if { [string match -* $token] } {
        if { $token eq "-parameter" || $token eq "-param" || $token eq "-parameter_map" } {
          lappend param_args_list $token
          lappend param_args_list [lrange $origStepArgs 1 1]
          set origStepArgs [lrange $origStepArgs 2 end]
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} param_args_list ->$param_args_list<-"}
        } elseif { $token eq "-required_files" || $token eq "-required_vars" || $token eq "-require_all_vars" } {
          lappend required_args_list $token
	  if {$token eq "-require_all_vars"} {
#            if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} lrange result ->[lrange $origStepArgs 1 1]<-"}
#            if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} regexp result ->[regexp {error|warn|note} [lrange $origStepArgs 1 1]]<-"}
	    if {[regexp {error|warn|note} [lrange $origStepArgs 1 1]]} {
	      # The user specified the severity. Use it.
              lappend required_args_list [lrange $origStepArgs 1 1]
              set origStepArgs [lrange $origStepArgs 2 end]
	    } else {
	      # If the user didn't specify the severity as the second argument, use the default:
              lappend required_args_list $::FFF::myDefaultRequiredFilesSeverityLevel
              set origStepArgs [lrange $origStepArgs 1 end]
	    }
	  } else {
            lappend required_args_list [lrange $origStepArgs 1 1]
            set origStepArgs [lrange $origStepArgs 2 end]
	  }
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} required_args_list ->$required_args_list<-"}
        } else {
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} WARNING: not a recognized option: ->$token<-"}
          set origStepArgs [lrange $origStepArgs 1 end]
        }
      } else {
        # else this is not a dash argument, but it's a list of more than 1 element, so we assume it is the step block
        lappend stepBlock $token
#        #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} stepBlock ->$stepBlock<-"}
        set origStepArgs [lrange $origStepArgs 1 end]
      }
      set token [lindex $origStepArgs 0]
#      #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} token at end: ->$token<-"}
    }
    set msgPrefix "${dbgPrefixWs}${commandName}:($myStepName):"

    # ################ END dash arg processing ############################


    # #####################################################################
    #                  Parameter Processing
    # #####################################################################
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Extracting parameters from param args->$param_args_list<-"}
    array set paramArray {}
    set index 0
    set token [lindex $param_args_list $index]
    while {$token ne ""} {
       set paramMap [lindex $param_args_list [incr index]]
#       #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Processing token: ->$token<- with possible paramMap: ->$paramMap<-"}
       switch -exact -- $token {
         -parameter {
           puts "WARNING: This parameter syntax will be obsoleted in future versions of the Foundation Flow."
           puts "Please use the new syntax: -parameter_map {<name> <value>}"
           puts "Note - the new syntax supports passing lists as parameters."
           if {[regexp {(\S+)=(\S+)} $paramMap full paramName paramValue]} {
#             if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Found Parameter Map: paramName: \
                ->$paramName<- in step shall be mapped to value: ->$paramValue<-"}
             set paramArray($paramName) $paramValue
             #set param_args_list [lrange $param_args_list 1 end]
           } else {
             puts "ERROR: parameter specified incorrectly: ->$token $paramMap<-"
             puts "Usage: -parameter name=value"
             puts "Exiting ..."
             exit 1
           }
         }
        -param {
           puts "WARNING: This parameter syntax will be obsoleted in future versions of the Foundation Flow."
           puts "Please use the new syntax: -parameter_map {<name> <value>}"
           puts "Note - the new syntax supports passing lists as parameters."
           if {[regexp {(\S+)=(\S+)} $paramMap full paramName paramValue]} {
#             if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Found Parameter Map: paramName: \
                ->$paramName<- in step shall be mapped to value: ->$paramValue<-"}
             set paramArray($paramName) $paramValue
             #set param_args_list [lrange $param_args_list 1 end]
           } else {
             puts "ERROR: parameter specified incorrectly: ->$token $paramMap<-"
             puts "Usage: -parameter name=value"
             puts "Exiting ..."
             exit 1
           }
         }
         -parameter_map {
#           if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Parameter Map: ->$paramMap<-"}
           set paramName [lindex [::FFF::flatten_list $paramMap] 0]
#           if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Parameter Name: ->$paramName<-"}
           set paramValue [list [lrange [::FFF::flatten_list $paramMap] 1 end]]
	   if {$paramValue eq "{{}}" } {
	     set paramValue {""}
#             if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Changed from empty set to empty string: Parameter Name: ->$paramValue<-"}
           }
#           if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Parameter Name: ->$paramValue<-"}
#             if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Found Parameter Map: paramName: \
                ->$paramName<- in step shall be mapped to value: ->$paramValue<-"}
           set paramArray($paramName) $paramValue
         }
       };# end switch
      incr index
      set token [lindex $param_args_list $index]
    };# end while

    # ################ END Parameter processing ###########################

    ####################################################################################
    # Process required_args_list
    ####################################################################################
    #
    # Two arrays to attract severity for each file or variable
    #
    array set requiredFilesArr {}
    array set requiredVarsArr {}
    set index 0
    set token [lindex $required_args_list $index]
    while {$token ne ""} {
      set requiredFilesOrVarsMap [lindex $required_args_list [incr index]]
      #
      # Remove outer curlies and spaces
      #
      while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $requiredFilesOrVarsMap full requiredFilesOrVarsMap]} {}
      switch -exact -- $token {
        -required_files {
#           if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Required Files & (possibly) severity set: ->$requiredFilesOrVarsMap<- (length: [llength $requiredFilesOrVarsMap])"}
           if {[llength $requiredFilesOrVarsMap] == 2} {
             set requiredFilesList [lindex $requiredFilesOrVarsMap 0]
             set severity [list [lrange $requiredFilesOrVarsMap 1 end]]
#             if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Custom severity set for: ->$requiredFilesList<-: ->$severity<-"}
           } elseif {[llength $requiredFilesOrVarsMap] == 1} {
             set requiredFilesList [::FFF::flatten_list $requiredFilesOrVarsMap]
             set severity $::FFF::myDefaultRequiredFilesSeverityLevel
#             if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Note: No severity specified. Using default severity for: ->$requiredFilesList<-: $severity"}
           } else {
             puts "insert_step() ERROR: Illegal number of arguments passed to -required_files option."
             puts "   insert_step ... $token $requiredFilesOrVarsMap"
             puts "Usage: insert_step ... -required_files {<file list> <severity>}"
             exit 1
           }
           #
           # Remove outer curlies from file list
           #
           while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $requiredFilesList full requiredFilesList]} {}
           foreach fileOrVar $requiredFilesList {
             set requiredFilesArr($fileOrVar) $severity
#             if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Setting Missing severity for file ->$fileOrVar<- to: ->$severity<-"}
             #
             # We only add the variable in to the missing severity array if it matches the vars() regexp
             #
             if {[regexp {^\$vars\((.*)\)} $fileOrVar full key]} {
               set requiredVarsArr(vars($key)) $severity
#               if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Setting Missing severity for var ->vars($key)<- to: ->$severity<-"}
             }
           }
        }
        -required_vars {
#           if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Required Vars & (possibly) severity set: ->$requiredFilesOrVarsMap<- (length: [llength $requiredFilesOrVarsMap])"}
           if {[llength $requiredFilesOrVarsMap] == 2} {
             set requiredVarsList [lindex $requiredFilesOrVarsMap 0]
             set severity [list [lrange $requiredFilesOrVarsMap 1 end]]
#             if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Custom severity set for: ->$requiredVarsList<-: ->$severity<-"}
           } elseif {[llength $requiredFilesOrVarsMap] == 1} {
             set requiredVarsList [::FFF::flatten_list $requiredFilesOrVarsMap]
             set severity $::FFF::myDefaultRequiredVarsSeverityLevel
#             if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Note: No severity specified. Using default severity for: ->$requiredVarsList<-: $severity"}
           } else {
             puts "insert_step() ERROR: Illegal number of arguments passed to -required_vars option."
             puts "   insert_step ... $token $requiredFilesOrVarsMap"
             puts "Usage: insert_step ... -required_vars {<file list> <severity>}"
             exit 1
           }
           #
           # Remove outer curlies from file list
           #
           while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $requiredVarsList full requiredVarsList]} {}
           foreach fileOrVar $requiredVarsList {
             if {[regexp {^\$vars\((.*)\)} $fileOrVar full key]} {
               set requiredVarsArr(vars($key)) $severity
#               if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Setting Missing severity for var ->vars($key)<- to: ->$severity<-"}
             }
           }
        }
        -require_all_vars {
#           if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} All vars required. Setting severity to ->$requiredFilesOrVarsMap<-"}
           set myRequireAllVarsFlag 1
	   set myRequireAllVarsSeverity $requiredFilesOrVarsMap
        }
      };# end switch
      incr index
      set token [lindex $required_args_list $index]
    };# end while

#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Final required files settings: ->[array get requiredFilesArr]<-"}
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Final required vars settings: ->[array get requiredVarsArr]<-"}


    if {$myStepName eq ""} {
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} ERROR CS1: create_step called w/out name argument. Exiting..."}
      puts "${commandName} ERROR CS1: create_step called w/out name argument."
      exit 1
    }

    ##################################################################      
    # Check for:
    ##################################################################      
    #
    # existing step instances with same basename
    #
    set stepInstanceObjIDs [get_step -instances -basename ${myStepName} -non_elab]

    #
    # Step definition object only (i.e., previous create_step command)
    #
    set stepDefinitionObjID [get_step -basename ${myStepName} -non_elab]


    if {$stepInstanceObjIDs ne "-1"} {
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Found these step IDs with basename $myStepName ->$stepInstanceObjIDs<-"}
    } else {
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} No existing step instances with basename $myStepName"}
    }

    if {$stepDefinitionObjID ne "-1"} {
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Found this step ID with basename $myStepName ->$stepDefinitionObjID<-"}
    } else {
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Step never created."}
    }


    # #####################################################################
    #        Create Block array (to pass to Step object constructor)
    # #####################################################################
    #set stepBlock [lrange $stepBlock 1 end]
#    #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} stepBlock after stripping name: ->$stepBlock<-"}
    # Old:
    #while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $stepBlock full stepBlock ]} {} 
    # New:
    while {[regexp {^\{(.*)[[:space:]]*\}$} $stepBlock full stepBlock ]} {}

    set stepBlock [split $stepBlock "\n"]
    set argCount [llength $stepBlock]
    array set local_arr {}
#    #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} after split: stepBlock: ->$stepBlock<-"}
    if {$stepBlock ne ""} {
      set index 1
      set argNum 1
      foreach arg $stepBlock {
#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} analyze command line: ->$arg<-"}
	if {$index == 1 } {
	  if {$arg ne ""} {
            set local_arr($index) $arg
#            if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} saved line ->$arg<-"}
            incr index
          } else {
#            if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Ignoring first blank line"}
	  }
	} elseif { $argNum == $argCount } {
	  if {$arg ne ""} {
            set local_arr($index) $arg
#            if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} saved line ->$arg<-"}
            incr index
          } else {
#            if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Ignoring last blank line"}
	  }
        } else {	
          set local_arr($index) $arg
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} saved line ->$arg<-"}
          incr index
	}
	incr argNum
      }
      #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} done processing \$stepBlock"} 
    };# End if $stepBlock eq ""
    # ################ END Block array creation  #####################

    ##################################################################      
    # Check parameter mapping passed to step
    ##################################################################      
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Listing parameters passed (current ns: ->[namespace current]<-"}
    if { [array names paramArray] ne "" } {
      if {$Debug} {
        foreach paramName [array names paramArray] {
          #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Parameter Setting: ->$paramName<- mapped to ->$paramArray($paramName)<-"}
        }
      }
      #
      # Create a new default parameter configuration.
      # Then populate the configuration with the variables extracted from the create_step args
      #
      set paramConfigObjID [new Configuration ${myStepName}.defparam $args]
      foreach paramName [array names paramArray] {
#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Loading config [$paramConfigObjID->get_name] ($paramConfigObjID)  with variable $paramName set to $paramArray($paramName)"}
        $paramConfigObjID->update_vars "set $paramName $paramArray($paramName)"
      }

      if {$stepInstanceObjIDs ne "-1"} {
        ##################################################################      
 	# Step instances exist; need to push default configuration to each step's configuration list.
	# These are added using the "bind_to_config" member function.
	# After binding, we re-resolve parameters for the step
        ##################################################################      
        foreach stepObjID $stepInstanceObjIDs {
	  #
	  # Add this parameter config to the end of the parameter config list for each step instance
	  #
	  $stepObjID->bind_to_param_config $paramConfigObjID

	  # Note - we don't actually resolve parameters yet, as we may modify the step command block itself
	  # Therefore, parameter resolution happens after we process the step commands for each instance
        }
      }
    }

    # ############### END parameter config creation ###################

    ##################################################################      
    # Reset the step Definition if one exists
    ################################################################## 
    if {$stepDefinitionObjID eq "-1"} {
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} $myStepName has never been created. Creating new Step Definition."}
      set myStepObjID [new Step $myStepName]
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Created new Step ID ->$myStepObjID<- of step ->$myStepName<-"}
      $myStepObjID->set_base_name $myStepName
      set ::FFF::step_objid_arr($myStepObjID) $myStepName
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Added $myStepObjID to ::FFF::step_objid_arr"}
    } else {
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} $myStepName has been created before. Overwriting previous step definition."}
      # This is an existing Step that we are redefining.
      # We set the "myStepObjID" variable, as this is the variable that the dynamic proc will upvar to
      set myStepObjID $stepDefinitionObjID
      set stepRedefined 1
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Reset the step definition, set to new cmd block"}
    }
    #
    # Set the command block
    #
    $myStepObjID->set_cmd_block [array get local_arr]
    $myStepObjID->set_orig_cmd_block [array get local_arr]

    if {$paramConfigObjID ne ""} {
      #
      # We created a parameter config earlier. Now need to update this new step with the appropriate parameters
      #
      $myStepObjID->set_param_configurations $paramConfigObjID
      #
      # bind adds the config to the end of the stack (it will have lower priority than previous configs
      #
      $myStepObjID->bind_to_param_config $paramConfigObjID
      $myStepObjID->resolve_parameters_in_command_block
    }

    #
    # Add required vars / files to Step (if any already exist)
    #
    $myStepObjID->update_required_vars_arr [array get requiredVarsArr]
    $myStepObjID->update_required_files_arr [array get requiredFilesArr]

    #
    # Optionally set all vars required flag
    #
    if {$myRequireAllVarsFlag} {
      $myStepObjID->set_all_vars_required
      $myStepObjID->set_all_vars_required_severity $myRequireAllVarsSeverity
    }

    #
    # Set the create file name
    $myStepObjID->set_create_file ::FFF::fcfqc::current_filename

    #
    # We need to save the original ID as we may have to reset this variable
    # to process step instances.
    #
    set myStepDefinitionObjID $myStepObjID


    ##################################################################      
    # Reset the step Instances if they exist
    ##################################################################
    if {$stepInstanceObjIDs ne "-1"} {
      #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Found the following step instances: ->$stepInstanceObjIDs<-"}
      ##################################################################      
      # We have existing steps that match the basename. Need to update each step
      ##################################################################      
      # Logic
      # insert_step         -> create_step          ----> WARNING: Abnormal (everything is empty)
      # insert_step         -> create_step {block}  ----> No Note (Normal)
      # insert_step {block} -> create_step          ----> ERROR: Abnormal (Defined empty step that already had a defined block in the instantiation)
      # insert_step {block} -> create_step {block}  ----> ERROR: (overwriting insert_step cmd block)

      #
      # If we have a parameter configuration defined (default parameters)
      # we need to add the default parameters to the config list
      #
      
      array set stepReportWarningArr {}
      foreach stepObjID $stepInstanceObjIDs {
        ##################################################################      
        # INFO/WARNING/ERROR Messages for Step (re)creation
        ##################################################################      
#	if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} ->$myStepName<- Processing step instance: $stepObjID [$stepObjID->get_name]"}
#	if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Block size: [$stepObjID->get_block_size]"}

        if {[$stepObjID->get_block_size] == 0} {
          if {[array size local_arr] == 0} {
	    # Condition 1 (WARNING)
            ::FFF::dbg_puts -print_stdout "<FF> create_step: WARNING: step ->[$stepObjID->get_name]<- was created & inserted with an empty command block"
            ::FFF::dbg_puts -print_stdout "<FF> create_step: Define a command block in the create_step command. This step is currently empty."
          } else {
	    # Condition 2 (normal)
	  }
        } else {
          if {$stepRedefined == 0} {
	    if {[array size local_arr] == 0} {
	      # Condition 3 (ERROR)
	      ::FFF::dbg_puts -print_stdout "<FF> create_step: ERROR: step ->[$stepObjID->get_name]<- already instantiated with non-empty command block, and create_step has an empty command block"
	      puts "<FF> Existing command block:"
	      $stepObjID->print
	      ::FFF::dbg_puts -print_stdout "<FF> Create_step is not required if the step is defined using the insert_step command."
	      ::FFF::dbg_puts -print_stdout "<FF> Remove the create_step command, or move the command block from the insert_step command to the create_step command."
            } else {
	      # Condition 4 (ERROR)
              ::FFF::dbg_puts -print_stdout "<FF> create_step: ERROR: step ->[$stepObjID->get_name]<- already instantiated with non-empty command block, and create_step command block is also empty"
	      puts "<FF> Existing command block:"
	      $stepObjID->print
	      ::FFF::dbg_puts -print_stdout "<FF> Create_step is not required if the step is defined using the insert_step command."
	      ::FFF::dbg_puts -print_stdout "<FF> Remove the create_step command, or move the command block from the insert_step command to the create_step command."
	    }
	  }
        }

	#
	# Always update the step's cmd block and orig cmd block with the new block passed to the create_step command
        # User has been forewarned about overwrite issues (above)
        #
      	$stepObjID->set_orig_cmd_block [array get local_arr]
        $stepObjID->set_cmd_block [array get local_arr]
        #
        # Now that step commands have been (potentially) updated, resolve all parameters in each instance
	#
        if {$paramConfigObjID ne ""} {
          $stepObjID->resolve_parameters_in_command_block
        };# if $paramConfigObjID ne ""

        #
        # Add required vars / files
        $stepObjID->update_required_vars_arr [array get requiredVarsArr]
        $stepObjID->update_required_files_arr [array get requiredFilesArr]

        #
        # Optionally set all vars required flag
        #
        if {$myRequireAllVarsFlag} {
          $stepObjID->set_all_vars_required
          $stepObjID->set_all_vars_required_severity $myRequireAllVarsSeverity
        }

        #
        # Set the create file name
        $stepObjID->set_create_file ::FFF::fcfqc::current_filename

      };# end foreach stepInstanceObjIDs
    }; # end stepInstanceObjIDs ne "-1"
    # unset (reset) the local_arr
    array unset local_arr

    #if {[$myStepDefinitionObjID->get_param_configurations] ne ""} {
    #}
    #if {$paramConfigObjID ne ""} {
    #}

    array set reqVarSeverityArr [$myStepObjID->get_required_vars_severity_arr]
    array set reqFilesSeverityArr [$myStepObjID->get_required_files_severity_arr]
    if {[array size reqVarSeverityArr] > 0} {
      set str1 "Variable"
      set str2 "Missing (Var) Severity"
      foreach reqVar [array names reqVarSeverityArr] {
        set str1 $reqVar
	set str2 $reqVarSeverityArr($reqVar)
      }
    }
    if {$stepInstanceObjIDs ne "-1"} {
      foreach stepInstObjID $stepInstanceObjIDs {
	set configList ""
	foreach configID [::FFF::flatten_list [$stepInstObjID->get_configurations]] {
	  lappend configList [$configID->get_name]
	}
      }
    }
    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} Created [$myStepObjID->get_name] $myStepObjID"}
    #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}/ - - - - - - - - - - - create_step() END - - - - - - - - - - - - - - /"}
  } errorMsg]} {
    dbg_puts -print_stdout "<FF> INTERNAL-ERROR: create_step(). Stack Trace:\n$errorMsg"
    dbg_puts -print_stdout "<FF>                 Contact the Cadence Product Core Team for assistance."
  }
  };# end proc create_step
};# end namespace eval FFF
namespace eval FFF {
  proc init_create_step {} {
    namespace eval ${::FFF::nonelabns} {
      if {![llength [info commands create_step]]} {
        namespace import ::FFF::create_step
      }
    }
  }
}
namespace eval ::FFF {
  #set testMode Alpha
  set testMode Beta

  variable foundation_flow_applet [file normalize [info script]]
  variable debugfile ".fff_debug"
  variable Debug "0"
  variable fcf_version "1.0";
  variable supported_fcf_versions "1.0";
  variable tool_max_fcf_version [lindex $supported_fcf_versions end];
  variable default_fcf_version [lindex $supported_fcf_versions 0];

  variable DefaultAppBaseDir $env(HOME)/.cadence_applets/[::FFF::get_tool]/[::FFF::get_tool_version]
  variable DefaultCDNInternalAppsServerHostname splinter
  variable DefaultCDNInternalAppsServer "splinter:/applets/[::FFF::get_tool]/latest"
  variable DefaultExternalServerHostname ftp.cadence.com
  variable DefaultExternalAppsServer "ftp.cadence.com:/files/1240102498515"

  # The following are used by Step->print, Step->write_script, Configuration->print
  #variable maxLineLength "76"
  variable maxLineLength "10000"
  # This is the minimum token length to print on a single line byitself
  # in other words, we'll print this:
  # asdfg \
  # 12345 \
  # ...
  # but not this:
  # asdf \
  # 123 \
  # ...
  # instead:
  # asdf 123 \
  # ...
  variable minLengthPerSingleToken "5"
  variable verboseMessaging "0"

  variable myDefaultConfigName "FF_Default";
  variable nonelabns "::FFF::nonelabdb";
  variable elabns "::FFF::elabdb";
  variable elaborated_once "0"
  # The following are required, and are used by write_foundation / write_script / gen_exe_script:
  variable myDefaultScriptExt "tcl"
  variable myDefaultScriptType "tclsh"
  variable myDefaultExeScript "ff"
  variable myDefaultExeScriptType "make"
  variable myDefaultRequiredFilesSeverityLevel "error"
  variable myDefaultRequiredVarsSeverityLevel "error"

  variable myDefaultMissingFilesSeverityLevel "note"
  variable myDefaultMissingVarsSeverityLevel "note"

  variable vars
  array set vars {};
  variable tmpargs

  variable ellipsisCount 0

  variable FFFUserAPIs {
  }

  # ###########################################
  # This array is printed out when the user sources the script.
  # It is part of a welcome messag to indicate what apis are available
  # ###########################################
  variable user_api_commands {}
  lappend user_api_commands "read_foundation"
  lappend user_api_commands "report_foundation"
  lappend user_api_commands "write_foundation"
  lappend user_api_commands "write_foundation_template"
  lappend user_api_commands "get_flow"
  lappend user_api_commands "get_stage"
  lappend user_api_commands "get_step"
  lappend user_api_commands "get_var"
  lappend user_api_commands "report_steps"
  lappend user_api_commands "report_stages"
  lappend user_api_commands "reset_foundation"

  variable FFFCmdList { \
    get_config \
    create_flow \
    insert_flow \
    get_flow \
    create_stage \
    insert_stage \
    update_stage \
    get_stage \
    create_step \
    insert_step \
    get_step \
    get_var \
    set_fcf_version \
    set_tool \
  }
  namespace eval ${nonelabns} {} {
    # FCF/FDF Stubs (basically, ignore these commands)
    foreach cmd {set_configuration create_configuration} {
      eval {proc $cmd {args} { } };
    }
  }

}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [elaborate_foundation.tcl]                                       #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {
  namespace export elab_flow
  proc elab_flow { { FlowObjID "" } { parentNS ::FFF::elabdb } } {
    set dbgPrefixWs [string repeat " " [info level]]
    set msgPrefix "${dbgPrefixWs}[::FFF::getProcName]([$FlowObjID->get_name]):"
    set Debug $::FFF::Debug
    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix elaborating flow [$FlowObjID->get_name] ($FlowObjID)"}
  
    #
    # Generate Flow Instance Name
    #
    if {[info exists ${parentNS}::instance_count([$FlowObjID->get_name])]} {
      incr ${parentNS}::instance_count([$FlowObjID->get_name])                   
    } else {
      set ${parentNS}::instance_count([$FlowObjID->get_name]) 0
    }
    if {[set ${parentNS}::instance_count([$FlowObjID->get_name])] > 0} {
      set flowInstanceName [$FlowObjID->get_name]_i[set ${parentNS}::instance_count([$FlowObjID->get_name])]
    } else {
      set flowInstanceName [$FlowObjID->get_name]
    }
  #  if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix Name: [$FlowObjID->get_name], Base: [$FlowObjID->get_base_name], Instance Name: ${flowInstanceName}"}
    set flow_obj_elab_ns ${parentNS}::${flowInstanceName}
    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix Created NS: ${flow_obj_elab_ns}"}
  
    #
    # Set up namespace
    #
  
    namespace eval ${flow_obj_elab_ns} {
      set dbgPrefixWs [string repeat " " [info level]]
      set msgPrefix "${dbgPrefixWs}(namespace eval [namespace current])():"
      #set Debug $::FFF::Debug
      #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Defining flow objects in [namespace current]"}
  
      namespace import ::FFF::define_plugin_object
      namespace import ::FFF::define_plugin_instance_object
  
      variable flow_objid_arr
      array set flow_objid_arr ""
      define_configuration_object
      define_flow_object
      define_step_object
      ::FFF::define_plugin_object
      define_stage_object
      define_step_instance_object
      ::FFF::define_plugin_instance_object
      define_stage_instance_object
      define_stageiterator_object
    }
  
    # Create new object in namespace
    set elabFlowObjID  [new ${flow_obj_elab_ns}::Flow [$FlowObjID->get_name]]
  
    # Set new name
    $elabFlowObjID->set_name $flowInstanceName
  
    # Create array to track objects in namespace
    set ${flow_obj_elab_ns}::flow_objid_arr([$elabFlowObjID->get_name]) $elabFlowObjID
  
    # Copy object member data from original (uninstantiated) flow object to instantiated flow object
    $FlowObjID->copy_to $elabFlowObjID
  
    # Delete stage and flow arrays in copy (we will repopulate next)
    $elabFlowObjID->clear_stage_instance_arr
    $elabFlowObjID->clear_flow_instance_arr
    
    # DEBUG only:
    array set stageArr [$FlowObjID->get_stage_arr]
    dbg_puts "original flow object id and contents: $FlowObjID :"
    foreach stageObjID [lsort -dictionary [array names stageArr]] {
      dbg_puts "[$stageObjID->get_name] Length: [$stageObjID->get_size]"
      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix Elaborating stage [$stageObjID->get_name] ($stageObjID)  which consists of the following steps:"}
      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "- --------------------------------------------------------------------------------------- -"}
      set posIterator [$stageObjID->begin]
      while { [$posIterator->current] ne "NULL" } {
        set stepObjID [$posIterator->current]
        set stepName [$stepObjID->get_name]
        if {$Debug} {puts $::FFF::DEBUG_OSTREAM [format "$dbgPrefixWs    %-*s %-*s " 20 $stepName 50 $stepObjID ]}
        $posIterator->next
      }
      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "- --------------------------------------------------------------------------------------- -"}
    }


   
    dbg_puts "elab flow object id and contents: $elabFlowObjID :"
    array set stageArr [$elabFlowObjID->get_stage_arr]
    foreach stageObjID [lsort -dictionary [array names stageArr]] {
      dbg_puts "[$stageObjID->get_name] Length: [$stageObjID->get_size]"
      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix Elaborating stage [$stageObjID->get_name] ($stageObjID)  which consists of the following steps:"}
      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "- --------------------------------------------------------------------------------------- -"}
      set posIterator [$stageObjID->begin]
      while { [$posIterator->current] ne "NULL" } {
        set stepObjID [$posIterator->current]
        set stepName [$stepObjID->get_name]
        if {$Debug} {puts $::FFF::DEBUG_OSTREAM [format "$dbgPrefixWs    %-*s %-*s " 20 $stepName 50 $stepObjID ]}
        $posIterator->next
      }
      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "- --------------------------------------------------------------------------------------- -"}
    }

    # Process stageArr of original object, and populate new Flow object with elaborated stage objects
    array set stageArr [$FlowObjID->get_stage_arr]
  
    $elabFlowObjID->set_parent_path ${parentNS}
    #array set stageArr [$elabFlowObjID->get_stage_arr]
  
    #
    # Foreach stage in the flow, elaborate it
    #
    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} about to elaborate the following stages: [lsort -dictionary [array names stageArr]]"}
    if {$Debug} {
      foreach stageObjID [lsort -dictionary [array names stageArr]] {
        puts $::FFF::DEBUG_OSTREAM "${msgPrefix} [$stageObjID->get_name] Length: [$stageObjID->get_size]"
      }
    }
    foreach stageObjID [lsort -dictionary [array names stageArr]] {
      set stage_obj_id [elab_stage ${stageObjID} ${elabFlowObjID} ${flow_obj_elab_ns}]
      dbg_puts "ObjID returned from elab_stage: $stage_obj_id"
      if {$stage_obj_id ne "-1"} {
        set ::FFF::elabdb::stage_objid_arr($stage_obj_id) [$stage_obj_id->get_size]
        $elabFlowObjID->set_total_steps [expr {[$elabFlowObjID->get_total_steps] + [$stage_obj_id->get_size]}]
      } else {
        puts "elaborate_foundation(): Failed during elaboration of [$stageObjID->get_name]"
        return -1
      }
    }
  
    # Now that we have put copies in the elabdb, we clean up the instances in the nonelabdb (MAYBE)
    #       foreach stageObjID [array names mStageInstArr] {
    #         set baseID [$stageObjID->upcast Stage]
    #         #delete $stageObjID
    #         delete $baseID
    #       }
    #
  
  #  set design scope of flow_object
  #  set Makefile or shell script name & path
  #  foreach configuratoin (all configs){
  #    copy configuration variables to namespace
  #  }
  #  import fff functions into NS
  #  eval in flowobject NS {
  #    # Stage 2: hierarchical support
  #    foreach object $mflowArr {
  #      elab_flow $object
  #    }
  #  }
  #   if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix elab_flow(): Finished elaboration of flow [$FlowObjID->get_name]"}
  #   if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} END"}
     return $elabFlowObjID
  };# end proc
};# end namespace eval
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [elaborate_foundation.tcl]                                       #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {
  namespace export elab_stage
  proc elab_stage { { StageObjID "" } { TargetObjID "" } { parentNS ::FFF::elabdb:: } } {
    set dbgPrefixWs [string repeat " " [info level]]
    set msgPrefix "${dbgPrefixWs}[::FFF::getProcName]([$StageObjID->get_base_name]):"
    set Debug $::FFF::Debug
    
    if {[$StageObjID->is_empty]} {
      puts "elaborate_foundation(): ERROR: stage \"[$StageObjID->get_name]\" is empty (no command block defined at insert_stage, or there was no create_stage command issued for this stage)"
      puts "elaborate_foundation(): Define at least one step for stage \"[$StageObjID->get_name]\" or remove this stage from your flow."
      puts "elaborate_foundation(): Unable to elaborate stage [$StageObjID->get_name]."
      return -1
    } 
  
    #
    # Quick sanity check on what we are elaborating
    #
    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix Elaborating stage [$StageObjID->get_name] ($StageObjID)  which consists of the following steps:"}
    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "- --------------------------------------------------------------------------------------- -"}
    set posIterator [$StageObjID->begin]
    while { [$posIterator->current] ne "NULL" } {
      set stepObjID [$posIterator->current]
      set stepName [$stepObjID->get_name]
      if {$Debug} {puts $::FFF::DEBUG_OSTREAM [format "$dbgPrefixWs    %-*s %-*s " 20 $stepName 50 $stepObjID ]}
      $posIterator->next
    }
    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "- --------------------------------------------------------------------------------------- -"}
  
    #
    # Determine what the stage definition consists of for this stage instance
    #
    #puts "$StageObjID basename: [$StageObjID->get_base_name]"
    set stageDefinitionObjectID [::FFF::get_stage -non_elab -basename [$StageObjID->get_base_name]]
    #puts "stageDefinitionObjectID: $stageDefinitionObjectID" 
    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix Stage Definition Contents: [$stageDefinitionObjectID->get_name] ($stageDefinitionObjectID)  which consists of the following steps:"}
    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "- --------------------------------------------------------------------------------------- -"}
    set posIterator [$stageDefinitionObjectID->begin]
    while { [$posIterator->current] ne "NULL" } {
      set stepObjID [$posIterator->current]
      set stepName [$stepObjID->get_name]
      if {$Debug} {puts $::FFF::DEBUG_OSTREAM [format "$dbgPrefixWs    %-*s %-*s " 20 $stepName 50 $stepObjID ]}
      $posIterator->next
    }
    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "- --------------------------------------------------------------------------------------- -"}
  
  
    if {[info exists ${parentNS}::instance_count([$StageObjID->get_base_name])]} {
      incr ${parentNS}::instance_count([$StageObjID->get_base_name]) 
    } else {
      set ${parentNS}::instance_count([$StageObjID->get_base_name]) 0
    }
  
    if {[set ${parentNS}::instance_count([$StageObjID->get_base_name])] > 0} {
      set stageInstanceName [$StageObjID->get_base_name]_i[set ${parentNS}::instance_count([$StageObjID->get_base_name])]
    } else {
      set stageInstanceName [$StageObjID->get_base_name]
    }
    set msgPrefix "${dbgPrefixWs}[::FFF::getProcName]($stageInstanceName):"
  
    set stage_obj_elab_ns ${parentNS}::${stageInstanceName}
  
    #
    # Define a namespace for the stage object to be elaborated in
    #
    namespace eval $stage_obj_elab_ns {
      namespace import ::FFF::define_plugin_object
      namespace import ::FFF::define_plugin_instance_object
      set dbgPrefixWs [string repeat " " [info level]]
      set msgPrefix "${dbgPrefixWs}(namespace eval [namespace current])():"
  
      variable stage_objid_arr
      array set stage_objid_arr {}
      define_configuration_object
      define_step_object
      ::FFF::define_plugin_object
      define_stage_object
      define_step_instance_object
      ::FFF::define_plugin_instance_object
      define_stage_instance_object
      define_stageiterator_object
      define_flow_object
    }
  
    #
    # Create a new stage instance in the created namespace
    # Then specify the elab stage ID in the stage_objid_arr array
    #
    set elabStageObjID  [new ${stage_obj_elab_ns}::StageInst [$StageObjID->get_name]]
    set ${stage_obj_elab_ns}::stage_objid_arr([$elabStageObjID->get_name]) $elabStageObjID
  
    #
    # Populate (copy) the following items from the source stage object to the elaborated object
    #
    $elabStageObjID->set_configurations 		[$StageObjID->get_configurations]
    $elabStageObjID->set_tool 		       	[$StageObjID->get_tool]
    $elabStageObjID->set_tool_args 	      	[$StageObjID->get_tool_args]
    $elabStageObjID->set_base_name 		[$StageObjID->get_base_name]
    $elabStageObjID->set_script_name 		[$StageObjID->get_script_name]
    $elabStageObjID->set_print_stage_header_flag	[$StageObjID->get_print_stage_header_flag]
  
    # Note - probably no longer necessary to rename the instantiated object, since we keep track of the instance name separately
    # However, need to check all references to mName and make sure it's not used post-elaboration as a reference to the instance name
  
    $elabStageObjID->set_name 			${stageInstanceName}
    $elabStageObjID->set_instance_name 		${stageInstanceName}
    $elabStageObjID->set_parent_path 		${parentNS}
  
    #
    # Internal messaging
    #
    if {[$TargetObjID->typeid] eq "Flow"} {
      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}Instantiating Stage ${StageObjID} in Flow ${TargetObjID}"}
    } elseif {[$TargetObjID->typeid] eq "Stage"} {
      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}Instantiating Stage ${StageObjID} in Stage ${TargetObjID}"}
    }
  
    #
    # Insert the elaborated stageobject into it's parent
    #
    $TargetObjID->insert_stage $elabStageObjID
  
  #  copy $stageObject to ::FFF::elabdb
  #  set stage hier path to object (i.e., /flow1/stage1)
  #  set design scope of stage_object
  #  set namespace for stageobject
  #  set tool script name & path
  #  foreach configuration (all parent configs){
  #    copy configuration variables to namespace
  #  }
  #  import fff functions into NS
  #  eval in stageobject NS {
  #    # Stage 2: hierarchical support
  #    foreach object $mStageArr {
  #      elab_stage $object
  #    }
  #  }
  
  
     # Clear head and tail of new stage, and reset size
  
     $elabStageObjID->set_head [new ${stage_obj_elab_ns}::Step "FAKEHEAD" ]
     $elabStageObjID->set_tail [new ${stage_obj_elab_ns}::Step "FAKETAIL" ]
     $elabStageObjID->set_size 0
  
  #   if {$Debug} {puts $::FFF::DEBUG_OSTREAM ""}
  #   if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix Steps to be Elaborated in Stage $StageObjID : (Namespace: ${stage_obj_elab_ns})"}
     set posIterator [$StageObjID->begin]
     while { [$posIterator->current] ne "NULL" } {
       set origstepObjID [$posIterator->current]
       set stepName [$origstepObjID->get_name]
  #     if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$dbgPrefixWs    $stepName ($origstepObjID)"}
       $posIterator->next
     }
  #   if {$Debug} {puts $::FFF::DEBUG_OSTREAM ""}
  
     # Elaborate all steps
     array set elabStepTrackArr {}
  
     set posIterator [$StageObjID->begin]
  #   if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Iterator Created: $posIterator"}
  
     ::FFF::write_ellipsis -start
     while { [$posIterator->current] ne "NULL" } {
       set origstepObjID [$posIterator->current]
       set stepName [$origstepObjID->get_name]
       set step_obj_id [elab_step $origstepObjID ${elabStageObjID} ${stage_obj_elab_ns}]
       dbg_puts "ObjID returned from elab_step: $step_obj_id"
       set elabStepTrackArr($origstepObjID) $step_obj_id
       if {$step_obj_id ne "-1"} {
         if {[$step_obj_id->typeid] eq "PluginInst"} {
           set ::FFF::elabdb::plugin_objid_arr($step_obj_id) [$step_obj_id->get_name]
         } else {
           set ::FFF::elabdb::step_objid_arr($step_obj_id) [$step_obj_id->get_name]
         }
         $posIterator->next
       } else {
         puts "elaborate_foundation(): Failed during elaboration of [$origstepObjID->get_name]"
         return -1
       }
     }
  
     ::FFF::write_ellipsis -end
  
     #
     # Print some diagnostic data to the screen
     #
     set str1 Steps:
     set str2 [$elabStageObjID->get_size]
  
     puts "   /[$TargetObjID->get_name]/[$elabStageObjID->get_name]"
     puts [format "      %*s %*s" 6 $str1 13 $str2 ]
     #puts "      Steps:   [$StageObjID->get_size]"
  
  #   if {$Debug} {puts $::FFF::DEBUG_OSTREAM ""}
  #   if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$dbgPrefixWs ##########################################################"}
  #   if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix Stage Elaboration Result for Stage: [$elabStageObjID->get_name] ($elabStageObjID)"}
     set posIterator [$StageObjID->begin]
     while { [$posIterator->current] ne "NULL" } {
       set origstepObjID [$posIterator->current]
       set stepName [$origstepObjID->get_name]
       $posIterator->next
  #     if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$dbgPrefixWs    $stepName ($origstepObjID) -->  $elabStepTrackArr($origstepObjID)"}
     }
  #   if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$dbgPrefixWs ##########################################################"}
  #   if {$Debug} {puts $::FFF::DEBUG_OSTREAM ""}
  
  
  #  if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} END"}
    return $elabStageObjID
  };# end elab_stage
};# end namespace eval
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [elaborate_foundation.tcl]                                       #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {
  namespace export elab_step
  proc elab_step { { StepObjID "" } { TargetObjID "" } { parentNS ::FFF::elabdb:: } } {
    set dbgPrefixWs [string repeat " " [info level]]
    set msgPrefix "${dbgPrefixWs}[::FFF::getProcName]([$StepObjID->get_name]):"
    set Debug $::FFF::Debug
    if {[$StepObjID->is_empty]} {
        puts "elaborate_foundation(): ERROR: step \"[$StepObjID->get_base_name]\" is empty (no command block provided with insert_step, or create_step was not issued for this step"
        puts "elaborate_foundation(): Define at least one command for step \"[$StepObjID->get_base_name]\" or remove this step from your flow."
        puts "elaborate_foundation(): Unable to elaborate step [$StepObjID->get_base_name]."
        return -1
    }
    set baseName [$StepObjID->get_base_name]
    if {[info exists ${parentNS}::instance_count($baseName)]} {
      incr ${parentNS}::instance_count($baseName) 
    } else {
      set ${parentNS}::instance_count($baseName) 0
    }
  
    if {[set ${parentNS}::instance_count($baseName)] > 0} {
      set stepInstanceName ${baseName}_i[set ${parentNS}::instance_count($baseName)]
    } else {
      set stepInstanceName $baseName
    }
  
    # Define target namespace for step object
    set step_obj_elab_ns ${parentNS}
  #  if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix Name: [$StepObjID->get_name] Base: $baseName Instance name: ${stepInstanceName}"}
  
    #
    # Is this a Step or Plugin?
    #
    dbg_puts "Source Step name: [$StepObjID->get_name] ID: $StepObjID Type: [$StepObjID->typeid]"
    if {[$StepObjID->typeid] eq "PluginInst"} {
      set elabStepObjID  [new ${step_obj_elab_ns}::PluginInst ${baseName}]
    } else {
      # Create new step in target namespace
      set elabStepObjID  [new ${step_obj_elab_ns}::StepInst ${baseName}]
    }

    dbg_puts "New Elaborated Step name: [$elabStepObjID->get_name] ID: $elabStepObjID Type: [$elabStepObjID->typeid]"
  
    # Clopy head, tail, size, configs, tool, script_name:
    #  if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix Copying contents of current step [$StepObjID->get_name]($StepObjID) to new step [$elabStepObjID->get_name]($elabStepObjID)"}
    $StepObjID->copy_to ${elabStepObjID}
    if {[regexp {Plugin} [$StepObjID->typeid]]} {
      ${elabStepObjID}->set_plugin_cmd [${StepObjID}->get_plugin_cmd]
      # Copy the inline status
      ${elabStepObjID}->set_inline_status [${StepObjID}->get_inline_status]
    }
  
      # Uniquify / set instance name:
    $elabStepObjID->set_name ${stepInstanceName}
  
    # Set parent path
    $elabStepObjID->set_parent_path ${parentNS}
  
    # Set parent Stage
    $elabStepObjID->set_parent_stage $TargetObjID
  
    # ###########################################################################
    # If the step is a plugin, than we will try to resolve the plugin arguments here.
    # This involves re-writing the step_cmd_block
    # ###########################################################################
  
    #if {[$StepObjID->typeid] eq "PluginInst"} {
    #  #
    #  # Resolve variables used in load_plugin command
    #  #
    #  $elabStepObjID->resolve_plugin elaborate_foundation
    #}
  
    # Insert step into target
    $TargetObjID->insert_step $elabStepObjID
  
    #  set design scope of step_object
    #  set namespace for stepobject to parent stage namespace
    #
    # Analyze dependent variables in the step
    # For a plugin, this would be variables used in the load_plugin command invocation.
    # 
    set varlist [$elabStepObjID->analyze_dependent_vars]
  
  
    if {[$StepObjID->typeid] eq "PluginInst"} {
      #
      # Resolve (additional) vars in the plugin files themselves. Add these to the dependent vars list / unresolved vars list
      #
      $elabStepObjID->resolve_plugin_vars
  
      # Need to determine if the plugin is a file or proc
      # First, resolve the value of $vars(<plugin name>)
      set pluginFileOrProc [subst vars([$elabStepObjID->get_name])]
      
      # Second, determine if it's a file or a proc (file has precedence)
      if {![file isfile $pluginFileOrProc]} {
        # File doesn't exist. Check if it's a proc
        if {[info commands $pluginFileOrProc] ne ""} {
          $elabStepObjID->set_cmd_block "$pluginFileOrProc"
        }
      } else {
        $elabStepObjID->set_plugin_file $pluginFileOrProc
        $elabStepObjID->set_cmd_block "source $pluginFileOrProc"
      }
    }
  
    # Resolve all parameters
    if {[$elabStepObjID->get_param_configurations] ne ""} {
      $elabStepObjID->resolve_parameters_in_command_block
    }
  
    # Study what we can get from the step:
  
    namespace eval ${parentNS} {
      variable varBlock
    }
  
    # Code to check if the variable in the varlist (from the step) exists in the bound configurations
    foreach stepVar $varlist {
      set firstResolvedConfig ""
      foreach configObjID [$elabStepObjID->get_configurations] {
        if {$configObjID eq ""} {
          puts "elaborate_foundation() ERROR: NO Configuration bound to step [$elabStepObjID->get_name]."
          exit 1
        } elseif {[$configObjID->get_name] eq ""} {
          puts "elaborate_foundation() ERROR: Configuration: $configObjID bound to step [$elabStepObjID->get_name] has not been defined."
          puts "elaborate_foundation() ERROR: Create a configuration for [$elabStepObjID->get_name] using \"set_configuration $configObjID ...\""
          puts "elaborate_foundation() ERROR: Exiting ..."
          exit 1
        } else {
          set tracking_ns [$configObjID->get_var_tracking_namespace]
          set ns_var_list ${tracking_ns}::mVarArray
          set var_ns [$configObjID->get_var_namespace]
          if {[array exists ${var_ns}::$stepVar]} {
            set firstResolvedConfig $configObjID
  	  $elabStepObjID->add_resolved_config $configObjID
          } elseif {[info exists ${var_ns}::$stepVar]} {
            set firstResolvedConfig $configObjID
  	  $elabStepObjID->add_resolved_config $configObjID
          }
        }
      };# end foreach configObjID
      # Buda: disabled this warning for now (need to fix) 
      if {$firstResolvedConfig eq ""} {
        #puts "elaborate_foundation() WARNING: $stepVar was used in step [$elabStepObjID->get_name], but it is not defined in any of the bound configurations." 
        #puts "elaborate_foundation() WARNING: Configuration(s) bound to this step:"
        #foreach config  [$elabStepObjID->get_configurations] {
        #  set configName [$config->get_name] 
        #  puts $configName
        #}
        #puts "elaborate_foundation() WARNING: $stepVar will be printed unresolved in the resulting template script."
      }
    };# end foreach stepVar
   
   # elab_step Stats
   # get_resolved_vars_arr
  
    #
    # Check required files in Step
    #
    $elabStepObjID->analyze_required_files
    
    # Report Stats if in debug mode
    if {$Debug} {
      $elabStepObjID->report_stats
    }
  
  #  foreach variable in cmdArr {
  #    foreach stage { # hierarchical only
  #      foreach configuration {
  #	if overwriting "warn user"; then overwrite
  #	unless user forbids overwriting
  #        copy $variable to $variableArr
  #	# At this point, we are set up to execute elab_print
  #      }
  #    }
  #  }
  
    ::FFF::write_ellipsis
  
    return $elabStepObjID
  };# end proc
};# end namespace eval FFF
namespace eval FFF {
  proc init_create_configuration {} {
    namespace eval ${::FFF::elabns} {
      if {![llength [info commands create_configuration]]} {
        namespace import ::FFF::create_configuration
      }
    }
  }
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [elaborate_foundation.tcl]                                       #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {
  namespace export elaborate_foundation
  ##nagelfar ignore
  proc elaborate_foundation {args} {
    set dbgPrefixWs [string repeat " " [info level]]
    set msgPrefix "${dbgPrefixWs}[::FFF::getProcName]():"
    set Debug $::FFF::Debug
    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix BEGIN"}
    #
    # Check for any TCL LINT errors, and bail out of elaboration if any are found
    #
    foreach file [array names ::FF_LINT::tclLintErrorFile] {
      if {$::FF_LINT::tclLintErrorFile($file) > 0} {
        puts "<FF> Exiting code generation due to TCL LINT error in $file. Please correct this file and re-run codegeneration."
	puts "<FF> Errors:\n$::FF_LINT::tclLintErrorLog($file)"
	return -code error
      }
    }
 
    set ::FFF::fcfqc::current_command elaborate_foundation
    puts "Elaborating Foundation Database ..."
    # By definition, we are no longer reading foundation files...
    set ::FFF::still_reading 0

    #
    # Parse options
    # There are no elab options (yet). In the future we will allow partial elaboration of flow and design scopes,
    # in the case of complex flows.
    #
    switch -- [parse_options [calling_proc] {} $args \
      "-flow sOs flow to elaborate" flowToElab \
    ] {
        -2 { return }
         0 { return -code error }
    }

    # Created the elab namespace
    # BUDA: 6/24/2011 Force delete the elabdb namespace
    # This allows repeated applications of the elaborate_foundation command
    # In the future we need to allow flow-scoped elaboration (i.e., elaborate various stages and flows independently)
    namespace delete ::FFF::elabdb
    namespace eval ::FFF::elabdb {}
    ::FFF::init_elab_db
    ::FFF::init_set_wrapper_in_elabns
    ::FFF::init_create_configuration

    #
    # Add configs 
    #
    ##nagelfar ignore
    catch {set cwd [exec pwd]}
    if {[info exists ::FFF::vars(config_files)]} {
      foreach file $::FFF::vars(config_files) {
        lappend normConfigList [::FFF::relPathTo [file normalize $file] $cwd]
      }
      $::FFF::config_objid_list($::FFF::myDefaultConfigName)->update_vars "set vars(config_files) \"[::FFF::flatten_list $normConfigList]\""  
    }
 
    if {[array exists ::FFF::flow_objid_arr]} {
      # init error array
      set TotalStepCount 0
      foreach flowObjID [array names ::FFF::flow_objid_arr] {
        set top_flow_ns "::FFF::elabdb"
        set flow_obj_id [elab_flow $flowObjID $top_flow_ns]
	
        if {$flow_obj_id ne "-1"} {
	  set TotalStepCount [expr {[$flow_obj_id->get_total_steps] + $TotalStepCount}]
          set ::FFF::elabdb::flow_objid_arr($flow_obj_id) [$flow_obj_id->get_name]
        } else {
          puts "elaborate_foundation() ERROR: Elaboration failed attempt to elaborate flow [$flowObjID->get_name]"
          return -1
        }
      }
      # Write out each variable, preceding beginning of variable with 'set'
  
      # Next, create a default configuration using any variables populated in ::FFF::vars array:
      set defaultConfigVarArg {}
      foreach varEntry [array names ::FFF::vars] {
       lappend defaultConfigVarArg "set vars($varEntry) $::FFF::vars($varEntry)"
      }

      puts "  Flow elaboration ................ Done"
      puts "  Flow hierarchy summary:"

      puts [format "      %-*s %*s" 6 "Flow Instances: " 3 [array size ::FFF::elabdb::flow_objid_arr]]
      puts [format "      %-*s %*s" 6 "Stage Instances:" 3 [array size ::FFF::elabdb::stage_objid_arr]]
      puts [format "      %-*s %*s" 6 "Step Instances: " 3 [array size ::FFF::elabdb::step_objid_arr]]
      if {[array size ::FFF::elabdb::plugin_objid_arr] > 0} {
        puts [format "      %-*s %*s" 6 "Plugin Instances: " 1 [array size ::FFF::elabdb::plugin_objid_arr]]
      }
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$dbgPrefixWs Final Elab Stats:"}
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$dbgPrefixWs /----------------------------------------------------------------/"}
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$dbgPrefixWs Pre-elab Object Stats:"}
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$dbgPrefixWs ----------------------"}
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$dbgPrefixWs ::FFF::config_objid_list size: [array size ::FFF::config_objid_list]"}
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$dbgPrefixWs ::FFF::step_objid_arr size: [array size ::FFF::step_objid_arr]"}
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$dbgPrefixWs ::FFF::plugin_objid_arr size: [array size ::FFF::plugin_objid_arr]"}
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$dbgPrefixWs ::FFF::stage_objid_arr size: [array size ::FFF::stage_objid_arr]"}
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$dbgPrefixWs ::FFF::flow_objid_arr size: [array size ::FFF::flow_objid_arr]"}
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$dbgPrefixWs ::FFF::stepInst_objid_arr size: [array size ::FFF::stepInst_objid_arr]"}
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$dbgPrefixWs ::FFF::pluginInst_objid_arr size: [array size ::FFF::pluginInst_objid_arr]"}
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$dbgPrefixWs ::FFF::stageInst_objid_arr size: [array size ::FFF::stageInst_objid_arr]"}
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$dbgPrefixWs ::FFF::flowInst_objid_arr size: [array size ::FFF::flowInst_objid_arr]"}
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$dbgPrefixWs "}
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$dbgPrefixWs Final List of Elaborated Objects:"}
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$dbgPrefixWs ---------------------------------"}
    } else {
      puts "elaborate_foundation() ERROR: No Flows have been defined. Elaboration failed."
      exit 1
    }
  };# end proc elaborate_foundation
};# end namespace eval FFF

# In global ns, see if add_command_help exists. If not, import it...
if {![llength [info commands ::elaborate_foundation]]} {
    namespace import ::FFF::elaborate_foundation
    add_command_help elaborate_foundation "elaborate the Foundation Flow database"
}

##############################################################################
# Define aliases (just in case these are used in an rc script)
##############################################################################
if {![llength [info commands elaborat]]} {proc elaborat {args} {elaborate $args}}
if {![llength [info commands elabora]]}  {proc elabora {args} {elaborate $args}}
if {![llength [info commands elabor]]}   {proc elabor {args} {elaborate $args}}
if {![llength [info commands elabo]]}    {proc elabo {args} {elaborate $args}}
if {![llength [info commands elab]]}     {proc elab {args} {elaborate $args}}
if {![llength [info commands ela]]}      {proc ela {args} {elaborate $args}}
if {![llength [info commands el]]}       {proc el {args} {elaborate $args}}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [ConfigurationObject.tcl]                                         #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################

# Config - Foundation Flow Configuration
# A configuration consists of:
# Flow Variables
# Flow Definition Files
# Flow History
# Flow Metrics Db     
proc define_configuration_object {} {
  set dbgPrefixWs [string repeat " " [info level]]
  set msgPrefix "${dbgPrefixWs}[::FFF::getProcName]():"
  set Debug $::FFF::Debug
  #::FFF::dbg_puts "BEGIN"

  uplevel 1 {
    object Configuration {
      protected {
        var mName
        var mFlowDef
        var mFlowHistory
        var mMetricsDB
	# mArgs is the actual configuration data (set vars(netlist) ... etc. ) 
        var mArgs
	var mVarNamespace
	var mVarTrackingNamespace
        var mVarArr
	var mSetArgs
        var mPrettyCommand2Print
        var mOstream
        var mFile
      }
      ####################################################
      # Incorporating prettyprint function as part of this class, since
      #  1) We don't really use it too many other places
      #  2) We need to set variables in order to properly detect the length,
      #     especially when variables cannot be easily split (example is: set a {a b "c" d})
      ####################################################

      member list2prettyArr { origArgs } {
        set dbgPrefixWs [string repeat " " [info level]]
	set msgPrefix "${dbgPrefixWs}Configuration([$this->get_name])::list2prettyArr()"
        set myPathFix ""
	set myEscapedFlag 0
        switch -- [parse_options [calling_proc] {} $origArgs \
          "-path_fix sos \[normalize|relative\] how to handle path fixing" myPathFix \
          "-escaped bos Escape variable refs" myEscapedFlag \
          "-rundir sos Run directory" myRunDir \
          "sos list" var \
        ] {
          -2 { return }
          0  { error "Failed on [lindex [info level 0] 0]" }
        }

        # maxLineLength is the maximum length of characters a list should have on one line before breaking it into multiple lines"
	# Generate a random number to be used as a placeholder for double quotes
	# This is done because when we build the string, double quotes dissappear
	set randNum [expr {rand() * 1000000000000}]
	set randNumLen [string length $randNum]
	# Build the quote separator
	set quoteSeparator __[join [lrange [::FFF::flatten_list [split $randNum {}]] 0 [expr {$randNumLen - 3}]] ""]__
	set re "\""
        set maxLineLength $::FFF::maxLineLength

        
	# Use the quoteseparator to swap out quotes
	set tmp1 [set $var]
	regsub -all {\"} $tmp1 $quoteSeparator tmp2
	regsub -all $quoteSeparator $tmp2 $re args

        # Add backslashes if requested
        if {$myEscapedFlag} {
	  regsub -all {\$} $args {\$} args
        }

        #
        # Normalize entries in the list if requested
        #
        if {[info exists myPathFix] && $myPathFix ne ""} {
          switch -exact -- $myPathFix {
            normalize {
              set preNormArgs $args
	      unset args
              foreach item $preNormArgs {
                if {[file exists $item]} {
                  lappend args [file normalize $item]
                } else {
                  lappend args $item
                }
                puts "current args: ->$args<-"
              }
            }
            relative  {
              puts "INTERNAL ERROR: config->print relative referencing not supported. Exiting.."
            }
          }
        }

	# testing:
        set theListToPrint {}
        array unset returnArr
	set myBraceType ""

	set lineNum 0
        # This loop detects the brace type ( {block} or "block" ) used.
        # The first entry in the array (returnArr(0)) is set depending on the bracetype
        # For lists, this member function should be called with -bracetype curly
        # For non-list variables, this member function should be called with -bracetype quote
	# The remaining args are captured in the list $args
        if {[llength [::FFF::flatten_list [list [split $args {\" } ]]]] > 1 || [regexp {[\"]} $args] } {
          # it's either a list, or the value containts a double quote.
          # Either way, we'll put it in braces (regardless of how it was defined)
          set blockType curly
	} else {
	  # it's a single length value, or it doesn't contain double quotes, so it will go in double quotes
          set blockType quote
        }

        set stringLen [string length $args]
	if {$stringLen < $maxLineLength} {
          if {$blockType eq "curly"} {
            set returnArr($lineNum) "\{ $args \}" 
	  } elseif {$blockType eq "quote"} {
            set returnArr($lineNum) "\"$args\""
 	  }
	} else {
	  if {$blockType eq "curly"} {
            set returnArr($lineNum) "\{ \\"
	  } elseif {$blockType eq "quote"} {
            set returnArr($lineNum) "\" \\"
 	  }

	  # Process the string
          # Algorithm:
          # Until the end of the string
          #  Valid line breaks:
          #   1) Encountered a space after maxLineLength characters
          #   2) Encountered a space or double quote before maxLineLength, and a character or double quote after maxLineLength
          #      (in which case the line is broken at the previous space / double quote)
          #  ->Work on current line until a space or double quote is reached
          #  Until the maxLineLength is reached, or until a double quote is encountered, add the current character to the current line
          #   if a double quote is reached, create a substring and continue incrementing the char counter
          #   if a second double quote is reached, and char counter is < maxLineLength, add the entire substring into the current line
          #   if the maxLineLength is reached and the second double quote has not yet been encountered, close the current line, and begin a new line
          #    when the double quote is finally encountered, add the substring to the new line, and close the line
          #  
	  set currentLine ""
          set currentQuote ""
	  set lastDoubleQuotedChar ""
	  set lastSpaceChar ""
	  set currentLineStart 0
	  set currentLineEnd 0
	  set doubleQuoteCount 0
	  set nonSpaceCharEncountered 0
          set minLengthPerSingleToken $::FFF::minLengthPerSingleToken
          set minCharNum [expr {$minLengthPerSingleToken - 1}]
          set maxCharNum [expr {$currentLineStart + $minCharNum}]
	  #set maxCharNum [expr {$maxLineLength - 1}]

	  set pos 0
	  incr lineNum
	  while {$pos < $stringLen} {
            set currentChar [string index $args $pos]
	    if {$currentChar eq " "} {
	      if {$nonSpaceCharEncountered} {
	        set lastSpaceChar $pos
	      }
	    } else {
	      set nonSpaceCharEncountered 1
	    }
	    if {$currentChar eq "\""} {
	      set lastDoubleQuotedChar $pos
	      incr doubleQuoteCount
	    }

            # no double quotes encountered yet
            # simply break at last space before maxLineCount

	    if {$lastDoubleQuotedChar eq ""} {
	      # no double quotes encountered yet
	      # simply break at last space before maxLineCount
	      if {$pos >= $maxCharNum} {
	        # maxCharNum reached. Need to see if there are any spaces or quotes
#                if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix: pos: $pos = maxCharNum $maxCharNum, lastSpaceChar: $lastSpaceChar<-"}
	        if {$lastSpaceChar > $currentLineStart} {
	  	  # if there was a space in the current segment, we break at this space.
	          # otherwise we keep going ...
                  set returnArr($lineNum) "[string range $args $currentLineStart $lastSpaceChar] \\"
#                  if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix: dump2 line returnArr($lineNum) dumped: at pos: $lastSpaceChar ->$returnArr($lineNum)<-"}
	  	  set currentLineStart [expr {$lastSpaceChar + 1}]
	  	  #set maxCharNum [expr {$currentLineStart + $maxLineLength}]
                  set maxCharNum [expr {$currentLineStart + $minCharNum}]
	          incr lineNum
	        }; # end if $lastSpaceChar == $pos
	      };# end if $pos == $maxCharNum
	    } elseif {$lastDoubleQuotedChar ne ""} {
	      # A double quote was encountered
	      # now we keep track of quoted blocks - separately from the line
#              if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix: \$lastDoubleQuotedChar: $lastDoubleQuotedChar, doublequotecount: $doubleQuoteCount pos: $pos, maxCharNum: $maxCharNum "}
	      if {$pos == $maxCharNum} {
	        if {[expr {$doubleQuoteCount % 2}] eq 0} {
#                  if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix: modulo test passed. DoublequoteCount is even"}
	  	  # even number of double quotes, so take the last space  or the last double quote as the end of line (whichever is greater)
#                  if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix: lastspacechar: $lastSpaceChar, pos: $pos"}
	          if {$lastSpaceChar > $lastDoubleQuotedChar} { 
	  	  set segmentEndChar $lastSpaceChar
	  	} else {
	  	  set segmentEndChar $lastDoubleQuotedChar
	  	}
	          if {$segmentEndChar == $pos} {
	            # the current character happens to be either a space or double quote. No need to start the pos counter over
                    set returnArr($lineNum) "[string range $args $currentLineStart $segmentEndChar] \\"
#                    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix: dump3 line returnArr($lineNum) dumped: at pos: $currentLineStart->$segmentEndChar ->$returnArr($lineNum)<-"}
	            set currentLineStart [expr {$pos + 1}]
	  	    #set maxCharNum [expr {$currentLineStart + $maxLineLength}]
                    set maxCharNum [expr {$currentLineStart + $minCharNum}]
	            incr lineNum
	          } elseif {$lastSpaceChar > 0} {
	            # there is a space somewhere in the string, which is where the currentLineEnd will be set too.
	            # subsequently restart the currentLineStart counter
                    set returnArr($lineNum) "[string range $args $currentLineStart $lastSpaceChar] \\"
#                    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix: dump4 line returnArr($lineNum) dumped: at pos: $lastSpaceChar ->$returnArr($lineNum)<-"}
	            set currentLineStart [expr {$lastSpaceChar + 1}]
	  	    #set maxCharNum [expr {$currentLineStart + $maxLineLength}]
                    set maxCharNum [expr {$currentLineStart + $minCharNum}]
	            incr lineNum
	          } 
	        } else {
	  	if {$lastSpaceChar > $currentLineStart} {
	            # we are at $maxCharNum AND in the middle of a double quoted block. Cut the segment at the last space. Else do nothing
#	            if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix: dumping range: $currentLineStart->[expr {$lastDoubleQuotedChar - 1}]"}
                    set returnArr($lineNum) "[string range $args $currentLineStart [expr {$lastDoubleQuotedChar - 1}]] \\"
#                    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix: dump5 line returnArr($lineNum) dumped: at pos: [expr {$lastDoubleQuotedChar - 1}] ->$returnArr($lineNum)<-"}
	            # the next line will begin with the quote:
	            set currentLineStart $lastDoubleQuotedChar
	  	    #set maxCharNum [expr {$currentLineStart + $maxLineLength}]
                    set maxCharNum [expr {$currentLineStart + $minCharNum}]
	            incr lineNum
	  	}
	        };# end 
	      };# end $pos == $maxCharNum
	    };# end lastDoubleQuotedChar eq ""
	    incr pos
          };# end while loop

          # We exited the while loop, which means we completed processing the string
	  # If the string ended on the maxlinelength character

	  # Dump anything left into the last line:
	  # if $pos == $currentLineStart, that means we were actually already dumped everything.
	  if {$pos > $currentLineStart} {
            set returnArr($lineNum) "[string range $args $currentLineStart $pos] \\"
            incr lineNum
          } elseif {$pos == $currentLineStart} {
            set returnArr($lineNum) $var
	  }

	  if {$blockType eq "curly"} {
            set returnArr($lineNum) "\}"
	  } elseif {$blockType eq "quote"} {
            set returnArr($lineNum) "\""
 	  }
	};# end not longer than maxLineLength

        return [array get returnArr]
      }; #end member list2prettyArr
      

      ####################################################

      member get_var_value {var} {
	set ${mVarTrackingNamespace}::searchVar "$var"
        #puts "mvarTracking: ->${mVarTrackingNamespace}::return_var<-"
        namespace eval $mVarNamespace {
	  ::set ns_tmp [namespace current]
	  regexp {(.*)::(.*)$} $ns_tmp full parentNS localNS
	  ::set tracking_ns ${parentNS}::VAR_TRACKING_NS
          ::set varName [::set ${tracking_ns}::searchVar]
          if {[info exists $varName]} {
	    return [::set $varName]
          } else {
            return -1
          }
        }
      }

      member update_vars {args} {
        ::set dbgPrefixWs [string repeat " " [info level]]
	::set commandName update_vars
        ::set msgPrefix "${dbgPrefixWs}Configuration([$this->get_name])::${commandName}:"

        set Debug $::FFF::Debug
        # Default is to always overwrite configuration variables (last one wins)
	set ${mVarTrackingNamespace}::mOverWriteFlag 1
#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} BEGIN"}
        #puts "update_vars() args: ->$args<-"
        while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $args full args ]} {}
#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} args: ->$args<-"}
#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} current NS: ->[namespace current]<-"}
#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} current vars: ->[info vars ${mVarNamespace}::*]<-"}

        # #####################################################################
        # The following block processes dash args and extracts the arg block and any switches
        # #####################################################################
        #
        # Pull out name first (default is anonymous)
        # Separate block from dash args
	set origArgs $args
	if {[lindex $args 0] eq "-no_overwrite"} {
	  set ${mVarTrackingNamespace}::mOverWriteFlag 0
	  set varBlock [lrange $origArgs 1 end]
	} else {
	  set varBlock $args
	}	

        # ################ END dash arg processing ############################

        # algorithm:
        # foreach arg, create a variable as appropriate (string vs array), then set the variable
        # in addition, keep list of all strings and arrays
        # warn user (optinally)O if they are overwriting a variable

	# Copy the args passed to update_vars() to the NS
	regsub {^\{(.*)\}$} $varBlock {\1} varBlock
	set ${mVarTrackingNamespace}::set_args "$varBlock"
	
	# ##################################################################
	# Overload 'set' to keep track of variable names in the configuration
	# ##################################################################
	namespace eval $mVarNamespace {
          ::set dbgPrefixWs [string repeat " " [info level]]
          ::set msgPrefix "${dbgPrefixWs}Configuration()::eval_in_mVarNS():"

	  ::set mVarNamespace [namespace current]
	  regexp {(.*)::(.*)$} $mVarNamespace full parentNS localNS
	  ::set tracking_ns ${parentNS}::VAR_TRACKING_NS

          # Overload set. We do this to push the variables names into
          # an array (mVarArray). We also determine whether the variable
          # is an array or string.
          proc set {args} {
            ::set dbgPrefixWs [string repeat " " [info level]]
            ::set msgPrefix "${dbgPrefixWs}set_wrapper():"
	    upvar 1 Debug Debug
	    # Link to member variables that point to absolute NS locations:
	    upvar 1 tracking_ns tracking_ns_local
	    upvar 1 parentNS parentNS_local
	    # Tmp variables, blown away when the proc exits
            ::set varName [lindex $args 0]
            ::set varValue [lrange $args 1 end]
            if {[regexp {(.+)\((.+)\)} $varName full arrName arrKey]} {
              variable $arrName
	      ::set ${tracking_ns_local}::mVarArray($arrName) "ARRAY"
            } else {
              variable $varName
	      ::set ${tracking_ns_local}::mVarArray($varName) "STRING"
            }
            ::set cmd_string "::set $varName $varValue"
	    # Set the variable in the namespace
	    eval $cmd_string
            #######################################################################
	    # BEGIN HACK
            # 4/22/2010 The following is a quick hack to support parameters
	    # Basically we are justing setting the variable in the FFF namespace so it can be resolved w/out analyzing a configuration (i.e., during insert_step)
            # It should be undone asap!
            ::set ::FFF::tmp_cmd_string "::set ::FFF::$varName $varValue"
	    namespace eval ::FFF {
              ::set dbgPrefixWs [string repeat " " [info level]]
              ::set msgPrefix "${dbgPrefixWs}set_wrapper_in_FFF():"
	      eval $::FFF::tmp_cmd_string
	    }
	    # END HACK
            #######################################################################
#            if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} END"}
          };# end proc set

          proc lappend {args} {
            ::set dbgPrefixWs [string repeat " " [info level]]
            ::set msgPrefix "${dbgPrefixWs}lappend_wrapper():"
	    upvar 1 Debug Debug
            # Link to member variables that point to absolute NS locations:
	    upvar 1 tracking_ns tracking_ns_local
	    upvar 1 parentNS parentNS_local
            # Temp variables
            ::set listName [lindex $args 0]
            ::set listValue [lrange $args 1 end]
            if {[regexp {(.+)\((.+)\)} $listName full arrName arrKey]} {
              variable $arrName
	      ::set ${tracking_ns_local}::mVarArray($arrName) "ARRAY"
            } else {
              variable $listName
	      ::set ${tracking_ns_local}::mVarArray($listName) "STRING"
            }
            ::set cmd_string "::lappend $listName $listValue"
	    eval $cmd_string
	    # Set the variable in the FFF namespace
            ::set ::FFF::tmp_cmd_string "::lappend ::FFF::$listName $listValue"
	    namespace eval ::FFF {
	      eval $::FFF::tmp_cmd_string
	    }
          };# end proc lappend

#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} END"}
	};# end namespace eval mVarNamespace

        # eval the args, using the overloaded 'set' command
        #puts "Configuration::update_vars() evaluating the following: ->$args<-"

	# In the mVarNamespace, reference the set commands defined in the tracking ns, and execute them
	namespace eval $mVarNamespace {
          ::set dbgPrefixWs [string repeat " " [info level]]
          ::set msgPrefix "${dbgPrefixWs}Configuration()::eval_in_mVarNS():"

          if {[::FFF::get_tool] ne "edi"} {
	    # import a wrapper for "Puts" (this only exists in EDI)
	    if {![llength [info commands Puts]]} { namespace import ::FFF::Puts }
          }
	  ::set ns_tmp [namespace current]
	  regexp {(.*)::(.*)$} $ns_tmp full parentNS localNS
	  ::set tracking_ns ${parentNS}::VAR_TRACKING_NS
	  ::set setCommand [::set ${tracking_ns}::set_args]
	  if {[regexp {set\s+(.*?)\s+(.*)} $setCommand full varAboutToBeSet varValueToBeSet]} {
	    if {[info exists [::set varAboutToBeSet]]} {
	      if { [::set ${tracking_ns}::mOverWriteFlag] == 0 } {
	      } else {
		#
		# Bug caught on 6/29. varValueToBeSet has to be regsub'd to remove curlies
	  	#
        	regsub {^\{(.*)\}$} $varValueToBeSet {\1} varValueToBeSet

		if {[::set $varAboutToBeSet] ne $varValueToBeSet} {
	          puts "read_foundation: NOTE: Overriding current value of $varAboutToBeSet from \"[::set $varAboutToBeSet]\" to \"$varValueToBeSet\""
 	          eval [::set ${tracking_ns}::set_args]
		}
	      }
	    } else {
 	      eval [::set ${tracking_ns}::set_args]
	    }
          }
	}; # end namespace eval $mVarNamespace

	# The following is just for safety - probably not necessary, and should eventually be removed:
        set ${mVarTrackingNamespace}::mOverWriteFlag 1
      }; # update_vars

      member Configuration {{Name "Default"} {args ""}} {
        set mName $Name
        set dbgPrefixWs [string repeat " " [info level]]
        set msgPrefix "${dbgPrefixWs}[typeid]($mName)->New():"
        set mArgs $args
        while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $args full args ]} {}

	# mVarNamespace is a member variable that points to the NS that we actually set the config variables
	# (i.e., where we eval the set commands)
	set mVarNamespace [namespace current]::VAR_NS

	# mVarTrackingNamespace is a member variable that points to the NS used as an absolute reference for
	# tracking what variables have been set
	# These are not Configuration Object member variables because when they are referred to, we are actually outside
	# the object namespace. In other words, this completely breaks the object oriented paradigm of t++, since we don't
	# enforce any protection mechanism for these variables.
	# On the plus side, this namespace gives us an easy solution to track any particulars of a configuration
	# when we are moving in and of different namespaces, since the absolute path to these variables is always
	# relative to configuration object namespace.
	set mVarTrackingNamespace [namespace current]::VAR_TRACKING_NS

	# Initialize the Tracking Namespace
	namespace eval $mVarTrackingNamespace {
          #set dbgPrefixWs [string repeat " " [info level]]
	  variable mVarArray
	  variable set_args
	  variable myConfigObjNSPath
	  variable mArgs
	  variable mOverWriteFlag
        }

	# Initialize Variable NS
	namespace eval $mVarNamespace {}

	# Define mArgs in the var namespace
	set ${mVarTrackingNamespace}::myConfigObjNSPath [namespace current]

	# Copy $mArgs (now in the object) to the namespace 
 	# This code needs to be obsoleted, so we can simply copy all variables out of the namespace...
	#set ${mVarNamespace}::mArgs $mArgs
	#namespace eval $mVarNamespace {
        #  eval $mArgs
	#}
	if {![array exists mVarArr]} {
	  #puts "setting mVarArr to \{\}"
	  array set mVarArr {}
        }

        # initialize
        array set mPrettyCommand2Print {}
        set mOstream ""
        set mFile "" 
      }

      member set_mPrettyCommand2Print {Arr} {
        array set mPrettyCommand2Print $Arr
      }

      member get_var_namespace {} {
	return $mVarNamespace
      }

      member get_var_tracking_namespace {} {
	return $mVarTrackingNamespace
      }

      member get_name {} {
        if {[info exists mName]} {
          return $mName
        } else {
          return "NOTNAMED"
        }
      }
      member get_var_block {} {
        set Debug $::FFF::Debug
        return $mArgs
      }
      member set_ostream {arg} {
        set mOstream $arg
      }
      member set_mfile {arg} {
        set mFile $arg
      }
      member print_array {{trim_ws ""} {indent ""} {prefix ""} {var ""} {key ""}} {
        if {[array size mPrettyCommand2Print] > 1} {
          # Print the first line with the opening curly brace or quote:
          if {$mFile ne ""} {
            puts $mOstream "${prefix}set ${var}($key) $mPrettyCommand2Print(0)"
          } else {
            if {$mOstream ne ""} {
              puts $mOstream "${prefix}set ${var}($key) $mPrettyCommand2Print(0)"
            } else {
              puts "${prefix}set ${var}($key) $mPrettyCommand2Print(0)"
            }
          }
          # print out each item in the prettyprint array
          for {set i 1} {$i < [array size mPrettyCommand2Print] } {incr i} {
            if {$i == [expr {[array size mPrettyCommand2Print] - 1 }]} {
              set blockIndent ""
            } else {
              set blockIndent "   "
            }
            if {$trim_ws} {
              regsub {[[:space:]]*(.*)} $mPrettyCommand2Print($i) {\1} trimmed_cmd
              if {$mFile ne ""} {
                puts $mOstream "${indent}$prefix$blockIndent$trimmed_cmd"
              } else {
                if {$mOstream ne ""} {
                  puts $mOstream "${indent}$prefix$blockIndent$trimmed_cmd"
                } else {
                  puts "${indent}$prefix$blockIndent$trimmed_cmd"
                }
              }
            } else {
              if {$mFile ne ""} {
                puts $mOstream "${indent}$prefix$blockIndent$mPrettyCommand2Print($i)"
              } else {
                if {$mOstream ne ""} {
                  puts $mOstream "${indent}$prefix$blockIndent$mPrettyCommand2Print($i)"
                } else {
                  puts "${indent}$prefix$blockIndent$mPrettyCommand2Print($i)"
                }
              }
            }
          }
        } else {
          if {$mOstream ne ""} {
            puts $mOstream "${indent}${prefix}set ${var}($key) $mPrettyCommand2Print(0)"
          } else {
            puts "${indent}${prefix}set ${var}($key) $mPrettyCommand2Print(0)"
          }
        }
      }
      member print {{args}} {
         set dbgPrefixWs [string repeat " " [info level]]
         set Debug $::FFF::Debug
	 if {[regexp {FF_Default} $mName configName]} {
	   set ediFF_style_config 1
	 } else {
	   set ediFF_style_config 0
           set configName $mName
	 }
         set prefix ""
	 set fileName ""
         set trim_ws 0
         set debug 0
	 set OSTREAM ""
	 set indent ""
         set list2prettyArrArgs ""
         set pathFixValue ""
         set myEscapedFlag 0
         # Normalize files and dirs by default
         #regexp {\{(.*)\}} $args full args
         set args [::FFF::flatten_list $args]

         if {$args ne ""} {
           while {[string match -* [lindex $args 0]] } {
             #puts "config->print processing args ->$args<-"
             set option [lindex $args 0]
             set args [lrange $args 1 end]
             switch -exact -- $option {
               -prefix {
                 set prefix [lrange $args 0 0]
                 regsub -all {\{([[:space:]]*)\}} $prefix {\1} prefix
                 set args [lrange $args 1 end]
               }
               -indent {
                 set indent [lrange $args 0 0]
                 regsub -all {\{([[:space:]]*)\}} $indent {\1} indent
                 set args [lrange $args 1 end]
               }
	       -file {
                 set fileName [lrange $args 0 0]
                 #puts "config->print processing args found file: ->$fileName<-"
                 set args [lrange $args 1 end]
		 $this->set_mfile $fileName
               }
               -trim_ws {
                 set trim_ws 1
               }
               -escaped {
	         lappend list2prettyArrArgs "-escaped"
                 set myEscapedFlag 1
               }
               -path_fix {
                 set pathFixValue [lrange $args 0 0]
	         lappend list2prettyArrArgs "-path_fix $pathFixValue"
               }
               -rundir {
                 set rundir [lrange $args 0 0]
	         lappend list2prettyArrArgs "-rundir $rundir"
               }
               -debug {
                 set debug 1
                 puts "Configuration::print([$this->get_name]) ID: $this"
               }
               -ost {
                 set OSTREAM [lrange $args 0 0]
                 set args [lrange $args 1 end]
               }
             }
           }
         };# end if args ne ""

         #puts "config->print done processing args"
	if {$fileName ne ""} {
          set OSTREAM [open $fileName "a"]
 	  $this->set_ostream $OSTREAM
          puts $OSTREAM "${indent}##### BEGIN Configuration: $configName #####"
	  if {$ediFF_style_config == 0 } {
	    puts $OSTREAM "${indent}set_configuration $configName \{"
	  }
        } else {
	  if {$OSTREAM ne ""} {
            puts $OSTREAM "${indent}##### BEGIN Configuration: $configName #####"
	    if {$ediFF_style_config == 0 } {
	      puts $OSTREAM "${indent}set_configuration $configName \{"
	    }
	  } else {
            puts "${indent}##### BEGIN Configuration: $configName #####"
	    if {$ediFF_style_config == 0 } {
	      puts "${indent}set_configuration $configName \{"
	    }
 	  }
	}

        
	# Print out contents of an array variable
        foreach var [array names ${mVarTrackingNamespace}::mVarArray] {
          if {[array exists ${mVarNamespace}::$var]} {
            #
            # This is a special section to take care of variables which *must* appear first in the config file before any others
            # because other variables may rely on these.
            # Currently these are: vars(rundir) and vars(script_path)
	    #
            if {$var eq "vars"} {
	      # check to see if vars(rundir) exists in the array
              set vars_rundirIndex [lsearch [array names ${mVarNamespace}::$var] rundir]
              if {$vars_rundirIndex ne "-1"} {
                #puts $OSTREAM "${prefix}# vars(rundir) may be used in other variables names so appears first"
                #puts $OSTREAM "${prefix}# vars(rundir) is defined in the .ff.tcl script which must appear in your rundir"
                #puts "executing config->list2prettyArr [list $list2prettyArrArgs [set mVarNamespace]::vars(rundir)]"
	        #array set arrToPrint [$this->list2prettyArr [::FFF::flatten_list [list $list2prettyArrArgs [set mVarNamespace]::vars(rundir)]]]
	  	#$this->set_mPrettyCommand2Print [array get arrToPrint]
                #puts $OSTREAM "${prefix}set vars(rundir) $arrToPrint(0)"
		#array set nullArr {}
		#$this->set_mPrettyCommand2Print [array get nullArr]
 	      }
              # check to see if vars(script_path) exists
              set vars_script_pathIndex [lsearch [array names ${mVarNamespace}::$var] script_path]
              if {$vars_script_pathIndex ne "-1"} {
                puts $OSTREAM "${prefix}# vars(script_path) may be used in other variable names so appears second."
	        set scriptPath [set mVarNamespace]::vars(script_path)
                puts $OSTREAM "${prefix}set vars(script_path) \"[set [set scriptPath]]\""
 	      }
              # insert the foundationflow applet

              if {$vars_rundirIndex ne "-1"} {
                puts $OSTREAM "${prefix}set vars(foundation_flow_applet) \"[::FFF::relPathTo $::FFF_OPEN::vars(foundation_flow_applet) [file normalize [set [set mVarNamespace]::vars(rundir)]]]\""
              }
            }
            foreach key [lsort -dictionary [array names  ${mVarNamespace}::$var]] {
	      array unset prettyCommand2Print
              if {[llength [set [set mVarNamespace]::[set var]($key)] ] > 1} {
	        # 'pretty-print' the list 1 item per line
	        array set prettyCommand2Print [$this->list2prettyArr [::FFF::flatten_list [list $list2prettyArrArgs [set mVarNamespace]::[set var]($key)]]]
	        if {[array size prettyCommand2Print] > 1} {
	          # Print the first line with the opening curly brace or quote:
	          if {$fileName ne ""} {
	            puts $OSTREAM "${prefix}set ${var}($key) $prettyCommand2Print(0)"
	          } else {
	            if {$OSTREAM ne ""} {
	              puts $OSTREAM "${prefix}set ${var}($key) $prettyCommand2Print(0)"
	            } else {
	              puts "${prefix}set ${var}($key) $prettyCommand2Print(0)"
	            }
	          }
	          # print out each item in the prettyprint array
                  for {set i 1} {$i < [array size prettyCommand2Print] } {incr i} {
	            if {$i == [expr {[array size prettyCommand2Print] - 1 }]} {
	      	set blockIndent ""
	            } else {
	              set blockIndent "   "
	            }
	            if {$trim_ws} {
                      regsub {[[:space:]]*(.*)} $prettyCommand2Print($i) {\1} trimmed_cmd
	              if {$fileName ne ""} {
                        puts $OSTREAM "${indent}$prefix$blockIndent$trimmed_cmd"
	              } else {
	      	  if {$OSTREAM ne ""} {
                          puts $OSTREAM "${indent}$prefix$blockIndent$trimmed_cmd"
	      	  } else {
                          puts "${indent}$prefix$blockIndent$trimmed_cmd"
	      	  }
	              }
                    } else {
	              if {$fileName ne ""} {
                        puts $OSTREAM "${indent}$prefix$blockIndent$prettyCommand2Print($i)"
	              } else {
	      	  if {$OSTREAM ne ""} {
                          puts $OSTREAM "${indent}$prefix$blockIndent$prettyCommand2Print($i)"
	      	  } else {
                          puts "${indent}$prefix$blockIndent$prettyCommand2Print($i)"
	      	  }
	              }
                    }
                  }
	        } else {
	          # only 1 line in the pretty print array
	          if {$fileName ne ""} {
	            puts $OSTREAM "${indent}${prefix}set ${var}($key) $prettyCommand2Print(0)"
	          } else {
	            if {$OSTREAM ne ""} {
	              puts $OSTREAM "${indent}${prefix}set ${var}($key) $prettyCommand2Print(0)"
	            } else {
	              puts "${indent}${prefix}set ${var}($key) $prettyCommand2Print(0)"
	            }
	          }
 	        }
              } else {
	        # Normalize single entries
                set testI [set [set mVarNamespace]::[set var]($key)]
                if {$pathFixValue ne ""} {
                  if {[file exists $testI]} {
                    if {$pathFixValue eq "normalize"} {
                      set configCommand "set ${var}($key) \"[file normalize $testI]\""
                    } elseif {$pathFixValue eq "relative"} {
                      set configCommand "set ${var}($key) \"[::FFF::relPathTo [file normalize $testI] [file normalize $rundir]]\""
                    } else {
                      set configCommand "set ${var}($key) \"[::FFF::relPathTo [file normalize $testI] [exec pwd]]\""
                    }
                  } else {
                    set configCommand "set ${var}($key) \"$testI\""
                  }
                } else {
                  set configCommand "set ${var}($key) \"$testI\""
                }

	        #
	        # sub out $ if requested
	        #
                if {$myEscapedFlag} {
                  regsub -all {\"\$(\S+)\"} $configCommand {"\$\1"} configCommand
                } else {
                  regsub -all {\"\$(\S+)\"} $configCommand {"$\1"} configCommand
                }

	        #
	        # Trim whitespace, if requested
	        #
                if {$trim_ws} {
                  regsub {[[:space:]]*(.*)} $configCommand {\1} trimmed_cmd
	          if {$fileName ne ""} {
                    puts $OSTREAM "${indent}$prefix$trimmed_cmd"
	          } else {
	            if {$OSTREAM ne ""} {
                      puts $OSTREAM "${indent}$prefix$trimmed_cmd"
	            } else {
                      puts "${indent}$prefix$trimmed_cmd"
	            }
	          }
                } else {
	          if {$fileName ne ""} {
                    puts $OSTREAM "${indent}$prefix$configCommand"
	          } else {
	            if {$OSTREAM ne ""} {
                      puts $OSTREAM "${indent}$prefix$configCommand"
	            } else {
                      puts "${indent}$prefix$configCommand"
	            }
	          }
                }
	      }
            };# end foreach
	  # Print out contents of a non-array variable
          } elseif {[info exists ${mVarNamespace}::$var]} {
            if {[llength [set ${mVarNamespace}::$var] ] > 1} {
              set configCommand "set ${var} \{[set ${mVarNamespace}::$var]\}"
            } else {
              set configCommand "set ${var} \"[set ${mVarNamespace}::$var]\""
            }
	    if {$trim_ws} {
              regsub {[[:space:]]*(.*)} $configCommand {\1} trimmed_cmd
	      if {$fileName ne ""} {
#	        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}Printing to OSTREAM ->$prefix$trimmed_cmd<-"}
                puts $OSTREAM "${indent}$prefix$trimmed_cmd"
	      } else {
		if {$OSTREAM ne ""} {
                  puts $OSTREAM "${indent}$prefix$trimmed_cmd"
		} else {
                  puts "${indent}$prefix$trimmed_cmd"
		}
	      }
            } else {
	      if {$fileName ne ""} {
#	        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}Printing to OSTREAM ->$prefix$configCommand<-"}
                puts $OSTREAM "${indent}$prefix$configCommand"
	      } else {
		if {$OSTREAM ne ""} {
                  puts $OSTREAM "${indent}$prefix$configCommand"
		} else {
                  puts "${indent}$prefix$configCommand"
		}
	      }
            }
          } else {
	    if {$fileName ne ""} {
	      if {[info exists ::FFF::DEBUG_OSTREAM]} {
                puts $OSTREAM "# ${indent}$prefix$configName {empty Config definition}"
              }
	    } else {
	      if {$OSTREAM ne ""} {
                puts $OSTREAM "${indent}$prefix$configCommand"
	      } else {
                puts "${indent}$prefix$configCommand"
	      }
	    }
	  }
        }; #end foreach var in mVarArray
        if {$ediFF_style_config == 0 } {
	  if {$fileName ne ""} {
              puts $OSTREAM "${indent}\}"
              puts $OSTREAM "${indent}##### END Configuration: $configName #####"
	  } else {
	    if {$OSTREAM ne ""} {
                puts $OSTREAM "${indent}\}"
                puts $OSTREAM "${indent}##### END Configuration: $configName #####"
	      } else {
                puts "${indent}\}"
                puts "${indent}##### END Configuration: $configName #####"
	    }
	  }
	} else {
	  if {$fileName ne ""} {
              puts $OSTREAM "${indent}##### END Configuration: $configName #####"
	  } else {
	    if {$OSTREAM ne ""} {
                puts $OSTREAM "${indent}##### END Configuration: $configName #####"
	    } else {
                puts "${indent}##### END Configuration: $configName #####"
	    }
	  }
	}
	if {$OSTREAM ne ""} {
          close $OSTREAM
        }
#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}Configuration::print([$this->get_name]): END"}
       };# End member print


      # write_script
      # Similar to print, but i'm writing to a file

      member write_script {{args}} {
         set dbgPrefixWs [string repeat " " [info level]]
	 
         set Debug $::FFF::Debug
         set prefix ""
	 set fileName ""
         set trim_ws_switch ""
	 set debug_switch ""
	 set prefix_switch ""
#         if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}Configuration::write_script(): BEGIN: args: $args"}
         regexp {\{(.*)\}} $args full args

#         if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}Configuration::write_script(): BEGIN: args: $args"}
         if {$args ne ""} {
           while {[string match -* [lindex $args 0]] } {
             set option [lindex $args 0]
             set args [lrange $args 1 end]
             switch -exact -- $option {
               -prefix {
                 set prefix [lrange $args 0 0]
                 regsub -all {\{([[:space:]]*)\}} $prefix {\1} prefix
		 set prefix_switch "-prefix $prefix"
                 set args [lrange $args 1 end]
               }
               -file {
                 set fileName [lrange $args 0 0]
                 regsub -all {\{([[:space:]]*)\}} $fileName {\1} fileName
                 set args [lrange $args 1 end]
               }
               -trim_ws {
		 set trim_ws_switch "-trim_ws"
               }
               -debug {
                 set debug_switch "-debug"
               }
             }
           }
         }

	 puts "NOTE: write_script member function now obsolete."
         puts "Please use ->print -file <name> from now on."
	 $this->print -file $fileName $trim_ws_switch $debug_switch $prefix_switch


         #######set OSTREAM [open $fileName "a"]
         #######puts $OSTREAM "##### BEGIN Configuration: $mName #####"
         #######puts $OSTREAM "set_configuration $mName {"

         #######if {[llength $mArgs] == 0} {
         #######  puts $OSTREAM "$prefix$mName {empty Config definition}"
         #######} else {
#	 #######  if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}${mName}->write_script() mArgs: ->$mArgs<-"}
         #######  set line_split_args [split $mArgs "\n"]
#	 #######  if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}${mName}->write_script() line_split_args: ->$line_split_args<-"}
         #######  foreach arg $line_split_args { 
#	 #######    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}${mName}->write_script() Processing arg: ->$arg<-"}
         #######    if {$trim_ws} {
         #######      regsub {[[:space:]]*(.*)} $arg {\1} trimmed_cmd
         #######      puts $OSTREAM "$prefix$trimmed_cmd"
         #######    } else {
         #######      puts $OSTREAM "$prefix$arg"
         #######    }
         #######  }
         #######} ; # end mVarArr is empty

         #######puts $OSTREAM "}"

       } ; # End member write_script

      member ~Configuration {} {
      }
    }
  }
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [FFFFlowObject.tcl]                                         #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
# Define the Flow object (Class)
proc define_flow_object {} {
  set dbgPrefixWs [string repeat " " [info level]]
  set msgPrefix "${dbgPrefixWs}[::FFF::getProcName]():"
  set Debug $::FFF::Debug
  #::FFF::dbg_puts "BEGIN"

  uplevel 1 {
    object Flow {
      private {
        var mFlowInstArr
        var mdesScope
        var mscriptType
        var mFlowOutputsList
        var mParentFlow
        var mTotalSteps
      }
      
      # Define Flow Object (base class: Stage Object)

      member set_script_type {scriptType} {
        set dbgPrefixWs [string repeat " " [info level]]
        set msgPrefix "${dbgPrefixWs}[typeid]($Name)->[::FFF::getProcName]():"
        set Debug $::FFF::Debug
        ::FFF::dbg_puts "BEGIN"
        set mscriptType $scriptType
      }

      member Flow {{Name "anonymous"}} {
        set dbgPrefixWs [string repeat " " [info level]]
        set msgPrefix "${dbgPrefixWs}[typeid]($Name)->[::FFF::getProcName]():"
        set Debug $::FFF::Debug
        ::FFF::dbg_puts "BEGIN"
	inherit public Stage $Name
        set mdesScope "/"
	set mscriptType ""
        set mParentFlow ""
	set mTotalSteps 0
        ::FFF::dbg_puts "Flow Object [$this->get_name] created."
      }
      member set_total_steps {stepCount} {
        set mTotalSteps $stepCount
      }
      member get_total_steps {} {
        return $mTotalSteps
      }
      member get_parent_flow {} {
        #::FFF::fff_member_init
        return $mParentStage
      }
      member set_parent_flow {flowObjID} {
        #::FFF::fff_member_init
        set mParentStage $flowObjID
      }

      member add_flow_outputs {outputList} {
        lappend mFlowOutputsList $outputList
      }

      member get_flow_outputs {} {
        return $mFlowOutputsList
      }
  
       member get_flows {} {
         set flow_ID_list {}
         foreach flowObjID [array names mFlowInstArr] {
           lappend stage_ID_list "$stageObjID"
         }
         #puts "the list: $stage_ID_list"
         return $stage_ID_list
       }

      member clear_flow_instance_arr {} {
        ::FFF::fff_member_init
	#foreach flowObjID [array names mFlowInstArr] {
        #  delete $flowObjID
	#}
        #array unset mFlowInstArr
        array unset mFlowInstArr
        array set mFlowInstArr {}
        ::FFF::fff_member_close
      }

      member set_flow_arr {flowArr} {
        array set mFlowInstArr $flowArr
      }
      member set_design_scope {scope} {
        set mdesScope $scope
      }
      member get_design_scope {} {
        return $mdesScope
      }

      # Overload insert_stage in base class with new member function:
      member insert_stage {NewStageInstObjID {args ""}} {
        ::FFF::fff_member_init
        set mStageInstArr($NewStageInstObjID) [$NewStageInstObjID->get_name]
        $this->set_size [expr {[$this->get_size] + 1}]
        #::FFF::dbg_puts "Current Stages in [$this->typeid] [$this->get_name] ($this):"
        #::FFF::fff_member_close
      }
   
      ### DISABLING
      ###virtual member print {{args}} {
      ###  set prefix ""
      ###  set trim_ws 0
      ###  set debug 0
      ###  regexp {\{(.*)\}} $args full args
  
      ###  if {$args ne ""} {
      ###    while {[string match -* [lindex $args 0]] } {
      ###      set option [lindex $args 0]
      ###      set args [lrange $args 1 end]
      ###      switch -exact -- $option {
      ###        -prefix {
      ###          set prefix [lrange $args 0 0]
      ###          regsub -all {\{([[:space:]]*)\}} $prefix {\1} prefix
      ###          set args [lrange $args 1 end]
#      ###        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "Flow::print(): prefix is ->$prefix<-"}
      ###        }
      ###        -trim_ws {
      ###          set trim_ws 1
      ###        }
      ###        -debug {
      ###          set debug 1
      ###        }
      ###      }
      ###    }
      ###  }
      ###  # Print stages in the flow
      ###  if {[array size mStageArr] == 0} {
      ###    puts "$prefix{No Stages defined in Flow [$this->get_name]}"
      ###  } else {
      ###    foreach stageObjID [array names mStageInstArr] {
      ###      $stageObjID->print -prefix "      " -trim_ws
      ###      #if {$trim_ws} {
      ###      #  regsub {[[:space:]]*(.*)} $mStageInstArr($stageObjID) {\1} trimmed_name
      ###      #  puts "$prefix$trimmed_name"
      ###      #} else {
      ###      #  puts "$prefix$mStageInstArr($stageObjID)"
      ###      #}
      ###    }
      ###  }
      ###  # Print flows in the flow
      ###  if {[array size mFlowInstArr] == 0} {
      ###    #puts "NOTE: No Flows instantiated in Flow"
      ###  } else {
      ###    puts "Flows:"
      ###    for {set i 1} {$i <= [array size mFlowInstArr]} {incr i} {
      ###      if {$trim_ws} {
      ###        regsub {[[:space:]]*(.*)} $mFlowInstArr($i) {\1} trimmed_cmd
      ###        puts "${prefix}${trimmed_cmd}"
      ###      } else {
      ###        puts "${prefix}$mFlowInstArr($i)"
      ###      }
      ###    }
      ###  }
      ###};# End member print
  
  
      # Generate an executable script for the Flow
      member gen_exe_script {args} {
        set Debug $::FFF::Debug
        set prefix ""
        set trim_ws_switch ""
        set debug_switch ""
        set prefix_switch ""
	set comments_switch ""
	set replace_switch ""
	set resolve_vars_switch ""
        set make_switch "true"
        set debug 0
	while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $args full args ]} {
	};# end while
  
        if {$args ne ""} {
          while {[string match -* [lindex $args 0]] } {
            set option [lindex $args 0]
            set args [lrange $args 1 end]
            switch -exact -- $option {
              -prefix {
                 set prefix [lrange $args 0 0]
                 # Wierd problem that i haven't gotten to the bottom of with arg processing
                 # For some reason " " get's converted to {}
                 # This is a quick hack to convert back to " "
                 #regsub -all {\{([[:space:]]*)\}} $prefix {"\1"} prefix
                 regsub -all {\{([[:space:]]*)\}} $prefix {\1} prefix
#                 #if {$Debug} {puts "Stage::print(): setting prefix to ->$prefix<-"}
                 set args [lrange $args 1 end]
                 set prefix_switch "-prefix \"$prefix\""
              }
              -no_resolve {
                  set resolve_vars_switch "-no_resolve"
               }
              -trim_ws {
                set trim_ws_switch "-trim_ws"
              }
              -no_make {
                set make_switch "false"
              }
              -debug {
		set debug_switch "-debug"
              }
              -replace {
		set replace_switch "-replace"
              }
              -overwrite {
		set replace_switch "-replace"
              }
	      -nocomments {
		set comments_switch "-nocomments"
	      }
            }
          }
        }

        # Set up name for executable script

#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "Flow->write_script() current mscriptName: ->$mscriptName<-"}
#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "Flow->write_script() current mscriptNameBase: ->$mscriptNameBase<-"}

        # First, see if there is scriptname, basename, or instance name for the flow
	# This will form part of the script name.
        if {$mscriptName eq ""} {
          if {$mscriptNameBase eq ""} {
            if {[$this->get_instance_name] eq ""} {
              set mscriptName [$this->get_name]
	      puts "[$this->get_name]->gen_exe_script NOTE: No name defined. Using flow name for script basename: $mscriptName"
            } else {
              set mscriptName [$this->get_instance_name]
	    }
          } else {
            set mscriptName $mscriptNameBase
          }
        }

	# Next, determine the execution script type. This forms the rest of the name
        if {$mscriptType eq ""} {
	  set mscriptType ${::FFF::myDefaultExeScriptType}
	}
        switch -exact -- $mscriptType {
          perl { set mscriptName ${mscriptName}.pl }
          csh  { set mscriptName ${mscriptName}.csh }
          bash  { set mscriptName ${mscriptName}.sh }
          python  { set mscriptName ${mscriptName}.py }
          make  { set mscriptName Makefile.${mscriptName} }
	}; # end switch

#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "Flow->gen_exe_script() After setting scriptname: ->$mscriptName<-"}
#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "Flow->gen_exe_script() After setting mscriptNameBase: ->$mscriptNameBase<-"}

        if {$replace_switch eq ""} {
          # Default behavior is to not overwrite scripts
          set mscriptName [::FFF::generate_next_output_filename $mscriptName]
        }

#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "Flow->gen_exe_script() final mscriptName: $mscriptName"}

        # Fix hierarchical path name
        set flowHierInstancePath [$this->get_parent_path]::[$this->get_name]
        regsub {::FFF::elabdb::} $flowHierInstancePath {/} flowHierInstancePath
        regsub {::} $flowHierInstancePath {/} flowHierInstancePath

        if {$make_switch} {
          # Write header
          puts "gen_exe_script() Writing $mscriptName..."
          set OSTREAM [open $mscriptName "w"]
          puts $OSTREAM "###########################################################"
          puts $OSTREAM "### Frontend Foundation Flow Generated Makefile"
          puts $OSTREAM "### Generated by:             Frontend Foundation Flow v$::FFF::fcf_version"
          puts $OSTREAM "### Generated on:             [clock format [clock seconds] -format "%I:%M:%S %p(%b%d)"]"
          puts $OSTREAM "### Flow:                     [$this->get_name]"
          puts $OSTREAM "### File:                     $mscriptName"
          puts $OSTREAM "### Instance:                 $flowHierInstancePath"
          puts $OSTREAM "###########################################################"
          puts $OSTREAM "# Configurations bound to this Flow: [$this->get_configurations]"
          puts $OSTREAM "#----------------------------------------------------------"
          puts $OSTREAM ""
	  close $OSTREAM
        }
 
        # Write Stage Targets

        # Print stages in the flow
        if {[array size mStageInstArr] == 0} {
          puts "# $prefix{No Stages defined in Flow [$this->get_name]}"
        } else {
          foreach stageObjID [array names mStageInstArr] {
	    # Note - the name of the script is part of the private data in the stage object
	    # In the future this member function could be updated to provide a different script name
            $stageObjID->write_script [::FFF::flatten_list [list $trim_ws_switch $prefix_switch $debug_switch $comments_switch $replace_switch $resolve_vars_switch]]

	    if {$make_switch} {
	      # Next write the target for this (top level) stage into the Makefile:	
              $stageObjID->write_makefile_target $mscriptName
	    }
          }
        }
        # Print flows in the flow
        if {[array size mFlowInstArr] == 0} {
          #puts "NOTE: No Flows defined Flow"
        } else {
          for {set i 1} {$i <= [array size mFlowInstArr]} {incr i} {
              $mFlowInstArr($i)->gen_exe_script [::FFF::flatten_list [list $debug_switch $comments_switch $replace_switch $resolve_vars_switch]]
          }
        }
	if {$make_switch} { 
          set OSTREAM [open $mscriptName "a+"]
          puts $OSTREAM "##### END Frontend Foundation Flow Makefile v$::FFF::fcf_version"
	  close $OSTREAM
	
          if {[file exists $mscriptName]} {
            puts "<FF> Wrote $mscriptName"
          }
	}

      };# End member gen_exe_script
  
      # Overload copy_to function
      member copy_to {{newObjID}} {
        set dbgPrefixWs [string repeat " " [info level]]
        set msgPrefix "${dbgPrefixWs}[$this->typeid]([$this->get_name])->[::FFF::getProcName]([$newObjID->get_name]):"
        set Debug $::FFF::Debug

        # Create a new Flow object in the target namespace, and copy over all object data (private, protected, public)
        # We actually don't want to copy these over directly; rather we need to elaborate from the original object, and
        # insert the new (elaborated) stages/flows in this object
        # However, in order to preserve the name and logical purpose of this function, i'll leave the following intact
        # (For the purpose of elaboration, we delete the next two arrays, and then repopulate. This should be cleaned up
        # in the future.)


        set [[peekObj $newObjID]->getVarPath mName] $mName
        set [[peekObj $newObjID]->getVarPath mBaseName] $mBaseName

#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix Copied Flow Definition $this to elaborated Flow $newObjID, which included the following:"}
        $newObjID->set_stage_arr [array get mStageInstArr]
	if {[array size mStageInstArr] > 0} {
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix Stage Instances copied:"}
	  foreach sid [$newObjID->get_stages] {
#            if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix    [$sid->get_name] ($sid)"}
          }
   	}
        $newObjID->set_flow_arr [array get mFlowInstArr]
	if {[array size mFlowInstArr] > 0} {
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix Flow Instances copied to $newObjID:"}
	  foreach fid [$newObjID->get_flows] {
#            if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix    [$fid->get_name]($fid)"}
          }
        }
        $newObjID->set_design_scope $mdesScope
#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix Design Scope copied: ->[$newObjID->get_design_scope]<-"}
        $newObjID->set_configurations $mConfigList
#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix Configuration List Copied: ->[$newObjID->get_configurations]<-"}
        $newObjID->set_script_name $mscriptName
#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix Script Name Copied: ->[$newObjID->get_script_name]<-"}

#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} END"}
      }
      member ~Flow {} {
      }
    }
  }
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [FFFParameterConfigurationObject.tcl]                                         #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
# Define the Step Instance object (Class)

proc define_parameter_configuration_object {} {
  set dbgPrefixWs [string repeat " " [info level]]
  set msgPrefix "${dbgPrefixWs}[::FFF::getProcName]():"
  set Debug $::FFF::Debug
  #::FFF::dbg_puts "BEGIN"

  uplevel 1 {
    # #################################################################
    # Base Class: Configuration
    # #################################################################

    object ParameterConfiguration {
       member ParameterConfiguration  {{Name "Default"} {args ""}} {
         set dbgPrefixWs [string repeat " " [info level]]
         set msgPrefix "${dbgPrefixWs}[typeid]():"
         inherit Configuration $Name $args
	 friend Configuration
       }
       member ~ParameterConfiguration {} {
         set dbgPrefixWs [string repeat " " [info level]]
         set msgPrefix "${dbgPrefixWs}[typeid]():"
       }
    };# end Object Declaration
  };# end uplevel 1
}; # end proc define_parameter_configuration_object
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [FFFPluginInstanceObject.tcl]                                         #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
# Define the Step Instance object (Class)

namespace eval FFF {

  namespace export define_plugin_instance_object

  proc define_plugin_instance_object {} {
    set dbgPrefixWs [string repeat " " [info level]]
    set msgPrefix "${dbgPrefixWs}[::FFF::getProcName]():"
    set Debug $::FFF::Debug
  
    uplevel 1 {
      # #################################################################
      # Base Class: Step
      # #################################################################
      object PluginInst {
         member PluginInst {{Name "anonymous"}} {
           inherit Plugin $Name
	   ::FFF::fff_member_init
           dbg_puts "new PluginInstance: $Name"
  	   friend Plugin Step StepInst
         }
         member ~PluginInst {} {
           set dbgPrefixWs [string repeat " " [info level]]
           set msgPrefix "${dbgPrefixWs}[typeid]():"
           array unset ::FFF::pluginInst_objid_arr $pubThis
         }
      };# end Object Plugin Declaration
    };# end uplevel 1
  }; # end proc define_step_instance_object
}; # end namespace eval FFF
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [FFFPluginObject.tcl]                                         #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
# Define the Step Instance object (Class)

namespace eval FFF {

  namespace export define_plugin_object

  proc define_plugin_object {} {
    set dbgPrefixWs [string repeat " " [info level]]
    set msgPrefix "${dbgPrefixWs}[::FFF::getProcName]():"
    set Debug $::FFF::Debug
    #::FFF::dbg_puts "BEGIN"
  
    uplevel 1 {
      # #################################################################
      # Base Class: Step
      # #################################################################
      object Plugin {
        protected {
	  # temporary array used by inline and outline
	  var tmpCmdArr

	  #
	  # mPluginFullyResolvedFlag: Flag indicating whether the plugin has
	  # been fully resolved (all variables have values)
	  # This (normally) happens only during elaboration.
	  #
          var mPluginFullyResolvedFlag

	  #
	  # mPluginCmd: The command to print in the generated script
	  # when the plugin is not inlined
	  # Example: source /path/to/pre_syn_gen.tcl
	  # or
	  #          pre_syn_gen_plugin_proc
          var mPluginCmd

	  #
	  # mPluginFileCmdArr: The actual plugin. This is the actual plugin block, either from
	  # a plugin file or plugin proc.
	  #
	  var mPluginFileCmdArr
	  
          # Whether to in-line the plugin
	  # By in-line we mean replace the mPluginCmd with the mPluginFileCmdArr
	  var mInline

	  # Plugin Type: file or proc
	  var mPluginType

	  # mPluginFile
	  # If the plugin is a file, store the path to the file in this variable
	  var mPluginFile

	  # If the plugin is a proc, store the proc name in this variable
	  var mPluginProc
	}
        member Plugin {{Name "anonymous"}} {
          inherit Step $Name
	  ::FFF::fff_member_init
	  dbg_puts "new Plugin: $Name"
  	  friend Step
          set mPluginFullyResolvedFlag ""
          set mPluginCmd ""
          array set mPluginFileCmdArr ""
          array set tmpCmdArr ""
	  set mInline 1
	  set mPluginType ""
	  set mPluginFile ""
	  set mPluginProc ""
        }

	member get_inline_status {} 	{ return $mInline }
	member set_inline_status {arg} 	{ set mInline $arg }
	member get_plugin_type {} 	{ return $mPluginType }
	member set_plugin_type {arg} 	{ set mPluginType $arg }
	member get_plugin_file {} 	{ return $mPluginFile }
	member set_plugin_file {arg} 	{ set mPluginFile $arg }
	member get_plugin_proc {} 	{ return $mPluginProc }
	member set_plugin_proc {arg} 	{ set mPluginProc $arg }

        # Resolve variables in the plugin cmd block
	member resolve_plugin_vars {} {
          ::FFF::fff_member_init
	  if {$mPluginFile ne "" && [file isfile $mPluginFile]} {
	    $this->read_file $mPluginFile
	  }

          set FFFdbVarlist {}
          set var_count 0
          set lineNum 0
          for {set i 1} {$i <= [array size mPluginFileCmdArr]} {incr i} {
            incr lineNum
            set stepCommand $mPluginFileCmdArr($i)
            set token_list [split $stepCommand "$" ]
            set cmdtmp $stepCommand
            set elab_cmd ""

            set token_num 0
            foreach token $token_list {
              incr token_num
              set orig_token $token
              if {$token ne ""} {
                if {[regexp {vars\((.*?)\)} $token match submatch]} {
                  set resolvedValue [$this->resolve_var vars($submatch)]
                  if { $resolvedValue ne "-1" } {
                    incr var_count
                    lappend FFFdbVarlist "\$vars($submatch)"
                  } else {
                    $this->add_unresolved_vars "vars($submatch)"
                  }
                }; #end found a foundationflow var
              };# end $token ne ""
            };# end foreach token 
          };# end foreach line in mPluginFileCmdArr
          ::FFF::fff_member_close
          return [lsort -unique [::FFF::flatten_list $FFFdbVarlist]]
	};# end member resolve_plugin_vars

        #
        # Read a single file into the mPluginFileCmdArr array
	#
        member read_file {file} {
          ::FFF::fff_member_init
          #
          # reset the cmd array
          #
          array unset mPluginFileCmdArr
          array set mPluginFileCmdArr ""
 
          #
          # Check if the file exists, if not report an error
          #
          if {![file isfile $file]} {
            puts "ERROR: Plugin file $file not found. Please check the path specified in our Foundation Configuration File."
            return -1
          } else {
            set ISTREAM [open $file "r"]
            set lineno 1
            while {![eof $ISTREAM]} {
              gets $ISTREAM mPluginFileCmdArr($lineno)
              incr lineno
            }
	    # remove last line
	    array unset mPluginFileCmdArr [incr lineno -1]
          }
          ::FFF::dbg_puts "Completed reading of plugin file: $file"
        }
        member set_plugin_file_cmd_arr {cmdArr} {
          array unset mPluginFileCmdArr
          array set mPluginFileCmdArr $cmdArr
        }

        member get_plugin_file_cmd_arr {} {
          return [array get mPluginFileCmdArr]
        }

        member set_plugin_cmd {arg} {
          #::FFF::fff_member_init
          set mPluginCmd $arg
        }
        member get_plugin_cmd {} {
          #::FFF::fff_member_init
          return $mPluginCmd
        }

	member inline {} {
          ::FFF::fff_member_init
	  set resolvedValue [$this->resolve_var vars([$this->get_name])]
	  ::FFF::dbg_puts "resolvedValue of plug [$this->get_name]: $resolvedValue"
          if {[file isfile $resolvedValue]} {
	    ::FFF::dbg_puts "Found a file for plugin [$this->get_name]: $resolvedValue"
	    $this->set_plugin_type "file"
	    $this->set_plugin_file $resolvedValue
	    #
	    # read the file into the mPluginFileCmdArr array
	    #
	    $this->read_file $resolvedValue
	    
	    #
	    # set the command block of the step with the text of the plugin file from the mPluginFileCmdArr
	    #

            array set tmpCmdArr [$this->get_cmd_block]
            $this->set_cmd_block [array get mPluginFileCmdArr]

	  } elseif { [info commands ${::FFF::nonelabns}::$resolvedValue] ne ""} {
	    ::FFF::dbg_puts "Found a proc for plugin [$this->get_name]: $resolvedValue"
	    $this->set_plugin_type "proc"
	    $this->set_plugin_proc $resolvedValue
	    # build a command array using the proc body
	    set tmpString [info body ${::FFF::nonelabns}::$resolvedValue]
	    set lineno 1
	    foreach line [split $tmpString "\n"] {
              if {$lineno eq "1" && $line eq ""} {
		# skip first line if it's "" (this happens normally since most procs are declared
		# proc name {} { <--- newline
		#   <proc body>
		# } <--- newline
	      } else {
	        set tmpCmdArr($lineno) $line
	        incr lineno
 	      }
    	    }
	    # Remove the last line in tmpCmdArr if it's null
	    # See above example why the last line in a proc is normally null	
	    if {$tmpCmdArr([array size tmpCmdArr]) eq ""} {
	      array unset tmpCmdArr [array size tmpCmdArr]
	    }
	    # Set step block
            $this->set_cmd_block [array get tmpCmdArr]
	  } else {
	    dbg_puts "ERROR! Couldn't find a file or proc!"
	    puts "<FF> write_foundation_template ERROR: Attempting to inline plugin [$this->get_name] but couldn't find a file or proc."
            puts "<FF>   The plugin vars([$this->get_name]) was set to: \"$resolvedValue\""
	    puts "<FF>   The plugin variable must be set to a valid file or proc in a configuration file and read into the foundation flow applet."
            puts "<FF>   Use the syntax: 'set vars([$this->get_name]) <file name> or <proc name>'. A plugin file must be readable on the filesystem."
            puts "<FF>   Note: you can use 'write_foundation_template -noinline' or 'flows write -noinline' to avoid automatic inlining if the plugin will be added later."
	    return -code error
	  }
	}

	member outline {} {
          ::FFF::fff_member_init
          array set tmpCmdArr ""
	  ::FFF::dbg_puts "outlined [$this->get_name]"
          set resolvedValue [$this->resolve_var vars([$this->get_name])]
          ::FFF::dbg_puts "resolvedValue of plug [$this->get_name]: $resolvedValue"
          if {[file isfile $resolvedValue]} {
	    set tmpCmdArr(1) "source $resolvedValue"
	  } elseif {[info commands ${::FFF::nonelabns}::$resolvedValue] ne ""} {
	    set tmpCmdArr(1) "$resolvedValue"
 	  }
          $this->set_cmd_block [array get tmpCmdArr]
	}

        protected member resolve_variables_in_command {stepCommand} {
          ::FFF::fff_member_init
          set checkIsVarAList_list {}

          # Steps 1, 2
          if {[regexp {^\$} $stepCommand]} {
            set firstTokenIsAVariable 1
          } else {
            set firstTokenIsAVariable 0
  	  }

          set leading_ws ""
          if {[regexp {^([[:space:]]*).*} $stepCommand full leading_ws]} {}
          set token_num 0
          # create token list based on variables in the command
          # Note - token list will be of length 1 if there are no "$"
          set token_list [split $stepCommand]
          set cmdtmp $stepCommand
          set elab_cmd ""

          # This while loop goes through the entire command, searches and attempts to resolve all $vars.
          # if it cannot resolve a $var, it will be escaped
          # Lastly, it automatically places curlies and double quotes as appropriate
          # This loop is skipped if there are no $vars in the command

          set resolvedValue ""
          set token_num 1
          foreach token $token_list {
            set orig_token $token
            if {$token ne ""} {
              if {[regexp {\$vars\((.*?)\)} $token full variableName]} {
	 	#
                # We found a Foundation Flow Variable (i.e., $vars(...))
                # check each bound configuration for this variable
	 	#
                set resolvedValue [$this->resolve_var vars($variableName)]

		#
		# If the variable was not resolved by all bound configurations
		# set the unresolved flag for the plugin
		#
                if { $resolvedValue eq "-1" } {
                  $this->add_unresolved_vars "vars($variableName)"
                  $this->set_plugin_resolved_status 0
		  regsub {(\$vars\(.*?\))} $token {\1} token
                } else {
		  # BUDA 7/11/2011: NOTE: for the following "exceptions," we should have a final pass on
		  # the generated flow to make sure these variables are bound to this step,
	          # otherwise info exists and lindex will fail during script execution

	          #
	          # [info exists vars(...) ] test (never regsub)
	          #
	          set re "info exists vars\[(\]$variableName\[)\]"

		  #
	          # [lindex $vars(...)] test (never regsub)
		  #
	          set re2 "lindex.*vars\[(\]$variableName\[)\]"

                  # With variable resolved, we first decide whether to surround variable with curlies
                  if {[regexp $re $stepCommand]} {
		  } elseif {[regexp $re2 $stepCommand]} {
         	  } elseif {[regexp {^\s*(if.*)vars.*} $stepCommand] ||
                            [regexp {^\s*(for.*)vars.*} $stepCommand] ||
                            [regexp {^\s*(while.*)vars.*} $stepCommand] ||
                            [regexp {\[.*${variableName}.*\]} $stepCommand] } {
         	   # We are in an expression. Always add curlies/quotes
                    if {[::FFF::is_var_a_list $resolvedValue]} {
                      regsub {(vars\(.*?\))} $token {{\1}} token
                    }
         	   regsub {(\$vars\(.*?\))} $token $resolvedValue token
         	 } else {
                    if {[::FFF::is_var_a_list $resolvedValue]} {
                      regsub {(\$vars\(.*?\))} $token {{\1}} token
                    }
         	   regsub {(\$vars\(.*?\))} $token $resolvedValue token
                  }; # end regexp (is it an expression)
                }; # end if resolvedValue eq ""
              } else {
                # Not a Foundation Flow Variable, but a variable nonetheless, since we split on "$". This means we need to add "$" back in
                # The very first token is special: we only add in a "$" if it was already detected to be a variable
	        if {$token_num != 1 || $firstTokenIsAVariable} {
	          set token "$token"
  	        }
              }; # end not a vars match

              #
              # Force vars(rundir) to resolve
              #  Note that this typically happens when a variable has been resolved above, and includes $vars(rundir) as part of it's value.
              #  look vars vars(rundir) in the token through regular expressions, and subst it if found
	      #
	      regsub {\$vars\(rundir\)} $token "." token
	      # 5/14/2012 Force variable resolution, regardless of max line length
              set elab_cmd "${elab_cmd} ${token}"
            }; # end if token ne ""
            incr token_num
          }; # end foreach


          #
          # Fix leading WS
          #
          if {[regsub {^([[:space:]]*)} $elab_cmd $leading_ws elab_cmd]} { }

          # done - just return the fully resolved command
          return $elab_cmd
        }; # end member function resolve_variables_in_command()

        # This block converts the command (placeholder) in a plugin to source commands.
        # If the parameters cannot be resolved to files, it returns an error

	# Resolve variables used in the plugin command
	# Example: load_plugin $vars(some_plug)
        member resolve_plugin {calling_command} {
          # This is normally only called by elaborate_foundation
          
          ::FFF::fff_member_init
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}Initial Number of Commands: [$this->get_block_size]"}
          array set mStepResolvedArr {}
          array set tmpCmdArr {}
          set tmpCmdArrIndex 1
          set plug ""
          if {![array size mStepCmdArr] == 0} {
            if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}[array size mStepCmdArr] Commands to resolve."}
            # For each command, resolve the variables from parameter configuration, if one exists
            set anyPluginsNotFound 0
            for {set stepCmdNum 1} {$stepCmdNum <= [array size mStepCmdArr]} {incr stepCmdNum} {
              set origCmd $mStepCmdArr($stepCmdNum)
              if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}Processing line $stepCmdNum of [array size mStepCmdArr] (step commands): line: ->$origCmd<-"}
              regexp {load_plugin (.*)} $origCmd full plug
              if {![file isfile $plug]} {
                set pluginLine "source \$vars($plug)"
                if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} pluginLine: $pluginLine"}
                set resolvedValue [$this->resolve_var vars($plug)]
                if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} resolvedValue: $resolvedValue"}
                set resolved_string [$this->resolve_variables_in_command $pluginLine]
                if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} resolvedstring: $resolved_string"}
              } else {
                set resolved_string "source $plug"
              }
              if {[$this->get_plugin_resolved_status] eq 0} {
                puts "${calling_command}() ERROR: Unable to elaborate : $origCmd"
                puts "Not able to find the following plugin file(s) : [$this->get_unresolved_vars]"
                puts "Please fix the flow definition file and rerun code generation."
                puts "Exiting..."
                exit -1
              } else { 
                regexp {source (.*)} $resolved_string full pluglist
                set key "vars($plug)"
                set mStepResolvedArr($key) "$pluglist"
                set FileNotFoundList ""
                foreach plugin [::FFF::flatten_list $pluglist] { 
         	 # Code to determine if the plugin (file) exists
                  if {[file isfile $plugin]==0} {
         	   lappend FileNotFoundList $plugin
          	 } else {
                    set tmpCmdArr($tmpCmdArrIndex) "source $plugin"
          	    lappend mPluginFileList $plugin
                    incr tmpCmdArrIndex
          	 }
                }
                if {$FileNotFoundList ne ""} {
                  puts "${calling_command}() ERROR: Unable to elaborate : $origCmd"
                  puts "The following plugins were not found: $FileNotFoundList"
         	 if {[array size mResolvedVarArr] > 0} {
         	   foreach plugin $FileNotFoundList {
         	     set possibleVarList ""
         	     foreach {var value} [array get mStepResolvedArr] {
         	       if {[regexp -all $plugin $value]} {
         	         lappend possibleVarList $var
         	       }
         	     }	
         	     if {$possibleVarList ne ""} {
                        puts "Possible Variables used for this plugin:"
         	       foreach var $possibleVarList {
         	         puts "Var: $var, Value: $mStepResolvedArr($var)"
         	       }
         	     }
         	   }
         	 }
                  puts "Please fix the flow definition file and rerun code generation."
                  puts "Exiting..."
                  exit -1
                }
                unset FileNotFoundList
              }
            }; # end for loop
          };# end mStepCmdArr is empty
          $this->set_cmd_block [array get tmpCmdArr]
          array unset tmpCmdArr
          set tmpCmdArrIndex ""
          ::FFF::fff_member_close
        };# end member function resolve_plugin


        member write_plugin_script {args} {
          ::FFF::fff_member_init

          # Pull out default curlies from args list
          set args [flatten_list $args]
          dbg_puts "args: ->$args<-"

	  # Standard parse_options for write_script
	  # Note - we only grab the filename from parse_options for this member function
	  # The rest of the options are passed directly to the write_script member function of
	  # the step object.
          switch -- [parse_options [calling_proc] {} $args \
            "-trim_ws bos trim white space preceding the first non white space character in each line" trimWs \
            "-nocomments bos don't print comments" noComments \
            "-debug bos turn debug option on" debugOn \
            "-no_resolve bos don't resolve variables" noResolve \
            "-prefix sos prefix string to prepend to each line" prefixString \
            "-filename sos name of file to write to" fileName \
          ] {
            -2 { return }
            0 { error "Failed on [lindex [info level 0] 0]" }
          }

	  # Determine script name
          if {[$this->is_elaborated]} {
            if {$fileName ne ""} {
              set scriptName $fileName
            } else {
              set scriptName [$mParentStage->get_script_name]
            }
	  }

	  # Set plugin header/footer identifier string
	  set pluginIDString "[$this->get_plugin_type]: "
	  if {[$this->get_plugin_type] eq "file"} {
	    lappend pluginIDString [$this->get_plugin_file]
	  } else {
	    lappend pluginIDString [$this->get_plugin_proc]
	  }

          # write out the plugin header
          set OSTREAM [open $scriptName "a+"]
	  puts $OSTREAM "########## BEGIN PLUGIN $pluginIDString ##########"
	  close $OSTREAM

	  # write out the plugin body
	  $this->write_script $args

          # write out the plugin footer
          set OSTREAM [open $scriptName "a+"]
	  puts $OSTREAM "########## END PLUGIN $pluginIDString ##########"
	  close $OSTREAM
	}

        member set_plugin_resolved_status {arg} {
          #::FFF::fff_member_init
          set mPluginFullyResolvedFlag $arg
        }
        member get_plugin_resolved_status {} {
          return $mPluginFullyResolvedFlag
        }

        member ~Plugin {} {
          set dbgPrefixWs [string repeat " " [info level]]
          set msgPrefix "${dbgPrefixWs}[typeid]():"
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Deleting $this"}
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Removing ($this) (pubThis: $pubThis)from ::FFF::stepInst_objid_arr"}
          array unset ::FFF::plugin_objid_arr $pubThis
          if {[info exists ::FFF::plugin_objid_arr($pubThis)]} {
#            if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} INTERNAL ERROR: ($this) still exists in ::FFF::stepInst_objid_arr with value: $::FFF::stepInst_objid_arr($this)"}
          }
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Current Steps: ->[get_step -instances -basename [$this->get_base_name] -non_elab]<-"}
        }
      };# end Object Plugin Declaration
    };# end uplevel 1
  }; # end proc define_plugin_object
}; # end namespace eval FFF
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [FFFStageInstanceObject.tcl]                                  #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @ #
#  Date        [01-11-2011]                                                  #
##############################################################################
# Define the Flow object (Class)

proc define_stage_instance_object {} {
  set dbgPrefixWs [string repeat " " [info level]]
  set msgPrefix "${dbgPrefixWs}[::FFF::getProcName]():"
  set Debug $::FFF::Debug
  #::FFF::dbg_puts "BEGIN"

  uplevel 1 {
    # #################################################################
    # Base Class: Stage
    # #################################################################

    object StageInst {
       public {
          var mPublicStageInstVar
       }
       private {
          var mPriveateStageInstVar
       }
       member StageInst {{Name "anonymous"}} {
         set dbgPrefixWs [string repeat " " [info level]]
         set msgPrefix "${dbgPrefixWs}[typeid]():"
         set stageName $Name

         inherit Stage $stageName
	 # To use peekObj, we make the inherited class a friend of the base class
	 friend Stage
       }
       virtual member get_stage_prev_step {} {
         ::FFF::fff_member_init
         ::FFF::dbg_puts "head  of stage [$this->get_name] is [$mHead->get_name]($mHead)"
         set val [$mHead->prev]
         return $val
       }
       member ~StageInst {} {
         set dbgPrefixWs [string repeat " " [info level]]
         set msgPrefix "${dbgPrefixWs}[typeid]():"
#         if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Deleting $this"}
       }
    };# end Object StageInst Declaration
  };# end uplevel 1
}; # end proc define_stage_instance_object

##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [FFFStageIteratorObject.tcl]                                  #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
# Define the Flow object (Class)

proc define_stageiterator_object {} {
  set dbgPrefixWs [string repeat " " [info level]]
  set msgPrefix "${dbgPrefixWs}[::FFF::getProcName]():"
  set Debug $::FFF::Debug
  #::FFF::dbg_puts "BEGIN"

  uplevel 1 {
    # Iterator Class
    # Iterators belong to a stage list, and have a current position
    object StageIterator {
       private {
          var mStage
          var mPos
          var mTail
       }
       member StageIterator {stageObj {pos "NULL"} {tail "NULL"} } {
          set mStage $stageObj
          set mPos $pos
          set mTail $tail
       }
       member ~StageIterator {} {
       }
       # get the current position
       member current {} {
          return $mPos
       }
       # change the position of the iterator to the prev position
       member prev {} {
          if {$mPos eq "NULL"} {
             # If we are passed the tail position, set the previous to the tail position
             set mPos $mTail
          } else {
            if { [$mPos->prev] ne "NULL"} {
              # Move the position back one
              set mPos [$mPos->prev]
            } else {
              puts "WARNING: Cannot go back further. Already at the beginning of the list"
            }
          }
       }
       member begin {} {
         set mPos $mStage->begin
       }
       member equals {otherIterator} {
          if {($mStage eq [$otherIterator->list]) &&
              ($mPos eq [$otherIterator->current])} {
             return 1
          } else {
             return 0
          }
       }
       # change the position of the iterator to the next node
       member next {} {
          if {$mPos ne "NULL"} {
             set mPos [$mPos->next]
          } else {
            puts "WARNING: NO NEXT! CURRENT POSITION IS NULL"
          }
       }
       member printStats {} {
         puts "Stage: $mStage"
         puts "Position: $mPos Value: [$mPos->get]"
         puts "Last: $mTail Value: [$mTail->get]"
       }
       member get {} {
         return $mPos->get
       }
       member list {} {
         return $mStage
       }
    }
  }
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [FFFStageObject.tcl]                                         #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
# Define the Flow object (Class)
# #################################################################
# Base Class: Step
# #################################################################

proc define_stage_object {} {
  set dbgPrefixWs [string repeat " " [info level]]
  set msgPrefix "${dbgPrefixWs}[::FFF::getProcName]():"
  set Debug $::FFF::Debug
  #::FFF::dbg_puts "BEGIN"

  uplevel 1 {

    object Stage {
       protected {
          var mHead
          var mTail
          var mSize 0
          var stepArrHead
          var stepArrTail
          var mscriptNameBase
          var mscriptName
          var mtoolName
          var mRequiredStagesList
	  var mScriptExt
	  var mtoolArgs
          var mPrintStageHeader
          var mStageInstArr
          var mStepInstArr
       }
       member Stage {{Name "anonymous"}} {
         set dbgPrefixWs [string repeat " " [info level]]
         set msgPrefix "${dbgPrefixWs}[typeid](constructor):"
	 set stageName $Name
         inherit Step $stageName

         ::FFF::fff_member_init
         ::FFF::dbg_puts "new Stage [$this->get_name] $this"
  
         # Create a fake head and tail (to be populated later)
         set stepArrHead(1) "FAKEHEAD"
         set stepArrTail(1) "FAKETAIL"
         #::FFF::dbg_puts "about to create steps"
         set mHead [new Step "FAKEHEAD"]
         $mHead->set_cmd_block [array get stepArrHead]
         set mTail [new Step "FAKETAIL"]
         $mTail->set_cmd_block [array get stepArrTail]
         #::FFF::dbg_puts "HEAD: [$mHead->get_name]"
         #::FFF::dbg_puts "TAIL: [$mTail->get_name]"
         set mName $stageName
	 set mScriptExt "tcl"
         set mscriptNameBase ""
         set mscriptName ""
         set mtoolName ""
	 set mtoolArgs ""
         set mConfigList {}
	 set mParentPath ""
         set mParamConfigID ""
         set mPrintStageHeader 1
         set mBaseName ""
	 set mParentStage ""
         set mSize 0
	 array set mStageInstArr ""
         array set mStepInstArr ""
         array set mResolvedConfigArr ""

         #::FFF::dbg_puts "is empty (does not contain steps. Head and Tail Steps are both fake)"
         #::FFF::dbg_puts "head Step is [$mHead->get_name] (Object ID: $mHead)"
         #::FFF::dbg_puts "tail Step is [$mTail->get_name] (Object ID: $mTail)"
         $mHead->next $mTail
         $mTail->prev $mHead
         #::FFF::dbg_puts "set next step of head of stage to [[$mHead->next]->get_name]"
         #::FFF::dbg_puts "set prev step of tail of stage to [[$mTail->prev]->get_name]"
         #::FFF::fff_member_close
       }      

       #
       # Step Instance ID Management
       # This section is to manage step instance creation and deletion
       #
   
       member get_step_status {stepId} {
         return [$mStepInstArr($stepId)->get_status]
       }
       member get_steps {} {
         set step_ID_list {}
         foreach stepObjID [lsort -dictionary [array names mStepInstArr]] {
           lappend step_ID_list "$stepObjID"
         }
         return $step_ID_list
       }

       member get_step {args} {
         # Import parse options (see if we can do this for the object itself, not for every member function (!)
         if {[llength [info commands $::ns(compat)::parse_options]]} {
           if {![llength [info commands parse_options]]} {
             namespace import $::ns(parse_opt)::parse_options
           }
         }
	 if {![llength [info commands flatten_list]]} {
	   namespace import ::FFF::flatten_list
         }

	 set args [flatten_list $args]
         switch -- [parse_options [calling_proc] {} $args \
           "-basename sos Exact original step base name (original name, will not include _u\# suffixes)" myBaseName \
           "-id sos Return the name of a step given it's object ID as an argument" myStepObjID \
           "-regexp sos Filter step names using regular expression syntax" myRegExp \
           "sos Exact (possibly uniquified) step name, which may include _u\# suffixes" myStepName \
         ] {
           -2 { return }
           0 { error "Failed on [lindex [info level 0] 0]" }
         }

         while {[string match -* [lindex $args 0]] } {
           set option [lindex $args 0]
           set args [lrange $args 1 end]
           switch -exact -- $option {
             -id {
               set step_id [lrange $args 0 0]
               set args [lrange $args 1 end]
               return [lindex [array get mStepInstArr $step_id] 1]
             }
  	     -basename {
  	       # Return all steps with the exact same basename
  	       set match_step_list {}
               set basename [lrange $args 0 0]
               set args [lrange $args 1 end]
               foreach stepObjID [$this->get_steps] {
  	         if {$basename eq [$stepObjID->get_base_name]} {
                   lappend match_step_list $stepObjID
                 }
               }
	       if {$match_step_list ne ""} {
                 return $match_step_list
	       } else {
                 return -1
	       }
  	     }
             -regexp {
  	       # Return glob style match of steps 
               set match_step_list {}
               set re [lrange $args 0 0]
               set args [lrange $args 1 end]
               foreach stepObjID [$this->get_steps] {
                 if {[regexp $re [$stepObjID->get_name]]} {
                   lappend match_step_list $stepObjID
                 }
               }
               return $match_step_list
             }
             default {
               return -code error "[$this->get_name]->get_step(): unknown option \"$option\""
             }
           };# switch
         };# while
       };# end proc get_step

       member list_step_ids {} {
         return [array names mStepInstArr]
       }
       member clear_step_instance_arr {} {
         ::FFF::fff_member_init
	 ::FFF::dbg_puts "Stage Instance: $this"
         #foreach stepObjID [array names mStepInstArr] {
         #  delete $stepObjID
         #}
         array unset mStepInstArr
	 array set mStepInstArr {}
         ::FFF::fff_member_close
       }

       member set_step_arr {stepInstArr} {
         ::FFF::fff_member_init
         array set mStepInstArr $stepInstArr
       }
       member get_step_arr {} {
         return [array get mStepInstArr]
       }

       #
       # Stage Instance ID Management
       # This section is to manage stage instance creation and deletion
       #

       member get_stage_status {stageId} {
         return [$mStageInstArr($stageId)->get_status]
       }
       member get_stages {} {
         set stage_ID_list {}
         foreach stageObjID [lsort -dictionary [array names mStageInstArr]] {
           lappend stage_ID_list "$stageObjID"
         }
         #puts "the list: $stage_ID_list"
         return $stage_ID_list
       }
       member list_stage_ids {} {
         return [array names mStageInstArr]
       }
       member clear_stage_instance_arr {} {
         ::FFF::fff_member_init
         #foreach stageObjID [array names mStageInstArr] {
	 #  set baseID [$stageObjID->upcast Stage]
         #  #delete $stageObjID
	 #  delete $baseID
         #}
         array unset mStageInstArr
	 array set mStageInstArr {}
         ::FFF::fff_member_close
       }

       member set_stage_arr {stageInstArr} {
         array set mStageInstArr $stageInstArr
       }
       member get_stage_arr {} {
         return [array get mStageInstArr]
       }

       ###member set_resolved_config {configArr} {
       ###  #::FFF::fff_member_init
       ###  array set mResolvedConfigArr $configArr
       ###  #::FFF::fff_member_close
       ###}
       ###member add_resolved_config {var config} {
       ###  #::FFF::fff_member_init
       ###  #::FFF::dbg_puts "Setting resolved config for $var to [$config->get_name]"
       ###  set mResolvedConfigArr($var) $config
       ###  #::FFF::fff_member_close
       ###}

       ###member get_parent_stage {} {
       ###  #::FFF::fff_member_init
       ###  return $mParentStage
       ###}
       ###member set_parent_stage {stageObjID} {
       ###  #::FFF::fff_member_init
       ###  set mParentStage $stageObjID
       ###}

       ###member resolve_var {Var} {
       ###  ::FFF::fff_member_init
       ###  if {$Var eq "FFStageName"} {
       ###    #::FFF::dbg_puts "Reserved FF Variable (FFStageName) which resolves to->[[$this->get_parent_stage]->get_name]<-"
       ###    #::FFF::fff_member_close
       ###    return [[$this->get_parent_stage]->get_name]
       ###  }
       ###  #::FFF::dbg_puts "Configurations bound to stage [$this->get_name]:"
       ###  foreach configObjID [$this->get_configurations] {
       ###    #::FFF::dbg_puts "[$configObjID->get_name]"
       ###  }
       ###  foreach configObjID [$this->get_configurations] {
       ###    if {[$configObjID->get_name] eq ""} {
       ###      puts "elaborate_foundation() ERROR: Configuration: $configObjID bound to stage [$this->get_name] but does not exist."
       ###      puts "elaborate_foundation() Exiting ..."
       ###      exit 1
       ###    }
       ###    #::FFF::dbg_puts "***Checking configuration [$configObjID->get_name]"
       ###    set tracking_ns [$configObjID->get_var_tracking_namespace]
       ###    set ns_var_list ${tracking_ns}::mVarArray
       ###    set var_ns [$configObjID->get_var_namespace]
       ###    if {[array exists ${var_ns}::$Var]} {
       ###      #::FFF::dbg_puts "Found array $Var in ${var_ns} with value: [array get ${var_ns}::$Var]"
       ###      $this->add_resolved_config $Var $configObjID
       ###      #::FFF::fff_member_close
       ###      return  [array get ${var_ns}::$Var]
       ###    } elseif {[info exists ${var_ns}::$Var]} {
       ###      #::FFF::dbg_puts "Found variable $Var in ${var_ns} with value: ->[set ${var_ns}::$Var]<-"
       ###      #::FFF::dbg_puts "Setting resolved config for var $Var to ->[$configObjID->get_name]<-"
       ###      $this->add_resolved_config $Var $configObjID
       ###      #::FFF::fff_member_close
       ###      return [set ${var_ns}::$Var]
       ###    } else {
       ###      #::FFF::dbg_puts "Did not find $Var defined in [$configObjID->get_name]"
       ###    }
       ###  };# end foreach configuration
       ###  # At this point, if we have not returned from the function, it means we have not resolved the Var
       ###  # Indicate this, and return with "-1"
       ###  #::FFF::dbg_puts "Did not find $Var defined in any of the configurations:"
       ###  foreach configObjID [$this->get_configurations] {
       ###    #::FFF::dbg_puts "[$configObjID->get_name]"
       ###  }
       ###  #::FFF::fff_member_close
       ###  return "-1"
       ###};# end member function resolve_var

       member get_size {} {
         return $mSize
       }
       ###member bind_to_config {configurationID} {
       ###  #::FFF::fff_member_init
       ###  lappend mConfigList $configurationID
       ###  #::FFF::dbg_puts "$msgPrefix bound to [$configurationID->get_name]"
       ###  #::FFF::dbg_puts "END"
       ###}
       member get_print_stage_header_flag {} {
         return $mPrintStageHeader
       }
       member set_print_stage_header_flag {value} {
         set mPrintStageHeader $value
       }
       ###member set_param_config_id {configID} {
       ###  set mParamConfigID $configID
       ###}
       ##member get_param_config_id {} {
       ##  return $mParamConfigID
       ##}
       ###member set_base_name {name} {
       ###  #::FFF::fff_member_init
       ###  set mBaseName $name
       ###  #::FFF::dbg_puts "END"
       ###}
       ###member get_base_name {} {
       ###  #::FFF::fff_member_init
       ###  return $mBaseName
       ###  #::FFF::dbg_puts "END"
       ###}

       member set_script_basename {name} {
	 #::FFF::fff_member_init
	 set mscriptNameBase $name
	 #::FFF::fff_member_close
       }
       member get_script_basename {} {
	 #::FFF::fff_member_init
	 return $mscriptNameBase
         #::FFF::dbg_puts "END"
       }
       member set_script_ext {extension} {
	 #::FFF::fff_member_init
	 set mScriptExt $extension
         #::FFF::dbg_puts "END"
       }
       member get_script_ext {} {
	 #::FFF::fff_member_init
	 return $mScriptExt
         #::FFF::dbg_puts "END"
       }
       member set_tool_args {args} {
	 #::FFF::fff_member_init
         while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $args full args ]} {
         }
         #::FFF::dbg_puts "set_tool_args(): setting to $args"
	 set mtoolArgs $args
         #::FFF::dbg_puts "END"
       }
       member get_tool_args {} {
	 #::FFF::fff_member_init
	 return $mtoolArgs
         #::FFF::dbg_puts "END"
       }
       ###member set_parent_path {path} {
       ###  #::FFF::fff_member_init
       ###  #::FFF::dbg_puts "Setting parentPath to $path"
       ###  set mParentPath $path
       ###  #::FFF::dbg_puts "END"
       ###}
       ###member get_parent_path {} {
       ###  #::FFF::fff_member_init
       ###  return $mParentPath
       ###  #::FFF::dbg_puts "END"
       ###}
       virtual member copy_to {{newObjID}} {
	 ::FFF::fff_member_init
         set msgPrefix "${dbgPrefixWs}[typeid]([$this->get_name])->[::FFF::getProcName]"
         if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}Copying Stage [$this->get_name] ($this) to new ID: ($newObjID)"}

         # Copy private data of $this to another Stage object
         #$newObjID->set_size $mSize
         $newObjID->set_configurations $mConfigList
         $newObjID->set_tool $mtoolName
         $newObjID->set_tool_args $mtoolArgs
#         if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix   current (copy from) base name: ->$mBaseName<-"}
         $newObjID->set_base_name $mBaseName
         $newObjID->set_script_name $mscriptName
         $newObjID->set_print_stage_header_flag $mPrintStageHeader
         #$newObjID->set_step_arr [array get mStepInstArr]

	 #
	 # Clone Steps
	 #
	 array set trackStepInstArr {}
         set newStepPrev "NULL"
         set newStepNext "NULL"

         set posIter [$this->begin]
         while { [$posIter->current] ne "NULL" } {
	   set sid [$posIter->current]
#           if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix   Processing original step: $sid type: [$sid->typeid]"}
           set StepBaseName [$sid->get_base_name]
	   #
	   # Creates a new StepInst or PluginInst:
	   # 
           if {$sid->typeid] eq "PluginInst"} {
	     set newStepID [new PluginInst $StepBaseName]
	   } else { 
	     set newStepID [new StepInst $StepBaseName]
   	   }

           #
           # Copy this steps contents to the new Step
	   #$newStepID->set_cmd_block [$sid->get_cmd_block]
	   $sid->copy_to $newStepID

	   # Copy the inline status
           if {$newStepID->typeid] eq "PluginInst"} {
	     $newStepID->set_inline_status [$sid->get_inline_status]
           }

	   #
	   # Insert the Step into the Copied-to Stage
	   # 
	   $newObjID->insert_step $newStepID

           #
           # Register the Step in the StepInstance array
	   #
           set ::FFF::stepInst_objid_arr($newStepID) [$newStepID->get_name]
	   #
	   # For internal reporting
	   #
	   set trackStepInstArr($sid) $newStepID

#           if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix    Cloned Step [$sid->get_name]: $sid -> $newStepID"}
           $posIter->next
         }

	 # ####################################################
         # End of Member Function Reporting
	 # ####################################################
#         if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix Copied Object Definition $this to object instance $newObjID, which included the following:"}
#         if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix CHECK: Step Instances copied:"}
         set posIter [$this->begin]
         while { [$posIter->current] ne "NULL" } {
	   set sid [$posIter->current]
#           if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix    [$sid->get_name] $sid --> $trackStepInstArr($sid)"}
           $posIter->next
         }
#         if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix    CHECK Cloned Step Head [$newObjID->get_head]"}
#         if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix    CHECK Cloned Step Tail [$newObjID->get_tail]"}
#         if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix Configuration List Copied: ->[$newObjID->get_configurations]<-"}
#         if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix Script Name Copied: ->[$newObjID->get_script_name]<-"}
#         if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix Base Name Copied: ->[$newObjID->get_base_name]<-"}
         ::FFF::dbg_puts "END"
       }

       member is_empty {} {
	 ::FFF::fff_member_init
         #::FFF::dbg_puts "mHead: $mHead"
         #::FFF::dbg_puts "mTail: $mTail"
         #if {[$mHead->get_name] eq "FAKEHEAD"} {
         #  ::FFF::dbg_puts "$mName is an empty Stage"
	 #  return 1
	 #} else {
         #  ::FFF::dbg_puts "$mName is NOT an empty Stage"
         #  ::FFF::dbg_puts "HEAD: $mHead ([$mHead->get_name])"
         #  ::FFF::dbg_puts "Tail: $mTail ([$mTail->get_name])"
	 #  return 0
         #}
	 if {[array size mStepInstArr] == 0} {
	   return 1
	 } else {
	   return 0
         }
       }
       
  

       member set_stage_prev_step {StepID} {
         ::FFF::fff_member_init
         ::FFF::dbg_puts "mhead: ->$mHead<-"
         $mHead->prev $StepID
       }

       member set_stage_next_step {StepID} {
         ::FFF::fff_member_init
         ::FFF::dbg_puts "mhead: ->$mHead<-"
         $mHead->next $StepID
       }
       virtual member get_stage_prev_step {} {
         ::FFF::fff_member_init
         ::FFF::dbg_puts "mhead: ->$mHead<- of Stage $this"
         set val [$mHead->prev]
         return $val
       }
       member get_stage_next_step {} {
         ::FFF::fff_member_init
         ::FFF::dbg_puts "mTail: ->$mTail<-"
         set val [$mTail->next]
         return $val
       }
       member reset_steps {} {
         ::FFF::fff_member_init
         ::FFF::dbg_puts "Resetting $mName steps to init state for Stage: $this"
         # BUDA: 6/25/2011 TBD:
         # Before we do the following, we need to iterate through the linked list and delete all step and subsequent stage instances
         # inorder to preserve mememory.
         # Create a fake head and tail (to be populated later)
         set stepArrHead(1) "FAKEHEAD"
         set stepArrTail(1) "FAKETAIL"
         set mHead [new Step "FAKEHEAD"]
	 $mHead->set_cmd_block [array get stepArrHead]
         set mTail [new Step "FAKETAIL"]
         $mTail->set_cmd_block [array get stepArrTail]

         $mHead->next $mTail
         $mTail->prev $mHead
	 set mSize 0
	 ::FFF::fff_member_close
       }

       ###member set_name {stageName} {
       ###  #::FFF::fff_member_init
       ###  set mName $stageName
       ###}
       member set_size {size} {
	 #::FFF::fff_member_init
         set mSize $size
       }
       member get_tool {} {
         return $mtoolName
       }
       member set_tool {toolName} {
	 #::FFF::fff_member_init
         set mtoolName $toolName
	 # Don't set the script name here. Because the user can set the script name, this must now be done independently
	 #set mscriptNameBase "${mName}.${mtoolName}.${mScriptExt}"
	 #set mscriptName $mscriptNameBase
         #::FFF::dbg_puts "END"
       }
       member set_script_name {name} {
	 #::FFF::fff_member_init
         set mscriptName $name
	 #::FFF::dbg_puts "${msgPrefix}: Setting mscriptName to: $mscriptName"
         #::FFF::dbg_puts "END"
       }
       member get_script_name {} {
	 #::FFF::fff_member_init
         return $mscriptName
       }
       ###member set_instance_name {instanceName} {
       ###  ::FFF::fff_member_init
       ###  set mInstanceName $instanceName
       ###  # Don't set the script name here. It is now (4/4/2011) done independently
       ###  #set mscriptNameBase "${mInstanceName}.${mtoolName}.${mScriptExt}"
       ###  #set mscriptName $mscriptNameBase
       ###}
       ###member get_instance_name {} {
       ###  if {[info exists mInstanceName]} {
       ###    return $mInstanceName
       ###  } else {
       ###    return ""
       ###  }
       ###}
       ###member set_configurations {configIDList} {
       ###  #::FFF::fff_member_init
       ###  set mConfigList $configIDList
       ###}
       member set_required_stage_list {stageList} {
	 ::FFF::fff_member_init
         set mRequiredStagesList $stageList
       }
       ###member get_name {} {
       ###  if {[info exists mName]} {
       ###    return $mName
       ###  } else {
       ###    return "NOTNAMED"
       ###  }
       ###}
       member get_head {} {
	 #::FFF::fff_member_init
         return $mHead
       }
       member get_tail {} {
	 #::FFF::fff_member_init
         return $mTail
       }
       member set_head {newHead} {
	 ::FFF::fff_member_init
         set mHead $newHead
       }
       member set_tail {newTail} {
	 ::FFF::fff_member_init
         set mTail $newTail
       }
       ###member get_configurations {} {
       ###   return $mConfigList
       ###}
       member add_step {newStepObjID} {
	 ::FFF::fff_member_init
         ::FFF::dbg_puts "Stage $this"
         #control::assert {[$newStepObjID->upcast Step] ne ""}
  
         # If the head of the list is undefined, set it to the new Node
         # Note - if the head is fake, so is the tail
         if { [$mHead->get_name] eq "FAKEHEAD"} {
           ::FFF::dbg_puts "Inserting first REAL node in stage"
           set mHead $newStepObjID
           # Note: $mHead->next defaults to NULL, so no change needed
         } else {
         # If the head is defined, the tail is good.
         # set the next node of the current tail Node to the new element
         # (effective appending the new element to the list)
           ::FFF::dbg_puts "DEBUG: Appending node: $newStepObjID \"[$newStepObjID->get_name]\" to last node $mTail \"[$mTail->get_name]\""
           $mTail->next $newStepObjID
           # Define the new tail node
         }
         set mTail $newStepObjID
         incr mSize
         ::FFF::dbg_puts "Stage->add_step(): List Size: $mSize"
       }
       member remove_step {StepInstObjID {args ""}} {
	 ::FFF::fff_member_init

         if {[get_step -id $StepInstObjID] ne "-1"} {
           # If we are removeing the first step, reset the head to the next step
           if {$StepInstObjID eq $mHead} {
             ::FFF::dbg_puts "Deleting Head"
             # Set the new Head to the next step
             set mHead [$StepInstObjID->next]
           } elseif {$StepInstObjID eq $mTail} {
             ::FFF::dbg_puts "Deleting Tail"
             set mTail [$StepInstObjID->prev]
           } else {
             # else, we are inserting somewhere between the head and the tail
             # Reset the prev/next nodes of the current previous and next steps to the new step
             # and set the prev/next node of the new step
             set prevStepObjID [$StepInstObjID->prev]
             set nextStepObjID [$StepInstObjID->next]
             # Complete the link
             $prevStepObjID->next $nextStepObjID
             $nextStepObjID->prev $prevStepObjID
           }
           # delete the old step object from the object namespace
	   delete $StepInstObjID
         }
       }
       member insert_step {newStepInstObjID {args ""}} {
         set Debug $::FFF::Debug
	 ::FFF::fff_member_init

	 # By default, print step headers:
	 set noStepHeaderFlag 0

	 # List of all steps inserted
	 set insertedStepObjIDList ""
    
         set mStepInstArr($newStepInstObjID) [$newStepInstObjID->get_name]

         dbg_puts "StepObjID to insert: $newStepInstObjID Type: [$newStepInstObjID->typeid]"
          # Pseudo Code
          # Determine if insertion point exists (valid for -before and -after)
          # If it exists, set iterator to insertion point
          # for previous, change "next" to new stepID
          # for next, change "previous" to new stepID
         while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $args full args ]} {
         }
         proc maxStepArgMsg {} {
           puts "insert_step() ERROR: More than one location argument specified!"
           puts "insert_step() Only one argument (-before|-after|-begin|-end) is allowed per insert_step command."
           puts "insert_step() The step will not be inserted."
         }
         proc stepDoesNotExistMsg {stepObjID} {
           puts "insert_step() ERROR: The specified step does not exist: $stepObjID"
         }
         set step_target_location_specified 0
         if {$args ne ""} {
             while {[string match -* [lindex $args 0]] } {
                 set option [lindex $args 0]
                 #::FFF::dbg_puts "checking option: ->$option<-"
                 set args [lrange $args 1 end]
                 switch -exact -- $option {
                  -before {
		     ::FFF::dbg_puts "Inserting step [$newStepInstObjID->get_name] before ->$args<- (stepIDs) in stage [$this->get_name]"
                     if {$step_target_location_specified == 0} {
		       ::FFF::dbg_puts "Current head of [$this->get_name]($this): [$mHead->get_name]($mHead)"
		       ::FFF::dbg_puts "Current tail of [$this->get_name]($this): [$mTail->get_name]($mTail)"
                       # removing inclosing curlies...
                       while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $args full args ]} {
                       }
                       foreach nextStepObjID [split $args " "] {
		         if {[lsearch [$this->get_steps] $nextStepObjID] ne "-1"} {
                           ::FFF::dbg_puts "Processing step [$nextStepObjID->get_name] ($nextStepObjID)"
                           #
                           # For each insertion, we need to make a new instance of the step object
			   #
                           ::FFF::dbg_puts "Attempting to insert Step Object. Automatically generating a new Step instance to insert..."

			   # This is to supporing inserting a plugin instance in a stage
                           if {[$newStepInstObjID->typeid] eq "PluginInst"} {
                             ::FFF::dbg_puts "Attempting to insert PluginInst Object"
                             set stepObjID [new PluginInst [$newStepInstObjID->get_name]]
                           } else {
                             set stepObjID [new StepInst [$newStepInstObjID->get_name]]
                           }
			   lappend insertedStepObjIDList $stepObjID

                           $stepObjID->set_base_name [$newStepInstObjID->get_name]
	                   $newStepInstObjID->copy_to ${stepObjID}
			   # Replicate inline status
                           if {[$newStepInstObjID->typeid] eq "PluginInst"} {
			     $stepObjID->set_inline_status [$newStepInstObjID->get_inline_status]
			   }
                           ::FFF::dbg_puts "Created new step instance [$stepObjID->get_name]($stepObjID) and added to stepInst_objid_arr"
                           set ::FFF::stepInst_objid_arr($stepObjID) [$newStepInstObjID->get_name]
                           ::FFF::dbg_puts "Changing ID from $newStepInstObjID to $stepObjID for the rest of this member function..."

			   #
                           # If we are inserting before the first step, reset the head
			   #
                           if {$nextStepObjID eq $mHead} {
                             ::FFF::dbg_puts "Inserting before first step, so resetting head to [$stepObjID->get_name]"
                             $mHead->prev $stepObjID
                             $stepObjID->next $mHead
                             set mHead $stepObjID
			     #::FFF::dbg_puts "New head: [$mHead->get_name]($mHead)"
			     #::FFF::dbg_puts "Cur tail: [$mTail->get_name]($mTail)"
                           } else {
                             ::FFF::dbg_puts "Inserting [$stepObjID->get_name] here:"
			     ::FFF::dbg_puts ""
                             ::FFF::dbg_puts "[[$nextStepObjID->prev]->get_name]([$nextStepObjID->prev])"
                             ::FFF::dbg_puts " -->  [$stepObjID->get_name]($stepObjID)"
                             ::FFF::dbg_puts "[$nextStepObjID->get_name]($nextStepObjID)"
			     ::FFF::dbg_puts ""
                             # else, we are inserting somewhere between the head and the tail
                             # Reset the prev/next nodes of the current previous and next steps to the new step
                             # and set the prev/next node of the new step
                             set prevStepObjID [$nextStepObjID->prev]
                             $prevStepObjID->next $stepObjID
                             $nextStepObjID->prev $stepObjID
                             $stepObjID->prev $prevStepObjID
                             $stepObjID->next $nextStepObjID
			     ::FFF::dbg_puts "Inserted [$stepObjID->get_name] between [$prevStepObjID->get_name] ($prevStepObjID) and [$nextStepObjID->get_name] ($nextStepObjID)"
                           }
                           # shift args by 1 for further processing
                           set args [lrange $args 1 end]
                         } else {
                           stepDoesNotExistMsg $nextStepObjID
                         }
                         incr mSize
                       };# End foreach
                       incr step_target_location_specified
                     } else {
                       maxStepArgMsg
                     }
                     ::FFF::dbg_puts "End Processing -before switch for $nextStepObjID"
                   }
                  -after {
                     ########## NOTE: Need to copy while / foreach loops from -before section to this section ###############
                     if {$step_target_location_specified == 0} {
		       ::FFF::dbg_puts "Current head of [$this->get_name]($this): [$mHead->get_name]($mHead)"
		       ::FFF::dbg_puts "Current tail of [$this->get_name]($this): [$mTail->get_name]($mTail)"
                       # removing inclosing curlies...
                       while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $args full args ]} {
                       }
                       foreach prevStepObjID [split $args " "] {
		         if {[lsearch [$this->get_steps] $prevStepObjID] ne "-1"} {
                           ::FFF::dbg_puts "Processing step [$prevStepObjID->get_name] ($prevStepObjID)"

                           #
                           # For each insertion, we need to make a new instance of the step object
			   #
                           ::FFF::dbg_puts "Attempting to insert Step Object. Automatically generating a new Step instance to insert..."
                           if {[$newStepInstObjID->typeid] eq "PluginInst"} {
                             ::FFF::dbg_puts "Attempting to insert PluginInst Object"
                             set stepObjID [new PluginInst [$newStepInstObjID->get_name]]
                           } else {
                             set stepObjID [new StepInst [$newStepInstObjID->get_name]]
                           }

			   lappend insertedStepObjIDList $stepObjID

                           $stepObjID->set_base_name [$newStepInstObjID->get_name]
	                   $newStepInstObjID->copy_to ${stepObjID}
			   # Replicate inline status
                           if {[$newStepInstObjID->typeid] eq "PluginInst"} {
			     $stepObjID->set_inline_status [$newStepInstObjID->get_inline_status]
			   }
                           ::FFF::dbg_puts "Created new step instance [$stepObjID->get_name]($stepObjID) and added to stepInst_objid_arr"
                           set ::FFF::stepInst_objid_arr($stepObjID) [$newStepInstObjID->get_name]
                           ::FFF::dbg_puts "Changing ID from $newStepInstObjID to $stepObjID for the rest of this member function..."

			   #
                           # If we are inserting after the last step, reset the tail of the stage
			   #
                           if {$prevStepObjID eq $mTail} {
                             ::FFF::dbg_puts "Inserting after last step, so resetting tail to [$stepObjID->get_name]"
                             $mTail->next $stepObjID
                             $stepObjID->prev $mTail
                             set mTail $stepObjID
			     ::FFF::dbg_puts "Cur head: [$mHead->get_name]($mHead)"
			     ::FFF::dbg_puts "New tail: [$mTail->get_name]($mTail)"
                           } else {
                             # else, we are inserting somewhere between the head and the tail
                             # Reset the prev/next nodes of the current previous and next steps to the new step
                             # and set the prev/next node of the new step
                             ::FFF::dbg_puts "Inserting [$stepObjID->get_name] here:"
			     ::FFF::dbg_puts ""
                             ::FFF::dbg_puts "[$prevStepObjID->get_name]($prevStepObjID)"
                             ::FFF::dbg_puts " -->  [$stepObjID->get_name]($stepObjID)"
                             ::FFF::dbg_puts "[[$prevStepObjID->next]->get_name]([$prevStepObjID->next])"
			     ::FFF::dbg_puts ""
                             set nextStepObjID [$prevStepObjID->next]
                             $prevStepObjID->next $stepObjID
                             $nextStepObjID->prev $stepObjID
                             $stepObjID->prev $prevStepObjID
                             $stepObjID->next $nextStepObjID
			     ::FFF::dbg_puts "Inserted [$stepObjID->get_name] between [$prevStepObjID->get_name] ($prevStepObjID) and [$nextStepObjID->get_name] ($nextStepObjID)"
                           }
                           # shift args by 1 for further processing
                           set args [lrange $args 1 end]
                         } else {
                           stepDoesNotExistMsg $prevStepObjID
                         }
                         incr mSize
                         incr step_target_location_specified
 		       };# end foreach
                     } else {
                       maxStepArgMsg
                     }
                   }
                   -begin {
		     ::FFF::dbg_puts "Inserting step [$newStepInstObjID->get_name] at beginning of stage [$this->get_name]"
                     if {$step_target_location_specified == 0} {
		       #::FFF::dbg_puts "Current head of [$this->get_name]: [$mHead->get_name]"
		       #::FFF::dbg_puts "Current tail of [$this->get_name]: [$mTail->get_name]"
                       if { [$mHead->get_name] eq "FAKEHEAD"} {
                         # The current stage is empty. Set the new object to be the head and tail
                         set mHead $newStepInstObjID
                         set mTail $newStepInstObjID
			 #::FFF::dbg_puts "New head: [$mHead->get_name]"
			 #::FFF::dbg_puts "New tail: [$mTail->get_name]"
                       } else {
                         ::FFF::dbg_puts "PROCESSING to INSERT AT BEGINNING oF STAGE"
                         $mHead->prev $newStepInstObjID
                         $newStepInstObjID->next $mHead
                         set mHead $newStepInstObjID
			 #::FFF::dbg_puts "New head: [$mHead->get_name]"
                       }
		       lappend insertedStepObjIDList $newStepInstObjID
                       incr mSize
                       incr step_target_location_specified
                     } else {
                         maxStepArgMsg
                     }
                   }
                   -end {
		     ::FFF::dbg_puts "Inserting Step [$newStepInstObjID->get_name] at end of stage [$this->get_name]"
                     if {$step_target_location_specified == 0} {
		       #::FFF::dbg_puts "Current head of [$this->get_name]: [$mHead->get_name]"
		       #::FFF::dbg_puts "Current tail of [$this->get_name]: [$mTail->get_name]"
                       if { [$mHead->get_name] eq "FAKEHEAD"} {
                         # The current stage is empty. Set the new object to be the head and tail
                         set mHead $newStepInstObjID
                         set mTail $newStepInstObjID
			 #::FFF::dbg_puts "New head: [$mHead->get_name]"
			 #::FFF::dbg_puts "New tail: [$mTail->get_name]"
                       } else {
                         $mTail->next $newStepInstObjID
                         $newStepInstObjID->prev $mTail
                         set mTail $newStepInstObjID
			 #::FFF::dbg_puts "New tail: [$mTail->get_name]"
                       }
		       lappend insertedStepObjIDList $newStepInstObjID
                       incr mSize
                       incr step_target_location_specified
                     } else {
                       maxStepArgMsg
                     }
                   }
                   -instance {
                     set iName [lrange $args 0 0]
                   }
                   -readme {
                     puts $::fcf_header::README;
                     return
                   }
                   -help {
                     puts $::fcf_header::README;
                     return
                   }
                   -regexp {
                     set match_step_list {}
                     set re [lrange $args 0 0]
                     set args [lrange $args 1 end]
                     set complete_arr_index_list [lsearch -glob [array get ::FFF::step_objid_arr] $re]
                     foreach idx $complete_arr_index_list {
                       lappend match_step_list [lindex [array get ::FFF::step_objid_arr] $idx]
                     }
                   }
		   -no_step_header {
		     set noStepHeaderFlag 1
		   }
                   default {
                     return -code error "${msgPrefix} unknown option \"$option\""
                   }
                 };# switch
             };# while
         }; # args ne ""
         if {$step_target_location_specified == 0} {
            ::FFF::dbg_puts "no location specified for step. inserting at end"
            #No location args provided. Default location will be at the end of the stage (after the current tail)
            if { [$mHead->get_name] eq "FAKEHEAD"} {
              # The current stage is empty. Set the new object to be the head and tail
              ::FFF::dbg_puts "Setting head and tail to $newStepInstObjID"
              set mHead $newStepInstObjID
              set mTail $newStepInstObjID
            } else {
              ::FFF::dbg_puts "inserting new step [$newStepInstObjID->get_name] after [$mTail->get_name]"
              $mTail->next $newStepInstObjID
              $newStepInstObjID->prev $mTail
              set mTail $newStepInstObjID
              #::FFF::dbg_puts "head: [$mHead->get_name] ($mHead)"
              #::FFF::dbg_puts "tail: [$mTail->get_name] ($mTail)"
              incr step_target_location_specified
            }
            incr mSize
         }
  
	 # Go through created steps and set the step header print setting
	 # to false if it was specified
	 if {$noStepHeaderFlag} {
	   foreach stepID $insertedStepObjIDList {
	     $stepID->set_print_step_header_flag 0
	   }
	 }
         # Increment the step counter of the stage
         ::FFF::dbg_puts "Stage [$this->get_name] length: $mSize"
         #::FFF::dbg_puts "END insert_step([$newStepInstObjID->get_name])"
       };# end member function insert_step
  
       ###################### BEGIN INSERT STAGE ############################
       # When Stages are inserted in Stages, the following happens
       # The Head (step) of the inserted Stage is linked to the Stage it is inserted into
       # The Tail (step) of the inserted Stage is linked to the Stage it is inserted into
       # NOTE: We need to update printing to query whether a given step is also the head
       # or tail of a substage.
       # If the user requests a single process top level stage, then all steps are printed in the same
       # tcl file.
       # Else we need to tag stages for multiprocess execution, meaning that even though stages
       # are inserted in one another (so there is effectively one long stage), we still want
       # to extract out the substages for execution.
       virtual member insert_stage {NewStageInstObjID {args ""}} {
	 set Debug $::FFF::Debug
         ::FFF::fff_member_init
          # Pseudo Code
          # Determine if insertion point exists (valid for -before and -after)
          # If it exists, set iterator to insertion point
          # for previous, change "next" to new stepID
          # for next, change "previous" to new stepID
         while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $args full args ]} {
         }
         ::FFF::dbg_puts "BEGIN Inserting [$NewStageInstObjID->typeid] [$NewStageInstObjID->get_name] into [$this->typeid] [$this->get_name] with args: ->$args<-"
         if {$NewStageInstObjID ne ""} {
           if {[$NewStageInstObjID->typeid] eq "Stage"} {
             ::FFF::dbg_puts "NewStageInstObjID is a Stage: ->$NewStageInstObjID<-"
           } elseif {[$NewStageInstObjID->typeid] eq "Step" || \
		     [$NewStageInstObjID->typeid] eq "StepInst" || \
		     [$NewStageInstObjID->typeid] eq "Plugin" || \
		     [$NewStageInstObjID->typeid] eq "PluginInst"} {
             ::FFF::dbg_puts "ERROR NewStageInstObjID is a Step or Plugin: ->$NewStageInstObjID<-. Use insert_step/load_plugin instead"
             puts "insert_stage() ERROR: Attemping to insert a stage into a step. This is not allowed."
             puts "insert_stage()   Stages may only be inserted inside stages or flows."
             return -code error "insert_stage(): Attepted to insert stage into step."
           }
         }

         set NewStageHeadStepObjID [$NewStageInstObjID->get_head]
         set NewStageTailStepObjID [$NewStageInstObjID->get_tail]
         ::FFF::dbg_puts "Head of Stage [$NewStageInstObjID->get_name] is: [$NewStageHeadStepObjID->get_name] ($NewStageHeadStepObjID)"
         ::FFF::dbg_puts "Tail of Stage [$NewStageInstObjID->get_name] is: [$NewStageTailStepObjID->get_name] ($NewStageTailStepObjID)"
         proc maxStepArgMsg {} {
           puts "insert_stage() ERROR: More than one location argument specified!"
           puts "insert_stage() Only one argument (-before|-after|-begin|-end) is allowed per insert_stage command."
           puts "insert_stage() The step will not be inserted."
         }
         proc stepDoesNotExistMsg {stepObjID} {
           puts "insert_stage() ERROR: The specified step does not exist: $stepObjID"
         }
         set step_target_location_specified 0
         if {$args ne ""} {
             while {[string match -* [lindex $args 0]] } {
                 set option [lindex $args 0]
                 set args [lrange $args 1 end]
                 ::FFF::dbg_puts "insert_stage(): insert_stage option: $option, args: $args"
                 switch -exact -- $option {
                  -before {
                     puts "Hit -before switch"
                     if {$step_target_location_specified == 0} {
                       # removing inclosing curlies...
                       while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $args full args ]} {
                       }
                       foreach nextStepObjID [split $args " "] {
  
  		       # NOTE! THIS SECTION IS PROBABLY BROKEN
  		       # NEED TO MAKE SURE ALL OBJECT IDS ARE UNIQUE TO AVOID CIRCULAR REFERENCES
  
                         puts "Processing nextStepObjID: $nextStepObjID"
                         #set nextStepObjID [lrange $args 0 0]
                         if {[get_step -id $nextStepObjID] ne "-1"} {
                           # If we are inserting before the first step, reset the head
                           if {$nextStepObjID eq $mHead} {
                             $mHead->prev $NewStageHeadStepObjID
                             $NewStageTailStepObjID->next $mHead
                             set mHead $NewStageHeadStepObjID
                           } else {
                             # else, we are inserting somewhere between the head and the tail
                             # Reset the prev/next nodes of the current previous and next steps to the new step
                             # and set the prev/next node of the new step
                             set prevStepObjID [$nextStepObjID->prev]
                             $prevStepObjID->next $NewStageHeadStepObjID
                             $nextStepObjID->prev $NewStageTailStepObjID
                             $NewStageHeadStepObjID->prev $prevStepObjID
                             $NewStageTailStepObjID->next $nextStepObjID
                           }
                           # shift args by 1 for further processing
                           set args [lrange $args 1 end]
                         } else {
                           stepDoesNotExistMsg $prevStepObjID
                         }
                       incr mSize
                       };# End foreach
                       incr step_target_location_specified
                     } else {
                       maxStepArgMsg
                     }
                   }
                  -after {
                     ########## NOTE: Need to copy while / foreach loops from -before section to this section ###############
                     if {$step_target_location_specified == 0} {
                       set prevStepObjID [lrange $args 0 0]
                       if {[get_step -id $prevStepObjID] ne "-1"} {
                         # If we are inserting after the last step, reset the tail of the stage
                         if {$prevStepObjID eq $mTail} {
                           $mTail->next $NewStageHeadStepObjID
                           $newStepObjID->prev $mTail
                           set mTail $newStepObjID
                         } else {
                           # else, we are inserting somewhere between the head and the tail
                           # Reset the prev/next nodes of the current previous and next steps to the new step
                           # and set the prev/next node of the new step
                           set nextStepObjID $prevStepObjID->next
                           $prevStepObjID->next $newStepObjID
                           $nextStepObjID->prev $newStepObjID
                           $newStepObjID->prev $prevStepObjID
                           $newStepObjID->next $nextStepObjID
                         }
                         # shift args by 1 for further processing
                         set args [lrange $args 1 end]
                       } else {
                         stepDoesNotExistMsg $prevStepObjID
                       }
                       incr mSize
                       incr step_target_location_specified
                     } else {
                       maxStepArgMsg
                     }
                   }
                   -begin {
                     if {$step_target_location_specified == 0} {
                       if { [$mHead->get_name] eq "FAKEHEAD"} {
                         # The current stage is empty. Set the new object to be the head and tail
                         set mHead $newStepObjID
                         set mTail $newStepObjID
                       } else {
                         ::FFF::dbg_puts "PROCESSING to INSERT AT BEGINNING OF STAGE"
                         $mHead->prev $newStepObjID
                         $newStepObjID->next $mHead
                         set mHead $newStepObjID
                       }
                       incr mSize
                       incr step_target_location_specified
                     } else {
                         maxStepArgMsg
                     }
                   }
                   -end {
                     if {$step_target_location_specified == 0} {
                       if { [$mHead->get_name] eq "FAKEHEAD"} {
                         # The current stage is empty. Set the new object to be the head and tail
                         set mHead $NewStageHeadStepObjID
                         set mTail $NewStageTailStepObjID
                       } else {
                         ::FFF::dbg_puts "PROCESSING TO INSERT AT END OF STAGE"
			 ::FFF::dbg_puts "Current HEAD: $mHead"
			 ::FFF::dbg_puts "Current TAIL: $mTail"
			 if {[$NewStageHeadStepObjID->get_name] eq "FAKEHEAD"} {
                           ::FFF::dbg_puts "Inserting empty stage into a stage at end."
                           ::FFF::dbg_puts "Setting the inserted stage HEAD to the TAIL of the stage it is being inserted into: ->$mTail<-"
			   $NewStageInstObjID->set_head $mTail
			   if {$mTail ne "NULL"} {
                             ::FFF::dbg_puts "Setting the empty stage TAIL to the next step the TAIL of the stage it is being inserted into is pointing to."
			     $NewStageInstObjID->set_tail [$mTail->next]
 			   } else {
                             ::FFF::dbg_puts "Setting the empty stage TAIL to the TAIL of the stage it is being inserted into is pointing to."
			     $NewStageInstObjID->set_tail $mTail
			   }
			 } else {
                           ::FFF::dbg_puts "Inserting a non-empty stage into a stage at end."
                           ::FFF::dbg_puts "Linking the stages by setting the inserted stage HEAD->prev to the TAIL of the stage it is being inserted into"
			   $NewStageHeadStepObjID->prev $mTail
                           ::FFF::dbg_puts "Performing reverse link: current stage tail->next being set to head of inserted stage"
                           $mTail->next $NewStageHeadStepObjID
			 }
			 ::FFF::dbg_puts "Final HEAD: $mHead"
			 ::FFF::dbg_puts "Final TAIL: $mTail"
                       }
                       incr step_target_location_specified
                     } else {
                       maxStepArgMsg
                     }
                   }
                   -instance {
                     set iName [lrange $args 0 0]
                   }
                   -readme {
                     puts $::fcf_header::README;
                     return
                   }
                   -help {
                     puts $::fcf_header::README;
                     return
                   }
                   -regexp {
                     set match_step_list {}
                     set re [lrange $args 0 0]
                     set args [lrange $args 1 end]
	   	     set complete_arr_index_list [lsearch -glob [array get ::FFF::step_objid_arr] $re]
                     foreach idx $complete_arr_index_list {
                       lappend match_step_list [lindex [array get ::FFF::step_objid_arr] $idx]
                     }
                   }
                   default {
                     return -code error "insert_step: unknown option \"$option\""
                   }
                 };# switch
             };# while
         }; # args ne ""
         if {$step_target_location_specified == 0} {
            ::FFF::dbg_puts "No location specified for step. inserting at end"
            #No location args provided. Default location will be at the end of the stage (after the current tail)
            if { [$mHead->get_name] eq "FAKEHEAD"} {
              # The current stage is empty. Set the new object to be the head and tail
              ::FFF::dbg_puts "Setting head to $NewStageHeadStepObjID and tail to $NewStageTailStepObjID"
              set mHead $NewStageHeadStepObjID
              set mTail $NewStageTailStepObjID
              ::FFF::dbg_puts "New mHead for stage [$this->get_name] id: $this : $mHead"
              ::FFF::dbg_puts "New mTail for stage [$this->get_name] id: $this : $mTail"
            } else {
              ::FFF::dbg_puts "Inserting new stage $NewStageInstObjID after $mTail"
              $mTail->next $NewStageHeadStepObjID
              $NewStageHeadStepObjID->prev $mTail
              set mTail $NewStageTailStepObjID
              ::FFF::dbg_puts "New mHead for stage [$this->get_name] id: $this : $mHead"
              ::FFF::dbg_puts "New mTail for stage [$this->get_name] id: $this : $mTail"
              incr step_target_location_specified
            }
            incr mSize
         }
  
         # Increment the step counter of the stage
         ::FFF::dbg_puts "Size: $mSize"
         ::FFF::dbg_puts "END ->insert_stage object: $NewStageInstObjID args: $args"
         ::FFF::fff_member_close
       }; # end member insert_stage
  
  
       ###################### END INSERT STAGE ##############################
  
  
  
       member begin {} {
	 #::FFF::fff_member_init
         # Create a new iterator and pass it the private version of the
         # "this" value so that it can directly access private variables
         # (similar to a friend class in C++)
         return [new StageIterator $this $mHead $mTail]
       }
       member end {} {
	 ::FFF::fff_member_init
         return [new StageIterator $this "NULL"]
       }
       virtual member size {} {
         return $mSize
       }
       virtual member print {args} {
	 ::FFF::fff_member_init
         set Debug $::FFF::Debug
         set prefix_switch ""
         set debug_switch ""
         set trim_ws_switch ""
	 set resolve_vars_switch ""

         if {[array exists ::FFF::elabdb::flow_objid_arr]} {
           array set flow_objid_arr [array get ::FFF::elabdb::flow_objid_arr]
           set elaborated 1
         } else {
           array set flow_objid_arr [array get ::FFF::flow_objid_arr]
           set elaborated 0
         }

         ::FFF::dbg_puts "Stage::print($this): BEGIN: args: $args"
         regexp {\{(.*)\}} $args full args
  
         if {$args ne ""} {
           while {[string match -* [lindex $args 0]] } {
#             #if {$Debug} {puts "Stage::print(): begin of while loop. \$args: $args"}
             set option [lindex $args 0]
#             #if {$Debug} {puts "Stage::print(): setting option to: ->$option<-"}
             set args [lrange $args 1 end]
#             #if {$Debug} {puts "Stage::print(): setting new arg list: $args"}
             switch -exact -- $option {
               -no_resolve {
                  set resolve_vars_switch "-no_resolve"
               }
               -trim_ws {
                  set trim_ws_switch "-trim_ws"
                }
               -debug {
                  set debug_switch "-debug"
                  puts "Stage ID: $this"
                }
               -prefix {
                 set prefix [lrange $args 0 0]
                 # Wierd problem that i haven't gotten to the bottom of with arg processing
                 # For some reason " " get's converted to {}
                 # This is a quick hack to convert back to " "
                 #regsub -all {\{([[:space:]]*)\}} $prefix {"\1"} prefix
                 regsub -all {\{([[:space:]]*)\}} $prefix {\1} prefix
#                 #if {$Debug} {puts "Stage::print(): setting prefix to ->$prefix<-"}
                 set args [lrange $args 1 end]
                 set prefix_switch "-prefix \"$prefix\""
                 ::FFF::dbg_puts "Stage::print(): prefix_switch is ->$prefix_switch<-"
               }
             }
           }
#           #if {$Debug} {puts "Stage::print():  end of while loop"}
         }
  
         set posIter [$this->begin]
         #puts "### Stage([$this->get_name]):"

	 # If pre-elab, simply print out the Stage
         # If post-elab, we need to fix instance names

	 if {$elaborated} {
           set str1 [$this->get_parent_path]::[$this->get_name]
	   regsub {::FFF::elabdb::} $str1 {/} str1
	   regsub {::} $str1 {/} str1
     	 } else {
           set str1 $mBaseName
	 }
	 set str2 Stage
         #set str3 [$this->get_configurations]
         set str3 [::FFF::fix_default_config_name $this]

         #puts "[$this->get_parent_path]::[$this->get_name]"
         puts [format "%-*s %-*s %*s" 30 $str1 20 $str2 20 $str3]
         while { [$posIter->current] ne "NULL" } {
           set stepName [[$posIter->current]->get_name]
           #puts "# Step: $stepName"
           ::FFF::dbg_puts "Step::print(): args passed: ->print $trim_ws_switch $prefix_switch $debug_switch<-"
           [$posIter->current]->print [::FFF::flatten_list [list $trim_ws_switch $prefix_switch $debug_switch $resolve_vars_switch]]
           $posIter->next
         }
       }

       member get_stepID_list {} {
         set step_list ""
         set posIter [$this->begin]
         while { [$posIter->current] ne "NULL" } {
           lappend setp_list [$posIter->current]
           $posIter->next
         }
	 return $step_list
       }

       member write_makefile_target {filename} {
	 ::FFF::fff_member_init
         set OSTREAM [open $filename "w"]
         # NOTE: No dependency checking  
         puts $OSTREAM "###########################################################"
         puts $OSTREAM "### Frontend Foundation Flow Generated Makefile"
         puts $OSTREAM "### Generated by:             Frontend Foundation Flow v$::FFF::fcf_version"
         puts $OSTREAM "### Generated on:             [clock format [clock seconds] -format "%I:%M:%S %p(%b%d)"]"
         puts $OSTREAM "### Flow:                     [$this->get_name]"
         puts $OSTREAM "###########################################################"
         puts $OSTREAM "all:"
         for {set stageCmdNum 1} {$stageCmdNum <= [array size mStepCmdArr]} {incr stageCmdNum} {
	   puts $OSTREAM "\t$mStepCmdArr($stageCmdNum);"
	 }
         puts $OSTREAM "\t$mtoolName $mtoolArgs $mscriptName"
         close $OSTREAM
	 puts "<FF> Wrote $filename"
       }

       member write_csh_target {filename} {
	 ::FFF::fff_member_init
         set OSTREAM [open $filename "w"]
         # NOTE: No dependency checking  
         puts $OSTREAM "###########################################################"
         puts $OSTREAM "### Frontend Foundation Flow Generated CSH Script"
         puts $OSTREAM "### Generated by:             Frontend Foundation Flow v$::FFF::fcf_version"
         puts $OSTREAM "### Generated on:             [clock format [clock seconds] -format "%I:%M:%S %p(%b%d)"]"
         puts $OSTREAM "### Flow:                     [$this->get_name]"
         puts $OSTREAM "###########################################################"
         puts $OSTREAM "# $mName:" 
         for {set stageCmdNum 1} {$stageCmdNum <= [array size mStepCmdArr]} {incr stageCmdNum} {
	   puts $OSTREAM "$mStepCmdArr($stageCmdNum)"
	 }
         puts $OSTREAM "$mtoolName $mtoolArgs $mscriptName"
         close $OSTREAM
	 puts "<FF> Wrote $filename"
	 catch {exec chmod +x $filename}
       }

       virtual member write_script {args} {
	 ::FFF::fff_member_init
	 dbg_puts "args: ->$args<-"
	 while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $args full args ]} {
	 };# end while

         set trim_ws_switch ""
         set debug_switch ""
         set prefix_switch ""
	 set comments_switch ""
	 set replace_switch ""
         set fileName ""
         set makefileName ""
         set makefile_name_switch ""
	 set file_name_switch ""
	 set resolve_vars_switch ""
         set noinline_switch ""
	 set myRunDir ""

         #
         # arg processing
         #
         if {$args ne ""} {
           while {[string match -* [lindex $args 0]] } {
             set option [lindex $args 0]
             set args [lrange $args 1 end]
             switch -exact -- $option {
	       -noinline {
		  set noinline_switch "-noinline"
	       } 
	       -nocomments {
		  set comments_switch "-nocomments"
	       } 
               -trim_ws {
                  set trim_ws_switch "-trim_ws"
               }
               -no_resolve {
                  set resolve_vars_switch "-no_resolve"
               }
               -debug {
                  set debug_switch "-debug"
               }
               -replace {
                  set replace_switch "-replace"
               }
               -overwrite {
                  set replace_switch "-replace"
               }
               -prefix {
                 set prefix [lrange $args 0 0]
                 # Wierd problem that i haven't gotten to the bottom of with arg processing
                 # For some reason " " get's converted to {}
                 # This is a quick hack to convert back to " "
                 #regsub -all {\{([[:space:]]*)\}} $prefix {"\1"} prefix
                 regsub -all {\{([[:space:]]*)\}} $prefix {\1} prefix
                 set args [lrange $args 1 end]
                 set prefix_switch "-prefix \"$prefix\""
               }
	       -filename {
	         set fileName [lrange $args 0 0]
                 set args [lrange $args 1 end]
	 	 set file_name_switch "-filename $fileName"
	       }
	       -makefilename {
	         set makefileName [lrange $args 0 0]
                 set args [lrange $args 1 end]
	 	 set makefile_name_switch "-makefilename $makefileName"
	       }
	       -rundir {
			 set myRunDir [lrange $args 0 0]
			 set args [lrange $args 1 end]
	       }
	     }
	   }
	 }

	 # First order of business is to determine the name of the script
	 # The name of the script can be set using the FCF command "set_script_name"
	 # In this case, the script name will be identical to this setiing as long as -overwrite is used with write_foundation_template.
	 # (if not, the script name will be auto-incremented based on the highest suffix number of incremented scripts with the same base name
	 # in the output directory.
	 #
	 # If no script name has been set, FFF shall use several defaults to specify a script name. In order these are:
	 # There are 3 components to the script name: <basename>.<extension>.<incr suffix>
	 # If the basename, toolname, are undefined, the basename defaults to the name of the stage ($mName)
	 # If the basename is undefined, but the toolname is defined, the basename defaults to $mName.$mtoolName
	 # If instance name is defined, it overrides mName in the above examples
	 #      No toolname: basename -> $instanceName
	 #      toolname:    basename -> $instanceName.$mtoolName
	 # If extension is defined, it replaces the default extension
	 # If -overwrite is supplied as an argument, the final basename.extension will not be autoincremented
	 # otherwise, FFF will analyze the scripts in the target output directory and automatically add/increment the suffix as required. 
	 # 
	 # basename should only be set by FCF::set_script_name
	 # mscriptName is only set by 'write_foundation' or 'write_script'
	 # Note - if the user were to write out the foundation database after executing the above, they would see that mscriptName was updated with the actual output name:

	 # For script names, mscriptName is the final name to print
	 if {$mscriptName eq ""} {
	   if {$mscriptNameBase eq ""} {
	     if {[$this->get_instance_name] eq ""} {
	       set mscriptName $mName
	     } else {
	       set mscriptName [$this->get_instance_name]
	     }
	   } else {
	     set mscriptName $mscriptNameBase
	   }
	   if {$mtoolName ne ""} {
	     set mscriptName ${mscriptName}.${mtoolName}
	   }
	   if {$mScriptExt ne ""} {
	     set mscriptName ${mscriptName}.${mScriptExt}
	   } else {
	     set mscriptName ${mscriptName}.${::FFF::myDefaultScriptExt}
	   }
	 }

	 #
	 # Set the name to fileName, or use mscriptName if it is undefined
	 #
	 if {$fileName eq ""} {
	   set fileName $mscriptName
	 }
	 # Now check and see if there are any files with this script name.
	 # If so, we need to advance the suffix number by 1 (or add a suffix if none exist)
	 if {$replace_switch eq ""} {
	   # Default behavior is to not overwrite scripts
	   set fileName [::FFF::generate_next_output_filename $fileName]
	 }
	 $this->set_script_name $fileName

	 # Set a new script name (to account for existing script names in the directory)
	 # Note - this method will have to be refined as we may want to write multiple stages to the same script
	 # when we have full support for hierarchical flows (in the future). For now assume 1Stage:1File approach

	 #
	 # Create file ostream
	 #
	 set OSTREAM [open $fileName "w"]

	 ::FFF::dbg_puts "write_script() writing file $fileName"

	 if {$mPrintStageHeader} {
	   puts $OSTREAM "###########################################################"
	   puts $OSTREAM "### Frontend Foundation Flow Script Generation ###"
	   puts $OSTREAM "### [clock format [clock seconds]]"
	   puts $OSTREAM "### Stage: [$this->get_name], Original code-generated file: $fileName"
	   puts $OSTREAM "### Length: [$this->size] Steps"
	   puts $OSTREAM "###########################################################"
	 }

	 # This entire section builds a list of all the variables used in this stage.
	 # More information can be generated by using the -debug switch to write_foundation_template
	 # (future enhancement).

	 set posIter [$this->begin]
	 #::FFF::dbg_puts "\$posIter = $posIter value: [$posIter->current]"
         set Debug $::FFF::Debug
	 set var_key_list ""
	 set var_cumulative_list {}
	 while { [$posIter->current] ne "NULL" } {
	   #::FFF::dbg_puts "LOOP BEGIN: \$posIter = $posIter value: [$posIter->current]"
	   set stepName [[$posIter->current]->get_name]
	   set var_list [[$posIter->current]->analyze_dependent_vars]
	   set var_key_list [[$posIter->current]->get_resolved_vars]
	   ::FFF::dbg_puts "Resolved vars for: $stepName"
	   foreach key $var_key_list {
	     lappend var_cumulative_list "\$$key"
	   }
	   $posIter->next
	 }

	 if {$mPrintStageHeader} {
	   puts $OSTREAM "# Variables affecting this Stage: ([llength [lsort -unique $var_cumulative_list]] total)"
	   puts $OSTREAM "#----------------------------------------------------------"
	   foreach var [lsort -unique $var_cumulative_list] {
	       puts $OSTREAM "# - $var"
	       ::FFF::dbg_puts "Stage->write_script()# - $var"
	   }
	   #puts "Done with analyze_dependent_vars"
	   puts $OSTREAM "###########################################################"
         }
	 close $OSTREAM

	 # Next we write out the stage. To do so, we iterate across the entire stage, and 
	 # use the write_script member function of each step object.
	 # This can be passed trim, prefix, and debug options.

	 set posIter [$this->begin]
	 while { [$posIter->current] ne "NULL" } {
	   set stepName [[$posIter->current]->get_name]
	   #
	   # Check if the step is a plugin
	   #
	   dbg_puts "Writing Step: $stepName ObjID: [$posIter->current]"
	   if {[[$posIter->current]->typeid] eq "PluginInst"} {
	     # Determine if the plugin is to be inlined (default is inlining)
	     if {$noinline_switch eq ""} {
	       ::FFF::dbg_puts "Inlining Requested. Inline status for [[$posIter->current]->get_name]: [[$posIter->current]->get_inline_status]"
	       if {[[$posIter->current]->get_inline_status]} {
	         if {[catch {[$posIter->current]->inline} errorMsg]} {
	           ::FFF::dbg_puts -print_stdout "<FF> Error writing stage [$this->get_name] during inlining of plugin [[$posIter->current]->get_name]."
	           ::FFF::dbg_puts "$errorMsg"
	           ::FFF::dbg_puts -print_stdout "Removing file $fileName"
	           file delete -force $fileName
	           return -code error
	         }
               }
	     } elseif {$noinline_switch eq "-noinline"} {
	       # Or outlining is requested (by -noinline) option
	       ::FFF::dbg_puts "Outlining requested. Inline status for [[$posIter->current]->get_name]: [[$posIter->current]->get_inline_status]"
	       if {[catch {[$posIter->current]->outline} errorMsg]} {
	         ::FFF::dbg_puts -print_stdout "<FF> Error writing stage [$this->get_name], plugin: [[$posIter->current]->get_name]."
	         ::FFF::dbg_puts "$errorMsg"
	         return -code error
	       }
   	     }
	     # Write out plugin block (includes header, step block, and footer
	     [$posIter->current]->write_plugin_script [::FFF::flatten_list [list $trim_ws_switch $prefix_switch $debug_switch $file_name_switch $comments_switch $resolve_vars_switch]]
	   } else {
	     # Write out step block
	     [$posIter->current]->write_script [::FFF::flatten_list [list $trim_ws_switch $prefix_switch $debug_switch $file_name_switch $comments_switch $resolve_vars_switch]]
	   }

	   #
	   # Reset cmd block to faciliate interactive debug
	   #
	   if {[[$posIter->current]->typeid] eq "PluginInst" && $noinline_switch eq ""} {
	     [$posIter->current]->outline
	   }
	   $posIter->next
	 }
	 # Print tail

	 if {$mPrintStageHeader} {
	   set OSTREAM [open $fileName "a"]
	   puts $OSTREAM "##### END Frontend Foundation Flow Script Generation for Stage: [$this->get_name] v$::FFF::fcf_version #####"
	   close $OSTREAM
	 }
	 if {[file exists $fileName]} {
	   puts "<FF> Wrote $fileName"
	 }

	 #
	 # Generate Makefile for single Stage
	 #
	 if {$makefile_name_switch ne ""} {
	   # Write header
	   set OSTREAM [open $makefileName "w"]
	   puts $OSTREAM "###########################################################"
	   puts $OSTREAM "### Frontend Foundation Flow Generated Makefile"
	   puts $OSTREAM "### Generated by:             Frontend Foundation Flow v$::FFF::fcf_version"
	   puts $OSTREAM "### Generated on:             [clock format [clock seconds] -format "%I:%M:%S %p(%b%d)"]"
	   puts $OSTREAM "### File:                     $makefileName"
	   puts $OSTREAM "### Stage:                    [$this->get_name]"
	   puts $OSTREAM "###########################################################"
	   foreach config [$this->get_configurations] {
	     lappend configNameList [$config->get_name]
	   }
	   puts $OSTREAM "# Configurations bound to this Stage: $configNameList" 
	   puts $OSTREAM "#----------------------------------------------------------"
           puts $OSTREAM ""
           close $OSTREAM

           # Next write the target for this (top level) stage into the Makefile:     
           $this->write_makefile_target $makefileName
           set OSTREAM [open $makefileName "a+"]
           puts $OSTREAM ""
           puts $OSTREAM "##### END Frontend Foundation Flow Makefile v$::FFF::fcf_version"
           close $OSTREAM

           if {[file exists $makefileName]} {
             puts "<FF> Wrote $makefileName"
           }
         }

	 ::FFF::fff_member_close
       };# end member write_script

       member ~Stage {} {
	 ::FFF::fff_member_init
	 ::FFF::dbg_puts "Deleting [$this->get_name] ($this)"
         while {$mHead ne "NULL"} {
            set next $mHead
            set mHead [$mHead->next]
            delete $next
         }
	 ::FFF::fff_member_close
       }
       member printStats {} {
	 ::FFF::fff_member_init
         puts "Head: $mHead, value: [$mHead->get_name]"
         puts "Tail: $mTail, value: [$mTail->get_name]"
         puts "Size: $mSize"
	 ::FFF::fff_member_close
       }
    }
  }
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [FFFStepInstanceObject.tcl]                                         #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
# Define the Step Instance object (Class)

proc define_step_instance_object {} {
  set dbgPrefixWs [string repeat " " [info level]]
  set msgPrefix "${dbgPrefixWs}[::FFF::getProcName]():"
  set Debug $::FFF::Debug
  #::FFF::dbg_puts "BEGIN"

  uplevel 1 {
    # #################################################################
    # Base Class: Step
    # #################################################################
    # When creating, the Step is not actually valid until 'instantiated' in a stage
    # This occurs throught the $stage->insert_step API.
    # When executed, a new StepInst object is created. 

    object StepInst {
       public {
	  var mPublicStepInstVar
       }
       private {
          var mPriveateStepInstVar
       }
       member StepInst {{Name "anonymous"}} {
         set dbgPrefixWs [string repeat " " [info level]]
         set msgPrefix "${dbgPrefixWs}[typeid]():"
         inherit Step $Name
	 friend Step
       }
       member ~StepInst {} {
         set dbgPrefixWs [string repeat " " [info level]]
         set msgPrefix "${dbgPrefixWs}[typeid]():"
#         if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Deleting $this"}
#         if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Removing ($this) (pubThis: $pubThis)from ::FFF::stepInst_objid_arr"}
         array unset ::FFF::stepInst_objid_arr $pubThis
         if {[info exists ::FFF::stepInst_objid_arr($pubThis)]} {
#           if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} INTERNAL ERROR: ($this) still exists in ::FFF::stepInst_objid_arr with value: $::FFF::stepInst_objid_arr($this)"}
         }
#         if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Current Steps: ->[get_step -instances -basename [$this->get_base_name] -non_elab]<-"}
       }
    };# end Object StepInst Declaration
  };# end uplevel 1
}; # end proc define_step_instance_object
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [FFFStepObject.tcl]                                         #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
# Define the Step object (Class)

proc define_step_object {} {
  set dbgPrefixWs [string repeat " " [info level]]
  set msgPrefix "${dbgPrefixWs}[::FFF::getProcName]():"
  set Debug $::FFF::Debug
  #::FFF::dbg_puts "BEGIN"

  uplevel 1 {
    # #################################################################
    # This is the base class for the following:
    #   StepInst
    #   Stage
    # #################################################################
    # When createing, the Step is not actually valid until 'instantiated' in a stage
    # This occurs throught the $stage->insert_step API.
    # When executed, a new StepInst object is created. 

    object Step {
       public {
	  var mConfigVars
       }
       protected {
	  # Basic Step Info
          var mNext
          var mPrev
          var mName
          var mBaseName
          var mStepCmdArr
	  # We save the original stepCmdArr in case we need to re-resolve parameters
          var mOrigStepCmdArr
          var mCreateFile
          var mInsertFile
          var mRow
          var mColumn
          var mInstanceName
	  # For hierarchy support:
          var mParentPath
	  var mParentStage
	  var mPrintStepHeader

	  # For Variable and Parameter Tracking
	  var mParamConfigID
          var mConfigList
          var mParamConfigList

	  # Vars that are used (in a step command line) but not resolved
          var mUnresolvedVars

	  # Vars that are required using -required_vars but do not appear in a step command line
	  var mUnusedRequiredVars

	  # mResolvedConfigArr:
	  #   Used mostly for debugging what configuration was used to resolve a variable
          #   key/value pair: <vars(name)> / <configuration ID>
	  var mResolvedConfigArr

	  # mResolvedVarArr:
	  #   Used mostly for debugging what values were resolved for a given variable
	  #   key/value pair: <vars(name)> / <variable value>
	  var mResolvedVarArr

	  var mResolvedParamConfigArr
	  var mResolvedParamArr
	  # For Required Files
          var mRequiredFilesArr
          var mRequiredVarsArr

	  # Overriding flag specifying that all vars in the step must be resolved
	  var mAllVarsRequiredFlag 
	  var mAllVarsRequiredSeverity

	  # Files that are used (in a step command line) but not found
	  # key: filename, value: original var (if any) or "" if not based on variable
          var mNotFoundFilesArr 
  
          # Files that have been found
	  # key: filename, value: original var (if any) or "" if not based on variable
	  var mFoundFilesArr

       }

       member get_all_vars_required_severity {} {
	 ::FFF::fff_member_init
	 return $mAllVarsRequiredSeverity
       }
       member set_all_vars_required_severity {severity} {
	 ::FFF::fff_member_init
	 set mAllVarsRequiredSeverity $severity
         ::FFF::dbg_puts "Set mAllVarsRequiredSeverity to $mAllVarsRequiredSeverity"
       }

       #
       # For each file in the required files list, resolve the variable (if it is one), then resolve the file
      
       member analyze_required_files {} {
         ::FFF::fff_member_init
	 set var ""
 	 foreach reqFileOrVar [array names mRequiredFilesArr] {
	   if {[regexp {vars\((.*)\)} $reqFileOrVar full submatch]} {
	     # Replace entry with the actual file name
	     set severity $mRequiredFilesArr($reqFileOrVar)
	     array unset mRequiredFilesArr $reqFileOrVar
	     set fileName [resolve_var "vars($submatch)"]
	     set mRequiredFilesArr($fileName) $severity
	     ::FFF::dbg_puts "Replacing entry in mRequiredFilesArr (old key: $reqFileOrVar): new key: ->$fileName<-"
	     set var $reqFileOrVar
	     ::FFF::dbg_puts "Will call resolve_file with ->$var<-"
	   } else {
	     set var ""
	     set fileName $reqFileOrVar
	   }
	   resolve_file $fileName $var
         }
         ::FFF::fff_member_close
       }

       #
       # Finding (or not) files
       #

       # Look for a file, and populate the mFoundFilesArr or mNotFoundFilesArr arrays accordingly.
       member resolve_file {{file "NONE"} {var ""}} {
         ::FFF::fff_member_init
	 if {$file ne "NONE"} {
 	   if {[file isfile $file]} {
	     set mFoundFilesArr($file) $var
	     ::FFF::dbg_puts "FILE $file found. Set mFoundFilesArr($file) to ->$var<-"
	   } else {
	     set mNotFoundFilesArr($file) $var
	     ::FFF::dbg_puts "FILE $file NOT FOUND. Set mNotFoundFilesArr($file) to ->$var<-"
	   }
	 } else {
	   puts "INTERNAL ERROR: illegal usage of resolve_file(). Please contact fed_applet_support@cadence.com"
	 }
         ::FFF::fff_member_close
       }

       member get_found_files_arr {} {
         ::FFF::fff_member_init
#         if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}Array: mFoundFilesArr ->[array get mFoundFilesArr]<-"}
         return [array get mFoundFilesArr]
       }
       member set_found_files_arr {arr} {
         ::FFF::fff_member_init
#         if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}Setting: mFoundFilesArr ->[array get arr]<-"}
         array set mFoundFilesArr $arr
       }
       member get_found_files {} {
         ::FFF::fff_member_init
         return [array names mFoundFilesArr]
       }
       member set_found_files {{fileName} {varName ""}} {
         ::FFF::fff_member_init
         set mFoundFilesArr($fileName) $varName
       }
       member add_notfound_file {{fileName} {varName ""}} {
         #::FFF::fff_member_init
#         #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}adding $arg to the Unresolved vars list for [$this->get_name]"}
         set mNotFoundFilesArr($fileName) $varName
       }
       member get_notfound_files {} {
         #::FFF::fff_member_init
         return [array names mNotFoundFilesArr]
       }
       member get_notfound_files_arr {} {
         #::FFF::fff_member_init
         return [array get mNotFoundFilesArr]
       }

       # End of file finding section

       member get_unused_required_files {} {
         ::FFF::fff_member_init
	 set unusedList ""
	 set resolvedList [array names mFoundFilesArr]
	 lappend resolvedList [array names mNotFoundFilesArr]
	 set resolvedList [lsort -uniq [::FFF::flatten_list $resolvedList]]
	 foreach reqFile [array names mRequiredFilesArr] {
	   if {[lsearch $resolvedList $reqFile] == "-1"} { 
	     lappend unusedList $reqFile 
	     ::FFF::dbg_puts "Found unused but required file: $reqFile"
	   }
	 }
	 ::FFF::dbg_puts "Final unused but required file list: $unusedList"
	 return $unusedList
       }

       #
       # Determine whether any vars specified using -required_vars were not actually used in the step (or object)
       member get_unused_required_vars {} {
         if {[catch {
         ::FFF::fff_member_init
	 set unusedList ""
	 set resolvedList [array names mResolvedVarArr]
	 lappend resolvedList $mUnresolvedVars
	 set resolvedList [lsort -uniq [::FFF::flatten_list $resolvedList]]
	 foreach reqVar [array names mRequiredVarsArr] {
	   if {[lsearch $resolvedList $reqVar] == "-1"} { 
	     lappend unusedList $reqVar 
	     ::FFF::dbg_puts "Found unused but required variable: $reqVar"
	   }
	 }
	 ::FFF::dbg_puts "Final unused but required variable list: $unusedList"
	 } errorMsg]} {
           dbg_puts "<FF> ERROR (INTERNAL):\n$errorMsg"
         }
	 return $unusedList
       }
  
       member are_all_vars_required {} {
         ::FFF::fff_member_init
	 return $mAllVarsRequiredFlag
       }
       member set_all_vars_required {{arg "1"}} {
         ::FFF::fff_member_init
	 if {$arg} {
	   set mAllVarsRequiredFlag 1
	 } elseif {$arg == 0} {
	   set mAllVarsRequiredFlag 0
         } else {
	   puts "INTERNAL ERROR: set_all_vars_required() passed illegal argument. Contact fed_applet_support@cadence.com"
	 }
       }
       # This is a simple helper function that creates look up entries
       #member convert_required_vars_keys_in_arr {} {
       #}
       # Required Vars
       member set_required_vars_severity {varsList severity} {
         ::FFF::fff_member_init
	 set mRequiredVarsArr($varsList) $severity
       }
       member get_required_vars_severity_arr {} {
         #::FFF::fff_member_init
         return [array get mRequiredVarsArr]
       }
       member update_required_vars_arr {Arr} {
         ::FFF::fff_member_init
         array set mRequiredVarsArr $Arr
       }
       member set_required_vars_arr {Arr} {
         ::FFF::fff_member_init
	 array unset mRequiredVarsArr
         array set mRequiredVarsArr $Arr
       }

       #
       # Required Files
       #
       member set_required_files_severity {fileList severity} {
         ::FFF::fff_member_init
	 set mRequiredFilesArr($fileList) $severity
       }
       member get_required_files_severity_arr {} {
         #::FFF::fff_member_init
         return [array get mRequiredFilesArr]
       }
       member set_required_files_arr {Arr} {
         ::FFF::fff_member_init
	 array unset mRequiredFilesArr
         array set mRequiredFilesArr $Arr
       }
       member update_required_files_arr {Arr} {
         ::FFF::fff_member_init
         array set mRequiredFilesArr $Arr
       }

       #

       member bind_to_param_config {configurationID} {
         lappend mParamConfigList $configurationID
       }
       member push_param_config {configurationID} {
         ::FFF::fff_member_init
         # Put the configID (argument) on the top of the config list
	 ::FFF::dbg_puts "set mParamConfigList from ->$mParamConfigList<- to:"
          set mParamConfigList [::FFF::flatten_list [list $configurationID $mParamConfigList]]
	 ::FFF::dbg_puts "->$mParamConfigList<-"
       }
       member get_param_configurations {} {
         return $mParamConfigList
       }
       member set_param_configurations {paramConfigIDList} {
         set mParamConfigList $paramConfigIDList
       }
       member set_orig_cmd_block {cmdArr} {
         ::FFF::fff_member_init
	 array unset mOrigStepCmdArr
         array set mOrigStepCmdArr $cmdArr
       }

       member get_orig_cmd_block {} {
         return [array get mOrigStepCmdArr]
       }
       member get_resolved_param_config_arr {} {
         return [array get mResolvedParamConfigArr]
       }

       member add_resolved_param_config {param config} {
	 set mResolvedParamConfigArr($param) $config
       }

       member set_resolved_params {{paramName} {paramValue}} {
         set mResolvedParamArr($paramName) $paramValue
       }
       member get_resolved_param_value_arr {} {
         return [array get mResolvedParamArr]
       }

       member is_empty {} {
         #::FFF::fff_member_init
         if {[$this->get_block_size] == 0 } {
#           #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}$mName is an empty Step"}
           return 1
         } else {
#           #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}$mName is NOT an empty Step"}
           return 0
         }
#         #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}END"}
       }
       
       member get_resolved_vars_arr {} {
	 ::FFF::fff_member_init
#	 if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}Array: mResolvedVarArr ->[array get mResolvedVarArr]<-"}
         return [array get mResolvedVarArr]
       }
       member set_resolved_vars_arr {arr} {
	 ::FFF::fff_member_init
#	 if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}Setting: mResolvedVarArr ->[array get arr]<-"}
         array set mResolvedVarArr $arr
       }
       member get_resolved_vars {} {
	 ::FFF::fff_member_init
#	 if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}Array: mResolvedVarArr ->[array get mResolvedVarArr]<-"}
         return [array names mResolvedVarArr]
       }
       member set_resolved_vars {{varName} {varValue}} {
	 ::FFF::fff_member_init
#	 if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}Setting: mResolvedVarArr($varName) to ->$varValue<-"}
         set mResolvedVarArr($varName) $varValue
       }
       member add_unresolved_vars {arg} {
	 #::FFF::fff_member_init
#	 #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}adding $arg to the Unresolved vars list for [$this->get_name]"}
         lappend mUnresolvedVars $arg
       }
       member get_unresolved_vars {} {
	 #::FFF::fff_member_init
         return $mUnresolvedVars
       }
       member set_print_step_header_flag {value} {
         #::FFF::fff_member_init
         set mPrintStepHeader $value
#         #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}set mPrintStepHeader to $mPrintStepHeader"}
         #::FFF::fff_member_close
       }
       virtual member get_print_step_header_flag {} {
         #::FFF::fff_member_init
#         #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}returning ->$mPrintStepHeader<-"}
         return $mPrintStepHeader
       }
       #member set_param_config_id {configID} {
       #  #::FFF::fff_member_init
       #  set mParamConfigID $configID
       #}
       #member get_param_config_id {} {
       #  #::FFF::fff_member_init
#       #  #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}returning to $mParamConfigID"}
       #  return $mParamConfigID
       #}
       member set_base_name {name} {
         ::FFF::fff_member_init
#         if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}Setting basename to $name"}
	 set mBaseName $name
         #::FFF::fff_member_close
       }
       member get_base_name {} {
         #::FFF::fff_member_init
	 return $mBaseName
       }

       member get_resolved_config_arr {} {
         return [array get mResolvedConfigArr]
       }

       member set_resolved_config {configArr} {
         #::FFF::fff_member_init
	 array set mResolvedConfigArr $configArr
         #::FFF::fff_member_close
       }
       member add_resolved_config {var config} {
         #::FFF::fff_member_init
#         #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}Setting resolved config for $var to [$config->get_name]"}
	 set mResolvedConfigArr($var) $config
         #::FFF::fff_member_close
       }
       member get_step_elab_ns {} {
         #::FFF::fff_member_init
#         if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}objectSpace is [$this->objectSpace]"}
         return [$this->objectSpace]
       }
       # Node Constructor
       member set_name {name} {
         #::FFF::fff_member_init
         set mName $name
         #::FFF::fff_member_close
       }
       member set_parent_path {path} {
         set dbgPrefixWs [string repeat " " [info level]]
         set msgPrefix "${dbgPrefixWs}[typeid]():"
#         if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}Setting parentPath to $path"}
         set mParentPath $path
       }
       member get_parent_path {} {
         set dbgPrefixWs [string repeat " " [info level]]
         set msgPrefix "${dbgPrefixWs}[typeid]():"
         return $mParentPath
       }
       member get_parent_stage {} {
         #::FFF::fff_member_init
         return $mParentStage
       }
       member set_parent_stage {stageObjID} {
         #::FFF::fff_member_init
         set mParentStage $stageObjID
       }
       virtual member copy_to {newObjID} {
         ::FFF::fff_member_init
         set Debug $::FFF::Debug
         #$newObjID->set_name $mName
	 #::FFF::dbg_puts "pathToNew_mName: $pathToNew_mName"
         #set pathToNew_mName [[peekObj $newObjID]->getVarPath mName]
	 #::FFF::dbg_puts "pathToNew_mName: $pathToNew_mName"
	 #set $pathToNew_mName $mName
	 # One liner:
	 set [[peekObj $newObjID]->getVarPath mName] $mName

         #$newObjID->set_base_name $mBaseName
         #set pathToNew_mBaseName [[peekObj $newObjID]->getVarPath mBaseName]
	 #set $pathToNew_mBaseName $mBaseName
	 # One liner:
	 set [[peekObj $newObjID]->getVarPath mBaseName] $mBaseName


         $newObjID->set_cmd_block [array get mStepCmdArr]
         $newObjID->set_orig_cmd_block [array get mOrigStepCmdArr]
         #$newObjID->set_resolved_config [array get mResolvedConfigArr]
         $newObjID->set_row $mRow
         $newObjID->set_column $mColumn
         $newObjID->set_create_file $mCreateFile
         $newObjID->set_insert_file $mInsertFile
         $newObjID->set_configurations $mConfigList

         #$newObjID->set_param_configurations $mParamConfigList
	 #set pathToNew_mParamConfigList [[peekObj $newObjID]->getVarPath mParamConfigList]
	 #set $pathToNew_mParamConfigList $mParamConfigList
	 # One liner:
	 set [[peekObj $newObjID]->getVarPath mParamConfigList] $mParamConfigList

         $newObjID->set_print_step_header_flag $mPrintStepHeader
         #$newObjID->set_resolved_vars_arr [array get mResolvedVarArr]


	 set [[peekObj $newObjID]->getVarPath mAllVarsRequiredFlag] $mAllVarsRequiredFlag
	 set [[peekObj $newObjID]->getVarPath mAllVarsRequiredSeverity] $mAllVarsRequiredSeverity

         # Required vars and files
	 #::FFF::dbg_puts "old obj required vars: ->[array get mRequiredVarsArr]<-"
	 #::FFF::dbg_puts "old obj required files: ->[array get mRequiredFilesArr]<-"
	 array set [[peekObj $newObjID]->getVarPath mRequiredFilesArr] [array get mRequiredFilesArr]
	 array set [[peekObj $newObjID]->getVarPath mRequiredVarsArr] [array get mRequiredVarsArr]
	 #::FFF::dbg_puts "new obj required vars: ->[$newObjID->get_required_vars_severity_arr]<-"
	 #::FFF::dbg_puts "new obj required files: ->[$newObjID->get_required_files_severity_arr]<-"
	 ::FFF::fff_member_close
       }
       member get_block_size {} {
         #::FFF::fff_member_init
         return [array size mStepCmdArr]
       }
       virtual member size {} {
         #::FFF::fff_member_init
         return [array size mStepCmdArr]
       }
       member set_row {rowNum} {
         #::FFF::fff_member_init
         set mRow $rowNum
       }
       member set_column {colNum} {
         #::FFF::fff_member_init
         set mColumn $colNum
       }
       member set_create_file {file} {
         set mCreateFile $file
       }
       member set_insert_file {file} {
         set mInsertFile $file
       }
       member Step {{Name "anonymous"}} {
         ::FFF::fff_member_init
         # mStepCmdArr is meant to take *any* text the user provides.
         # these array elements are not eval'd in TCL.

    	 array set mStepCmdArr ""
	 array set mOrigStepCmdArr ""
         set mName $Name
         # On construction, we always set the prev and next nodes to NULL.
         # These are only set when the Step is instantiated in a Stage
         set mNext "NULL"
         set mPrev "NULL"
         set mConfigList ""
	 set mParamConfigList ""
         set mParentPath ""
	 set mParentStage ""
	 array set mResolvedConfigArr ""
	 set mParamConfigID ""
	 set mPrintStepHeader 1
         # Not yet supported:
         set mRow ""
         set mColumn ""
         set mCreateFile ""
         set mInsertFile ""
	 set mUnresolvedVars ""
	 array set mNotFoundFilesArr ""
	 array set mFoundFilesArr ""
	 set mInstanceName ""
	 set mBaseName $Name
	 array set mResolvedVarArr ""
         array set mRequiredFilesArr {}
         array set mRequiredVarsArr {}
	 set mAllVarsRequiredFlag 0
         set mAllVarsRequiredSeverity ""
         #::FFF::fff_member_close
         # mStepCmdArr is meant to take *any* text the user provides.
       }
       
       # Member function to associate a configuration (with lowest priority)
       member push_config {configurationID} {
         # Put the configID (argument) on the top of the config list
          set mConfigList [::FFF::flatten_list [list $configurationID $mConfigList]]
       }
       member bind_to_config {configurationID} {
         #::FFF::fff_member_init
         lappend mConfigList $configurationID
#         #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}bound to [$configurationID->get_name]"}
       }
       member set_instance_name {instanceName} {
         #::FFF::fff_member_init
         #set dbgPrefixWs [string repeat " " [info level]]
         set mInstanceName $instanceName
         #::FFF::fff_member_close
       }
       member get_instance_name {} {
         if {[info exists mInstanceName]} {
           return $mInstanceName
         } else {
           return ""
         }
       }
       member set_cmd_block {cmdArr} {
         ::FFF::fff_member_init
         #puts "${msgPrefix}cmdArr: [array get mStepCmdArr]"
	 #puts "${msgPrefix}cmdArr: [array get mStepCmdArr]"
	 #puts "${msgPrefix}Erasing mStepCmdArr"
#	 #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}cmdArr: [array get mStepCmdArr]"}
#	 #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}Erasing mStepCmdArr"}
	 array unset mStepCmdArr
 	 #puts "${msgPrefix}cmdArr: [array get mStepCmdArr]"
	 #puts "${msgPrefix}Setting mStepCmdArr to ->$cmdArr<-"
#	 #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}cmdArr: [array get mStepCmdArr]"}
#	 #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}Setting mStepCmdArr to ->$cmdArr<-"}
         array set mStepCmdArr $cmdArr
	 #puts "${msgPrefix}cmdArr: [array get mStepCmdArr]" 
#	 #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}cmdArr: [array get mStepCmdArr]"}
         #::FFF::fff_member_close
       }

       member get_cmd_block {} {
         return [array get mStepCmdArr]
       }

       member clear_cmd_block {} {
         #::FFF::fff_member_init
         array unset mStepCmdArr
         array set mStepCmdArr {}
         #::FFF::fff_member_close
       }

       member set_configurations {configIDList} {
         #::FFF::fff_member_init
         set mConfigList $configIDList
       }
       member get_configurations {} {
         return $mConfigList
       }
       # FUTURE: Need to switch this to checking if the object has been created in the elabns.
       member is_elaborated {} {
         if {[array exists ::FFF::elabdb::flow_objid_arr]} {
           return 1
         } else {
           return 0
         }
       }
       virtual member write_script {args} {
         ::FFF::fff_member_init
	 dbg_puts "args: ->$args<-"
         regexp {\{(.*)\}} $args full args

         if {[array exists ::FFF::elabdb::flow_objid_arr]} {
           set elaborated 1
         } else {
           set elaborated 0
         }
	 set fileName ""
         set prefix ""
         set trim_ws 0
	 set nocomments 0
	 set debug_switch 0
	 # Default is to resolve all variables
	 set resolve_vars_switch 1
         while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $args full args ]} {
         }

	 # Future implementation using parse_options
         ##### default for printing to stdout: don't
         ####switch -- [parse_options [calling_proc] {} $args \
         ####  "-trim_ws bos trim white space preceding the first non white space character in each line" trimWs \
         ####  "-nocomments bos don't print comments" noComments \
         ####  "-debug bos turn debug option on" debugOn \
         ####  "-no_resolve bos don't resolve variables" noResolve \
         ####  "-prefix sos prefix string to prepend to each line" prefixString \
         ####  "-filename sos name of file to write to" fileName \
         ####] {
         ####  -2 { return }
         ####  0 { error "Failed on [lindex [info level 0] 0]" }
         ####}

         if {$args ne ""} {
           while {[string match -* [lindex $args 0]] } {
             set option [lindex $args 0]
             set args [lrange $args 1 end]
             switch -exact -- $option {
               -trim_ws {
                  set trim_ws 1
               }
               -nocomments {
                  set nocomments 1
               }
               -debug {
                  set debug_switch 1
               }
               -no_resolve {
                  set resolve_vars_switch 0
               }
               -prefix {
                 set prefix [lrange $args 0 0]
                 regsub -all {\{([[:space:]]*)\}} $prefix {\1} prefix
                 set prefix_switch "-prefix \"$prefix\""
                 set args [lrange $args 1 end]
               }
	       -filename {
	         set fileName [lrange $args 0 0]
                 set args [lrange $args 1 end]
	       }
             }
           }
         }
	 if {$elaborated} {
	   if {$fileName ne ""} {
	     set scriptName $fileName
	   } else {
	     set scriptName [$mParentStage->get_script_name]
	   }
           set OSTREAM [open $scriptName "a+"]
	 
           dbg_puts "Writing [$this->get_name] to $scriptName"

	   array set mConfigVars [array get ${mParentPath}::vars]
           if {[array size mConfigVars] > 0} {
             foreach varName [array names mConfigVars] {
	       set cmdStr "set vars($varName) {$mConfigVars($varName)}" 
               puts "writing step vars... set vars($varName) {$mConfigVars($varName)}"
	       eval $cmdStr
             }
           }
           set str1 [$this->get_parent_path]::[$this->get_name]
           regsub {::FFF::elabdb::} $str1 {/} str1
           regsub -all {::} $str1 {/} str1
           set str2 Step
           set str3 [$this->get_configurations]

	   # Now print comments for steps by default (04/04/2011)
	   if {$mPrintStepHeader == 1} {
	     puts $OSTREAM "# --------------------------------------------------------------------------- #"
	     if {[array size mResolvedConfigArr] > ""} {
	       set configList ""
	       set varList ""
               foreach varName [array names mResolvedConfigArr] {
                 set configName [$mResolvedConfigArr($varName)->get_name]
                 #
                 # Don't print configs that are due to parameterization
                 #
                 if {![regexp {(\S*).param} $configName]} {
	           lappend configList $configName
	           lappend varList $varName
                 }
                 #
                 # Don't print the FF_Default config (make it invisible in the comments)
                 #

                 regsub {FF_Default} $configList {} configList

	       }
	       puts $OSTREAM "# Step: $mBaseName"

               #
               # Debug Code for each Step
               #
               if {[$this->typeid] eq "PluginInst"} {
                 puts $OSTREAM "$dbgPrefixWs  Plugin Command: [$this->get_plugin_cmd]"
               }
               array set resVarConfigArr [$this->get_resolved_config_arr]
               array set resVarValueArr [$this->get_resolved_vars_arr]
               array set reqVarSeverityArr [$this->get_required_vars_severity_arr]
               array set reqFilesSeverityArr [$this->get_required_files_severity_arr]
               set unresolvedVars [$this->get_unresolved_vars]
               set notFoundFiles [$this->get_notfound_files]

               if {[array size resVarConfigArr] > 0} {
                 #
                 # Formatting
                 #

                 # Set up the column widths
                 set w1 55
                 set w2 17
                 
                 #
                 # Make a nice header (with separator) for the table first
                 #
                 puts $OSTREAM "# Resolved Variables:"
                 set sep "# [string repeat - $w1]-+-[string repeat - $w2] #"
                 puts $OSTREAM $sep
                 puts $OSTREAM [format "# %-*s | %-*s" $w1 "Variable" $w2 "Value"]
                 puts $OSTREAM $sep
                 
                 # Resolved Vars
                 foreach var [lsort -dictionary [array names resVarConfigArr]] {
                   set str1 $var
                   set str2 [::FFF::flatten_list $resVarValueArr($var)]
		   regsub -all {[ \r\t\n\\]+} $str2 " " str2
		   regsub {^\s+(.*)} $str2 {\1} str2
		   regsub {(.*)\s+$} $str2 {\1} str2
                   set str2 "\"$str2\""
                   puts $OSTREAM [format "# set %-*s  %-*s" $w1 $str1 $w2 $str2]
                 }

                 # Finish off by printing the separator again
                 puts $OSTREAM $sep
               }

    	       if {$configList ne ""} {
		 puts $OSTREAM "# Bound configs: [lsort -unique $configList]"
	       }
	     } else {
	       puts $OSTREAM "# Step: $mBaseName (no variables)"
	     }
	     puts $OSTREAM "# --------------------------------------------------------------------------- #"
	   }
	   # Print plugin information
	   dbg_puts "Object Type: [$this->typeid] ID: $this"
           if {[$this->typeid] eq "PluginInst"} {
             puts $OSTREAM "### BEGIN [$this->get_plugin_cmd] ###"
           }
           if {[array size mStepCmdArr] == 0} {
             puts $OSTREAM "# $prefix$prefix{empty Step definition}"
           } else {
	     # there is something in the command array. Start processing each entry:
             for {set stepCmdNum 1} {$stepCmdNum <= [array size mStepCmdArr]} {incr stepCmdNum} {
	       array unset prettyCommand2Print
               set checkIsVarAList_list {}
	       if {$resolve_vars_switch} {
                 set uglyCommand2Print [$this->resolve_variables_in_command $mStepCmdArr($stepCmdNum)]
	       } else {
		 set uglyCommand2Print $mStepCmdArr($stepCmdNum)
	       }

	       dbg_puts "uglyCommand: $uglyCommand2Print"
	       # Create the "pretty-fied" command array from the original "ugly command"

	       # BCL: commented out list2prettyArr since it's easier to deal with "pretty-fying" in FCF
	       # as opposed to trying to craft rules in a parser! Maybe somebody else can tackle this
	       # in the future...
	       set prettyCommand2Print(0) $uglyCommand2Print
	       #array set prettyCommand2Print [$this->list2prettyArr $uglyCommand2Print]

	       # Ignore line if it's a comment and '-nocomments' was passed
	       # Currently this command supports the following types of comments:
	       # Single hash: '#'
	       # Double forward slash: '//'
	       #
               if {[array size prettyCommand2Print] > 1} {
		 # more than one line, so need to iterate
                 for {set i 0} {$i < [array size prettyCommand2Print]} {incr i} {
	           if {$nocomments} {
		     # filter out comments
                     if {![regexp {^[[:space:]]*\#} $prettyCommand2Print($i)] && ![regexp {^[[:space:]]*//} $prettyCommand2Print($i)]} {
                       if {$i == 0} {
                         set blockIndent ""
                       } else {
                         set blockIndent "   "
                       }
	               if {$trim_ws} {
                         regsub {^[[:space:]]*(.*)} $prettyCommand2Print($i) {\1} resolved_command
                         puts $OSTREAM "$prefix$prefix$blockIndent$resolved_command"
                       } else {
                         puts $OSTREAM "$prefix$prefix$blockIndent$prettyCommand2Print($i)"
	               }
	             };# end filter on comments
                   } else {
		     # comments ok (don't filter)
		     if {$i == 0} {
                       set blockIndent ""
                     } else {
                       set blockIndent "   "
                     }
	             if {$trim_ws} {
                       regsub {^[[:space:]]*(.*)} $prettyCommand2Print($i) {\1} resolved_command
                       puts $OSTREAM "$prefix$prefix$blockIndent$resolved_command"
                     } else {
                       puts $OSTREAM "$prefix$prefix$blockIndent$prettyCommand2Print($i)"
	             }
		   }; # end comment check
	         }; # end for loop
	       } elseif {[array size prettyCommand2Print] == 1 } {
	         # single line, no need to indent, no need to iterate over for loop (just process line 0)
		 set blockIndent ""
	         if {$nocomments} {	
		   # filter out comments
                   if {![regexp {^[[:space:]]*\#} $prettyCommand2Print(0)] && ![regexp {^[[:space:]]*//} $prettyCommand2Print(0)]} {
	              if {$trim_ws} {
                        regsub {^[[:space:]]*(.*)} $prettyCommand2Print(0) {\1} resolved_command
                        puts $OSTREAM "$prefix$prefix$blockIndent$resolved_command"
                      } else {
                        puts $OSTREAM "$prefix$prefix$blockIndent$prettyCommand2Print(0)"
	              }
		   };# end filter on comments
	         } else {
		   # comments ok
		   if {$trim_ws} {
                     regsub {^[[:space:]]*(.*)} $prettyCommand2Print(0) {\1} resolved_command
                     puts $OSTREAM "$prefix$prefix$blockIndent$resolved_command"
                   } else {
                     puts $OSTREAM "$prefix$prefix$blockIndent$prettyCommand2Print(0)"
	           }
		 }
	       };# end processing prettyCommand2Print array
	     };# end foreach step in mstepCmdArr

             if {[$this->typeid] eq "PluginInst"} {
               puts $OSTREAM "### END [$this->get_plugin_cmd] ###"
             }
	     # add a line after the last step (for readability)
	     if {$debug_switch} {
	       if {$mPrintStepHeader == 1} {
	         puts $OSTREAM ""
               }
	     }
	     close $OSTREAM
           };# end mStepCmdArr is empty
         } else {
	   # Non-elaborated Step Print:
	   puts "ERROR: Flow is not yet elaborated. To elaborate execute 'elaborate_foundation'."
         };# end not elaborated
	 ::FFF::fff_member_close
       };# End member write_script

       # Function to write out the step cmd array (fully elaborated) to a script file.

       ##########################################################################
       # resolve_var ()
       ##########################################################################
       # This is a protected helper function 
       # It can be called by objects that inherit the Step class
       # This command does variable substitution of the command string
       # and adds \$ to all non $vars variables in a configuration "under the hood":
       #
       # Pseudo code:
       # 1 Determine all $vars in the cmdn (array entry)
       # 1(a) 4/1/2011 (not an April Fool's joke): Note, we have to determine if the $vars usage
       #   is in a TCL expression. If so, it should be quoted/curly-braced.
       #   Otherwise, it should never be quoted or curly braced.
       #   this is to avoid situations like this: 'synthesize -to_mapped -effort "high"'
       #   (cannot have 'high' in quotes)
       # 2 For each $var entry, determine if the value is a list (length greater than 1)
       #   if it's a list, enclose the entry in curly braces
       # 3 regsub all $vars(+?) -> converting to __FFTMPVAR__vars(.*) (will avoid subst)
       # 4 regsub all $+?^[\s] -> converting to \$+? (will avoid subst)
       # 5 Convert __FFTMPVAR__vars back to $vars
       # 6 pass the cmd on to the subst command to "elaborate" the line
       #   Elaboration is a subst
		
       # Protected member function to cycle through all configurations and resolve a single variable
       # This also sets the configuration used to resolve the variable
       protected member resolve_var {stepVar} {
         ::FFF::fff_member_init  	
         foreach configObjID [$this->get_configurations] {
            if {[$configObjID->get_name] eq ""} {
              puts "elaborate_foundation() ERROR: Configuration: $configObjID bound to step [$this->get_name] but does not exist."
              puts "elaborate_foundation() ERROR: Exiting ..."
                    exit 1
            }
            set tracking_ns [$configObjID->get_var_tracking_namespace]
            set ns_var_list ${tracking_ns}::mVarArray
            set var_ns [$configObjID->get_var_namespace]
            if {[array exists ${var_ns}::$stepVar]} {
	      regexp {vars\((.*)\)} $stepVar full key
              $this->set_resolved_vars $stepVar [array get ${var_ns}::$stepVar]
	      $this->add_resolved_config $stepVar $configObjID
	      ::FFF::fff_member_close
	      return  [array get ${var_ns}::$stepVar]
            } elseif {[info exists ${var_ns}::$stepVar]} {
	      regexp {vars\((.*)\)} $stepVar full key
	      $this->set_resolved_vars $stepVar [set ${var_ns}::$stepVar]
	      $this->add_resolved_config $stepVar $configObjID
	      ::FFF::fff_member_close
	      return [set ${var_ns}::$stepVar]
            }
         };# end foreach configuration
	 # At this point, if we have not returned from the function, it means we have not resolved the stepVar
	 # Indicate this, and return with "-1"
#         if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}Did not find $stepVar defined in any of the configurations:"}
	 foreach configObjID [$this->get_configurations] {
#           if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}[$configObjID->get_name]"}
         }
	 ::FFF::fff_member_close
	 return "-1"
       };# end member function resolve_var

       protected member resolve_param {stepVar} {
	 ::FFF::fff_member_init
         set Debug $::FFF::Debug
	 if {$stepVar eq "FFStepName"} {
	   ::FFF::fff_member_close
           return [$this->get_name]
         }
         if {$stepVar eq "FFStageName"} {
	   ::FFF::fff_member_close
           return [[$this->get_parent_stage]->get_name]
         }
         foreach paramConfigObjID [$this->get_param_configurations] {
           if {[$paramConfigObjID->get_name] eq ""} {
             puts "elaborate_foundation() ERROR: Parameter Configuration: $paramConfigObjID bound to step [$this->get_name] ($this) but does not exist."
             puts "elaborate_foundation() Exiting ..."
             exit 1
           }
           set tracking_ns [$paramConfigObjID->get_var_tracking_namespace]
           set ns_var_list ${tracking_ns}::mVarArray
           set var_ns [$paramConfigObjID->get_var_namespace]
           if {[array exists ${var_ns}::$stepVar]} {
	     $this->set_resolved_params $stepVar [array get ${var_ns}::$stepVar]
	     $this->add_resolved_param_config $stepVar $paramConfigObjID
	     ::FFF::fff_member_close
	     return  [array get ${var_ns}::$stepVar]
           } elseif {[info exists ${var_ns}::$stepVar]} {
              set Debug $::FFF::Debug
	     #BUDA
	     $this->set_resolved_params $stepVar [set ${var_ns}::$stepVar]
	     $this->add_resolved_param_config $stepVar $paramConfigObjID
	     ::FFF::fff_member_close
	     return [set ${var_ns}::$stepVar]
           }
         };# end foreach configuration
	 # At this point, if we have not returned from the function, it means we have not resolved the stepVar
	 # Indicate this, and return with "-1"
	 #::FFF::fff_member_close
	 return "-1"
       };# end member function resolve_param


       # At coding time Foundation Elab only supports $vars types of variables
       # All other variables will be printed as is (un-elaborated).
       virtual protected member resolve_variables_in_command {stepCommand} {
         ::FFF::fff_member_init
         set Debug $::FFF::Debug
	 set checkIsVarAList_list {}

	 # Steps 1, 2
	 if {[regexp {^\$} $stepCommand]} {
	   set firstTokenIsAVariable 1
	 } else {
	   set firstTokenIsAVariable 0
  	 }

	 set leading_ws ""
         regexp {^([[:space:]]*).*} $stepCommand full leading_ws
	 set token_num 0
	 # create token list based on variables in the command
	 # Note - token list will be of length 1 if there are no "$"
	 dbg_puts "original command: $stepCommand"
         #set token_list [split $stepCommand]
         # 7/7/2012 BCL: Major change affecting how we look for variables
         set token_list [split $stepCommand {$\"\{\}\[\]\/ }]
	 dbg_puts "token list: $token_list"

	 #
         # This while loop goes through the entire command, token by token, and searches and attempts to resolve all $vars.
         # If it cannot resolve a $var, it will be escaped
         # Lastly, it automatically places curlies and double quotes as appropriate
	 # This loop is skipped if there are no $vars in the command
	 #

	 set resolvedValue ""
	 set token_num 1
	 set elab_cmd $stepCommand
	 foreach token $token_list {
	   #dbg_puts "processing token: ->$token<-"
	   set orig_token $token
	   if {$token ne ""} {
             if {[regexp {vars\((.*?)\)} $token full variableName] || [regexp {\{vars\((.*?)\)\}} $token full variableName]} {
	       ::FFF::dbg_puts "Processing vars($variableName)..."
	       #
	       # We found a Foundation Flow Variable ($vars())
	       # check each bound configuration for this variable using the resolve_var member function
	       #
	       set resolvedValue [$this->resolve_var vars($variableName)]
	       ::FFF::dbg_puts "resolve_var on vars($variableName) returned ->$resolvedValue<-"

	       if { $resolvedValue eq "-1" } {
		 # The variable was not resolved based on the configurations bound to this step
                 $this->add_unresolved_vars "vars($variableName)"
                 if {[regexp {\$vars\((.*?)\)} $token]} {
	           regsub {(\$vars\(.*?\))} $token {\1} token
                 } else {
	           regsub {(\$\{vars\(.*?\)\})} $token {\1} token
	  	 }
	       } else {
	         # With variable resolved, we first decide whether to surround variable with curlies
		 # BUDA 7/11/2011: NOTE: for the following "exceptions," we should have a final pass on
		 # the generated flow to make sure these variables are bound to this step,
	         # otherwise info exists and lindex will fail during script execution

	         #
	         # [info exists vars(...) ] test (never regsub)
	         #
	         set re "info exists vars\[(\]$variableName\[)\]"

		 #
	         # [lindex $vars(...)] test (never regsub)
		 #
	         set re2 "lindex.*vars\[(\]$variableName\[)\]"
		
	         if {[regexp $re $stepCommand]} {
		 } elseif {[regexp $re2 $stepCommand]} {
		 } elseif {[regexp {^\s*(if.*)vars.*} $stepCommand] ||
                           [regexp {^\s*(for.*)vars.*} $stepCommand] ||
                           [regexp {^\s*(while.*)vars.*} $stepCommand] ||
                           [regexp {\[.*${variableName}.*\]} $stepCommand] } {
	           #####if {[::FFF::is_var_a_list $resolvedValue]} {
		   #####  #
		   #####  # We are in an if, for, while or square-brace expression, and the resolved value is a list. Add curly braces:
		   #####  #
		   #####  #::FFF::dbg_puts -print_stdout "LIST processing! token before first regsub: ->$token<-"
	           #####  regsub {(vars\(.*?\))} $token {{\1}} token
		   #####  #::FFF::dbg_puts -print_stdout "token after first regsub: ->$token<-"
		   #####  regsub {(\$\{vars\(.*?\)\})} $token $resolvedValue token
		   #####  #::FFF::dbg_puts -print_stdout "token after second regsub: ->$token<-"
	           #####  regsub {(.*)} $token {{\1}} token
		   #####  #::FFF::dbg_puts -print_stdout "token after third regsub: ->$token<-"
	           #####} else {
		   #####  #
		   #####  # regsub the variable with the resolved value
		   #####  #
		   #####  #::FFF::dbg_puts -print_stdout "NOT a list.  token before first regsub: ->$token<-"
		   #####  regsub {(\$vars\(.*?\))} $token $resolvedValue token
		   #####  #::FFF::dbg_puts -print_stdout "NOT a list.  token after first regsub: ->$token<-"
                   #####}
		 } else {
		   # 
		   # Not an if, for, while, or square-braced expression
		   # Only add curlies. do not add double quotes if the variable is singular
		   #
	           #####if {[::FFF::is_var_a_list $resolvedValue]} {
	           #####  regsub {(\$vars\(.*?\))} $token {{\1}} token
	           #####}
		   regsub {(\$vars\(.*?\))} $token $resolvedValue token
                 }; # end regexp (is it an expression)

		 #
		 # Modify elab_cmd with resolved value
		 #
		 #####if {[::FFF::is_var_a_list $resolvedValue]} {
		 #####  #
		 #####  # We are in an if, for, while or square-brace expression, and the resolved value is a list. Add curly braces:
		 #####  #
	         #####  regsub {(.*)} $resolvedValue {{\1}} resolvedValue
	         #####}
	         set re "\\\$vars\\\($variableName\\\)"
	         if {[regsub -all $re $elab_cmd $resolvedValue elab_cmd]} {
	           ::FFF::dbg_puts "sub'ed elab_cmd: ->$elab_cmd<-"
	         }
	         set re2 "\\\$\{vars\\\($variableName\\\)\}"
		 if {[regsub -all $re2 $elab_cmd $resolvedValue elab_cmd]} {
	           ::FFF::dbg_puts "sub'ed elab_cmd: ->$elab_cmd<-"
	         }
	       }; # end if resolvedValue eq ""
	     } else {
    	       # Not a Foundation Flow Variable, but a variable nonetheless, since we split on "$". This means we need to add "$" back in
	       # The very first token is special: we only add in a "$" if it was already detected to be a variable
	       if {$token_num != 1 || $firstTokenIsAVariable} {
	         set token "$token"
  	       }
	       
	     }; # end not a vars match

	     #
             # 5/14/2012 Force variable resolution, regardless of max line length
             #set elab_cmd "${elab_cmd} ${token}"
	     
	   }; # end if token ne ""
	   incr token_num
         }; # end foreach


	 #
	 # Fix leading WS
         #
         if {[regsub {^([[:space:]]*)} $elab_cmd $leading_ws elab_cmd]} { }

         # Force vars(rundir) to resolve
         #  Note that this typically happens when a variable has been resolved above, and includes $vars(rundir) as part of it's value.
         #  look vars vars(rundir) in the token through regular expressions, and subst it if found
	 #
	 if {![info exists ::FFF::vars(rundir)]} {
	   set rundir .
	 } else {
	   set rundir $::FFF::vars(rundir)
	 }
         regsub -all {\$vars\(rundir\)} $elab_cmd [::FFF::relPathTo [file normalize .] [file normalize $rundir]] elab_cmd

         # return the fully resolved command
   	 dbg_puts "elab_cmd returned: $elab_cmd"	 
         return $elab_cmd
       }; # end member function resolve_variables_in_command()

       protected member resolve_parameters_in_string {stepCommand} {
	 ::FFF::fff_member_init
	 set checkIsVarAList_list {}
	 # Steps 1, 2
              set Debug $::FFF::Debug
	 set firstTokenIsAVariable 0
	 if {[regexp {^\$} $stepCommand]} {
	   set firstTokenIsAVariable 1
	 } else {
	 }
	 set token_num 0
	 # create token list based on parameters in the command
	 # We create tokens by splitting on most standard tcl non-variable characters.
	 # Note - token list will be of length 1 if there are no "$"
         set token_list [split $stepCommand {$().,\"\{\}\[\] }]

	 # This is the final elaborated command that is returned:
	 set elab_cmd $stepCommand

         # This while loop goes through the entire command, searches and attempts to resolve all parameters except for $vars
         # if it cannot resolve a $var, it will be escaped
         # Lastly, it automatically places curlies and double quotes as appropriate
	 # This loop is skipped if there are no parameters in the command
         array set substArray {}

	 set token_num 1
	 foreach token $token_list {
	   if { $token ne "" && $token ne "vars" } {
	     # check each bound configuration for this parameter
	     #set resolvedValue [::FFF::flatten_list [$this->resolve_param $token]]
	     set resolvedValue [$this->resolve_param $token]
	     if { $resolvedValue ne "-1" } {
	       #####if {[::FFF::is_var_a_list $resolvedValue]} {
	       #####  regsub {(.*)} $resolvedValue {{\1}} resolvedValue
	       #####}
	       set substArray($token) $resolvedValue
	     }; # end if resolvedValue is not null
	   };# end token ne ""
	   incr token_num
         }; # end foreach token

	 # Now that we have resolved all parameters, substitute the resolved parameters into the original command
	 foreach param [array names substArray] {
	   # Step 1: Search/substitute for parameter if used w/out curly braces (i.e., $myvar)
	   #regsub {(.*)($param)(.*)} $elab_cmd {\1$substArray($param)\3} elab_cmd
	   set re "\\\$$param"
	   regsub -all $re $elab_cmd $substArray($param) elab_cmd

	   # Step 2: Search/substitute for parameter if used with curly braces (i.e., ${myvar})
	   set re "\\\${$param}"
	   regsub -all $re $elab_cmd $substArray($param) elab_cmd
	 }

         # done - just return the fully resolved command
	 ::FFF::fff_member_close
         return $elab_cmd
       }; # end member function resolve_parameters_in_string


       # This command tries to substitute out parameters before we go into elaboration.
       # BUDA: This is a temporary stop gap for rich, and should be refactored asap.
       member resolve_parameters_in_command_block {} {
	 ::FFF::fff_member_init
	 if {[array size mStepCmdArr] != [array size mOrigStepCmdArr]} {
#	   if {$Debug} {puts $::FFF::DEBUG_OSTREAM "INTERNAL ERROR"}
#	   if {$Debug} {puts $::FFF::DEBUG_OSTREAM "mStepCmdArr:"}
#	   if {$Debug} {puts $::FFF::DEBUG_OSTREAM "->[array get mStepCmdArr]<-"}
#	   if {$Debug} {puts $::FFF::DEBUG_OSTREAM "mOrigStepCmdArr:"}
#	   if {$Debug} {puts $::FFF::DEBUG_OSTREAM "->[array get mOrigStepCmdArr]<-"}
	   puts "INTERNAL ERROR: resolve_parameters_in_command_block mStepCmdArr != mOrigStepCmdArr"
	   puts "INTERNAL ERROR: Please report this error to the Cadence Product Core Team (fed_applet_support@cadence.com)"
	 } elseif {![array size mStepCmdArr] == 0} {
#           if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}[array size mStepCmdArr] Commands to resolve."}
           # For each command, resolve the parameters from the parameter configuration, if one exists
	   # Buda 7/5/2011. Now this function always operates on the original cmd block, and populates the cmd block.
           # This allows us to re-resolve parameters as they are redefined
           for {set stepCmdNum 1} {$stepCmdNum <= [array size mOrigStepCmdArr]} {incr stepCmdNum} {
              set Debug $::FFF::Debug
#             if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}Processing line $stepCmdNum of [array size mStepCmdArr] (step commands)"}
#             if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}Current configurations for [$this->get_name] ($this):"}
#	     if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}[$this->get_param_configurations]"}
             set checkIsVarAList_list {}
             set resolved_string [$this->resolve_parameters_in_string $mOrigStepCmdArr($stepCmdNum)]
              set Debug $::FFF::Debug
#             if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}Changing cmd ->$mStepCmdArr($stepCmdNum)<- to ->$resolved_string<-"}
	     set mStepCmdArr($stepCmdNum) $resolved_string
           }; # end for loop
         };# end mStepCmdArr is empty
	 #::FFF::fff_member_close
       };# end member function resolve_parameters_in_command_block

      member list2prettyArr { var } {
	::FFF::fff_member_init
	set lineNum 0

        if {[regexp {^\s*#} $var] || [regexp {^\s*\/\/} $var]} {
          set returnArr($lineNum) $var
	} else {
          # maxLineLength is the maximum length of characters a list should have on one line before breaking it into multiple lines"
	  set tmp1 $var
	  # Generate a random number to be used as a placeholder for double quotes
	  # This is done because when we build the string, double quotes dissappear
	  set randNumQuote [expr {rand() * 1000000000000}]
	  set randNumLenQuote [string length $randNumQuote]

	  set randNumLeftCurly [expr {rand() * 1000000000000}]
	  set randNumLenLeftCurly [string length $randNumLeftCurly]

	  set randNumRightCurly [expr {rand() * 1000000000000}]
	  set randNumLenRightCurly [string length $randNumRightCurly]

	  set randNumleadingWS [expr {rand() * 1000000000000}]
	  set randNumLenleadingWS [string length $randNumleadingWS]

	  # Build the quote separator
	  set quoteSeparator __[join [lrange [::FFF::flatten_list [split $randNumQuote {}]] 0 [expr {$randNumLenQuote - 3}]] ""]__
	  set LeftcurlySeparator __[join [lrange [::FFF::flatten_list [split $randNumLeftCurly {}]] 0 [expr {$randNumLenLeftCurly - 3}]] ""]__
	  set RightcurlySeparator __[join [lrange [::FFF::flatten_list [split $randNumRightCurly {}]] 0 [expr {$randNumLenRightCurly - 3}]] ""]__
	  set LeadingWSSeparator __[join [lrange [::FFF::flatten_list [split $randNumleadingWS {}]] 0 [expr {$randNumLenleadingWS - 3}]] ""]__
	  # Use the quoteseparator to swap out quotes
	  regsub -all {\"} $tmp1 $quoteSeparator tmp2a
	  regsub -all {\{} $tmp2a $LeftcurlySeparator tmp2b
	  regsub -all {\}} $tmp2b $RightcurlySeparator tmp2c
	  # Save the whitespace (if any)
 	  set SavedSpace ""
          if {[regexp {^(\s+).*} $tmp2c full SavedSpace]} {
	    regsub {^\s+} $tmp2c $LeadingWSSeparator tmp2
	  } else {
	    set tmp2 $tmp2c
	  }

	  # create string from the list	
	  set tmp3 [join $tmp2 " "]
	  set re1 "\""
	  set re2 "\{"
	  set re3 "\}"
	  set re4 $SavedSpace
	  # put quotes back
	  regsub -all $quoteSeparator $tmp3 $re1 argsA
	  regsub -all $LeftcurlySeparator $argsA $re2 argsB
	  regsub -all $RightcurlySeparator $argsB $re3 argsC
	  regsub $LeadingWSSeparator $argsC $re4 args
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}args->$args<-"}
          set maxLineLength $::FFF::maxLineLength
          set minLengthPerSingleToken $::FFF::minLengthPerSingleToken

	  # Defaults
          set theListToPrint {}
          array unset returnArr
	  set myBraceType ""

          set stringLen [string length $args]
	  # Process the string
          # Algorithm:
          # Until the end of the string
          #  Valid line breaks:
          #   1) Encountered a space after maxLineLength characters
          #   2) Encountered a space or double quote before maxLineLength, and a character or double quote after maxLineLength
          #      (in which case the line is broken at the previous space / double quote)
          #  ->Work on current line until a space or double quote is reached
          #  Until the maxLineLength is reached, or until a double quote is encountered, add the current character to the current line
          #   if a double quote is reached, create a substring and continue incrementing the char counter
          #   if a second double quote is reached, and char counter is < maxLineLength, add the entire substring into the current line
          #   if the maxLineLength is reached and the second double quote has not yet been encountered, close the current line, and begin a new line
          #    when the double quote is finally encountered, add the substring to the new line, and close the line
          #  
	  set currentLine ""
          set currentQuote ""
	  set lastDoubleQuotedChar ""
	  set doubleQuoteCount 0
	  set lastLeftCurlyChar ""
	  set lastRightCurlyChar ""
          set CurlyCount 0
	  set lastSpaceChar ""
	  set curLineStart 0
	  set curLineEnd 0
	  set inCurlyVariable 0
	  set NOTcondStatement 0
	  set maxCharNum [expr {$maxLineLength - 1}]
	  set minCharNum [expr {$minLengthPerSingleToken - 1}]
          set nonSpaceCharEncountered 0
	  set pos 0

	  # Determine if this is an if,elseif,while, or for loop. if so, do not break on minChar
	  if {[regexp {if|elseif|while|for|foreach|set|else} $args]} {
	    set NOTcondStatement 0
	  } else {
	    set NOTcondStatement 1
	  }

	  # Process the string one character at a time...
	  while {$pos < $stringLen} {
            set currentChar [string index $args $pos]
            set lastChar [string index $args [expr {$pos - 1}]]
	    if {$currentChar eq " "} {
	      if {$nonSpaceCharEncountered} {
	        set lastSpaceChar $pos
	      }
	    } else {
	      set nonSpaceCharEncountered 1
	    }
	    if {$currentChar eq "\""} {
	      set lastDoubleQuotedChar $pos
	      incr doubleQuoteCount
	    }

	    # we need to differentiate between curly braces used with variables, and curly braces to create blocks
	    # this is because pretty print wants to break apart only blocks, and not variables
	    if {$currentChar eq "\{" } {
	      if {$lastChar eq "$"} {
	        set inCurlyVariable 1
	      } else {
	        set inCurlyVariable 0
	      }
	    }
	    if {$currentChar eq "\{" && $inCurlyVariable == 0} {
	      set lastLeftCurlyChar $pos
	      incr CurlyCount
	    }
	    ########################################################################
	    # NOTE: need to clean up the following block.
	    # There is a possibility that CurlyCount can go negative. probably need an if condition
	    # to check for this, but i need to study this more.
	    ########################################################################

            if {$currentChar eq "\}"} {
	      if {$inCurlyVariable == 0} {
	        set lastRightCurlyChar $pos
	        incr CurlyCount -1
	      } else {
	        # no longer in curly variable...
	        set inCurlyVariable 1
	      }
	    }
	    # no double quotes encountered yet
	    # simply break at last space before maxLineCount
            
            ### 6/14/2011 NOTE - removed this because it was causing more trouble than it was worth for the A15 flow.
            ### May need to put back later.
	    ###if {$CurlyCount > 0 && $NOTcondStatement} {
            ###  # If we are in a curly block, then break on the minimum token length
#            ###  if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}$msgPrefix: in a curly block. Break on min token length"}
	    ###  set maxCharNum [expr {$curLineStart + $minCharNum}]
#            ###  #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}$msgPrefix: curlyCount: $CurlyCount maxCharNum set to: $maxCharNum"}
	    ###} else {
	    ###  # else if we leave the curly block, switch back to breaking on the maxLineLength
#            ###  if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}$msgPrefix: Left curly break. Switching to maxLineLength for line break"}
	    ###  set maxCharNum [expr {$curLineStart + $maxLineLength}]
#            ###  #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}$msgPrefix: curlyCount: $CurlyCount maxCharNum set to: $maxCharNum"}
	    ###}
	    if {$pos >= $maxCharNum} {
	      # Not in a curly block. Normal rules apply
	      # maxCharNum reached. Need to see if there are any spaces or quotes
#              #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}$msgPrefix: pos: $pos >= maxCharNum $maxCharNum, lastSpaceChar: $lastSpaceChar<-"}
	      if {$lastSpaceChar > $curLineStart} {
	        # if there was a space in the current segment, we break at this space.
	        # otherwise we keep going ...
                set returnArr($lineNum) "[string range $args $curLineStart $lastSpaceChar] \\"
#                if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}dump2 line returnArr($lineNum) dumped: at pos: $lastSpaceChar ->$returnArr($lineNum)<-"}
	        set curLineStart [expr {$lastSpaceChar + 1}]
	        set maxCharNum [expr {$curLineStart + $maxLineLength}]
	        incr lineNum
	      }; # end if $lastSpaceChar == $pos
	    };# end if $pos == $maxCharNum
	    incr pos
          };# end while loop

          # We exited the while loop, which means we completed processing the string
	  # If the string ended on the maxlinelength character

	  # Dump anything left into the last line:
	  if {$pos > $curLineStart} {
	    set tmpStr [string range $args $curLineStart $pos]
	    if {$tmpStr eq "\/"} {
	      # Hack for RC (tcl): because of root attributes settings where the line ends in a "/", we always want to keep the last "/" on the same line as the attribute setting,
              # so we need to 'back-out' the backslash on the last line. This should be fine for all languages in general.
	      incr lineNum -1
	      regsub {(.*)\\} $returnArr($lineNum) {\1} fullMatch
	      set returnArr($lineNum) "$fullMatch$tmpStr"
	      incr lineNum
	    } else {
              set returnArr($lineNum) "[string range $args $curLineStart $pos]"
              incr lineNum
	    }
          } elseif {$pos == $curLineStart} {
            set returnArr($lineNum) $var
	  }
	}; # end (not a comment)
	# Now test it:
        ::FFF::fff_member_close
        return [array get returnArr]
      }; #end member list2prettyArr

       virtual member print {args} {
         ::FFF::fff_member_init
         regexp {\{(.*)\}} $args full args

         if {[array exists ::FFF::elabdb::flow_objid_arr]} {
           set elaborated 1
         } else {
           set elaborated 0
         }
         set prefix ""
         set trim_ws 0
         set debug 0
	 set nocomments 0
	 set resolve_vars_switch 1
         while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $args full args ]} { }
         if {$args ne ""} {
           while {[string match -* [lindex $args 0]] } {
             set option [lindex $args 0]
             set args [lrange $args 1 end]
             switch -exact -- $option {
               -prefix {
                 set prefix [lrange $args 0 0]
                 regsub -all {\{([[:space:]]*)\}} $prefix {\1} prefix
                 set args [lrange $args 1 end]
               }
               -no_resolve {
                  set resolve_vars_switch 0
               }
               -trim_ws {
                 set trim_ws 1
               }
               -nocomments {
                  set nocomments 1
               }
               -debug {
                 set debug 1
               }
             }
           }
         }

	 if {$elaborated} {
	   array set mConfigVars [array get ${mParentPath}::vars]
           if {[array size mConfigVars] > 0} {
             foreach varName [array names mConfigVars] {
	       set cmdStr "set vars($varName) {$mConfigVars($varName)}" 
               puts "#2 writing step vars... set vars($varName) {$mConfigVars($varName)}"
	       eval $cmdStr
             }
           }
           set str1 [$this->get_parent_path]::[$this->get_name]
           regsub {::FFF::elabdb::} $str1 {/} str1
           regsub -all {::} $str1 {/} str1
           set str2 Step
	   # May not have configurations bound to every step. In this case, we don't print them
	   # Major enhancement needed to support querying stage configurations
	   set str3 [::FFF::fix_default_config_name $this]

	   puts [format "%-*s %-*s %*s" 30 $str1 20 $str2 20 $str3]
           if {[array size mStepCmdArr] == 0} {
             puts "$prefix$prefix{empty Step definition}"
           } else {
	     ##############################################################
	     # copied from write_script
	     # NOTE: Need to consolidate write_script and print at some point ...
	     ##############################################################
	     # there is something in the command array. Start processing each entry:
             for {set stepCmdNum 1} {$stepCmdNum <= [array size mStepCmdArr]} {incr stepCmdNum} {
	       array unset prettyCommand2Print
               set checkIsVarAList_list {}
               set resolved_command [$this->resolve_variables_in_command $mStepCmdArr($stepCmdNum)]
               ::FFF::dbg_puts "flow command: ->$mStepCmdArr($stepCmdNum)<-"
               ::FFF::dbg_puts "resolved command: ->$resolved_command<-"

	       # BCL: commented out list2prettyArr since it's easier to deal with "pretty-fying" in FCF
	       # as opposed to trying to craft rules in a parser! Maybe somebody else can tackle this
	       # in the future...
	       set prettyCommand2Print(0) $resolved_command
	       #array set prettyCommand2Print [$this->list2prettyArr $resolved_command]

	       # Ignore line if it's a comment and '-nocomments' was passed
	       # Currently this command supports the following types of comments:
	       # Single hash: '#'
	       # Double forward slash: '//'
	       #
#	       if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}nocomments flag specified. Current command: ->$resolved_command<-"}
               if {[array size prettyCommand2Print] > 1} {
		 # more than one line, so need to iterate
                 for {set i 0} {$i < [array size prettyCommand2Print]} {incr i} {
	           if {$nocomments} {
		     # filter out comments
                     if {![regexp {^[[:space:]]*\#} $prettyCommand2Print($i)] && ![regexp {^[[:space:]]*//} $prettyCommand2Print($i)]} {
                       if {$i == 0} {
                         set blockIndent ""
                       } else {
                         set blockIndent "   "
                       }
	               if {$trim_ws} {
                         regsub {[[:space:]]*(.*)} $prettyCommand2Print($i) {\1} resolved_command
                         puts "$prefix$prefix$blockIndent$resolved_command"
                       } else {
                         puts "$prefix$prefix$blockIndent$prettyCommand2Print($i)"
	               }
	             };# end filter on comments
                   } else {
		     # comments ok (don't filter)
		     if {$i == 0} {
                       set blockIndent ""
                     } else {
                       set blockIndent "   "
                     }
	             if {$trim_ws} {
                       regsub {[[:space:]]*(.*)} $prettyCommand2Print($i) {\1} resolved_command
                       puts "$prefix$prefix$blockIndent$resolved_command"
                     } else {
                       puts "$prefix$prefix$blockIndent$prettyCommand2Print($i)"
	             }
		   }; # end comment check
	         }; # end for loop
	       } elseif {[array size prettyCommand2Print] == 1 } {
	         # single line, no need to indent, no need to iterate over for loop (just process line 0)
		 set blockIndent ""
	         if {$nocomments} {	
		   # filter out comments
                   if {![regexp {^[[:space:]]*\#} $prettyCommand2Print(0)] && ![regexp {^[[:space:]]*//} $prettyCommand2Print(0)]} {
	              if {$trim_ws} {
                        regsub {[[:space:]]*(.*)} $prettyCommand2Print(0) {\1} resolved_command
                        puts "$prefix$prefix$blockIndent$resolved_command"
                      } else {
                        puts "$prefix$prefix$blockIndent$prettyCommand2Print(0)"
	              }
		   };# end filter on comments
	         } else {
		   # comments ok
		   if {$trim_ws} {
                     regsub {[[:space:]]*(.*)} $prettyCommand2Print(0) {\1} resolved_command
                     puts "$prefix$prefix$blockIndent$resolved_command"
                   } else {
                     puts "$prefix$prefix$blockIndent$prettyCommand2Print(0)"
	           }
		 }
	       };# end processing prettyCommand2Print array
	     };# end foreach step in mstepCmdArr

	   ##############################################################

           };# end mStepCmdArr is empty
         } else {
	   # Non-elaborated Step Print:
           set str1 $mName
           set str2 Step
	   set str3 [::FFF::fix_default_config_name $this]

	   puts [format "%-*s %-*s %*s" 30 $str1 20 $str2 20 $str3]
           if {[array size mStepCmdArr] == 0} {
             puts "$prefix$prefix{empty Step definition}"
           } else {
             for {set stepCmdNum 1} {$stepCmdNum <= [array size mStepCmdArr]} {incr stepCmdNum} {
	       array unset prettyCommand2Print

	       # BCL: commented out list2prettyArr since it's easier to deal with "pretty-fying" in FCF
	       # as opposed to trying to craft rules in a parser! Maybe somebody else can tackle this
	       # in the future...
	       set prettyCommand2Print(0) $mStepCmdArr($stepCmdNum)
	       #array set prettyCommand2Print [$this->list2prettyArr $mStepCmdArr($stepCmdNum)]
               if {[array size prettyCommand2Print] > 1} {
                 for {set i 0} {$i < [array size prettyCommand2Print]} {incr i} {
                   if {$i == 0} {
                     set blockIndent ""
                   } else { 
                     set blockIndent "   "
                   }
                 }
	       }

               if {$trim_ws} {
                 regsub {^[[:space:]]*(.*)} $mStepCmdArr($stepCmdNum) {\1} trimmed_cmd
                 puts "$prefix$prefix$trimmed_cmd"
	       } else {
                 puts "$prefix$prefix$mStepCmdArr($stepCmdNum)"
  	       }
	     }; # end for loop
	   };# end mStepCmdArr is not empty
         };# end not elaborated
       };# End member print

       virtual member report_stats {args} {
         ::FFF::fff_member_init

	 # Pull out default curlies from args list
         set args [flatten_list $args]

	 # default for printing to stdout: don't
	 set ptsargs "" 
         switch -- [parse_options [calling_proc] {} $args \
           "-debug_file_only bos only print the stats to the .fff_debug file" debugFileOnly \
         ] {
           -2 { return }
           0 { error "Failed on [lindex [info level 0] 0]" }
         }

         # If $debugFileOnly, set the puts commands to print to stdout
         # else set the option to "-debug" which is the default behavior (this is totally optional
	 # and only done so we don't have to change the dbg_puts statements into eval commands
	 # and surrond the print string in curlies
	 # I.e., we are attempting to avoid this:
	 # eval {dbg_puts $ptsargs $sting}
         if {$debugFileOnly} {
	   set ptsargs "-print_stdout" 
         } else {
	   set ptsargs "-debug" 
	 }
 

	 # Setup up results arrays
         array set resVarConfigArr 	[$this->get_resolved_config_arr]
         array set resVarValueArr 	[$this->get_resolved_vars_arr]
         array set reqVarSeverityArr 	[$this->get_required_vars_severity_arr]
         array set reqFilesSeverityArr 	[$this->get_required_files_severity_arr]
         set unresolvedVars 		[$this->get_unresolved_vars]
         set notFoundFiles 		[$this->get_notfound_files]
	 set unusedVarList 		[$this->get_unused_required_vars]

	 ::FFF::dbg_puts $ptsargs "##########################################################"
	 ::FFF::dbg_puts $ptsargs "Stats for [$this->get_name]"

	 #
	 # Resolved Variables
	 #
	 if {[array size resVarConfigArr] > 0} {
	   ::FFF::dbg_puts $ptsargs "Resolved Variables:"
      	   set str1 "Variable"
      	   set str2 "Value"
      	   set str3 "Configuration"
      	   set str4 "Missing (Var) Severity"
	   ::FFF::dbg_puts $ptsargs [format "$dbgPrefixWs    %-*s %-*s %-*s %-*s" 30 $str1 20 $str2 20 $str3 20 $str4]
           foreach var [array names resVarConfigArr] {
             set str1 $var
             set str2 $resVarValueArr($var)
	     if {[llength $str2] > 1} {
	       regsub {(.*)} $str2 {{\1}} str2
             }
             set str3 [$resVarConfigArr($var)->get_name]
             if {[info exists reqVarSeverityArr($var)]} {
               set str4 $reqVarSeverityArr($var)
             } else {
               set str4 "N/A"
             }
             ::FFF::dbg_puts $ptsargs [format "$dbgPrefixWs    %-*s %-*s %-*s %-*s" 30 $str1 20 $str2 20 $str3 20 $str4]
           }
         }

	 #
	 # Unresolved Variables
	 #
         if {[llength $unresolvedVars] > 0} {
           if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$dbgPrefixWs Unresolved Variables:"}
           # Unresolved Vars
           foreach var $unresolvedVars {
             set str1 $var
             set str2 "Unresolved"
             set str3 "Unresolved"
             if {[$this->are_all_vars_required]} {
               ::FFF::dbg_puts $ptsargs "All vars required severity:->[$this->get_all_vars_required_severity]<-"
               set str4 [$this->get_all_vars_required_severity]
               if {![info exists reqVarSeverityArr($var)]} {
                 ::FFF::dbg_puts $ptsargs "Adding $var to reqVarSeverityArr Array with severity:  $str4 due to '-require_all_vars switch'"
                 set reqVarSeverityArr($var) $str4
               }
             } elseif {[info exists reqVarSeverityArr($var)]} {
               set str4 $reqVarSeverityArr($var)
             } else {
               set str4 "Not Required"
             }
             ::FFF::dbg_puts $ptsargs [format "$dbgPrefixWs    %-*s %-*s %-*s %-*s" 30 $str1 20 $str2 20 $str3 20 $str4]
             if {[regexp {error|warn|note} $str4]} {
               #
               # Print messaging to stdout. In future, create message object only, then dump full report at end of elab
               #
               if {!$::FFF::newEllipsisCommentLine} {
                 # Create a newline
                 puts ""
               }
               if {[$this->typeid] eq "PluginInst"} {
                 ::FFF::fcfqc::lint_message $reqVarSeverityArr($var) FCF-VAR-202 "$var" "[$this->get_name]";
               } else {
                 ::FFF::fcfqc::lint_message $reqVarSeverityArr($var) FCF-VAR-201 "$var" "[$this->get_name]";
               }
               set ::FFF::newEllipsisCommentLine 1
             }
           };# end foreach var
         };#end llength $unresolvedVars


	 #
	 # Files not found
	 #
         if {[llength $notFoundFiles] > 0} {
           array set notFoundFilesArr [$this->get_notfound_files_arr]
           ::FFF::dbg_puts $ptsargs "Files Not Found:"
           set str1 "File"
           set str2 "Variable"
           set str3 "Configuration"
           set str4 "Missing (File) Severity"
           ::FFF::dbg_puts $ptsargs [format "$dbgPrefixWs    %-*s %-*s %-*s %-*s" 30 $str1 20 $str2 20 $str3 20 $str4]
           # Not Found Files
           foreach file $notFoundFiles {
             set str1 $file
             if {[info exists notFoundFilesArr($file)] && $notFoundFilesArr($file) ne ""} {
               set str2 $notFoundFilesArr($file)
               regsub {\$vars(.*)} $str2 {vars\1} str2
               set str3 [$resVarConfigArr($str2)->get_name]
             } else {
               set str2 "N/A"
               set str3 "N/A"
             }
             if {[info exists reqFilesSeverityArr($str1)]} {
               set str4 $reqFilesSeverityArr($str1)
             } else {
               set str4 "Not Required"
             }
             ::FFF::dbg_puts $ptsargs [format "$dbgPrefixWs    %-*s %-*s %-*s %-*s" 30 $str1 20 $str2 20 $str3 20 $str4]
             if {[regexp {error|warn|note} $str4]} {
               #
               # Print messaging to stdout. In future, create message object only, then dump full report at end of elab
               #
               if {!$::FFF::newEllipsisCommentLine} {
                 # Create a newline
                 puts ""
               }
               if {[$this->typeid] eq "PluginInst"} {
                 ::FFF::fcfqc::lint_message $reqFilesSeverityArr($file) FCF-VAR-204 "$str1" "[$this->get_name]" "$str2";
               } else {
                 ::FFF::fcfqc::lint_message $reqFilesSeverityArr($file) FCF-VAR-203 "$str1" "[$this->get_name]" "$str2";
               }
               set ::FFF::newEllipsisCommentLine 1
             }
           }
	 }

         #
         # Required by FCF, but unused vars (not referenced by object)
	 #

	 if {[llength $unusedVarList] > 0} {
           ::FFF::dbg_puts $ptsargs "$dbgPrefixWs Required but Unused Variables:"
           # Required but not used variables:
           foreach var $unusedVarList {
             set str1 $var
             set str2 "Not Used"
             set str3 "Not Used"
             set str4 $reqVarSeverityArr($var)
             ::FFF::dbg_puts $ptsargs [format "$dbgPrefixWs    %-*s %-*s %-*s %-*s" 30 $str1 20 $str2 20 $str3 20 $str4]

             if {[regexp {error|warn|note} $str4]} {
               #
               # Print messaging to stdout. In future, create message object only, then dump full report at end of elab
               #
               if {!$::FFF::newEllipsisCommentLine} {
                 # Create a newline
                 puts ""
               }
               if {[$this->typeid] eq "PluginInst"} {
                 ::FFF::fcfqc::lint_message $reqVarSeverityArr($var) FCF-VAR-202 "$var" "[$this->get_name]";
               } else {
                 ::FFF::fcfqc::lint_message $reqVarSeverityArr($var) FCF-VAR-201 "$var" "[$this->get_name]";
               }
               set ::FFF::newEllipsisCommentLine 1
             }
           }
         }

         array set resParamConfigArr [$this->get_resolved_param_config_arr]
         array set resParamValueArr  [$this->get_resolved_param_value_arr]
         if {[array size resParamConfigArr] > 0} {
           set str1 "Parameter"
           set str2 "Value"
           set str3 "Configuration"
           ::FFF::dbg_puts $ptsargs [format "$dbgPrefixWs    %-*s %-*s %-*s" 30 $str1 20 $str2 20 $str3]
           foreach var [array names resParamConfigArr] {
             set str1 $var
             set str2 $resParamValueArr($var)
             set str3 [$resParamConfigArr($var)->get_name]
             ::FFF::dbg_puts $ptsargs [format "$dbgPrefixWs    %-*s %-*s %-*s" 30 $str1 20 $str2 20 $str3]
           }
         }
         ::FFF::dbg_puts $ptsargs "##########################################################"
       };# end member report_stats

       # This member method determines the ::FFFdb::vars() variables that affect this step
       # BUDA: Do we need to run resolve_param here too?
       member analyze_dependent_vars {} {
	 ::FFF::fff_member_init
         set FFFdbVarlist {}
         set var_count 0
         set lineNum 0
         for {set i 1} {$i <= [array size mStepCmdArr]} {incr i} {
	   incr lineNum
           set stepCommand $mStepCmdArr($i)
           set token_list [split $stepCommand "$" ]
#	   if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}token_list->$token_list<-"}
	   set elab_cmd ""

	   set token_num 0
	   foreach token $token_list {
             incr token_num
	     set orig_token $token
	     if {$token ne ""} {
#	       if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}Processing line $lineNum, token $token_num: ->$token<-"}
               if {[regexp {vars\((.*?)\)} $token match submatch]} {
	         # We found a Foundation Flow Variable ($vars())
#	         if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}Current token: ->$token<-, Found an FF variable (regexp match): ->vars($submatch)<-. Attempting to resolve it..."}
	         # check each bound configuration for this variable
	         set resolvedValue [$this->resolve_var vars($submatch)]
#	         if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}Finished resolve_var. Current resolvedValue is ->$resolvedValue<-"}
	         if { $resolvedValue ne "-1" } {
	           # With variable resolved, we first decide whether to surround variable with curlies
#	           if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}Resolved variable to: ->$resolvedValue<-"}
#	           if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}Performing substitution in token ->$token<- with resolved value ->$resolvedValue<-"}
		   # Add this to the running list of resolved vars (these would have been resolved earlier)
                   # This was already done by resolve_var above ...
#                   ###if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}Adding var ->$stepVar<- with value ->[set ${var_ns}::$stepVar]<- to mResolvedVarArr"}
                   ###$this->set_resolved_vars $submatch $resolvedValue

	           incr var_count
                   lappend FFFdbVarlist "\$vars($submatch)"
#	           if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}Added \$vars($submatch) to FFFdbVarlist"}
#		   if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}Current var count: $var_count"}
	 	   # Perform substitution on token (do we really need to do this?)
	           #regsub {(vars\(.*?\))} $token $resolvedValue token
	         } else {
#                   if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}Unable to resolve variable ->vars($submatch)<-."}
#                   if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}Adding ->vars($submatch)<- to unresolved vars list"}
                   $this->add_unresolved_vars "vars($submatch)"
                 }
	       }; #end found a foundationflow var
             };# end $token ne ""
           };# end foreach token 
         };# end foreach line in mStepCmdArr
	 ::FFF::fff_member_close
#         if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Returning: ->[lsort -unique [::FFF::flatten_list $FFFdbVarlist]]<-"}
         return [lsort -unique [::FFF::flatten_list $FFFdbVarlist]]
       }; # end member function analyze_dependent_vars
    
       # Sets the next node to the provided argument
       # or if no argument is given, returns the current next Node Object
       # @return the next Node object
      
       member next {{newNext "NULL"}} {
          if {$newNext ne "NULL"} {
             set mNext $newNext
          }
          return $mNext
       }
       # Sets the prev Node object to the argument
       # or if not argument is given, returns the current prev Node Object
       # @return the previous node
       member prev {{newPrev "NULL"}} {
          if {$newPrev ne "NULL"} {
             set mPrev $newPrev
          }
          return $mPrev
       }
       # Returns data of Node object
       member get_name {} {
	 if {[info exists mName]} {
           return $mName
         } else {
	   return "NOTNAMED"
	 }
       }
       member ~Step {} {
         ::FFF::fff_member_init
         ::FFF::dbg_puts "Deleting [$this->get_name] ($this)"
#         if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Removing ($this) pubThis: $pubThis)from ::FFF::step_objid_arr"}
         array unset ::FFF::step_objid_arr $pubThis
	 if {[info exists ::FFF::step_objid_arr($pubThis)]} {
#           if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} INTERNAL ERROR: ($this) still exists in ::FFF::step_objid_arr with value: $::FFF::step_objid_arr($this)"}
	 }
#         if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Current Steps: ->[get_step -instances -basename ${mBaseName} -non_elab]<-"}
       }
    };# end Object Step Declaration
  };# end uplevel 1
}; # end proc define_step_object
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [get_config.tcl]                                                 #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @						             #
#  Date        [01-11-2011]                                                  #
##############################################################################

proc get_config {args} {
  if {$args ne ""} {
    if {![string match -* [lindex $args 0]] && [llength $args] == 1} {
      return [lindex [array get ::FFF::config_objid_list $args] 1]
    }
    while {[string match -* [lindex $args 0]] } {
        set option [lindex $args 0]
        set args [lrange $args 1 end]
        #puts "process_config_args(): insert_config option: $option, args: $args"
        switch -exact -- $option {
          -name {
            set config_name [lrange $args 0 0]
            set args [lrange $args 1 end]
            return [lindex [array get ::FFF::config_objid_list $config_name] 1]
          }
          -id {
            set config_id [lrange $args 0 0]
            set args [lrange $args 1 end]
            # This is not the cheapest way to search the values in an array, but should be ok
            # if our flows are less than 500,000 configs and we don't perform this too often (good for the time being)
            set config_objid_list [array get ::FFF::config_objid_list]
            set matchid [lsearch $config_objid_list $config_id]
            if {$matchid eq "-1"} {
              return $matchid
            } else {
              incr matchid -1
              return [lindex $config_objid_list $matchid]
            }
          }
          -readme {
            puts $::fcf_header::README;
            return
          }
          -help {
            puts $::fcf_header::README;
            return
          }
          -regexp {
            set match_config_list {}
            set re [lrange $args 0 0]
            set args [lrange $args 1 end]
            set complete_list [array names ::FFF::config_objid_list]
            foreach name $complete_list {
              if {[regexp $re $name match]} {
                lappend match_config_list [lindex [array get ::FFF::config_objid_list $name] 1]
              }
            }
            return $match_config_list
          }
          default {
            return -code error "insert_config: unknown option \"$option\""
          }
        };# switch
    };# while
  } else {
      #No args provided
  };# $args ne ""
  #array get ::FFF::config_objid_list $config_name
}

# Alias to proc get_config
proc get_configuration {args} {
  get_config $args
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [get_flow.tcl]                                                #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @	     #
#  Date        [01-11-2011]                                                  #
##############################################################################

# Define the proc in it's own variable namespace (consistent with RC applets)
namespace eval FFF {

  namespace export get_flow

  proc get_flow {args} {
    set dbgPrefixWs [string repeat " " [info level]]
    set msgPrefix "${dbgPrefixWs}get_flow:"
    set Debug $::FFF::Debug
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix BEGIN at [clock format [clock seconds]]"}
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix args: ->$args<-"}
  

    # Implement parse_options here
    # Also, specify no option for elab vs nonelab

    set myBaseName ""
    set myFlowObjID ""
    set myHelpFlag ""
    set myRegExp ""
    set myNonElabFlag 0
    set myFlowName ""
    set myInstancesFlag 0

    switch -- [parse_options [calling_proc] {} $args \
      "-basename sos Exact original Flow base name (original name, will not include _u\# suffixes)" myBaseName \
      "-instances bos Return Flow instances instead of original (created) flow" myInstancesFlag \
      "-id sos Return the name of a flow given it's object ID as an argument" myFlowObjID \
      "-help bos Print Readme Information on the Foundation Flow" myHelpFlag \
      "-regexp sos Filter flow names using regular expression syntax" myRegExp \
      "-non_elab bos Query from the non-elab database" myNonElabFlag \
      "sos Exact (possibly uniquified) flow name, which may include _u\# suffixes" myFlowName \
    ] {
      -2 { return }
      0 { error "Failed on [lindex [info level 0] 0]" }
    }

    if {$myNonElabFlag} {
      set elab_switch "non_elab"
    } else {
      set elab_switch "default"
    }

    if {[array exists ::FFF::elabdb::flow_objid_arr] && $elab_switch eq "default"} {
      # We are elaborated 
      array set flow_objid_arr [array get ::FFF::elabdb::flow_objid_arr]
      set elaborated 1
    } else {
      # We are not elaborated, or the non_elab switch was specified
      # Next determine whether to search for flow instances or the original flow declaration.
      if {$myInstancesFlag} {
#        #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix Will look for Flow Instances in the ::FFF::flowInst_objid_arr array"}
        if {[array exists ::FFF::flowInst_objid_arr] && [array size ::FFF::flowInst_objid_arr] > 0} {
          array set flow_objid_arr [array get ::FFF::flowInst_objid_arr]
        } else {
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix No Flows defined"}
          return -1
        }
      } else {
#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix Will look for Flow Definitions in the ::FFF::flow_objid_arr array"}
        if {[array exists ::FFF::flow_objid_arr] && [array size ::FFF::flow_objid_arr] > 0} {
          array set flow_objid_arr [array get ::FFF::flow_objid_arr]
        } else {
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix No Flows defined"}
          return -1
        }
      }
      set elaborated 0
    }

#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix set arr flow_objid_arr  to ->[array get flow_objid_arr]<-"}
    #if {$elaborated} {
#    #  if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix FFF DB is elaborated"}
    #} else {
#    #  if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix FFF DB is NOT elaborated"}
    #}

    #
    # Simple search algorithm when the user is only searching for the exact name
    #  
    if {$args ne ""} {
      if {![string match -* [lindex $args 0]] && [llength $args] == 1} {
        #set candidate [lindex [array get flow_objid_arr] [incr  [lsearch  [array get flow_objid_arr] $args] -1 ]]
        ##nagelfar ignore
        set candidate [::FFF::array_search flow_objid_arr $args]
        if {$candidate ne ""} {
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix returning $candidate"}
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix END"}
          return $candidate
        } else {
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix END"}
          return -1
        }
      }
      while {[string match -* [lindex $args 0]] } {
          set option [lindex $args 0]
          set args [lrange $args 1 end]
          switch -exact -- $option {
            -name {
              set flow_name [lrange $args 0 0]
              set args [lrange $args 1 end]
              #return [lindex [array get $flow_objid_arr $flow_name] 1]
#              if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix END"}
              #set candidate [lindex [array get flow_objid_arr] [incr  [lsearch  [array get flow_objid_arr] $flow_name] -1 ]]
              ##nagelfar ignore
              set candidate [::FFF::array_search flow_objid_arr $flow_name]
              if {$candidate ne ""} {
#                if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix returning $candidate"}
#                if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix END"}
                return $candidate
              } else {
#                if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix END"}
                return -1
              }
            }
            -id {
              set flow_id [lrange $args 0 0]
              set args [lrange $args 1 end]
              # This is not the cheapest way to search the values in an array, but should be ok
              # if our flows are less than 500,000 flows and we don't perform this too often (good for the time being)
              #set flow_objid_arr [array get $flow_objid_arr]
              #set matchid [lsearch $flow_objid_arr $flow_id]
              #if {$matchid eq "-1"} {
              #  return $matchid
              #} else {
              #  incr matchid -1
              #  return [lindex $flow_objid_arr $matchid]
              #}
              return [lindex [array get flow_objid_arr $flow_id] 1]
            }
	    -instances {
	    }
            -readme {
              puts $::fcf_header::README;
              return
            }
            -help {
              puts $::fcf_header::README;
              return
            }
            -basename {
              # Return all flows with the exact same basename
              set match_flow_list {}
              set basename [lrange $args 0 0]
              set args [lrange $args 1 end]
              set flowObjIDList [array names flow_objid_arr]
#              #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix flowObjIDList: ->$flowObjIDList<-"}
              foreach flowObjID $flowObjIDList {
                set foundBaseName [$flowObjID->get_base_name]
#                #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix searching basename: ->$basename<- in flow ->[$flowObjID->get_name]<-"}
                if {$basename eq $foundBaseName} {
#                  if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix FOUND MATCH to basename: $foundBaseName in flow [$flowObjID->get_name]"}
                  lappend match_flow_list $flowObjID
                }
              }
              if {$match_flow_list ne ""} {
                return $match_flow_list
              } else {
                return -1
              }
            }
            -regexp {
              # Return glob style match of flows 
              set match_flow_list {}
              set re [lrange $args 0 0]
              if {$re eq "*"} {
    	        set re ".*"
	      }	
              set args [lrange $args 1 end]
              set flowObjIDList [array names flow_objid_arr]
              #puts "$msgPrefix flowObjIDList: ->$flowObjIDList<-"
              foreach flowObjID $flowObjIDList {
                #puts "$msgPrefix searching regexp: ->$re<- in name ->[$flowObjID->get_name]<-"
                if {[regexp $re [$flowObjID->get_name] match]} {
                  #puts "$msgPrefix FOUND MATCH: ->$match<- match list ->[lindex [array get flow_objid_arr $flowObjID] 1]<-"
                  lappend match_flow_list $flowObjID
                }
              }
	      if {$match_flow_list ne ""} {
                return $match_flow_list
              } else {
                return -1
              }
            }
            default {
#              if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix END"}
              return -code error "get_flow: unknown option \"$option\""
            }
          };# switch
      };# while
    } else {
        #No args provided
    };# $args ne ""
    #array get ::FFF::flow_objid_arr $flow_name
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix END"}
  }
};# end namespace eval FFF

if {![llength [info commands ::get_flow]]} {
    namespace import ::FFF::get_flow
    add_command_help get_flow "Get the flow id for a flow in a Foundation Flow"
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [get_stage.tcl]                                                 #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @						             #
#  Date        [01-11-2011]                                                  #
##############################################################################
# Define the proc in it's own variable namespace (consistent with RC applets)
namespace eval FFF {

  # export the proc so it can be read into the elab ns ($elabns)
  namespace export get_stage

  proc get_stage {args} {
    set dbgPrefixWs [string repeat " " [info level]]
    set msgPrefix "${dbgPrefixWs}get_stage:"
    set Debug $::FFF::Debug
  
    # Parse Options
  
    set myBaseName ""
    set myStageObjID ""
    set myHelpFlag ""
    set myRegExp ""
    set myNonElabFlag 0
    set myStageName ""
    set myInstancesFlag 0
    
    switch -- [parse_options [calling_proc] {} $args \
      "-basename sos Exact original stage base name (original name, will not include _u\# suffixes)" myBaseName \
      "-instances bos Return Stage instances instead of original (created) stage" myInstancesFlag \
      "-id sos Return the name of a stage given it's object ID as an argument" myStageObjID \
      "-help bos Print Readme Information on the Foundation Flow" myHelpFlag \
      "-regexp sos Filter stage names using regular expression syntax" myRegExp \
      "-non_elab bos Query from the non-elab database" myNonElabFlag \
      "sos Exact (possibly uniquified) stage name, which may include _u\# suffixes" myStageName \
    ] {
      -2 { return }
      0 { error "Failed on [lindex [info level 0] 0]" }
    }
  
    if {$myNonElabFlag} {
      set elab_switch "non_elab"
    } else {
      set elab_switch "default"
    }

    # modify regular expression if "*" is passed as a name (shortcut)
    if {$myRegExp eq "" && $myStageName eq "*"} {
      set myRegExp ".*"
    } 
  
    if {[array exists ::FFF::elabdb::stage_objid_arr] && $elab_switch eq "default"} {
      # We are elaborated 
      array set stage_objid_arr [array get ::FFF::elabdb::stage_objid_arr]
      set elaborated 1
    } else {
      # We are not elaborated, or the non_elab switch was specified
      # Next determine whether to search for stage instances or the original stage declaration.
      if {$myInstancesFlag} {
        if {[array exists ::FFF::stageInst_objid_arr] && [array size ::FFF::stageInst_objid_arr] > 0} {
          array set stage_objid_arr [array get ::FFF::stageInst_objid_arr]
        } else {
          return -1
        }
      } else {
        if {[array exists ::FFF::stage_objid_arr] && [array size ::FFF::stage_objid_arr] > 0} {
          array set stage_objid_arr [array get ::FFF::stage_objid_arr]
        } else {
          return -1
        }
      }
      set elaborated 0
    }
  
    if {$args ne ""} {
      if {![string match -* [lindex $args 0]] && [llength $args] == 1} {
        ##nagelfar ignore
        set candidate [::FFF::array_search stage_objid_arr $args]
        if {$candidate ne ""} {
          return $candidate
        } else {
          return -1
        }
      }
      while {[string match -* [lindex $args 0]] } {
          set option [lindex $args 0]
          set args [lrange $args 1 end]
          switch -exact -- $option {
            -name {
              set stage_name [lrange $args 0 0]
              set args [lrange $args 1 end]
              ##nagelfar ignore
              set candidate [::FFF::array_search stage_objid_arr $stage_name]
              if {$candidate ne ""} {
                return $candidate
              } else {
                return -1
              }
            }
  	  -basename {
  	    # Return all stages with the exact same basename
  	    set match_stage_list {}
            set basename [lrange $args 0 0]
            set args [lrange $args 1 end]
            set stageObjIDList [array names stage_objid_arr]
            foreach stageObjID $stageObjIDList {
  	      set foundBaseName [$stageObjID->get_base_name]
  	      if {$basename eq $foundBaseName} {
                  lappend match_stage_list $stageObjID
                }
              }
  	    if {$match_stage_list ne ""} {
                return $match_stage_list
  	    } else {
  	      return -1
  	    }
  	  }
          -id {
            set stage_id [lrange $args 0 0]
            set args [lrange $args 1 end]
  	    return [lindex [array get stage_objid_arr $stage_id] 1]
          }
          -help {
            puts $::fcf_header::README;
            return
          }
  	  -instances {
	  }
  	  -non_elab {
	  }
          -regexp {
  	  # Return glob style match of stages 
            set match_stage_list {}
            #set re [lrange $args 0 0]
            set re $myRegExp

            # Fix the regular expression for a pure wildcard anyway (should be ok 99.999% of the time!)
            if {$re eq "*"} {
    	      set re ".*"
	    }	
            set args [lrange $args 1 end]
            set stageObjIDList [array names stage_objid_arr]
            foreach stageObjID $stageObjIDList {
              if {[regexp $re [$stageObjID->get_name] match]} {
                lappend match_stage_list $stageObjID
              }
            }
            return $match_stage_list
          }
          default {
            return -code error "insert_stage: unknown option \"$option\""
          }
        };# switch
      };# while
    } else {
     #No args provided. Return help info...
      help get_stage
    };# $args ne ""
  };# end proc get_stage

}; # end namespace eval 

if {![llength [info commands ::get_stage]]} {
    namespace import ::FFF::get_stage
    add_command_help get_stage "Get the stage id for a stage in a Foundation Flow"
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [get_step.tcl]                                                 #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
# Define the proc in it's own variable namespace (consistent with RC applets)
namespace eval FFF {

  namespace export get_step

  proc get_step {args} {
    set dbgPrefixWs [string repeat " " [info level]]
    set msgPrefix "${dbgPrefixWs}get_step:"
    set Debug $::FFF::Debug
  
    set myBaseName ""
    set myStepObjID ""
    set myStageObjID ""
    set myHelpFlag ""
    set myRegExp ""
    set myNonElabFlag 0
    set myStepName ""
    set myInstancesFlag 0
    array set step_objid_arr {}
    array unset step_objid_arr
    array set step_objid_arr {}
  
    switch -- [parse_options [calling_proc] {} $args \
      "-basename sos Exact original step base name (original name, will not include _i<#> suffixes)" myBaseName \
      "-instances bos Return Step instances instead of original (created) step" myInstancesFlag \
      "-id sos Return the name of a step given it's object ID as an argument" myStepObjID \
      "-stage sos only search for steps instantiated in the stage (ID)" myStageObjID \
      "-help bos Print Readme Information on the Foundation Flow" myHelpFlag \
      "-regexp sos Filter step names using regular expression syntax" myRegExp \
      "-non_elab bos Query from the non-elab database" myNonElabFlag \
      "sos Exact (possibly uniquified) step name, which may include _i<#> suffixes" myStepName \
    ] {
      -2 { return }
      0 { error "Failed on [lindex [info level 0] 0]" }
    }
  
    if {$myNonElabFlag} {
      set elab_switch "non_elab"
    } else {
      set elab_switch "default"
    }
  
  
    if {[array exists ::FFF::elabdb::step_objid_arr] && $elab_switch eq "default"} {
      # We are elaborated 
      array set step_objid_arr [array get ::FFF::elabdb::step_objid_arr]
      array set step_objid_arr [array get ::FFF::elabdb::plugin_objid_arr]
      set elaborated 1
    } else {
      # We are not elaborated, or the non_elab switch was specified
      # Next determine whether to search for step instances or the original step declaration.
      if {$myInstancesFlag} {
        if {[array exists ::FFF::stepInst_objid_arr] && [array size ::FFF::stepInst_objid_arr] > 0} {
          array set step_objid_arr [array get ::FFF::stepInst_objid_arr]
          array set step_objid_arr [array get ::FFF::pluginInst_objid_arr]
        } else {
          return -1
        }
      } else {
        if {[array exists ::FFF::step_objid_arr] && [array size ::FFF::step_objid_arr] > 0} {
          array set step_objid_arr [array get ::FFF::step_objid_arr]
          array set step_objid_arr [array get ::FFF::plugin_objid_arr]
        } else {
          return -1
        } 
      }
      set elaborated 0
    }

    if {$args ne ""} {
      if {![string match -* [lindex $args 0]] && [llength $args] == 1} {
        # nagelfars complains about a token used as a constant and an array. Can be fixed by using [array get ...], but
        # that causes my upvar call in this proc to fail. Such is the life of a tcl programmer...
        ##nagelfar ignore
        set candidate [::FFF::array_search step_objid_arr $args]
  
        if {$candidate ne ""} {
          return $candidate
        } else {
          return -1
        }
      }

      if {$myStageObjID ne ""} {
	set stepObjIDList [$myStageObjID->get_steps]
      } else {
        set stepObjIDList [array names step_objid_arr]
      }

      while {[string match -* [lindex $args 0]] } {
          set option [lindex $args 0]
          set args [lrange $args 1 end]
          switch -exact -- $option {
            -name {
              set step_name [lrange $args 0 0]
              set args [lrange $args 1 end]
              ##nagelfar ignore
              set candidate [::FFF::array_search step_objid_arr $step_name]
              if {$candidate ne ""} {
                return $candidate
              } else {
                return -1
              }
            }
            -id {
              set step_id [lrange $args 0 0]
              set args [lrange $args 1 end]
              return [lindex [array get step_objid_arr $step_id] 1]
            }
            -readme {
              puts $::fcf_header::README;
              return
            }
            -help {
              puts $::fcf_header::README;
              return
            }

            -instances {
            }
            -stage {
              set args [lrange $args 1 end]
            }
  	  -basename {
  	    # Return all steps with the exact same basename
  	    set match_step_list {}
            set basename [lrange $args 0 0]
            set args [lrange $args 1 end]
            foreach stepObjID $stepObjIDList {
  	      if {$basename eq [$stepObjID->get_base_name]} {
                lappend match_step_list $stepObjID
              }
            }
	    if {$match_step_list ne ""} {
              return $match_step_list
	    } else {
              return -1
	    }
  
  	  }
            -regexp {
  	    # Return glob style match of steps 
              set match_step_list {}
              set re [lrange $args 0 0]
              set args [lrange $args 1 end]
              foreach stepObjID $stepObjIDList {
                if {[regexp $re [$stepObjID->get_name]]} {
                  lappend match_step_list $stepObjID
                }
              }
              return $match_step_list
            }
            default {
              return -code error "get_step: unknown option \"$option\""
            }
          };# switch
      };# while
    };# $args ne ""
  };# end proc
};#end namespace eval FFF

if {![llength [info commands ::get_step]]} {
    namespace import ::FFF::get_step
    add_command_help get_step "Get the step id for a step in a Foundation Flow"
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [get_var.tcl]                                                 #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {
  # Variables are stored in the FFFdb namespace
  namespace export get_var

  proc get_var {args} {
    if {[llength $args] > 1} {
        while {[string match -* [lindex $args 0]] } {
            set option [lindex $args 0]
            set args [lrange $args 1 end]
            switch -exact -- $option {
              -name {
                set var_name [lrange $args 0 0]
                set args [lrange $args 1 end]
              }
  	    -config {
                set config_name [lrange $args 0 0]
                set args [lrange $args 1 end]
              }
              -readme {
                puts $::fcf_header::README;
                return
              }
              -help {
                puts $::fcf_header::README;
                return
              }
              -regexp {
                set match_var_list {}
                set re_base [lrange $args 0 0]
                set re "($re_base)"
                puts "get_var(): re_base: $re_base, re: $re"
                set args [lrange $args 1 end]
  	      # TO BE IMPLEMENTED!!!
                #set complete_list 
                ###foreach name $complete_list {
                ###  if {[regexp $re $name full match]} {
                ###    lappend match_var_list $match
                ###  }
                ###}
                #return $match_var_list
              }
              default {
                return -code error "insert_step: unknown option \"$option\""
              }
            };# switch
        };# while
    } else {
      #If only a single arg, assume the single arg is the complete name of the variable, and the regexp
      # is defaulting to -config *
      # TO BE IMPLEMENTED
      #return [lindex [array get ::FFFdb::var_objid_list $args] 1]
    };# $args ne ""
    # Future - support filtering by configuration (i.e., get_var foo -config buda)
  }
}
if {![llength [info commands ::get_var]]} {
    namespace import ::FFF::get_var
    # When we move to parse_options for this proc, uncomment the following code:
    #add_command_help get_var "Get the variable in the Foundation Flow"
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [insert_flow.tcl]                                         #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
##############################################################################

namespace eval FFF {
  ###############################################################
  # insert_flow
  # Usage: insert_flow [-name <name>] [-depend <id> ] [-instance <id>] [-config <id>]
  ###############################################################
  proc insert_flow {args} {
    if {[catch {
    set Debug $::FFF::Debug
    # Always called within a create_flow block (flows cannot be inserted anywhere
    # else)
    # so we can upvar 1 and get the parent flow
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "insert_flow: args ->$args<-"}
    upvar 1 flowName parentflowName_local

    set myFlowBaseName "anonymous"
    set myFlowInstanceName ""
    set myDependFlowObjID ""
    set myConfigurationList {}

    # For the - args applied to this proc
    set dash_args_list {}

    # Pull out name and brace block first
    if { $args ne "" } {
      set index 0
      set token [lindex $args $index]
      set insert_flow_args {}
      while {$token ne ""} {
        if { ![string match -* $token] } {
          if {[llength $token] == 1} {
            set myFlowBaseName $token
          } elseif {[llength $token] > 1} {
            lappend insert_flow_args $token
          }
        } else {
          lappend dash_args_list $token
          incr index
          lappend dash_args_list [lindex $args $index]
        }
        incr index
        set token [lindex $args $index]
      }
    }

    # Set new dash args list  
    set dash_args_list [::FFF::flatten_list $dash_args_list]
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "insert_flow: BLOCK ->$insert_flow_args<-"}
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "insert_flow: dash args ->$dash_args_list<-"}

    switch -- [parse_options insert_flow {} $dash_args_list \
       "-instance sos Instance name (for hierarchical path referencing)" myInstanceName \
       "-depend sos Flow depends on this step completing first" myDependFlowObjID \
       "-readme bos Print Readme Information on the Foundation Flow" myReadmeFlag \
       "-config sos Configuration name(s) to bind to the step" myConfigurationList \
       ] {
       -2 { return }
       0 { error "Failed on [lindex [info level 0] 0]" }
    }

    ##############################################################      
    # create args list to pass to object creation
    if { $myDependFlowObjID ne "" } {
      set insert_flow_depend_args "-depend $myDependFlowObjID"
    }

    ##############################################################      

    # Clean up curlies
    while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $insert_flow_args full insert_flow_args ]} {
    }

    # Initialize array (block of commands) for the Flow Object
    array set local_arr {}

    # Set or increment flowName number (the number of times this flow name has been used)
    if {$insert_flow_args ne ""} {
      if {![array exists ::FFF::unique_flow_name_arr]} {
        array set ::FFF::unique_flow_name_arr {}
        set ::FFF::unique_flow_name_arr($myFlowBaseName) 1
      } else {
        if {[info exists ::FFF::unique_flow_name_arr($myFlowBaseName)]} {
          set ::FFF::unique_flow_name_arr($myFlowBaseName) [expr {$::FFF::unique_flow_name_arr($myFlowBaseName) + 1}]
        } else {
          set ::FFF::unique_flow_name_arr($myFlowBaseName) 1
        }
      }
    };# end $insert_flow_args ne ""

    # Create uniquified flow name:
    set myFlowName ${myFlowBaseName}_i[set ::FFF::unique_flow_name_arr($myFlowBaseName)]

    # Split on newlines:
    set insert_flow_args [split $insert_flow_args "\n"]

    # Create the flow
    # create_flow ...<args>...
    # To Be Implemented (best to reuse the create_flow command here)
  } errorMsg]} {
    dbg_puts -print_stdout "<FF> INTERNAL-ERROR: insert_flow(). Stack Trace:\n$errorMsg"
    dbg_puts -print_stdout "<FF>                 Contact the Cadence Product Core Team for assistance."
  }
  }; # end proc insert_flow()
}; # end namespace eval
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [insert_stage.tcl]                                         #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
##############################################################################

namespace eval FFF {
  ###############################################################
  # insert_stage
  # Usage: insert_stage [-name <name>] [-before <id> | -after <id>
  #  -begin | -end ]
  ###############################################################
  proc insert_stage {args} {
    if {[catch {
    set dbgPrefixWs [string repeat " " [info level]]
    set msgPrefix "${dbgPrefixWs}insert_stage():"
    set Debug $::FFF::Debug
    # Always called within a create_flow or create_stage block
    # so we can upvar 1 and get the calling stageName
    # Regardless, the target name and ObjID used in this script are parentName_local and parentObjID_local
    upvar 1 stageName parentName_local
    upvar 1 stageObjID parentObjID_local
    if {![info exists parentObjID_local]} {
      # We are in a flow, not a stage
      upvar 1 flowName parentName_local
      upvar 1 flowObjID parentObjID_local
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} In a Flow. Parent Name: [$parentObjID_local->get_name], type: [$parentObjID_local->typeid], ID: $parentObjID_local"}
    } else {
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} In a Stage. Parent Name: [$parentObjID_local->get_name], type: [$parentObjID_local->typeid], ID: $parentObjID_local"}
    }

    # Default variables
    set commandName insert_stage
    set myStageBaseName "anonymous"
    set myInstanceName ""
    set myBeforeStageOrStepObjID ""
    set myAfterStageOrStepObjID ""
    set myInsertAtBeginningFlag 0
    set myInsertAtEndFlag 0
    set myNoStageHeaderFlag 0
    set myStageHeaderFlag 0
    set myConfigurationList {}
    set myFullInsertStageLocationList {}
    set dash_args_list {}
    set parse_options_args_list {}
    set param_args_list {}
    set paramConfigObjID ""
    set insert_stage_args {}
    set insert_stage_location_args ""
 
    set stage_id_list {} 
    set config_list {}
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} args: ->$args<-s"}
    set insert_stage_args {}

    set origStageArgs $args
    # #####################################################################
    # The following block processes dash args and extracts the stage name
    # #####################################################################
    #
    # Pull out name first (default is anonymous)
    # Separate block from dash args
    # Create $insert_stage_args (the block) and $dash_args_list (to be passed to parse_options)
    set token [lindex $origStageArgs 0]
    while {$token ne ""} {
#      #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} processing token ->$token<-"}
      if { [string match -* $token] } {
        if { $token eq "-parameter" || $token eq "-param" || $token eq "-parameter_map"} {
          lappend param_args_list $token
          lappend param_args_list [lrange $origStageArgs 1 1]
          set origStageArgs [lrange $origStageArgs 2 end]
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} param_args_list ->$param_args_list<-"}
        } elseif { $token eq "-end" || $token eq "-begin" || $token eq "-readme" || $token eq "-help" || $token eq "-no_stage_header" } {
          lappend parse_options_args_list $token
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} adding token ->$token<- to parse_options_args_list, which is now ->$parse_options_args_list<- "}
          set origStageArgs [lrange $origStageArgs 1 end]
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} setting origStageArgs to ->[lrange $origStageArgs 1 1]<-"}
        } elseif { $token eq "-config" } {
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} match on -config ->$token<- origStageArgs ->[lrange $origStageArgs 1 1]<-"}
          set myConfigurationList [::FFF::flatten_list [lrange $origStageArgs 1 1]]
          set origStageArgs [lrange $origStageArgs 2 end]
          # "-config sos Configuration name(s) to bind to the stage" myConfigurationList
        } elseif { $token eq "-before" } {
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} match on -before ->$token<- origStageArgs ->[lrange $origStageArgs 1 1]<-"}
          set myBeforeStageOrStepObjID [::FFF::flatten_list [lrange $origStageArgs 1 1]]
          set origStageArgs [lrange $origStageArgs 2 end]
        } elseif { $token eq "-after" } {
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} match on -before ->$token<- origStageArgs ->[lrange $origStageArgs 1 1]<-"}
          set myAfterStageOrStepObjID [::FFF::flatten_list [lrange $origStageArgs 1 1]]
          set origStageArgs [lrange $origStageArgs 2 end]
        } elseif { $token eq "-instance" } {
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} match on -instance ->$token<- origStageArgs ->[lrange $origStageArgs 1 1]<-"}
          set myInstanceName [::FFF::flatten_list [lrange $origStageArgs 1 1]]
          set origStageArgs [lrange $origStageArgs 2 end]
        } else {
          # unrecognized option, and not a block statement
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} WARNING: not a recognized option: ->$token<-"}
          set origStageArgs [lrange $origStageArgs 1 end]
        }
      } elseif { [regexp {\s} $token] } {
        # else this is not a dash argument, but it's a list of more than 1 element
          lappend insert_stage_args $token
#          if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} insert_stage_args ->$insert_stage_args<-"}
          set origStageArgs [lrange $origStageArgs 1 end]
      } else {
        # else this is not a dash argument, and it's a single item, therefore we assume this is the Stage name
        set myStageBaseName $token
        set msgPrefix "${dbgPrefixWs}insert_stage($myStageBaseName):"
        ::FFF::dbg_puts "Inserted"
        set origStageArgs [lrange $origStageArgs 1 end]
      }
      set token [lindex $origStageArgs 0]
    }
    # Now process parameters. We process the params separately because parse_options doesn't support multiple entries
    # yet. I.e., it cannot support foo -param a=1 -param b=2

    array set paramArray {}
    set index 0
    set token [lindex $param_args_list $index]
    while {$token ne ""} {
       set paramMap [lindex $param_args_list [incr index]]
       #set param_args_list [lrange $param_args_list 1 end]
#       #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Processing token: ->$token<- with possible paramMap: ->$paramMap<-"}
       switch -exact -- $token {
         -parameter {
           puts "WARNING: This parameter syntax will be obsoleted in future versions of the Foundation Flow."
           puts "Please use the new syntax: -parameter_map {<name> <value>}"
           puts "Note - the new syntax supports passing lists as parameters."
           if {[regexp {(\S+)=(\S+)} $paramMap full paramName paramValue]} {
             #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Found Parameter Map: paramName: ->$paramName<- in stage shall be mapped to value: ->$paramValue<-"}
             set paramArray($paramName) $paramValue
             #set param_args_list [lrange $param_args_list 1 end]
           } else {
             puts "ERROR: parameter specified incorrectly: ->$token $paramMap<-"
             puts "Usage: -parameter name=value"
             puts "Exiting ..."
             exit 1
           }
         }
        -param {
           puts "WARNING: This parameter syntax will be obsoleted in future versions of the Foundation Flow."
           puts "Please use the new syntax: -parameter_map {<name> <value>}"
           puts "Note - the new syntax supports passing lists as parameters."
           if {[regexp {(\S+)=(\S+)} $paramMap full paramName paramValue]} {
             #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Found Parameter Map: paramName: ->$paramName<- in stage shall be mapped to value: ->$paramValue<-"}
             set paramArray($paramName) $paramValue
             #set param_args_list [lrange $param_args_list 1 end]
           } else {
             puts "ERROR: parameter specified incorrectly: ->$token $paramMap<-"
             puts "Usage: -parameter name=value"
             puts "Exiting ..."
             exit 1
           }
         }
         -parameter_map {
#           if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Parameter Map: ->$paramMap<-"}
           set paramName [lindex [::FFF::flatten_list $paramMap] 0]
#           if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Parameter Name: ->$paramName<-"}
           set paramValue [list [lrange [::FFF::flatten_list $paramMap] 1 end]]
#           if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Parameter Name: ->$paramValue<-"}
             #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Found Parameter Map: paramName: ->$paramName<- in stage shall be mapped to value: ->$paramValue<-"}
           set paramArray($paramName) $paramValue
         }
       };# end switch
      incr index
      set token [lindex $param_args_list $index]
    };# end while

#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Processing parse options args->$parse_options_args_list<-"}
    set parse_options_args_list [::FFF::flatten_list $parse_options_args_list]
    switch -- [parse_options insert_stage {} $parse_options_args_list \
       "-instance sos Instance name (for hierarchical path referencing)" myInstanceName \
       "-before sos Insert before this stage or step" myBeforeStageOrStepObjID \
       "-after sos Insert after this stage or step" myAfterStageOrStepObjID \
       "-begin bos Insert stage at beginning of the stage" myInsertAtBeginningFlag \
       "-end bos Insert stage at end of the stage" myInsertAtEndFlag \
       "-readme bos Print Readme Information on the Foundation Flow" myReadmeFlag \
       "-no_stage_header bos Do not print a header comment before the stage is printed" myNoStageHeaderFlag \
       ] {
       -2 { return }
       0 { error "Failed on [lindex [info level 0] 0]" }
    }


    ##############################################################
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} myConfigurationList ->$myConfigurationList<-"}
    set myConfigurationObjIDList {}
    # Support for Default Configurations (EDI Style)
    if {$myConfigurationList eq ""} {
      if {$::FFF::verboseMessaging} {
        puts "$commandName NOTE: No configuration specified for stage \"$myStageBaseName\". Binding to default configuration."
      }
      set  myConfigurationObjIDList $::FFF::myDefaultConfigObjID
      set myConfigurationList [ $::FFF::myDefaultConfigObjID->get_name]
    } else {
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Configuration(s) ->$myConfigurationList<-"}
      foreach configName $myConfigurationList {
#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Adding to config list: ->$configName<- id:->[get_config $configName]<-"}
        lappend myConfigurationObjIDList [get_config $configName]
      }
    }
    set myConfigurationObjIDList [::FFF::flatten_list $myConfigurationObjIDList]
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Final configuration ID list: ->$myConfigurationObjIDList<-"}

    ##############################################################      
    # Determine Object type if -before or -after was used
    # For stages, after the stage means we extract the tail step, while before the stage means we extract the head step
    ##############################################################      
    if {$myAfterStageOrStepObjID ne ""} {
      if {[$myAfterStageOrStepObjID->typeid] eq "Stage"} {
#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} myAfterStageOrStepObjID is a Stage: ->$myAfterStageOrStepObjID<-"}
        lappend myFullInsertStageLocationList [$myAfterStageOrStepObjID->get_tail]
#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Will insert after the tail of the stage, which is [[$myAfterStageOrStepObjID->get_tail]->get_name] ([$myAfterStageOrStepObjID->get_tail])"}
      } elseif {[$myAfterStageOrStepObjID->typeid] eq "Step"} {
#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} myAfterStageOrStepObjID is a Step: ->$myAfterStageOrStepObjID<-"}
        lappend myFullInsertStageLocationList $myAfterStageOrStepObjID
      }
    }
    if {$myBeforeStageOrStepObjID ne ""} {
      if {[$myBeforeStageOrStepObjID->typeid] eq "Stage"} {
#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} myBeforeStageOrStepObjID is a Stage: ->$myBeforeStageOrStepObjID<-"}
        lappend myFullInsertStageLocationList [$myBeforeStageOrStepObjID->get_head]
#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Will insert before the head of the stage, which is [[$myBeforeStageOrStepObjID->get_head]->get_name] ([$myBeforeStageOrStepObjID->get_head])"}
      } elseif {[$myBeforeStageOrStepObjID->typeid] eq "Step"} {
#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} myBeforeStageOrStepObjID is a Step: ->$myBeforeStageOrStepObjID<-"}
        lappend myFullInsertStageLocationList $myBeforeStageOrStepObjID
      }
    }

    ##############################################################      
    # Error checking for insert_stage location options
    # Only one location is allowed per call to insert_stage.
    ##############################################################      

#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} myFullInsertStageLocationList: ->$myFullInsertStageLocationList<-"}
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} determining length of myFullInsertStageLocationList: ->$myFullInsertStageLocationList<-"}
    if {$myFullInsertStageLocationList ne ""} {
      set location_opt_count [llength [list $myFullInsertStageLocationList]]
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Set location_opt_count as Length of myFullInsertStageLocationList: ->$location_opt_count<-"}
    } else {
      set location_opt_count 0
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Set location_opt_count to 0 as Length of myFullInsertStageLocationList: ->$location_opt_count<-"}
    }
    if {$myInsertAtBeginningFlag} {
      incr location_opt_count
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Incremented location_opt_count count due to \$myInsertAtBeginningFlag set to ->$myInsertAtBeginningFlag<- : ->$location_opt_count<-"}
    }
    if {$myInsertAtEndFlag} {
      incr location_opt_count $myInsertAtEndFlag
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Incremented location_opt_count count due to \$myInsertAtEndFlag set to ->$myInsertAtEndFlag<- : ->$location_opt_count<-"}
    }
    if {$myNoStageHeaderFlag} {
      set myStageHeaderFlag 0
    } else {
      set myStageHeaderFlag 1
    }

    if {$location_opt_count > 1 } {
      puts "$commandName($myStageBaseName) ERROR: More than one location given to $commandName: ->$args<-"
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix}  ERROR: More than one location given to $commandName: ->$args<-"}
      return -2
    } else {
      # create args list to pass to object creation
      # for -before|-after, use $myFullInsertStageLocationList, since this will have the resolved head or tail of the stage
      if { $myBeforeStageOrStepObjID ne "" } {
        set insert_stage_location_args "-before [::FFF::flatten_list $myFullInsertStageLocationList]"
      }
      if { $myAfterStageOrStepObjID ne "" } {
        set insert_stage_location_args "-after [::FFF::flatten_list $myFullInsertStageLocationList]"
      }
      if { $myInsertAtBeginningFlag ne ""} {
        if { $myInsertAtBeginningFlag } {
          set insert_stage_location_args "-begin"
        }
      }
      if { $myInsertAtEndFlag ne ""} {
        if { $myInsertAtEndFlag } {
          set insert_stage_location_args "-end"
        }
      }
      # Check and see if we set it to anything. If not, set default to be -end
      if {$insert_stage_location_args eq ""} {
        if {$::FFF::verboseMessaging} {
          puts "insert_stage NOTE: Inserting stage $myStageBaseName at end of stage (Default location)"
        }
        set insert_stage_location_args "-end"
      }
    }

    ##############################################################      
    # Uniquify Stage Name
    ##############################################################      
    # Overload the stage name by advancing it one number
    # Create new "uniquified" stage name.
    # Example: original: 'syn' -> uniquified: 'syn_u1'

    # Note - this is required when stages are defined using insert_stage in a stage
    # In this scenario, we cannot expect the user to always uniquify each stage (nor should they have to)
    # This is obvious for the case of multiway instantiation (insert_stage genReports -after [get_step -regexp .*synth.*])

#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Uniquifying stage name"}
    if {![array exists ::FFF::unique_stage_name_arr]} {
      array set ::FFF::unique_stage_name_arr {}
      set ::FFF::unique_stage_name_arr($myStageBaseName) 1
#      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Created unique name arr value for ->$myStageBaseName<- : ->$::FFF::unique_stage_name_arr($myStageBaseName)<-"}
    } else {
      if {[info exists ::FFF::unique_stage_name_arr($myStageBaseName)]} {
        set ::FFF::unique_stage_name_arr($myStageBaseName) [expr {$::FFF::unique_stage_name_arr($myStageBaseName) + 1}]
#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} incremented counter for ->$myStageBaseName<- to ->$::FFF::unique_stage_name_arr($myStageBaseName)<-"}
      } else {
        set ::FFF::unique_stage_name_arr($myStageBaseName) 1
#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Creating counter for ->$myStageBaseName<-: value: ->$::FFF::unique_stage_name_arr($myStageBaseName)<-"}
      }
    }

    set myStageName ${myStageBaseName}_i[set ::FFF::unique_stage_name_arr($myStageBaseName)]
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Uniquified stage name is ->$myStageName<-"}

    ##############################################################      
    # Check parameter mapping passed to stage
    ##############################################################      
    if { [array names paramArray] ne "" } {
      # Here's the magic for parameters. Basically we create a new config for the stage only
      # We then populate the config variables, and bind this config to the stage.
      # The stage variables are then processed like any other configuration.
      # Note - this configuration goes at the beginning, so as to overwrite any other duplicate variables
      set paramConfigObjID [new Configuration ${myStageName}.param $args]
      foreach paramName [array names paramArray] {
        $paramConfigObjID->update_vars "set $paramName $paramArray($paramName)"
      }
      lappend myConfigurationObjIDList $paramConfigObjID
    }

    # clean up the stage args
    while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $insert_stage_args full insert_stage_args ]} { }

    #
    # Here we create the stage and populate the associated info
    #
    set stageObjID [new StageInst $myStageName]

    ::FFF::dbg_puts "Created new StageInst: $stageObjID"
    $stageObjID->set_instance_name $myInstanceName
    $stageObjID->set_param_configurations $paramConfigObjID
    $stageObjID->set_base_name $myStageBaseName


    $parentObjID_local->insert_stage $stageObjID $insert_stage_location_args
    set msgPrefix "${dbgPrefixWs}[$parentObjID_local->typeid]($parentName_local)->insert_stage($myStageName):"

    # Execute whatever is in the remainder of the set_stage block
    eval $insert_stage_args

    #################################################################################
    # Check to see if this new Stage Instance has the same basename of a previously defined
    # Stage (i.e., defined by create_stage)
    #################################################################################
    #
    # Check if the Stage we just created has a command block, and create messages for user based on the following logic:
    #
    # Condition   First Cmd              Second Cmd                 Result
    # 1           create_stage         -> insert_stage          ----> WARNING: Abnormal (everything is empty)
    # 2           create_stage         -> insert_stage {block}  ----> NOTE: Abnormal (create_stage was empty?)
    # 3           create_stage {block} -> insert_stage          ----> No Note (Normal)
    # 4           create_stage {block} -> insert_stage {block}  ----> ERROR: (overwriting create_stage cmd block)

    #
    # Look for an existing stage object defined by create_stage:
    #
    set existingStageObjID [get_stage -basename $myStageBaseName -non_elab]


    if {$existingStageObjID ne "-1"} {
      if {[$existingStageObjID->is_empty]} {
        if {[$stageObjID->is_empty]} {
          # Condition 1: insert_stage overwriting an empty create_stage with another empty block (not a recommended use model as it's hard to follow the FCF)
          puts "insert_stage() WARNING: insert_stage inserting empty stage $myStageName, previously defined as an empty stage using create_stage. Define the stage contents in the create_stage command."
        } else {
          # Condition 2: insert_stage overwriting create_stage where the creat_stage block was empty (Unusual)
          puts "insert_stage() NOTE: Defining commands for Stage [$stageObjID->get_base_name] in insert_stage block, when a previous create_stage command defined the Stage as empty."
        }
      } else {
        # Found stage (created through create_stage) and it has a non-empty command array.
        if {[$stageObjID->is_empty]} {
          # Condition 3: insert_stage binding to a create_stage (non-empty) block (Normal usage)
          if {$existingStageObjID ne "-1"} {
            $existingStageObjID->copy_to ${stageObjID}
          }
        } else {
          # Condition 4: insert_stage wants to overwrite a stage definition defined by create_stage (Incorrect (ERROR) usage)
          if {$::FFF::elaborated_once == 0} {
            puts "insert_stage() ERROR: insert_stage called with a stage block, when create_stage already defined the stage block for [$stageObjID->get_base_name]"
            puts "insert_stage block:"
            $stageObjID->print
            puts "create_stage block:"
            $existingStageObjID->print
            puts "FCF Syntax only allows block definition in either the create_stage command or insert_stage command, but not both."
          } else {
            puts "insert_stage() NOTE: Redefining [$existingStageObjID->get_base_name]"
          }
        }
      }
    };# end if $existingStageObjID ne "-1"

    # Bind to the specified configuration, to overwrite any (potential) previous binding
    foreach configObjID $myConfigurationObjIDList {
      $stageObjID->bind_to_config $configObjID
    }

    # Set the stage header print flag last, to overwrite the defaults from create_stage
    $stageObjID->set_print_stage_header_flag $myStageHeaderFlag

    # 
    # Register the Stage Instance
    #
    set ::FFF::stageInst_objid_arr($stageObjID) $myStageName
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} set ::FFF::stageInst_objid_arr($stageObjID) to $::FFF::stageInst_objid_arr($stageObjID)"}

    # At this point the stage object is created. We now need to set it's head and tail if it inside another stage
    #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} END"}
  } errorMsg]} {
    dbg_puts -print_stdout "<FF> INTERNAL-ERROR: insert_stage(). Stack Trace:\n$errorMsg"
    dbg_puts -print_stdout "<FF>                 Contact the Cadence Product Core Team for assistance."
  }
  }; # end proc insert_stage()
}; # end namespace eval
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [insert_step.tcl]                                         #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################

namespace eval FFF {
  ###############################################################
  # insert_step
  # Usage: insert_step <name> [-before <id> | -after <id>
  #  -begin | -end ] {step text}
  ###############################################################
  proc insert_step {args} {
    if {[catch {
    set dbgPrefixWs [string repeat " " [info level]]
    set msgPrefix "${dbgPrefixWs}insert_step:"
    set Debug $::FFF::Debug
    # Always called within a set_stage block (by a set_stage dynamically generated proc)
    # so we can upvar 1 and get the calling stageName
    set commandName insert_step
    set myStepBaseName "anonymous"
    set myInstanceName ""
    set myBeforeStepObjID ""
    set myAfterStepObjID ""
    set myInsertAtBeginningFlag 0
    set myInsertAtEndFlag 0
    set myNoStepHeaderFlag 0
    set myStepHeaderFlag 0
    set myConfigurationList {}
    set myFullInsertStepLocationList {} 
    set dash_args_list {}
    set parse_options_args_list {}
    set param_args_list {}
    set required_args_list {}
    set paramConfigObjID ""
    set insert_step_args {}
    set insert_step_location_args ""
    set myRequireAllVarsFlag 0
    set myRequireAllVarsSeverity ""
    upvar 1 stageName stageName_local
    upvar 1 stageObjID stageObjID_local

    set origStepArgs $args 

    # #####################################################################
    # The following block processes dash args and extracts the step name, param args, and required_files args
    # #####################################################################
    #
    # Pull out name first (default is anonymous)
    # Separate block from dash args
    # Create $insert_step_args (the block) and $dash_args_list (to be passed to parse_options)
    set token [lindex $origStepArgs 0]
    while {$token ne ""} {
      if { [string match -* $token] } {
        if { $token eq "-parameter" || $token eq "-param" || $token eq "-parameter_map"} {
          lappend param_args_list $token
          lappend param_args_list [lrange $origStepArgs 1 1]
	  set origStepArgs [lrange $origStepArgs 2 end]
	} elseif { $token eq "-required_files" || $token eq "-required_vars" || $token eq "-require_all_vars" } {
          lappend required_args_list $token
          if {$token eq "-require_all_vars"} {
            if {[regexp {error|warn|note} [lrange $origStepArgs 1 1]]} {
              # The user specified the severity. Use it.
              lappend required_args_list [lrange $origStepArgs 1 1]
              set origStepArgs [lrange $origStepArgs 2 end]
            } else {
              # If the user didn't specify the severity as the second argument, use the default:
              lappend required_args_list $::FFF::myDefaultRequiredFilesSeverityLevel
              set origStepArgs [lrange $origStepArgs 1 end]
            }
          } else {
            lappend required_args_list [lrange $origStepArgs 1 1]
            set origStepArgs [lrange $origStepArgs 2 end]
          }
	} elseif { $token eq "-end" || $token eq "-begin" || $token eq "-readme" || $token eq "-help" || $token eq "-no_step_header" } {
          lappend parse_options_args_list $token
	  set origStepArgs [lrange $origStepArgs 1 end]
        } elseif { $token eq "-config" } {
          set myConfigurationList [flatten_list [lrange $origStepArgs 1 1]]
	  set origStepArgs [lrange $origStepArgs 2 end]
          # "-config sos Configuration name(s) to bind to the step" myConfigurationList
        } elseif { $token eq "-before" } {
          set myBeforeStepObjID [flatten_list [lrange $origStepArgs 1 1]]
	  set origStepArgs [lrange $origStepArgs 2 end]
        } elseif { $token eq "-after" } {
          set myAfterStepObjID [flatten_list [lrange $origStepArgs 1 1]]
	  set origStepArgs [lrange $origStepArgs 2 end]
        } elseif { $token eq "-instance" } {
          set myInstanceName [flatten_list [lrange $origStepArgs 1 1]]
	  set origStepArgs [lrange $origStepArgs 2 end]
	} else {
	  # unrecognized option, and not a block statement
	  set origStepArgs [lrange $origStepArgs 1 end]
        }
      } elseif { [regexp {\s} $token] || $myStepBaseName ne "anonymous"} {
	# else this is not a dash argument, but it's a list of more than 1 element
	# or, the step name has be identified, and the token has no spaces (this is the case where the stepblock has no spaces)
          lappend insert_step_args $token
	  set origStepArgs [lrange $origStepArgs 1 end]
      } else {
	# else this is not a dash argument, and it's a single item, therefore we assume this is the step name
        set myStepBaseName $token
	set origStepArgs [lrange $origStepArgs 1 end]
        # get next token
      }
      set token [lindex $origStepArgs 0]
    }
    set msgPrefix "${dbgPrefixWs}insert_step($myStepBaseName):"
    # Now process parameters. We process the params separately because parse_options doesn't support multiple entries
    # yet. I.e., it cannot support foo -param a=1 -param b=2

    ####################################################################################
    # Process param_args_list
    ####################################################################################
    array set paramArray {}
    set index 0
    set token [lindex $param_args_list $index]
    while {$token ne ""} {
       set paramMap [lindex $param_args_list [incr index]]
       switch -exact -- $token {
         -parameter_map {
	   set paramName [lindex [flatten_list $paramMap] 0]
	   set paramValue [list [lrange [flatten_list $paramMap] 1 end]]
	   set paramArray($paramName) $paramValue
         }
       };# end switch
      incr index
      set token [lindex $param_args_list $index]
    };# end while

    ####################################################################################
    # Process required_args_list
    ####################################################################################
    #
    # Two arrays to attract severity for each file or variable
    #
    array set requiredFilesArr {}
    array set requiredVarsArr {}
    set index 0
    set token [lindex $required_args_list $index]
    while {$token ne ""} {
      set requiredFilesOrVarsMap [lindex $required_args_list [incr index]]
      #
      # Remove outer curlies and spaces
      #
      while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $requiredFilesOrVarsMap full requiredFilesOrVarsMap]} {}
      switch -exact -- $token {
        -required_files {
	   if {[llength $requiredFilesOrVarsMap] == 2} {
             set requiredFilesList [lindex $requiredFilesOrVarsMap 0]
             set severity [list [lrange $requiredFilesOrVarsMap 1 end]]
	   } elseif {[llength $requiredFilesOrVarsMap] == 1} {
             set requiredFilesList [flatten_list $requiredFilesOrVarsMap]
             set severity $::FFF::myDefaultRequiredFilesSeverityLevel
           } else {
	     puts "insert_step() ERROR: Illegal number of arguments passed to -required_files option."
	     puts "   insert_step ... $token $requiredFilesOrVarsMap"
	     puts "Usage: insert_step ... -required_files {<file list> <severity>}"
	     exit 1
	   }
	   #
	   # Remove outer curlies from file list
	   #
           while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $requiredFilesList full requiredFilesList]} {}
	   foreach fileOrVar $requiredFilesList {  
             set requiredFilesArr($fileOrVar) $severity
	     #
	     # We only add the variable in to the missing severity array if it matches the vars() regexp
	     #
	     if {[regexp {^\$vars\((.*)\)} $fileOrVar full key]} {
               set requiredVarsArr(vars($key)) $severity
  	     }
	   }
        }
        -required_vars {
	   if {[llength $requiredFilesOrVarsMap] == 2} {
             set requiredVarsList [lindex $requiredFilesOrVarsMap 0]
             set severity [list [lrange $requiredFilesOrVarsMap 1 end]]
	   } elseif {[llength $requiredFilesOrVarsMap] == 1} {
             set requiredVarsList [flatten_list $requiredFilesOrVarsMap]
             set severity $::FFF::myDefaultRequiredVarsSeverityLevel
           } else {
	     puts "insert_step() ERROR: Illegal number of arguments passed to -required_vars option."
	     puts "   insert_step ... $token $requiredFilesOrVarsMap"
	     puts "Usage: insert_step ... -required_vars {<file list> <severity>}"
	     exit 1
	   }
	   #
	   # Remove outer curlies from file list
	   #
           while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $requiredVarsList full requiredVarsList]} {}
	   foreach fileOrVar $requiredVarsList {  
	     if {[regexp {^\$vars\((.*)\)} $fileOrVar full key]} {
               set requiredVarsArr(vars($key)) $severity
  	     }
	   }
        }
	-require_all_vars {
	   set myRequireAllVarsFlag 1
           set myRequireAllVarsSeverity $requiredFilesOrVarsMap
	}
      };# end switch
      incr index
      set token [lindex $required_args_list $index]
    };# end while

    set parse_options_args_list [flatten_list $parse_options_args_list]
    switch -- [parse_options insert_step {} $parse_options_args_list \
       "-instance sos Instance name (for hierarchical path referencing)" myInstanceName \
       "-before sos Insert before this step" myBeforeStepObjID \
       "-after sos Insert after this step" myAfterStepObjID \
       "-begin bos Insert step at beginning of stage" myInsertAtBeginningFlag \
       "-end bos Insert step at end of stage" myInsertAtEndFlag \
       "-readme bos Print Readme Information on the Foundation Flow" myReadmeFlag \
       "-no_step_header bos Do not print a header comment before the step is printed" myNoStepHeaderFlag \
       ] {
       -2 { return }
       0 { error "Failed on [lindex [info level 0] 0]" }
    }

    ##############################################################
    set myConfigurationObjIDList {}
    # Support for Default Configurations (EDI Style)
    if {$myConfigurationList eq ""} {
      if {$::FFF::verboseMessaging} {
        puts "$commandName NOTE: No configuration specified for step \"$myStepBaseName\". Binding to default configuration."
      }
      set myConfigurationObjIDList $::FFF::myDefaultConfigObjID
      set myConfigurationList [ $::FFF::myDefaultConfigObjID->get_name]
    } else {
      foreach configName $myConfigurationList {
	lappend myConfigurationObjIDList [get_config $configName]
      }
    }
    set myConfigurationObjIDList [flatten_list $myConfigurationObjIDList]

    ##############################################################	
    if {$myBeforeStepObjID ne ""} {
      lappend myFullInsertStepLocationList $myBeforeStepObjID
    }
    if {$myAfterStepObjID ne ""} {
      lappend myFullInsertStepLocationList $myAfterStepObjID
    }
      
    if {$myFullInsertStepLocationList ne ""} {
      set location_opt_count [llength [list $myFullInsertStepLocationList]]
    } else {
      set location_opt_count 0
    }
    if {$myInsertAtBeginningFlag} {
      incr location_opt_count
    }
    if {$myInsertAtEndFlag} {
      incr location_opt_count $myInsertAtEndFlag
    }
    if {$myNoStepHeaderFlag} {
      set myStepHeaderFlag 0
    } else {
      set myStepHeaderFlag 1
    }
    
    if {$location_opt_count > 1 } {
      puts "insert_step($myStepBaseName) ERROR: More than one location given to insert_step: ->$args<-"
      return -2
    } else {
      # create args list to pass to object creation
      if { $myBeforeStepObjID ne "" } {
        set insert_step_location_args "-before $myBeforeStepObjID"
      }
      if { $myAfterStepObjID ne "" } {
        set insert_step_location_args "-after $myAfterStepObjID"
      }
      if { $myInsertAtBeginningFlag ne ""} {
	if { $myInsertAtBeginningFlag } {
          set insert_step_location_args "-begin"
	}
      }
      if { $myInsertAtEndFlag ne ""} {
	if { $myInsertAtEndFlag } {
          set insert_step_location_args "-end"
	}
      }
      # Check and see if we set it to anything. If not, error
      if {$insert_step_location_args eq ""} {
        if {$::FFF::verboseMessaging} {
	  puts "insert_step NOTE: Inserting step $myStepBaseName at end of stage (Default location)"
	}
        set insert_step_location_args "-end"
      }
    } 

    ##############################################################	
    # Create Step Instance Name
    ##############################################################	
    # Overload the original step name by advancing it one number
    # Create new "uniquified" step name.
    # Example: original: 'syn' -> uniquified: 'syn_i1'

    # Note - this is required when steps are defined using insert_step in a stage
    # In this scenario, we cannot expect the user to always uniquify each step (nor should they have to)
    # This is obvious for the case of multiway instantiation (insert_step genReports -after [get_step -regexp .*synth.*])

    if {![array exists ::FFF::unique_step_name_arr]} {
      array set ::FFF::unique_step_name_arr {}
      set ::FFF::unique_step_name_arr($myStepBaseName) 1
    } else {
      if {[info exists ::FFF::unique_step_name_arr($myStepBaseName)]} {
        set ::FFF::unique_step_name_arr($myStepBaseName) [expr {$::FFF::unique_step_name_arr($myStepBaseName) + 1}]
      } else {
        set ::FFF::unique_step_name_arr($myStepBaseName) 1
      }
    }

    set myStepName ${myStepBaseName}_i[set ::FFF::unique_step_name_arr($myStepBaseName)]

    ##############################################################	
    # Check parameter mapping passed to step
    ##############################################################	
    if { [array names paramArray] ne "" } {
      # Here's the magic for parameters. Basically we create a new config for the step only
      # We then populate the config variables, and bind this config to the step.
      # The step variables are then processed like any other configuration.
      # Note - this configuration is "pushed" onto the parameter config stack, as it should overwrite any previously bound default configuration.
      # The oppposite is true for default configurations specified with the create configuration command. They are pushed onto the 
      # bottom of the parameter stack, as they should only be relevant if the insert_step param configuration does not specify all parameters.
      # In other words, parameters specified in insert_step take precidence over the default parameters specified in create_step.

      set paramConfigObjID [new Configuration ${myStepName}.param $args]
      foreach paramName [array names paramArray] {
        $paramConfigObjID->update_vars "set $paramName $paramArray($paramName)"
      }
      # Buda 7/5/2011 - removed auto appending of paramConfigs to standard config List
      # We will process parameters separately now. The paramConfigObjID will be pushed onto the current list for the inserted object
      #lappend myConfigurationObjIDList $paramConfigObjID
    }

    # Buda: old - this was getting rid of leading white space, which doesn't print pretty.
    #while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $insert_step_args full insert_step_args ]} {}
    # New: get rid of the first curly, and all whitespace after the last non-whitespace character, and the last curly
    while {[regexp {^\{(.*)[[:space:]]*\}$} $insert_step_args full insert_step_args ]} {}
    # At this point all the relevant arguments have been extracted, and we can
    # continue with block processing
    while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $insert_step_args full args ]} {
      # Iteratively strip curly braces on the outside of the block.
      # This is needed in order to pass the entire block to eval below
    };# end while

    # Initialize command array (block of commands) for the step Object
    array set local_arr {}


    ##################################################################      
    # Check for existing step definition with same basename
    ##################################################################      
    # See if there are any existing steps with the same basename
    set stepDefinitionObjID [get_step -basename ${myStepBaseName} -non_elab]

    ##################################################################      
    # Create new StepInst
    ##################################################################      
    set stepObjID [new StepInst $myStepName ]
    $stepObjID->set_base_name $myStepBaseName
    set ::FFF::stepInst_objid_arr($stepObjID) $myStepName

    #################################################################################
    # If inserting step w/out block, copy existing Step Definition (if one exists) into this StepInst
    #################################################################################
    if {$insert_step_args eq ""} {
      if {$stepDefinitionObjID ne "-1"} {
        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Copying contents of $stepDefinitionObjID to $stepObjID"} 
        $stepDefinitionObjID->copy_to ${stepObjID}
	# This will copy the following:
	#  mName
	#  mBaseName
	#  mStepCmdArr
	#  mOrigStepCmdArr
	#  mResolvedConfigArr
	#  mRow
	#  mColumn
	#  mConfigList
	#  mParamConfigList
	#  mParamConfigID
	#  mPrintStepHeader
	#  mPluginCmd
	#  mResolvedVarArr

        # 7/05/11 We need to update the following copied values from the step definition (post copy_to):
	#  instance name
	#  param configurations
        # 5/11/11 OBSOLETE COMMENT: Note - this copies configurations, which at this point should be empty.
        # 5/11/11 OBSOLETE COMMENT: Configuration binding can only happen in an instantiated step
        # UPDATE 5/5/2011!
        # Due to new requirement for default parameters, config binding is now allowed at step creation.
        # copy_to always supported copying configuration bindings, so now this copy step will copy any configurations bound at step creation to
        # the stepObjID created here. The intent is only for default parameter values (though strictly speaking, not limited to default parameters,
        # there is currently no other configuration binding possible in the create_step command)
      };# end stepDefinitionObjID ne ""
    };# end insert_step_args eq ""

    ##################################################################      
    # Check if args were passed.
    # If so, build command block, and update created step object
    ##################################################################      
    if {$insert_step_args ne ""} {
      #
      # Step inserted with command block
      # Create appropriate array structure, and update the created StepInst
      #

      set insert_step_args [split $insert_step_args "\n"]
     
      # Fix up the step block (get rid of extraneous curly braces)
      # Create cmd arr to pass to Step Object
      set index 1
      foreach arg $insert_step_args {
        set local_arr($index) $arg
        incr index
      }

      # Strip first array entry if it is empty ("")
      # This corresponds to the empty space that exists between the opening curly brace of a step and the beginning of the step block:
      # insert_step foo {
      #  a command       /\
      #  a command       || the empty white space here!
      # }
      #
      if {$local_arr(1) eq ""} {
        array unset local_arr 1
        # Now shift array keys down by one
        foreach lineNum [lsort -dictionary [array names local_arr]] {
          set local_arr([expr {$lineNum -1}]) $local_arr($lineNum)
        }
	# Delete last entry (lineNum will be the last key since we sorted above)
        array unset local_arr $lineNum
      }
      
      # Strip last array entry if it is empty ("")
      # This corresponds to the empty space to the left of the close curly:
      # insert_step foo {
      #  a command
      #  a command
      # }
      #/\
      #|| the empty white space here!
      set lastEntry [lindex [lsort -dictionary [array names local_arr]] end]
      if {$local_arr($lastEntry) eq ""} {
        array unset local_arr $lastEntry
      }

      # Strip any white-space only lines off the end of the command block
      # 5/11/2012: COMMENTED OUT PER REQUEST FROM RICHO
      #while {[regexp {^[[:space:]]*$} $local_arr([array size local_arr]) full]} {
      #  array unset local_arr [array size local_arr]
      #}

      # Here we create the step and populate the associated info
      # Note - every call to "insert_step" generates a new Obj ID, as the instance always has a unique ID
      $stepObjID->set_cmd_block [array get local_arr]

      #
      # We go ahead and set the orig cmd block.
      # If there is a subsequent create_step command, it will automatically overwrite the orig cmd block.
      # If not, we are still ok.
      #
      $stepObjID->set_orig_cmd_block [array get local_arr]
    }

    #########################################################################################################
    # Now, determine user messaging depending on whether step was already defined using a create_step command
    # Possible states:
    #
    # Condition   First Cmd		   Second Cmd                 Result
    # 1           create_step         -> insert_step	        ----> WARNING: Abnormal (everything is empty)
    # 2           create_step         -> insert_step {block}  ----> NOTE: Abnormal (create_step was empty?)
    # 3           create_step {block} -> insert_step	        ----> No Note (Normal)
    # 4           create_step {block} -> insert_step {block}  ----> ERROR: (overwriting create_step cmd block)
    #
    # Note: no errors issued when rerunning elaboration
    #########################################################################################################
  
    if {$stepDefinitionObjID ne "-1"} {
      if {[$stepDefinitionObjID->get_block_size] == 0} {
        if {[array size local_arr] == 0} {
          # Condition 1
          puts "insert_step() WARNING: Step [$stepObjID->get_base_name] defined with an empty block, and insert_step command for instance [$stepDefinitionObjID->get_name] also has an empty block"
        } else {
          # Condition 2
          # insert_step wants to overwrite a step with a non-zero command block
          puts "insert_step() NOTE: Defining commands for Step [$stepObjID->get_base_name] in insert_step block, when a previous create_step command defined the block to be empty."
        }
      } else {
        # Existing step has a non-zero command array.
        if {[array size local_arr] == 0} {
          # Condition 3
          # Here the only thing we need to do is 
        } else {
          # Condition 4
          # insert_step wants to overwrite a step with a non-zero command block
          if {$::FFF::elaborated_once == 0} {
            puts "insert_step() ERROR: insert_step called with a command block, when create_step already defined the command block for [$stepObjID->get_base_name]"
            puts "insert_step commands:"
            $stepObjID->print 
            puts "create_step commands:"
            $stepDefinitionObjID->print
            puts "FCF Syntax only allows block definition in either the create_step command or insert_step command, but not both."
          } else {
            puts "insert_step() NOTE: Redefining [$stepDefinitionObjID->get_base_name]"
          }
        }
      }
    };# end if $stepDefinitionObjID ne "-1"

    #
    # Push the parameter config onto the generated step if it is not empty (specified using -parameter_map)
    #
    if {$paramConfigObjID ne ""} {
      $stepObjID->push_param_config $paramConfigObjID
    }

    #
    # Bind configurations (specified using -config)
    #
    foreach configObjID $myConfigurationObjIDList {
      $stepObjID->push_config $configObjID
    }
    #
    # Set the instance name and step header print flag
    #
    $stepObjID->set_instance_name $myInstanceName
    $stepObjID->set_print_step_header_flag $myStepHeaderFlag
    
    #
    # Add required vars / files to Step (if any already exist)
    #
    $stepObjID->update_required_vars_arr [array get requiredVarsArr]
    $stepObjID->update_required_files_arr [array get requiredFilesArr]

    #
    # Resolve parameters for the step
    #
    $stepObjID->resolve_parameters_in_command_block

    #
    # Optionally set all vars required flag
    #
    if {$myRequireAllVarsFlag} {
      $stepObjID->set_all_vars_required
      $stepObjID->set_all_vars_required_severity $myRequireAllVarsSeverity
    }

    #
    # Set the insert file name
    $stepObjID->set_insert_file ::FFF::fcfqc::current_filename

    #
    # Register the new step Object in the stepInst_objid_arr
    #
    set ::FFF::stepInst_objid_arr($stepObjID) $myStepName

    # Now, insert the step into the correct stage
    #set stageObjID [get_stage $stageName_local]
    $stageObjID_local->insert_step $stepObjID $insert_step_location_args

    ################################################################################
    # Print final stats for insert_step
    ################################################################################

#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM ""}
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} Final Stats for Inserted Step: $stepObjID"}
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} ##################################################"}
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} $myStepName $stepObjID"}
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} Inserted into Stage: [$stageObjID_local->get_name] ($stageObjID_local)"}
    set configList ""
    foreach configID [$stepObjID->get_configurations] {
      lappend configList [$configID->get_name]
    }

    array set resParamConfigArr [$stepObjID->get_resolved_param_config_arr]
    array set resParamValueArr [$stepObjID->get_resolved_param_value_arr]
    if {[array size resParamConfigArr] > 0} {
      set str1 "Parameter"
      set str2 "Value"
      set str3 "Configuration"
      foreach var [array names resParamConfigArr] {
        set str1 $var
        set str2 $resParamValueArr($var)
        set str3 [$resParamConfigArr($var)->get_name]
      }
    }

    array set reqVarSeverityArr [$stepObjID->get_required_vars_severity_arr]
    array set reqFilesSeverityArr [$stepObjID->get_required_files_severity_arr]
    if {[array size reqVarSeverityArr] > 0} {
      set str1 "Variable"
      set str2 "Missing (Var) Severity"
      foreach reqVar [array names reqVarSeverityArr] {
        set str1 $reqVar
        set str2 $reqVarSeverityArr($reqVar)
      }
    }
  } errorMsg]} {
    dbg_puts -print_stdout "<FF> INTERNAL-ERROR: insert_step(). Stack Trace:\n$errorMsg"
    dbg_puts -print_stdout "<FF>                 Contact the Cadence Product Core Team for assistance."
  }
  }; # end proc insert_step()
}; # end namespace eval
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [remove_step.tcl]                                         #
#  Description:                                                              #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @                                                            #
#  Date        [01-11-2011]                                                  #
##############################################################################

namespace eval FFF {

  # Do not export (yet)
  #namespace export remove_step
  
  proc remove_step {args} {
      set dbgPrefixWs [string repeat " " [info level]]
      set msgPrefix "${dbgPrefixWs}[::FFF::getProcName]():"
  
      set myBaseName ""
      set myStepObjID ""
      set myHelpFlag ""
      set myRegExp ""
      set myNonElabFlag 0
      set myStepName ""
      set myInstancesFlag 0
      array set step_objid_arr {}
      array unset step_objid_arr
      array set step_objid_arr {}
  
      switch -- [parse_options [calling_proc] {} $args \
        "-basename sos Exact original step base name (original name, will not include _u\# suffixes)" myBaseName \
        "-instances bos Return Step instances instead of original (created) step" myInstancesFlag \
        "-id sos Return the name of a step given it's object ID as an argument" myStepObjID \
        "-help bos Print Readme Information on the Foundation Flow" myHelpFlag \
        "-regexp sos Filter step names using regular expression syntax" myRegExp \
        "-non_elab bos Query from the non-elab database" myNonElabFlag \
        "sos Exact (possibly uniquified) step name, which may include _u\# suffixes" myStepName \
      ] { 
        -2 { return }
        0 { error "Failed on [lindex [info level 0] 0]" }
      }
      if {$myNonElabFlag} {
        set elab_switch "non_elab"
      } else {
        set elab_switch "default"
      }
  
  
      if {[array exists ::FFF::elabdb::step_objid_arr] && $elab_switch eq "default"} {
        # We are elaborated 
        array set step_objid_arr [array get ::FFF::elabdb::step_objid_arr]
        array set step_objid_arr [array get ::FFF::elabdb::plugin_objid_arr]
        set elaborated 1
      } else {
        # We are not elaborated, or the non_elab switch was specified
        # Next determine whether to search for step instances or the original step declaration.
        if {$myInstancesFlag} {
          if {[array exists ::FFF::stepInst_objid_arr] && [array size ::FFF::stepInst_objid_arr] > 0} {
            array set step_objid_arr [array get ::FFF::stepInst_objid_arr]
            array set step_objid_arr [array get ::FFF::pluginInst_objid_arr]
          } else {
            return -1
          }
        } else {
          if {[array exists ::FFF::step_objid_arr] && [array size ::FFF::step_objid_arr] > 0} {
            array set step_objid_arr [array get ::FFF::step_objid_arr]
            array set step_objid_arr [array get ::FFF::plugin_objid_arr]
          } else {
            return -1
          }
        }
        set elaborated 0
      }
      if {$args ne ""} {
        if {![string match -* [lindex $args 0]] && [llength $args] == 1} {
          # nagelfars complains about a token used as a constant and an array. Can be fixed by using [array get ...], but
          # that causes my upvar call in this proc to fail. Such is the life of a tcl programmer...
          ##nagelfar ignore
          set candidate [::FFF::array_search step_objid_arr $args]
          if {$candidate ne ""} {
            return $candidate
          } else {
            return -1
          }
        }
        while {[string match -* [lindex $args 0]] } {
            set option [lindex $args 0]
            set args [lrange $args 1 end]
            switch -exact -- $option {
              -name {
                set step_name [lrange $args 0 0]
                set args [lrange $args 1 end]
                ##nagelfar ignore
                set candidate [::FFF::array_search step_objid_arr $step_name]
                if {$candidate ne ""} {
                  return $candidate
                } else {
                  return -1
                }
              }
              -id {
                set step_id [lrange $args 0 0]
                set args [lrange $args 1 end]
                # Remove the step
                [lindex [array get step_objid_arr $step_id] 1]->remove_step
              }
              -readme {
                puts $::fcf_header::README;
                return
              }
              -help {
                puts $::fcf_header::README;
                return
              }
  
              -instances {
              }
            -basename {
              # Return all steps with the exact same basename
              set match_step_list {}
              set basename [lrange $args 0 0]
              set args [lrange $args 1 end]
              set stepObjIDList [array names step_objid_arr]
              foreach stepObjID $stepObjIDList {
                set foundBaseName [$stepObjID->get_base_name]
                if {$basename eq $foundBaseName} {
                  lappend match_step_list $stepObjID
                }
              }
              if {$match_step_list ne ""} {
                return $match_step_list
              } else {
                return -1
              }
  
            }
              -regexp {
              # Return glob style match of steps 
                set match_step_list {}
                set re [lrange $args 0 0]
                set args [lrange $args 1 end]
                set stepObjIDList [array names step_objid_arr]
                foreach stepObjID $stepObjIDList {
                  if {[regexp $re [$stepObjID->get_name] match]} {
                    lappend match_step_list $stepObjID
                  }
                }
                return $match_step_list
              }
              default {
                return -code error "insert_step: unknown option \"$option\""
              }
            };# switch
        };# while
      } else {
          #No args provided
      };# $args ne ""
      #array get ::FFF::step_objid_arr $step_name
    };# end proc
};# end namespace eval
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [lint.tcl]                               		     #
#  Description:                                                              #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @            #
#  Date        [01-11-2011]                                                  #
##############################################################################
# NOTE: Adapted from cpfreader.tcl, build date: 6-14/2011
##############################################################################

namespace eval ::FFF::fcfqc {

  namespace export *;
  array set message_severity_table {};
  variable  current_command "";
  variable  fail "";
  variable  current_filename;
  array set current_lineno {};
  array set base_lineno {};
  variable  msg "";
  variable  hierarchy_separator_chars {/ : . ^};
  variable  hierarchy_separator;
  variable  current_scope_level -1;
  variable  keep_leading_hierarchy_separator 0;
  variable  print_output_file_channel stdout;
  variable  current_scope;
  variable  testing_fcf_elaboration false;
  variable  message_callback_func "";
  array set open_file_channels {};
  
  variable  fcf_verbose 0;
  variable  fcf_print 0;
  variable  fcf_suppress_src_msg 0;
  variable  standalone_mode false;
  variable  num_lint_errs 0;
  variable  num_lint_warns 0;

  variable  num_lint_errs 0;
  variable  num_lint_warns 0;
  #
  # General Architecture
  #
  # 1. Follow FCF Lint architecture up until create_lint_message
  # 2. Create_lint_message creates a t++ lint message object (and prints messages
  #    per original functionality)
  # 3. Lint Message Objects registered in tracking array (similar to steps, stages, etc.)
  # 4. Reuse report/query functions to report on messages
  # 
  # Message Object member data:
  # name
  # msg_id
  # msg_txt
  # msg_explanation (i.e. for report rule check -verbose, or help/man)
  # severity
  # violation_num
  # file
  # row
  # column
  # waived
  #
  # member functions
  # get_* (member data (e.g. get_row, get_line ...))
  # set_* (member data (e.g., set_row, set_line ...))
  # change_severity (severity_level)
  # waive
  #  


  ###########################################################################
  # create_lint_message
  # inputs: key, argList
  # @return: lint message
  #
  # Notes: Called by lint_message, this proc looks up the lint message
  # in the array ::FFF::lint_message_arr using the key
  # It takes as arguments in the argList:
  #
  # cur_fcf;
  # msgArgs;
  # lint_message_arr;
  # current_filename;
  # current_lineno;
  # current_command;
  # message_callback_func;

  # Call stack:
  # Initialization:
  # ->Define lint_message_arr
  # ->Define msg_handler, regiser_message_callback procs
  # ->register_message_callback as the message handler {callback_func} (i.e.: register_message_callback msg_handler)
  #   This is effectively how to print the messages
  # lint_message (e.g.: ::FFF::fcfqc::lint_message error FCF-LINT-217 $current_command $fcf_version_used_for_checking;)
  #  ->create_lint_message (e.g.: create_lint_message $key args)
  #    -> strip_leading_hierarchy_separator (e.g.: [strip_leading_hierarchy_separator "" [lindex $args $i] 0])
  #    <- $msg
  #  -> eval set msg (extract from lint_message_arr) (e.g.: eval set msg \"$lint_message_arr($key)\")
  #  -> eval message_callback_func (registered as the msg_handler)_ (e.g.: eval msg_handler $current_command $key $type $current_filename $lineno $msg;)
   

##############################################################################
#  Lint message utilities
##############################################################################
  proc is_list { str } {
      if { [regexp {.\s+.} $str] } {
          return true;
      } else {
          return false;
      }
  }


    proc myassert {value {msg ""}} {
        if { !$value } {
            if { $::FFF::fcfqc::current_filename ne "" } {
                set lineno $::FFF::fcfqc::current_lineno($::FFF::fcfqc::current_filename);
                puts "Assert Fail: $msg at $::FFF::fcfqc::current_filename:$lineno";
            } else {
                puts "Assert Fail: $msg";
            }
            exit 1;
        }
    }

    ##############################################################################
    # lint_message_arr: look-up table of lint message IDs and explanations
    # Categories
    # 1xx - Basic setup, syntax, hierarchy, versioning, basic command usage
    # 2xx - Configurations / Variables / Parameters
    # 3xx - Steps
    # 4xx - Stages
    # 5xx - Flows
    # 6xx - TBD
    # 7xx - TBD
    # 8xx - TBD
    # 9xx - Misc
    ##############################################################################
    variable lint_message_arr
    array set lint_message_arr {
      LINT-101 {FCF Version '$msgArgs(0)' is not supported. Supported versions are '$msgArgs(1)'.}
      #LINT-102 {}
      #LINT-103 {$msgArgs(0) command not preceded by the $msgArgs(1) command.}
      #LINT-104 {}
      #LINT-105 {}
      #LINT-106 {$msgArgs(0) object '$msgArgs(1)' is undefined.}
      LINT-110 {Mandatory Argument '$msgArgs(0)' missing for command '$msgArgs(1)'. }
      #LINT-122 {Mandatory option '$msgArgs(0)' not specified.}
      #LINT-196 {Voltage range format '$msgArgs(0)' incorrect. Expected format is <lower_bound>:<upper_bound>\\\[:<step>\\\].}
      #LINT-197 {Step '$msgArgs(0)' is specified incorrectly in voltage range '$msgArgs(1)'.}
      VAR-201 {The Required Variable '$msgArgs(0)' in Step '$msgArgs(1)' is not defined. }
      VAR-202 {The Required Variable '$msgArgs(0)' in Plugin '$msgArgs(1)' is not defined. }
      VAR-203 {Required File '$msgArgs(0)' in Step '$msgArgs(1)' was not found. FF Variable: '$msgArgs(2)'}
      VAR-204 {Required File '$msgArgs(0)' in Plugin '$msgArgs(1)' was not found. FF Variable: '$msgArgs(2)'}
      VAR-205 {Var '$msgArgs(0)' was required but not used in Step '$msgArgs(1)'. }
      VAR-206 {Var '$msgArgs(0)' was required but not used in Plugin '$msgArgs(1)'. }
      LINT-246 {Unbalanced braces in the argument of the option: '$msgArgs(0)'.}
      #LINT-229 {Name '$msgArgs(0)' contains wildcard character '$msgArgs(1)'.}
      #LINT-217 {Command '$msgArgs(0)' is not valid in FCF version '$msgArgs(1)'. Either the FCF version is set incorrectly, or the tool only supports up to '$msgArgs(1)'.}
      #LINT-218 {Option '$msgArgs(0)' is not valid in FCF version '$msgArgs(1)'. Please set correct FCF version.}
      #LINT-114 {Argument '$msgArgs(0)' is invalid. Single character string is expected.}
      #LINT-135 {Argument '$msgArgs(0)' format is incorrect; expected format is <string>%s.}
      #LINT-136 {Argument '$msgArgs(0)' is incorrect; expected format is \[<character>\]%d\[<character>\].}
      #LINT-152 {Argument '$msgArgs(0)' for option $msgArgs(1) is invalid. Valid argument(s) are '$msgArgs(2)'.}
      #LINT-158 {Argument '$msgArgs(0)' to option '$msgArgs(1)' is not an integer.}
      #LINT-205 {Argument '$msgArgs(0)' for '$msgArgs(1)' is not a float.}
      #LINT-507 {Argument '$msgArgs(0)' for '$msgArgs(1)' should be a float, a triplet of float,  or 'off'.}
    }

    ##############################################################################
    #  Callback utilities
    ##############################################################################

    proc register_command_callback {callback_func} {
        variable command_callback_func;
        set command_callback_func $callback_func;
    }

    proc register_message_callback {callback_func} {
        set ::FFF::fcfqc::message_callback_func $callback_func;
    }

    proc register_hierarchical_fcf_found_notification {callback_func} {
        variable hier_callback_func;
        set hier_callback_func $callback_func;
    }

    ##############################################################################
    #  msg_handler: Simply print severity, lint code, command, args, filename, lineno
    ##############################################################################
    proc msg_handler {command key severity filename lineno args} {
        variable print_output_file_channel;
        #puts $print_output_file_channel "$severity: \[$key\] $command: $args ($filename:$lineno)";
	set str1 "$severity:"
	set str2 "\[$key\] $command: $args ($filename)"
#        #if {$Debug} {puts $::FFF::DEBUG_OSTREAM [format "%-*s %-*s" 8 $str1 50 $str2]}
#        #if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$severity: \[$key\] $command: $args ($filename)"}
        #puts $print_output_file_channel "$severity: \[$key\] $command: $args ($filename)";
        puts $print_output_file_channel "[format "%-*s %-*s" 8 $str1 50 $str2]";
    }


  #####################################################
  # proc lint_message
  # This is the main (top level) proc that is called to generate a message
  # to the user.
  # This proc invokes:
  # create_lint_message
  ####################################################

  proc lint_message {severity key args} {
      variable message_severity_table;
      variable current_command;
      variable current_filename;
      variable current_lineno;
      variable message_callback_func;
      variable fail;
      variable num_lint_errs;
      variable num_lint_warns;
      set type "";
  
      if { [info exists message_severity_table($key)] } {
          set severity $message_severity_table($key);
      }
      #
      # Increment global counters to keep track of overall message stats
      #
      switch -exact -- $severity {
          "error"   {
              set type "Error";
              set fail true;
              incr num_lint_errs;
          }
          "warn"    {
              set type "Warning";
              incr num_lint_warns;
          }
          "note"    {
              set type "Note";
          }
          "ignore"  { return; }
          default   {
             puts "Internal Error: Wrong usage on proc 'lint_message' with severity=$severity, key=$key, args=$args";
             return;
          }
      }
  
      #
      # Create the lint message
      #
      set msg [create_lint_message $key $args];
      if { $message_callback_func ne "" } {
          set lineno 0;
          #if { $current_filename ne "" } { set lineno $current_lineno($current_filename); }
	  # Don't support line numbers yet. Will do soon!
          #eval $message_callback_func $current_command $key $type $current_filename $lineno $msg;
          eval $message_callback_func $current_command $key $type $current_filename $msg;
      } else {
	  #set str1 "$type:"
	  #set str2 "\[$key\] $current_command: $msg"
#          #if {$Debug} {puts $::FFF::DEBUG_OSTREAM [format "%-*s %-*s" 10 $str1 50 $str2]}
          puts "$type: \[$key\] $current_command: $msg";
      }
  }


  #
  # Proc that actually looks up the message in the lint_message_arr
  # with the key
  #
  proc create_lint_message {key argList} {
      upvar 1 $argList args;
      variable cur_fcf;
      variable msgArgs;
      variable lint_message_arr;
      variable current_filename;
      variable current_lineno;
      variable current_command;
      variable message_callback_func;
  
      if { $current_command eq "" } { set current_command "-"; }
      # Clear out the prefix "FCF" (or anything in the future)
      # We are simply keeping this generic in case the acronym changes...
      regsub -all {FCF-} $key "" new_key;
 
      for {set i 0} {$i < [llength $args]} {incr i} {
          #set msgArgs($i) [strip_leading_hierarchy_separator "" [lindex $args $i] 0];
          set msgArgs($i) [lindex $args $i];
      }
      variable msg;
      #
      # Create the message (look up the message text from lint_message_arr (key is MESSAGE code)
      #
      eval set msg \"$lint_message_arr($new_key)\"
  
      #
      # Add filename to message
      #
      if { $message_callback_func eq "" && $current_filename ne ""} {
          #set msg "$msg ($current_filename:$current_lineno($current_filename))";
          set msg "$msg $current_filename";
      }
      if { [string first \[ $msg] != -1 } { return "{$msg}" }

      # return message text to caller
      return $msg;
  }





  
  
  #
  # (Re)sets the severity level for a given message id (code)
  # 
  proc set_message_severity {msg_id severity} {
      variable message_severity_table;
      set message_severity_table($msg_id) $severity;
  }

  #
  # Usage of set_message_severity
  #

  proc strip_leading_hierarchy_separator {optionName arg {check_keep 1}} {
      variable hierarchy_separator;
      variable current_scope_level;
      variable current_command;
      variable keep_leading_hierarchy_separator;
  
      if { [string match *file* $optionName] } { return $arg; }
      if { [string match *libraries* $optionName] } { return $arg; }
      if { [string match define_library_set $current_command] } { return $arg; }
      if { $current_scope_level < -1 } { return $arg; }
      if { $check_keep && $keep_leading_hierarchy_separator } { return $arg; }
  
      if { [regexp -all {\{} $arg] != [regexp -all {\}} $arg] } {
          lint_message warn FCF-LINT-246 $optionName;
      }
      set hs $hierarchy_separator($current_scope_level);
      if { [string equal $arg [lindex $arg 0]] } {
          set argitem [lindex $arg 0];
          set split_char [::FFF::need_to_split_option_value_pair $optionName];
          if { $split_char ne "" } {
              set pair [split $argitem $split_char];
              set first  [::FFF::strip_leading_hier_seps [lindex $pair 0]];
              set second [::FFF::strip_leading_hier_seps [lindex $pair 1]];
              return "$first$split_char$second"
          }
          if { $argitem ne "" && $argitem != $hs && ![string is double $argitem] } {
              return [::FFF::strip_leading_hier_seps $argitem]
          }
  
          return $argitem;
      } else {
          set newarg "";
          if { [::FFF::need_braces_for_esc $arg] && [llength $arg] <= 1 } {
              set arg \{$arg\}
          }
  
          foreach argitem $arg {
              set newitem [::FFF::strip_leading_hier_seps $argitem];
              if { [is_list $newitem] && ![::FFF::need_braces_for_esc $newitem] } {
                  lappend newarg $newitem;
              } elseif { [is_list $newarg] } {
                  set newarg [string trimright $newarg];
                  append newarg " $newitem " ;
              } else {
                  append newarg "$newitem ";
              }
          }
          regsub -all {^ {1,}| {1,}$} $newarg "" newarg;
          regsub -all {\( } $newarg "(" newarg;
          regsub -all { \)} $newarg ")" newarg;
          return $newarg;
      }
  }

##############################################################################
#  File utilities
##############################################################################

proc get_file_key {filename source_level} {
    if {$source_level ne ""} {
        return "$filename.$source_level"
    } else {
        return $filename
    }
}

proc get_opened_file_channel {filename {source_level ""}} {
    variable open_file_channels;
    set key [get_file_key $filename $source_level]

    foreach {filename_key channel_fp} [array get open_file_channels] {
        if { $filename_key == $key } {
            return $channel_fp;
        }
    }
    ::FFF::fcfqc::myassert 0 "Filename $filename is not opened";
}

proc get_file_channel {filename {source_level ""} } {
    variable open_file_channels;
    set key [get_file_key $filename $source_level]

    foreach {filename_key channel_fp} [array get open_file_channels] {
        if { $filename_key == $key } {
            return $channel_fp;
        }
    }
    set fp [::open $filename];
    set open_file_channels($key) $fp;
    return $fp;
}


 proc special_source_file { args } {
        variable seek_to_file_NAME;
        variable seek_to_file_POS;
        variable seek_to_lineno;
        variable saved_file_pointer_stack_SIZE;

        if {$seek_to_file_NAME eq ""} {
            return;
        }
        variable file_name $seek_to_file_NAME;
        variable line_number $seek_to_lineno
        set seek_to_file_NAME ""
        set seek_to_lineno ""
        set saved_lineno $::FFF::fcfqc::current_lineno($::FFF::fcfqc::current_filename)
        set saved_base_lineno $::FFF::fcfqc::base_lineno($::FFF::fcfqc::current_filename)
        sourcefile $file_name false $seek_to_file_POS $line_number
        set ::FFF::fcfqc::current_lineno($::FFF::fcfqc::current_filename) $saved_lineno;
        set ::FFF::fcfqc::base_lineno($::FFF::fcfqc::current_filename) $saved_base_lineno;
    }

    proc get_relative_line_number { level } {

        variable info_frame;
        if {[catch {set info_frame [info frame $level] } ] } {
            return 0;
        }
        foreach {name value} $info_frame {
            if {$name eq "line"} {
                if {$value <= 1} {
                    return 0;
                }
                return [expr {$value - 1}];
            }
        }
        return 0;
    }


    proc check_file_exists {filenames} {
        foreach group $filenames {
            foreach filename $group {
                if { ![file isfile $filename] } {
                    ::FFF::fcfqc::lint_message error FCF-LINT-160 $filename;
                     return false;
                }
            }
        }
        return true;
    }

    proc source {args} {
        if {$::FFF::fcfqc::fcf_verbose} { puts "Begin parsing file $args ..."; }
        foreach filename $args {
            if {$::FFF::fcfqc::fcf_suppress_src_msg} {
                sourcefile $filename false;
            } else {
                sourcefile $filename;
            }
        }
        if {$::FFF::fcfqc::fcf_verbose} { puts "Finished parsing file $args."; }
    }

    proc include {args} {
        variable current_source_level;
        variable filename_stack;

        foreach filename $args {
            set filedir [file dirname $filename_stack($current_source_level)];
            set include_filename [file join $filedir $filename];
            if {$::FFF::fcfqc::fcf_suppress_src_msg} {
                sourcefile $include_filename false;
            } else {
                sourcefile $include_filename;
            }
        }
    }


 proc sourcefile {filename {verbose true} {seek_to_pos 0} {seek_to_line 1} } {
        variable filename_stack;
        variable current_source_level;
        variable seek_to_file_NAME;
        variable seek_to_file_POS;
        variable seek_to_lineno;
        variable previous_command_file_pos;
        variable block_fcf_FILE_LINENO_TABLE;
        variable fcf_file_info;
        variable cmds_executed;
        variable stop_sourcing_file;
        global env;
        set stop_sourcing_file false;
        array unset cmds_executed
        set ::FFF::fcfqc::current_command source;
        if { ![check_file_exists $filename] } { return ; }
        incr current_source_level;
        set filename_stack($current_source_level) $filename;
        set ::FFF::fcfqc::current_filename $filename;
        if { $seek_to_line ne "" } {
            set ::FFF::fcfqc::current_lineno($::FFF::fcfqc::current_filename) $seek_to_line;
        } else {
            set ::FFF::fcfqc::current_lineno($::FFF::fcfqc::current_filename) 1;
        }
        if {[info exists fp]} {set save_fp $fp};
        set local_current_source_level $current_source_level
        set fp [get_file_channel $::FFF::fcfqc::current_filename $local_current_source_level];
        seek $fp $seek_to_pos;
        if { $current_source_level > 1 && $fcf_file_info && \
             [info exists filename_stack([expr {$current_source_level-1}])] } {
            if {$verbose} {
                puts "// Sourcing file $::FFF::fcfqc::current_filename (in $filename_stack([expr {$current_source_level-1} ])) ...";
            }
        }
	while {![eof $fp]} {
            set previous_command_file_pos [tell $fp];
            set command [gets $fp];
            #check_trailing_space $command;
            #set comment_line_extended [check_comment_line_extension $command false];
            set local_lc 1;
            set local_lineno $::FFF::fcfqc::current_lineno($::FFF::fcfqc::current_filename)
            set ::FFF::fcfqc::base_lineno($::FFF::fcfqc::current_filename) $local_lineno;
            set line $command
            while {[string index $line end]=="\\" || ![info complete $command]} {
                if {[eof $fp]} { break; }
                set line [gets $fp];
                if {$line eq "" && [info complete $command]} {
                    incr local_lc;
                    append command "\n";
                    break;
                }
                append command "\n";
                append command $line;
                #check_trailing_space $line;
                #set comment_line_extended [check_comment_line_extension $line $comment_line_extended];
                incr local_lc;
            }
            if {[catch { namespace eval ::cpf $command } err ]} {
                if { [regexp "invalid command name \"(.*)\"" $err -> unknown_cmd_name] } {
                    unknown $unknown_cmd_name;
                } else {
                    return -code error
                }
            }
            if {$stop_sourcing_file} {
                set stop_sourcing_file false;
                break;
            }
            set ::FFF::fcfqc::current_lineno($::FFF::fcfqc::current_filename) [expr {$local_lineno + $local_lc}];
            if {$seek_to_file_NAME ne ""} {
                set fp [get_file_channel $seek_to_file_NAME $current_source_level];
                seek $fp $seek_to_file_POS;
                set ::FFF::fcfqc::current_filename $seek_to_file_NAME;
                if { $seek_to_lineno ne "" } {
                    set ::FFF::fcfqc::current_lineno($::FFF::fcfqc::current_filename) $seek_to_lineno;
                    set seek_to_lineno "";
                }
                set seek_to_file_NAME "";
            }
        }
        catch {close $fp};
        set key [::FFF::fcfqc::get_file_key $::FFF::fcfqc::current_filename $local_current_source_level]
        if { [info exists ::FFF::fcfqc::open_file_channels($key) ] } {
            unset ::FFF::fcfqc::open_file_channels($key);
        }
        if {[info exists save_fp]} {set fp $save_fp};
        incr current_source_level -1;
        if { [info exists filename_stack($current_source_level)] } {
            set ::FFF::fcfqc::current_filename $filename_stack($current_source_level);
        } else {
            set ::FFF::fcfqc::current_filename "";
        }
        array unset cmds_executed
    }

  # Initialization:
  register_message_callback msg_handler
};# end namespace eval FFF::fcfqc
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [load_plugin.tcl]                                         #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################

namespace eval FFF {
  ###############################################################
  # load_plugin
  # Usage: load_plugin <name> 
  #  [-before <id> | -after <id> | -begin | -end]
  #  [-parameter_map {<param_name> <param_value>}] ... 
  #  [-require_all_vars [error|warn|note]] 
  #  [-required_files {{<file list>} <severity>}]
  #  [-required_vars {{<var list>} <severity>}]
  #  [{plugin block commands}]
  ###############################################################
  proc load_plugin {args} {
    if {[catch {
    set dbgPrefixWs [string repeat " " [info level]]
    set msgPrefix "${dbgPrefixWs}load_plugin:"
    set Debug $::FFF::Debug
    # Always called within a create_stage block
    # so we can upvar 1 and get the calling stageName
    set commandName load_plugin
    set myStepBaseName ""
    set myPluginName ""
    set myInstanceName ""
    set myBeforeStepObjID ""
    set myAfterStepObjID ""
    set myInsertAtBeginningFlag 0
    set myInsertAtEndFlag 0
    set myNoStepHeaderFlag 0
    set myStepHeaderFlag 0
    set myConfigurationList {}
    set myFullInsertStepLocationList {} 
    set dash_args_list {}
    set parse_options_args_list {}
    set param_args_list {}
    set paramConfigObjID ""
    set load_plugin_args {}
    set load_plugin_location_args ""
    set myRequireAllVarsFlag 0
    set myRequireAllVarsSeverity ""
    set required_args_list {}
    set myNoInlineOption 0

    upvar 1 stageName stageName_local
    upvar 1 stageObjID stageObjID_local

    set origStepArgs $args 
    # #####################################################################
    # The following block processes dash args and extracts the plugin name (step Name)
    # #####################################################################
    #
    # Pull out name first (default is anonymous)
    # Separate block from dash args
    # Create $load_plugin_args (the block) and $dash_args_list (to be passed to parse_options)
    set token [lindex $origStepArgs 0]
    while {$token ne ""} {
      if { [string match -* $token] } {
        if { $token eq "-parameter" || $token eq "-param" || $token eq "-parameter_map"} {
          lappend param_args_list $token
          lappend param_args_list [lrange $origStepArgs 1 1]
	  set origStepArgs [lrange $origStepArgs 2 end]
        } elseif { $token eq "-required_files" || $token eq "-required_vars" || $token eq "-require_all_vars" } {
          lappend required_args_list $token
          if {$token eq "-require_all_vars"} {
            if {[regexp {error|warn|note} [lrange $origStepArgs 1 1]]} {
              # The user specified the severity. Use it.
              lappend required_args_list [lrange $origStepArgs 1 1]
              set origStepArgs [lrange $origStepArgs 2 end]
            } else {
              # If the user didn't specify the severity as the second argument, use the default:
              lappend required_args_list $::FFF::myDefaultRequiredFilesSeverityLevel
              set origStepArgs [lrange $origStepArgs 1 end]
            }
          } else {
            lappend required_args_list [lrange $origStepArgs 1 1]
            set origStepArgs [lrange $origStepArgs 2 end]
          }
	} elseif { $token eq "-end" || $token eq "-begin" || $token eq "-readme" || $token eq "-help" || $token eq "-no_step_header" } {
          lappend parse_options_args_list $token
	  set origStepArgs [lrange $origStepArgs 1 end]
        } elseif { $token eq "-config" } {
          set myConfigurationList [flatten_list [lrange $origStepArgs 1 1]]
	  set origStepArgs [lrange $origStepArgs 2 end]
          # "-config sos Configuration name(s) to bind to the step" myConfigurationList
        } elseif { $token eq "-before" } {
          set myBeforeStepObjID [flatten_list [lrange $origStepArgs 1 1]]
	  set origStepArgs [lrange $origStepArgs 2 end]
        } elseif { $token eq "-after" } {
          set myAfterStepObjID [flatten_list [lrange $origStepArgs 1 1]]
	  set origStepArgs [lrange $origStepArgs 2 end]
        } elseif { $token eq "-instance" } {
          set myInstanceName [flatten_list [lrange $origStepArgs 1 1]]
	  set origStepArgs [lrange $origStepArgs 2 end]
	} else {
	  # unrecognized option, and not a block statement
	  set origStepArgs [lrange $origStepArgs 1 end]
        }
      } elseif { [regexp {\s} $token] } {
	# else this is not a dash argument, but it's a list of more than 1 element, assume this the plugin
          lappend load_plugin_args $token
	  set origStepArgs [lrange $origStepArgs 1 end]
      } else {
	# else this is not a dash argument, and it's a single item, therefore we assume this is the plugin name
        set myPluginName $token
	set origStepArgs [lrange $origStepArgs 1 end]
      }
      set token [lindex $origStepArgs 0]
    }

    set myStepBaseName $myPluginName
    set msgPrefix "${dbgPrefixWs}load_plugin($myPluginName):"

    array set paramArray {}
    set index 0
    set token [lindex $param_args_list $index]
    while {$token ne ""} {
       set paramMap [lindex $param_args_list [incr index]]
       switch -exact -- $token {
         -parameter_map {
	   set paramName [lindex [flatten_list $paramMap] 0]
	   set paramValue [list [lrange [flatten_list $paramMap] 1 end]]
             if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} Found Parameter Map: paramName: \
		->$paramName<- in step shall be mapped to value: ->$paramValue<-"}
	   set paramArray($paramName) $paramValue
         }
       };# end switch
      incr index
      set token [lindex $param_args_list $index]
    };# end while

    ####################################################################################
    # Process required_args_list
    ####################################################################################
    #
    # Two arrays to attract severity for each file or variable
    #
    array set requiredFilesArr {}
    array set requiredVarsArr {}
    set index 0
    set token [lindex $required_args_list $index]
    while {$token ne ""} {
      set requiredFilesOrVarsMap [lindex $required_args_list [incr index]]
      #
      # Remove outer curlies and spaces
      #
      while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $requiredFilesOrVarsMap full requiredFilesOrVarsMap]} {}
      switch -exact -- $token {
        -required_files {
           if {[llength $requiredFilesOrVarsMap] == 2} {
             set requiredFilesList [lindex $requiredFilesOrVarsMap 0]
             set severity [list [lrange $requiredFilesOrVarsMap 1 end]]
           } elseif {[llength $requiredFilesOrVarsMap] == 1} {
             set requiredFilesList [flatten_list $requiredFilesOrVarsMap]
             set severity $::FFF::myDefaultRequiredFilesSeverityLevel
           } else {
             puts "insert_step() ERROR: Illegal number of arguments passed to -required_files option."
             puts "   insert_step ... $token $requiredFilesOrVarsMap"
             puts "Usage: insert_step ... -required_files {<file list> <severity>}"
             exit 1
           }
           #
           # Remove outer curlies from file list
           #
           while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $requiredFilesList full requiredFilesList]} {}
           foreach fileOrVar $requiredFilesList {
             set requiredFilesArr($fileOrVar) $severity
             #
             # We only add the variable in to the missing severity array if it matches the vars() regexp
             #
             if {[regexp {^\$vars\((.*)\)} $fileOrVar full key]} {
               set requiredVarsArr(vars($key)) $severity
             }
           }
        }
        -required_vars {
           if {[llength $requiredFilesOrVarsMap] == 2} {
             set requiredVarsList [lindex $requiredFilesOrVarsMap 0]
             set severity [list [lrange $requiredFilesOrVarsMap 1 end]]
           } elseif {[llength $requiredFilesOrVarsMap] == 1} {
             set requiredVarsList [flatten_list $requiredFilesOrVarsMap]
             set severity $::FFF::myDefaultRequiredVarsSeverityLevel
           } else {
             puts "insert_step() ERROR: Illegal number of arguments passed to -required_vars option."
             puts "   insert_step ... $token $requiredFilesOrVarsMap"
             puts "Usage: insert_step ... -required_vars {<var list> <severity>}"
             exit 1
           }
           #
           # Remove outer curlies from file list
           #
           while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $requiredVarsList full requiredVarsList]} {}
           foreach fileOrVar $requiredVarsList {
             if {[regexp {^\$vars\((.*)\)} $fileOrVar full key]} {
               set requiredVarsArr(vars($key)) $severity
             }
           }
        }
        -require_all_vars {
           set myRequireAllVarsFlag 1
	   set myRequireAllVarsSeverity $requiredFilesOrVarsMap
        }
      };# end switch
      incr index
      set token [lindex $required_args_list $index]
    };# end while

    set parse_options_args_list [flatten_list $parse_options_args_list]
    dbg_puts "Parse options being passed: ->$parse_options_args_list<-"
    switch -- [parse_options load_plugin {} $parse_options_args_list \
       "-noinline bos Don't in-line the plugin in the generated script" myNoInlineOption \
       "-instance sos Instance name (for hierarchical path referencing)" myInstanceName \
       "-before sos Insert before this step" myBeforeStepObjID \
       "-after sos Insert after this step" myAfterStepObjID \
       "-begin bos Insert step at beginning of stage" myInsertAtBeginningFlag \
       "-end bos Insert step at end of stage" myInsertAtEndFlag \
       "-readme bos Print Readme Information on the Foundation Flow" myReadmeFlag \
       "-no_step_header bos Do not print a header comment before the step is printed" myNoStepHeaderFlag \
       ] {
       -2 { return }
       0 { error "Failed on [lindex [info level 0] 0]" }
    }
    dbg_puts "myNoInlineOption: $myNoInlineOption"
    ##############################################################
    set myConfigurationObjIDList {}
    # Support for Default Configurations (EDI Style)
    if {$myConfigurationList eq ""} {
      if {$::FFF::verboseMessaging} {
        puts "$commandName NOTE: No configuration specified for plugin \"$myPluginName\". Binding to default configuration."
      }
      set  myConfigurationObjIDList $::FFF::myDefaultConfigObjID
      set myConfigurationList [ $::FFF::myDefaultConfigObjID->get_name]
    } else {
      foreach configName $myConfigurationList {
	lappend myConfigurationObjIDList [get_config $configName]
      }
    }
    set myConfigurationObjIDList [flatten_list $myConfigurationObjIDList]

    ##############################################################	
    if {$myBeforeStepObjID ne ""} {
      lappend myFullInsertStepLocationList $myBeforeStepObjID
    }
    if {$myAfterStepObjID ne ""} {
      lappend myFullInsertStepLocationList $myAfterStepObjID
    }
      
    if {$myFullInsertStepLocationList ne ""} {
      set location_opt_count [llength [list $myFullInsertStepLocationList]]
    } else {
      set location_opt_count 0
    }
    if {$myInsertAtBeginningFlag} {
      incr location_opt_count
    }
    if {$myInsertAtEndFlag} {
      incr location_opt_count $myInsertAtEndFlag
    }
    if {$myNoStepHeaderFlag} {
      set myStepHeaderFlag 0
    } else {
      set myStepHeaderFlag 1
    }
    
    if {$location_opt_count > 1 } {
      puts "load_plugin($myPluginName) ERROR: More than one location given to load_plugin: ->$args<-"
      return -2
    } else {
      # create args list to pass to object creation
      if { $myBeforeStepObjID ne "" } {
        set load_plugin_location_args "-before $myBeforeStepObjID"
      }
      if { $myAfterStepObjID ne "" } {
        set load_plugin_location_args "-after $myAfterStepObjID"
      }
      if { $myInsertAtBeginningFlag ne ""} {
	if { $myInsertAtBeginningFlag } {
          set load_plugin_location_args "-begin"
	}
      }
      if { $myInsertAtEndFlag ne ""} {
	if { $myInsertAtEndFlag } {
          set load_plugin_location_args "-end"
	}
      }
      # Check and see if we set it to anything. If not, error
      if {$load_plugin_location_args eq ""} {
        if {$::FFF::verboseMessaging} {
	  puts "load_plugin NOTE: Inserting step $myPluginName at end of stage (Default location)"
	}
        set load_plugin_location_args "-end"
      }
    } 

    ##############################################################	
    # Uniquify Step Name
    ##############################################################	
    # Overload the step name by advancing it one number
    # Create new "uniquified" step name.
    # Example: original: 'syn' -> uniquified: 'syn_u1'

    # Note - this is required when steps are defined using load_plugin in a stage
    # In this scenario, we cannot expect the user to always uniquify each step (nor should they have to)
    # This is obvious for the case of multiway instantiation (load_plugin genReports -after [get_step -regexp .*synth.*])

    ##############################################################	
    # Uniquify the plugin step name
    ##############################################################	
    if {![array exists ::FFF::unique_step_name_arr]} {
      array set ::FFF::unique_step_name_arr {}
      set ::FFF::unique_step_name_arr($myStepBaseName) 1
    } else {
      if {[info exists ::FFF::unique_step_name_arr($myStepBaseName)]} {
        set ::FFF::unique_step_name_arr($myStepBaseName) [expr {$::FFF::unique_step_name_arr($myStepBaseName) + 1}]
      } else {
        set ::FFF::unique_step_name_arr($myStepBaseName) 1
      }
    }

    set myStepName ${myStepBaseName}_i[set ::FFF::unique_step_name_arr($myStepBaseName)]
    dbg_puts "myStepName: $myStepName"
    ##############################################################	
    # Check parameter mapping passed to step
    ##############################################################	
    if { [array names paramArray] ne "" } {
      # Here's the magic for parameters. Basically we create a new config for the step only
      # We then populate the config variables, and bind this config to the step.
      # The step variables are then processed like any other configuration.
      # Note - this configuration goes at the beginning, so as to overwrite any other duplicate variables
      set paramConfigObjID [new Configuration ${myStepName}.param $args]
      foreach paramName [array names paramArray] {
        $paramConfigObjID->update_vars "set $paramName $paramArray($paramName)"
      }
      lappend myConfigurationObjIDList $paramConfigObjID
    }

    # Get rid of the first curly, and all whitespace after the last non-whitespace character, and the last curly
    while {[regexp {^\{(.*)[[:space:]]*\}$} $load_plugin_args full load_plugin_args ]} {}
    # At this point all the relevant arguments have been extracted, and we can
    # continue with block processing

    while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $load_plugin_args full args ]} {};
    # Iteratively strip curly braces on the outside of the block.
    # This is needed in order to pass the entire block to eval below

    # Initialize command array (block of commands) for the step Object
    array set local_arr {}

    #################################################################################
    # Insert the step with the plugin block as sourcing the plugin
    #################################################################################
    set stepObjID [new PluginInst $myStepName ]

    $stepObjID->set_param_configurations $paramConfigObjID
    $stepObjID->set_instance_name $myInstanceName
    $stepObjID->set_base_name $myStepBaseName
    if {$myNoInlineOption} {
      dbg_puts "executing $stepObjID->set_inline_status"
      $stepObjID->set_inline_status 0
    }

    # Here's the magical algorithm:
    # First see if the argument provided is a file that exists
    #  If not, assume it's a $vars key that, when resolved points to a file
    #    change the command to load_plugin
    #    This will trigger resolve_plugin to look for a variable
    #    If resolve_plugin fails to find the var, then we assume that the user really intended the argument to be a file.
    #    and we should report that the file didn't exist
    array set load_plugin_arr {}
    set load_plugin_arr(1) "# Plugin: $myPluginName"
    $stepObjID->set_cmd_block [array get load_plugin_arr]
    array unset load_plugin_arr

    $stepObjID->set_print_step_header_flag $myStepHeaderFlag
    foreach configObjID $myConfigurationObjIDList {
      $stepObjID->bind_to_config $configObjID
    }

    #
    # Add required vars / files to Step (if any already exist)
    #
    $stepObjID->update_required_vars_arr [array get requiredVarsArr]
    $stepObjID->update_required_files_arr [array get requiredFilesArr]
    #
    # Resolve parameters for the step
    # No parameters for plugins (yet)
    #$stepObjID->resolve_parameters_in_command_block
 
    #
    # Optionally set all vars required flag
    #
    if {$myRequireAllVarsFlag} {
      $stepObjID->set_all_vars_required
      $stepObjID->set_all_vars_required_severity $myRequireAllVarsSeverity
    }

    #
    # Set the insert file name
    #
    $stepObjID->set_insert_file ::FFF::fcfqc::current_filename

    #set ::FFF::step_objid_arr($stepObjID) $myStepName
    #set ::FFF::stepInst_objid_arr($stepObjID) $myStepName
    set ::FFF::pluginInst_objid_arr($stepObjID) $myStepName
    dbg_puts "${msgPrefix} Added $stepObjID to ::FFF::stepInst_objid_arr (array)"
    # Now, insert the step into the correct stage
    #set stageObjID [get_stage $stageName_local]
    dbg_puts "${msgPrefix} Inserting in stage: ->$stageObjID_local<- ([$stageObjID_local->get_name])"
    dbg_puts "${msgPrefix} ->$dash_args_list<- final location args: ->$load_plugin_location_args<-"
    $stageObjID_local->insert_step $stepObjID $load_plugin_location_args
    array set reqVarSeverityArr [$stepObjID->get_required_vars_severity_arr]
  } errorMsg]} {
    dbg_puts -print_stdout "<FF> INTERNAL-ERROR: load_plugin(). Stack Trace:\n$errorMsg"
    dbg_puts -print_stdout "<FF>                 Contact the Cadence Product Core Team for assistance."
  }
  }; # end proc load_plugin()
}; # end namespace eval
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [fcfTclLint.tcl]                                         #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @ #
#  Date        [01-11-2011]                                                  #
##############################################################################

# Define the proc in it's own variable namespace (consistent with RC applets)
namespace eval FFF {
  set dbgPrefixWs [string repeat " " [info level]]

  # FCF Linting
  
  namespace export ff_tcl_lint
  proc ff_tcl_lint {args} {
    set dbgPrefixWs [string repeat " " [info level]]
 
    switch -- [parse_options [calling_proc] {} $args \
      "-file srs file to lintcheck" file ] {
      -2 { return }
      0 { return }
    }
    ::FFF::dbg_puts "${dbgPrefixWs}Starting lint check on file: $file"
  
    # Define ns
    namespace eval ::FF_LINT {
      variable file
      variable tclLintErrorFile
      array set tclLintErrorFile {}

      variable errorCount 0
      variable vars
      array set vars {};
    }

    # Initialize error count for file
    if {![info exists ::FF_LINT::tclLintErrorFile($file)]} {
      set ::FF_LINT::tclLintErrorFile($file) 0
    }
 
    ::set ::FF_LINT::file $file
    ::lappend ::FF_LINT::vars(config_files) $file
  
    # Define stubs
    namespace eval ::FF_LINT {

      proc process_error {args} {
        switch -- [parse_options [calling_proc] {} $args \
          "-file srs file being checked" file \
          "-command sos command executed" command \
          "-errormsg sos errors message reported" errorMsg ] {
          -2 { return }
          0 { return }
        }
	# Increment the error count for the file
        incr ::FF_LINT::tclLintErrorFile($file)
	# Increment master error count
        incr ::FF_LINT::errorCount
	# append the error messages to the error log for the file
        ::lappend ::FF_LINT::tclLintErrorLog($file) $errorMsg
	# Print a message
        ::FFF::dbg_puts -print_stdout "<FF> TCL LINT ERROR File: $file, Command: $command:, Message:\n$errorMsg"
      }
  
      proc create_flow {args} {
        ::set dbgPrefixWs [string repeat " " [info level]]
        ::set msgPrefix "${dbgPrefixWs}[::FFF::getProcName](LINT):"
        ::set Debug $::FFF::Debug
        regsub {^\{} [lrange $args [expr {[llength $args] - 1}] [expr {[llength $args] - 1}]] "" blockpart
        regsub {\}$} $blockpart "" block
	::FFF::dbg_puts "create_flow block: ->$block<-"
        if {[catch {uplevel 1 eval $block} errorMsg]} {
	  process_error -file $::FF_LINT::file -command create_flow -errormsg $errorMsg
        } else {
	  ::FFF::dbg_puts "created [lrange $args 0 0]"
        }
      }
      proc create_stage {args} {
        ::set dbgPrefixWs [string repeat " " [info level]]
        ::set msgPrefix "${dbgPrefixWs}[::FFF::getProcName](LINT):"
        ::set Debug $::FFF::Debug
	::set stageToCreate [lindex $args 0]
	if {[lrange $args 1 1] ne ""} {
	  ::set stageBlock [lrange $args 1 1]

	  # Create proc from stage insertion block if it exists
	  proc $stageToCreate {} {
	    upvar stageBlock localStageBlock
            if {[catch {uplevel 1 eval [::FFF::remove_outer_braces $localStageBlock]} errorMsg]} {
	      process_error -file $::FF_LINT::file -command [calling_proc] -errormsg $errorMsg
            } else {
	      ::FFF::dbg_puts "executed block $stageToCreate"
            }
	  }
	  # execute stage insertion block
	  if {[catch {eval $stageToCreate} errorMsg]} {
	    process_error -file $::FF_LINT::file -command create_stage -errormsg $errorMsg
	  }
        } else {
          ::FFF::dbg_puts -print_stdout "<FF> TCL LINT ERROR ($::FF_LINT::file) evaluating create_stage $stageToCreate: No stage block provided."
	}
      }
      proc create_step {args} {
        ::set dbgPrefixWs [string repeat " " [info level]]
        ::set msgPrefix "${dbgPrefixWs}[::FFF::getProcName](LINT):"
        ::set Debug $::FFF::Debug
	::FFF::dbg_puts "created [lrange $args 0 0]"
      }
      proc insert_step {args} {
        ::set dbgPrefixWs [string repeat " " [info level]]
        ::set msgPrefix "${dbgPrefixWs}[::FFF::getProcName](LINT):"
        ::set Debug $::FFF::Debug
        regsub {^\{} [lrange $args [expr {[llength $args] - 1}] [expr {[llength $args] - 1}]] "" blockpart
        regsub {\}$} $blockpart "" block
	::FFF::dbg_puts "inserted $block"
      }
      proc load_plugin {args} {
        ::set dbgPrefixWs [string repeat " " [info level]]
        ::set msgPrefix "${dbgPrefixWs}[::FFF::getProcName](LINT):"
        ::set Debug $::FFF::Debug
        regsub {^\{} [lrange $args [expr {[llength $args] - 1}] [expr {[llength $args] - 1}]] "" blockpart
        regsub {\}$} $blockpart "" block
	::FFF::dbg_puts "inserted $block"
      }
      proc insert_stage {args} {
        ::set dbgPrefixWs [string repeat " " [info level]]
        ::set msgPrefix "${dbgPrefixWs}[::FFF::getProcName](LINT):"
        ::set Debug $::FFF::Debug

	# Extract out stage name and (possible) stage block (ignore dash args)
	set stageBlock ""
    	::set token [lindex $args 0]
    	while {$token ne ""} {
          if { [string match -* $token] } {
	    # ignore dash args
	  } elseif { [regexp {\s} $token] } {
            # else this is not a dash argument, but it's a list of more than 1 element
            lappend stageBlock $token
          } else {
            # else this is not a dash argument, and it's a single item, therefore we assume this is the Stage name
            ::set stageToCreate $token
	    # set new args block
            ::set args [lrange $args 1 end]
          }
          ::set token [lindex $args 0]
	}

	if {$stageBlock ne ""} {
	  # Create proc from stage insertion block if it exists
	  proc $stageToCreate {} {
	    upvar stageBlock localStageBlock
            if {[catch {uplevel 1 eval [::FFF::remove_outer_braces $localStageBlock]} errorMsg]} {
	      process_error -file $::FF_LINT::file -command [calling_proc] -errormsg $errorMsg
            } else {
	      ::FFF::dbg_puts "executed block $stageToCreate"
            }
	  }
	  # execute stage insertion block
	  if {[catch {eval $stageToCreate} errorMsg]} {
	    process_error -file $::FF_LINT::file -command insert_stage -errormsg $errorMsg
	  }
	}
      }
      
      proc insert_flow {args} {
        ::set dbgPrefixWs [string repeat " " [info level]]
        ::set msgPrefix "${dbgPrefixWs}[::FFF::getProcName](LINT):"
        ::set Debug $::FFF::Debug
        regsub {^\{} [lrange $args [expr {[llength $args] - 1}] [expr {[llength $args] - 1}]] "" blockpart
        regsub {\}$} $blockpart "" block
	::FFF::dbg_puts "inserted $block"
      }
      proc set {args} {
        ::set dbgPrefixWs [string repeat " " [info level]]
        ::set msgPrefix "${dbgPrefixWs}[::FFF::getProcName](LINT):"
        ::set Debug $::FFF::Debug
        ::set varName [lindex $args 0]
        ::set varValue [lrange $args 1 end]
        if {[regexp {(.+)\((.+)\)} $varName full arrName arrKey]} {
          uplevel 1 variable $arrName
        } else {
          uplevel 1 variable $varName
        }
        ::set cmd_string "::set ::FF_LINT::$varName $varValue"
        ::FFF::dbg_puts "set $varName to $varValue"

        if {[catch {eval $cmd_string} errorMsg]} {
	  process_error -file $::FF_LINT::file -command set -errormsg $errorMsg
        } else {
	  ::FFF::dbg_puts "set $varName to $varValue"
        }
      }
      proc open {args} {
        ::set dbgPrefixWs [string repeat " " [info level]]
        ::set msgPrefix "${dbgPrefixWs}[::FFF::getProcName](LINT):"
	::FFF::dbg_puts "opened $args"
      }
      proc close {args} {
        ::set dbgPrefixWs [string repeat " " [info level]]
        ::set msgPrefix "${dbgPrefixWs}[::FFF::getProcName](LINT):"
	::FFF::dbg_puts "closed $args"
      }
      proc lappend {args} {
        ::set dbgPrefixWs [string repeat " " [info level]]
        ::set msgPrefix "${dbgPrefixWs}[::FFF::getProcName](LINT):"
        ::set Debug $::FFF::Debug
        ::set listName [lindex $args 0]
        ::set listValue [lrange $args 1 end]
        if {[regexp {(.+)\((.+)\)} $listName full arrName arrKey]} {
          uplevel 1 variable $arrName
        } else {
          uplevel 1 variable $listName
        }
        ::set local_cmd_string "::lappend $listName $listValue"

        if {[catch {eval $local_cmd_string} errorMsg]} {
	  process_error -file $::FF_LINT::file -command lappend -errormsg $errorMsg
        } else {
	  ::FFF::dbg_puts "lappend $listName to $listValue"
        }
      }
      proc puts {args} {
      }
      proc Puts {args} {
      }
      proc set_script_name {args} {
      }
    }
    # Lint file
    namespace eval ::FF_LINT {
      if {[::FFF::get_tool] eq "rc"} {
        if {[catch {tcl_source $file} errorMsg]} {
	  incr ::FF_LINT::tclLintErrorFile($file)
	  ::lappend ::FF_LINT::tclLintErrorLog($file) $errorMsg
	}
      } else {
        if {[catch {source $file} errorMsg]} {
	  incr ::FF_LINT::tclLintErrorFile($file)
	  ::lappend ::FF_LINT::tclLintErrorLog($file) $errorMsg
	}
      }
    }
  
    # Completion
    ::FFF::dbg_puts "${dbgPrefixWs}Completed lint check on file: $file"
    # return error count
    return $::FF_LINT::errorCount
  }
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [read_foundation.tcl]                                         #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @ #
#  Date        [01-11-2011]                                                  #
##############################################################################

# Define the proc in it's own variable namespace (consistent with RC applets)
namespace eval FFF {
  set dbgPrefixWs [string repeat " " [info level]]
  variable rf_file_list
  # export the proc so it can be read into the elab ns ($elabns)
  namespace export read_foundation

  proc read_foundation {args} {

    #
    # Debug code initialized
    if {[info exists ::env(FFF_DEBUG)] && $::env(FFF_DEBUG) ne "" && $::env(FFF_DEBUG)} {
      if {![info exists ::FFF::DEBUG_OSTREAM]} {
        puts "<FF-INTERNAL> DEBUG MODE ENABLED"
        puts "<FF-INTERNAL> See .fff_debug for stack trace."
        #
        # Open read channel for debug file
        #
        set ::FFF::DEBUG_OSTREAM [open $::FFF::debugfile "w"]
      }
      set ::FFF::Debug "1"
    }

    set dbgPrefixWs [string repeat " " [info level]]
    set msgPrefix "${dbgPrefixWs}read_foundation:"
    set Debug $::FFF::Debug
    set ::FFF::fcfqc::current_command read_foundation
    set ::FFF::still_reading 1
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} Set ::FFF::still_reading bit to 1"}
    #if {![llength [info commands ::calling_proc]] } { namespace export calling_proc }
    #if {![llength [info commands ::dispatch_subcommand]] } { namespace export dispatch_subcommand }
    if {[::FFF::get_tool] ne "lec" } {puts "// Command: [calling_proc] $args"}
    set fcf_version $::FFF::default_fcf_version
    set overwrite 0
    set noelab 0 ; # Meaning, default is to run elaboration
    set config 0
    set rf_file_list {}
    set fileList {}
  
    set parse_options_args ""
    # Pre-Process args
    # Basically we need to pass the args list to parse_options in the following way:
    # read_foundation [optionA] [optionB] ... { file list }
    # (but read_foundation doesn't require the final set of curly braces, so this pre-processor adds them in)
    while {[llength $args] > 0} {
      set option [lindex $args 0]
      set args [lreplace $args 0 0]
      switch -regexp -- $option {
        ^-(o|overwrite)$ 	{ lappend parse_options_args $option }
        ^-(c|config)$ 		{ lappend parse_options_args $option }
        ^-(n|noelab)$ 		{ lappend parse_options_args $option }
        ^-(v|verbose)$ 	{ lappend parse_options_args $option }
        ^-(r|readme)$ 		{ lappend parse_options_args $option }
        ^-(h|help)$ 		{ lappend parse_options_args $option }
        ^-(d|debug)$ 		{ lappend parse_options_args $option }
        default 		{ lappend fileList "$option " }
      }
    }

    # NOTE: -debug is currently not used (placeholder only)

    # Remove curlies (if any)
    set fileList [::FFF::flatten_list $fileList]
    set parse_options_args [::FFF::flatten_list $parse_options_args]

    # Construct final parse_options args
    set parse_options_args "$parse_options_args {$fileList}"

    # Call parse_options
    switch -- [parse_options [calling_proc] {} $parse_options_args \
      "-overwrite bos overwrite existing foundation data" overwrite \
      "-config bos specify that the files" config \
      "-noelab bos elaboration should not be performed after reading file(s)" noelab \
      "-verbose bos enable verbose messaging" verbose \
      "-readme bos display help info" readme \
      "-debug bOs display help info" debug \
      "sos foundation configuration or flow definition file(s)" rf_file_list \
    ] {
      -2 { return }
      0  { error "Failed on [lindex [info level 0] 0]" }
    }
    if {$verbose} {
      set ::FFF::verboseMessaging 1
    }
    if {$readme} {
      puts $::fcf_header::README;
      return
    }

    # Copy $rf_file_list to FFF namespace, and remove any curlies
    set ::FFF::rf_file_list [::FFF::flatten_list $rf_file_list]

    #
    # Set FFF var
    # (Used by most flows)
    # 
    if {$config} {
      foreach file $::FFF::rf_file_list {
        lappend ::FFF::vars(config_files) $file
      }
    }

    #
    # Perform lint check. Purpose is to catch basic syntax issues such as missing curly braces.
    #
    foreach file $::FFF::rf_file_list {
      set ::FFF::fcfqc::current_filename $file
      dbg_puts "Linting $file"

      ##nagelfar syntax ff_tcl_lint
      #ff_tcl_lint -file $file
    } 
    dbg_puts "Completed Lint Check"

    # Source each file in the elab namespace
    # This is where all objects are created
    dbg_puts "Populating ${::FFF::elabns} with Flow Objects"
    namespace eval ${::FFF::elabns} {
      ::set dbgPrefixWs [string repeat " " [info level]]
      ::set Debug $::FFF::Debug
      if {[::FFF::get_tool] ne "edi"} {
        # import a wrapper for "Puts" (this only exists in EDI)
	if {![llength [info commands Puts]]} { namespace import ::FFF::Puts }
      }
      # Foreach file defined in list (based on arg processing above)

      foreach file $::FFF::rf_file_list {
	set ::FFF::fcfqc::current_filename $file
        puts "read_foundation: reading file $file"
        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} reading $file"}

        # Auto-escape all "$" except for $vars()
        # do this inside an array, then source the array
        # TEMP SOLUTION: write out a temp file, regesub, then source, then 
        # source the temp file 
	if {[::FFF::get_tool] eq "rc"} {
          tcl_source $file
	} else {
          source $file
	}
      } ; # end foreach
    } ; # end namepace eval
  

    # #############################################################
    # Source in nonelab namespace (Normally this is ::FFF::nonelabdb)
    # For this section, we only need to populate variables in ::FFF::nonelabdb
    # #############################################################

    # Switch to the nonelabns to parse set() variables for default configuration support
    namespace eval ${::FFF::nonelabns} {
      ::set dbgPrefixWs [string repeat " " [info level]]
      # rename set_configuration so we don't create configurations all over again
      rename set_configuration __set_configuration
      rename create_configuration __create_configuration
      proc set_configuration {args} {
        ::set dbgPrefixWs [string repeat " " [info level]]
      }
      proc create_configuration {args} {
        ::set dbgPrefixWs [string repeat " " [info level]]
      }
    }


    namespace eval ${::FFF::nonelabns} {
      # Stub out puts (to avoid repeat messages)
      proc puts {args} {}
      proc Puts {args} {}
    }
    dbg_puts "Populating ${::FFF::nonelabns} with Flow Objects"
    namespace eval ${::FFF::nonelabns} {
      ::set dbgPrefixWs [string repeat " " [info level]]
      ::set Debug $::FFF::Debug
      # Create a stub (we just want variables, we don't want to execute foundation commands at this point)
      foreach file $::FFF::rf_file_list {
        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs} sourcing $file"}
	set ::FFF::fcfqc::current_filename $file
        
	if {[::FFF::get_tool] eq "rc"} {
          catch {tcl_source $file}
	} else {
          catch {source $file}
	}
      }

    }

    namespace eval ${::FFF::nonelabns} {
      ::set dbgPrefixWs [string repeat " " [info level]]
      # get rid of stub
      rename set_configuration ""
      rename create_configuration ""
      # put the original back
      rename __set_configuration set_configuration
      rename __create_configuration create_configuration
    }
   
 #####    # Future code
 #####    # Copy all vars variables over to the nonelabns
 #####    namespace eval ${::FFF::nonelabns} {
 #####      ::set msgPrefix "[string repeat " " [info level]]read_foundation():"
 #####      ::set Debug $::FFF::Debug
 #####      ::set Debug 0
 #####      foreach key [array names ${::FFF::elabns}::vars] {
 #####        ::set vars($key) [set ${::FFF::elabns}::vars($key)]
 #####        ::FFF::dbg_puts "set vars($key) to $vars($key) in nonelabns"
 #####      }
 #####    }

    if {!$noelab} { 
      elaborate_foundation
    }
  } ; # End proc read_foundation()
}; # end namespace eval FFF

# In global ns, see if add_command_help exists. If not, import it...
if {![llength [info commands ::read_foundation]]} {
    namespace import ::FFF::read_foundation
    add_command_help read_foundation "read in a Foundation configuration or flow recipe file"
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [report_configurations.tcl]                                   #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################

proc report_configurations {args} {
  set Debug $::FFF::Debug
  if {[::FFF::get_tool] ne "lec" } {puts "// Command: [calling_proc] $args"}
  while {[string match -* [lindex $args 0]] } {
    set option [lindex $args 0]
    set args [lrange $args 1 end]
    #puts "Processing option: $option with args: $args"
    switch -exact -- $option {
      -readme {
        puts $::fcf_header::README;
        return;
      }
      -help {
        puts $::fcf_header::README;
        return;
      }
      -design {
        set design [lrange $args 0 0]
        set args [lrange $args 1 end]
      }
      -basename {
        set basename [lrange $args 0 0]
        set args [lrange $args 1 end]
      }
      -include {
        lappend includes [lrange $args 0 0]
        set args [lrange $args 1 end]
      }
      -exclude {
        lappend excludes [lrange $args 0 0]
        set args [lrange $args 1 end]
      }
      default {
        return -code error "unknown option \"$option\""
      }
    }
  }

  set config_list [array names ::FFF::config_objid_list]
#  if {$Debug} {puts $::FFF::DEBUG_OSTREAM "report_configurations(): config_list: ->$config_list<-"}
  set header_config_list [lsort -dictionary $config_list]
  #if {[array names [${::FFF::myDefaultConfigObjID}->get_var_tracking_namespace]::mVarArray] ne ""} {
  #  #regexp {FF_Default} [${::FFF::myDefaultConfigObjID}->get_name] configName
  #  lappend header_config_list [${::FFF::myDefaultConfigObjID}->get_name]
  #}
#  if {$Debug} {puts $::FFF::DEBUG_OSTREAM "report_configurations(): header_config_list: ->$header_config_list<-"}
  puts ""
  puts "============================================================"
  puts "  report_configurations()"
  puts ""
  puts "  Generated by:           Frontend Foundation Flow v$::FFF::fcf_version"
  puts "  Generated on:           [clock format [clock seconds] -format "%I:%M:%S %p(%b%d)"]"
  puts "  Configurations:         $header_config_list"
  puts "============================================================"

  # Default Config
  #if {[array names [${::FFF::myDefaultConfigObjID}->get_var_tracking_namespace]::mVarArray] ne ""} {
  #  ${::FFF::myDefaultConfigObjID}->print -prefix "   " -trim_ws
  #}
  
  foreach config $header_config_list {
    #puts $config
    [get_config -name $config]->print -prefix "   "
  }
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [report_flows.tcl]                                            #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################

proc report_flows {args} {
  set dbgPrefixWs [string repeat " " [info level]]
  set msgPrefix "${dbgPrefixWs}report_flows():"
  set Debug $::FFF::Debug
  if {[::FFF::get_tool] ne "lec" } {puts "// Command: [calling_proc] $args"}
  set debug_switch ""
  if {[array exists ::FFF::elabdb::flow_objid_arr]} {
    array set flow_objid_arr [array get ::FFF::elabdb::flow_objid_arr]
    set elaborated 1
  } else {
    array set flow_objid_arr [array get ::FFF::flow_objid_arr]
    set elaborated 0
  } 


  set hier_switch ""

#  if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix flow objids: [array names flow_objid_arr]"}
  while {[string match -* [lindex $args 0]] } {
    set option [lindex $args 0]
    set args [lrange $args 1 end]
    #puts "Processing option: $option with args: $args"
    switch -exact -- $option {
      -readme {
        puts $::fcf_header::README;
        return;
      }
      -help {
        puts $::fcf_header::README;
        return;
      }
      -design {
        set design [lrange $args 0 0]
        set args [lrange $args 1 end]
      }
      -name {
        set flow_list [lrange $args 0 0]
        set args [lrange $args 1 end]
        if {[array get $flow_objid_arr $flow_list] eq ""} {
          puts "No flow found matching name: $flow_list"
          return -1
        }
      }
      -include {
        lappend includes [lrange $args 0 0]
        set args [lrange $args 1 end]
      }
      -exclude {
        lappend excludes [lrange $args 0 0]
        set args [lrange $args 1 end]
      }
      -debug {
        set debug_switch "-debug"
      }
      -hier {
        set hier_switch "-hier"
      }
      -full {
        set hier_switch "-hier"
      }
      -d {
        puts "Debug mode on"
        set debug_switch "-debug"
      }
      -regexp {
        set flow_list {}
        set re [lrange $args 0 0]
        set args [lrange $args 1 end]
        set complete_list [array names flow_objid_arr]
        foreach name $complete_list {
          if {[regexp $re $name match]} {
            lappend flow_list $name
          }
        }
      }
      default {
        puts "default captured"
        return -code error "unknown option \"$option\""
      }
    }
  }
  if {[llength $args] == 1} {
    if {[array get $flow_objid_arr $args] eq ""} {
      puts "No flow found matching name: $args"
      return -1
    } else {
      set flow_list $args
    }
  }
  # If we didn't specify any argument, just return all flows
  if {![info exists flow_list]} {
    set flow_list [array names flow_objid_arr]
  }

  if {$hier_switch ne "-hier"} {
    puts "============================================================"
    puts "  report_flows()"
    puts ""
    puts "  Generated by:             Frontend Foundation Flow v$::FFF::fcf_version"
    puts "  Generated on:             [clock format [clock seconds] -format "%I:%M:%S %p(%b%d)"]"
    if {! $elaborated} {
      puts "  NOTE: Flow DB not yet elaborated. Will only report list of flows."
    }
    puts "============================================================"
    
    if {$hier_switch eq ""} {
      puts [format "%-*s %-*s %*s" 30 "Flow" 20 "Stages" 20 "Config(s)"]
    } else {
      puts [format "%-*s %-*s %*s" 30 "Object" 20 "Type" 20 "Config(s)"]
    }
    set str1 "------------"
    set str2 $str1
    set str3 $str1
    puts [format "%-*s %-*s %*s" 30 $str1 20 $str2 20 $str3]

#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix flow list: $flow_list"}
    if {$hier_switch ne "-hier"} {
      foreach flowObjID $flow_list {
#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix printing flow: $flowObjID"}
        if {$elaborated} {
          set str1 [$flowObjID->get_parent_path]::[$flowObjID->get_name]
          set str2 [$flowObjID->get_size]
          set str3 [::FFF::fix_default_config_name $flowObjID]
          regsub {::FFF::elabdb::} $str1 {/} str1
          regsub {::} $str1 {/} str1
        } else {
          set str1 [$flowObjID->get_base_name]
          set str2 "N/A"
          set str3 "N/A"
        }
        puts [format "%-*s %-*s %*s" 30 $str1 20 $str2 20 $str3]
        #$flowObjID->print -prefix "   " -trim_ws
      }
    } else {
      foreach flowObjID $flow_list {
#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix printing flow: $flowObjID"}
        if {$elaborated} {
          set flowHierPath [$flowObjID->get_parent_path]::[$flowObjID->get_name]
          set flowConfigs [::FFF::fix_default_config_name $flowObjID]
          regsub {FF_Default} $flowConfigs {} flowConfigs
          set str1 [::FFF::strip_elab_and_colon_prefix $flowHierPath]
          set str2 "Flow"
          set str3 "$flowConfigs"
          puts [format "%-*s %-*s %*s" 30 $str1 20 $str2 20 $str3]
          foreach stageObjID [$flowObjID->get_stages] {
	    set stageHierPath [$stageObjID->get_name]
            set stageConfigs [::FFF::fix_default_config_name $stageObjID]
            regsub {FF_Default} $stageConfigs {} stageConfigs
            set str1 [::FFF::strip_elab_and_colon_prefix $flowHierPath/$stageHierPath]
            set str2 "Stage"
            set str3 "$stageConfigs"
            puts [format "%-*s %-*s %*s" 30 $str1 20 $str2 20 $str3]
            set posIter [$stageObjID->begin]
            while { [$posIter->current] ne "NULL" } {
	      set stepObjID [$posIter->current]
              set stepName [$stepObjID->get_name]
              set stepConfigs [::FFF::fix_default_config_name $stepObjID]
              regsub {FF_Default} $stepConfigs {} stepConfigs
#   	      if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix stepConfigs: ->$stepConfigs<-"}
              set str1 [::FFF::strip_elab_and_colon_prefix $flowHierPath/$stageHierPath/$stepName]
	      if {[$stepObjID->typeid] eq "PluginInst"} {
                set str2 "Step (Plugin)"
              } else {
                set str2 "Step"
	      }
              set str3 "$stepConfigs"
              puts [format "%-*s %-*s %*s" 30 $str1 20 $str2 20 $str3]
              $posIter->next
            }
          }
        } else {
          set str1 [$flowObjID->get_base_name]
          set str2 "N/A"
          set str3 "N/A"
          puts [format "%-*s %-*s %*s" 30 $str1 20 $str2 20 $str3]
        }
      }
    }
  } else {
    puts "report_flows() NOTE: Only -hier supported"
  }
  puts ""
#  if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix END"}
}; # End proc report_flows()
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [report_foundation.tcl]                                       #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################

############################################
# report_foundation
############################################
# This proc builds an ordered array of all foundation db variables, and then prints them in order.
# Ordering is done to print the variables in the same order they appeared in the original
# config file(s)

# Define the proc in it's own variable namespace (consistent with RC applets)
namespace eval FFF {
  set dbgPrefixWs [string repeat " " [info level]]

  # export the proc so it can be read into the elab ns ($elabns)
  namespace export report_foundation

  proc report_foundation {args} {
    set tags_only 0
    if {[::FFF::get_tool] ne "lec" } {puts "// Command: [calling_proc] $args"}
    while {[string match -* [lindex $args 0]] } {
      set option [lindex $args 0]
      set args [lrange $args 1 end]
      #puts "Processing option: $option with args: $args"
      switch -exact -- $option {
        -readme {
          puts $::fcf_header::README;
          return;
        }
        -help {
          puts $::fcf_header::README;
          return;
        }
        -library_only {
          set library_only 1
        }
        -design_only {
          set design_only 1
        }
        -setup_only {
          set setup_only 1
        }
        -flow_only {
          set flow_only 1
        }
        -design {
          set design [lrange $args 0 0]
          set args [lrange $args 1 end]
        }
        -basename {
          set basename [lrange $args 0 0]
          set args [lrange $args 1 end]
        }
        -include {
          lappend includes [lrange $args 0 0]
          set args [lrange $args 1 end]
        }
        -exclude {
          lappend excludes [lrange $args 0 0]
          set args [lrange $args 1 end]
        }
        -file {
          set output_file [lrange $args 0 0]
          set args [lrange $args 1 end]
        }
        default {
          return -code error "unknown option \"$option\""
        }
      }
    }
    puts "============================================================"
    if {!$tags_only} {
      puts "  Foundation Flow Tags File"  
    } else { 
      puts "  report_foundation()"
    }
    puts ""
    puts "  Generated by:           Frontend Foundation Flow v$::FFF::fcf_version"
    puts "  Generated on:           [clock format [clock seconds] -format "%I:%M:%S %p(%b%d)"]"
    puts "  Configuration:          Default"
    puts "============================================================"
    if {!$tags_only} {
      if {[array exists ::FFFdb::var_objid_list]} {
        array set varObjIdArr {}
        foreach varName [array names ::FFFdb::var_objid_list] {
          set varObjIdArr([[get_var $varName]->get_index]) [get_var $varName]
        }
        # Write out each variable, preceding beginning of variable with 'set'
        for {set varIndex 1} {$varIndex <= [array size varObjIdArr]} {incr varIndex} {
          $varObjIdArr($varIndex)->report "set "
        }
      } else {
        puts "Foundation DB currently empty"
      }
    } else {
  
    };# end else  tags_only
  };# end report_foundation
};# end namespace eval FFF

# In global ns, see if add_command_help exists. If not, import it...
if {![llength [info commands ::report_foundation]]} {
    namespace import ::FFF::report_foundation
    add_command_help report_foundation "report on the foundation flow database"
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [report_stages.tcl]                                            #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################

proc report_stages {args} {
  set dbgPrefixWs [string repeat " " [info level]]
  set msgPrefix "${dbgPrefixWs}report_stages():"
  set Debug $::FFF::Debug
  if {[::FFF::get_tool] ne "lec" } {puts "// Command: [calling_proc] $args"}
    set Debug $::FFF::Debug
  set debug_switch ""
  if {[array exists ::FFF::elabdb::stage_objid_arr]} {
    array set stage_objid_arr [array get ::FFF::elabdb::stage_objid_arr]
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix FFF DB is elaborated"}
    set elaborated 1
  } else {
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix FFF DB is NOT elaborated"}
    array set stage_objid_arr [array get ::FFF::stage_objid_arr]
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix set arr stage_objid_arr  to ->[array get stage_objid_arr]<-"}
    set elaborated 0
  }

  while {[string match -* [lindex $args 0]] } {
    set option [lindex $args 0]
    set args [lrange $args 1 end]
    #puts "Processing option: $option with args: $args"
    switch -exact -- $option {
      -readme {
        puts $::fcf_header::README;
        return;
      }
      -help {
        puts $::fcf_header::README;
        return;
      }
      -design {
        set design [lrange $args 0 0]
        set args [lrange $args 1 end]
      }
      -name {
        set stage_list [lrange $args 0 0]
        set args [lrange $args 1 end]
        if {[array get ::FFF::stage_objid_arr $stage_list] eq ""} {
          puts "No stage found matching name: $stage_list"
          return -1
        }
      }
      -include {
        lappend includes [lrange $args 0 0]
        set args [lrange $args 1 end]
      }
      -exclude {
        lappend excludes [lrange $args 0 0]
        set args [lrange $args 1 end]
      }
      -debug {
        set debug_switch "-debug"
      }
      -d {
        puts "Debug mode on"
        set debug_switch "-debug"
      }
      -regexp {
        # Note - we need to determine how -regexp behavior differs pre and post elaboration
	# Currently -regexp assumes pre-elab settings
        set stage_list {}
        set re [lrange $args 0 0]
        set args [lrange $args 1 end]
        set complete_list [array names ::FFF::stage_objid_arr]
        foreach name $complete_list {
          if {[regexp $re $name match]} {
            lappend stage_list $name
          }
        }
      }
      default {
        puts "default captured"
        return -code error "unknown option \"$option\""
      }
    }
  }

#  if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix Finished while loop"}
  if {[llength $args] == 1} {
    if {[array get ::FFF::stage_objid_arr $args] eq ""} {
      puts "No stage found matching name: $args"
      return -1
    } else {
      set stage_list $args
    }
  }

  if {[array size stage_objid_arr] > 0 } {
    puts "============================================================"
    puts "  report_stages()"
    puts ""
    puts "  Generated by:             Frontend Foundation Flow v$::FFF::fcf_version"
    puts "  Generated on:             [clock format [clock seconds] -format "%I:%M:%S %p(%b%d)"]"
      if {! $elaborated} {
        puts "  NOTE: Flow DB not yet elaborated. Will only report list of stages."
      }
    puts "============================================================"
    puts [format "%-*s %-*s %*s %*s" 30 "Stage" 20 "Parent" 20 "Steps" 20 "Config(s)"]
    set str1 "------------"
    set str2 $str1
    set str3 $str1
    set str4 $str1
    puts [format "%-*s %-*s %*s %*s" 30 $str1 20 $str2 20 $str3 20 $str4]

#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix Iterating through stage objects..."}
    foreach stageObjID [array names stage_objid_arr] {
      if {$elaborated} {
        set str1 [$stageObjID->get_name]
        set str2 [$stageObjID->get_parent_path]
        set str3 [$stageObjID->get_size]
        set str4 [::FFF::fix_default_config_name $stageObjID]

        regsub {::FFF::elabdb::} $str1 {/} str1
        regsub {::FFF::elabdb::} $str2 {/} str2
        regsub {::} $str1 {/} str1
        regsub {::} $str2 {/} str2
      } else {
#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix Not elaborated..."}
#        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix Getting base name of $stageObjID ([$stageObjID->get_name]) which is: [$stageObjID->get_base_name]"}
        set str1 [$stageObjID->get_base_name]
        set str2 "N/A"
        set str3 "N/A"
        set str4 "N/A"
      }
      puts [format "%-*s %-*s %*s %*s" 30 $str1 20 $str2 20 $str3 20 $str4]
      #set configs [[get_stage $stage]->get_configurations]
      #[get_stage $stage]->print -prefix "   " -trim_ws
    }
  } else {
    puts "report_stages() NOTE: No Stages Created"
  }
#  if {$Debug} {puts $::FFF::DEBUG_OSTREAM "$msgPrefix END"}
} ; # End proc report_stages()
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [report_steps.tcl]                                            #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {

  namespace export report_steps

  proc report_steps {args} {
    set dbgPrefixWs [string repeat " " [info level]]
    set msgPrefix "${dbgPrefixWs}report_steps():"
    set Debug $::FFF::Debug
    if {[array exists ::FFF::elabdb::step_objid_arr]} {
      array set step_objid_arr [array get ::FFF::elabdb::step_objid_arr]
      array set step_objid_arr [array get ::FFF::elabdb::plugin_objid_arr]
      set elaborated 1
    } else {
      array set step_objid_arr [array get ::FFF::step_objid_arr]
      array set step_objid_arr [array get ::FFF::plugin_objid_arr]
      set elaborated 0
    }
    if {[::FFF::get_tool] ne "lec" } {puts "// Command: [calling_proc] $args"}
  
  
    # Call parse_options
    switch -- [parse_options [calling_proc] {} $args \
      "-basename sos specify basename of step" basename \
      "-design bOs specify design scope" designScope \
      "-full bos display full step information" fullFlag \
      "sos step name" stepName \
    ] {
      -2 { return }
      0  { error "Failed on [lindex [info level 0] 0]" }
    }
  
    if {[array size step_objid_arr]} {
      puts ""
      puts "============================================================"
      puts "  report_steps()"
      puts ""
      puts "  Generated by:           Frontend Foundation Flow v$::FFF::fcf_version"
      puts "  Generated on:           [clock format [clock seconds] -format "%I:%M:%S %p(%b%d)"]"
      puts "  Total count:            [array size step_objid_arr]"
      if {! $elaborated} {
        puts "  NOTE: Flow not yet elaborated. Will only report list of flows."
      }
      puts "============================================================"
      puts [format "%-*s %-*s %-*s %*s %*s" 5 "Number" 30 "Step" 20 "Parent" 20 "Lines" 20 "Config(s)"]
      set wsx5 "-----"
      set wsx12 "------------"
      puts [format "%-*s %-*s %*s %*s" 5 $wsx5 30 $wsx12 20 $wsx12 20 $wsx12 20 $wsx12]
  
      set stepNum 1
      if {$basename ne ""} {
        set objList [get_step -basename $basename]
      } else {
        set objList [lsort -dictionary [array names step_objid_arr]]
      }
      if {$objList ne "-1"} {
        foreach stepObjID $objList {
          ::FFF::dbg_puts "$msgPrefix Processing step [$stepObjID->get_name] ($stepObjID)"
          if {$elaborated} {
            set str1 $stepNum
            set str2 [$stepObjID->get_name]
            set str3 [$stepObjID->get_parent_path]
            set str4 [$stepObjID->get_block_size]
            set str5 [::FFF::fix_default_config_name $stepObjID]
            # Remove FF_Default from the config list, if it's there
            regsub {FF_Default} $str4 {} str4
  
            regsub {::FFF::elabdb::} $str1 {/} str1
            regsub {::FFF::elabdb::} $str2 {/} str2
            regsub {::FFF::elabdb::} $str3 {/} str3
            regsub {::} $str1 {/} str1
            regsub {::} $str2 {/} str2
            regsub {::} $str3 {/} str3
          } else {
            set str2 [$stepObjID->get_base_name]
            set str3 "N/A"
            set str4 "N/A"
            set str5 "N/A"
          }
          puts [format "%-*s %-*s %-*s %*s %*s" 5 $str1 30 $str2 20 $str3 20 $str4 20 $str5]
          if {$fullFlag || $basename ne ""} {
            $stepObjID->print -prefix "   "
          $stepObjID->report_stats
          }
        
          incr stepNum
        }
      } else {
        puts "<FF> ERROR: No step found with basename $basename"
        return -code error
      }
    } else {
      puts "report_steps() NOTE: No Steps Created"
    }
  };# end proc
};# end namespace eval FFF

if {![llength [info commands ::report_steps]]} {
    namespace import ::FFF::report_steps
    add_command_help report_steps "Generate a report of all steps in the Foundation Flow"
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [reset_foundation.tcl]                                        #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################

proc reset_foundation {args} {
  namespace eval FFFdb {} {
    array unset vars
    array unset FFFdbVar
    array unset var_objid_list
    variable vars
    array set vars {
      library_set,timing {}
      design ""
      netlist ""
      hdl_file_set,default {}
      synthesis,effort ""
    }
  }
  namespace eval FFF {} {
    array unset flow_objid_arr;
    array unset flowInst_objid_arr;
    array unset stage_objid_arr;
    array unset stageInst_objid_arr;
    array unset step_objid_arr;
    array unset stepInst_objid_arr;
    array unset plugin_objid_arr;
    array unset pluginInst_objid_arr;
    array unset config_objid_list;
  }
  namespace delete ::FFF::elabdb
  puts "Foundation DB reset"
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [run_foundation.tcl]                                          #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @  #
#  Date        [01-11-2011]                                                  #
##############################################################################
# Define the proc in it's own variable namespace (consistent with RC applets)
namespace eval FFF {

  # export the proc so it can be read into the elab ns ($elabns)
  namespace export run_foundation

  proc run_foundation {args} {
    set dbgPrefixWs [string repeat " " [info level]]
    set FFCommand "run_foundation"
    set msgPrefix "${dbgPrefixWs}${FFCommand}(API):"

    if {[::FFF::get_tool] ne "lec" } {puts "// Command: [calling_proc] $args"}
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} BEGIN"}
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} args: ->$args<-"}
    # Variables for Parse Options:
    set myPrefix ""
    set mySuffix ""
    set myDebugSwitch 0
    set myRegexp ""
    set myReadmeFlag 0
    set myDesignScope ""
    set myFlowToExecute ""
    set myStageToExecute ""
    set myTrimWsFlag 0
    set myRunDir "./"

    # Variables set for internal use by the proc
    set comments_switch ""
    set trim_ws_switch ""
    set replace_switch ""
    set debug_switch "-debug"

    if {[array exists ::FFF::elabdb::flow_objid_arr]} {
      array set flow_objid_arr [array get ::FFF::elabdb::flow_objid_arr]
      set elaborated 1
    } else {
      puts "run_foundation() ERROR: Foundation DB not yet elaborated."
      puts "Foundation DB must first be elaborated using \"elaborate_foundation\" or by not passing the"
      puts "\"-noelab\" argument to read_foundation."
      puts "Alternatively, you can simply source the generated scripts."
      return 0
    } 

    # #########################################################################
    # Parse options
    # #########################################################################
    # "-name <x><y><z>(<value>) <help>"
    # <x>: s - string
    #      n - int
    #      f - float
    #      b - boolean
    # <y>: o - optional
    #      r - required
    # <z>: s - single arg accepted
    #      m - multiple args accepted (list accepted)
    # <value>: possible value the option accepts.
    #          Optional if <y> is set to 'o'
    #          Use "|" for strings, object types, integers
    # <help>: string displayed when the user types -help with the option

    # Note - if "-edi" is used, and "-config" is not provided, FF will write out he variables
    # in the ::FFF:: namespace; in other words, the default configuration.

    switch -- [parse_options [calling_proc] {} $args \
      "-debug bos Suffix for all files" myDebugSwitch \
      "-regexp sos Regular expression filter to select specific stages/flows" myRegexp \
      "-rundir sos Directory that tool execution will occur in" myRunDir \
      "-readme bos Print Readme Information on the Foundation Flow" myReadmeFlag \
      "-scope sos Filter on design scope" myDesignScope \
      "-flow sos Flow name (if unique) or flow instance path to write" myFlowToExecute \
      "-stage sos Stage name (if unique) or stage instance path to write" myStageToExecute \
      ] {
      -2 { return }
      0 { error "Failed on [lindex [info level 0] 0]" }
    }

    if {$myReadmeFlag} {
      puts $::fcf_header::README;
    }

    if {$myDebugSwitch} {
      set debug_switch "-debug"
    } else {
      set debug_switch ""
    }
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} debug_switch: ->$debug_switch<-"}

    # If we didn't specify any argument, just return all flows
    if {![info exists flow_list]} {
      set flow_list [array names flow_objid_arr]
    }
  
    # Execute the stage
    if {$myStageToExecute ne ""} {
      # BUDA: Branch Edit: added -basename below
      if {$myRunDir ne "./"} {
        set ::FFF::runScript [file normalize [[get_stage -basename $myStageToExecute]->get_script_name]]
        ##nagelfar ignore
        set cwd [exec pwd]
        if {[::FFF::get_tool] eq "rc"} {
          lcd $myRunDir
        } else {
          cd $myRunDir
        }
	puts "<FF> INFO: Changed directory to $myRunDir"
      } else {
        set ::FFF::runScript [[get_stage -basename $myStageToExecute]->get_script_name]
      }
      uplevel #0 {
        source $::FFF::runScript
      }
      if {$myRunDir ne "./"} {
        if {[::FFF::get_tool] eq "rc"} {
          lcd $cwd
        } else {
          cd $cwd
        }
	puts "<FF> INFO: Changed directory to $cwd"
      }
    }
  } ; # End proc run_foundation()
}; # end namespace eval 

if {![llength [info commands ::run_foundation]]} {
    namespace import ::FFF::run_foundation
    add_command_help run_foundation "Execute the flow."
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [set_configuration.tcl]                                       #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################

###############################################################
# set_configuration
# Usage: set_configuratoin <config_name> {variable list}
# @Return: Configuration Object ID
###############################################################

namespace eval FFF {
  namespace export set_configuration
  # Define proc in FFF namespace
  proc set_configuration {args} {
    set dbgPrefixWs [string repeat " " [info level]]
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}set_configuration(API) BEGIN"}
    #puts "calling set_configuration ..."
    #set_configuration $args

    set Debug $::FFF::Debug
    set configName [lindex $args 0]

    if {[llength $configName] > 1} {
      puts "set_configuration ERROR: Name detected is: $configName, which is illegal."
      puts "set_configuration ERROR: Usage: set_configuration <name> { block of set statements}"
      puts "set_configuration ERROR: Contact the Author if you have received this message in error."
      puts "Exiting ..."
      exit 1
    }
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}set_configuration(API): Processing configuration $configName"}

    set args [lrange $args 1 end]
    while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $args full args ]} {
    };# end while

    #set args [split $args "\n"]
    array set local_arr {}

#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}set_configuration(API): Config name: $configName"}
    # Process configuration
    if {$configName ne ""} {
      # We have a config name (which is required for now)
      if {[get_config $configName] eq ""} {
        # Configuration does not exist, so create namespace and then configuration object inside namespace
      
        set configObjID [new Configuration $configName $args]
        $configObjID->update_vars $args
        set ::FFF::config_objid_list($configName) $configObjID

      } else {
        # Need to fix this, if the stuff above works
        set configObjID [get_config $configName]
        $configObjID->update_vars $args
      }
    } else {
      puts "ERROR: set_configuration requires a name be supplied for the config"
      return -1
    }
#    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${dbgPrefixWs}set_configuration(API) END"}
  };# end proc set_configuration
}

namespace eval ${::FFF::elabns} {
  if {![llength [info commands set_configuration]]} {
    namespace import ::FFF::set_configuration
  }
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [set_fcf_version.tcl]                                         #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {
  ###############################################################
  # set_fcf_version
  # Usage: set_fcf_version <flow_name> {flow text}
  # @Return: Flow Object ID
  ###############################################################
  namespace export set_fcf_version
  proc set_fcf_version {args} {
    if {[ regexp {([0-9]+\.[0-9]+)} $args full read_set_fcf_version_value]} {
      if {[lsearch $read_set_fcf_version_value $::FFF::supported_fcf_versions]} {
        if { $::FFF::default_fcf_version ne $read_set_fcf_version_value} {
          # Only need to print a message if we are overwritting the default version
          puts "NOTE: Setting FCF Version to: $read_set_fcf_version_value"
          set fcf_version $read_set_fcf_version_value
        }
      }
    }
  }
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [set_script_name.tcl]                                         #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version     [10.10-d002]                                                  #
##############################################################################

namespace eval FFF {
  ###############################################################
  # set_script_name
  # Usage: set_script_name <name>
  ###############################################################
  proc set_script_name {args} {
    set dbgPrefixWs [string repeat " " [info level]]
    set msgPrefix "${dbgPrefixWs}set_script_name():"

    set Debug $::FFF::Debug
    set set_script_name_args {}
    if {$args ne ""} {
      if {![string match -* [lindex $args 0]]} {
        set scriptName [lindex $args 0]
        set args [lrange $args 1 end]
      }

      # Always called within a create_stage block
      # so we can upvar 1 and get the calling stageName
      upvar 1 stageName stageName_local
      upvar 1 stageObjID stageObjID_local
      upvar 1 flowName flowName_local
      upvar 1 flowObjID flowObjID_local

      while {[string match -* [lindex $args 0]]} {
        set option [lindex $args 0]
        set args [lrange $args 1 end]
        switch -exact -- $option {
          -naming_parameters {
            set naming_parameters [lrange $args 0 0]
            set args [lrange $args 1 end]
          }
          -extension {
            set extension [lrange $args 0 0]
            set args [lrange $args 1 end]
          }
          default {
            return -code error "unknown option \"$option\""
          }
        };# end switch
      };# end While (string matching for args and expressions)

      while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $args full args ]} {
      };# end while

      if {[info exists stageObjID_local] && $stageObjID_local ne ""} {
        $stageObjID_local->set_script_name $scriptName
      } elseif {[info exists flowObjID_local] && $flowObjID_local ne ""} {
        $flowObjID_local->set_script_name $scriptName
      } else {
	puts "set_script_name ERROR: set_script_name called outside of a stage or flow definition. This is not allowed."
	puts "Exiting ..."
	exit 1
      }
    }
  }
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [set_script_type.tcl]                                         #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version     [10.10-d002]                                                  #
##############################################################################

namespace eval FFF {
  ###############################################################
  # set_script_type
  # Usage: set_script_type <name>
  ###############################################################
  proc set_script_type {args} {
    set Debug $::FFF::Debug
    set dbgPrefixWs [string repeat " " [info level]]
    set msgPrefix "${dbgPrefixWs}set_script_type ([namespace current]):"
    set scriptType ""	
    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} STARTING set_script_type: args: ->$args<- called in NS: ->[namespace current]<-"}
    set set_script_type_args {}
    if {$args ne ""} {
      if {![string match -* [lindex $args 0]]} {
        set scriptType [lindex $args 0]
        set args [lrange $args 1 end]
      }

      # Always called within a create_stage block
      # so we can upvar 1 and get the calling stageName
      upvar 1 stageName stageName_local
      upvar 1 stageObjID stageObjID_local
      upvar 1 flowName flowName_local
      upvar 1 flowObjID flowObjID_local

      while {[string match -* [lindex $args 0]]} {
        set option [lindex $args 0]
        set args [lrange $args 1 end]
        switch -exact -- $option {
          -path_to_exe {
            set path_to_exe [lrange $args 0 0]
            set args [lrange $args 1 end]
          }
          default {
            return -code error "unknown option \"$option\""
          }
        };# end switch
      };# end While (string matching for args and expressions)

      while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $args full args ]} {
      };# end while

      if {[info exists stageObjID_local] && $stageObjID_local ne ""} {
        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} setting script type for stage $stageObjID_local to $scriptType"}
        $stageObjID_local->set_script_type $scriptType
      } elseif {[info exists flowObjID_local] && $flowObjID_local ne ""} {
        if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} setting script type for flow $flowObjID_local to $scriptType"}
        $flowObjID_local->set_script_type $scriptType
      } else {
	puts "${msgPrefix} ERROR: set_script_type called outside of a stage or flow definition. This is not allowed."
	puts "Exiting ..."
	exit 1
      }
    }
    if {$Debug} {puts $::FFF::DEBUG_OSTREAM "${msgPrefix} END"}
  }
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [set.tcl]                                                     #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################

###############################################################
# set command for Frontend Foundation Flow
#
# This is effectively a wrapper which puts every variable set outside a configuration
# into the default configuration namespace (::FFF::nonelab::default_config)
# 
# Usage: set <variable name> {value}
# @Return: Configuration Object ID
###############################################################

namespace eval FFF {

  #
  # This proc creates (persistent) namespace variables in the nonelab namespace
  # so the FF variables don't go away
  #
  proc init_set_wrapper_in_nonelabns {} {
    namespace eval $::FFF::nonelabns {

      #
      # set wrapper
      #
      proc set {args} {
        ::set varName [lindex $args 0]
        ::set varValue [lrange $args 1 end]
        if {[regexp {(\S+)\((.*)\)} $varName full arrName varKey]} {
          variable $arrName
          ::set local_cmd_string "::set $varName $varValue"
        } else {
          variable $varName
          ::set local_cmd_string "::set $varName $varValue"
        }
        eval $local_cmd_string
      }

      #
      # lappend wrapper
      #
      proc lappend {args} {
        ::set varName [lindex $args 0]
        ::set varValue [lrange $args 1 end]
        if {[regexp {(\S+)\((.*)\)} $varName full arrName varKey]} {
          variable $arrName
          ::set local_cmd_string "::lappend $varName $varValue"
        } else {
          variable $varName
          ::set local_cmd_string "::lappend $varName $varValue"
        }
        eval $local_cmd_string
      }
    };# end namespace eval nonelabns
  };# end proc init_set_wrapper_in_nonelabns
};# end namespace eval FFF
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [set.tcl]                                                     #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {

  proc init_set_wrapper_in_elabns {} {

    namespace eval $::FFF::elabns {
      proc set {args} {
        ::set cmd_string "set $args"
        ::set varName [lindex $args 0]
        ::set varValue [lrange $args 1 end]
        if {[regexp {(\S+)\((.*)\)} $varName full arrName varKey]} {
          #::set local_cmd_string "variable $arrName"
          #eval $local_cmd_string
	  variable $arrName
        } else {
          variable $varName
        }
        ::set local_cmd_string "::set $varName $varValue"
        eval $local_cmd_string

        ${::FFF::myDefaultConfigObjID}->update_vars $cmd_string
      };# end set wrapper

      proc lappend {args} {
        ::set cmd_string "lappend $args"
        ::set varName [lindex $args 0]
        ::set varValue [lrange $args 1 end]
        if {[regexp {(\S+)\((.*)\)} $varName full arrName varKey]} {
          #::set local_cmd_string "variable $arrName"
          #eval $local_cmd_string
	  variable $arrName
        } else {
          variable $varName
        }
        ::set local_cmd_string "::lappend $varName $varValue"
        eval $local_cmd_string

        ${::FFF::myDefaultConfigObjID}->update_vars $cmd_string
      };# end lappend wrapper

      #proc open {args} {
      #  catch {
      #  ::set dbgPrefixWs [string repeat " " [info level]]
      #  ::set msgPrefix "${dbgPrefixWs}[::FFF::getProcName]():"
      #  ::FFF::dbg_puts "opened $args"
      #  }
      #}
      #proc close {args} {
      #  catch {
      #  ::set dbgPrefixWs [string repeat " " [info level]]
      #  ::set msgPrefix "${dbgPrefixWs}[::FFF::getProcName]():"
      #  ::FFF::dbg_puts "closed $args"
      #  }
      #}

    }; #end namespace eval $::FFF::elabns
  };# end proc init_set_wrapper_in_elabns
};# end namespace eval FFF
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [set_tool.tcl]                                         #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version     [10.10-d002]                                                  #
##############################################################################

namespace eval FFF {
  ###############################################################
  # set_tool
  # Usage: set_tool [-name <name>] [-before <id> | -after <id>
  #  -begin | -end ]
  ###############################################################
  proc set_tool {args} {
    set dbgPrefixWs [string repeat " " [info level]]
    set msgPrefix "${dbgPrefixWs}set_tool():"
    set Debug $::FFF::Debug
    set instance_name ""
    set toolArgs ""
    set stage_id_list {} 
    set config_list {}
    set set_tool_args {}
    if {$args ne ""} {
      set expression ""
      set in_expr 0
      if {![string match -* [lindex $args 0]]} {
        set toolName [lindex $args 0]
        set args [lrange $args 1 end]
      }

      # Always called within a create_stage block
      # so we can upvar 1 and get the calling stageName
      upvar 1 stageName stageName_local
      upvar 1 stageObjID stageObjID_local
      
      while {[string match -* [lindex $args 0]]} {
        set option [lindex $args 0]
        set args [lrange $args 1 end]
        switch -exact -- $option {
          -exe_path {
            set exe_path [lrange $args 0 0]
            set args [lrange $args 1 end]
          }
          -args {
            set toolArgs [lrange $args 0 0]
            set args [lrange $args 1 end]
            while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $toolArgs full toolArgs ]} {
            }
          }
          default {
            return -code error "unknown option \"$option\""
          }
        };# end switch
      };# end While (string matching for args and expressions)

      while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $args full args ]} {
      };# end while

      $stageObjID_local->set_tool $toolName
      $stageObjID_local->set_tool_args $toolArgs
    }
  }; # end proc set_tool
};# end namespace eval FFF
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [update_foundation_db.tcl]                                    #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################

############################################
# update_foundation_db
############################################
proc update_foundation_db {args} {
  set fcf_version $::FFF::default_fcf_version
  set overwrite 0
  set includes ""
  set excludes ""
  set file_list {}
  while {[string match -* [lindex $args 0]] } {
    set option [lindex $args 0]
    set args [lrange $args 1 end]
    #puts "Processing option: $option with args: $args"
    switch -exact -- $option {
      -overwrite {
      set overwrite 1
      #puts "setting overwrite mode"
      }
      -readme {
        puts $::fcf_header::README;
        return
      }
      -help {
        puts $::fcf_header::README;
        return
      }
      -exclude {
      lappend excludes [lrange $args 0 0]
      set args [lrange $args 1 end]
      }
      default {
      return -code error "unknown option \"$option\""
      }
    }
  }
  lappend file_list $args
  # END OF PROCESSING ARGS

  # pseudo code
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [update_stage.tcl]                                            #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
##############################################################################

namespace eval FFF {
  ###############################################################
  # update_stage
  # Usage: update_stage <stage_name> {stage text}
  ###############################################################
  namespace export update_stage

  proc update_stage {args} {
    set Debug $::FFF::Debug
    set dbgPrefixWs [string repeat " " [info level]]
    set msgPrefix "${dbgPrefixWs}update_stage():"
    set stageName [lindex $args 0]
    set msgPrefix "${dbgPrefixWs}update_stage($stageName):"
    set args [lrange $args 1 end]
    if {$stageName ne ""} {
      # Create the stage object if it doesn't exist
      if {[get_stage $stageName] eq "-1"} {
      } else {
        set stageObjID [get_stage $stageName]
      }
      set stage_proc_name $stageName
      # Define a proc to execute the args in the stage block
      # The following is the parsing method the foundation flow is using. 
      # This is a valid nagelfar waiver
      ##nagelfar ignore
      proc $stageName {args} {
        ::set dbgPrefixWs [string repeat " " [info level]]
	upvar 1 stageObjID stageObjID
	upvar 1 Debug Debug

	# link to ::FFF::vars
	variable vars

        while {[string match -* [lindex $args 0]] } {
          set option [lindex $args 0]
          set args [lrange $args 1 end]
          switch -exact -- $option {
            -name {
              set stageName [lrange $args 0 0]
              set args [lrange $args 1 end]
            }
          }
        }
        ::set msgPrefix "${dbgPrefixWs}($stageName):"
        # Iteratively strip curly braces on the outside of the block.
        # This is needed in order to pass the entire block to eval below
        while {[regexp {^\{[[:space:]]*(.*)[[:space:]]*\}$} $args full args ]} {}
        eval $args
      }
      # Execute the stage definition
      # Basically this evaluates all the commands in the stage block
      # in the ::FFF:: namespace
      $stageName -name $stage_proc_name $args
    } else {
      puts "ERROR: update_stage requires a name be supplied for the stage"
      return -1
    }
  }; # end proc update_stage
}; # end namespace FFF

namespace eval ${::FFF::nonelabns} {
  if {![llength [info commands update_stage]]} {
    namespace import ::FFF::update_stage
  }
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [write_foundation.tcl]                                        #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {

  namespace export write_foundation

  proc write_foundation {args} {
    set Debug $::FFF::Debug
    # Arg defaults:
    set design ""
    set basename ""
  
    # Args to write_foundation:
    set myOverwriteFlag 0
    set myWriteLibraryVarsFlag 0
    set myWriteDesignVarsFlag 0
    set myWriteSetupVarsFlag 0
    set myWriteFlowVarsFlag 0
    set myWriteEdiVarsFlag 0
    set myConfigurationName {}
    set myEscapedFlag 0
    set myReademeFlag 0
    set myQuietFlag 0
    set myTagsFlag 0
    set myGzipFlag 0
    set myFileName "setup.tcl"
    set myNoUpdateFlag 0
    set parse_options_args_list {}
    set myNoRundirConfigFlag 0
  
    # Internal variables
    set configNameList {}

    # "-name <x><y><z>(<value>) <help>"
    # <x>: s - string
    #      n - int
    #      f - float
    #      b - boolean
    # <y>: o - optional
    #      r - required
    # <z>: s - single arg accepted
    #      m - multiple args accepted (list accepted)
    # <value>: possible value the option accepts.
    #          Optional if <y> is set to 'o'
    #          Use "|" for strings, object types, integers
    # <help>: string displayed when the user types -help with the option
     
    # Note - if "-edi" is used, and "-config" is not provided, FF will write out he variables
    # in the ::FFF:: namespace; in other words, the default configuration.
  
    switch -- [parse_options [calling_proc] {} $args \
      "-file sos File name to write the configuration to" myFileName \
      "-overwrite bos Whether to overwrite an existing foundation configuration file" myOverwriteFlag \
      "-gzip bos gzip the output configuration file" myGzipFlag \
      "-tags bos gzip Write out a tags file" myTagsFlag \
      "-readme bos Print Readme Information on the Foundation Flow" myReadmeFlag \
      "-quiet bos Do not print information to stdout when writing configuration file " myQuietFlag \
      "-library bos Include library related configuration variables" myWriteLibraryVarsFlag \
      "-design bos Include design related configuration variables" myWriteDesignVarsFlag \
      "-setup bos Include setup related configuration variables" myWriteSetupVarsFlag \
      "-flow bos Include flow related configuration variables" myWriteFlowVarsFlag \
      "-noupdate bos Do not update Foundation DB prior to writing out configuration" myNoUpdateFlag \
      "-norundircfg bos Do not automatically source the Foundation Rundir Config file" myNoRundirConfigFlag \
      "-edi bos Write EDI FF compatible configuration file" myWriteEdiVarsFlag \
      "-configs sos Configuration name(s)" myConfigurationName \
      "-escaped bos Escape any variable values that reference other variables" myEscapedFlag \
      "-path_fix sos \[normalize|relative\] Modify the paths to files or directories as relative (from the rundir) or absolute." myPathFix \
      "-rundir sos Run directory " myRunDir \
      ] {
      -2 { return }
      0 { error "Failed on [lindex [info level 0] 0]" }
    }
    if {$myEscapedFlag} {
      if {$myRunDir ne ""} {
        if {[info exists myPathFix] && $myPathFix ne ""} {
          switch -exact -- $myPathFix {
              normalize {set configPrintArgs "-escaped -rundir $myRunDir -path_fix normalize -file $myFileName -prefix \"   \""}
              relative  {set configPrintArgs "-escaped -rundir $myRunDir -path_fix relative -file $myFileName -prefix \"   \""}
              default   {set configPrintArgs "-escaped -file $myFileName -prefix \"   \""}
          }
        } else {
          set configPrintArgs "-escaped -file $myFileName -prefix \"   \""
        }
      } else {
        if {[info exists myPathFix] && $myPathFix ne ""} {
          switch -exact -- $myPathFix {
              normalize {set configPrintArgs "-escaped -path_fix normalize -file $myFileName -prefix \"   \""}
              default   {set configPrintArgs "-escaped -file $myFileName -prefix \"   \""}
          }
        } else {
          set configPrintArgs "-escaped -file $myFileName -prefix \"   \""
        }
      }
    } else {
      if {$myRunDir ne ""} {
        if {[info exists myPathFix] && $myPathFix ne ""} {
          switch -exact -- $myPathFix {
              normalize {set configPrintArgs "-rundir $myRunDir -path_fix normalize -file $myFileName -prefix \"   \""}
              relative  {set configPrintArgs "-rundir $myRunDir -path_fix relative -file $myFileName -prefix \"   \""}
              default   {set configPrintArgs "-file $myFileName -prefix \"   \""}
          }
        } else {
          set configPrintArgs "-file $myFileName -prefix \"   \""
        }
      } else {
        if {[info exists myPathFix] && $myPathFix ne ""} {
          switch -exact -- $myPathFix {
              normalize {set configPrintArgs "-path_fix normalize -file $myFileName -prefix \"   \""}
              default   {set configPrintArgs "-file $myFileName -prefix \"   \""}
          }
        } else {
          set configPrintArgs "-file $myFileName -prefix \"   \""
        }
      }
    }

    if {!$myQuietFlag} {
      puts "write_foundation() $args"
    }
    # Debug - checking that this worked:
    if {$myNoUpdateFlag} {
      puts "NOTE: Will not update Foundation DB prior to writing configuration"
    } else {
      # Not yet supported
      ###puts "NOTE: Updating Foundation DB from tool [::FFF::get_tool]"
      # Call update_foundation here (TBD)
    }

    if {!$myTagsFlag} {
      set configNameList [array names ::FFF::config_objid_list]
      set header_configNameList $configNameList
      if {[array names [${::FFF::myDefaultConfigObjID}->get_var_tracking_namespace]::mVarArray] ne ""} {
        regexp {FF_Default} [${::FFF::myDefaultConfigObjID}->get_name] configName
        lappend header_configNameList $configName
      }
  
      if {!$myQuietFlag} {
        if {$myFileName eq ""} {
          puts "write_foundation(): Writing configuration"
        } else {
          puts "write_foundation(): Writing $myFileName"
        }
      }
      set vars(codegen_dir) [dirname [file normalize $myFileName]]
      if {$vars(codegen_dir) eq ""} {set vars(codegen_dir) "."}
      #puts "set codegen_dir $vars(codegen_dir)"

      if {[file dirname $vars(codegen_dir)] ne "."} {
        catch {file mkdir $vars(codegen_dir)} 
      }
    }

    set OSTREAM [open $myFileName "w"]
    # Write out Foundation DB
    puts $OSTREAM "#============================================================"
    if {!$myTagsFlag} {
      puts $OSTREAM "#  write_foundation() Configuration File"
    } else {
      puts $OSTREAM "#  write_foundation() Tags File"
    }
    puts $OSTREAM "#"
    ##nagelfar ignore
    puts $OSTREAM "#  FF Generation dir:     [exec pwd]"
    puts $OSTREAM "#  Filename:              $myFileName"
    puts $OSTREAM "#  Generated by:          Frontend Foundation Flow v$::FFF::fcf_version"
    puts $OSTREAM "#  Generated on:          [clock format [clock seconds] -format "%I:%M:%S %p(%b%d)"]"
    if {!$myTagsFlag} {
      puts $OSTREAM "#  Configurations:        $header_configNameList"
    }
    puts $OSTREAM "#  Exported by:           [eval exec whoami]"
    puts $OSTREAM "#============================================================"
    if {!$myTagsFlag} {
       puts $OSTREAM "if {!\[info exists vars\]} {"
       puts $OSTREAM "   global vars"
       puts $OSTREAM "}"
       #if {!$myNoRundirConfigFlag} {
       #  puts $OSTREAM "if {\[file exists .ff.tcl\]} {"
       #  puts $OSTREAM "  source .ff.tcl"
       #  puts $OSTREAM "}"
       #}
    }
    close $OSTREAM
  
    if {!$myTagsFlag} {

      #
      # Write out Configs
      #
      foreach config $configNameList {
        if {[get_config $config] ne ""} {
          #puts "executing [get_config $config]->print $configPrintArgs"
          [get_config $config]->print $configPrintArgs
        }
      }

    } else {
      # 
      # Write out tags
      # 
      if {[array exists ::FFF::elabdb::flow_objid_arr]} {
        array set flow_objid_arr [array get ::FFF::elabdb::flow_objid_arr]
        set elaborated 1
      } else {
        array set flow_objid_arr [array get ::FFF::flow_objid_arr]
        set elaborated 0
      }
      if {![info exists flow_list]} {
        set flow_list [array names flow_objid_arr]
      }

      set OSTREAM [open $myFileName "a"]
      foreach flowObjID $flow_list {
        if {$elaborated} {
          set flowHierPath [$flowObjID->get_parent_path]::[$flowObjID->get_name]
          set flowConfigs [::FFF::fix_default_config_name $flowObjID]
          regsub {FF_Default} $flowConfigs {} flowConfigs
          set str1 "# Flow:"
          set str2 [file tail [::FFF::strip_elab_and_colon_prefix $flowHierPath]]
          set str3 "$flowConfigs"
          puts $OSTREAM [format "%-*s %-*s %*s" 0 $str1 4 $str2 20 $str3]
          foreach stageObjID [$flowObjID->get_stages] {
            set stageHierPath [file tail [$stageObjID->get_name]]
            set stageConfigs [::FFF::fix_default_config_name $stageObjID]
            regsub {FF_Default} $stageConfigs {} stageConfigs
            set str1 "# Stage:"
            set str2 [::FFF::strip_elab_and_colon_prefix $flowHierPath/$stageHierPath]
            set str3 "$stageConfigs"
            puts $OSTREAM [format "%-*s %-*s %*s" 0 $str1 4 $str2 72 $str3]
            puts $OSTREAM ""
            set posIter [$stageObjID->begin]
            while { [$posIter->current] ne "NULL" } {
              set stepObjID [$posIter->current]
              set stepName [$stepObjID->get_name]
              set str1 "set"
              set str2 "vars($stageHierPath,$stepName,pre_tcl)"
              set str3 "<file name>"
              puts $OSTREAM [format "%-*s %-*s %-*s" 0 $str1 65 $str2 14 $str3]

              set str1 "set"
              set str2 "vars($stageHierPath,$stepName,post_tcl)"
              set str3 "<file name>"
              puts $OSTREAM [format "%-*s %-*s %-*s" 0 $str1 65 $str2 14 $str3]

              set str1 "set"
              set str2 "vars($stageHierPath,$stepName,replace_tcl)"
              set str3 "<file name>"
              puts $OSTREAM [format "%-*s %-*s %-*s" 0 $str1 65 $str2 14 $str3]

              set str1 "set"
              set str2 "vars($stageHierPath,$stepName,skip)"
              set str3 "<true | false>"
              puts $OSTREAM [format "%-*s %-*s %-*s" 0 $str1 65 $str2 14 $str3]

              $posIter->next
            };# end while
          };# end foreach stage
        };# end if elab
      };# end foreach flow
      close $OSTREAM
    };#end else !$myTagsFlag


    set OSTREAM [open $myFileName "a"]
    puts $OSTREAM "##### END Frontend Foundation Flow v$::FFF::fcf_version #####"
    close $OSTREAM
    if {!$myQuietFlag} {
      puts "<FF> Wrote $myFileName"
    }
  }; # end proc write_foundation
}; # end namespace eval FFF

if {![llength [info commands ::write_foundation]]} {
  namespace import ::FFF::write_foundation
  add_command_help write_foundation "Write out a Foundation Configuration File"
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [write_foundation_template.tcl]                               #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {

  namespace export write_foundation_template

  proc write_foundation_template {args} {
    set dbgPrefixWs [string repeat " " [info level]]
    set msgPrefix "${dbgPrefixWs}write_foundation_template():"
    set Debug $::FFF::Debug
    set ::FFF::fcfqc::current_command write_foundation_template
    if {[::FFF::get_tool] ne "lec" } {puts "// Command: [calling_proc] $args"}
    ::FFF::dbg_puts "args: ->$args<-"
    # Variables for Parse Options:
    set myPrefix ""
    set mySuffix ""
    set myDebugSwitch 0
    set myRegexp ""
    set myOverwriteFlag 0
    set myReplaceFlag 0
    set myGzipFlag 0
    set myReadmeFlag 0
    set myDesignScope ""
    set myFlowToWrite ""
    set myStageToWrite ""
    set myNoUpdateFlag 0
    set myTrimWsFlag 0
    set myNoCommentsFlag 0
    set myNoResolveVarsFlag 0
    set myNoMakefileFlag 0
    set myScriptPath ""
    set myRunDir "" 
    set myMakefilePath ""

    # Variables set for internal use by the proc
    set comments_switch ""
    set trim_ws_switch ""
    set replace_switch ""
    set debug_switch "-debug"
    set file_name_switch ""

    if {[array exists ::FFF::elabdb::flow_objid_arr]} {
      array set flow_objid_arr [array get ::FFF::elabdb::flow_objid_arr]
      set elaborated 1
    } else {
      #array set flow_objid_arr [array get ::FFF::flow_objid_arr]
      #set elaborated 0
      puts "write_foundation_template() ERROR: Foundation DB not yet elaborated."
      puts "Foundation DB must first be elaborated using \"elaborate_foundation\" or by not passing the"
      puts "\"-noelab\" argument to read_foundation"
      return 0
    } 

    # Note - if "-edi" is used, and "-config" is not provided, FF will write out he variables
    # in the ::FFF:: namespace; in other words, the default configuration.

    switch -- [parse_options [calling_proc] {} $args \
      "-prefix sos Prefix for all files" myPrefix \
      "-suffix sos Suffix for all files" mySuffix \
      "-debug bos Suffix for all files" myDebugSwitch \
      "-regexp sos Regular expression filter to select specific stages/flows" myRegexp \
      "-overwrite bos Whether to overwrite existing script(s)" myOverwriteFlag \
      "-replace bos Whether to overwrite existing script(s)" myReplaceFlag \
      "-no_namespace bos Do not encapsulate the step commands in their own namespace (not recommended)" myNoNameSpaceFlag \
      "-gzip bos gzip the output file(s)" myGzipFlag \
      "-readme bos Print Readme Information on the Foundation Flow" myReadmeFlag \
      "-scope sos Filter on design scope" myDesignScope \
      "-rundir sos Directory that tool execution will occur in" myRunDir \
      "-flow sos Flow name (if unique) or flow instance path to write" myFlowToWrite \
      "-stage sos Stage name (if unique) or stage instance path to write" myStageToWrite \
      "-makefile sos Makefile path" myMakefilePath \
      "-script sos Script path" myScriptPath \
      "-noupdate bos Do not update Foundation DB prior to writing out the script(s)" myNoUpdateFlag \
      "-nomake bos Do not write a Makefile" myNoMakefileFlag \
      "-trim_ws bos Trim leading whitespace when writing out scripts" myTrimWsFlag \
      "-nocomments bos Do not write out comments in step blocks" myNoCommentsFlag \
      "-no_resolve bos Do not resolve variables (print \$vars(...))" myNoResolveVarsFlag \
      "-noinline bos Do not in-line plugins" myNoInlineFlag \
      ] {
      -2 { return }
      0 { error "Failed on [lindex [info level 0] 0]" }
    }

    if {$myReadmeFlag} {
      puts $::fcf_header::README;
    }

    if {$myDebugSwitch} {
      set debug_switch "-debug"
    } else {
      set debug_switch ""
    }

    if {$myOverwriteFlag || $myReplaceFlag} {
      set replace_switch "-replace"
    } else {
      set replace_switch ""
    }

    if {$myNoCommentsFlag} {
      set comments_switch "-nocomments"
    } else {
      set comments_switch ""
    }

    if {$myNoResolveVarsFlag} {
      set resolve_vars_switch "-no_resolve"
    } else {
      set resolve_vars_switch ""
    }

    set makefile_name_switch ""
    if {$myNoMakefileFlag} {
      set make_switch "-no_make"
    } else {
      set make_switch ""
      if {$myMakefilePath ne ""} {
        set makefile_name_switch "-makefilename $myMakefilePath"
      }
    }

    if {$myTrimWsFlag} {
      set trim_ws_switch "-trim_ws"
    } else {
      set trim_ws_switch ""
    }

    if {$myNoInlineFlag} {
      set noinline_switch "-noinline"
    } else {
      set noinline_switch ""
    }

    if {$myScriptPath ne ""} {
      set file_name_switch "-filename $myScriptPath"
      #
      # If there is no vars(codegen_dir) set, set it now
      #
      set codegen_dir [file dirname [file normalize $myScriptPath]]
      set curCodegenDir [$::FFF::config_objid_list($::FFF::myDefaultConfigName)->get_var_value vars(codegen_dir)]
      set ::FFF::codegen_dir $codegen_dir
    }

    if {$myRunDir ne ""} {
      set rundir_switch "-rundir $myRunDir"
    } else {
      set rundir_switch ""
    }

    # If we didn't specify any argument, just return all flows
    if {![info exists flow_list]} {
      set flow_list [array names flow_objid_arr]
    }
  
    ##nagelfar syntax get_stage
    if {$myScriptPath ne ""} {
      set stageObjID [get_stage -instances -basename $myStageToWrite]
      dbg_puts "StageObjID Found using \[get_stage -instances -basename $myStageToWrite\]: $stageObjID"
      if {$stageObjID ne "-1"} {
        # Hardcode prefix switch for single stage writing:
        set prefix_switch "-prefix \"\""
        if {[catch {$stageObjID->write_script [::FFF::flatten_list [list $noinline_switch $trim_ws_switch $prefix_switch $debug_switch $comments_switch $replace_switch $file_name_switch $resolve_vars_switch $makefile_name_switch $rundir_switch]]} errorMsg]} {
	  ::FFF::dbg_puts -print_stdout "<FF> Error in write_foundation_template()."
	  ::FFF::dbg_puts "$errorMsg"
	  return -code error
	}
      } else {
        puts "write_foundation_template() ERROR: No stage found with name $myStageToWrite"
      }
    } else {
      if {$flow_list ne ""} {
        # Foreach flow in flow_list ...
        foreach flowObjID $flow_list {
          $flowObjID->gen_exe_script [::FFF::flatten_list [list $debug_switch $comments_switch $trim_ws_switch $replace_switch $resolve_vars_switch $make_switch $rundir_switch]]
        }
      } else {
        puts "write_foundation_template() ERROR: No Flows Created"
      }
    }; # end myScriptPath ne ""
  } ; # End proc report_flows()
}; # end namespace eval 

if {![llength [info commands ::write_foundation_template]]} {
  namespace import ::FFF::write_foundation_template
  add_command_help write_foundation_template "Write out script(s) to execute the flow."
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [aliases.tcl]                                                 #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {

  namespace export fff_write_metrics

  proc fff_write_metrics {args} {
    set file ""
    set flow ""
    set stage ""
    
    switch -- [parse_options [calling_proc] {} $args \
      "-flow sos flow name" flow \
      "-stage sos stage name" stage \
      "-design sos design name" design \
      "-file sos file name" outputFile \
    ] {
      -2 { return }
      0  { error "Failed on [lindex [info level 0] 0]" }
    }

    ##nagelfar syntax GetSeqCount
    ##nagelfar syntax GetComboCount
    ##nagelfar syntax GetLatchCount
    ##nagelfar syntax GetFFCount
    ##nagelfar syntax GetBufferCount
    ##nagelfar syntax GetInvCount
    ##nagelfar syntax GetTotalPower
    ##nagelfar syntax GetDynamicPower
    ##nagelfar syntax GetCGCount

    # RC Metrics Procs (from generate_report):
    proc GetSeqCount { obj } {
        return [llength [find $obj -instance instances_seq/*]]
    }
    
    proc GetComboCount { obj } {
        return [llength [find $obj -instance instances_comb/*]]
    }
    
    proc GetLatchCount { obj } {
        return [llength [filter latch true [find $obj -instance instances_comb/*]]]
    }
    
    proc GetFFCount { obj } {
        return [llength [filter flop true [find $obj -instance instances_seq/*]]]
    }
    
    proc GetBufferCount { obj } {
        return [llength [filter buffer true [find $obj -instance instances_comb/*]]]
    }
    
    proc GetInvCount { obj } {
        return [llength [filter inverter true [find $obj -instance instances_comb/*]]]
    }
    
    proc GetCGCount { obj } {
        # Need to handle library domains as well as library attribute
        if {[llength [find /libraries -library_domain *]]} {
            set libRoot [lindex [find /libraries -library_domain *] 0]
        } else {
            set libRoot /libraries
        }
        set cgInfo [join [filter -regexp clock_gating_integrated_cell {\w} [find ${libRoot} -libcell *]] |]
        return [llength [filter -regexp libcell "(${cgInfo})" [find $obj -instance instances_seq/*]]]
    }
  
    proc GetTotalPower { obj } {
        return [format "%.2f" [expr {[get_attribute lp_leakage_power $obj] + [get_attribute lp_internal_power $obj] + [get_attribute lp_net_power $obj]}]]
    }
  
    proc GetDynamicPower { obj } {
        return [format "%.2f" [expr {[get_attribute lp_internal_power $obj] + [get_attribute lp_net_power $obj]}]]
    }
   
    # Metrics Array
   
    set metrics(total_area) [get_attribute area /designs/$design]
    set metrics_units(total_area) "um^2"
    set metrics(cell_area) [get_attribute cell_area /designs/$design]
    set metrics_units(cell_area) "um^2"
    set metrics(net_area) [get_attribute net_area /designs/$design]
    set metrics_units(net_area) "um^2"
    set metrics(cell_count) [get_attribute cell_count /designs/$design]
    set metrics_units(cell_count) "int"
    set metrics(seq_cell_count) [GetSeqCount /designs/$design]
    set metrics_units(seq_cell_count) "int"
    #set metrics(register_count) [llength [find /designs/$design -instance instances_seq/*reg*]]
    # assume icg prefix is RC_CG (does not support pre-instantiated icgs yet)
    #set metrics(icg_count) [llength [find /designs/mult -instance instances_seq/*RC_CG*]]
    #set metrics(icg_count) [$::ns(genrpt)::GetCGCount /designs/$design]
    set metrics(icg_count) [GetCGCount /designs/$design]
    set metrics_units(icg_count) "int"
    
    #set metrics(combo_cell_count) [llength [find /designs/mult -instance instances_comb/*]] 
    set metrics(combo_cell_count) [GetComboCount /designs/$design]
    set metrics_units(combo_cell_count) "int"
    set metrics(latch_cell_count) [GetLatchCount /designs/$design]
    set metrics_units(latch_cell_count) "int"
    set metrics(flip_flop_count) [GetFFCount /designs/$design]
    set metrics_units(flip_flop_count) "int"
    set metrics(buf_count) [GetBufferCount /designs/$design]
    set metrics_units(buf_count) "int"
    set metrics(inv_count) [GetInvCount /designs/$design]
    set metrics_units(inv_count) "int"
    
    # For optimized flops
    # report sequential -deleted_seqs
    # load the rport, count the instnaces, then set the value
    #set metrics(deleted_seqs)
  
    set metrics(tns) [get_attribute tns /designs/$design]
    set metrics_units(tns) "ps"
    set metrics(wns) [get_attribute slack /designs/$design]
    set metrics_units(wns) "ps"
    set metrics(leakage_power) [get_attribute lp_leakage_power /designs/$design]
    set metrics_units(leakage_power) "nW"
    set metrics(internal_power) [get_attribute lp_internal_power /designs/$design]
    set metrics_units(internal_power) "nW"
    set metrics(net_power) [get_attribute lp_net_power /designs/$design]
    set metrics_units(net_power) "nW"
    #set metrics(total_power) [expr {$metrics(leakage_power) + $metrics(internal_power) + $metrics(net_power)}]
    set metrics(total_power) [GetTotalPower /designs/$design]
    set metrics_units(total_power) "nW"
    set metrics(dynamic_power) [GetDynamicPower /designs/$design]
    set metrics_units(dynamic_power) "nW"
    
    # For RCP flows only:
    if {[::FFF::get_tool] eq "rc"} {
      if {[get_attribute gui_enabled /]} { 
        catch {set graphic [get_attribute gui_pv_placement_snapshot]}
        if {[file isfile $graphic]} {
          set metrics(layout_snapshot) "[file normalize $graphic]"
          set metrics_units(layout_snapshot) "n/a"
        }
      }
    }
    
    #Datapath report (report datapath > design_datapath.txt)
    #Timing Report (report timing design_timing.txt)
    #Gates Report (report gates design_gates.txt)
    #Area Report (report area design_area.txt)
    #Power Report (report power design_power.txt)
    #Clock Gating Report (report clock_gating design_clock_gated.txt) 
  
    if {[file exists $outputFile]} {
      puts "<FF> Overwriting file $outputFile"
    } else {
      puts "<FF> Writing metrics output: $outputFile"
    }
    set OST [open $outputFile w]
    #
    # Header
    #
    puts $OST "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>"
   
  
    puts $OST "<qor_report>"
    puts $OST "  <flow name='$flow'>"
    puts $OST "    <stage name='$stage'>"
  
    # 
    # Body
    #
  
    foreach metricName [array names metrics] {
      puts $OST "      <$metricName units='$metrics_units($metricName)'>$metrics($metricName)</$metricName>"
    } 
  
    #
    # Tail
    #
    puts $OST "    </stage>"
    puts $OST "  </flow>"
    puts $OST "</qor_report>"
  
    # End
    close $OST
    return ""
  }

  #<qor_report>
  # <default_synth>
  #   <syn_map>
  #      <name>syn2gen</name>
  #      <worst_slack>-55</worst_slack>
  #      <worst_slack_units>ps</worst_slack>
  #      <total_slack>-1042</total_slack>
  #      <total_slack_units>ps</total_slack>
  #      <area>75435.0</area>
  #      <area_units>um^2</area>
  #      <power>512961198.9</power>
  #      <power>nW</power>
  #   </syn_map>
  #   <syn_incr>
  #      <name>syn2gen</name>
  #      <worst_slack>-55</worst_slack>
  #      <total_slack>-1042</total_slack>
  #      <area>75435.0</area>
  #      <power>512961198.9</power>
  #   </syn_incr>
  #   <syn_placed>
  #      <name>syn2gen</name>
  #      <worst_slack>-55</worst_slack>
  #      <total_slack>-1042</total_slack>
  #      <area>75435.0</area>
  #      <power>512961198.9</power>
  #   </syn_placed>
  # </default_synth>
  #</qor_report>
  #   <reports>
  #      <name>datapath file=run_dir/REPORTS/datapath.txt</name>
  #   </reports>
  #</qor_report>
}

if {![llength [info commands ::fff_write_metrics]]} {
  namespace import ::FFF::fff_write_metrics
  add_command_help fff_write_metrics "Write out script(s) to execute the flow."
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [aliases.tcl]                                                 #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {
  proc source_plug {args} {
    switch -- [parse_options [calling_proc] {} $args \
      "-plugdir sos Plug-in directory" myPlugdir \
      "srs plugin" plugin \
    ] {
      -2 { return }
      0  { error "Failed on [lindex [info level 0] 0]" }
    }

    puts "<FF> INFO: Checking for plugin: \"$plugin\""

    # Logic
    # If variable exists, first check for file, then check for command
    #  else
    # if plugdir exists, 
    global vars

    # Look for plugin name matching pattern <name>_tcl
    set myPlugName_minus_tcl ""
    catch {regexp {(.*)_tcl$} $plugin full myPlugName_minus_tcl}
    #
    # vars($plugin) has precedence. Only use $myPlugName_minus_tcl if $vars($plugin) is not a proc
    #
    if {![info exists vars($plugin)]} {
      if {[info exists vars($myPlugName_minus_tcl)]} {
        puts "<FF> INFO: vars($plugin) was not defined but vars($myPlugName_minus_tcl) was."
        puts "<FF>       Will use vars($myPlugName_minus_tcl) in this flow, but please change your plugin name to $plugin."
        set plugin $myPlugName_minus_tcl
      }
    }

    #
    # check for plugin existence
    #
    if {[info exists vars($plugin)]} {
      puts "<FF> INFO: Detecting whether plugin $plugin is a file or proc (file has precedence) "
      if {![file isfile [subst $vars($plugin)]]} {
        # File doesn't exist. Check if it's a proc
        if {[info commands $vars($plugin)] ne ""} {
          puts "<FF> INFO: Resolved Plugin as the proc: $vars($plugin). Executing ..."
          #
          # Define commands to execute (extract from proc body)
          #
	  set ::FFF::source_plug_proc_body_commands_to_eval [info body $vars($plugin)]
          #
          # Define plug name
          #
	  set ::FFF::source_plug_name $plugin

          #
          # Execute commands in global namespace
          #
	  namespace eval :: {
	    if {[catch {eval $::FFF::source_plug_proc_body_commands_to_eval} errorMsg]} {
              error "<FF> ERROR in plugin: $::FFF::source_plug_name\n$errorMsg"
            } else {
              #
              # time stamp
              #
	      if {[info commands time_info] ne ""} {time_info -quiet -table ff_int -stamp "$::FFF::source_plug_name (plugin)"}
	      #catch {time_info -quiet -table ff_int -stamp "$::FFF::source_plug_name (plugin)"}
              #
              # return "eval" indicating that source_plug evaluated a command (instead of sourced a file)
	      return "eval"
	    }
          }
        } else {
	  # not a proc
	  # check if halt variable is set.
          if {$vars(require_all_defined_plugins)} {
            puts "<FF> ERROR: defined plugin \"$plugin\" resolved to $vars($plugin) does not exist as a file or proc." 
            puts "<FF>        and vars(require_all_defined_plugins) was set to 'true'"
            puts "<FF>        Please set the variable for this plugin so that it points to the correct file or procedure."
	    if {[::FFF::get_tool] eq "rc"} {
              puts "<FF>        Suspending the RC session for interactive debug..."
              suspend
              puts "<FF>        Resuming the RC session (note - will not attempt to re-execute source_plugin on $vars($plugin))"
            } elseif {[::FFF::get_tool] eq "lec"} {
              puts "<FF>        Suspending the Conformal session for interactive debug..."
              ##nagelfar syntax vpx
              ##nagelfar syntax tclmode
	      vpx break
	      tclmode
              puts "<FF>        Resuming the Conformal session (note - will not attempt to re-execute source_plugin on $vars($plugin))"
	    } else {
              puts "<FF>        Exiting ..."
	      exit 99
            }
          } elseif {[file isfile $myPlugdir/[file tail [subst $vars($plugin)]]]} {
	    # message to user that plugin was found
            set RelPathToPlugin [::FFF::relPathTo [file normalize $myPlugdir/[file tail [subst $vars($plugin)]]] [file normalize .]]
            puts "<FF> INFO: Resolved Plugin as the file: $RelPathToPlugin. Executing plugin ..."
            if {[catch {uplevel #0 source $RelPathToPlugin} errorMsg]} {
              error "<FF> ERROR in plugin: $plugin\n$RelPathToPlugin\n$errorMsg"
            } else {
	      ##nagelfar syntax time_info
	      if {[info commands time_info] ne ""} {time_info -quiet -table ff_int -stamp "$plugin (plugin)"}
              # return "source" indicating that source_plug sourced a file
              return "source"
            }
            # Not a hard requirement to be defined, so check the plugdir
          } else {
            puts "<FF> WARNING: defined plugin \"$plugin\" does not exist as a file or proc, and could not find [file tail $vars($plugin)] in $myPlugdir. Skipping plugin..."
            puts "<FF>          To make this an error, set vars(require_all_defined_plugins) to 'true'"
          }
          return ""
        }
      } else {
        # Plugin is a file
        #puts "INFO: Saving temporary database $vars(tmp_dir)/tmp.db which can be used to restore to this point"
        #write_db -all_root_attributes -to_file $vars(tmp_dir)/tmp.db
        ##nagelfar ignore
        set RelPathToPlugin [::FFF::relPathTo [file normalize [subst $vars($plugin)]] [file normalize .]]
        puts "<FF> INFO: Resolved Plugin as the file: $RelPathToPlugin. Executing plugin ..."
        #
        # Source file in global namespace
        #
        if {[catch {uplevel #0 source [subst $vars($plugin)]} errorMsg]} {
          error "<FF> ERROR in plugin: $plugin\n[file normalize [subst $vars($plugin)]]\n$errorMsg"
        } else {
          #
          # time stamp
          #
	  ##nagelfar syntax time_info
	  if {[info commands time_info] ne ""} {time_info -quiet -table ff_int -stamp "$plugin (plugin)"}
          #catch {time_info -quiet -table ff_int -stamp "$plugin (plugin)"}
          #
          # return "source" indicating that source_plug sourced a file
          return "source"
        }
      }
    } elseif {[info exists myPlugdir] && [file isdirectory $myPlugdir]} {
      # No variables defined. Search plug dir (if provided) for matching plugins
      # Note: ${plugin}.tcl has precedence over ${myPlugName_minus_tcl}.tcl
      # i.e., post_syn_placed_tcl.tcl has precedence over post_syn_placed.tcl
      # (this decision was arbitrary)
      if {![file exists $myPlugdir/${plugin}.tcl] && ![file exists $myPlugdir/${myPlugName_minus_tcl}.tcl]} {
        puts "<FF> INFO: No plugins found in plug_dir: \"$myPlugdir\" matching $plugin. Skipping this plugin..."
      } elseif {![file exists $myPlugdir/${plugin}.tcl] && [file exists $myPlugdir/${myPlugName_minus_tcl}.tcl]} {
        set plugin $myPlugName_minus_tcl
      } elseif {[file exists $myPlugdir/${plugin}.tcl] && [file exists $myPlugdir/${myPlugName_minus_tcl}.tcl]} {
        puts "<FF> WARNING: Both ${plugin}.tcl and ${myPlugName_minus_tcl}.tcl found in $myPlugdir."
        puts "<FF>          ${plugin}.tcl has precedence and will be used."
        puts "<FF>          To avoid confusion, one of these plugins should be removed."
      }
      if {[file exists $myPlugdir/${plugin}.tcl]} {
        puts "<FF> INFO: Found  plugin: \"${plugin}.tcl\" in plug_dir: \"$myPlugdir\". Executing plugin ..."
        if {[catch {uplevel #0 source $myPlugdir/${plugin}.tcl} errorMsg]} {
          error "<FF> ERROR in plugin: $plugin\n[file normalize $myPlugdir/${plugin}.tcl]\n$errorMsg"
        } else {
	  if {[info commands time_info] ne ""} {time_info -quiet -table ff_int -stamp "$plugin (plugin)"}
          return "source"
        }
      }
    } else {
      return ""
    }
  }
};#end namespace eval
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName   : adjustClockPeriod.tcl
#  Description: 							     #
#  Summary    : Adjust the period of all clocks by a scale factor            #
#  Author     : Buda Leung / Cadence FED Product Core Team                   #
#  Date       : 01-11-2011                                                   #
##############################################################################
namespace eval FFF {
  proc adjust_clock_period {clock_period_scale_factor} {
    suppress_messages {TIM-304}
    # Create a fake proc inorder to properly parse the create_clock command
    global vars
    puts "INFO: Executing adjust_clock_period"
    puts "INFO: All clock periods will be multiplied by $clock_period_scale_factor"
  
    set create_clock_count 0
    set set_max_transition_count 0
  
    set allClocks [find / -clock *]
    set clockNameList ""
    set started 0
    foreach clock $allClocks {
      set clockName [basename $clock]
      if {[info exists ${clockName}(report_clocks)]} {
        unset ${clockName}(report_clocks)
      }
      set clockPort ""
      puts "Analyzing clock: $clockName"
      redirect -variable ${clockName}(report_clocks) {report clocks $clock}
      set junk [split [set ${clockName}(report_clocks)] "\n"]
      foreach line $junk {
        if {[regexp {Clock Description} $line]} {
          set started 1
        }
        if {[regexp {Clock Network Latency} $line]} {
          set started 0
        }
        if {$started} {
          #puts "ORIG: ->$line<-"
          if {[regexp {(\w+)\s+(\w+)\s+([0-9.]+)\s+([0-9.]+)\s+([0-9.]+)\s+(\w+)\s+([A-Za-z_])(\w*).*} $line full mode clockName oldPeriod oldRise oldFall clockDomain clockPortp1 clockPortp2]} {
  	  #puts "Mode: $mode Clock: $clockName $oldPeriod $oldRise -> $oldFall Domain: $clockDomain Port: $clockPort"
  	  set clockPort $clockPortp1$clockPortp2
          } elseif {[regexp {(\w+)\s+(\w+)\s+([0-9.]+)\s+([0-9.]+)\s+([0-9.]+)\s+(\w+).*} $line full mode clockName oldPeriod oldRise oldFall clockDomain]} {
  	  #puts "Mode: $mode Clock: $clockName $oldPeriod $oldRise -> $oldFall Domain: $clockDomain"
          }
        }
      }
  
      if {$clockPort ne ""} {
        puts "  Detected current clock definition: create_clock -name $clockName -period $oldPeriod -rise $oldRise -fall $oldFall $clockPort"
        set adjclock($mode,$clockName,clockPort) $clockPort
      } else {
        puts "  Detected current clock definition: create_clock -name $clockName -period $oldPeriod -rise $oldRise -fall $oldFall"
      }
  
      set adjclock($mode,$clockName,period) [expr {$oldPeriod * $clock_period_scale_factor}]
      set adjclock($mode,$clockName,rise) [expr {$oldRise * $clock_period_scale_factor}]
      set adjclock($mode,$clockName,fall) [expr {$oldFall * $clock_period_scale_factor}]
      lappend clockNameList $clockName
    }
    set clockNameList [lsort -unique $clockNameList]
  
    set newSDC rc.adjust_clock_period.mode_${mode}.tmpadj[pid].sdc
    set OST [open $vars(tmp_dir)/$newSDC w]
    puts $OST "# SDC created by adjust_clock_period on [clock format [clock seconds] -format "%I:%M:%S %p(%b%d)"]"
  
    foreach mode [basename [find -mode *]] {
      foreach clockName $clockNameList {
        if {[info exists adjclock($mode,$clockName,clockPort)] && $adjclock($mode,$clockName,clockPort) ne ""} {
        puts $OST "create_clock -name $clockName -period $adjclock($mode,$clockName,period) \
  	-waveform \{$adjclock($mode,$clockName,rise) $adjclock($mode,$clockName,fall)\} $adjclock($mode,$clockName,clockPort)"
        } else {
        puts $OST "create_clock -name $clockName -period $adjclock($mode,$clockName,period) \
  	-waveform \{$adjclock($mode,$clockName,rise) $adjclock($mode,$clockName,fall)\}"
        }
        incr create_clock_count
        puts $OST "puts \"adjust_clock_period() NOTE: Adjusting clock period for $clockName to $adjclock($mode,$clockName,period)\""
      }
    }
  
    # Write out the current constraints
    close $OST
    if {$create_clock_count > 0} {
      puts "INFO: adjust_clock_period() $create_clock_count adjusted clock definition(s)"
    }
    #if {$set_max_transition_count > 0} {
    #  puts "$set_max_transition_count adjusted set_max_transition definition(s)"
    #}
    # Source the new SDC
    puts "INFO: Reading adjusted SDC clock commands"
    catch {read_sdc -mode $mode $vars(tmp_dir)/$newSDC}
    #catch {rm -rf $origSDC}
    #catch {rm -rf $newSDC}
  
    puts "INFO: Finished executing adjust_clock_period"
  }
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [aliases.tcl]                                                 #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {
  proc create_ClockGateEnables_path_group {} {
    puts " \n ---------------------Defining cost_group ClockGateEnables----------------------------------------- \n "
    set_attribute source_verbose true /
    define_cost_group -name  ClockGateEnables
    foreach rm_mode [find -mode *] {
      if {[find /designs/* -pin RC_CGIC_INST/E] ne ""} {
        path_group -mode $rm_mode  -to [find /designs/* -pin RC_CGIC_INST/E] -group ClockGateEnables -name clock_gating_enables
      }
    }
    set_attribute source_verbose false /
  }
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [aliases.tcl]                                                 #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {
  proc remove_timing_constraints_except_clock {} {
    puts "Removing external delays"
    catch {rm /designs/*/modes/*/external_delays/*}
    puts "Removing all timing exceptions"
    catch {rm /designs/*/modes/*/exceptions/*/*}
  }
};# end namespace eval FFF
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [aliases.tcl]                                                 #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {
  proc check_min_tool_version {args} {

    # args are of the form YY.SS.DDD
    # where YY is the year (10, 11, 12, etc.)
    # SS is the minor subYear version (10, 11)
    # DDD is the minor release (300, 331)
    regexp {([\d]{2})\.([\d]{2}).*([\d]{3}).*} $args full yearMinRel yearMinSubRel minorMinRel

    set tool_version [::FFF::get_tool_version]
    if {[::FFF::get_tool] eq "rc"} { 
      if {[regexp {.*([\d]{2})\.([\d]{2}).*([\d]{3}).*} $tool_version full yearRel yearSubRel minorRel]} {
        if {$yearRel < $yearMinRel} {
          puts "<FF> ERROR: RC Version Requirement Failure. Required version is: $yearMinRel.$yearMinSubRel.$minorMinRel; tool version is: $yearRel.$yearSubRel.$minorRel"
          exit -1
        } elseif {$yearRel == $yearMinRel && $yearSubRel < $yearMinSubRel} {
          puts "<FF> ERROR: RC Version Requirement Failure. Required version is: $yearMinRel.$yearMinSubRel.$minorMinRel; tool version is: $yearRel.$yearSubRel.$minorRel"
          exit -1
        } elseif {$yearRel == $yearMinRel && $yearSubRel == $yearMinSubRel && $minorRel < $minorMinRel} {
          puts "<FF> ERROR: RC Version Requirement Failure. Required version is: $yearMinRel.$yearMinSubRel.$minorMinRel; tool version is: $yearRel.$yearSubRel.$minorRel"
          exit -1
        } else {
        puts "<FF> INFO: RC Minimum version check passed. Min required version of [::FFF::get_tool]: $yearMinRel.$yearMinSubRel.$minorMinRel; current tool version is: $yearRel.$yearSubRel.$minorRel"
        }
      } else {
        puts "<FF> INT-WARNING: Unable to check required version ($args) against [::FFF::get_tool] version ($tool_version). This flow may not execute properly."
      }
    } else {
        puts "<FF> ERROR: check_min_tool_version does not yet support tool [::FFF::get_tool] version [::FFF::get_tool_version]"
    }
  }
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [aliases.tcl]                                                 #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {
  proc check_min_applet_version {args} {

    set defAppletNS "::applet"
    set defSeverity "error"

    switch -- [parse_options [calling_proc] {} $args \
      "-applet srs name of applet" appletName        \
      "-version srs required version of applet (equal or greater)" reqAppletVersion \
      "-severity sos severity (error|warning|info)" severity \
      "-namespace sos namespace to search for applet" appletNS] {
          -2 { return }
          0 { return -code error }
    }

    if {$appletNS eq ""} {
        set appletNS $defAppletNS
        puts "<FF> INFO check_min_applet_version(): Set Applet namespace to $appletNS"
    }

    if {$severity eq ""} {
      set severity $defSeverity
    }
      
    if {[catch {set providedVersion [package present ${appletNS}::$appletName]} errorMessage]} {
      puts "<FF> ERROR check_min_applet_version():  Applet $appletName was not found in namespace ${appletNS}"
      puts "<FF>       Please check that the applet was loaded correctly."
      puts "<FF>       Note current applet_search_path: [get_attribute applet_search_path]"
      switch -exact -- $severity {
	error   { puts "<FF> Exiting ...";exit 99 }
	warning { puts "<FF> Applet $appletName skipped. Problems may occur with this flow. It is advised that the $appletName applet be loaded correctly." }
	info    { puts "<FF> Applet $appletName version check skipped due to severity level \"info\"" }
      }
    } else {
      if {[package vcompare $providedVersion $reqAppletVersion] == -1} {
        switch -exact -- $severity {
          error {
            puts "<FF> ERROR check_min_applet_version(): Minimum applet version for applet $appletName is $reqAppletVersion, but provided applet version is $providedVersion."
            puts "<FF>       Check that the apple was loaded from the correct location." 
            puts "<FF>       Note current applet_search_path: [get_attribute applet_search_path]"
            puts "<FF>       Exiting due to severity level of \"error\" for check_min_applet_version()... "
	    exit 99
          }
          warning {
            puts "<FF> WARNING check_min_applet_version(): Minimum applet version for applet $appletName is $reqAppletVersion, but provided applet version is $providedVersion."
            puts "<FF>       Check that the apple was loaded from the correct location." 
            puts "<FF>       Note current applet_search_path: [get_attribute applet_search_path]"
          }
          info {
            puts "<FF> INFO check_min_applet_version(): Minimum applet version for applet $appletName is $reqAppletVersion, but provided applet version is $providedVersion."
            puts "<FF>       Check that the apple was loaded from the correct location." 
            puts "<FF>       Note current applet_search_path: [get_attribute applet_search_path]"
          }
        }
      } else {
        puts "<FF> INFO check_min_applet_version(): Minimum applet version check PASSED for $appletName (Required Ver: $reqAppletVersion, Provided Ver: $providedVersion)"
      }
    }
  }
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [aliases.tcl]                                                 #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {
  namespace export load_applet
  proc load_applet {args} {
    set defAppletNS "::applet"
    set defSeverity "error"
    set defaultLocalInstall $::ns(applet)::localInstall
    set defaultLocalServer $::ns(applet)::localServer
    set reqAppletVersion ""

    switch -- [parse_options [calling_proc] {} $args \
      "-version sos required version of applet (equal or greater)" reqAppletVersion \
      "-severity sos severity (error|warning|info)" severity \
      "-namespace sos namespace to search for applet" appletNS \
      "srs name of applet" appletName] {
          -2 { return }
          0 { return -code error }
    }

    if {$appletNS eq ""} {
        set appletNS $defAppletNS
    }

    if {$severity eq ""} {
      set severity $defSeverity
    }
   
    # Check to see if the applet happened to already be loaded. If so, check
    # whether there is a minimum version requirement met. If yes, skip the rest of the applet
    # If the applet already does not meet the minimum version requirement, unload it (using package forget)
    if {![catch {set providedVersion [package present ${appletNS}::$appletName]} errorMessage]} {
      if {$reqAppletVersion ne ""} {
        if {[package vcompare $providedVersion $reqAppletVersion] == -1} {
          puts "load_applet INFO: applet $appletName was already loaded, but it's version ($providedVersion) did not meet the minimum required version ($reqAppletVersion)"
          puts "load_applet INFO: This version of the $appletName applet will be removed and the load_applet will search for a newer version of $appletName..."
          package forget ${appletNS}::$appletName
        } else {
	  puts "load_applet INFO: Found $appletName already loaded and it's version ($providedVersion) already meets the minimum required version ($reqAppletVersion). Skipping load..."
	  return
        }
      } else {
	puts "load_applet INFO: Found $appletName already loaded with version ($providedVersion). Skipping applet load..."
	return
      }
    }

    # There is no previously loaded applet. Continue with this proc...
    set FoundMinVersionPath 0
    set finalSearchPath "" 
    set appletSearchPathCount [llength [get_attribute applet_search_path /]]
    set origappletSearchPathCount $appletSearchPathCount
    set origSearchPath ""
    set failedPaths ""
    # First pass: determine which applet installations meet min required version, if any
    # This for loop does not load the applets, it only determines a final search path to use
    # If none of the search paths contain the minimum version, and severity code is error, this proc
    # will return inside this foreach loop with code error
    if {$appletSearchPathCount > 1} {
      puts "load_applet INFO: Checking all applet search paths for versions of $appletName"
    }
    foreach pathComponent [get_attribute applet_search_path /] {
      incr appletSearchPathCount -1
      if {$origappletSearchPathCount > 1} {
        puts -nonewline "  $pathComponent ..."
      } else {
        puts -nonewline "load_applet INFO: Checking applet_search_path: $pathComponent ..."
      }
      # If the path component is <default> replace with the applet designated search path value using "UpdateSeachPath"
      if {[string match "<default>" $pathComponent]} {
        set pathComponent [$::ns(applet)::UpdateSearchPath $pathComponent]
      }
      lappend origSearchPath $pathComponent
      if {[file isdirectory $pathComponent]} {
	if {[file isfile $pathComponent/.servInfo]} {
	  if {[get_tool] eq "rc"} {
            set sourceCommand tcl_source
	  } else {
	    set sourceCommand source
	  }
	  set errorMsg ""
	  array unset appInfo
	  if {[catch {$sourceCommand $pathComponent/.servInfo} errorMsg] || ![info exists appInfo(${appletNS}::${appletName},version)]} {
	    if {$errorMsg ne ""} {
	      puts " $errorMsg"
	    } else {
	      puts " BAD APPLET SERVER (corrupted .servInfo file)"
	    }
          } else {
	    if {$reqAppletVersion eq "" } {
	      lappend minVersionSearchPath $pathComponent  
	      set FoundMinVersionPath 1
	    } elseif {[package vcompare $appInfo(${appletNS}::${appletName},version) $reqAppletVersion] != -1} {
	        lappend minVersionSearchPath $pathComponent  
	        set FoundMinVersionPath 1
 	    } else {
	      lappend failedPaths $pathComponent
	      set failedPathver($pathComponent) $appInfo(${appletNS}::${appletName},version)
	    }
	    puts " Found $appInfo(${appletNS}::${appletName},version)"
          }
	} else {
	  puts " BAD APPLET INSTALL"
        }
      } else {
	puts "  NONEXISTENT APPLET SERVER"
      }
    };# end first foreach loop (distilling final minimum version applet_search_path

    # Second pass: attempt to load applet in each valid search_path until a successful applet load occurs
    # This for loop must lead to a successful outcome (loaded applet) or an error will be issued
    if {$FoundMinVersionPath} {
      foreach searchPath $minVersionSearchPath {
        set_attribute -quiet applet_search_path $searchPath
        if {[catch {applet load $appletName} errorMsg]} {
          puts "load_applet INFO: Version check passed on applet install $appletName but applet load failed."
          if {$appletSearchPathCount > 0} {
            puts "load_applet: Trying next applet_search_path..."
          } else {
            puts "load_applet: ERROR: Failed to load applet $appletName. Please check your applet_search_path and applet installation(s)."
	    set_attribute -quiet applet_search_path $origSearchPath
            return -code error
          }
        } else {
	  if {[catch {set providedVersion [package present ${appletNS}::$appletName]} errorMessage]} {
            puts "load_applet: ERROR: applet $appletName loaded correctly, but the applet did not correctly provide a package version. Trying next search path..."
	  } else {
            puts "load_applet: INFO: Applet $appletName $providedVersion successfully loaded from applet installation at $pathComponent, meeting min version requirement ($reqAppletVersion)"
	    set_attribute -quiet applet_search_path $origSearchPath
	    return
	  }
        }
      }
    } else {
      # Didn't find any searchy paths with minimum applet installed.
      switch -exact -- $severity {
        error {
          puts "load_applet ERROR: Minimum applet version for applet $appletName is $reqAppletVersion, but no applet was found meeting this requirement."
	}
        warning {
          puts "load_applet WARNING: Minimum applet version for applet $appletName is $reqAppletVersion, but no applet was found meeting this requirement."
	}
        info {
          puts "load_applet INFO: Minimum applet version for applet $appletName is $reqAppletVersion, but no applet was found meeting this requirement."
	}
      }
      puts "load_applet INFO: Search results:"
      foreach searchPath $failedPaths {
        puts "  applet_search_path: $searchPath, $appletName version found: $failedPathver($searchPath)"
      }
      puts "load_applet INFO: Note applet search path that was set:"
      puts "  $origSearchPath" 
      switch -exact -- $severity {
        error {
	  set_attribute -quiet applet_search_path $origSearchPath
          return -code 99
        }
      }
    }
    set_attribute -quiet applet_search_path $origSearchPath
  }
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [aliases.tcl]                                                 #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {
  proc report_uptime {args} {
    set externalFlag 0
    set initFlag 0
    set stepName ""
    switch -- [parse_options [calling_proc] {} $args \
      "-step sos name of step" stepName        \
      "-init bos initialize the file" initFlag \
      "-ext bos print to std out" externalFlag \
      "-file srs Filename to write to" file] {
          -2 { return }
          0 { return -code error }
    }

    # File header, host stats
    if {$initFlag} {
      set OST [open "$file" w]
      puts $OST "############################################################"
      puts $OST "# Foundation Flow Uptime Report                            #"
      puts $OST "############################################################"
      puts $OST ""
      close $OST

      if {[file exists /proc/cpuinfo] && ![catch {exec which egrep}]} {
        exec egrep "model|MHz" /proc/cpuinfo | egrep "cpu|name" >> $file
      }

      if {![catch {exec which uptime}] && [file exists /proc/cpuinfo] && ![catch {exec which egrep}] && [file exists /proc/meminfo]} {
        set OST [open "$file" "a+"]
        puts $OST ""
        puts $OST "2. Uptime Profile"
        puts $OST ""
        puts $OST "
  Time              |    Uptime       |   Users   |    Load Average    |     Memory     |        Stage
--------------------+-----------------+-----------+--------------------+----------------+----------------------"
        close $OST
      }
    }

    # date/time
    set dateID [clock format [clock seconds] -format "%I_%M_%S_%p_%b%d"]
    set dateFormatted [clock format [clock seconds] -format "%I:%M:%S %p(%b%d)"]
    set date($dateID) "$dateFormatted"

    # Default Entries (insure that these variables are resolved
    set uptimeNum($dateID) "n/a"
    set uptimeUnits($dateID) "n/a"
    set numUsers($dateID) "n/a"
    set loadAvg($dateID) "n/a"
    set memory($dateID) "n/a"
    set memoryUnits($dateID) "n/a"

    #hostname
    set host [info hostname]

    # Get Memory usage
    if {![catch {exec which egrep}] && [file exists /proc/meminfo]} {
      set retStatus [catch {set pipe [open "|egrep MemTotal /proc/meminfo" "r"]}]
      while {![eof $pipe]} {
        gets $pipe line
        if {[regexp {MemTotal:\s*(\d+)\s+(\w+)} $line full memory($dateID) memoryUnits($dateID)]} {
          if {$externalFlag} {
            puts "<FF> Memory: $memory($dateID) $memoryUnits($dateID)"
          }
        } 
      }
      close $pipe
    }

    if {![catch {exec which uptime}] && ![catch {exec which egrep}]} {
      # Get uptime stats
      set retStatus [catch {set pipe [open "|uptime" "r"]}]
      while {![eof $pipe]} {
        gets $pipe line
        if {[regexp {\s*\S+\s+up\s+(\d+)\s+(\w+)\s+.*\s+(\d+) user.*,.*load average:(.*)} $line full uptimeNum($dateID) uptimeUnits($dateID) numUsers($dateID) loadAvg($dateID)]} {
          if {$externalFlag} {
            puts "<FF> Uptime: $uptimeNum($dateID) $uptimeUnits($dateID)"
            puts "<FF> Users: $numUsers($dateID)"
            puts "<FF> Load: $loadAvg($dateID)"
          }
        } elseif {[regexp {\s*\S+\s+up\s+(\d+)\s+(\w+),.*,\s+(\d+) user.*,.*load average:(.*)} $line full uptimeNum($dateID) uptimeUnits($dateID) numUsers($dateID) loadAvg($dateID)]} {
          if {$externalFlag} {
            puts "<FF> Uptime: $uptimeNum($dateID) $uptimeUnits($dateID)"
            puts "<FF> Users: $numUsers($dateID)"
            puts "<FF> Load: $loadAvg($dateID)"
          }
        }
      }
      close $pipe

      # Print results to file
      set OST [open "$file" "a+"]
      puts $OST [format "%19s | %15s | %9s | %18s | %14s | %20s"   \
                            $date($dateID) "$uptimeNum($dateID) $uptimeUnits($dateID)" $numUsers($dateID) $loadAvg($dateID) "$memory($dateID) $memoryUnits($dateID)" $stepName]
                  puts $OST "--------------------+-----------------+-----------+--------------------+----------------+----------------------"
      close $OST
      return ""
    }
  }
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [aliases.tcl]                                                 #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {
  proc fff_get_default_rc_corner {} {
    global vars
    if {[info exists vars(default_setup_view)]} {
      if {[info exists vars($vars(default_setup_view),delay_corner)]} {
        if {[info exists vars($vars($vars(default_setup_view),delay_corner),rc_corner)]} {
          return $vars($vars($vars(default_setup_view),delay_corner),rc_corner)
        } else {
           return -1
        }
      } else {
        return -1
      }
    } else {
      return -1
    }
  }
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [aliases.tcl]                                                 #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {
  proc fff_get_default_constraint_mode {} {
    global vars
    if {[info exists vars(default_setup_view)]} {
      if {[info exists vars($vars(default_setup_view),constraint_mode)]} {
        return $vars($vars(default_setup_view),constraint_mode)
      } else {
        return -1
      }
    } else {
      return -1
    }
  }
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [aliases.tcl]                                                 #
#  Description: 							     #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @							     #
#  Date        [01-11-2011]                                                  #
##############################################################################
namespace eval FFF {
  # adapted from: http://wiki.tcl.tk/15925
  proc relPathTo {target current} {
    #puts "calling relPathTo $target $current"
    set cc [file split [file normalize $current]]
    set tt [file split [file normalize $target]]
    if {![string equal [lindex $cc 1] [lindex $tt 1]]} {
        # not on *n*x then
        #return -code error "::FFF::relPathTo(): ERROR $target not on same volume as $current"
        return [file normalize $target]
    }
    set prefix ""
    while {[string equal [lindex $cc 0] [lindex $tt 0]] && [llength $cc] > 0} {
      # discard matching components from the front (but don't
      # do the last component in case the two files are the same)
      set cc [lreplace $cc 0 0]
      set tt [lreplace $tt 0 0]
    }

    #if {[llength $cc] == 1} {
    #  # just the file name, so target is lower down (or in same place)
    #  set prefix "."
    #}   
    # step up the tree (start from 1 to avoid counting file itself
    for {set i 1} {$i <= [llength $cc]} {incr i} {
        append prefix " .."
    }
    # stick it all together (the eval is to flatten the target list)
    if {$cc eq $tt} {
      return "."
    } else {
      return [eval file join $prefix $tt]
    }
  }
}
##############################################################################
#  Cadence Copyright - Foundation Configuration Format (FCF) Processor  2011 #
#  FileName    [relPathTo.tcl]                                                 #
#  Description:                                                              #
#  Author      [Buda Leung / Cadence FED Product Core Team]                  #
#  Version      @Id: foundationflow.tcl,v 1.59 2012/01/19 16:31:37 buda Exp @                                                        #
#  Date        [01-11-2011]                                                  #
##############################################################################
# adapted from: http://wiki.tcl.tk/15925
namespace eval FFF {
  namespace export relPathTo
  proc relPathTo {target current} {
    #puts "calling relPathTo $target $current"
    set cc [file split [file normalize $current]]
    set tt [file split [file normalize $target]]
    if {![string equal [lindex $cc 1] [lindex $tt 1]]} {
        # not on *n*x then
        #return -code error "::FFF::relPathTo(): ERROR $target not on same volume as $current"
        return [file normalize $target]
    }
    set prefix ""
    while {[string equal [lindex $cc 0] [lindex $tt 0]] && [llength $cc] > 0} {
      # discard matching components from the front (but don't
      # do the last component in case the two files are the same)
      set cc [lreplace $cc 0 0]
      set tt [lreplace $tt 0 0]
    }

    for {set i 1} {$i <= [llength $cc]} {incr i} {
        append prefix " .."
    }
    # stick it all together (the eval is to flatten the target list)
    if {$cc eq $tt} {
      return "."
    } else {
      return [eval file join $prefix $tt]
    }
  }
}
# Imported from EDI/utils.tcl on 1/2/2011
namespace eval FFF {

   proc wrap_command {tag command} {

      global vars
      global env
      global errors

      if {![info exists vars(tags,verbose)]} {
         set verbose FALSE
      }  else {
         set verbose $vars(tags,verbose)
      }

      if {![info exists vars(tags,verbosity_level)]} {
         set verbosity_level LOW
      } else {
         switch [string toupper $vars(tags,verbosity_level)] { 
            "LOW" {
               set verbosity_level LOW
            }
            "HIGH" {
               set verbosity_level HIGH
            }
            default {
               set verbosity_level LOW
            }
         }
      }

      if {[info exists vars($tag,pre_tcl)] || \
          [info exists vars($tag,post_tcl)] || \
          [info exists vars($tag,skip)] || \
          [info exists vars($tag,replace_tcl)]} {
         if {![info exists vars(tagged)]} {
            set vars(tagged) [list]
         }
      }

      if {$verbosity_level eq "HIGH"} {
         set commands "# <BEGIN TAG> $tag\n"
      } else {
         set commands ""
      }
#      set commands ""
      if {[info exists vars($tag,skip)] && $vars($tag,skip)} {
         lappend vars(tagged) $tag,skip
         regsub  -all "\\\n" "\n\n$command\n" "\n# " skip
#         append skip "\n"
         if {$verbose} {
            append commands "\n# <begin tag $tag,skip>"
         } 
         append commands $skip
         if {$verbose} {
            append commands "<end tag $tag,skip>\n\n"
         }
         append commands "\n"
         if {$verbose} {
            return $commands
         } else {
            return
         }
      }

      if {[info exists vars($tag,pre_tcl)]} {
         if {[file exists $vars($tag,pre_tcl)]} {
            lappend vars(tagged) $tag,pre_tcl
            if {$vars(flat) eq "full"} {
               set ip [open $vars($tag,pre_tcl) r]
               if {$verbose} {
                  append commands "\n# <begin tag $tag,pre_tcl>\n"
               } 
               while {[gets $ip line]>=0} {
                  append commands "$line\n"
               }
               close $ip
               if {$verbose} {
                  append commands "# <end tag $tag,pre_tcl>\n\n"
               } 
            } else {
               append commands "source $vars($tag,pre_tcl)\n"
            }
         } else {
            puts "<FF> ERROR: $tag pre_tcl file ($vars($tag,pre_tcl)) not found"
            set errors($vars(error_count)) "$tag pre_tcl file ($vars($tag,pre_tcl)) not found"
            incr vars(error_count)
            if {$verbose} {
               append commands "# <end tag $tag,pre_tcl>\n\n"
            }
         }
      }
      if {[info exists vars($tag,replace_tcl)]} {
         if {[file exists $vars($tag,replace_tcl)]} {
            lappend vars(tagged) $tag,replace_tcl
            set ip [open $vars($tag,replace_tcl) r]
            if {$verbose} {
               append commands "\n# <begin tag $tag,replace_tcl>\n"
            } 
            while {[gets $ip line]>=0} {
               append commands "$line\n"
            }
            close $ip
         } else {
            puts "<FF> ERROR: $tag replace_tcl file ($vars($tag,replace_tcl)) not found"
            set errors($vars(error_count)) "$tag replace_tcl file ($vars($tag,replace_tcl)) not found"
            incr vars(error_count)
         }
         if {$verbose} {
            append commands "# <end tag $tag,replace_tcl>\n\n"
         }
      } else {
         # Insert original command here
         append commands $command
      }

      if {[info exists vars($tag,post_tcl)]} {
         if {[file exists $vars($tag,post_tcl)]} {
            lappend vars(tagged) $tag,post_tcl
            if {$verbose} {
               append commands "\n# <begin tag $tag,post_tcl>\n"
            } 
            if {$vars(flat) eq "full"} {
               set ip [open $vars($tag,post_tcl) r]
               while {[gets $ip line]>=0} {
                  append commands "$line\n"
               }
               close $ip
#               if {$verbose} {
#                  append commands "#<<<\n"
#               } 
            } else {
               append commands "source $vars($tag,post_tcl)\n"
            }
         } else {
            puts "<FF> ERROR: $tag post_tcl file ($vars($tag,post_tcl)) not found"
            set errors($vars(error_count)) "$tag post_tcl file ($vars($tag,post_tcl)) not found"
            incr vars(error_count)
         }
         if {$verbose} {
            append commands "# <end tag $tag,post_tcl>\n\n"
         }
      }
      if {$verbosity_level eq "HIGH"} {
         append commands "# <END TAG> $tag\n"
      }

      return $commands
   }

   proc get_line_match {pattern file} {

      set ip [open $file r]

      while {[gets $ip line]>=0} {
         if {[regexp "$pattern" $line]>0} {
           set match $line
         }
      }

     return $match
   }

   proc singular {val {false "s"} {true ""}} {
     if {$val==1} { return $true } else { return $false }
   }

   proc size {val {suffix "byte"}} {
     set level 0
     set prefixes [list "" kilo mega giga tera peta]
     while {$val>1024} {
       set val [expr {$val/1024.0}]
       incr level
     }
     set val [expr {int($val+0.5)}]
     return "$val [lindex $prefixes $level]$suffix[singular $val]"
   }

   proc system_info {} {

      global vars

      set uname [exec uname]

      if {[lsearch "Linux" $uname] != -1} {

         set inFile "$vars(script_root)/ETC/status.dat"

         if {![file exists $inFile]} {
             return
         }

         set upId [open "/proc/uptime" r]
         set info(uptime) [lindex [split [gets $upId] .] 0]
         close $upId

         foreach {var val} {mon 2592000 wks 604800 day 86400 hrs 3600 min 60 sec 1} {
           set info(uptime.${var}) [expr {$info(uptime)/${val}}]
           set info(uptime) [expr {$info(uptime)-($info(uptime.${var})*${val})}]
         }

         set info(host.fqdn) [info hostname]
         set info(host.name) [lindex [split $info(host.fqdn) .] 0]
         set info(host.domain) [string range $info(host.fqdn) [expr {[string length $info(host.name)]+1}] end]
         set info(host.os) $::tcl_platform(os)
         set info(host.osver) $::tcl_platform(osVersion)
         set info(host.machine) $::tcl_platform(machine)

         if {$info(host.os)=="Linux"} {
           if {[file exists /etc/slackware-version]} { set info(host.distribution) "Slackware" }
           if {[file exists /etc/redhat-release]} { set info(host.distribution) "RedHat" }
           if {[file exists /etc/mandrake-release]} { set info(host.distribution) "Mandrake" }
           if {![info exists info(host.distribution)]} { set info(host.distribution) "Unknown" }
         } else {
           return
         }

         set cpuId [open "/proc/cpuinfo" r]
         set info(cpu.total) 0
         set info(cpu.cpucores) 1
         while {![eof $cpuId]} {
           gets $cpuId ln
           set ln [split $ln :]
           set item [string trim [lindex $ln 0]]
           set value [string trim [lindex $ln 1]]
           set info(cpu.[lindex $item 0][lindex $item 1]) $value
           if {[lindex $item 0] eq "processor"} {incr info(cpu.total)}
         }
         close $cpuId

         set memId [open "/proc/meminfo" r]
         set info(mem.free) 0
         while {![eof $memId]} {
           gets $memId ln
           set ln [split $ln :]
           set item [string trim [lindex $ln 0]]
           catch { set value [expr {[string trim [lindex [lindex $ln 1] 0]]*1024}] }
           switch -- "$item" {
             MemTotal { set info(mem.total) $value }
             SwapTotal { set info(mem.swap.total) $value }
             SwapFree { set info(mem.swap.free) $value }
             MemFree { incr info(mem.free) $value }
             Cached { incr info(mem.free) $value }
             Buffers { incr info(mem.free) $value }
           }
         }

         set parseId [open $inFile r]
         while 1 {
           gets $parseId ln
           if {[eof $parseId]} { break }
           catch { Puts [subst $ln] } err
         }
         close $parseId
      }
   }

   ############################################################################
   # This routine iterates over variables that maintain lists of files.  If
   # any element of the list is a wildcard, that entry is replaced with the
   # Tcl command that will expand the name at runtime
   ############################################################################

   proc process_file_lists {} {

      global vars

      if {![info exists vars(globbed)]} {
         set vars(globbed) false
      }
      if {$vars(globbed)} {
         return
      }
      set vars(globbed) true

      if {[regexp "^11" $vars(version)]} {
         return
      }
      # BCL: Removed def_files from this list
      set var_indices [list "cts_spec" "lef_files" \
                            "timing" "si" "ecsm" "cts_sdc"]

      # BCL: Add def_files to list only if it doesn't have [subst] in the name (other wise we need to keep [subst... unexpanded)
      if {[info exists vars(def_files)] && ![regexp {\[subst \$vars} $vars(def_files)]} {lappend var_indices def_files}

      foreach index $var_indices {
         set all_names [array names vars -glob "*$index"]
         foreach name $all_names {
            set expanded_files ""
	    # BCL: Added subst around final variable to resolve vars(rundir) references
            foreach file [subst $vars($name)] {
               if {([string first "*" $file] != -1) ||
                   ([string first "?" $file] != -1)} {
                  if {![catch {set files [glob $file]}]} {
                     lappend expanded_files $files
                  }
               } else {
                  lappend expanded_files $file
               }
            }
            set vars($name) $expanded_files
         }
      }
   }

   proc get_required_procs {file} {
      #
      # Given a list of required procedures, return the lines that represent
      # those procedures from the utils.tcl file
      #

      global vars
      global errors

      #
      # Read the file and gather all of the contents
      #

      set all_lines ""
      set length 0
      set ip [open $file]
      while {[gets $ip line]>=0} {
         set utils_lines($length) $line
         incr length
      }
      close $ip

      #
      # Iterate across each line and pull out relevant procedures
      #

      set lines ""
      set i 0
      while {$i < $length} {
         set line $utils_lines($i)
         foreach proc $vars(required_procs) {
            if {[regexp "proc $proc" $line] > 0} {
               append lines " $line\n"
               incr i
               while {$i < $length} {
                  set line $utils_lines($i)
                  if {[regexp "proc " $line] > 0} {
                     incr i -1
                     break
                  }
                  if {![regexp "^#" [string trimleft $line] ] && ($i != [expr {$length-1}])} {
                     append lines "$line\n"
                  }
                  incr i
               }
               break
            }
         }
         incr i
      }

      set lines [string trimright $lines]
      return "$lines\n"
   }

   proc source_file {file {abort 1}} {
      global vars
      global source_error
      global errorInfo
      global return_code

#      puts "<FF> LOADING '$file' FILE"
      if {[file exists $file]} {
	 if {[info commands ::FFF::get_tool] ne "" && [::FFF::get_tool] eq "rc" } {
             set sourceResult [catch { uplevel tcl_source $file } source_error ]
         } else {
             set sourceResult [catch { uplevel source $file } source_error ]
         }
         if { $sourceResult } {
            puts "<FF> =============== TCL ERROR ===================="
            puts "<FF> Error loading $file file"
            puts "<FF> $errorInfo"
            puts "<FF> $source_error"
            puts "<FF> =============================================="
            set return_code 99
            if {$abort} {
               exit $return_code
            }
         }
      }
   }

   proc get_by_suffix {passed_array {suffix ""}} {
      #
      # Get the list of array indices that have a suffix of the
      # passed string sequence
      #

      upvar $passed_array the_array

      #
      # If there is no suffix, return every name
      #

      if {[string length $suffix] == 0} {
         return [array names the_array]
      }

      #
      # If there is a suffix, find the matching names and return
      # the list of those names (without the suffix attached to it).
      # This is most helpful when looking for "multi-dimensional array
      # indices" (in quotes because Tcl doesn't support multiple
      # dimensions for array indices)
      #

      set suffix_length [string length $suffix]
      set all_names [array names the_array -glob "*$suffix"]
      set names [list]
      foreach name $all_names {
         set length [string length $name]
         set index [string range $name 0 [expr {$length - $suffix_length - 1}]]
         lappend names $index
      }
      return $names
   }

   ###########################################################################
   # Utility procedures on lists
   ###########################################################################

   proc lintersection {lista listb} {
      #
      # Return the intersection of lista and listb, removing any duplicates
      #

      set intersect [list]
      foreach a $lista {
         if {([lsearch $listb $a] != -1) && \
                ([lsearch $intersect $a] == -1)} {
            lappend intersect $a
         }
      }
      return $intersect
   }


   proc lunion {lista listb} {
      #
      # Return the union of lista and listb, removing any duplicates
      #

      set union [list]
      foreach a $lista {
         if {[lsearch $union $a] == -1} {
            lappend union $a
         }
      }
      foreach b $listb {
         if {[lsearch $union $b] == -1} {
            lappend union $b
         }
      }
      return $union
   }

   ###########################################################################
   # Utilities to handle different control structure output (if-then-else,
   # foreach, etc.)
   ###########################################################################

   proc get_lines {code_block} {
      #
      # Return a list of lines from the strings in code_block
      #

      set block [list]
      while {[llength $code_block]} {
         set index [string first "\n" $code_block]
         if {$index == -1} {
            set index [string length $code_block]
         }
         set line [string range $code_block 0 $index]
         set code_block [string range $code_block [expr {$index + 1}] end]

         if {[string index $line end] eq "\n"} {
            append line "\n"
         }
         lappend block $line
      }

      return $block
   }

   proc for_each {var var_list code_block} {
      #
      # Return a string for a Tcl foreach block
      #

      set code ""
      if {![llength $code_block]} {
         return $code
      }

      set code "foreach $var $var_list \{\n"
      foreach line [get_lines $code_block] {
         append code "   $line"
      }
      append code "\}\n"
      return $code
   }

   

   proc if_else {cond then_block {else_block ""}} {
      #
      # Output a Tcl if-then-else block with the passed data.
      #

      set command "if \{$cond\} \{\n"
      foreach line [get_lines $then_block] {
         append command "   $line"
      }
      if {[llength $else_block]} {
         append command "\} else \{\n"
         foreach line [get_lines $else_block] {
            append command "   $line"
         }
      }
      append command "\}\n"
      return $command
   }

   proc pretty_print_lists {line debug} {
      #
      # If there is an explicit Tcl list in the line, we may want to
      # separate it out into multiple lines.  It will turn a list from
      #       [list a b c]
      # into
      #       [list a \
      #             b \
      #             c]
      # That may not look like much, but for lists that have really *big*
      # text entries, it makes it look a lot nicer
      #
      # If there is no list in the line, do nothing
      #

      set endChar [string index $line end]
      set line [string trimright $line]
      if {$endChar eq "\n"} {
         append line "\n"
      }
      set listPos [string first "\[list " $line]
      if {$listPos == -1} {
         return $line
      }
      set original $line

      #
      # Initialize the line with the contents of the line up to and including
      # the "[list " text.  Also determine the amount of indentation in the
      # line so that we know what to do for subsequent lines
      #

      incr listPos 5
      set nextLine [string range $line 0 $listPos]
      set indent [string repeat " " [string length $nextLine]]
      set line [string trimleft [string range $line $listPos end]]

      #
      # Make sure that there is no space between the close brace in the list
      # and the last text in the list.  This will help with processing (below)
      #

      set line [string trimright $line]
      if {[string index $line end] eq "\]"} {
         return $original
      }
      set line [string range $line 0 [expr {[string length $line] - 2}]]
      set line [string trimright $line]
      append line "\]\n"

      #
      # Parse each element in the list
      #

      set printString ""
      while {[string length $line]} {
         #
         # Get the next item in the list
         #

         set space [string first " " $line]
         if {$space == -1} {
            set space [string length $line]
         }
         set arg [string range $line 0 $space]
         append nextLine $arg

         #
         # Remove that item from the line
         #

         set line [string range $line [expr {$space + 1}] end]
         set line [string trimleft $line]
         if {[string length $line]} {
            if {[string length $nextLine] > 80} {
               append printString "$nextLine\\\n"
               set nextLine $indent
            }
         }
      }
      append printString $nextLine
      return $printString
   }

   proc pretty_print {commands format_options {debug 0}} {

      global vars

      #
      # Pretty print the lines, one by one.  The following will be done:
      #   o If the line is greater than 80 columns, we will break it up
      #     along the options (-option) and indent
      #   o Fix any indentation
      #

      if {[info exists vars(catch_errors)] && $vars(catch_errors)} {
         set indent 3
      } else {
         set indent 0
      }
      set lines ""
      set len [string length $commands]
      while {$len > 0} {
         #
         # Handle the simple case.  If the leading character is a carriage
         # return, append a blank line to the pretty-printed lines and
         # continue on
         #

         set cr [string first "\n" $commands]
         if {!$cr} {
            set commands [string range $commands 1 end]
            incr len -1
            append lines "\n"
            continue
         }

         #
         # If we didn't find a carriage return in the string, the entire thing
         # is a single line.  Otherwise, remove the next line from the set of
         # lines.  If it still ends up being a blank line, append the blank
         # line to the pretty-printed string and continue on
         #

         if {$cr == -1} {
            set line $commands
            set commands ""
            set len 0
         } else {
            set line [string range $commands 0 $cr]
            set commands [string range $commands [incr cr] end]
            set len [expr {$len - $cr}]
         }
         set line [string trimright $line]
         if {![string length $line]} {
            append lines "\n"
            continue
         }

         #
         # We have a real line with real text.  If there is no quote in the
         # string, compress multiple blank spaces to a single blank space
         #

         set line [string trimleft $line]
         if {[string first "\"" $line] == -1} {
            set line [regsub -all {\s+} $line " "]
         }

         #
         # Apply the proper amount of indentation
         #

         set isPut [string equal -nocase -length 5 $line "puts "]
         set firstChar [string index $line 0]
         if {$firstChar eq "\}"} {
            incr indent -3
         }
         set blanks [string repeat " " $indent]
         set line "${blanks}${line}"
         if {[string index $line end] eq "\{"} {
            incr indent 3
         }

         #
         # If the first character is a dash, we have already broken the line
         # up for pretty printing.
         #

         if {$firstChar eq "-"} {
            append lines "   $line\n"
            continue
         }

         #
         # Don't bother formatting comments or short lines.  Also, if the
         # routine has been told not to format the command line options, just
         # output the line
         #

         set lineLen [string length $line]
         if {$isPut || ($firstChar eq "\#") ||
             ($lineLen < 80) || !$format_options} {
            append lines "$line\n"
            continue
         }

         #
         # The line length is over 80, and it's a real EDI command, and it's
         # not a print (puts) statement.  Start indenting on the -option
         # options.  The first "-option" should be on the same line as the
         # command.  All subsequent options should be on their own line,
         # slightly indented from the basic command
         #

         set firstDash [string first " -" $line]
         if {$firstDash == -1} {
            append lines "$line\n"
            continue
         }

         set dash [string first " -" $line [incr firstDash]]
         set leading ""
         while {$dash != -1} {
            set fragment [string range $line 0 [expr {$dash - 1}]]
            append lines \
               [pretty_print_lists "${leading}${fragment} \\\n" $debug]
            set leading "$blanks   "
            set line [string range $line [expr {$dash + 1}] end]
            set line [string trimleft $line]
            set dash [string first " -" $line]
         }
         append lines [pretty_print_lists "${leading}${line}\n" $debug]
      }
      return $lines
   }

   proc strip_lines {commands markers} {
      #
      # This routine strips out lines from $commands when they start with
      # any of the list elements in $markers
      #

      set lines ""
      while {[string length $commands] > 0} {
         #
         # Get the next line from the set of commands
         #

         set cr [string first "\n" $commands]
         if {$cr == -1} {
            set line $commands
            set commands ""
         } else {
            set line [string range $commands 0 $cr]
            set commands [string range $commands [incr cr] end]
         }

         #
         # If the line starts with a marker, ignore the line
         #

         set trimmed [string trimleft $line]
         set matched false
         foreach marker $markers {
            set len [string length $marker]
            if {[string equal -nocase -length $len $marker $trimmed]} {
               set matched true
               break
            }
         }
         if {$matched} {
            continue
         }
         append lines $line
      }

      return $lines
   }

  proc flatten_curlies_in_list list {string map {\{ "" \} ""} $list}

  #
  # gen_incr_filename(scriptNameBase)
  # Buda Leung, 11/2011
  # args:
  #  $scriptNameBase: <path>/basename of dir
  # @return: new base name
  #
  # Description: Generates a new output file name using the input
  # argument as a basename. This proc looks for all files in the
  # same directory as the argument with a matching basename.
  # It then looks for a trailing integer suffix, and compares
  # all matching files to find the largest integer. 
  # It returns a new file name of the form <path>/<basename><largest int + 1>
  #
  # Example Usage: input argument setup.tcl
  # files in dir: setup.tcl setup.tcl1
  # @return: setup.tcl2
  #

  proc gen_incr_filename {scriptNameBase} {
    set file_list [glob -nocomplain [set scriptNameBase]*]
    if {[llength $file_list] > 0} {
      set highNum 1
      foreach file $file_list {
        set re "[set scriptNameBase](\[\[:digit:\]\]+)\$"
        if {[regexp $re $file full num]} {
          if {$num >= $highNum} {
            set highNum [incr num]
          }
        }
      }
      set scriptName $scriptNameBase$highNum
    } else {
      set scriptName "[set scriptNameBase]"
    }
    return $scriptName
  }

  #
  # gen_new_rundir {args}
  # Buda Leung, 11/2011
  # args:
  #  -dir <string>: dir name to change
  #  -style [increment|date|custom]: naming style to use [increment|date|custom]
  #  -date_style <string> (required when style=date): tcl commands to create a date string
  #  -custom <string> (optional): a custom string to prepend or postpend to the dir
  #  -name_change_order [prefix|suffix] (required when customString is defined): [prefix|suffix]
  # @return: new dir name
  #
  # Description: Generates a new directory name based on the basename
  # and options provided. The options allowed are:
  #
  # style:
  #  * increment: add an integer to the rundir based on dirs found in [dirname $dir]
  #  * date: add a date string to the rundir name, using vars(date_style) to control the formatting
  #  * custom: add a custom string to the rundir name
  # nameChangeOrder:   
  #  * prefix: add the custom string to the beginning of the rundir
  #  * suffix: add the custom string to the end of the rundir
  #
  # NOTE: increment, date, and custom are mutually exclusive options
  #
  # Example Usage: 
  # gen_new_rundir work/run increment
  # (dirs with matching basename : work/run1 work/run2)
  # @return: work/run3
  #
  # gen_new_rundir work/run date
  # @return: work/run_2011-11-23_12_09_58 
  #
  # gen_new_rundir work/run custom rcp_high_eff prefix
  # @return: work/rcp_high_eff_run

  proc gen_new_rundir {argv} {
    #global vars
    #
    # Proc defaults
    # Note that defaults live in the default_setup.tcl, but when gen_new_rundir is called, that setup.tcl has not yet been loaded
    # These defaults must stay synchronized to  the default_setup.tcl vars() equivalents
    #
    set def_date_style                                 "\[clock format \[clock seconds\] -format \"%Y-%m-%d_%H_%M_%S\" \]"
    # Use the following if you want a custom prefix/suffix added to the rundir
    set def_custom_rundir_name_append                  ""
    # vars(rundir_namechange_method) [prefix|suffix]
    set def_rundir_namechange_method                   "suffix"

    #
    # These defaults stay here as they are related to the -u/-y args to gen_edi_flow.tcl
    #
    set def_rundir					"."
    set def_auto_increment_rundir_style                 "none";# [none|date|increment|custom]

    #
    # Arg processing
    #

    while {[llength $argv] > 0} {
      set option [lindex $argv 0]
      set argv [lreplace $argv 0 0]
      switch -regexp -- $option {
         ^-(d|-dir)$ {
            set dash_d_script_dir [lindex $argv 0]
            set argv [lreplace $argv 0 0]
         }
         ^-(y|-style)$ {
           set dash_y_style_type [lindex $argv 0]
           set argv [lreplace $argv 0 0]
         }
         ^-(u|-rundir)$ {
            set dash_u_rundir_base [lindex $argv 0]
            set argv [lreplace $argv 0 0]
         }
      }
    };# end while (processing args)

    set dbgMsg "<FF-INT> gen_new_rundir(): "

        #
    # Load vars. This will overwrite any FF defaults, but not the -u/-y options
    # Only looking for the following:
    # vars(rundir_base) (-u takes precedence) 
    # vars(rundir) - overrides vars(rundir_base) and -u/-y
    # vars(auto_increment_rundir_style) (-y takes precedence)
    # vars(date_style) (no gen_edi_flow.tcl option)
    # vars(custom_rundir_name_append) (no gen_edi_flow.tcl option)
    # vars(rundir_namechange_method) (no gen_edi_flow.tcl option)
    #
    if {[::FFF::get_tool] eq "rc"} { 
      set old_source_verbose [get_attribute source_verbose]
      set_attribute -quiet source_verbose false
    }
    ##nagelfar ignore
    foreach file [::FFF::flatten_list [set ${::ns(flows)}::vars(config_files)]] {
      if {[::FFF::get_tool] eq "rc"} { 
        redirect /dev/null {source $file}
      } else {
        source $file
      }
    }
    if {[::FFF::get_tool] eq "rc"} { 
      set_attribute -quiet source_verbose $old_source_verbose
    }

    # Incase the user defined these in their setup.tcl
    if {![info exists vars(date_style]} {
      set date_style $def_date_style
    }
    if {![info exists vars(custom_rundir_name_append)]} {
      set vars(custom_rundir_name_append) $def_custom_rundir_name_append
    }
    if {![info exists vars(rundir_namechange_method)]} {
      set vars(rundir_namechange_method) $def_rundir_namechange_method
    }

    #
    # Set the rundir original name
    # Priority:
    # 1) vars(rundir)
    # 2) dash_u_rundir_base
    # 3) vars(rundir_base)
    # 4) def_rundir

    if {![info exists vars(rundir)]} {
      if {![info exists dash_u_rundir_base]} {
        if {![info exists vars(rundir_base)]} {
          set rundir_origname $def_rundir
        } else {
          set rundir_origname $vars(rundir_base)
        } 
      } else {
        if {[info exists vars(rundir_base)] && $vars(rundir_base) ne $dash_u_rundir_base} {
          # Conflict between -u and setup.tcl. -u wins
          puts "<FF> WARNING \"-u $dash_u_rundir_base\" overriding config variable vars(rundir_base) ($vars(rundir_base))"
          puts "             To prevent this behavior, do not use the \"-u\" option (FF will use vars(rundir_base) from your config file)."
        }
        set rundir_origname $dash_u_rundir_base
      } 
    } else {
      # The following handle conflicts between vars(rundir) and -u or vars(rundir_base)
      if {[info exists dash_u_rundir_base]} { 
        if {$vars(rundir) ne $dash_u_rundir_base} {
          puts "<FF> WARNING vars(rundir) \"$vars(rundir)\" overriding \"-u $dash_u_rundir_base\" option."
          puts "             To prevent this behavior, do not set vars(rundir) in your config file."
        } elseif {[info exists vars(rundir_base)]} {
          puts "<FF> WARNING vars(rundir) \"$vars(rundir)\" overriding config variable vars(rundir_base) \"$vars(rundir_base)\""
          puts "             To prevent this behavior, do not set vars(rundir) in your config file."
        }
      }
      set rundir_origname $vars(rundir)
    }

    #
    # Set the rundir naming style
    # Priority:
    # 1) vars(auto_increment_rundir_style)
    # 2) dash_y_style_type
    # 3) def_auto_increment_rundir_style
    
    if {![info exists vars(auto_increment_rundir_style)]} {
      if {![info exists dash_y_style_type]} {
        set styleType $def_auto_increment_rundir_style
      } else {
        set styleType $dash_y_style_type
      } 
    } else { 
      # vars(auto_increment_rundir_style) was set in the setup.tcl
      if {[info exists dash_y_style_type] && $dash_y_style_type ne $vars(auto_increment_rundir_style)} {
        # Conflict between -y and setup.tcl. -y wins
        puts "<FF> WARNING \"-y $dash_y_style_type\" overriding config variable vars(auto_increment_rundir_style) ($vars(auto_increment_rundir_style))"
        puts "             To prevent this behavior, do not use the \"-y\" option (FF will use vars(auto_increment_rundir_style) from your config file)."
      set styleType $dash_y_style_type
      } else {
        set styleType $vars(auto_increment_rundir_style)
      }
    }

    #
    # If increment is specified, -u / vars(rundir) is required ; otherwise error and exit:
    #
    if {$styleType eq "increment" && ([file tail $rundir_origname] eq "" || [file tail $rundir_origname] eq ".")} {
      puts "<FF> ERROR: Rundir naming style was set to \"increment\", but rundir evaluated to \".\" due to:"
      if {[info exists vars(rundir)] && [file dirname $vars(rundir)] eq "."} { 
        puts "            setting vars(rundir) to \"$vars(rundir)\" in your configuration file."
      } elseif {[info exists dash_u_rundir_base] && [file dirname $dash_u_rundir_base] eq "."} { 
        puts "            the \"-u\" $dash_u_rundir_base argument to gen_edi_flow.tcl"
      } elseif {[info exists vars(rundir_base)] && [file dirname $vars(rundir_base)] eq "."} { 
        puts "            setting vars(rundir_base) to \"$vars(rundir_base)\" in your configuration file."
      } else {
        puts "            the default rundir setting which is \"$def_rundir\""
      }
      puts "            To prevent this error, use the -u argument to specify a rundir base, or specify a vars(rundir_base) in your setup.tcl"
      exit 99
    }

    # 
    # Generate new rundir if valid style defined
    # 

    #  -date_style <string> (required when style=date): tcl commands to create a date string
    #  -custom <string> (optional): a custom string to prepend or postpend to the dir
    #  -name_change_order [prefix|suffix] (required when customString is defined): [prefix|suffix]

    # Remove any "//" in the path
    regsub -all {\/\/} $rundir_origname {/} rundir_origname

    set rundir_basename [file tail $rundir_origname]
    set rundir_dirname [file dirname $rundir_origname]

    if {$styleType ne "none"} {
      switch -exact -- $styleType {
        date {
          if {$vars(rundir_namechange_method) eq "prefix"} {
            set new_basename [subst $date_style]_${rundir_basename}
          } elseif {$vars(rundir_namechange_method) eq "suffix"} {
            set new_basename ${rundir_basename}_[subst $date_style]
          }
        }
        increment {
          ##nagelfar ignore
          set new_basename [file tail [::FFF::gen_incr_filename $rundir_origname]]
        }
        custom {
          if {$vars(custom_rundir_name_append) ne ""} {
            if {$vars(rundir_namechange_method) eq "prefix"} {
              set new_basename [subst $vars(custom_rundir_name_append)]_${rundir_basename}
            } elseif {$vars(rundir_namechange_method) eq "suffix"} {
              set new_basename ${rundir_basename}_[subst $vars(custom_rundir_name_append)]
            }
          } else {
	    puts "<FF> NOTE: vars(custom_rundir_name_append) set to \"\". No modification to rundir will occur."
            set new_basename $rundir_basename
          }
        }
        default {
          # This should never happen! (indicates incorrect usage within gen_edi_flow.tcl!)    
          puts "$dbgMsg WARNING: Unknown option for styleType. Using default (none)"
        }
      }
      set vars(rundir) [join "$rundir_dirname $new_basename" "/"]
      set vars(new_rundir_basename) $new_basename
    } else {
      set vars(rundir) $rundir_origname
    }
    return $vars(rundir)
  };# end proc gen_new_rundir

  proc relPathTo {target current} {
    #puts "calling relPathTo $target $current"
    set cc [file split [file normalize $current]]
    set tt [file split [file normalize $target]]
    if {![string equal [lindex $cc 1] [lindex $tt 1]]} {
        # not on *n*x then
        #return -code error "::FFF::relPathTo(): ERROR $target not on same volume as $current"
        return [file normalize $target] 
    }
    set prefix ""
    while {[string equal [lindex $cc 0] [lindex $tt 0]] && [llength $cc] > 0} {
      # discard matching components from the front (but don't
      # do the last component in case the two files are the same)
      set cc [lreplace $cc 0 0]
      set tt [lreplace $tt 0 0]
    }

    #if {[llength $cc] == 1} {
    #  # just the file name, so target is lower down (or in same place)
    #  set prefix "."
    #}   
    # step up the tree (start from 1 to avoid counting file itself
    for {set i 1} {$i <= [llength $cc]} {incr i} {
        append prefix " .."
    }
    # stick it all together (the eval is to flatten the target list)
    if {$cc eq $tt} {
      return "."
    } else {
      return [eval file join $prefix $tt]
    }
  }

  proc convert_dynamic_links_to_static_files {newDir OrigDir} {
    ##nagelfar ignore
    set cwd [exec pwd]
    set normNewDir [file normalize $newDir]
    set normOrigDir [file normalize $OrigDir]
    ##nagelfar ignore
    if {[::FFF::get_tool] eq "rc"} { lcd $normNewDir } else { cd $normNewDir }
    if {![catch {glob .??* *}]} {
      foreach possibleLink [glob .??* *] {
	#puts "Testing [file normalize $possibleLink]"
	if {[file type $possibleLink] eq "link"} {
          # If there's a link in the new dir, see what it refers to in the origDir by going to the orig dir
          if {[::FFF::get_tool] eq "rc"} { lcd $normOrigDir } else { cd $normOrigDir }
	  set isNotAResolvableLink [catch {set resolvedLink [file normalize [file readlink $possibleLink]]}]
	  # Go back to the new Dir
          if {[::FFF::get_tool] eq "rc"} { lcd $normNewDir } else { cd $OrigDir }
          if {!$isNotAResolvableLink} {
            #puts "Found a link: [file normalize $resolvedLink]"
	    # We are able to resolve the link to something (a file, or a dir, or something that doesn't actually exist)
            # We check what it might be:
            if {[file isdirectory $resolvedLink]} {
              #puts "Found a dir: $resolvedLink"
	      #puts "Deleting link: $possibleLink"
	      # the link resolved to a dir. Copy the dir over, then apply recursion
              file delete -force $possibleLink
	      #puts "Copying actual dir: [file normalize $resolvedLink] to ./ ([exec pwd])"
	      file copy [file normalize $resolvedLink] ./
	      if {[file tail $possibleLink] ne [file tail $resolvedLink]} {
	        # the basename of the resolved link is different from the link name, so go ahead and create a link to fix this in the dest dir
		file link [file tail $possibleLink] [file tail $resolvedLink]
	      }
	      # Recursively examine the copied dir for any links (rinse/repeat)
	      #puts "recursive call to: convert_dynamic_links_to_static_files ./[file tail $resolvedLink] $normOrigDir/[file tail $resolvedLink]"
              ##nagelfar syntax convert_dynamic_links_to_static_files
	      convert_dynamic_links_to_static_files ./[file tail $resolvedLink] $normOrigDir/[file tail $resolvedLink]
	    } elseif {[file isfile $resolvedLink]} {
	      # The link resovles to a file
              #puts "Replacing dynamic link [file normalize $possibleLink] with file [file normalize $resolvedLink] in [file normalize $normNewDir]"
              file delete -force $possibleLink
              file copy [file normalize $resolvedLink] ./
            } else {
	      # The link doesn't point to anything that exists
              puts "convert_dynamic_links_to_static_files() ERROR link [file normalize $possibleLink] does not point to an actual file (this: $resolvedLink doesn't exist)."
              return -code error
            }
          }
        } elseif {[file isdirectory $possibleLink]} {
	  # it's a dir, so apply recursion
          ##nagelfar syntax convert_dynamic_links_to_static_files
          convert_dynamic_links_to_static_files $possibleLink $normOrigDir/$possibleLink
        };# end (we only care about dirs and links. Proc ignores files
      };# end foreach possibleLink
    } else {
      puts "convert_dynamic_links_to_static_files() WARNING: Empty directory analyzed (no files or .files found)"
    }
    # Go back to the original (calling) directory
    if {[::FFF::get_tool] eq "rc"} { lcd $cwd } else { cd $cwd }
  }

};# end namespace FF
#===========================================================================
# File Name     : Source: /grid/tfo/vol103/buda/vault/cvs/ff/cvsroot/ff/applet/src/genRandInt.tcl,v 
# Date Created  : 10/25/2004
# Date Modified : Date: 2012/06/15 10:55:03 
# Version       : Revision: 1.2
# Summary       : Generate a random integer
# Keywords      : random rand
#
# Description:
#       Generate a random number.
#       A little more robust than using PIDs for tmp files
#
# Assumptions:
#       None
#
#===========================================================================
namespace eval FFF {
  namespace export gen_rand_int
  proc gen_rand_int {mLen} {
    set int ""
    while {[string length $int] < 10} {
      # keep trying until we get an int at least 14 chars long
      set dec [expr {rand()*1000000000000}]
      set declen [string length $dec]
      set int [string range $dec 0 [expr {$declen - 3}]]
      regsub {[.]} $int 0 int
      set len [string length $int]
    }
    while {$len < $mLen} {
      set int $int$int
      set len [string length $int]
    }
    set finalStr [string range $int 1 $mLen]
    return $finalStr
  }
}
if {![llength [info commands gen_rand_int]]} {
  namespace import ::FFF::gen_rand_int
}
#===========================================================================
# flows APIs
#===========================================================================
# Install the FF codegen app
# This should be applet install flows
# BCL: The following is no longer needed
#if {[info procs read_foundation] eq ""} {
#    set ff_dir $::env(HOME)/.localFFlows
#    source $ff_dir/foundationflow.etf
#    catch {redirect /dev/null {tcl_source $ff_dir/foundationflow.etf}}
#    #catch {tcl_source $ff_dir/foundationflow.etf}
#}
#package require foundationflows


#set _appletDir [file dirname [info script]]


#set isRTLCompiler [expr {[llength [info commands set_remove_assign_options]] && 
#			 [llength [info commands get_attribute]] && 
#			 [string equal [get_attribute program_short_name /] "rc"]}]

#if {!${isRTLCompiler}} {
    #if {[catch {package require compatibility} errMsg]} {
	#if {[info exists ::env(INFRA)]} { 
	    #source "$::env(INFRA)/compatibility.tcl" 
	#} elseif {[file exists ${_appletDir}/compatibility.tcl]} { 
	    #source "${_appletDir}/compatibility.tcl" 
	#} else {
	    #puts "Error: compatibility.tcl not found! \'compatibility.tcl\' is searched as follows:" 
	    #puts "\t1) based on existence and contents of pkgIndex.tcl"
	    #puts "\t2) based on existence and contents of INFRA environment variable"
	    #puts "\t3) In the same directory as applet.tcl"
	    #return -code error 
	#}
    #}
#}

if {![info exists ::ns(flows)]}  { set ::ns(flows) "::FFF::flows" }

#if {${isRTLCompiler}} { alias $::ns(compat)::redirect ::redirect }

namespace eval $::ns(flows) {
    variable baseDir [join [lrange [split [info nameofexecutable] /] 0 [expr {[llength [split [info nameofexecutable] /]] - 6}]] /]

    switch -regexp [info nameofexecutable] {
	{/(tclsh|wish)[\d\.]*$}     { 
	    variable localServer /dev/null 
	    variable remoteServer splinter:/foundationflows/default/latest
	    variable localInstall $::env(HOME)/.localFFlow/default
	}
	{/(velocity|encounter)$} { 
	    variable localServer /dev/null 
	    variable remoteServer splinter:/foundationflows/edi/latest
	    variable localInstall $::env(HOME)/.localFFlow/edi
	}
	{/ctos(gui)?$}           { 
	    variable localServer /dev/null 
	    variable remoteServer splinter:/foundationflows/ctos/latest
	    variable localInstall $::env(HOME)/.localFFlow/ctos
	}
	{/(lec|LEC|verify)$}     { 
	    variable localServer /dev/null 
	    variable remoteServer splinter:/foundationflows/lec/latest
	    variable localInstall $::env(HOME)/.localFFlow/lec
	}
	{/(ccd|CCD)$}            {
	    variable localServer /dev/null 
	    variable remoteServer splinter:/foundationflows/ccd/latest
	    variable localInstall $::env(HOME)/.localFFlow/ccd
	}
	{/(simvision\.exe)$}     { 
	    variable localServer /dev/null 
	    variable remoteServer splinter:/foundationflows/ies/latest
	    variable localInstall $::env(HOME)/.localFFlow/ies
	}
	default                  { 
	    variable localServer  ${::env(CDN_SYNTH_ROOT)}/lib/cdn/rc/flows/rc
	    variable remoteServer splinter:/foundationflows/rc/latest	    
	    variable localInstall $::env(HOME)/.localFFlows/rc
	}
    }

    ##nagelfar ignore
    if {![catch {set ftpSock [socket splinter.cadence.com 21]} errMsg]} {
	close $ftpSock
	variable defaultMode   remote 
	variable defaultServer [set [set ::ns(flows)]::remoteServer]
    } else {
	variable defaultMode local
	variable defaultServer [set [set ::ns(flows)]::localServer]
    }

    hidden_proc ValidatePath {obj val} {
	upvar $::ns(flows)::localServer  localServer 

	if {[string match ${localServer} [get_attribute flows_mode /]]} {
	    foreach dir $val { 
		if {[llength $dir] && ![file isdirectory $dir]} {
		    puts "Error   : \'$dir\' cannot be found or is not a directory"
		    return 0
		}
	    }
	}
	return 1
    }

    hidden_proc UpdateSearchPath {args} {
	upvar $::ns(flows)::localServer  localServer 
	upvar $::ns(flows)::localInstall localInstall

	if {[string match "<default>" ${args}]} {
	    puts "Info: using <default> \'flows_search_path\'"
	    if {[file exists "${localInstall}/.flowInfo"]} { 
		puts "\tFound valid foundation flow installation in \'${localInstall}\'"
		return "${localInstall}" 
	    } elseif {[file exists "${localServer}/.flowInfo"]}  { 
		puts "\tFound valid foundation flow installation in \'${localServer}\'"
		return "${localServer}" 
	    } else {
		puts "No valid foundation flow directory found. Please set the attribute \'flows_search_path\' to a valid foundation flow directory"
		return
	    }
	} else {
	    foreach searchDir ${args} { 
		if {![file isdirectory ${searchDir}]} { 
		    puts "Error: Invalid \'flows_search_path\'..."
		    puts "\t\'${searchDir}\' is not a directory"
		    return -code error
		} 
		if {![file exists "${searchDir}/.flowInfo"]}  {
		    puts "Error: Invalid \'flows_search_path\'..."
		    puts "\t\'${searchDir}\' is not a valid foundation flow directory"
		    return -code error
		} 
	    }
	    return ${args}
	}
    }

    hidden_proc SetServer {obj val} {
	upvar $::ns(flows)::localServer  localServer
	upvar $::ns(flows)::remoteServer remoteServer
	if {[string match "remote" ${val}]} { 
	    if {![catch {set ftpSock [socket splinter.cadence.com 21]} errMsg]} {
		close ${ftpSock}
		if {[string match ${localServer}  [get_attribute flows_server /]] || 
		    [string match ${remoteServer} [get_attribute flows_server /]]} {
		    set_attribute -quiet flows_server_pass ""  /
		    set_attribute -quiet flows_server_user anonymous /
		    set_attribute -quiet flows_server ${remoteServer} /
		} 
	    } 
	} else {
	    set_attribute -quiet flows_server ${localServer} /
	}
	return 1
    }
    if {[::FFF::get_tool] eq "rc"} {
      set redirectCmd "redirect"
    } else {
      if {[info commands ::aeware::compat::redirect] ne ""} {
        set redirectCmd "::aeware::compat::redirect"
      }
    }
    # This attribute allows the user to change the default installation location of the flows directory
    if {[attribute_exists -path / flows_search_path] == 0} {
      $redirectCmd /dev/null {
        define_attribute \
            -category flows \
            -data_type string \
            -obj_type root \
            -default_value "<default>" \
            -hidden \
            -help_string "Search path for flows directories." \
            flows_search_path
      }
    }

#   #    	-check_function $::ns(flows)::ValidatePath

    # This attribute specifies whether to use the flows data shipped with the tool or access 
    # the latest image over the network
    if {[attribute_exists -path / flows_mode] == 0} {
      $redirectCmd /dev/null {
        define_attribute \
            -category flows \
            -data_type string \
            -obj_type root \
            -default_value [set [set ::ns(flows)]::defaultMode] \
            -hidden \
            -check_function $::ns(flows)::SetServer \
            -help_string "Applet update mode (local|remote)." \
            flows_mode
      }
    }

    # This attribute specifies whether to use the flows data shipped with the tool or access 
    # the latest image over the network
    if {[attribute_exists -path / flows_server] == 0} {
      $redirectCmd /dev/null {
        define_attribute \
            -category flows \
            -data_type string \
            -obj_type root \
            -default_value [set [set ::ns(flows)]::defaultServer] \
            -hidden \
            -check_function $::ns(flows)::SetServer \
            -help_string "Applet server used for dynamic updates." \
            flows_server
      }
    }
    # -check_function $::ns(flows)::ValidatePath \
    # -default_value splinter:/flows/rc/latest

    # This attribute specifies the user name to be used when contacting flows server
    if {[attribute_exists -path / flows_server_user] == 0} {
      $redirectCmd /dev/null {
        define_attribute \
            -category flows \
            -data_type string \
            -obj_type root \
            -default_value "anonymous" \
            -hidden \
            -check_function $::ns(flows)::SetServer \
            -help_string "Applet server user name." \
            flows_server_user
      }
    }

    # This attribute specifies the user password to be used when contacting flows server
    if {[attribute_exists -path / flows_server_pass] == 0} {
      $redirectCmd /dev/null {
        define_attribute \
            -category flows \
            -data_type string \
            -obj_type root \
            -default_value "" \
            -hidden \
            -help_string "Applet server user password." \
            flows_server_pass
      }
    }
}

namespace eval $::ns(flows) {
    variable appInfo 

    if {![llength [info commands run_foundation]]} { namespace import ::FFF::run_foundation }
    if {![llength [info commands flatten_list]]} { namespace import ::FFF::flatten_list }

    namespace export flows
    
    hidden_proc avail {args} {
	# This proc was taken from the applet.  For the most part, this is untouched.
	# Changes include:
	# 1.  Changed applet_* attributes to flows_*
	# 2.  Changed wording of help functions. 
	# 3.  Removed "outdated" functionality
	
	variable appInfo
	
	set appDirs [eval UpdateSearchPath [get_attribute flows_search_path /]]	;# Default update locations

 	switch -- [parse_options [calling_proc] {} $args \
		       "-location sos specifies location of foundation flow directory (default is \'flows_search_path\')" appDirs \
		       "-debug bOs enable debug message output" debug \
		       "-noserver bos skip checking the server for foundation flows" noserver \
		       "-local bos report installed and server versions of installed foundation flows only (default is ALL foundation flows)" local] {
			   -2 { return }
			   0 { return -code error }
	}

	if {$debug} { 
	    puts [format "%s DEBUG:\n" [string repeat "#" 60]]
	    puts "appDir ="
	    foreach dirName ${appDirs} { puts "\t${dirName}" }
	}

	# Get latest foundation flow information from server / tool install
	if {![llength $appDirs] && ${local}} {
	    puts "Warning: no \'foundation flow\' installation specified"
	    puts "\tPlease specify a local installation using the \'flows_search_path\' attribute"
	    puts "\tor the \'-location\' switch of \'flows avail\'"
	    puts "\tAlternatively, you can remove the \'-local\' switch to view what is available on the \'foundation flow\' server"
	    return
	}
	if {![llength $appDirs] && !$local} { set appDirs "N/A" }
	array set appInfo {} ;# Need since Nagelfar does not understand tcl_source is loading the values
        if {!$noserver} {
          eval get_server_info
        }
	array set masterInfo [array get appInfo]
	array unset appInfo
	# Compare master against each local foundation flow installation
	foreach appLoc $appDirs {
	    puts [format "%s\n" [string repeat "#" 80]]
	    puts "Applets Local/Server information: "
	    if {[file exists [format "%s/%s" $appLoc ".flowInfo"]]} {
		puts "  Local Install (${appLoc})"
		array set flowInfo "";# - this is done in a .flowInfo file
		tcl_source [format "%s/%s" $appLoc ".flowInfo"]; # get specific installation's information
                regsub -all ",version" [array names flowInfo *,version] "" availFlows
	    } else {
		set availFlows {}
		puts "  Local Install (${appLoc})  *** NOT VALID APPLET DIRECTORY ***"
	    }
      if {!$noserver} {
         if {[string match "remote" [get_attribute flows_mode /]]} { 
            puts "  Remote Server ([get_attribute flows_server /])"
         } else {
            puts "  Local Server  ([get_attribute flows_server /])"
         }
      } else {
         puts "  No server"
      }
	    puts ""
	    # collect name only of all master foundation flows
	    regsub -all ",version" [array names masterInfo *,version] "" masterFlows
	    # only include full list of install/uninstalled when -local is not used
	    if {!$local} { set availFlows [lsort -unique [concat $masterFlows $availFlows]] }
	    # generate header
            puts "                Name                | Local   | Server  | Summary Description"
            puts "                                    | Version | Version |"
            puts "------------------------------------+---------+---------+--------------------------------------------------------"
	    # generate information for all foundation flow specifiec by switches
	    foreach flowName [lsort $availFlows] {
		# Need to handle case where master no longer supports foundation flow
		set masterVer "N/A"
		if {[info exists masterInfo($flowName,version)]} { 
		    if {[info exists masterInfo($flowName,private)]} {
			set masterVer "*N/A"
		    } else {
			set masterVer $masterInfo($flowName,version) 
		    }
		}
		# Need to handle case where foundation flow was not installed
		set flowVer "N/A"
		if {[info exists flowInfo($flowName,version)]} { 
		    if {[info exists flowInfo($flowName,private)]} { 
			set flowVer "*N/A"
		    } else {
			set flowVer $flowInfo($flowName,version) 
		    }
		}
		
		if {[string match "*N/A" ${masterVer}] && [string match "*N/A" ${flowVer}]} { continue }

		# Extract summary information from master. If N/A extract from local.
		if {![string match "N/A" $masterVer]} { 
		    set summary $masterInfo($flowName,summary)
		} else {
		    set summary $flowInfo($flowName,summary)
		}
		# Output information
		regsub "::flows::" $flowName "" flowName
		puts [format "%35s |%8s |%8s | %s" $flowName $flowVer $masterVer $summary]
	    }
	    puts "\n"
	    puts "NOTE: To install a foundation flow, use \'flows setup -name \<foundation flow name\>\'"
	}
	array unset appInfo
    }
    
    hidden_proc setup {args} {
      puts "// Command: flows setup $args"
      variable appInfo
	
      set ffDirs [eval UpdateSearchPath [get_attribute flows_search_path /]]	;# Default update locations
      switch -- [parse_options [calling_proc] {} $args \
            "-name srs specifies the name of the flow to install" ffFlow \
            "-flowdir sos specifies location of foundation flow directory (default is FLOW/<name> under the current working directory)" ffDest \
            "-overwrite bos allows over-writing if flow already exists" overwrite \
            "-debug bOs enable debug message output" debug ] {
         -2 { return }
         0 { return -code error }
      }

      if {$ffDest eq ""} {
         set ffDest FLOW
      }
	
	file mkdir $ffDest
	
	if {[file exists ${ffDest}/${ffFlow}] && !$overwrite} {
	    puts "<FF> ERROR flows setup():  $ffFlow already exists under $ffDest"
	    puts "        Use -overwrite to replace"
	    return -code error
	}
	
	# Find the location of the flow
	set ff_flag 1
	foreach dir $ffDirs {
	    if {[file isdirectory ${dir}/${ffFlow}]} {
		puts "<FF> INFO flows setup():  Installed Flow \"${ffFlow}\" from $dir to ${ffDest}"
                if {[catch {file delete -force ${ffDest}/${ffFlow}} errorMsg]} {puts "<FF> WARNING flows setup() Failed to delete existing flow: ${ffDest}/${ffFlow}\n$errorMsg"}
                #
                # Copy everything (including dynamic links)
                #
		file copy -force ${dir}/${ffFlow} ${ffDest}

                #
                # For any links, resolve them by deleting the links and copying original files 
                # If a link happens to point to a nonexistent file, report an error. This indicates a corrupt flows directory.
                 ##nagelfar ignore
                if {[catch {::FFF::convert_dynamic_links_to_static_files ${ffDest}/${ffFlow} ${dir}/${ffFlow}} errorMsg]} {
                  puts "<FF-INT> ERROR: Foundation Flow may be corrupted. Please check that all links in the original flow directory point to actual files."
                }

		# Create the flow settings file from the master.  This allows user editing.
		set masterFlowFile [open ${dir}/.flowInfo r]
		set flowFile [open ${ffDest}/${ffFlow}/.${ffFlow}.flowInfo w]
		# Write the header
		set dateTime [clock format [clock seconds] -format "%b%d-%H%M%S"]
		puts $flowFile [format "%s" [string repeat "#" 80]]
		puts $flowFile "# Flow Info file created on $dateTime"
		puts $flowFile "# Original flowInfo file was ${dir}/.flowInfo"
		puts $flowFile "# Original flow directory was ${dir}/${ffFlow}"
		puts $flowFile [format "%s\n" [string repeat "#" 80]]
		
		while {[gets $masterFlowFile flowLine] != -1}  {
		    set pattern ::flows::${ffFlow}
		    if {[regexp $pattern $flowLine]} {
			puts $flowFile $flowLine
		    }
		}
		close $masterFlowFile
		close $flowFile
		set ff_flag 0
		break
	    }
	}
	
	if {$ff_flag} {
	    puts "<FF> ERROR flows setup():  $ffFlow does not exist in FF search path.  Check the name or path, and try again."
	}
    }
    hidden_proc installed {args} {
	switch -- [parse_options [calling_proc] {} $args \
		       "-flowdir sos specifies location of foundation flow directory (default is FLOW under the current working directory)" ffFlowDir \
		       "-debug bOs enable debug message output" debug ] {
			   -2 { return }
			   0 { return -code error }
        }
        if {$ffFlowDir eq ""} {
           set ffFlowDir FLOW
        }
        if {![file isdirectory $ffFlowDir]} {
           puts "FF-ERROR:  $ffFlowDir is not a directory.  Either no flows have been installed, or the directory was entered incorrectly."
           return -code error
        }

        # Print the header
        puts "Flows currently installed under $ffFlowDir"
        puts "------------------------+-------------+----------------------------------------------------------"
        puts "          Name          |    Version  | Summary Description"
        puts "------------------------+-------------+----------------------------------------------------------"

        # Process over the installed flows
        foreach flow [lsort [glob -nocomplain $ffFlowDir]] {
           # This file contains the flow info
           if {[file exists ${ffFlowDir}/${flow}/.${flow}.flowInfo]} {
              # This is a flow directory
              array set flowInfo "";# - this is done in a .flowInfo file
              tcl_source ${ffFlowDir}/${flow}/.${flow}.flowInfo
              set version $flowInfo(::flows::$flow,version)
              set summary $flowInfo(::flows::$flow,summary)
              puts [format "%23s |%12s | %s" $flow $version $summary]
           }
        }
        puts ""
    }

    hidden_proc write {args} {
        set dbgPrefixWs [string repeat " " [info level]]
        set msgPrefix "${dbgPrefixWs}flows [calling_proc]():"
        set Debug $::FFF::Debug
        if {[::FFF::get_tool] ne "lec" } {puts "// Command: flows [calling_proc] $args"}
	if {[info commands dbg_puts] eq ""} {namespace import ::FFF::dbg_puts}
	if {[info commands flatten_list] eq ""} {namespace import ::FFF::flatten_list}
        global vars
	##nagelfar syntax dbg_puts
	##nagelfar syntax flatten_list
	##nagelfar syntax read_foundation
	##nagelfar syntax write_foundation
	##nagelfar syntax write_foundation_template
	##nagelfar syntax elaborate_foundation
        dbg_puts "args: ->$args<-"
	
	upvar $::ns(flows)::localInstall localInstall
	
        set orig_argv ""
        set ffConfig ""
        set ffRunDir ""
        set ffStage ""
        set ffScript ""
        #set stage $flowInfo($flowName,RC)
	switch -- [parse_options [calling_proc] {} $args \
		       "-name srs specifies the name of the flow to run" ffFlow \
		       "-config srs specifies the config files for the run" ffConfig \
		       "-flowdir sos specifies location of foundation flow directory (default is FLOW/<name> under the current working directory)" ffFlowDir \
		       "-rundir sos specifies where to install write the runfiles (default is RC/<name> under the current working directory)" ffRunDir \
		       "-stage sos specifies the stage name to write (default is controlled by the flow variables)" ffStage \
		       "-script sos specifies the script name to write (default is controlled by the flow variables)" ffScript \
		       "-scriptDir sos specifies the directory to write scripts to (default is FF)" ffScriptDir \
		       "-vars sos specifies optional vars to provide to codegen.  Provide a list with var setting separated by semicolons" ffVars \
		       "-execute bos causes the flow to execute after codegen" execute \
		       "-no_relativize bos convert paths to files or directories to relative paths from the rundir (useful when vars(rundir) != vars(ff_exe_dir))" ffnoRelativizePaths \
		       "-debug bOs enable debug message output" debug ] {
			   -2 { return }
			   0 { return -code error }
        }
  
      #reset_foundation
      #
      # Error checking on config files
      #
      foreach file $ffConfig {
        if {![file exists $file]} {
           puts "<FF> ERROR flows write():  specified config file $file does not exist"
           return -code error
        }
      }
      #
      # Set a default for the flow dir
      #
      ##nagelfar ignore
      set $::ns(flows)::vars(config_files) [list [::FFF::flatten_list $ffConfig]]
      if {$ffFlowDir eq ""} {
         set ffFlowDir FLOW
      }

      #
      # Check that the flow was previously setup
      #
      if {![file isdirectory ${ffFlowDir}/${ffFlow}]} {
         puts "<FF> ERROR flows write():  specified flow $ffFlow does not exist"
         puts "<FF>   Check that 'flows setup' was run successfully on the ${ffFlow} flow"
         return -code error
      }
      #
      # Set a default for the rundir
      #
      if {$ffRunDir eq ""} {
         set ffRunDir RC/$ffFlow
      } else {
         set orig_argv "-u $ffRunDir"
      }

      #
      # Generate (potentially) a new rundir
      # This uses the various vars() variables (in the users's setup.tcl) to determine the final rundir name
      #
      ##nagelfar ignore
      set finalRunDir [::FFF::gen_new_rundir $orig_argv]
      ##nagelfar ignore
      set $::ns(flows)::vars(rundir) $finalRunDir

      if {$finalRunDir ne $ffRunDir} {
        puts "<FF> INFO flows write(): rundir set to: $finalRunDir"
      }
      file mkdir $finalRunDir

      # Parse the flow info file
      set flowInfoFile ${ffFlowDir}/${ffFlow}/.${ffFlow}.flowInfo
      if {![file exists $flowInfoFile]} {
         puts "<FF> ERROR flows write():  .${ffFlow}.flowInfo file does not exist in ${ffFlowDir}/${ffFlow}.  Flow is possibly corrupt"
         return -code error
      }
      array set flowInfo "";# - this is done in a .flowInfo file, but we do it here as well to pass nagelfars
      #
      # set up the flowInfo namespace variables
      # The flowInfo file defines what FCF and TCL files are to be read in to define the flow
      #
      tcl_source $flowInfoFile

      set flowName ::flows::$ffFlow
      set fcfFiles ""
      set setupFiles ""
      set configFiles ""

      # Name, Version, Summary (all extracted after sourcing $flowInfoFile)
      set headerflowName [flatten_list $flowInfo($flowName,summary)]
      set headerflowVersion [flatten_list $flowInfo($flowName,version)]
      set headerflowWhatis [flatten_list $flowInfo($flowName,whatis)]

      foreach file $flowInfo($flowName,fcf_files) {
         lappend fcfFiles ${ffFlowDir}/${ffFlow}/$file
      }
      foreach file $flowInfo($flowName,default_setup_files) {
         lappend setupFiles ${ffFlowDir}/${ffFlow}/$file
      }
      foreach file $flowInfo($flowName,default_config_files) {
         lappend configFiles ${ffFlowDir}/${ffFlow}/$file
      }
      # Preserve the user configs that create the flow
      foreach file $ffConfig {
         catch {file copy -force $file $finalRunDir/.}
      }
      set ffGen [catch {
         # Read in the default setup files
         read_foundation -noelab $setupFiles
         # Read in the user config files
         foreach file $ffConfig {
           read_foundation -config -noelab $file
         }

	 # set vars(rc_codegen) to true, which is used by default_config files to control
    	 # messaging during codegen
      	 $::FFF::config_objid_list($::FFF::myDefaultConfigName)->update_vars "set vars(rc_codegen) \"true\""
      	 set ::FFF::nonelabdb::vars(rc_codegen) "true"
      	 set ::FFF::elabdb::vars(rc_codegen) "true"
      	 set ::FFF::vars(rc_codegen) "true"
	 if {![namespace exists ::FF_LINT]} {namespace eval ::FF_LINT {}}
      	 set ::FF_LINT::vars(rc_codegen) "true"
      	 set vars(rc_codegen) "true"

         # Read in the default config files (default variable user customization).  This is needed after user config because of dependancies
         if {$configFiles ne ""} {
            read_foundation -noelab $configFiles
         }

	 # Set vars(script_dir) if it doesn't exist in the namespace
	 # Default: same as finalRunDir

         # set vars(script_dir) if not set
         if {![info exists ::FFF::vars(script_dir)]} {
           $::FFF::config_objid_list($::FFF::myDefaultConfigName)->update_vars "set vars(script_dir) [file normalize $finalRunDir]"
         } else {
           $::FFF::config_objid_list($::FFF::myDefaultConfigName)->update_vars "set vars(script_dir) [file normalize $::FFF::vars(script_dir)]"
	 }

	 if {![info exists ::FF_LINT::vars(script_dir]} {
      	   set ::FF_LINT::vars(script_dir) [file normalize $finalRunDir]
	 }
	 # Under the flows infrastructure, finalRunDir now represents the resolved rundir based on the flows write command and any vars(rundir) setting in the user's config file
         $::FFF::config_objid_list($::FFF::myDefaultConfigName)->update_vars "set vars(rundir) [file normalize $finalRunDir]"

         if {![info exists ::FFF::vars(ff_exe_dir)]} {
           $::FFF::config_objid_list($::FFF::myDefaultConfigName)->update_vars "set vars(ff_exe_dir) [file normalize .]"
         }

         # Read in the FCF files
         read_foundation -noelab $fcfFiles

         # Create flow header information step
         ::FFF::create_step ff_print_flow_version  \
	   -parameter_map "gendate \"[clock format [clock seconds]]\"" \
	   -parameter_map "user \"$::env(USER)\"" \
	   -parameter_map "applet_version \"[package versions ::applet::foundationflow]\"" \
           -parameter_map "flow_name \"$headerflowName\"" \
           -parameter_map "flow_version \"$headerflowVersion\"" \
           -parameter_map "flow_whatis \"$headerflowWhatis\"" {
#===========================================================================
# Description    : Foundation Flow Generated Script
# Generated on   : $gendate
# Generated by   : $user
#===========================================================================
# Flow Name      : $flow_name
# Flow Version   : $flow_version
# Flow Summary   : $flow_whatis
# Applet Version : $applet_version
#===========================================================================
}

         # Insert header into each stage
	 # Hardcoded using "-regexp syn*"
 	 # Need to undo this and parse all flows / stages
	 foreach synthStage [get_stage -instances -regexp syn*] {
           #$synthStage->insert_step [get_step ff_print_flow_version] -no_step_header -begin
	 }

         # Elaborate the whole thing
         elaborate_foundation

         #
         # If no stage is provided, and there is more than one stage, and 
         #  ffScript was provided, error out and mesg the user that a stage must be provided as well
         #
         ##nagelfar ignore
         if {$ffStage eq "" && [llength [get_stage -regexp *]] > 1 && $ffScript ne ""} {
           puts "<FF> ERROR flows write():  specified -script option but there is more than one stage defined."
           puts "<FF>   Stages defined for current flow:"
           puts "       ---------------"
           ##nagelfar ignore
           foreach stageObjID [get_stage -regexp *] {
             puts "       [$stageObjID->get_name]"
           }
           puts ""
           puts "<FF>   In order to use the -script option, you can only have one stage in the defined flow, or you must provide a -stage argument"
           puts "       to 'flows write', or simply use the stage names defined in the flow as the prefix name of each stage script."
           puts ""
           puts "       Example using the -stage argument:"
           puts "       ---------------"
           ##nagelfar ignore
           foreach stageObjID [get_stage -regexp *] {
             puts "       flows write -stage [$stageObjID->get_name] -script [$stageObjID->get_name].tcl"
           }
           return -code error
         }
         # 
         # If there is only a single stage, but it wasn't passed as an argument, and an ffScript argument was provided, assume that
         # the only stage that exists is the stage the user intended to write out
         #
         ##nagelfar ignore
         if {$ffStage eq "" && [llength [get_stage -regexp *]] == 1} {
           if {$ffScript ne ""} {
             puts "<FF> INFO flows write():  specified -script option but no stage argument provided."
             ##nagelfar ignore
             puts "<FF>     As there is only one stage defined ([[get_stage -regexp *]->get_name]), this will be the stage written out." 
             ##nagelfar ignore
           }
           # Set ffStage to the only stage found
           set ffStage [[get_stage -regexp *]->get_name]
           # $ffScript wasn't set, nor was a stage set, but there's only a single stage, so set the ffScript to the stage's script name
           set ffScript [[get_stage -regexp *]->get_script_name]
         }

         # Write out the script
         ##nagelfar syntax get_flow
         ##nagelfar syntax get_stage
         ##nagelfar syntax get_step
         ##nagelfar syntax get_name
         set flowObjID [get_flow -regexp *]
         if {[llength [get_stage -regexp *]] > 1} {
           foreach stageObjID [get_stage -regexp *] {
             set stageName [$stageObjID->get_name]
             $stageObjID->set_script_name ${stageName}.tcl
             # For future Makefile support
             #$stageObjID->set_tool "rc"
             #$stageObjID->set_tool_args "-64 -cmdfile $::FFF::vars(syn_log_dir)/${stageName}.cmd -logfile $::FFF::vars(syn_log_dir)/${stageName}.log -f"
             # 
             # Write out the script to the codegen dir
             #
             write_foundation_template -debug -overwrite -nomake -stage $stageName -script $finalRunDir/[$stageObjID->get_script_name] -rundir $finalRunDir
             lappend writtenScripts $finalRunDir/[$stageObjID->get_script_name].tcl
             #write_foundation_template -debug -overwrite -nomake -stage $stage -script $finalRunDir/$ffScript -rundir $finalRunDir
             #write_foundation_template -debug -overwrite -makefile $finalRunDir/Makefile
           }
         } else {
           write_foundation_template -debug -overwrite -nomake -stage $ffStage -script $finalRunDir/$ffScript -rundir $finalRunDir
           lappend writtenScripts $finalRunDir/$ffScript 
         }

         write_foundation -quiet -norundircfg -escaped -edi -overwrite -file $finalRunDir/vars.tcl.tmp -rundir $finalRunDir 

         puts "-------------------------------------------------"
         puts "<FF> Finalizing Foundation Flow Variables"


         namespace eval ::FFF_TMP {} {
           set rcff_vars ""
         }
         # set variable to point to vars file
         set ::FFF_TMP::rcff_vars $finalRunDir/vars.tcl.tmp

         namespace eval ::FFF_TMP {
           proc set {args} {
             ::set varName [lindex $args 0]
             ::set varValue [lrange $args 1 end]
             ::set ::FFF_TMP::$varName $varValue
             #puts "::set ::FFF_TMP::$varName $varValue"
           }
           #
           # Source variables into temporary namespace (FFF_TMP).
           #
           puts "<FF-INT> Importing varables from $::FFF_TMP::rcff_vars"
           if {![catch {source $::FFF_TMP::rcff_vars} errorMessage]} {
            # file delete $::FFF_TMP::rcff_vars
           } else {
             puts "<FF-INT> Internal Error. Problem with sourcing $::FFF_TMP::rcff_vars"
             puts "<FF-INT> Please contact the Cadence Customer Support."
           }

           #
           # This is a helper proc to help testing whether variables have changed
           #
           proc flatten_ws {var} {
             # Convert all multiple whitespace to single spaces
             # Remove curlies
             regsub  {^\{} $var {} var
             regsub  {\}$} $var {} var
             regsub -all {\s+} $var { } var
             # Do again, incase there were any 2-space whitespace sections
             regsub -all {\s+} $var { } var
             # Remove leading and trailing ws
             regsub  {^\s} $var {} var
             regsub  {\s$} $var {} var
             return $var
           }
         }

         # Copy vars from FFF_TMP into global namespace
         # Report any changes
         # puts "global vars(process): $vars(process)"

         namespace eval :: {} {
           puts "<FF> Total vars prior to RCFF Import: [llength [array names ::vars]]"
           foreach key [array names ::FFF_TMP::vars] {
               #puts "<FF INCOMING FROM RCCODEGEN>: vars($key)  = $vars($key)"
             if {[info exists ::vars($key)] && [::FFF_TMP::flatten_ws $::vars($key)] ne [::FFF_TMP::flatten_ws $::FFF_TMP::vars($key)]} {
               puts "<FF> INFO: RCFF redefined the variable: vars($key) as follows"
               puts "OLD vars($key): [::FFF_TMP::flatten_ws $::vars($key)]"
               puts "NEW vars($key): [::FFF_TMP::flatten_ws $::FFF_TMP::vars($key)]"
             }
           #  set ::vars($key) $::FFF_TMP::vars($key)
             set ::vars($key) [::FFF_TMP::flatten_ws $::FFF_TMP::vars($key)]
           }
           puts "<FF> Total vars after RCFF Import: [llength [array names ::vars]]"
         }

         if {$::FFF::vars(fff_info_level) == 99} {
           foreach key [lsort -dictionary [array names ::vars]] {
             puts "<FF IMPORTING TO GLOBAL NS>: vars($key)  = $::vars($key)"
           }
         }

	 # NOTE: $ffnoRelativizePaths defaults to 0
	 if {!$ffnoRelativizePaths} {
	   dbg_puts "Starting variable relativization"
           # Relativize the variables
           # i.e. substitute plugdirs with variable referencing by replacing actual dir with [subst $vars(plug_dir)]) before writing vars.tcl

           set relativizeMesgLog ""
           # First relativize ff_exe_dir. Ignore plug variables for now (maybe this can be relaxed?)
           # All files in this first relativization task must exist. Skip anything that is located in vars(rundir).
           ##nagelfar ignore
           set relativizeMesgLog "$relativizeMesgLog [::FFF::remove_outer_braces [::FFF::relativizeFileOrDir -vardir ff_exe_dir -mustExist -skipVar script_dir -skipVar ff_exe_dir -skipVar rc_plug_dir -skipVar lec_plug_dir -skipVar plug_dir -skipVar rundir -skipDir [file normalize $vars(rundir)]]]"
           # Relativize all files in rundir. Skip variable referencing, meaning do not include $vars(rundir) in the final variable value
           ##nagelfar ignore
           set relativizeMesgLog "$relativizeMesgLog [::FFF::remove_outer_braces [::FFF::relativizeFileOrDir -vardir rundir -skipVariableUsageInReference -skipVar script_dir]]"
           # Swap out the invidiual plug dir variables
	   # NOTE - in cases where lec_plug_dir == rc_plug_dir == plug_dir, plug_dir has precedence and will be used for all plugins
           foreach dir "lec_plug_dir rc_plug_dir plug_dir" {
             if {[info exists vars($dir)]}  {
	        if {[file normalize $vars($dir)] ne [file normalize $vars(ff_exe_dir)]} {
                  # Relativize the plugin (syn_load_rtl goes from ./plug/rc/syn_load_rtl.tcl to $vars(rc_plug_dir)/syn_load_rtl.tcl)
	   	  # If $vars(dir) == $vars(ff_exe_dir), then we just use $vars(ff_exe_dir) as the variable reference
	          # Note that vars(ff_exe_dir) substitution already occurred earlier
                  ##nagelfar ignore
                  set relativizeMesgLog "$relativizeMesgLog [FFF::remove_outer_braces [FFF::relativizeFileOrDir -vardir $dir -mustExist \
                     -exactSubDirMatch [file normalize $vars($dir)]]]"
	        }
                # Swap out the invidiual plug dir variables ($vars(rc_plug_dir) goes from ./plug/rc to $vars(ff_exe_dir)/plug/rc)
                ##nagelfar ignore
                set relativizeMesgLog "$relativizeMesgLog [FFF::remove_outer_braces [FFF::relativizeFileOrDir -vardir ff_exe_dir -mustExist -var $dir]]"
             }
           }
         }
         # Write the final vars.tcl

         # BCL: The following are set using variables in the generated .ff.tcl, and are therefore pulled out of the generated vars.tcl
         set skipVarList {ff_exe_dir rundir plug_dir rc_plug_dir lec_plug_dir script_dir}

         # BCL: Changed to tcl file mkdir
         set op [open $finalRunDir/vars.tcl w]

         puts $op "# ############################################################################ #"
         puts $op "# Foundation Flow Codegen Vars Record"
         puts $op "# Executed on [clock format [clock seconds] -format "%I:%M:%S %p(%b%d)"] by user: $::env(USER)"
         puts $op "# Copyright 2008-2012, Cadence Design Systems, Inc."
         puts $op "# All Rights Reserved"
         puts $op "# ############################################################################ #"
         puts $op ""
         puts $op "# This file contains all default (seeded) variables and user-defined variables that were resolved during code generation."

         puts $op "if {!\[info exists vars\]} {"
         puts $op "   global vars"
         puts $op "}"
         puts $op ""

         puts $op "#"
         puts $op "# Referenced Variables"
         puts $op "# The followin variables may or may not be used to resolve other variables in this file, so they appear in the beginning."
         puts $op "set vars(ff_exe_dir) \"$vars(ff_exe_dir)\""
         puts $op "set vars(rundir) \"$vars(rundir)\""
         puts $op "set vars(script_dir) \"$vars(script_dir)\""
         if {[info exists vars(plug_dir)]}     {puts $op "set vars(plug_dir) \"$vars(plug_dir)\""}
         if {[info exists vars(rc_plug_dir)]}  {puts $op "set vars(rc_plug_dir) \"$vars(rc_plug_dir)\""}
         if {[info exists vars(lec_plug_dir)]} {puts $op "set vars(lec_plug_dir) \"$vars(lec_plug_dir)\""}
         puts $op "#"

         foreach var [lsort [array names vars]] {
            # BCL: Only write out variable values in curlies if not using [subst ...]
            if {[lsearch $skipVarList $var] == -1} {
              if {[regexp {\$} $vars($var)]} {
                puts $op "set vars($var) \"$vars($var)\""
              } else {
                puts $op "set vars($var) \{$vars($var)\}"
              }
            }
         }
         ##nagelfar ignore
         close $op

         set op [open $vars(script_dir)/relativize_vars.rpt w]
         puts $op "# ############################################################################ #"
         puts $op "# Foundation Flow Variable Relativization Report"
         puts $op "# Copyright (c) 1997-[clock format [clock seconds] -format %Y] Cadence Design Systems, Inc. All Rights Reserved."
         puts $op "# Executed on [clock format [clock seconds] -format "%I:%M:%S %p(%b%d)"] by user: $::env(USER)"
         puts $op "# ############################################################################ #"
         foreach line $relativizeMesgLog {
           puts $op $line
         }
         close $op

         lappend writtenScripts $finalRunDir/vars.tcl
      } errorMsg ]

      if {$ffGen} {
         puts "ERROR:  foundation flow failed to complete properly"
         puts $errorMsg
         return -code error
      } elseif {$execute} {
         puts "INFO:  Executing the generated flow"
         puts source $finalRunDir/$ffScript
      } else {
         puts "##################################################"
         puts "<FF> INFO flows write():  Wrote the following scripts:"
         foreach script $writtenScripts {
           puts "<FF>  $script"
         }
         puts "##################################################"
      }
    }

   hidden_proc run {args} {
     puts "// Command: flows run $args"
     upvar $::ns(flows)::localInstall localInstall
        
     ##nagelfar syntax run_foundation
     #nagelfar ignore
     set flows_write_rundir [set $::ns(flows)::vars(rundir)]
        switch -- [parse_options [calling_proc] {} $args \
                       "-stage srs specifies the name of the stage to run" ffStage \
                       "-rundir sos specifies where to install write the runfiles (default is RC/<name> under the current working directory)" ffRunDir \
                       "-debug bOs enable debug message output" debug ] {
                           -2 { return }
                           0 { return -code error }
        }
     #
     # Check if the stage exists (and was elaborated)
     #
     if {[get_stage -basename $ffStage] eq "-1"} {
       puts "<FF> ERROR flows run(): stage $ffStage does not exist. Available stages:"
       report_stages
       return -code error
     }
     if {[info exists ffRunDir] && $ffRunDir ne "" && [file normalize $flows_write_rundir] ne [file normalize $ffRunDir]} {
       puts "<FF> WARNING flows run(): -rundir $ffRunDir provided to flows run() does not match rundir generated during \"flows write()\": $flows_write_rundir"
       puts "<FF>                      Using -rundir $ffRunDir."
       run_foundation -stage $ffStage -rundir $ffRunDir
     } else {
       run_foundation -stage $ffStage -rundir $flows_write_rundir
     }
   }

   hidden_proc whatis args {
      variable flowInfo

      set flowDirs [eval UpdateSearchPath [get_attribute flows_search_path /]]	;# Default update locations

      switch -- [parse_options [calling_proc] {} $args \
             "-detail bos reports detailed description of foundation flow (default is short description)" detail \
             "-noserver bos gets information exclusively from local server" noserver \
             "srs list of flows to report information for" flowList] {
            -2 { return }
            0 { return -code error }
      }

      # Get latest applet information from server / tool install
      array set flowInfo {} ;# Need since Nagelfar does not understand tcl_source is loading the values
      if {!$noserver} {
         eval get_server_info
      }
      array set masterInfo [array get flowInfo]
      array unset flowInfo
      foreach flowName $flowList {
         if {![regsub "::flows::" $flowName "" shortName]} {
            set shortName ${flowName}
            set flowName "::flows::${flowName}"
         }
         foreach flowLoc $flowDirs {
            tcl_source [format "%s/%s" $flowLoc ".flowInfo"]; # get specific installation's information
            if {[info exists flowInfo($flowName,summary)]} {
               puts "Foundation Flow: $shortName"
               puts "\tLocation: [file normalize $flowLoc]"
               puts "\tVersion:  $flowInfo($flowName,version)"
               puts "\tSummary:  $flowInfo($flowName,summary)\n"
               if {$detail} {
                  puts "\tFull Description:"
                  if {[info exists flowInfo($flowName,detailFile)]} {
         puts "[format "%s/%s" $flowLoc/$shortName $flowInfo($flowName,detailFile)]"
                     set flowFile [open [format "%s/%s" $flowLoc/$shortName $flowInfo($flowName,detailFile)] r]
                     # open applet file and extract full description information
                     while {[gets $flowFile flowLine] != -1}  {
                           puts "\t$flowLine"
                     }
                     close $flowFile
                  } else {
                     puts "No details available for flow $shortName"
                  }
               }
            } elseif {[info exists masterInfo($flowName,summary)]} {
               puts "Flow: ${shortName} (currently not installed)"
               puts "\tLocation: Server"
               puts "\tVersion:  $masterInfo($flowName,version)"
               puts "\tSummary:  $masterInfo($flowName,summary)\n"
               if {$detail} {
                  puts "Info: \'-detail\' not available for server applets. Please install locally"
               }
            } else {
               array unset flowInfo
               return -code error "Error: foundation flow \'$shortName\' not found. Please check the flows_search_path attribute and the flow names"
            }
         }
      }
      array unset appInfo
      return
   }
   hidden_proc version {args} {
   }

    hidden_proc get_server_info {args} {
	variable appInfo
	array unset appInfo

	foreach xferDir [glob -nocomplain "$::env(HOME)/.cadence_app_*"] { file delete -force ${xferDir} }
	set xferDir "$::env(HOME)/.cadence_app_[pid]"

	if {[llength $args] || [regexp {^(h|he|hel|help)} $args]} { return -code error "\nUsage: [calling_proc]\n" }

	# Make sure flows exited cleanly or a .app directory is not in use by user
	if {[file exists "${xferDir}"]} {
	    puts "Error: Either the \'flows\' application exited unexpectedly on a previous session"
	    puts "\tor a directory \'${xferDir}\' already existed. Please remove such directory"
	    return -code error
	} 

	if {[string match "remote" [get_attribute flows_mode /]]} {
	    # Directory is necessary to ensure user files are not overwritten	    
	    if {[catch {file mkdir ${xferDir}} errMsg]} { return -code error "Error: Current directory must have write access when in \'remote\' mode" }
	    
	    set serverName [lindex [split [get_attribute flows_server /] :] 0]
	    puts "Info: Connecting to server...."
	    if {[catch {exec ping -c 1 $serverName} errMsg]} { return -code error  "Error: Applet server not accessible. Please check your connection" }
	    puts "Info: Collecting foundation flow server information..."
#	    file mkdir ${xferDir}
	    if {[catch {exec lftp -u [get_attribute flows_server_user /],[get_attribute flows_server_pass /] -e "lcd ${xferDir};get .flowInfo ;exit;" [get_attribute flows_server /]} errMsg]} {
		if {[regexp -nocase {failed} $errMsg]} {
		    puts "Error: remote server \'flows\' information not available or not complete. Please check"
		    puts "\tthe server location or your server installation may be corrupted"
		    file delete -force ${xferDir}
		    puts "$errMsg"
		    return -code error
		} 
	    }
	    set serverInfo [file join ${xferDir} ".flowInfo"]
	} else {
	    set serverInfo [file join [get_attribute flows_server /] ".flowInfo"]
	    if {![file exists $serverInfo]} { 
		puts "Error: local server \'flows\' information not available or not complete. Please check"
		puts "\tthe server location or your server installation may be corrupted"
		return -code error 
	    }
	    puts "Info: Collecting foundation flow server information..."
	}
	tcl_source ${serverInfo}
	file delete -force ${xferDir}
    }


   hidden_proc flows {args} {
      # record source_verbose status for restoring later
      set srcVerbose [get_attribute source_verbose /]
      set_attribute -quiet source_verbose false /

      set subcmdInfo {}
      lappend subcmdInfo [list "avail"   "visible" "$::ns(flows)::avail"      "list all flows that are available"]
      lappend subcmdInfo [list "setup" "visible" "$::ns(flows)::setup"    "setup named flow into the specified location"]
      lappend subcmdInfo [list "installed" "visible" "$::ns(flows)::installed"    "list all flows setup in the current directory"]
      lappend subcmdInfo [list "write" "visible" "$::ns(flows)::write"    "run codegen on the specified flow and config files"]
      lappend subcmdInfo [list "run" "visible" "$::ns(flows)::run"    "run codegen on the specified flow and config files, and execute"]
      lappend subcmdInfo [list "whatis"  "visible" "$::ns(flows)::whatis"     "display info on the specified flows"]
      lappend subcmdInfo [list "version" "visible" "$::ns(flows)::version"    "return version information"]
      dispatch_subcommand flows $args $subcmdInfo "manage RTL-Compiler Foundation Flows" 

      set_attribute -quiet source_verbose ${srcVerbose} /
   }
}

if {![llength [info commands ::flows]]} { 
    namespace import $::ns(flows)::flows 
    add_command_help flows "main command to install/manage/update Foundation Flows" "FoundationFlows"
}

if {![llength [info commands ::load_applet]]} { 
    namespace import ::FFF::load_applet
    add_command_help flows "load in an applet; support optional min version requirement"
}
namespace eval FFF {} {
  # Define Configuration Object
  define_configuration_object
  define_flow_object
  define_parameter_configuration_object
  define_plugin_instance_object
  define_plugin_object
  define_stage_instance_object
  define_stageiterator_object
  define_stage_object
  define_step_instance_object
  define_step_object

  # Create Default Configuration for EDI-FF backward compatibility
  namespace eval ${nonelabns} {} {
    ::define_configuration_object
  }
  variable myDefaultConfigObjID
  set myDefaultConfigObjID [new ${nonelabns}::Configuration $myDefaultConfigName]
  set ::FFF::config_objid_list($myDefaultConfigName) $myDefaultConfigObjID
}

# Initialization
::FFF::init_elab_db
::FFF::init_create_configuration
::FFF::init_create_flow
::FFF::init_create_stage
::FFF::init_create_step
::FFF::init_set_wrapper_in_elabns
::FFF::init_set_wrapper_in_nonelabns
if {![info exists ::ns(compat)]}  { set ::ns(compat) "::aeware" }
if {![info exists ::ns(applet)]}  { set ::ns(applet) "${::ns(compat)}::applet" }
#
# NOTE: pkgRev and pkgDate should be subbed out
# when this file is integrated into the applet.
#
namespace eval $::ns(applet) {
  proc applet_init_foundationflow {} {
    if {[info exists ::FFF::testMode] && $::FFF::testMode eq "Beta"} {
      regexp {\d+(\.\d+)+} {@Revision: 1.162 @} pkgRev
      regexp {\S+\s(\d+)/(\d+)/(\d+)\s\S+} {@Date: 2012/08/10 03:08:16 @} full pkgYear pkgMonth pkgDay
      puts "// ============================================================"
      puts "// Welcome to the Frontend Foundation Flow System"
      puts "// Release (Beta): $pkgRev Built on $pkgMonth/$pkgDay/$pkgYear"
      #puts "// Release (Beta): $pkgRev$ Built on $pkgDate$"
      puts "// Copyright (c) 1997-[clock format [clock seconds] -format %Y] Cadence Design Systems, Inc. All Rights Reserved."
      puts "// FCF Versions Supported: $::FFF::supported_fcf_versions"
      puts "// Available user API commands:"
      puts "//"
      foreach cmd $::FFF::user_api_commands {
        puts "//  $cmd"
      }
      puts "//"
      puts "// flows super command How to:"
      puts "// ---------------------------"
      puts "// To see available flows:"
      puts "//   flows avail \[-noserver\]"
      puts "// To setup a flow:"
      puts "//   flows setup -name <flow name>"
      puts "// To write a flow:"
      puts "//   flows write -name <flow name> -config <config list>"
      puts "// To run a flow:"
      puts "//   flows run -stage <stage name>"
      puts "//"
      puts "// ============================================================"
      puts ""
    }
  }
}

# pragma protect end
regexp {\d+(\.\d+)+} {@Revision: 1.162 @} pkgRev
package provide ::applet::foundationflow $pkgRev
#===========================================================================
# Date Modified : @Date: 2012/08/10 03:08:16 @
# Version       : @Revision: 1.162 @
# Summary       : Foundation Flow Applet
# Keywords      : foundation flow FCF create_flow insert_flow create_step insert_step
#===========================================================================
#
# Copyright 1997-2012 Cadence Design Systems, Inc.  All rights reserved worldwide. 
#
# The Tcl computer program and related information (collectively "Licensed Material") 
# contained herein are protected by copyright law and international treaties. 
#
# Cadence grants Recipient of the Licensed Material a nonexclusive right
# to use, copy, and modify the Licensed Material.   Should Recipient
# desire to distribute any portion of the Licensed Material, Recipient
# must obtain Cadence's permission.  In no event shall Recipient use the 
# Licensed Material for benchmarking purposes against Cadence's products.   
#
# The Licensed Material is provided to Recipient to use at Recipient's
# own risk. The Licensed Material may not be compatible with current or 
# future versions of Cadence products, and Cadence will not provide any 
# technical support for the Licensed Material, whether modified or not 
# by the Recipient.  THE LICENSED MATERIAL IS PROVIDED "AS IS" AND WITH 
# NO WARRANTIES, INCLUDING WITHOUT LIMITATION ANY EXPRESS WARRANTIES OR 
# IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR USE.
#
# IN NO EVENT SHALL CADENCE BE LIABLE TO RECIPIENT OR ANY THIRD PARTY
# FOR ANY INCIDENTAL, INDIRECT, SPECIAL OR CONSEQUENTIAL DAMAGES, OR ANY 
# OTHER DAMAGES WHATSOEVER (INCLUDING, WITHOUT LIMITATION, DAMAGES FOR
# LOSS OF BUSINESS PROFITS, BUSINESS INTERRUPTION, LOSS OF BUSINESS 
# INFORMATION, OR OTHER PECUNIARY LOSS) ARISING OUT OF THE USE OR
# INABILITY TO USE LICENSED MATERIAL, WHETHER OR NOT THE POSSIBILITY OR 
# CAUSE OF SUCH DAMAGES WAS KNOWN TO CADENCE.
#
# Cadence Design Systems, Inc.
# 2655 Seely Avenue
# San Jose, CA 95134
#
#===========================================================================
