###############################################################################
#                       CADENCE COPYRIGHT NOTICE
#         © 2008-2013 Cadence Design Systems, Inc. All rights reserved.
#------------------------------------------------------------------------------
#
# This Foundation Flow is provided as an example of how to perform specialized
# tasks.
#
# This work may not be copied, re-published, uploaded, or distributed in any way,
# in any medium, whether in whole or in part, without prior written permission
# from Cadence. Notwithstanding any restrictions herein, subject to compliance
# with the terms and conditions of the Cadence software license agreement under
# which this material was provided, this material may be copied and internally
# distributed solely for internal purposes for use with Cadence tools.
#
# This work is Cadence intellectual property and may under no circumstances be
# given to third parties, neither in original nor in modified versions, without
# explicit written permission from Cadence. The information contained herein is
# the proprietary and confidential information of Cadence or its licensors, and
# is supplied subject to, and may be used only by Cadence's current customers
# in accordance with, a previously executed license agreement between Cadence
# and its customer.
#
#------------------------------------------------------------------------------
# THIS MATERIAL IS PROVIDED BY CADENCE "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
# IN NO EVENT SHALL CADENCE BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL
# OR CONSEQUENTIAL DAMAGES HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT  (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  MATERIAL, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
###############################################################################

package provide foundation_flow 1.0

namespace eval FF_EDI:: {

   ###############################################################################
   # Procedure to seed certain flow variables to a known default value as well
   # as data variables required to seed the generic configuration file
   ###############################################################################
   proc seed_variables {{force 0}} {

      global vars
      global rda_defaults
      global udm
      global env
      global infos
      global warnings
      global errors
      global fargs 
      global dargs 

      if {$force} {
         if {[info exists vars(seed)]} {
            unset vars(seed)
         }
      }

      if {![info exists vars(seed)]} {

         puts "<FF> Seeding variables ..."

         if {![info exists vars(warning_count)]} {
            set vars(warning_count) 0
         }
         if {![info exists vars(error_count)]} {
            set vars(error_count) 0
         }
         if {![info exists vars(info_count)]} {
            set vars(info_count) 0
         }

      ###############################################################################
      # Set vars(version) to "14.1.0" if not defined
      ###############################################################################
         if {![info exists vars(version)]} {
            if {[info exists fargs(version)]} {
#               puts "<FF> INFO: Variable vars(version) not defined - setting to '$fargs(version)'"
               set vars(version) $fargs(version)
            } else {
               set vars(version) $dargs(version)
            }
            set vars(flow) mmmc
         } else {
            if {([lsearch $FF::valid_versions $vars(version)] < 0)} {
               set msg "Version '$vars(version)' not supported - setting to '14.1.0'"
               puts "<FF> WARNING: $msg"
               append commands "#  $msg\n"
               set warnings($vars(warning_count)) $msg
               incr vars(warning_count)
               set vars(flow) mmmc
               set vars(version) "14.1.0"
            } else {
               if {[lindex [split $vars(version) "."]  0] > 10} {
                  set vars(flow) mmmc
               }
            }
         }

         if {[regexp "9.1" $vars(version)]} {
            set vars(enable_ldb) FALSE
         }

         if {[info exists vars(enable_ldb)] && $vars(enable_ldb)} {
            append commands [FF_EDI::run_compile] 
         }

      ###############################################################################
      # Set vars(flow) to "mmmc" if not defined
      ###############################################################################
         if {![info exists vars(flow)]} {
            puts "<FF> INFO: Variable vars(flow) not defined - setting to 'mmmc'"
            set vars(flow) mmmc
         } else {
            if {([lsearch [list "default" "pr_mmmc" "mmmc"] $vars(flow)] < 0)} {
               puts "<FF> WARNING: Flow type '$vars(flow)' not supported - setting to 'mmmc'"
               append commands "#  WARNING: Flow type '$vars(flow)' not supported - setting to 'mmmc'\n"
               set warnings($vars(warning_count)) "Flow type '$vars(flow)' not supported - setting to 'mmmc'"
               incr vars(warning_count)
               set vars(flow) mmmc
            }
         }

      ###############################################################################
      # Make sure all scaling factors are either set or are 1.0 ... also
      # support backwards compatibility of old names
      ###############################################################################
         set map(pre_route_res_factor) def_res_factor
         set map(pre_route_clk_res_factor) def_clk_res_factor
         set map(pre_route_cap_factor) def_cap_factor
         set map(pre_route_clk_cap_factor) def_clk_cap_factor
         set map(post_route_res_factor) det_res_factor
         set map(post_route_clk_res_factor) det_clk_res_factor
         set map(post_route_cap_factor) det_cap_factor
         set map(post_route_clk_cap_factor) det_clk_cap_factor
         set map(post_route_xcap_factor) xcap_factor

         foreach rc_corner $vars(rc_corners) {
            foreach option "pre_route_res_factor pre_route_clk_res_factor \
                            post_route_res_factor post_route_clk_res_factor \
                            pre_route_cap_factor pre_route_clk_cap_factor \
                            post_route_cap_factor post_route_clk_cap_factor \
                            post_route_xcap_factor" {
               if {![info exists vars($rc_corner,$option)] && [info exists vars($rc_corner,$map($option))]} {
                  append commands "#  INFO: Variable $map($option) has been changed to $option ... please update\n"
                  set infos($vars(info_count)) "Variable $map($option) has been changed to $option ... please update"
                  incr vars(info_count)
                  set vars($rc_corner,$option) $vars($rc_corner,$map($option))
               }
            }
         }

      ###############################################################################
      # The following will be used to seed the config file
      ###############################################################################

         if {![FF::is_lp_flow]} {
            set max_libs [list]
            set min_libs [list]

            set count 0

            if {[info exists vars($vars($vars(default_setup_view),delay_corner),library_set)]} {
               foreach lib $vars($vars($vars($vars(default_setup_view),delay_corner),library_set),timing) {
                  if {[lsearch $max_libs $lib] == -1} {
                     lappend max_libs $lib
                     incr count
                  }
               }
            } else {
               if {[info exists vars($vars($vars(default_setup_view),delay_corner),late_library_set)]} {
                  foreach lib $vars($vars($vars($vars(default_setup_view),delay_corner),late_library_set),timing) {
                     if {[lsearch $max_libs $lib] == -1} {
                        lappend max_libs $lib
                        incr count
                     }
                  }
               }
            }

            if {![info exists vars(timelib,max)]} {
               set vars(timelib,max) $max_libs
            }

            if {[info exists vars($vars($vars(default_hold_view),delay_corner),library_set)]} {
               foreach lib $vars($vars($vars($vars(default_hold_view),delay_corner),library_set),timing) {
                  if {[lsearch $min_libs $lib] == -1} {
                     lappend min_libs $lib
                     incr count
                  }
               }
            } else {
               if {[info exists vars($vars($vars(default_hold_view),delay_corner),early_library_set)]} {
                  foreach lib $vars($vars($vars($vars(default_hold_view),delay_corner),early_library_set),timing) {
                     if {[lsearch $min_libs $lib] == -1} {
                        lappend min_libs $lib
                        incr count
                     }
                  }
               }
            }

            if {![info exists vars(timelib,min)]} {
               set vars(timelib,min) $min_libs
            }

            if {![info exists vars(timelib)]} {
               set vars(timelib) ""
            }

            set vars(cdb_file) ""
            set vars(cdb_file,min) ""
            set vars(cdb_file,max) ""

            if {[info exists vars($vars($vars(default_setup_view),delay_corner),library_set)]} {
               if {[info exists vars($vars($vars($vars(default_setup_view),delay_corner),library_set),si)]} {
                  set vars(cdb_file,max) $vars($vars($vars($vars(default_setup_view),delay_corner),library_set),si)
               }
            } elseif {[info exists vars($vars($vars(default_setup_view),delay_corner),late_library_set)]} {
               if {[info exists ars($vars($vars($vars(default_setup_view),delay_corner),late_library_set),si)]} {
                  set vars(cdb_file,max) $vars($vars($vars($vars(default_setup_view),delay_corner),late_library_set),si)
               }
            } else {
               set vars(cdb_file,max) ""
            }
            if {[info exists vars($vars($vars(default_hold_view),delay_corner),library_set)]} {
               if {[info exists vars($vars($vars($vars(default_hold_view),delay_corner),library_set),si)]} {
                  set vars(cdb_file,min) $vars($vars($vars($vars(default_hold_view),delay_corner),library_set),si)
               }
            } elseif {[info exists vars($vars($vars(default_hold_view),delay_corner),early_library_set)]} {
               if {[info exists vars($vars($vars($vars(default_hold_view),delay_corner),early_library_set),si)]} {
                  set vars(cdb_file,min) $vars($vars($vars($vars(default_hold_view),delay_corner),early_library_set),si)
               }
            } else {
               set vars(cdb_file,min) ""
            }
            if {[info exists vars($vars($vars(default_setup_view),constraint_mode),pre_cts_sdc)]} {
               if {$vars(flow) != "mmmc"} {
                  set vars(timingcon_file) $vars($vars($vars(default_setup_view),constraint_mode),pre_cts_sdc)
               }
               set vars(pre_cts_sdc) $vars($vars($vars(default_setup_view),constraint_mode),pre_cts_sdc)
            }
            if {[info exists vars($vars($vars(default_setup_view),constraint_mode),pre_cts_ilm_sdc)]} {
               if {$vars(flow) != "mmmc"} {
                  set vars(timingcon_file,full) $vars($vars($vars(default_setup_view),constraint_mode),pre_cts_ilm_sdc)
               }
            }
            if {[info exists vars($vars($vars(default_setup_view),constraint_mode),incr_cts_sdc)]} {
               set vars(incr_cts_sdc) $vars($vars($vars(default_setup_view),constraint_mode),incr_cts_sdc)
            }
            if {[info exists vars($vars($vars(default_setup_view),constraint_mode),post_cts_sdc)]} {
               set vars(post_cts_sdc) $vars($vars($vars(default_setup_view),constraint_mode),post_cts_sdc)
            }

            if {[info exists vars($vars($vars($vars(default_hold_view),delay_corner),rc_corner),cap_table)] &&\
                [info exists vars($vars($vars($vars(default_setup_view),delay_corner),rc_corner),cap_table)]} {
               set vars(captbl_file) [concat \
                    "-best" $vars($vars($vars($vars(default_hold_view),delay_corner),rc_corner),cap_table) \
                    "-worst" $vars($vars($vars($vars(default_setup_view),delay_corner),rc_corner),cap_table) \
                   ]
               set vars(wc_cap_table) $vars($vars($vars($vars(default_setup_view),delay_corner),rc_corner),cap_table)
            } else {
               if {[info exists vars($vars($vars($vars(default_setup_view),delay_corner),rc_corner),cap_table)]} {
                   set vars(captbl_file) [concat \
                       "-best" $vars($vars($vars($vars(default_setup_view),delay_corner),rc_corner),cap_table) \
                       "-worst" $vars($vars($vars($vars(default_setup_view),delay_corner),rc_corner),cap_table) \
                   ]
                   set vars(wc_cap_table) $vars($vars($vars($vars(default_setup_view),delay_corner),rc_corner),cap_table)
               } else {
                  set vars(captbl_file) ""
               }
            }
         } else {
            set vars(timelib) ""
            set vars(cdb_file) ""
            set vars(timelib,max) ""
            set vars(cdb_file,max) ""
            set vars(timelib,min) ""
            set vars(cdb_file,min) ""
            set found_max 0 
            set found_min 0 

            if {[info exists vars(setup_analysis_views)] && [info exists vars(hold_analysis_views)]} {
               foreach view $vars(setup_analysis_views) {
                  if {[info exists vars($vars($view,delay_corner),library_set)]} {
                     if {[info exists vars($vars($vars($view,delay_corner),library_set),timing)]} {
                        foreach file $vars($vars($vars($view,delay_corner),library_set),timing) {
                           if {[lsearch $vars(timelib,max) $file] == -1} {
                              lappend vars(timelib,max) $file
                           }
                           set found_max 1
                        }
                     } else {
                        puts "<FF> WARNING: Variable vars($vars($vars($view,delay_corner),library_set),timing) not defined"
                        set warnings($vars(warning_count)) "Variable vars($vars($vars($view,delay_corner),library_set),timing) not defined"
                        incr vars(warning_count)
                     }
                  } else {
                     if {![info exists vars($vars($view,delay_corner),early_library_set)]} {
                         puts "<FF> WARNING: Variable vars($vars($view,delay_corner),library_set) not defined"
                         set warnings($vars(warning_count)) "Variable vars($vars($view,delay_corner),library_set) not defined"
                         incr vars(warning_count)
                      }
                   }
               }
               foreach view $vars(hold_analysis_views) {
                  if {[info exists vars($vars($view,delay_corner),library_set)]} {
                     if {[info exists vars($vars($vars($view,delay_corner),library_set),timing)]} {
                        foreach file $vars($vars($vars($view,delay_corner),library_set),timing) {
                           if {[lsearch $vars(timelib,min) $file] == -1} {
                              lappend vars(timelib,min) $file
                           }
                           set found_min 1
                        }
                     } else {
                        puts "<FF> WARNING: vars($vars($vars($view,delay_corner),library_set),timing) not defined"
                        set warnings($vars(warning_count)) "Variable vars($vars($vars($view,delay_corner),library_set),timing) not defined"
                        incr vars(warning_count)
                     }
                  } else {
                     if {![info exists vars($vars($view,delay_corner),early_library_set)]} {
                        puts "<FF> WARNING: vars($vars($view,delay_corner),library_set) not defined"
                           set warnings($vars(warning_count)) "Variable vars($vars($view,delay_corner),library_set) not defined"
                        incr vars(warning_count)
                      }
                  }
               }
            }

            if {!$found_min || !$found_max} {
               append commands "#  WARNING: Either setup or hold analysis views inadequately defined"
               set warnings($vars(warning_count)) "Either setup or hold analysis views inadequately defined"
               incr vars(warning_count)
               set vars(timelib,min) ""
               set vars(timelib,max) ""
               foreach library_set $vars(library_sets) {
                  if {[info exists vars($library_set,timing)]} {
                     set vars(timelib) [concat $vars(timelib) $vars($library_set,timing)]
                  }
                  if {[info exists vars($library_set,si)]} {
                     set vars(cdb_file) [concat $vars(cdb_file) $vars($library_set,si)]
                  }
               }
            }
            set vars(captbl_file) ""
            set vars(timingcon_file) ""
   #           set vars(pre_route_res_factor) 1.0
   #           set vars(post_route_res_factor) 1.0
   #           set vars(pre_route_cap_factor) 1.0
   #           set vars(post_route_cap_factor) 1.0
   #           set vars(pre_route_clk_res_factor) 1.0
   #           set vars(post_route_clk_res_factor) 1.0
   #           set vars(pre_route_clk_cap_factor) 1.0
   #           set vars(post_route_clk_cap_factor) 1.0
   #           set vars(post_route_xcap_factor) 1.0
   #         set vars(qxtech_file) ""
   #         set vars(qxconf_file) ""
   #         set vars(qxlib_file) ""
   #         set vars(qxlayermap_file) ""
         }

         set map(qx_tech_file) qxtech_file
         set map(qx_conf_file) qxconf_file
         set map(qx_lib_file) qxlib_file

         foreach option "qx_tech_file qx_conf_file qx_lib_file" {
            if {[info exists vars($vars($vars($vars(default_setup_view),delay_corner),rc_corner),$option)]} {
               set vars($map($option)) $vars($vars($vars($vars(default_setup_view),delay_corner),rc_corner),$option)
            } else {
               set vars($map($option)) ""
            }
         }
         if {![info exists vars(qx_layermap_file)]} {
            if {[info exists vars(qrc_layer_map)]} {
               set vars(qxlayermap_file) $vars(qrc_layer_map)
            } else {
               set vars(qxlayermap_file) ""
            }
         } else {
            set vars(qxlayermap_file) $vars(qx_layermap_file)
            set vars(qrc_layer_map) $vars(qx_layermap_file) 
         }

   ###############################################################################
   # Backwards compatibility
   ###############################################################################
         if {[info exists vars(leakage_effort)] && ![info exists vars(leakage_power_effort)]} {
            set vars(leakage_power_effort) $vars(leakage_effort)
         }
         if {[info exists vars(enable_cppr)] && (($vars(enable_cppr) == 0) || ($vars(enable_cppr) == false))} {
            set vars(enable_cppr) none
         }
         if {[info exists vars(enable_cppr)] && (($vars(enable_cppr) == 1) || ($vars(enable_cppr) == true))} {
            set vars(enable_cppr) both
         }
         if {[info exists vars(def_file)]} {
            append commands "#  WARNING: Variable def_file has been changed to def_files ... please update\n"
            set warnings($vars(warning_count)) "Variable def_file has been changed to def_files ... please update"
            incr vars(warning_count)
            set vars(def_files) $vars(def_file)
         }

   ###############################################################################
   # Seed the rest of the config variables allowing user overrides ...
   # Default values for all variables are in defaults.tcl
   ###############################################################################

         if {![info exists vars(script_path)]} {
            if {[info exists vars(script_root)]} {
               set vars(script_path) $vars(script_root)
            } else {
               puts "<FF> ERROR: Variable vars(script_root) not defined"
               exit  1
            }
         } else {
            if {![info exists vars(script_root)]} {
               set vars(script_root) $vars(script_path)
            }
         }
         if {![info exists vars(setup_path)]} {
               set vars(setup_path) "."
         }
         if {[info command FFF::get_tool] ne "" && [FFF::get_tool] eq "rc"} {
           tcl_source $vars(script_path)/ETC/EDI/rda_defaults.tcl
         } else {
           source $vars(script_path)/ETC/common_defaults.tcl
           source $vars(script_path)/ETC/EDI/edi_defaults.tcl
           source $vars(script_path)/ETC/EDI/rda_defaults.tcl
         }

         foreach option [array names rda_defaults] {
            if {![info exists vars($option)]} {
               set vars($option) $rda_defaults($option)
            }  else {
               if {$vars($option) != $rda_defaults($option)} {
#                  puts "# <FF> INFO: User override of $option to $vars($option)"
               }
            }
         }

         if {![info exists vars(cpus_per_remote_host)] && [info exists vars(cpu_per_remote_host)]} {
            Puts "<FF> INFO: Setting 'vars(cpus_per_remote_host)' to 'vars(cpu_per_remote_host)'"
            Puts "<FF> INFO:                  ^"
            Puts "<FF> INFO: Please update your setup to cpus_per_remote ..."
            set vars(cpus_per_remote_host) $vars(cpu_per_remote_host)
         }

         if {![info exists vars(high_timing_effort)]} {
            set vars(high_timing_effort) $flow_defaults(high_timing_effort)
         }
         if {[info exists vars(clock_eco)] && ($vars(clock_eco) == "postcts")} {
            set vars(clock_eco) "post_cts"
         }
         if {[info exists vars(clock_eco)] && ($vars(clock_eco) == "postroute")} {
            set vars(clock_eco) "post_route"
         }
         if {[regexp "9.1" $vars(version)]} { 
            if {$vars(high_timing_effort)} {
               if {[info exists vars(critical_range)] && ($vars(critical_range) != 1.0)} {
                  Puts "<FF> High timing effort enabled but critical_range overridden by user settings"
               }
               if {[info exists vars(clock_eco)] && ($vars(clock_eco) != "post_cts")} {
                  Puts "<FF> High timing effort enabled but clock_eco overridden by user settings"
               }
               if {[info exists vars(in_place_opt)] && !$vars(in_place_opt)} {
                  Puts "<FF> High timing effort enabled but in_place_opt overridden by user settings"
               }
            }
         }
         if {[info exists vars(cts_engine)] && [regexp "^ccopt" [string tolower $vars(cts_engine)]]} {
            set flow_defaults(update_io_latency) true
         }
         foreach option [array names flow_defaults] {
            if {![info exists vars($option)]} {
               set vars($option) $flow_defaults($option)
               if {$vars(high_timing_effort) && [regexp "9.1" $vars(version)]} {
                  set vars(in_place_opt) true
                  set vars(critical_range) 1.0
#                  set vars(useful_skew) true
                  set vars(clock_eco) post_cts
               }
            }
         }
         if {![info exists vars(time_info_db)]} {
            set flow_defaults(time_info_db) $vars(rpt_dir)/time_info.db
         }
         if {![info exists vars(time_info_full_rpt)]} {
            set flow_defaults(time_info_full_rpt) $vars(rpt_dir)/time_info_full.rpt
         }
         if {![info exists vars(html_summary)]} {
            set flow_defaults(html_summary) $vars(rpt_dir)/summary.html
         }

         if {![info exists vars(enable_si_aware)]} {
#            if {[regsub "nm" $vars(process) ""] <= 65} {
#               set vars(enable_si_aware) true
#            } else {
               set vars(enable_si_aware) false
#            }
         }


         if {![info exists vars(dbs_format)]} {
            if {[string compare -nocase $vars(netlist_type) "verilog"]>=0} {
               set vars(dbs_format) fe
            } else {
               set vars(dbs_format) oa
            }
         }
         if {![info exists vars(partition_dir)]} { 
            set vars(partition_dir) PARTITION
         }
         if {![info exists vars(partition_dir_pass2)]} { 
            if {$vars(enable_dlm)} {
               set vars(partition_dir_pass2) $vars(partition_dir)_PRECTS
            } else {
               set vars(partition_dir_pass2) $vars(partition_dir)_CTS
            }
         }
         if {$vars(user_mode) == "hier"} {
            if {$vars(hier_flow_type) == "2pass"} {
               set vars(postcts,starting_dbs) .
            }
            if {$vars(enable_dlm)} {
               set vars(cts,starting_dbs) .
               # DLM is a two pass flow but user doesn't need to specify it
               set vars(hier_flow_type) "2pass"
            }
         }
         if {[string compare -nocase $vars(dbs_format) "oa"]==0} {
            if {![info exists vars(oa_abstract_name)]} { set vars(oa_abstract_name) abstract}
            if {![info exists vars(oa_layout_name)]} { set vars(oa_layout_name) layout}
            if {![info exists vars(oa_design_cell)]} { set vars(oa_design_cell) $vars(design)}
            if {![info exists vars(oa_design_view)]} { set vars(oa_design_view) ""}
            if {![info exists vars(oa_partition_lib)]} { set vars(oa_partition_lib) OA_PTN_LIB}
         } else {
            if {![info exists vars(oa_abstract_name)]} { set vars(oa_abstract_name) ""}
            if {![info exists vars(oa_layout_name)]} { set vars(oa_layout_name) ""}
            if {![info exists vars(oa_design_cell)]} { set vars(oa_design_cell) ""}
            if {![info exists vars(oa_design_view)]} { set vars(oa_design_view) ""}
            if {![info exists vars(oa_design_lib)]} { set vars(oa_design_lib) ""}
         }

         if {([string tolower $vars(fix_hold)] == "true") || ($vars(fix_hold) == 1)} {
            set infos($vars(info_count)) "Changing vars(fix_hold) from $vars(fix_hold) to \"$flow_defaults(fix_hold)\""
            incr vars(info_count)
            set vars(fix_hold) $flow_defaults(fix_hold)
         }
         if {([string tolower $vars(enable_ocv)] == "true") || ($vars(enable_ocv) == 1)} {
            set infos($vars(info_count)) "Changing vars(enable_ocv) from \"$vars(enable_ss)\" to \"pre_postroute\""
            incr vars(info_count)
            set vars(enable_ocv) pre_postroute
         } elseif {($vars(enable_ocv) == "none") || ($vars(enable_ocv) == 0)} {
            set infos($vars(info_count)) "Changing vars(enable_ocv) from \"$vars(enable_ocv)\" to \"false\""
            incr vars(info_count)
            set vars(enable_ocv) false
         }
         if {[lindex [split $vars(version) "."]  0] > 11} {
            if {[string tolower $vars(enable_ocv)] == "false"} {
            set infos($vars(info_count)) "Changing vars(enable_ocv) from \"$vars(enable_ocv)\" to \"pre_postroute\""
            incr vars(info_count)
            set vars(enable_ocv) "pre_postroute"
            }
         }
         if {([string tolower $vars(enable_ss)] == "true") || ($vars(enable_ss) == 1)} {
            set infos($vars(info_count)) "Changing vars(enable_ss) from $vars(enable_ss) to \"pre_postroute\""
            incr vars(info_count)
            set vars(enable_ss) pre_postroute
         } elseif {($vars(enable_ss) == "none") || ($vars(enable_ss) == 0)} {
            set infos($vars(info_count)) "Changing vars(enable_ss) from $vars(enable_ss) to \"false\""
            incr vars(info_count)
            set vars(enable_ss) false
         }
         if {([string tolower $vars(metalfill)] == "none") || ([string tolower $vars(metalfill)] == "false" && $vars(metalfill) != "false") || ($vars(metalfill) == 0)} {
            set infos($vars(info_count)) "Changing vars(metalfill) from $vars(metalfill) to \"false\""
            incr vars(info_count)
            set vars(metalfill) false
         }
         if {[info exists vars(clock_eco)]} {
            if {($vars(clock_eco) == "true") || ($vars(clock_eco) == 1)} {
               set infos($vars(info_count)) "Changing vars(clock_eco) from $vars(clock_eco) to \"post_cts\""
               incr vars(info_count)
               set vars(clock_eco) post_cts
            } elseif {($vars(clock_eco) == "false") || ($vars(clock_eco) == 0)} {
               set infos($vars(info_count)) "Changing vars(clock_eco) from $vars(clock_eco) to \"none\""
               incr vars(info_count)
               set vars(clock_eco) none
            } elseif {($vars(clock_eco) == "preroute") || ($vars(clock_eco) == "pre_route")} {
               set infos($vars(info_count)) "Changing vars(clock_eco) from $vars(clock_eco) to \"post_cts\""
               incr vars(info_count)
               set vars(clock_eco) post_cts
            } elseif {$vars(clock_eco) == "postroute"} {
               set infos($vars(info_count)) "Changing vars(clock_eco) from $vars(clock_eco) to \"post_route\""
               incr vars(info_count)
               set vars(clock_eco) post_route
            }
         }
#         if {![info exists vars(power_analysis_view)] || $vars(power_analysis_view) == ""} {
#            set vars(power_analysis_view) $vars(default_setup_view)
#         }
         if {![info exists vars(resize_shifter_and_iso_insts)] || $vars(resize_shifter_and_iso_insts) == ""} {
            set vars(resize_shifter_and_iso_insts) true
         }
         if {![info exists vars(activity_file_format)] || $vars(activity_file_format) == ""} {
            set vars(activity_file_format) TCF
         }
         if {![info exists vars(power_nets)]} {
            if {[info exists vars(pwrnet)]} {
               append commands "#  INFO: Variable pwrnet has been changed to power_nets ... please update\n"
               set infos($vars(info_count)) "Variable pwrnet has been changed to power_nets ... please update"
               incr vars(info_count)
               set vars(power_nets) $vars(pwrnet)
            } else {
               set vars(power_nets) ""
            }
         }
         if {![info exists vars(ground_nets)]} {
            if {[info exists vars(gndnet)]} {
               append commands "#  INFO: Variable gndnet has been changed to ground_nets ... please update\n"
               set infos($vars(info_count)) "Variable gndnet has been changed to ground_nets ... please update"
               incr vars(info_count)
               set vars(ground_nets) $vars(gndnet)
            } else {
               set vars(ground_nets) ""
            }
         }
         if {![info exists vars(superhosts)]} {
            set vars(superhosts) 0
         }

         if {![info exists vars(superthreads)]} {
            set vars(superthreads) 1
         } else {
            if {($vars(threads) > 1) && ($vars(superthreads) == 1)} {
               set vars(superthreads) $vars(threads)
            }
         }
         if {![info exists vars(makefile)]} {
            set vars(makefile) 1
         }
         if {![info exists vars(flat)]} {
            set vars(flat) none
         }
         if {![info exists vars(abort)]} {
            set vars(abort) 0
         }
         if {![info exists vars(catch_errors)]} {
            set vars(catch_errors) 1
         }
         if {![info exists vars(restore_design)]} {
            set vars(restore_design) 1
         }
         if {$vars(catch_errors)} {
            if {![info exists vars(save_on_catch)]} {
               set vars(save_on_catch) 1
            } 
         }
         if {![info exists env(VPATH)]} {
            set env(VPATH) $flow_defaults(vpath)
            Puts "<FF> INFO: Setting env(VPATH) to $flow_defaults(vpath)"
         }
         if {[info exists vars(cpf_file)]} {
            if {![info exists vars(cpf_timing)]} {
               set vars(cpf_timing) true
#               set vars(flat) true
            }
         } else {
            set vars(cpf_timing) false
         }

         if {!$vars(codegen)} { 
            if {[FF::is_lp_flow]} {
               catch {alias ff_modify_power_domains FF_EDI::modify_power_domains}
               catch {alias ff_add_power_switches FF_EDI::add_power_switches}
               catch {alias ff_route_secondary_pg_nets FF_EDI::route_secondary_pg_nets}
               catch {alias ff_get_power_domains FF_EDI::get_power_domains}
               catch {alias ff_buffer_always_on_nets FF_EDI::buffer_always_on_nets}
               catch {alias ff_insert_welltaps_endcaps FF_EDI::insert_welltaps_endcaps}
            }
            set flow_defaults(script_dir) "."
        }

# Remember these for step based reporting ...
         set vars(orig_rpt_dir)  $vars(rpt_dir)
         set vars(orig_log_dir)  $vars(log_dir)
         set vars(orig_dbs_dir)  $vars(dbs_dir)


# Add these for get metric
         if {![info exists vars(html_summary)]} {
            set vars(html_summary)  $vars(rpt_dir)/summary.html
         }
         if {![info exists vars(time_info_db)]} {
            set vars(time_info_db)  $vars(rpt_dir)/time_info.db
         }
         if {![info exists vars(time_info_rpt)]} {
            set vars(time_info_rpt)  $vars(rpt_dir)/time_info.rpt
         }

         if {[info command FFF::get_tool] ne "" && [FFF::get_tool] eq "rc"} {
           tcl_source $vars(script_path)/ETC/EDI/udm.tcl
         } else {
           source $vars(script_path)/ETC/EDI/udm.tcl
         }
         if {!$vars(rc) || ($vars(rc) && ![info exists vars(rc_steps)])} {
            set vars(seed) 1
         }

      }
   }

   ###############################################################################
   # Procedure to check the flow variables defined in the setup.tcl
   ###############################################################################

   proc check_setup {} {

      global vars
      global tvars
      global errors
      global warnings
      global infos
      global check

      if {[info exists vars(check_setup)]  && !$vars(check_setup)} {
         return
      }

      if {[info exists vars(warning_count)]} {
         set warning_count $vars(warning_count)
      } else {
         set warning_count 0
      }
      if {[info exists vars(error_count)]} {
         set error_count $vars(error_count)
      } else {
         set error_count 0
      }
      if {[info exists vars(info_count)]} {
         set info_count $vars(info_count)
      } else {
         set info_count 0
      }

      if {[info exists vars(cts_engine)]} {
         if {[string tolower $vars(cts_engine)] == "ccoptdesign"} { 
            set vars(cts_engine) ccopt 
         } 
         if {[string tolower $vars(cts_engine)] == "clockdesign"} { 
            set vars(cts_engine) cts 
         }
         set valid [list cts ccopt ccopt_cts]
         if {[lsearch $valid [string tolower $vars(cts_engine)]] == -1} {
            append commands "#  ERROR: Variable vars(cts_engine) has illegal value $vars(cts_engine)\n"
            set errors($error_count) "Variable vars(cts_engine) has illegal value $vars(cts_engine)"
            incr error_count
            append commands "#         Must be one of '$valid'\n"
         }
      }

      if {[info exists vars(ccopt_integration)]} {
         set valid {scripted native}
         if {[lsearch $valid $vars(ccopt_integration)] == -1} {
            append commands "#  ERROR: Variable vars(cts_engine) has illegal value $vars(cts_engine)\n"
            set errors($error_count) "Variable vars(cts_engine) has illegal value $vars(cts_engine)"
            incr error_count
            append commands "#         Must be one of '$valid'\n"
         }
      } else {
         # Default to native integration
         set vars(ccopt_integration) "native"
      }

      if {[lindex [split $vars(version) "."]  0] > 10} {
         foreach var [array names vars] {
            set save_vars($var) $vars($var)
            if {[info exists tvars($var)]} {
               set vars($var) $tvars($var)
            }
         }
      }

      set commands  ""

      set check(files) [list]
      set check(integers) [list]


      if {![info exists vars(abort)]} {
         set vars(abort) 0
      }

      if {[info exists vars(check_vars)] && $vars(check_vars)} {
         source $vars(script_root)/ETC/EDI/check_vars.tcl
      }

      append commands "#  ==============================================\n"
      append commands "#               Required Variables\n"
      append commands "#  ==============================================\n"
      set count 0
      foreach required "fp_tcl_file fp_file def_files" {
         # BCL: Note - This code removed as the RC Foundation Flow will set vars(def_files) when it
         # isn't defined in the user's setup.tcl
         #if {$vars(rc) && ![info exists vars(def_files)]} {
         #   set vars(def_files) $vars(dbs_dir)/$vars(design).syn_placed.def.gz
         #}
         if {!$vars(rc)} {
           # BCL: Only check for vars(def_files) if not in RC mode
           if {[info exists vars($required)] && ($vars($required) != "")} {
              if {$required == "def_files"} {
                 set first 1
                 # BCL: Added subst around vars(def_files) to resolve vars(rundir)
                 foreach file [subst $vars(def_files)] {
                    if {$first == 1} {
                       append commands "#  INFO:    $required = $file\n"
                       set first 0
                    } else {
                       append commands "#  INFO:                $file"
                    }
                    if {!$vars(rc)} { 
                       lappend check(files) $file
                    }
                 }
              } else {
                 lappend check(files) $vars($required)
                 append commands "#  INFO:    $required = $vars($required)\n"
              }
              incr count
           }
         }
      }
      if {[info exists vars(fp_tcl_proc)]} {
         append commands "#  INFO:    fp_tcl_proc = $vars(fp_tcl_proc)\n"
         incr count
      }

      if {[info exists vars(oa_fp)]} { 
         if {[llength $vars(oa_fp)] == 3} {
            append commands "#  INFO:          oa_fp = $vars(oa_fp)\n"
            incr count
         } else {
            append commands "#  ERROR: OA floorplan variable (oa_fp) should be 'lib cell view'"
            set errors($error_count) "OA floorplan variable (oa_fp) should be 'lib cell view'"
            incr error_count
         }
      } else {
         if {$count == 0} {
            append commands "#  WARNING: Neither fp_file, def_files, fp_tcl_file, fp_tcl_proc are defined\n"
            set warnings($warning_count) "Either fp_file, def_files, fp_tcl_file, fp_tcl_proc should be defined"
            incr warning_count
         }
      }

      if {[string compare -nocase $vars(netlist_type) "verilog"]>=0} {
         # BCL: Note - This code removed as the RC Foundation Flow will set vars(def_netlist) when it
         # isn't defined in the user's setup.tcl
         #if {$vars(rc) && ![info exists vars(netlist)]} {
         #   set vars(netlist) $vars(dbs_dir)/$vars(design).syn_placed.v.gz
         #}
         if {!$vars(rc)} {
           # BCL: Only check for vars(netlist) if not in RC mode
           if {[info exists vars(netlist)]} {
              # BCL: Added subst around vars(netlist)
              foreach file [subst $vars(netlist)] {
                 if {!$vars(rc)} {
                    lappend check(files) $file
                 }
              }
              append commands "#  INFO:    netlist = $vars(netlist)\n"
           } else {
              if {($vars(netlist_type) == "Verilog")} {
                 append commands "#  ERROR: A verilog netlist file must be defined\n"
                 set errors($error_count) "A verilog netlist file must be defined"
                 incr error_count
              }
           }
         }
      } elseif {[string compare -nocase $vars(netlist_type) "oa"]==0} {
         append commands "#  INFO:    netlist_type = $vars(netlist_type)\n"
         foreach required "oa_ref_lib oa_design_lib oa_design_cell oa_design_view" {
            if {[info exists vars($required)] && ($vars($required) != "")} {
               append commands "#  INFO:       $required = $vars($required)\n"
            } else {
               append commands "#  ERROR: Variable $required must be defined when netlist_type is open access"
               set errors($error_count) "Variable $required must be defined when netlist_type is open access"
               incr error_count
            }
         }
      }
      if {[string compare -nocase $vars(dbs_format) "oa"]==0} {
         append commands "#  INFO:    dbs_format = $vars(dbs_format)\n"
         foreach required "oa_ref_lib oa_design_lib oa_abstract_name oa_layout_name" {
            if {[info exists vars($required)] && ($vars($required) != "")} {
               append commands "#  INFO:       $required = $vars($required)\n"
            } else {
               append commands "#  ERROR: Variable $required must be defined when dbs_format is open access"
               set errors($error_count) "Variable $required must be defined when dbs_format is open access"
               incr error_count
            }
         }
      }

#      if {[info exists vars(netlist)]} {
#         foreach file $vars(netlist) {
#            lappend check(files) $file
#         }
#      } else {
#         if {$vars(netlist_type) == "Verilog"} {
#            append commands "#  ERROR: A verilog netlist file must be defined\n"
#            set errors($error_count) "A verilog netlist file must be defined"
#            incr error_count
#
#         }
#      }

      if {[info exists vars(cts_spec)]} {
         foreach file $vars(cts_spec) {
            lappend check(files) $file
         }
         append commands "#  INFO:    cts_spec = $vars(cts_spec)\n"
      } else {
         append commands "#  WARNING: Recommended variable cts_spec not defined\n"
         set warnings($warning_count) "Recommended variable cts_spec not defined "
         incr warning_count
      }

#      if {[info exists vars(cpf_file)] && $vars(cpf_timing)} {
#         set required_list "flow process library_sets rc_corners delay_corners"
#      } else {
         set required_list "flow process library_sets rc_corners delay_corners setup_analysis_views \
                       hold_analysis_views active_setup_views active_hold_views default_setup_view default_hold_view"
#      }

      foreach required $required_list {
         if {[info exists vars($required)] && ($vars($required) != "")} {
               append commands "#  INFO:    $required = $vars($required)\n"
               if {$required == "flow"} {
                  if {([info exists vars(partition_list)] || ($vars(ilm_list) != "")) && ($vars(flow) != "mmmc")} {
                     append commands "#  ERROR: Flow variable vars(flow) must be \"mmmc\" when ILMs are defined\n"
                     set errors($error_count) "#  ERROR: Flow variable vars(flow) must be \"mmmc\" when ILMs are defined"
                     incr error_count
                  }
               }
         }
      }


      append commands "#  ==============================================\n"
      append commands "#                 Library Sets\n"
      append commands "#  ==============================================\n"
      foreach library_set $vars(library_sets) {
         append commands "#  INFO: $library_set:\n"
         foreach required "timing" {
            if {[info exists vars($library_set,$required)] && ($vars($library_set,$required) != "")} {
               append commands "#  INFO:    $required = \n"
               foreach lib $vars($library_set,$required) {
#                  lappend check(files) $lib
                  append commands "#  INFO:       $lib\n"
               }
            } else {
               if {[FF::is_lp_flow]} {
                  append commands "#  WARNING: Variable vars($library_set,$required) not defined\n"
                  set warnings($warning_count) "Variable vars($library_set,$required) not defined"
                  incr warning_count
               } else {
                  append commands "#  ERROR: Required variable vars($library_set,$required) not defined or empty\n"
                  set errors($error_count) "Required variable vars($library_set,$required) not defined or empty"
                  incr error_count
               }
            }
         }
         if {[info exists vars($library_set,aocv)]} {
            foreach file $vars($library_set,aocv) {
               if {![file exists $file]} {
                  append commands "#  WARNING: AOCV table file does not exist ($file)\n"
                  set warnings($warning_count) "AOCV table file does not exist ($file)"
                  incr warning_count
               }
            }
         } else {
            if {$vars(enable_aocv)} {
                  append commands "#  WARNING: AOCV enabled, but table not provided for $library_set\n"
                  set warnings($warning_count) "AOCV enabled, but table not provided for $library_set"
                  incr warning_count
               
            }
         }
         if {[info exists vars($library_set,si)]} {
            foreach file $vars($library_set,si) {
               if {![file exists $file]} {
                  append commands "#  WARNING: CDB file does not exist ($file)\n"
                  set warnings($warning_count) "CDB file does not exist ($file)"
                  incr warning_count
               }
            }
         } 
      }

      append commands "#  ==============================================\n"
      append commands "#                 LEF Files\n"
      append commands "#  ==============================================\n"
      if {[info exists vars(lef_files)]} {
         foreach file $vars(lef_files) {
   #    lappend check(files) $file
             append commands "#  INFO: $file\n"
         }
      } else {
         if {([string tolower $vars(netlist_type)] == "verilog") && (![info exists vars(oa_ref_lib)])} {
            append commands "#  ERROR: Required variable vars(lef_files) not defined\n"
            set errors($error_count) "Required variable vars(lef_files) not defined"
            incr error_count
         }
      }

      if {[info exists vars(partition_list)]} {
         append commands "#  ==============================================\n"
         append commands "#                 Hierarchical \n"
         append commands "#  ==============================================\n"
         append commands "#  INFO: partitions = $vars(partition_list)\n"
         set cts_spec [FF::get_by_suffix vars ",cts_spec"] 
         if {$cts_spec != ""} {
            append commands "#   CTS Specs : \n"
            foreach partition $cts_spec {
               lappend check(files) $vars($partition,cts_spec)
               append commands "#      $partition -> $vars($partition,cts_spec)\n"
            }
         }
         set latency_sdc [FF::get_by_suffix vars ",latency_sdc"]
         if {$latency_sdc != ""} {
            append commands "#   Latency SDCs :\n"
            foreach partition $latency_sdc {
               lappend check(files) $vars($partition,latency_sdc)
               if {[llength [split $partition ","]] == 1} {  
                  append commands "#      $partition -> $vars($partition,latency_sdc)\n"
               } else { 
                  append commands "#      [lindex [split $partition ","] 0] ([lindex [split $partition ","] 1]) -> $vars($partition,latency_sdc)\n"
               }
            }
         }
      }
      if {[info exists vars(enable_pac)] && $vars(enable_pac)} {
         append commands "#  WARNING: PAC is obsolete and will be removed in a future version. Consider using Sign-off ECO."
         set warnings($warning_count) "PAC is obsolete and will be removed in a future version. Consider using Sign-off ECO."
         incr warning_count
         set pac_mode [FF::get_by_suffix vars ",pac_mode"]
         if {$pac_mode != ""} {
            set pac_list [list "read_only" "interface" "ilm" "all"]
            foreach pac $pac_mode {
               if {[lsearch $pac_list $vars($pac,pac_mode)] == -1} {
                  append commands "#  ERROR: $pac pac_mode invalid value; must be one of \'$pac_list\'\n"
                  set errors($error_count) "$pac pac_mode invalid value; must be one of \'$pac_list\'" 
                  incr error_count
               
               }
            }
         }
      }
      if {[FF::is_lp_flow]} {
         append commands "#  ==============================================\n"
         append commands "#                Low Power \n"
         append commands "#  ==============================================\n"
         set num_power_intent_files 0
         foreach v {cpf_file ieee1801_file} {
            if {[info exists vars($v)]} {
               append commands "#  INFO: $v = $vars($v)\n"
               lappend check(files) $vars($v)
               incr num_power_intent_files
            }
         }
         if {$num_power_intent_files > 1} {
            set errors($error_count) "vars(cpf_file) and vars(ieee1801_file) may not both be specified."
            append commands "#  ERROR: $errors($error_count)\n"
            incr error_count
         }

         if {[info exists vars(power_domains)] && ($vars(power_domains) != "")} {
            append commands "#  INFO: power_domains =  $vars(power_domains)\n"
            foreach domain $vars(power_domains) {
               set print($domain) 1
               foreach optional "filler_cells tie_cells endcaps welltaps" {
                  if {[info exists vars($domain,$optional)] && ($vars($domain,$optional) != "")} {
                     if {$print($domain)} {
                        append commands "#  INFO:    $domain:\n"
                        set print($domain) 0
                     }
                     append commands "#  INFO:       $optional = $vars($domain,$optional)\n"
                  }
#                 if {$optional == "filler_cells} {
#                     set process [regsub "nm" $vars(process) ""]
#                     if {[expr $process <= 28)] && [info exists vars(filler_cells,min_gap)]} {
#                        append commands "#  ERROR: For process node < 28nm, variable vars(filler_cells,min_gap) is required\n"
#                        set errors($error_count) "For process node < 28nm, variable vars(filler_cells,min_gap) is required"
#                        incr error_count
#                     }
#                  }
               }
            }
         } else {
            append commands "#  WARNING: Recommended variable vars(power_domains) not defined\n"
            append commands "#           Will retreive domain information dynamically\n"
            set warnings($warning_count) "Recommended variable vars(power_domains) not defined"
            incr warning_count
         }
         if {[info exists vars(power_analysis_view)] && ($vars(power_analysis_view) != "")} {
            append commands "#  INFO: power_analysis_view =  $vars(power_analysis_view)\n"
         } else {
            append commands "#  WARNING: Recommended variable vars(power_analysis_view) not defined\n"
            append commands "#           Will default to the default setup analysis view\n"
            set warnings($warning_count) "Recommended variable vars(power_analysis_view) not defined"
            incr warning_count
         }
      }

      append commands "#  ==============================================\n"
      append commands "#                  RC Corners\n"
      append commands "#  ==============================================\n"
      set check(rc_corners) [list]
      foreach rc_corner $vars(rc_corners) {
         append commands "#  INFO: $rc_corner:\n"
         if {[info exists vars($rc_corner,cap_table)] && ($vars($rc_corner,cap_table) != "")} {
            append commands "#  INFO:    cap_table = $vars($rc_corner,cap_table)\n"
            lappend check(rc_corners) $vars($rc_corner,cap_table)
         } else {
            if {![info exists vars($rc_corner,qx_tech_file)]} {
               append commands "#  ERROR: Variable vars($rc_corner,cap_table) or vars($rc_corner,qx_tech_file) must be defined\n"
               set errors($error_count) "Variable vars($rc_corner,cap_table) or vars($rc_corner,qx_tech_file) must be defined"
               incr error_count
            } else {
               append commands "#  INFO: Variable vars($rc_corner,cap_table) not defined\n"
               set infos($info_count) "Variable vars($rc_corner,cap_table) not defined"
               incr info_count
            } 
         }
         if {$vars(cts_engine) != "cts"} {
            if {[info exists vars($rc_corner,atf_file)] && ($vars($rc_corner,atf_file) != "")} {
               append commands "#  INFO:     atf_file = $vars($rc_corner,atf_file)\n"
               lappend check(rc_corners) $vars($rc_corner,atf_file)
            } else {
               append commands "#  WARNING: Recommended variable vars($rc_corner,atf_file) not defined\n"
               set warnings($warning_count) "Recommended variable vars($rc_corner,atf_file) not defined"
               incr warning_count
            }
         }
         if {[info exists vars($rc_corner,T)] && ($vars($rc_corner,T) != "")} {
            append commands "#  INFO:    temperature = $vars($rc_corner,T)\n"
            lappend check(integers) "$rc_corner,T"
         } else {
            append commands "#  WARNING: Recommended variable vars($rc_corner,T) not defined\n"
            set warnings($warning_count) "Recommended variable vars($rc_corner,T) not defined"
            incr warning_count
         }
         if {[info exists vars($rc_corner,qx_tech_file)] && ($vars($rc_corner,qx_tech_file) != "")} {
            append commands "#  INFO:    qx_tech_file = $vars($rc_corner,qx_tech_file)\n"
            lappend check(rc_corners) $vars($rc_corner,qx_tech_file)
         } else {
            if {[info exists vars(postroute_extraction_effort)] && ($vars(postroute_extraction_effort) != "low")} {
               append commands "#  ERROR: qx_tech_file not defined for $rc_corner and postroute_extraction_effort is set to $vars(postroute_extraction_effort)\n"
               set errors($error_count) "qx_tech_file not defined for $rc_corner and postroute_extraction_effort is set to $vars(postroute_extraction_effort)"
               incr error_count
            }
            if {[info exists vars(signoff_extraction_effort)] && ($vars(signoff_extraction_effort) != "low")} {
               append commands "#  ERROR: qx_tech_file not defined for $rc_corner and signoff_extraction_effort is set to $vars(signoff_extraction_effort)\n"
               set errors($error_count) "qx_tech_file not defined for $rc_corner and signoff_extraction_effort is set to $vars(signoff_extraction_effort)"
#               set errors($error_count) "Required variable vars($rc_corner,cap_table) not defined"
               incr error_count
            }
         }
      }

      if {[info exists vars(opconds)]} {
         append commands "#  ==============================================\n"
         append commands "#             Operating Conditions\n"
         append commands "#  ==============================================\n"
         foreach opcond $vars(opconds) {
            append commands "#  INFO: $opcond:\n"
            foreach required "library_file P V T" {
               if {[info exists vars($opcond,$required)] && ($vars($opcond,$required) != "")} {
                  append commands "#  INFO:    $required = $vars($opcond,$required)\n"
               } else {
                  append commands "#  ERROR: Required variable vars($opcond,$required) not defined\n"
                  set errors($error_count) "Required variable vars($opcond,$required) not defined"
                  incr error_count
               }
            }
         }
      }

      append commands "#  ==============================================\n"
      append commands "#               Delay Corners\n"
      append commands "#  ==============================================\n"
      foreach delay_corner $vars(delay_corners) {
         append commands "#  INFO: $delay_corner:\n"

         if {[info exists vars($delay_corner,rc_corner)] && ($vars($delay_corner,rc_corner) != "")} {
            append commands "#  INFO:    rc_corner = $vars($delay_corner,rc_corner)\n"
         } else {
            append commands "#  ERROR: Required variable vars($delay_corner,rc_corner) not defined\n"
            set errors($error_count) "Required variable vars($delay_corner,rc_corner) not defined"
            incr error_count
         }

         if {![FF::is_lp_flow]} {
            if {[info exists vars($delay_corner,library_set)] && ($vars($delay_corner,library_set) != "")} {
               append commands "#  INFO:    library_set = $vars($delay_corner,library_set)\n"
            } else {
               foreach additional "early_library_set late_library_set" {
                  if {[info exists vars($delay_corner,$additional)] && ($vars($delay_corner,$additional) != "")} {
                     append commands "#  INFO:    $additional = $vars($delay_corner,$additional)\n"
                  } else {
                     append commands "#  ERROR: Required variable vars($delay_corner,library_set) and vars($delay_corner,$additional) not defined\n"
                     set errors($error_count) "Required variable vars($delay_corner,library_set) and vars($delay_corner,$additional) not defined\n"
                     incr error_count
                  }
               }
            }
         }
         foreach optional "opcond opcond_library early_opcond_library late_opcond_library" {
            if {[info exists vars($delay_corner,$optional)] && ($vars($delay_corner,$optional) != "")} {
               append commands "#  INFO:    $optional = $vars($delay_corner,$optional)\n"
            }
         }
         foreach optional "power_domains" {
            if {[info exists vars($delay_corner,$optional)] && ($vars($delay_corner,$optional) != "")} {
               append commands "#  INFO:    $optional = $vars($delay_corner,$optional)\n"
            }
         }
      }

      set check(constraint_modes) [list]
      if {[FF::is_lp_flow]} {
         append commands "#  ==============================================\n"
         append commands "#             Constraint Modes\n"
         append commands "#  ==============================================\n"
         if {[info exists vars(constraint_modes)]} {
            foreach mode $vars(constraint_modes) {
               append commands "#  INFO: $mode:\n"
               foreach other "pre_cts_sdc incr_cts_sdc post_cts_sdc" {
                  if {[info exists vars($mode,$other)] && ($vars($mode,$other) != "")} {
                     append commands "#  INFO:    $other = $vars($mode,$other)\n"
                     lappend check(constraint_modes) $vars($mode,$other)
                  } else {
                     if {!$vars(cpf_timing)} {
                        if {($other == "pre_cts_sdc") && $vars(rc)} {
                           set vars($mode,$other) $vars(dbs_dir)/$vars(design).syn_placed.$mode.sdc
                        } elseif {($other == "pre_cts_sdc") && !$vars(rc)} {
                           append commands "# ERROR:    Variable vars($mode,$other) not defined\n"
                           set errors($error_count) "Variable vars($mode,$other) not defined"
                           incr error_count
                        } else {
                           if {($other == "pre_cts_sdc") || (($other == "post_cts_sdc") && ![info exists vars($mode,incr_cts_sdc)])} {
                              append commands "#  INFO:    Variable vars($mode,$other) not defined\n"
                           }
                           
                        }
                     } else {
                        append commands "#  INFO:    Variable vars($mode,$other) not defined\n"
                     }
                  }
               }
            }
         } else {
                  append commands "#  INFO: No constraint mode information defined\n"
                  append commands "#        Post CTS latency adjustment must be\n"
                  append commands "#        managed by the user via plug-ins\n"
         }
      } else {
         append commands "#  ==============================================\n"
         append commands "#             Constraint Modes\n"
         append commands "#  ==============================================\n"
         foreach mode $vars(constraint_modes) {
            append commands "#  INFO: $mode:\n"
            foreach required "pre_cts_sdc" {
               if {[info exists vars($mode,$required)] && ($vars($mode,$required) != "")} {
                  append commands "#  INFO:    $required = $vars($mode,$required)\n"
                  lappend check(constraint_modes) $vars($mode,$required)
               } else {
                  append commands "#  ERROR: Required variable vars($mode,$required) not defined\n"
                  set errors($error_count) "Required variable vars($mode,$required) not defined"
                  incr error_count
               }
            }
            foreach other "post_cts_sdc incr_cts_sdc" {
               if {$other == "post_cts_sdc" && ![info exists vars($other)]} {
                  if {![info exists vars($mode,$other)]} {
                     append commands "#  INFO:    Variable vars($mode,$other) not defined\n"
                  } else {
                     append commands "#  INFO:    $other = $vars($mode,$other)\n"
                  }
               } else {
                  if {[info exists vars($mode,$other)] && ($vars($mode,$other) != "")} {
                     append commands "#  INFO:    $other = $vars($mode,$other)\n"
                     lappend check(constraint_modes) $vars($mode,$other)
                  } else {
                     append commands "#  INFO:    Variable vars($mode,$other) not defined\n"
                  }
               }
            }
         }
      }

      if {![info exists vars(hold_analysis_views)]} {
         set vars(hold_analysis_views) ""
      }
      if {![info exists vars(power_analysis_view)]} {
         set vars(power_analysis_view) ""
      }
      append commands "#  ==============================================\n"
      append commands "#             Analysis Views\n"
      append commands "#  ==============================================\n"
      if {[FF::is_lp_flow]} {
         foreach analysis_view [concat $vars(setup_analysis_views) $vars(hold_analysis_views) $vars(power_analysis_view)] {
            append commands "#  INFO: $analysis_view:\n"
            foreach other "delay_corner constraint_mode" {
               if {[info exists vars($analysis_view,$other)] && ($vars($analysis_view,$other) != "")} {
                  append commands "#  INFO:    $other = $vars($analysis_view,$other)\n"
                  lappend check(analysis_view) $vars($analysis_view,$other)
               } 
            }
         }
      } else {
         set check(analysis_views) [list]
         foreach analysis_view [concat $vars(setup_analysis_views) $vars(hold_analysis_views) $vars(power_analysis_view)] {
            append commands "#  INFO: $analysis_view:\n"
            foreach required "delay_corner constraint_mode" {
               if {[info exists vars($analysis_view,$required)] && ($vars($analysis_view,$required) != "")} {
                  append commands "#  INFO:    $required = $vars($analysis_view,$required)\n"
                  lappend check(analysis_view) $vars($analysis_view,$required)
               } else {
                  append commands "#  ERROR: Required variable vars($analysis_view,$required) not defined\n"
                  set errors($error_count) "Required variable vars($analysis_view,$required) not defined"
                  incr error_count
               }
            }
         }
      }

      append commands "#  ==============================================\n"
      append commands "#             Recommended Variables\n"
      append commands "#  ==============================================\n"
      foreach recommended "scan_def gds_layer_map" {
         if {[info exists vars($recommended)] && ($vars($recommended) != "")} {
            lappend check(files) $vars($recommended)
            append commands "#  INFO: $recommended = $vars($recommended)\n"
         }
      }
      if {[info exists vars(gds_files)] && ($vars(gds_files) != "")} {
         append commands "#  INFO: gds_files = $vars(gds_files)\n"
         foreach file $vars(gds_files) {
            lappend check(files) $file
         }
      }

      foreach recommended "max_route_layer filler_cells tie_cells dont_use_list antenna_diode" {
         if {[info exists vars($recommended)] && ($vars($recommended) != "")} {
            append commands "#  INFO: $recommended = $vars($recommended)\n"
            if {$recommended == "tie_cells"} {
               if {[llength $vars(tie_cells)] > 2} {
                  append commands "#  ERROR: Recommended variable vars($recommended) has more than two cells\n"
                  set errors($error_count) "Recommended variable vars($recommended) has more than two cells"
                  incr error_count
               }
            }
            if {$recommended == "antenna_diode"} {
               if {[llength $vars(antenna_diode)] > 1} {
                  append commands "#  ERROR: Recommended variable vars($recommended) has more than one cells\n"
                  set errors($error_count) "Recommended variable vars($recommended) has more than one cells"
                  incr error_count
               }
            }
            if {$recommended == "max_route_layer"} {
               lappend check(integers) "$recommended"
            }
         } else {
            if {($recommended == "dont_use_list")} {
               if {![info exists vars(dont_use_file)]} {
                  append commands "#  WARNING: Recommended variables dont_use_list and dont_use_file not defined\n"
                  set warnings($warning_count) "Recommended variables dont_use_list and dont_use_file not defined"
                  incr warning_count
               }
            } else {
               append commands "#  WARNING: Recommended variable vars($recommended) not defined\n"
               set warnings($warning_count) "Recommended variable vars($recommended) not defined"
               incr warning_count
            }  
         }
      }
      foreach optional "size_only_file dont_use_file" {
         if {[info exists vars($optional)]} {
            lappend check(files) $vars($optional)
         }
      }

      append commands "#  ==============================================\n"
      append commands "#                 Other Variables\n"
      append commands "#  ==============================================\n"
      foreach other "jtag_cells jtag_rows spare_cells" {
         if {[info exists vars($other)] && ($vars($other) != "")} {
            append commands "#  INFO: $other = $vars($other)\n"
         } else {
            append commands "#  INFO: Variable vars($other) not defined\n"
         }
      }

      append commands "#  ==============================================\n"
      append commands "#                 Scale Factors\n"
      append commands "#  ==============================================\n"
      foreach rc_corner $vars(rc_corners) {
         set i 0
         append commands "#  INFO: $rc_corner:\n"
         if {[info exists vars($rc_corner,scale_tcl)]} {
            if {[file exists $vars($rc_corner,scale_tcl)]} {
               incr i
               append commands "#  INFO:   scaling file = $vars($rc_corner,scale_tcl)\n"
            } else {
               puts "<FF> ERROR: Scaling file $vars($rc_corner,scale_tcl) for rc corner $rc_corner defined but does not exist"
               set errors($error_count) "Scaling file $vars($rc_corner,scale_tcl) for rc corner $rc_corner defined but does not exist"
               incr error_count
            }
         } else {
            foreach other "pre_route_res_factor post_route_res_factor \
                           pre_route_cap_factor post_route_cap_factor \
                           pre_route_clk_res_factor post_route_clk_res_factor \
                           pre_route_clk_cap_factor post_route_clk_cap_factor \
                           post_route_xcap_factor" {
               if {[info exists vars($rc_corner,$other)]} {
                  append commands "#  INFO:    $other = $vars($rc_corner,$other)\n"
                  incr i
               }
            }
         }
         if {$i == 0} {
            append commands "#  WARNING: No scale factors set for rc corner ($rc_corner)\n"
            set warnings($warning_count) "No scale factors set for rc corner ($rc_corner)"
            incr warning_count
         }
      }

      append commands "#  ==============================================\n"
      append commands "#                Derating Factors\n"
      append commands "#  ==============================================\n"
      set i 0
      if {[info exists vars(derate_tcl)]} {
         append commands "#  INFO:    derate file = $vars(derate_tcl)\n"
         lappend check(files) $vars(derate_tcl)
         incr i
      } else {
         foreach delay_corner $vars(delay_corners) {
            append commands "#  INFO: $delay_corner:\n"
            if {[info exists vars($delay_corner,derate_tcl)]} {
               append commands "#  INFO:    derate file = $vars($delay_corner,derate_tcl)\n"
               lappend check(files) $vars($delay_corner,derate_tcl)
               incr i
            } else {
               if {[info exists vars(derate_tcl)]} {
                  append commands "#  INFO:    derate file = $vars(derate_tcl)\n"
                  lappend check(files) $vars(derate_tcl)
               } else {
                  foreach other "early_data_cell early_clock_cell early_cell_check \
                                 late_data_cell late_clock_cell late_cell_check \
                                 data_cell_early clock_cell_early cell_check_early \
                                 data_cell_late clock_cell_late cell_check_late" {
                     if {[info exists vars($delay_corner,$other)]} {
                        append commands "#  INFO:    $other = $vars($delay_corner,$other)\n"
                        incr i
                     }
                  }
               }
            }
            if {$i == 0} {
               append commands "#  WARNING: No derating factors set for delay corner ($delay_corner)\n"
               set warnings($warning_count) "No derating factors set for delay corner ($delay_corner)"
               incr warning_count
            }
         }
      }
      if {![regexp "9.1" $vars(version)]} {

         set valid "TRUE FALSE true false auto"

         if {[info exists vars(enable_si_aware)]} {
            if {[lsearch $valid $vars(enable_si_aware)] == -1} {
               append commands "#  ERROR: Variable vars(enable_si_aware) has illegal value\n"
               set errors($error_count) "Variable vars(enable_si_aware) has illegal value"
                  incr error_count
               append commands "#         Must be one of '$valid'\n"
            }
         }
      }

      set valid "pre_place pre_prects pre_postcts pre_postroute pre_postroute_si pre_signoff true false"
      foreach option "metalfill enable_ocv enable_ss" {
         if {[info exists vars($option)]} {
            if {[lsearch $valid $vars($option)] == -1} {
               append commands "#  ERROR: Variable vars($option) has illegal value ($vars($option))\n"
               set errors($error_count) "Variable vars($option) has illegal value ($vars($option))"
               incr error_count
               append commands "#         Must be one of '$valid'\n"
            }
         }
      }

      set pacs [FF::get_by_suffix vars ",pac_mode"] 
      set valid "read_only interface all"

      foreach pac $pacs {
         if {[info exists vars(pac_mode)]} {
            if {[lsearch $valid $vars(pac_mode)] == -1} {
               append commands "#  ERROR: Variable vars(pac_mode) has illegal value\n"
               set errors($error_count) "Variable vars(pac_mode) has illegal value"
               incr error_count
               append commands "#         Must be one of '$valid'\n"
            }
         }
      }

      set valid "default pessimistic"

      if {[info exists vars(si_analysis_type)]} {
         if {[lsearch $valid $vars(si_analysis_type)] == -1} {
            append commands "#  ERROR: Variable vars(si_analysis_type) has illegal value\n"
            set errors($error_count) "Variable vars(si_analysis_type) has illegal value"
            incr error_count
            append commands "#         Must be one of '$valid'\n"
         }
      }

      set valid "post_cts post_route both none"

      if {[info exists vars(clock_eco)]} {
         if {[lsearch $valid $vars(clock_eco)] == -1} {
            append commands "#  ERROR: Variable vars(clock_eco) has illegal value\n"
            set errors($error_count) "Variable vars(clock_eco) has illegal value"
            incr error_count
            append commands "#         Must be one of '$valid'\n"
         }
      }

   ###############################################################################
   # The rda_Input(ui_pg_connections) variable is a special case as depending
   # on the value of this variable, other 'user defined' variables must be
   # dynamically checked
   ###############################################################################
   #if {[info exists vars(pg_connections)]} {
   #   foreach option $vars(pg_connections) {
   #      if {![info exists vars($option)]} {
   #         append commands "#  ERROR: The p/g connection definition is incomplete"
   #         append commands "             Please add 'set vars($option) <global_net>' to your setup.tcl"
   #         set errors($error_count) "The p/g connection definition is incomplete; variable vars($option) is required"
   #         incr error_count
   #      }
   #   }
   #}

      set check(plugins) [list]
      if {[info exists vars(metalfill)] && ($vars(metalfill) != false)} {
         set check(plugins) metalfill_tcl
      }
      append commands "#  ==============================================\n"
      append commands "#                Plug-ins\n"
      append commands "#  ==============================================\n"
      set rc_plugins "syn_init_tcl syn_load_rtl_tcl pre_syn_load_lib_tcl post_syn_load_lib_tcl \
                      pre_syn_elab_tcl post_syn_elab_tcl syn_dft_setup_tcl pre_syn_gen_tcl \
                      post_syn_gen_tcl pre_syn_map_tcl post_syn_map_tcl post_syn_dft_tcl \
                      pre_syn_incr_tcl post_syn_incr_tcl pre_syn_placed_tcl postload_syn_placed_tcl \
                      preexport_syn_placed_tcl preannotation_syn_placed_tcl post_syn_placed_tcl pre_syn_exit_tcl"
         set edi_plugins "always_source_tcl pre_init_tcl post_init_tcl \
                       pre_place_tcl place_tcl post_place_tcl pre_cts_tcl cts_tcl post_cts_tcl \
                       pre_prects_tcl post_prects_tcl pre_postcts_tcl post_postcts_tcl \
                       pre_postcts_hold_tcl post_postcts_hold_tcl pre_route_tcl post_route_tcl \
                       pre_postroute_tcl post_postroute_tcl pre_postroute_hold_tcl post_postroute_hold_tcl \
                       pre_postroute_si_tcl post_postroute_si_tcl pre_postroute_si_hold_tcl 
                       post_postroute_si_hold_tcl pre_signoff_tcl post_signoff_tcl \
                       pre_rebudget_tcl post_rebudget_tcl pre_flexilm_tcl post_flexilm_tcl pre_assemble_tcl post_assemble_tcl"
       
      if {$vars(rc)} {
         set plugin_list [join [concat $rc_plugins $edi_plugins]]
      } else {
         set plugin_list $edi_plugins
      }
      foreach plugin $plugin_list {
         if {[info exists vars($plugin)] && ($vars($plugin) != "")} {
            append commands "#  INFO: Plug-in $plugin = $vars($plugin)\n"
            lappend check(plugins) $plugin
            lappend vars(plugins_defined) $plugin 

         }
      }

      set dist(lsf) "queue resource args"
      set dist(custom) "script"
      set dist(rsh) "host_list"
      set dist(local) ""

      if {[info exists vars(distribute)]} {
         if {[info exists dist($vars(distribute))]} {
            append commands "#  ==============================================\n"
            append commands "#               Distribution Setup\n"
            append commands "#  ==============================================\n"
            append commands "#  INFO: Mode = $vars(distribute)\n"
            foreach option $dist($vars(distribute)) {
               if {![info exists vars($vars(distribute),$option)]} {
                  append commands "#  ERROR: Required variable vars($vars(distribute),$option) not defined\n"
                  set errors($error_count) "Required variable vars($vars(distribute),$option) not defined"
                  incr error_count
               } else {
                  append commands "#  INFO:    $option = $vars($vars(distribute),$option)\n"
               }
            }
         } else {
            append commands "#  ERROR: Distribution mode $vars(distribute) not supported\n"
            set errors($error_count) "Distribution mode $vars(distribute) not supported"
            incr error_count
         }
      } else {
         if {[info exists vars(hosts)] && ($vars(hosts) > 1)} {
            append commands "#WARNING: Variable vars(hosts) > 1 but vars(distribute) not defined\n"
            set warnings($warning_count) "Variable vars(hosts) > 1 but vars(distribute) not defined"
            incr warning_count
         }
      }

      append commands "#  ==============================================\n"
      append commands "#               Type Check\n"
      append commands "#  ==============================================\n"
      foreach integer $check(integers) {
         if {![string is integer -strict $vars($integer)]} {
            append commands "#  ERROR: Variables is not an integer ($integer) ...\n"
            set errors($error_count) "Variables is not an integer ($integer) ..."
            incr error_count
         }
      } 
      append commands "#  ==============================================\n"
      append commands "#               File Check\n"
      append commands "#  ==============================================\n"
      set files 0
      append commands "#  INFO: Checking design files ...\n"
      foreach file $check(files) {
   #   append commands "#  INFO:    $file ...\n"
         if {![file exists $file]} {
            append commands "#  ERROR: File does not exist ($file) ...\n"
            set errors($error_count) "File does not exist ($file)"
            incr error_count
         } else {
            incr files
         }
      }
      append commands "#  INFO:    ... found $files files\n"
      set files 0
      append commands "#  INFO: Checking LEF files ...\n"
      if {[info exists vars(lef_files)]} {
         foreach file $vars(lef_files) {
            if {![file exists $file]} {
               append commands "#  ERROR: File does not exist ($file)\n"
               set errors($error_count) "File does not exist ($file)"
               incr error_count
            } else {
               incr files
            }
         }
         append commands "#  INFO:    ... found ($files/[llength $vars(lef_files)]) lef files\n"
      }
      set files 0
      set total 0
#      if {![info exists vars(cpf_file)]} {
         append commands "#  INFO: Checking library sets ...\n"
         foreach library_set $vars(library_sets) {
            if {[info exists vars(enable_ldb)] && $vars(enable_ldb)} {
               set temp_list $vars($library_set,timing,orig)
            } else {
               set temp_list $vars($library_set,timing)
            }
            foreach file $temp_list {
               incr total
               if {![file exists $file]} {
                  append commands "#  ERROR: File does not exist ($file)\n"
#                  set errors($error_count) "File does not exist ($file)"
#                  incr error_count
               } else {
                  incr files
               }
            } 
            if {[info exists vars($library_set,si)]} {
               foreach file $vars($library_set,si) {
                  incr total
                  if {![file exists $file]} {
                     append commands "#  WARNING: CDB file does not exist ($file)\n"
#                     set warnings($warning_count) "CDB file does not exist ($file)"
#                     incr warning_count
                  } else {
                     incr files
                  }
               }
            } else {
               if {!$vars(enable_si_aware)} {
                  append commands "#  WARNING: CDB libraries not defined for $library_set library set\n"
                  set warnings($warning_count) "CDB libraries not defined for $library_set library set"
                  incr warning_count
               }
            }
         }
         append commands "#  INFO:    ... found ($files/$total) library files\n"
         if {$total != $files} {
            set errors($error_count) "[expr $total - $files] timing library files were not found "
            incr error_count
         }
         set files 0
#      }
      append commands "#  INFO: Checking rc corners ...\n"
      foreach file $check(rc_corners) {
         if {![file exists $file]} {
            append commands "#  ERROR: File does not exist ($file)\n"
            set errors($error_count) "File does not exist ($file)"
            incr error_count
         } else {
            incr files
         }
      }
      append commands "#  INFO:    ... found $files files\n"
      set files 0
      append commands "#  INFO: Checking constraint modes ...\n"
      foreach file_list $check(constraint_modes) {
         foreach file $file_list {
            if {![file exists $file]} {
               if {![info exists vars(cpf_file)] || ([info exists vars(cpf_file)] && !$vars(cpf_timing))} {
                  append commands "#  ERROR: File does not exist ($file)\n"
                  set errors($error_count) "File does not exist ($file)"
                  incr error_count
               }
            } else {
               incr files
            }
         }
      }
      append commands "#  INFO:    ... found $files files\n"
      set files 0
      append commands "#  INFO: Checking plugin files ...\n"
      foreach plug $check(plugins) {
         set file $vars($plug)
         if {![file exists $file] && ![file exists $vars(plug_dir)/$file]} {
            append commands "#  WARNING: File does not exist ($file) ... continuing\n"
            lappend vars(missing_plugins) $plug 
         } else {
            lappend vars(plugins_found) $plug 
            incr files
            if {!$vars(enable_celtic_steps)} { 
               if {[regexp "postroute_si" $plug]} {
                  append warnings($warning_count) "Plug-in $plug will be skipped for siAware flow"
                  incr warning_count
                  append commands "#  WARNING: Plug-in $plug will be skipped for siAware flow\n"
                  append commands "#           To enable celtic based SI flow, use vars(enable_celtic_steps)\n"
               }
            }
         }
      }
      append commands "#  INFO:    ... found $files files\n"

      append commands "#  =====================================================\n"
      append commands "#                    Flow Options\n"
      append commands "#  =====================================================\n"
      if {[info exists vars(partition_list)]} {
         set flow hierarchical
      } else {
         set flow flat
      }
      append commands "#                    Flow = $flow\n"
      append commands "#                  Flavor = $vars(flow)\n"
      append commands "#  -----------------------------------------------------\n"
      append commands "#                    Placement Options\n"
      append commands "#  -----------------------------------------------------\n"
      if {[info exists vars(in_place_opt)]} {
         append commands "#            In Place Opt = $vars(in_place_opt)\n"
      }
      if {[info exists vars(no_pre_place_opt)]} {
         append commands "#         No PrePlace Opt = $vars(no_pre_place_opt)\n"
      }
      if {[info exists vars(place_io_pins)]} {
         append commands "#           Place IO Pins = $vars(place_io_pins)\n"
      }
      if {[info exists vars(clock_gate_aware)]} {
         append commands "#        Clock Gate Aware = $vars(clock_gate_aware)\n"
      }
      if {[info exists vars(congestion_effort)]} {
         if {$vars(congestion_effort) == "none"} {
            unset vars(congestion_effort)  
         } else {
            append commands "#       Congestion Effort = $vars(congestion_effort)\n"
         }
      }
      append commands "#  -----------------------------------------------------\n"
      append commands "#                   Clock Tree Options\n"
      append commands "#  -----------------------------------------------------\n"
      append commands "#        Route Clock Nets = $vars(route_clock_nets)\n"
      if {[info exists vars(clock_eco)]} {
         append commands "#               Clock ECO = $vars(clock_eco)\n"
      }
      append commands "#  -----------------------------------------------------\n"
      append commands "#                 Optimization Options\n"
      append commands "#  -----------------------------------------------------\n"
      if {[info exists vars(leakage_effort)]} {
         append commands "#          Leakage Effort = $vars(leakage_effort)\n"
      }
      if {[info exists vars(preserve_assertions)]} {
         append commands "#     Preserve Assertions = $vars(preserve_assertions)\n"
      }
      if {[info exists vars(useful_skew)]} {
         append commands "#             Useful Skew = $vars(useful_skew)\n"
      }
      if {[info exists vars(critical_range)]} {
         append commands "#          Critical Range = $vars(critical_range)\n"
      }
      if {[info exists vars(all_end_points)]} {
         append commands "#          All End Points = $vars(all_end_points)\n"
      }
      if {[info exists vars(size_only_file)]} {
         append commands "#          Size Only File = $vars(size_only_file)\n"
      }
      if {[info exists vars(dont_use_file)]} {
         append commands "#          Don't Use File = $vars(dont_use_file)\n"
      }
      if {[info exists vars(skew_buffers)]} {
         append commands "#            Skew Buffers = $vars(skew_buffers)\n"
      }
      if {[info exists vars(enable_pac)]} {
         append commands "#              Enable PAC = $vars(enable_pac)\n"
         if {[info exists vars(partition_list)]} {
            foreach pac $vars(partition_list) {
               if {[info exists vars($pac,pac_mode)]} {
                  append commands "#                   $pac -> $vars($pac,pac_mode)\n"
               }
            }
         }
      }
      append commands "#  -----------------------------------------------------\n"
      append commands "#                  Hold Fixing Options\n"
      append commands "#  -----------------------------------------------------\n"
      append commands "#                Fix Hold = $vars(fix_hold)\n"
      if {[info exists vars(fix_hold_effort)]} {
         append commands "#         Fix Hold Effort = $vars(fix_hold_effort)\n"
      }
      if {[info exists vars(fix_hold_ignore_ios)]} {
         append commands "#             Ignore IOs  = $vars(fix_hold_ignore_ios)\n"
      }
      if {[info exists vars(fix_hold_allow_tns_degradation)]} {
         append commands "#   Allow TNS Degradation = $vars(fix_hold_allow_tns_degradation)\n"
      }
      append commands "#  -----------------------------------------------------\n"
      append commands "#                     Timing Options\n"
      append commands "#  -----------------------------------------------------\n"
      append commands "#             Enable CPPR = $vars(enable_cppr)\n"
      append commands "#              Enable OCV = $vars(enable_ocv)\n"
      append commands "#             Enable AOCV = $vars(enable_aocv)\n"
      append commands "#               Enable SS = $vars(enable_ss)\n"
      append commands "#  -----------------------------------------------------\n"
      append commands "#                    Routing Options\n"
      append commands "#  -----------------------------------------------------\n"
      if {[info exists vars(multi_cut_effort)]} {
         append commands "#        Multi-Cut Effort = $vars(multi_cut_effort)\n"
      }
      if {[info exists vars(litho_driven_routing)]} {
         append commands "#    Litho Driven Routing = $vars(litho_driven_routing)\n"
      }
      if {[info exists vars(antenna_diode)] && ($vars(antenna_diode) != "")} {
         append commands "#           Antenna Diode = $vars(antenna_diode)\n"
      }
      if {[info exists vars(relative_c_thresh)] || \
          [info exists vars(total_c_thresh)] || \
          [info exists vars(coupling_c_thresh)] ||\
          [info exists vars(postroute_extraction_effort)] ||\
          [info exists vars(signoff_extraction_effort)]} {
         append commands "#  -----------------------------------------------------\n"
         append commands "#                   Extraction Options\n"
         append commands "#  -----------------------------------------------------\n"
      }
      if {[info exists vars(relative_c_thresh)]} {
         append commands "#    Relative C Threshold = $vars(relative_c_thresh)\n"
      }
      if {[info exists vars(total_c_thresh)]} {
         append commands "#       Total C Threshold = $vars(total_c_thresh)\n"
      }
      if {[info exists vars(coupling_c_thresh)]} {
         append commands "#    Coupling C Threshold = $vars(coupling_c_thresh)\n"
      }
      if {[info exists vars(postroute_extraction_effort)]} {
         append commands "#  Postroute Effort Level = $vars(postroute_extraction_effort)\n"
      }
      if {[info exists vars(signoff_extraction_effort)]} {
         append commands "#    Signoff Effort Level = $vars(signoff_extraction_effort)\n"
      }

      append commands "#  -----------------------------------------------------\n"
      append commands "#                        DFM Options\n"
      append commands "#  -----------------------------------------------------\n"
      set check_lpa_tech 0
      set check_lpa_conf 0
      if {[info exists vars(fix_litho)] && $vars(fix_litho)} {
         append commands "#               Fix Litho = $vars(fix_litho)\n"
         set check_lpa_conf 1
         set vars(verify_litho) true
      }
      if {[info exists vars(verify_litho)] && $vars(verify_litho)} {
         append commands "#            Verify Litho = $vars(verify_litho)\n"
         set check_lpa_tech 1
      }
      if {[info exists vars(lpa_tech_file)]} {
         append commands "#           LPA Tech File = $vars(lpa_tech_file)\n"
      } 
      if {$check_lpa_tech} { 
         if {![info exists vars(lpa_tech_file)]} {
            set errors($error_count) "LPA tech file not defined ..."
            incr error_count
         }
      }
      if {[info exists vars(lpa_conf_file)]} {
         append commands "#           LPA Conf File = $vars(lpa_conf_file)\n"
      }
      if {$check_lpa_conf} { 
         if {![info exists vars(lpa_conf_file)]} {
            set errors($error_count) "LPA conf file not defined ..."
            incr error_count
         }
      }
      append commands "#  -----------------------------------------------------\n"
      append commands "#                Signal Integrity Options\n"
      append commands "#  -----------------------------------------------------\n"
      append commands "#                 Process = $vars(process)\n"
      if {[info exists vars(delta_delay_threshold)]} {
         append commands "#   Delta Delay Threshold = $vars(delta_delay_threshold)\n"
      }
      if {[info exists vars(celtic_settings)]} {
         append commands "#         Celtic Settings = $vars(celtic_settings)\n"
      }
      if {[info exists vars(si_analysis_type)]} {
         append commands "#           Analysis Type = $vars(si_analysis_type)\n"
      }
      if {[info exists vars(acceptable_wns)]} {
         append commands "#           Analysis Type = $vars(acceptable_wns)\n"
      }

      if {[info exists vars(distribute)]} {
         if {[info exists dist($vars(distribute))]} {
            append commands "#  -----------------------------------------------------\n"
            append commands "#                   Multiple CPUs\n"
            append commands "#  -----------------------------------------------------\n"
            append commands "#                    Mode = $vars(distribute)\n"
            if {[info exists vars(local_cpus)]} {
               append commands "#      CPUs On Local Host = $vars(local_cpus)\n"
            }
            if {[info exists vars(remote_hosts)]} {
               append commands "#  Number of Remote Hosts = $vars(remote_hosts)\n"
            }
            if {[info exists vars(cpus_per_remote_host)]} {
               append commands "#    CPUs Per Remote Host = $vars(cpus_per_remote_host)\n"
            }
         }
      } else {
         if {[info exists vars(local_cpus)]} {
            append commands "#  -----------------------------------------------------\n"
            append commands "#                   Multiple CPUs\n"
            append commands "#  -----------------------------------------------------\n"
            append commands "#      CPUs On Local Host = $vars(local_cpus)\n"
         }
      }
      if {$vars(high_timing_effort)} {
         append commands "#  -----------------------------------------------------\n"
         append commands "#          <<< HIGH EFFORT FLOW ENABLED >>>\n"
         append commands "#  -----------------------------------------------------\n"
      }

      append commands "#  =====================================================\n"
      append commands "#    Abort on Setup Error = $vars(abort)\n"
      append commands "#  =====================================================\n"

      if {[lindex [split $vars(version) "."]  0] > 10} {
         foreach var [array names save_vars] {
            set vars($var) $save_vars($var)
         }
      }
      set command ""
      set vars(info_count) $info_count
      if {$info_count > 0} {
         append command "#  -----------------------------------------------------\n"
         append command "#                   Info Summary\n"
         append command "#  -----------------------------------------------------\n"

         for {set i 0} {$i<$info_count} {incr i} {
            append command "#  ([expr $i + 1]) $infos($i)\n"
         }
         append command "#  -----------------------------------------------------\n"

         append commands $command
      }
      set vars(warning_count) $warning_count
      if {$warning_count > 0} {
         append command "#  -----------------------------------------------------\n"
         append command "#                   Warning Summary\n"
         append command "#  -----------------------------------------------------\n"

         for {set i 0} {$i<$warning_count} {incr i} {
            append command "#  ([expr $i + 1]) $warnings($i)\n"
         }
         append command "#  -----------------------------------------------------\n"

         append commands $command
      }
      set vars(error_count) $error_count
      if {$error_count > 0} {
         append command "#  -----------------------------------------------------\n"
         append command "#                    Error Summary\n"
         append command "#  -----------------------------------------------------\n"

         for {set i 0} {$i<$error_count} {incr i} {
            append command "#  ([expr $i + 1]) $errors($i)\n"
         }
         append command "#  -----------------------------------------------------\n"

         append commands $command

      } else {
            append commands "#                   SETUP CHECK PASSED\n"
            append commands "#  =====================================================\n"
      }

      file mkdir $vars(script_dir)
      set op [open $vars(script_dir)/check.rpt w]

      puts $op $commands

      close $op

      if {$vars(abort) && ($error_count > 0)} {
         puts "<FF> Aborting due to previous errors ..."
         puts "<FF> See $vars(script_dir)/check.rpt for details"
         puts ""
         puts "                  Error Summary"
         puts "                  -------------"

         for {set i 0} {$i<$error_count} {incr i} {
            puts "   ([expr $i + 1]) $errors($i)"
         }
         puts "-------------------------------------------------"
         exit -1
      }

      if {!$vars(codegen)} {
         if {![FF::is_lp_flow]} {
            return
         }
         set vars(required_procs) "get_clock_ports get_power_domains modify_power_domains add_power_switches \
                                   route_secondary_pg_nets buffer_always_on_nets insert_welltaps_endcaps"
	 #BCL: removing .ff.tcl from methodology
         #set op [open $vars(rundir)/.ff.tcl w]
         #puts "Puts <FF> LOADING FF LOW POWER UTILITIES ..."
         #set ff_lp_procs "\nnamespace eval FF_EDI:: {\n"
         #append ff_lp_procs [get_required_procs $vars(script_path)/ETC/EDI/utils.tcl]
         #append ff_lp_procs "}\n"
         #puts $op $ff_lp_procs
         #puts $op "catch {alias ff_modify_power_domains FF_EDI::modify_power_domains}"
         #puts $op "catch {alias ff_add_power_switches FF_EDI::add_power_switches}"
         #puts $op "catch {alias ff_route_secondary_pg_nets FF_EDI::route_secondary_pg_nets}"
         #puts $op "catch {alias ff_get_power_domains FF_EDI::get_power_domains}"
         #puts $op "catch {alias ff_buffer_always_on_nets FF_EDI::buffer_always_on_nets}"
         #puts $op "catch {alias ff_insert_welltaps_endcaps FF_EDI::insert_welltaps_endcaps}"
         #close $op
         #source $vars(rundir)/.ff.tcl
         #catch {exec rm -rf $vars(rundir)/.ff.tcl}
      }

      set vars(check_setup) 0

      # Record errors for later processing
      set vars(check_setup_errors) {}
      for {set i 0} {$i<$error_count} {incr i} {
         lappend vars(check_setup_errors) $errors($i)
      }
   }
   ###############################################################################
   # Procedure to determine flow flavor, check for ilms, etc.
   ###############################################################################

   proc check_flow {} {
   
      global vars
   
      set vars(ilm) 0
      set vars(top) 0
   
      if {![info exists vars(partition_list)] || ([info exists vars(partition_list)] && \
           ([file tail [file dirname [pwd]]] != "$vars(partition_dir)"))} {

         if {![info exists vars(partition_list)]} {
            set vars(flavor) flat
            if {![info exists vars(mode)]} {
               set vars(mode) "flat"
            }
         } else {
            set vars(flavor) hier
            if {![info exists vars(mode)]} {
               set vars(mode) "top_down"
            }
         }
     
         if {[info exists vars(partition_list)] && ($vars(mode) == "bottom_up")} {
            set vars(ilm) 1
         }
   
         if {[info exists vars(ilm_list)] && ($vars(ilm_list) != "")} {
            set vars(ilm) 1
         } else {
            set vars(ilm) 0
         }
   
      } else {
         if {[info exists vars(partition_list)]} {
            set ptn [file tail [pwd]]
            set vars(ptn) $ptn
            if {([file tail [file dirname [pwd]]] == "$vars(partition_dir)") &&
                ([lsearch $vars(partition_list) $ptn] == -1)} {
               set vars(ilm) 1
               set vars(top) 1
               FF_EDI::normalize_constraints
            }
         }
      }
      if {$vars(debug)} {
         puts "<DEBUG> Flow -> $vars(flavor) : Step -> $vars(step) : ILM -> $vars(ilm)"
      }
   }

   proc run_compile {} {
   
      global vars

      file mkdir $vars(script_dir)/EDI
      set op [open $vars(script_dir)/EDI/run_compile.tcl w]
   
      set commands ""
   
      if {![info exists vars(ldb_dir)]} {
         set vars(ldb_dir) LDB
      }
      file mkdir $vars(ldb_dir)
   
      foreach set $vars(library_sets) {
         set file_list [list]
         foreach file $vars($set,timing) {
            append commands "write_ldb -library $file -outfile $vars(ldb_dir)/[file tail $file.ldb]\n"
            lappend file_list $vars(ldb_dir)/[file tail $file].ldb
         }
         set vars($set,timing,orig) $vars($set,timing)
         set vars($set,timing) $file_list
      }
   
      puts $op "$commands\nexit\n"
      close $op
#      return $commands
   
   }

   # Generate the command to verify geometry. This is verifyGeometry
   # for traditional processes, verify_drc for 20nm and below.
   proc verify_geometry_command {} {
      global vars
      set process [regsub "nm" $vars(process) ""]
      if {$process > 20} {
         return "verifyGeometry"
      } else {
         return "verify_drc"
      }
   }

   ###############################################################################
   # Procedure to initialize the foundation flow 
   ###############################################################################

   proc initialize_flow {} {
      global vars
      global env

      set commands ""

      FF_EDI::seed_variables 1
      FF_EDI::check_setup

      if {[info exist env(VPATH)]} {
         file mkdir $env(VPATH)
      }

      if {[info exists vars(capture_metrics)] && $vars(capture_metrics)} { 
         append commands "\n#-------------------------------------------------------------\n"
         append commands "# Loading applets for metrics capture ...\n"
         append commands "#-------------------------------------------------------------\n"
         if {[file tail [file dirname [exec pwd]]] == $vars(partition_dir)} {
            append commands "source $vars(norm_script_path)/ETC/applet.tcl\n"
            append commands "source $vars(norm_script_path)/ETC/compatibility.tcl\n"
            append commands "set_attribute applet_search_path $vars(norm_script_path)/ETC/applets /\n"
         } else {
            append commands "source \$vars(script_path)/ETC/applet.tcl\n"
            append commands "source \$vars(script_path)/ETC/compatibility.tcl\n"
            append commands "set_attribute applet_search_path \$vars(script_path)/ETC/applets /\n"
         }
         append commands "applet load measure\n"
         append commands "applet load time_info\n"
         append commands "#-------------------------------------------------------------\n\n"
         append commands "if {\[file exists $vars(time_info_db)\]} {\n"
         append commands "   time_info -quiet -table ff_ext -load $vars(time_info_db)\n"
         append commands "}\n"
         append commands "#-------------------------------------------------------------\n\n"
      }

#      append commands "#---------------------------------------------------------------------\n"
#      append commands "#                 RUN SCRIPT FOR STEP '[string toupper $vars(step)]'\n"
#      append commands "#---------------------------------------------------------------------\n"
      if {$vars(report_system_info)} {
         append commands "ff_procs::system_info\n"
      }
      append commands [FF_EDI::initialize_multicpu]

      if {$vars(codegen)} {
         return $commands
      } else {
          uplevel #0 eval $commands
      }
   }

   proc load_design {step {current_step ""} {format 1}} {

      global env
      global vars
      global errors
      global warnings

      if {[info exists vars(hier)]} {
         set hier true
      } else {
         set hier false
      }

      if {$current_step == ""} {
         set current_step $step
      }

#      if {$step ==""} {
#         set step $vars(step)
#      }
#      if {![info exists vars(step)]} {
#         set vars(step) $step
#      }
      if {!$vars(codegen)} {
         set restore_design true
      }
      set design $vars(design)

      # Build restore_design command string
      # ... check first for starting_dbs
      # ... if not we need to know the design name as this may be a 
      #     recursive call in a hierarhical flow

      if {[info exists vars($current_step,starting_dbs)]} {
         if {[string compare -nocase $vars(dbs_format) "oa"]==0} {
            # Interpret the starting DBS as an OA triple
            set restore_command "[list restoreDesign -cellview $vars($current_step,starting_dbs)]\n"
         } else {
            if {[file isdirectory $vars($current_step,starting_dbs)]} {
               set restore_command "restoreDesign $vars($current_step,starting_dbs) $design\n"
            } elseif {[file exists $vars($current_step,starting_dbs)]} {
               set restore_command "restoreDesign $vars($current_step,starting_dbs).dat $design\n"
            } else {
               puts "<FF> Starting DBS ($vars($current_step,starting_dbs)) defined but does not exist"
               set restore_command "restoreDesign $vars($current_step,starting_dbs).dat $design\n"
               set warnings($vars(warning_count)) "Starting DBS ($vars($current_step,starting_dbs)) defined but does not exist"
               incr vars(warning_count)
            }
         }
      } else {
         # BCL: Added subst around vars(dbs_dir) to resolve vars(rundir)
         set dir [subst $vars(dbs_dir)]
         # Adding this for PV ...
         if {!$vars(codegen)} {
            if {[file exists $dir/$step.enc]} {
               # BCL: Changed "DBS" to $dir
               if {![catch {set foo [glob $dir/$step.enc.dat/*.conf]}]} {
                  # BCL: Changed "DBS" to $dir
                  regsub "\\\.conf" [glob $dir/$step.enc.dat/*.conf] "" temp
               } else {
                  # BCL: Changed "DBS" to $dir
                  if {![catch {set foo [glob $dir/$step.enc.dat/*.globals]}]} {
                     # BCL: Changed "DBS" to $dir
                     regsub "\\\.globals" [glob $dir/$step.enc.dat/*.globals] "" temp
                  }
               }
               if {$design != [file tail $temp]} {
                  set vars(design) [file tail $temp]
                  Puts "<FF> Updating design name to $design"
                  if {[info exists vars(partition_list)]} {
                     if {[lsearch $vars(partition_list) [file tail [pwd]]] != -1} {
                     set design [file tail [pwd]]
                     }
                  }
               }
            } else {
               Puts "<FF> Starting DBS $dir/$step.enc defined but does not exist"
               exit -1
            }
         }
         
         # Of course, the command will depend on the database format ... and the version
         if {[string compare -nocase $vars(dbs_format) "oa"]==0} {
            if {[lindex [split $vars(version) "."]  0] > 10} {
               if {$hier} {
                 set restore_command "restoreDesign -cellview \[list $vars(oa_partition_lib) $design $step\]\n"
               } else { 
                 set restore_command "restoreDesign -cellview \[list $vars(oa_design_lib) $design $step\]\n"
               }
            } else {
               set restore_command "restoreOaDesign $vars(oa_design_lib) $design $step\n"
            }
         } else {
            set restore_command "restoreDesign $dir/$step.enc.dat $design\n"
         }

      }
      # Pass the command through the wrapper and then make it conditional so it can 
      # be disabled in a single process flow
      set restore_command [FF::wrap_command $current_step,restore_design $restore_command]
      set cond_restore_command "if {\$vars(restore_design)} {\n$restore_command\n}"

      if {!$format} {
         if {$vars(codegen)} {
            return $cond_restore_command
         } else {
             eval $cond_restore_command
         }
      } else {
         if {$vars(catch_errors)} {
            append commands "\nif {\$vars(restore_design)} {\n"
            append commands "   if {\[catch {\n$restore_command}\]} {\n"
            append commands "      Puts \"<FF> ERROR LOADING DATABASE FROM STEP $step ... EXITING\"\n"
            append commands "      exit -1\n"
            append commands "   }\n"
            append commands "}\n"
         } else {
            append commands "\nif {\$vars(restore_design)} {\n"
            append commands "   $restore_command"
            append commands "}\n"
         }
         append commands [FF::source_plug always_source_tcl]

         if {$vars(codegen)} {
            return $commands
         } else {
             uplevel #0 eval $commands
         }
      }
   }

   ############################################################################
   # Setup procedure for run* steps
   ############################################################################

   proc initialize_step {step} {

      global vars
      global env
      global errors
      global warnings

      if {![info exists step]} {
         set step $var(step)
      }

      if {[info exists vars($step,rpt_dir)]} {
         set vars(rpt_dir) $vars($step,rpt_dir)
      } else {
         set vars(rpt_dir) $vars(orig_rpt_dir)
      }

      if {![info exists vars(warning_count)]} {
         set vars(warning_count) 0
      }
      if {![info exists vars(error_count)]} {
         set vars(error_count) 0
      }

      set commands ""
      if {$vars(verbose)} {
         append commands "#\n"
         append commands "# STEP $step\n"
         append commands "#\n"
      }

#      if {$vars(enable_qor_check)} {
#         set qor [catch {exec $check_qor $env(VPATH)/$last_step} msg]
#         if {$qor} {
#            puts "<FF> ERROR: QOR RESULT CHECK INDICATES A PROBLEM IN STEP $last_step"
#            exit -111
#         }
#      }
      set update_setup 0
      set update_hold 0

      set command ""
      if {[info exists vars($step,active_setup_views)] && ([llength $vars($step,active_setup_views)]>0)} {
         append command "set setup_analysis_views \"$vars($step,active_setup_views)\"\n"
         set update_setup 1
      }
      if {[info exists vars($step,active_hold_views)] && ([llength $vars($step,active_hold_views)]>0)} {
         append command "set hold_analysis_views \"$vars($step,active_hold_views)\"\n"
         set update_hold 1
      }

      set comments ""
      append comments "# The active analysis views are controlled by the following variables:\n"  
      append comments "#---------------------------------------------------------------------\n"
      append comments "# - vars($step,active_setup_views)\n"
      append comments "# - vars($step,active_hold_views)\n"
      append comments "#\n"
      append comments "######################################################################\n"
      if {$update_setup || $update_hold} {
         if {$vars(verbose)} {
            append commands "#\n"
            append commands "# <FF> UPDATING ANALYSIS VIEWS ...\n"
            append commands "#\n"
         }
         if {!$update_setup && $update_hold} {
#            append command "set_analysis_view -setup \[all_setup_analysis_views\] -hold \[list \$hold_analysis_views\]\n"
            append command "set_analysis_view -setup \[all_setup_analysis_views\] -hold \$hold_analysis_views\n"
         }
         if {$update_setup && !$update_hold} {
            append command "set_analysis_view -setup \$setup_analysis_views -hold \[all_hold_analysis_views\]\n"
         }
         if {$update_setup && $update_hold} {
#            append command "set_analysis_view -setup \[list \$setup_analysis_views\] -hold \[list \$hold_analysis_views\]\n"
            append command "set_analysis_view -setup \$setup_analysis_views -hold \$hold_analysis_views\n"
         }
         append commands $comments
         append commands "$command\n"
     } else {
         append comments "# set_analysis_view -setup \$vars($step,active_setup_views) -hold \$vars($step,active_hold_views)\n"
         append comments "#\n"
         append commands $comments
     }

      #########################################################################
      # Check if in top level partition (ilm) flow
      #########################################################################

      FF_EDI::check_flow

#      if {$vars(report_run_time)} {
#         append commands "set vars($step,start_time) \[clock seconds\]\n"
#      }

      #########################################################################
      # Load the recommended command mode settings for step
      #########################################################################

#      append commands "#\n"
#      append commands "# DEFINING MODE SETTINGS\n"
#      append commands "#\n"

      set comments ""
      set ucomments ""

      switch $step {

         "place" {
            ###################################################################
            # Set placement options ...
            # - Set optimization options if inPlaceOpt is enabled
            # - Load the CTS spec for clock gate aware placement
            # - Place JTAG cells if requested
            ###################################################################

            set process [regsub "nm" $vars(process) ""]
            append comments "# - vars(process)\n"
            if {$vars(high_timing_effort)} {
               append comments "# - vars(high_timing_effort)\n"
               if {![regexp "9.1" $vars(version)]} {
                  set command "setDesignMode -process $process -flowEffort high\n"
               } else {
                  set command "setDesignMode -process $process\n"
               }
            } else {
               set command "setDesignMode -process $process\n"
            }
            append commands [FF::wrap_command place,set_design_mode $command]

            if {$vars(enable_ss) == "pre_place"} {
               append comments "# - vars(enable_ss)\n"
               set command "setDelayCalMode -engine signalStorm\n"
               append commands [FF::wrap_command place,set_delay_cal_mode $command]
            } else {
               append ucomments "# - vars(enable_ss) \"pre_place\"\n"
            }

            set args ""
            if {![catch {set arg $vars(congestion_effort)}]} {
               append args " -congEffort $arg"
               append comments "# - vars(congestion_effort)\n"
            } else {
               append ucomments "# - vars(congestion_effort) \"auto low medium high\"\n"
            }
#            if {[info exists vars(clock_gate_aware)] &&  $vars(clock_gate_aware)} {
#               append comments "# - vars(clock_gate_aware)\n"
#               append args " -clkGateAware true"
#            }
            if {![catch {set arg $vars(clock_gate_aware)}]} {
               append comments "# - vars(clock_gate_aware)\n"
               append args " -clkGateAware $arg"
            } else {
               append ucomments "# - vars(clock_gate_aware) \"true\"\n"
            }
            if {![catch {set arg $vars(place_io_pins)}]} {
               append comments "# - vars(place_io_pins)\n"
               append args " -placeIoPins $arg"
            } else {
               append ucomments "# - vars(place_io_pins) \"true\"\n"
            }
#            set process [regsub "nm" $vars(process) ""]
#            if {[expr $process < 28] && [info exists vars(filler_cells,min_gap)]} {
#               append comments "# - vars(filler_cells,min_gap)\n"
#               append args " -fillerGapMinGap $vars(filler_cells,min_gap) -fillerGapEffort high\n"
#            } else {
#               append ucomments "# - vars(filler_cells,min_gap) \"<microns>\"\n"
#               append ucomments "# - vars(filler_cells,gap_effort) \"<low medium high> \"\n"
#            }

            if {$args != ""} {
               set command "setPlaceMode $args\n"
               append commands [FF::wrap_command place,set_place_mode $command]
            }

            if {[info exists vars(in_place_opt)] && $vars(in_place_opt)} {
               append comments "# - vars(in_place_opt)\n"
               set args ""
               if {![catch {set arg $vars(preserve_assertions)}]} {
                  append comments "# - vars(preserve_assertions)\n"
                  append args " -preserveAssertions $arg"
               } else {
                  append ucomments "# - vars(preserve_assertions) \"true\"\n"
               }
               if {![catch {set arg $vars(leakage_power_effort)}]} {
                  append comments "# - vars(leakage_power_effort)\n"
                  append args " -leakagePowerEffort $arg"
               } else {
                  append ucomments "# - vars(leakage_power_effort) \"low or high\"\n"
               }
               if {![catch {set arg $vars(dynamic_power_effort)}]} {
                  append comments "# - vars(dynamic_power_effort)\n"
                  append args " -dynamicPowerEffort $arg"
               } else {
                  append ucomments "# - vars(dynamic_power_effort) \"low or high\"\n"
               }
               if {![catch {set arg $vars(clock_gate_aware_opt)}]} {
                  append comments "# - vars(clock_gate_aware_opt)\n"
                  append args " -clkGateAware $arg"
               } else {
                  append ucomments "# - vars(clock_gate_aware_opt) \"true\"\n"
               }
               if {![catch {set arg $vars(critical_range)}]} {
                  append comments "# - vars(critical_range)\n"
                  append args " -criticalRange $arg"
               }
               if {[info exists vars(all_end_points)] && $vars(all_end_points)} {
                  append comments "# - vars(all_end_points)\n"
                  append args " -allEndPoints true"
               } else {
                  append ucomments "# - vars(all_end_points) \"true\"\n"
               }
               if {![catch {set arg $vars(size_only_file)}]} {
                  append comments "# - vars(size_only_file)\n"
                  append args " -sizeOnlyFile $arg"
               } else {
                  append ucomments "# - vars(size_only_file) \"<file>\"\n"
               }
               if {![catch {set arg $vars(fix_fanout_load)}]} {
                  append comments "# - vars(fix_fanout_load)\n"
                  append args " -fixFanoutLoad $arg"
               } else {
                  append ucomments "# - vars(fix_fanout_load) \"<file>\"\n"
               }
#               if {![catch {set arg $vars(useful_skew)}]} {
#                  append args " -usefulSkew $arg"
#                  if {![catch {set arg $vars(skew_buffers)}]} {
#                     append commands "setUsefulSkewMode -useCells \[list $arg\]\n"
#                  }
#               }
               if {$args != ""} {
                  set command "setOptMode $args\n"
                  append commands [FF::wrap_command place,set_opt_mode $command]
               }
            }

            
            set command [FF_EDI::add_tie_cells true false]
            append commands [FF::wrap_command place,add_tie_cells $command]

            if {[info exists vars(cts_spec)]} {
               set command "cleanupSpecifyClockTree\n"
               append commands [FF::wrap_command place,cleanup_specify_clock_tree $command]
               set command ""
               foreach spec $vars(cts_spec) {
                  append command "specifyClockTree -file $spec\n"
               }
               append commands [FF::wrap_command place,specify_clock_tree $command]
            }

            if {[info exists vars(jtag_cells)] &&
                [info exists vars(jtag_rows)]} {
               append comments "# - vars(jtag_cells), vars(jtag_rows)\n"
#               append commands "# PLACING JTAG CELLS\n"
               set command ""
               foreach inst $vars(jtag_cells) {
                  append command "specifyJtag -inst $inst\n"
               }
               append commands [FF::wrap_command place,specify_jtag $command]
               set command "placeJtag -nrRow $vars(jtag_rows)\n"
               append commands [FF::wrap_command place,place_jtag $command]
            }
         }

         "prects" {
            ###################################################################
            # Set optimization options ...
            # Enable signalStorm if requested (required for ECSM/CCS flows)
            # For low power flows, make sure always-on buffers are enabled
            ###################################################################

            set process [regsub "nm" $vars(process) ""]
            append comments "# - vars(process)\n"
            if {$vars(high_timing_effort)} {
               append comments "# - vars(high_timing_effort)\n"
               if {![regexp "9.1" $vars(version)]} {
                  set command "setDesignMode -process $process -flowEffort high\n"
               } else {
                  set command "setDesignMode -process $process\n"
               }
            } else {
               set command "setDesignMode -process $process\n"
            }
            append commands [FF::wrap_command prects,set_design_mode $command]
            set args "" 
            if {$vars(flow) == "mmmc"} {
               if {$vars(enable_ocv) == "pre_prects"} {
                  append comments "# - vars(enable_ocv)\n"
                  append args "-analysisType onChipVariation "
                  if {$vars(enable_aocv)} {
                     append comments "# - vars(enable_aocv)\n"
                     append args "-aocv true "
                  } else {
                     append ucomments "# - vars(enable_aocv)\n"
                  }
               } else {
                  append ucomments "# - vars(enable_ocv) \"pre_prects\"\n"
                  append ucomments "# - vars(enable_aocv) \"true\"\n"
               }
            }
            if {$args != ""} {
               set command "setAnalysisMode $args\n"
               append commands [FF::wrap_command prects,set_analysis_mode $command]
            }
            if {[info exists vars(clock_gate_clone)] && $vars(clock_gate_clone)} {
               if {([info exists vars(partition_list)])} {
                  if {[file tail [file dirname [pwd]]] == "$vars(partition_dir)"} {
                     set ptn [file tail [pwd]]
                     if {[info exists vars($ptn,cts_spec)]} {
                        set vars(cts_spec) $vars($ptn,cts_spec)
                     }
                  }
               }
      
               set scommand ""
               if {[info exists vars(cts_spec)]} {
                  set command "cleanupSpecifyClockTree\n"
                  append commands [FF::wrap_command prects,cleanup_specify_clock_tree $command]
                  foreach spec $vars(cts_spec) {
                     append scommand "specifyClockTree -file $spec\n"
                  }
               } else {
                  set command "createClockTreeSpec\n"
                  append commands [FF::wrap_command prects,create_clock_tree_spec $command]
                  if {[info exists vars(cts_cells)]} {
                    append scommand "specifyClockTree -update \"AutoCTSRootPin * Buffer $vars(cts_cells)\"\n"
                  }
               }
               if {[info exists vars(route_clock_nets)] && $vars(route_clock_nets)} {
                 append scommand "specifyClockTree -update \"AutoCTSRootPin * RouteClkNet YES\"\n"
               }
               if {!$vars(ilm)} {
                  append commands [FF::wrap_command prects,specify_clock_tree $scommand]
               }
#               if {![info exists vars(cts_spec)]} {
#                  append commands "clockDesign -genSpecOnly \[pid\].ctstch\n"
#                  append commands "specifyClockTree -file \[pid\].ctstch\n"
#               } else {
#                  foreach spec $vars(cts_spec) {
#                     append commands "specifyClockTree -file $spec\n"
#                  }
#               }
            }

            set args ""
            if {![catch {set arg $vars(preserve_assertions)}]} {
               append comments "# - vars(preserve_assertions)\n"
               append args " -preserveAssertions $arg"
            } else {
               append ucomments "# - vars(preserve_assertions) \"true\"\n"
            }
            if {![catch {set arg $vars(leakage_power_effort)}]} {
               append comments "# - vars(leakage_power_effort)\n"
               append args " -leakagePowerEffort $arg"
            } else {
               append ucomments "# - vars(leakage_power_effort) \"low or high\"\n"
            }
            if {![catch {set arg $vars(dynamic_power_effort)}]} {
               append comments "# - vars(dynamic_power_effort)\n"
               append args " -dynamicPowerEffort $arg"
            } else {
               append ucomments "# - vars(dynamic_power_effort) \"low or high\"\n"
            }
            if {![catch {set arg $vars(clock_gate_aware_opt)}]} {
               append comments "# - vars(clock_gate_aware_opt)\n"
               append args " -clkGateAware $arg"
            } else {
               append ucomments "# - vars(clock_gate_aware_opt) \"true\"\n"
            }
            if {![catch {set arg $vars(critical_range)}]} {
               append comments "# - vars(critical_range)\n"
               append args " -criticalRange $arg"
            }
            if {[info exists vars(all_end_points)] && $vars(all_end_points)} {
               append comments "# - vars(all_end_points)\n"
               append args " -allEndPoints true"
            } else {
               append ucomments "# - vars(all_end_points) \"true\"\n"
            }
            if {![catch {set arg $vars(size_only_file)}]} {
               append comments "# - vars(size_only_file)\n"
               append args " -sizeOnlyFile $arg"
            } else {
               append ucomments "# - vars(size_only_file) \"<file>\"\n"
            }
            if {![catch {set arg $vars(fix_fanout_load)}]} {
              append comments "# - vars(fix_fanout_load)\n"
              append args " -fixFanoutLoad $arg"
            } else {
              append ucomments "# - vars(fix_fanout_load) \"<file>\"\n"
            }
            if {![catch {set arg $vars(useful_skew)}]} {
               append comments "# - vars(useful_skew)\n"
               append args " -usefulSkew $arg"
               if {$vars(useful_skew) && ![catch {set arg $vars(skew_buffers)}]} {
                  append comments "# - vars(skew_buffers)\n"
                  set command "setUsefulSkewMode -delayPreCTS true -useCells \[list $arg\]\n"
                  append commands [FF::wrap_command prects,set_useful_skew_mode $command]
               }
            } else {
               append ucomments "# - vars(useful_skew) \"true\"\n"
               append ucomments "# - vars(skew_buffers) \"<list of buffers>\"\n"
            }
            if {[FF::is_lp_flow]} {
               if {![catch {set arg $vars(resize_shifter_and_iso_insts)}]} {
                  append comments "# - vars(resize_shifter_and_iso_insts)\n"
                  append args " -resizeShifterAndIsoInsts $arg"
               }
            }
            if {$args != ""} {
               set command "setOptMode $args\n"
               append commands [FF::wrap_command prects,set_opt_mode $command]
            }

            if {$vars(enable_ss) == "pre_prects"} {
               append comments "# - vars(enable_ss)\n"
               set command "setDelayCalMode -engine signalStorm\n"
               append commands [FF::wrap_command prects,set_delay_cal_mode $command]
            } else {
               append ucomments "# - vars(enable_ss) \"pre_prects\"\n"
            }
            if {[FF::is_lp_flow]} {
               set command ""
               if {[info exists vars(always_on_buffers)]} {
                  append comments "# - vars(always_on_buffers)\n"
                  foreach buffer $vars(always_on_buffers) {
                     append command "setDontUse $buffer false\n"
                  }
               }
               foreach domain [FF::get_by_suffix vars ",always_on_buffers"] {
                  if {[info exists vars($domain,always_on_buffers)]} {
                     foreach buffer $vars($domain,always_on_buffers) {
                        append command "setDontUse $buffer false\n"
                     }
                  }
               }
               if {$command != ""} {
                  append commands [FF::wrap_command prects,set_dont_use $command]
               }
            }
         }

         "cts" {
            ###################################################################
            # Set CTS options ... this includes nanoroute options as the clock
            # net is typically routed during CTS. For hierarchical flows, the
            # clock tree spec is defined per partition .
            ###################################################################

            set process [regsub "nm" $vars(process) ""]
            append comments "# - vars(process)\n"
            if {$vars(high_timing_effort)} {
               append comments "# - vars(high_timing_effort)\n"
               if {![regexp "9.1" $vars(version)]} {
                  set command "setDesignMode -process $process -flowEffort high\n"
               } else {
                  set command "setDesignMode -process $process\n"
               }
            } else {
               set command "setDesignMode -process $process\n"
            }
            append commands [FF::wrap_command cts,set_design_mode $command]

            set command "setCTSMode "
            if {![catch {set arg $vars(route_clock_nets)}]} {
               append comments "# - vars(route_clock_nets)\n"
               append command " -routeClkNet $arg"
            } else {
               append ucomments "# - vars(route_clock_nets)\n"
            }
            if {[info exists vars(clk_tree_top_layer)] && $vars(clk_tree_top_layer) != {}} {
               append comments "# - vars(clk_tree_top_layer)\n"
               append command " -routeTopPreferredLayer $vars(clk_tree_top_layer)"
            } else {
               append ucomments "# - vars(clk_tree_top_layer)\n"
            }
            if {[info exists vars(clk_leaf_top_layer)] && $vars(clk_leaf_top_layer) != {}} {
               append comments "# - vars(clk_leaf_top_layer)\n"
               append command " -routeLeafTopPreferredLayer $vars(clk_leaf_top_layer)"
            } else {
               append ucomments "# - vars(clk_leaf_top_layer)\n"
            }
            if {[info exists vars(clk_tree_bottom_layer)] && $vars(clk_tree_bottom_layer) != {}} {
               append comments "# - vars(clk_tree_bottom_layer)\n"
               append command " -routeBottomPreferredLayer $vars(clk_tree_bottom_layer)"
            } else {
               append ucomments "# - vars(clk_tree_bottom_layer)\n"
            }
            if {[info exists vars(clk_leaf_bottom_layer)] && $vars(clk_leaf_bottom_layer) != {}} {
               append comments "# - vars(clk_leaf_bottom_layer)\n"
               append command " -routeLeafBottomPreferredLayer $vars(clk_leaf_bottom_layer)"
            } else {
               append ucomments "# - vars(clk_leaf_bottom_layer)\n"
            }
            if {[info exists vars(clk_tree_ndr)] && $vars(clk_tree_ndr) != {}} {
               append comments "# - vars(clk_tree_ndr)\n"
               append command " -routeNonDefaultRule $vars(clk_tree_ndr)"
            } else {
               append ucomments "# - vars(clk_tree_ndr)\n"
            }
            if {[info exists vars(clk_tree_extra_space)] && $vars(clk_tree_extra_space) != {}} {
               append comments "# - vars(clk_tree_extra_space)\n"
               append command " -routePreferredExtraSpace $vars(clk_tree_extra_space)"
            } else {
               append ucomments "# - vars(clk_tree_extra_space)\n"
            }
            if {[info exists vars(clk_leaf_ndr)] && $vars(clk_leaf_ndr) != {}} {
               append comments "# - vars(clk_leaf_ndr)\n"
               append command " -routeLeafNonDefaultRule $vars(clk_leaf_ndr)"
            } else {
               append ucomments "# - vars(clk_leaf_ndr)\n"
            }
            if {[info exists vars(clk_leaf_extra_space)] && $vars(clk_leaf_extra_space) != {}} {
               append comments "# - vars(clk_leaf_extra_space)\n"
               append command " -routeLeafPreferredExtraSpace $vars(clk_leaf_extra_space)"
            } else {
               append ucomments "# - vars(clk_leaf_extra_space)\n"
            }
            if {$command != "setCTSMode "} {
               append command "\n"
               append commands [FF::wrap_command cts,set_cts_mode $command]
            }

            set command ""
            if {[string tolower $vars(cts_engine)] != "cts"} {
#               FF_EDI::assign_cts_cells
               foreach corner $vars(rc_corners) {
                  if {[info exists vars($corner,atf_file)]} {
                      append command "update_ccopt_rc_corner -name $corner -atf $vars($corner,atf_file)\n"
                  }
               }
               if {$command != ""} {
                  append command "\n"
                  append commands [FF::wrap_command cts,update_ccopt_rc_corner $command]
               }
               set command "setCCOptMode "
               if {[info exists vars(ccopt_integration)]} {
                  append comments "# - vars(ccopt_integration)\n"
                  append command " -integration \"$vars(ccopt_integration)\""
               } else {
                  append ucomments "# - vars(ccopt_integration)\n"
               }
               if {[info exists vars(cts_inverter_cells)]} {
                  append comments "# - vars(cts_inverter_cells)\n"
                  append command " -cts_inverter_cells \"$vars(cts_inverter_cells)\""
               } else {
                  append ucomments "# - vars(cts_inverter_cells)\n"
               }
               if {[info exists vars(cts_buffer_cells)]} {
                  append comments "# - vars(cts_buffer_cells)\n"
                  append command " -cts_buffer_cells \"$vars(cts_buffer_cells)\""
               } else {
                  append ucomments "# - vars(cts_buffer_cells)\n"
               }
               if {[info exists vars(clock_gate_cells)]} {
                  append comments "# - vars(clock_gate_cells)\n"
                  append command " -cts_clock_gating_cells \"$vars(clock_gate_cells)\""
               } else {
                  append ucomments "# - vars(clock_gate_cells)\n"
               }
               if {[info exists vars(cts_use_inverters)]} {
                  append comments "# - vars(cts_use_inverters)\n"
                  append command " -cts_use_inverters [string tolower $vars(cts_use_inverters)]"
               } else {
                  append ucomments "# - vars(cts_use_inverters)\n"
               }
               if {[info exists vars(update_io_latency)]} {
                  append comments "# - vars(update_io_latency)\n"
                  append command " -ccopt_modify_clock_latency $vars(update_io_latency)"               
               } else {
                  append ucomments "# - vars(update_io_latency)\n"
               }
               if {[info exists vars(cts_io_opt)]} {
                  append comments "# - vars(cts_io_opt)\n"
                  append command " -io_opt [string tolower $vars(cts_io_opt)]"
               } else {
                  append ucomments "# - vars(cts_io_opt)\n"
               }
               if {[info exists vars(cts_effort)]} {
                  append comments "# - vars(cts_effort)\n"
                  append command " -effort $vars(cts_effort)"               
               } else {
                  append ucomments "# - vars(cts_effort)\n"
               }
               if {[info exists vars(cts_target_skew)]} {
                  append comments "# - vars(cts_target_skew)\n"
                  append command " -cts_target_skew $vars(cts_target_skew)"               
               } else {
                  append ucomments "# - vars(cts_target_skew)\n"
               }
               if {[info exists vars(cts_target_slew)]} {
                  append comments "# - vars(cts_target_slew)\n"
                  append command " -cts_target_slew $vars(cts_target_slew)"               
               } else {
                  append ucomments "# - vars(cts_target_slew)\n"
               }
               if {[info exists vars(pre_ccopt_tcl)]} {
                  append comments "# - vars(pre_ccopt_tcl)\n"
                  append command " -pre_tcl \{ source $vars(pre_ccopt_tcl) \}"               
               }
               if {[info exists vars(post_ccopt_tcl)]} {
                  append comments "# - vars(post_ccopt_tcl)\n"
                  append command " -post_tcl \{ source $vars(post_ccopt_tcl) \}"
               }
               if {[info exists vars(ccopt_executable)]} {
                  append comments "# - vars(ccopt_executable)\n"
                  append command " -envAdvancedIntegrationLink $vars(ccopt_executable)"               
               } else {
                  append ucomments "# - vars(ccopt_executable)\n"
               }
               if {[info exists vars(clk_tree_ndr)]} {
                  append command " -route_top_non_default_rule $vars(clk_tree_ndr)"
               }
               if {[info exists vars(clk_tree_shield_net)]} {
                  append comments "# - vars(clk_tree_shield_net)\n"
                  append command " -route_top_shielding_net $vars(clk_tree_shield_net)"
               } else {
                  append ucomments "# - vars(clk_tree_shield_net)\n"
               }
               if {[info exists vars(clk_tree_top_layer)]} {
                  append command " -route_top_top_preferred_layer $vars(clk_tree_top_layer)"
               }
               if {[info exists vars(clk_tree_bottom_layer)]} {
                  append command " -route_top_bottom_preferred_layer $vars(clk_tree_bottom_layer)"
               }
               append command "\n"
               append commands [FF::wrap_command cts,set_ccopt_mode $command]
            }
            set args ""
            if {![catch {set arg $vars(multi_cut_effort)}]} {
               append comments "# - vars(multi_cut_effort)\n"
               append args " -drouteUseMultiCutViaEffort $arg"
            } else {
               append ucomments "# - vars(multi_cut_effort)\n"
            }
            if {![catch {set arg $vars(litho_driven_routing)}]} {
               append comments "# - vars(litho_driven_routing)\n"
               append args " -routeWithLithoDriven $arg"
            } else {
               append ucomments "# - vars(litho_driven_routing)\n"
            }
            if {$args != ""} {
               set command "setNanoRouteMode $args\n"
               append commands [FF::wrap_command cts,set_nanoroute_mode $command]
            }

            if {([info exists vars(partition_list)]) &&
                ([file tail [file dirname [pwd]]] == "$vars(partition_dir)")} {
               set ptn [file tail [pwd]]
               if {[info exists vars($ptn,cts_spec)]} {
                  set vars(cts_spec) $vars($ptn,cts_spec)
               } else {
                  if {$ptn != $vars(design)} {
                     if {[info exists vars(cts_spec)]} {
                        unset vars(cts_spec)
                    }
                 }
               }
            }
         }

         "postcts" {
            ###################################################################
            # Optionally enable cppr, signalStorm, and onChipVariation (if
            # MMMC)
            ###################################################################

            set process [regsub "nm" $vars(process) ""]
            append comments "# - vars(process)\n"
            if {$vars(high_timing_effort)} {
               append comments "# - vars(high_timing_effort)\n"
               if {![regexp "9.1" $vars(version)]} {
                  set command "setDesignMode -process $process -flowEffort high\n"
                  append commands [FF::wrap_command postcts,set_design_mode $command]
               } else {
                  set command "setDesignMode -process $process\n"
                  append commands [FF::wrap_command postcts,set_design_mode $command]
                  append commands "setOptMode -unfixClkInstForOpt true\n"
               }
            } else {
               set command "setDesignMode -process $process\n"
               append commands [FF::wrap_command postcts,set_design_mode $command]
               append ucomments "# - vars(high_timing_effort)\n"
            }
            if {$vars(enable_ss) == "pre_postcts"} {
               append comments "# - vars(enable_ss)\n"
               set command "setDelayCalMode -engine signalStorm\n"
               append commands [FF::wrap_command postcts,set_delay_cal_mode $command]
            } else {
               append ucomments "# - vars(enable_ss) \"pre_postcts\"\n"
            }
            set args "" 
            if {$vars(enable_cppr) != "false"} {
               append comments "# - vars(enable_cppr)\n"
               append args "-cppr $vars(enable_cppr) "
            } else {
               append ucomments "# - vars(enable_cppr)\n"
            }
            if {$vars(flow) == "mmmc"} {
               if {$vars(enable_ocv) == "pre_postcts"} {
                  append comments "# - vars(enable_ocv)\n"
                  append args "-analysisType onChipVariation "
                  if {$vars(enable_aocv)} {
                     append comments "# - vars(enable_aocv)\n"
                     append args "-aocv true "
                  } else {
                     append ucomments "# - vars(enable_aocv)\n"
                  }
               } else {
                  append ucomments "# - vars(enable_ocv) \"pre_postcts\"\n"
                  append ucomments "# - vars(enable_aocv) \"true\"\n"
               }
            }
            if {$args != ""} {
               set command "setAnalysisMode $args\n"
               append commands [FF::wrap_command postcts,set_analysis_mode $command]
            }

            if {[info exists vars(cts_spec)]} {
               if {![catch {set arg $vars(clock_gate_clone)}]} {
                  append comments "# - vars(clock_gate_clone)\n"
                  set command "setOptMode -postCtsClkGateCloning $arg\n"
                  append commands [FF::wrap_command postcts,set_opt_mode $command]
               }
            }
         }

         "postcts_hold" {
            ###################################################################
            # Set hold fixing options ...
            ###################################################################

            if {[info exists vars(delay_cells)]} {
               append comments "# - vars(delay_cells)\n"
               set command ""
               foreach delay_cell $vars(delay_cells) {
                  append command "setDontUse $delay_cell false\n"
               }
               if {$command != ""} {
                  append commands [FF::wrap_command postcts_hold,set_dont_use $command]
               }
            } else {
               append ucomments "# - vars(delay_cells)\n"
            }
            set args ""
            if {![catch {set arg $vars(fix_hold_allow_tns_degradation)}]} {
               append comments "# - vars(fix_hold_allow_tns_degradation)\n"
               append args " -fixHoldAllowSetupTnsDegrade $arg"
            } else {
               append ucomments "# - vars(fix_hold_allow_tns_degradation)\n"
            }
            if {$vars(fix_hold_ignore_ios)} {
               #append commands "setAnalysisMode -honorClockDomains true\n" 
               append comments "# - vars(fix_hold_ignore_ios)\n"
               append args " -ignorePathGroupsForHold {in2reg reg2out in2out}"
            } else {
               append ucomments "# - vars(fix_hold_ignore_ios)\n"
            }
            if {$args != ""} {
               set command "setOptMode $args\n"
               append commands [FF::wrap_command postcts_hold,set_opt_mode $command]
            }
         }

         "route" {
            ###################################################################
            # Set routing options  ...
            # Recommendations for multicut via insertion and litho driven
            # routing.  These all incur runtime penalties but have yield
            # advantages so are included here. The routeWithLithoDriven option
            # is recommended for 45nm but may also be used at 65nm. The
            # -drouteUseMultiCutViaEffort can be set to high if needed;
            # expect an average of 5% coverage improvement with an average 10%
            # runtime hit versus medium
            ###################################################################

            set args ""
            if {![catch {set arg $vars(multi_cut_effort)}]} {
               append comments "# - vars(multi_cut_effort)\n"
               append args " -drouteUseMultiCutViaEffort $arg"
            } else {
               append ucomments "# - vars(multi_cut_effort)\n"
            }
            if {![catch {set arg $vars(litho_driven_routing)}]} {
               append comments "# - vars(litho_driven_routing)\n"
               append args " -routeWithLithoDriven $arg"
            } else {
               append ucomments "# - vars(litho_driven_routing)\n"
            }
            if {![catch {set arg $vars(antenna_diode)}]} {
               if {$vars(antenna_diode) != ""} {
                  append comments "# - vars(antenna_diode)\n"
                  append args " -routeAntennaCellName $arg"
                  append args " -routeInsertAntennaDiode true"
               } else {
                  append ucomments "# - vars(antenna_diode)\n"
               }
            } else {
               append ucomments "# - vars(antenna_diode)\n"
            }
            if {$args != ""} {
               set command "setNanoRouteMode $args\n"
               append commands [FF::wrap_command route,set_nanoroute_mode $command]
            }
         }

         "postroute" {
            ###################################################################
            # Set extraction effort for postroute optimization
            # Enable signalStorm if requested
            ###################################################################

            set process [regsub "nm" $vars(process) ""]
            append comments "# - vars(process)\n"
            if {$vars(high_timing_effort)} {
               append comments "# - vars(high_timing_effort)\n"
               if {![regexp "9.1" $vars(version)]} {
                  set command "setDesignMode -process $process -flowEffort high\n"
                  append commands [FF::wrap_command postroute,set_design_mode $command]
               } else {
                  set command "setDesignMode -process $process\n"
                  append commands [FF::wrap_command postroute,set_design_mode $command]
                  append commands "setOptMode -unfixClkInstForOpt true\n"
               }
            } else {
               set command "setDesignMode -process $process\n"
               append commands [FF::wrap_command postroute,set_design_mode $command]
            }

            set command "setExtractRCMode -engine postRoute"
            if {![catch {set arg $vars(postroute_extraction_effort)}]} {
               append comments "# - vars(postroute_extraction_effort)\n"
               append command " -effortLevel $arg"
            } else {
               append ucomments "# - vars(postroute_extraction_effort)\n"
            }
            if {![catch {set arg $vars(total_c_thresh)}]} {
               append comments "# - vars(total_c_thresh)\n"
               append command " -total_c_th $arg"
            } else {
               append ucomments "# - vars(total_c_thresh)\n"
            }
            if {![catch {set arg $vars(relative_c_thresh)}]} {
               append comments "# - vars(relative_c_thresh)\n"
               append command " -relative_c_th $arg"
            } else {
               append ucomments "# - vars(relative_c_thresh)\n"
            }
            if {![catch {set arg $vars(coupling_c_thresh)}]} {
               append comments "# - vars(coupling_c_thresh)\n"
               append command " -coupling_c_th $arg"
            } else {
               append ucomments "# - vars(relative_c_thresh)\n"
            }
            if {![catch {set arg $vars(qrc_layer_map)}]} {
               append comments "# - vars(qrc_layer_map)\n"
               append command " -lefTechFileMap $arg"
            } else {
               append ucomments "# - vars(qrc_layer_map)\n"
            }
            append command "\n"
            append commands [FF::wrap_command postroute,set_extract_rc_mode $command]
             

            set args ""
            if {($vars(enable_ocv) == "pre_postroute") || ($vars(enable_ocv) == "pre_postcts")} {
               if {$vars(flow) != "default"} {
                  append comments "# - vars(enable_ocv)\n"
                  append args "-analysisType onChipVariation "
               }
               if {$vars(enable_aocv)} {
                  append comments "# - vars(enable_aocv)\n"
                  append args "-aocv true "
               } else {
                  append ucomments "# - vars(enable_aocv)\n"
               }
            } else {
               append ucomments "# - vars(enable_ocv) \"pre_postroute\"\n"
               append ucomments "# - vars(enable_aocv) \"true\"\n"
            }
            if {$vars(enable_cppr) != "false"} {
               append comments "# - vars(enable_cppr)\n"
               append args "-cppr $vars(enable_cppr) "
            } else {
               append ucomments "# - vars(enable_cppr)\n"
            }
            if {$args != ""} {
               set command "setAnalysisMode $args\n"
               append commands [FF::wrap_command postroute,set_analysis_mode $command]
            }

            if {[regexp "9.1" $vars(version)]} {
               if {$vars(enable_ss) == "pre_postroute"} {
                  append comments "# - vars(enable_ss)\n"
                  set command "setDelayCalMode -engine signalStorm -signoff true "
                  append commands [FF::wrap_command postroute,set_delay_cal_mode $command]
               } else {
                  append ucomments "# - vars(enable_ss) \"pre_postroute\"\n"
               }
            } else { 
               if {$vars(enable_si_aware)} {
                  set command "setDelayCalMode -siAware true -engine aae\n "
                  append commands [FF::wrap_command postroute,set_delay_cal_mode $command]
                  append comments "# - vars(enable_si_aware)\n"
                  if {$vars(enable_ss) == "pre_postroute"} {
                     append commands "# <FF> Variable vars(enable_ss) ignore when vars(enable_si_aware) is set"
                     set warnings($vars(warning_count)) "Variable vars(enable_ss) ignore when vars(enable_si_aware) is set"
                     incr vars(warning_count)
                  }
               } else {
                  append ucomments "# - vars(enable_si_aware)\n"
                  if {$vars(enable_ss) == "pre_postroute"} {
                     append comments "# - vars(enable_ss)\n"
                     set command "setDelayCalMode -engine signalStorm -signoff true -siAware false\n"
                     append commands [FF::wrap_command postroute,set_delay_cal_mode $command]
                  } else {
                     set command "setDelayCalMode -siAware false\n"
                     append commands [FF::wrap_command postroute,set_delay_cal_mode $command]
                     append ucomments "# - vars(enable_ss) \"pre_postroute\"\n"
                  }
               }
            }
         }

         "postroute_hold" {
            ###################################################################
            # Set hold fixing options ...
            ###################################################################

            set process [regsub "nm" $vars(process) ""]
            append comments "# - vars(process)\n"
            if {$vars(high_timing_effort)} {
               append comments "# - vars(high_timing_effort)\n"
               if {![regexp "9.1" $vars(version)]} {
                  set command "setDesignMode -process $process -flowEffort high\n"
                  append commands [FF::wrap_command postroute_hold,set_design_mode $command]
               } else {
                  set command "setDesignMode -process $process\n"
                  append commands [FF::wrap_command postroute_hold,set_design_mode $command]
                  append commands "setOptMode -unfixClkInstForOpt true\n"
               }
            } else {
               set command "setDesignMode -process $process\n"
               append commands [FF::wrap_command postroute_hold,set_design_mode $command]
            }

            set command "setExtractRCMode -engine postRoute"
            if {![catch {set arg $vars(postroute_extraction_effort)}]} {
               append comments "# - vars(postroute_extraction_effort)\n"
               append command " -effortLevel $arg"
            } else {
               append ucomments "# - vars(postroute_extraction_effort)\n"
            }
            if {![catch {set arg $vars(total_c_thresh)}]} {
               append comments "# - vars(total_c_thresh)\n"
               append command " -total_c_th $arg"
            } else {
               append ucomments "# - vars(total_c_thresh)\n"
            }
            if {![catch {set arg $vars(relative_c_thresh)}]} {
               append comments "# - vars(relative_c_thresh)\n"
               append command " -relative_c_th $arg"
            } else {
               append ucomments "# - vars(relative_c_thresh)\n"
            }
            if {![catch {set arg $vars(coupling_c_thresh)}]} {
               append comments "# - vars(coupling_c_thresh)\n"
               append command " -coupling_c_th $arg"
            } else {
               append ucomments "# - vars(coupling_c_thresh)\n"
            }
            if {![catch {set arg $vars(qrc_layer_map)}]} {
               append comments "# - vars(qrc_layer_map)\n"
               append command " -lefTechFileMap $arg"
            } else {
               append ucomments "# - vars(qrc_layer_map)\n"
            }
            append command "\n"
            append commands [FF::wrap_command postroute_hold,set_extract_rc_mode $command]
            set command "" 
            if {[info exists vars(delay_cells)]} {
               append comments "# - vars(delay_cells)\n"
               foreach delay_cell $vars(delay_cells) {
                  append command "setDontUse $delay_cell false\n"
               }
            } else {
               append ucomments "# - vars(delay_cells)\n"
            }
            if {$command != ""} {
               append commands [FF::wrap_command postroute_hold,set_dont_use_mode $command]
            }

            set args ""
            if {![catch {set arg $vars(fix_hold_allow_tns_degradation)}]} {
               append comments "# - vars(fix_hold_allow_tns_degradation)\n"
               append args " -fixHoldAllowSetupTnsDegrade $arg"
            } else {
               append ucomments "# - vars(fix_hold_allow_tns_degradation)\n"
            }
            if {$vars(fix_hold_ignore_ios)} {
               #append commands "setAnalysisMode -honorClockDomains true\n" 
               append comments "# - vars(fix_hold_ignore_ios)\n"
               append args " -ignorePathGroupsForHold {in2reg reg2out in2out}"
            } else {
               append ucomments "# - vars(fix_hold_ignore_ios)\n"
            }
            if {$args != ""} {
               set command "setOptMode $args\n"
               append commands [FF::wrap_command postroute_hold,set_opt_mode $command]
            }
         }

         "postroute_si" {
            ###################################################################
            # Set noise, extraction, and SI options ...
            # Enable signalStorm if requested
            # Enable onChipVariation (if MMMC)
            ###################################################################

            set process [regsub "nm" $vars(process) ""]
            append comments "# - vars(process)\n"
            if {$vars(high_timing_effort)} {
               append comments "# - vars(high_timing_effort)\n"
               if {![regexp "9.1" $vars(version)]} {
                  set command "setDesignMode -process $process -flowEffort high\n"
               } else {
                  set command "setDesignMode -process $process\n"
               }
            } else {
               set command "setDesignMode -process $process\n"
            }
            append commands [FF::wrap_command postroute_si,set_design_mode $command]

            set command "setExtractRCMode -coupled true"
            if {![catch {set arg $vars(total_c_thresh)}]} {
               append comments "# - vars(total_c_thresh)\n"
               append command " -total_c_th $arg"
            } else {
               append ucomments "# - vars(total_c_thresh)\n"
            }
            if {![catch {set arg $vars(relative_c_thresh)}]} {
               append comments "# - vars(relative_c_thresh)\n"
               append command " -relative_c_th $arg"
            } else {
               append ucomments "# - vars(relative_c_thresh)\n"
            }
            if {![catch {set arg $vars(coupling_c_thresh)}]} {
               append comments "# - vars(coupling_c_thresh)\n"
               append command " -coupling_c_th $arg"
            } else {
               append ucomments "# - vars(coupling_c_thresh)\n"
            }
            if {![catch {set arg $vars(qrc_layer_map)}]} {
               append comments "# - vars(qrc_layer_map)\n"
               append command " -lefTechFileMap $arg"
            } else {
               append ucomments "# - vars(qrc_layer_map)\n"
            }
            append command "\n"
            append commands [FF::wrap_command postroute_si,set_extract_rc_mode $command]

            set args ""
            if {![catch {set arg $vars(delta_delay_threshold)}]} {
               append comments "# - vars(delta_delay_threshold)\n"
               append args " -deltaDelayThreshold $arg"
            } else {
               append ucomments "# - vars(delta_delay_threshold)\n"
            }
            if {![catch {set arg $vars(celtic_settings)}]} {
               append comments "# - vars(celtic_settings)\n"
               append args " -insCeltICPreTcl \"$arg\""
            } else {
               append ucomments "# - vars(celtic_settings)\n"
            }
            if {![catch {set arg $vars(si_analysis_type)}]} {
               append comments "# - vars(si_analysis_type)\n"
               append args " -analysisType $arg"
            } else {
               append ucomments "# - vars(si_analysis_type)\n"
            }
            if {$vars(high_timing_effort) && [regexp "9.1" $vars(version)]} {
#               append comments "# - vars(high_timing_effort)\n"
               append args " -acceptableWNS 0"
            } elseif {[info exists vars(acceptable_wns)]} {
               append args " -acceptableWNS $vars(acceptable_wns)"
            }
            if {$args != ""} {
               set command "setSIMode $args\n"
               append commands [FF::wrap_command postroute_si,set_si_mode $command]
            }

            set args ""
            if {$vars(enable_ocv) == "pre_postroute_si"} {
               if {$vars(flow) != "default"} {
                  append comments "# - vars(enable_ocv)\n"
                  append args "-analysisType onChipVariation "
               }
               if {$vars(enable_aocv)} {
                  append comments "# - vars(enable_aocv)\n"
                  append args "-aocv true "
               } else {
                  append ucomments "# - vars(enable_aocv)\n"
               }
            } else {
               append ucomments "# - vars(enable_ocv) \"pre_postroute_si\"\n"
               append ucomments "# - vars(enable_aocv) \"true\"\n"
            }
            if {$vars(enable_cppr) != "false"} {
               append comments "# - vars(enable_cppr)\n"
               append args "-cppr $vars(enable_cppr) "
            } else {
               append ucomments "# - vars(enable_cppr)\n"
            }
            if {$args != ""} {
               set command "setAnalysisMode $args\n"
               append commands [FF::wrap_command postroute_si,set_analysis_mode $command]
            }

            if {$vars(enable_ss) == "pre_postroute_si"} {
               append comments "# - vars(enable_ss)\n"
               set command "setDelayCalMode -engine signalStorm\n"
               append commands [FF::wrap_command postroute_si,set_delay_cal_mode $command]
            } else {
               append ucomments "# - vars(enable_ss) \"pre_postroute_si\"\n"
            }
         }

         "postroute_si_hold" {
            ###################################################################
            # Set hold fixing options ...
            ###################################################################

            set process [regsub "nm" $vars(process) ""]
            append comments "# - vars(process)\n"
            if {$vars(high_timing_effort)} {
               append comments "# - vars(high_timing_effort)\n"
               if {![regexp "9.1" $vars(version)]} {
                  set command "setDesignMode -process $process -flowEffort high\n"
               } else {
                  set command "setDesignMode -process $process\n"
               }
            } else {
               set command "setDesignMode -process $process\n"
            }
            append commands [FF::wrap_command postroute_si_hold,set_design_mode $command]

            set command ""
            if {[info exists vars(delay_cells)]} {
               append comments "# - vars(delay_cells)\n"
               foreach delay_cell $vars(delay_cells) {
                  append command "setDontUse $delay_cell false\n"
               }
            } else {
               append ucomments "# - vars(delay_cells)\n"
            }
            if {$command != ""} {
               append commands [FF::wrap_command postroute_si_hold,set_dont_use $command]
            }

            set args ""
            if {![catch {set arg $vars(fix_hold_allow_tns_degradation)}]} {
               append comments "# - vars(fix_hold_allow_tns_degradation)\n"
               append args " -fixHoldAllowSetupTnsDegrade $arg"
            } else {
               append ucomments "# - vars(fix_hold_allow_tns_degradation)\n"
            }
            if {$vars(fix_hold_ignore_ios)} {
               #append commands "setAnalysisMode -honorClockDomains true\n" 
               append comments "# - vars(fix_hold_ignore_ios)\n"
               append args " -ignorePathGroupsForHold {in2reg reg2out in2out}"
            } else {
               append ucomments "# - vars(fix_hold_ignore_ios)\n"
            }
            if {$args != ""} {
               set command "setOptMode $args\n"
               append commands [FF::wrap_command postroute_si_hold,set_opt_mode $command]
            }

            ###################################################################
            # Set noise, extraction, and SI options ...
            # Enable signalStorm if requested
            # Enable onChipVariation (if MMMC)
            ###################################################################

            set command "setExtractRCMode -coupled true"
            if {![catch {set arg $vars(total_c_thresh)}]} {
               append comments "# - vars(total_c_thresh)\n"
               append command " -total_c_th $arg"
            } else {
               append ucomments "# - vars(total_c_thresh)\n"
            }
            if {![catch {set arg $vars(relative_c_thresh)}]} {
               append comments "# - vars(relative_c_thresh)\n"
               append command " -relative_c_th $arg"
            } else {
               append ucomments "# - vars(relative_c_thresh)\n"
            }
            if {![catch {set arg $vars(coupling_c_thresh)}]} {
               append comments "# - vars(coupling_c_thresh)\n"
               append command " -coupling_c_th $arg"
            } else {
               append ucomments "# - vars(coupling_c_thresh)\n"
            }
            if {![catch {set arg $vars(qrc_layer_map)}]} {
               append comments "# - vars(qrc_layer_map)\n"
               append command " -lefTechFileMap $arg"
            } else {
               append ucomments "# - vars(qrc_layer_map)\n"
            }
            append command "\n"
            append commands [FF::wrap_command postroute_si_hold,set_extract_rc_mode $command]

            set args ""
            if {![catch {set arg $vars(delta_delay_threshold)}]} {
               append comments "# - vars(delta_delay_threshold)\n"
               append args " -deltaDelayThreshold $arg"
            } else {
               append ucomments "# - vars(delta_delay_threshold)\n"
            }
            if {![catch {set arg $vars(celtic_settings)}]} {
               append comments "# - vars(celtic_settings)\n"
               append args " -insCeltICPreTcl \"$arg\""
            } else {
               append ucomments "# - vars(celtic_settings)\n"
            }
            if {![catch {set arg $vars(si_analysis_type)}]} {
               append comments "# - vars(si_analysis_type)\n"
               append args " -analysisType $arg"
            } else {
               append ucomments "# - vars(si_analysis_type)\n"
            }
            if {$vars(high_timing_effort) && [regexp "9.1" $vars(version)]} {
#               append comments "# - vars(high_timing_effort)\n"
               append args " -acceptableWNS 0"
            } elseif {[info exists vars(acceptable_wns]} {
               append args " -acceptableWNS $vars(acceptable_wns)"
            }
            if {$args != ""} {
               set command "setSIMode $args\n"
               append commands [FF::wrap_command postroute_si_hold,set_si_mode $command]
            }
            if {$vars(enable_ss) == "pre_postroute_si"} {
               append comments "# - vars(enable_ss)\n"
               set command "setDelayCalMode -engine signalStorm\n"
               append commands [FF::wrap_command postroute_si_hold,set_delay_cal_mode $command]
            } else {
               append ucomments "# - vars(enable_ss) \"pre_postroute_si\"\n"
            }
            if {$vars(enable_ocv) == "pre_postroute_si"}  {
               append comments "# - vars(enable_ocv)\n"
               if {$vars(flow) != "default"} {
                  set command "setAnalysisMode -analysisType onChipVariation\n"
                  if {$vars(enable_aocv)} {
                     append comments "# - vars(enable_aocv)\n"
                     append command "-aocv true "
                  } else {
                     append ucomments "# - vars(enable_aocv)\n"
                  }
                  append commands [FF::wrap_command postroute_si_hold,set_analysis_mode $command]
               }
            } else {
               append ucomments "# - vars(enable_ocv) \"pre_postroute_si\"\n"
               append ucomments "# - vars(enable_ocv) \"true\"\n"
            }
         }

         "signoff" {
            ###################################################################
            # For the default flow, switch to MMMC for final STA to support
            # multiple RC corners.  Also, enable CCE (signoff) extraction if
            # the QRC techfile exists
            ###################################################################
            if {$vars(flow) == "default"} {
               if {$vars(verbose)} {
                  append commands "#\n"
                  append commands "# <FF> UPDATING TIMING ENVIRONMENT"
                  append commands "#\n"
               }
               set command [FF_EDI::initialize_timing mmmc]
               append commands [FF::wrap_command signoff,initialize_timing $command]
            }
            set process [regsub "nm" $vars(process) ""]
            append comments "# - vars(process)\n"
            set command "setDesignMode -process $process\n"
            append commands [FF::wrap_command signoff,set_design_mode $command]

            ###################################################################
            # Set noise, extraction, and SI options ...
            # Enable signalStorm if requested
            # Enable onChipVariation (if MMMC)
            ###################################################################

            set command "setExtractRCMode -coupled true"
            if {![catch {set arg $vars(signoff_extraction_effort)}]} {
               append comments "# - vars(signoff_extraction_effort)\n"
               append command " -effortLevel $arg"
            } else {
               append command " -effortLevel high"
            }
            if {![catch {set arg $vars(total_c_thresh)}]} {
               append comments "# - vars(total_c_thresh)\n"
               append command " -total_c_th $arg"
            } else {
               append ucomments "# - vars(total_c_thresh)\n"
            }
            if {![catch {set arg $vars(relative_c_thresh)}]} {
               append comments "# - vars(relative_c_thresh)\n"
               append command " -relative_c_th $arg"
            } else {
               append ucomments "# - vars(relative_c_thresh)\n"
            }
            if {![catch {set arg $vars(coupling_c_thresh)}]} {
               append comments "# - vars(coupling_c_thresh)\n"
               append command " -coupling_c_th $arg"
            } else {
               append ucomments "# - vars(coupling_c_thresh)\n"
            }
            if {![catch {set arg $vars(qrc_layer_map)}]} {
               append comments "# - vars(qrc_layer_map)\n"
               append command " -lefTechFileMap $arg"
            } else {
               append ucomments "# - vars(qrc_layer_map)\n"
            }
            append command "\n"
            append commands [FF::wrap_command signoff,set_extract_rc_mode $command]

            set args ""
            if {![catch {set arg $vars(delta_delay_threshold)}]} {
               append comments "# - vars(delta_delay_threshold)\n"
               append args " -deltaDelayThreshold $arg"
            } else {
               append ucomments "# - vars(delta_delay_threshold)\n"
            }
            if {![catch {set arg $vars(celtic_settings)}]} {
               append comments "# - vars(celtic_settings)\n"
               append args " -insCeltICPreTcl \"$arg\""
            } else {
               append ucomments "# - vars(celtic_settings)\n"
            }
            if {![catch {set arg $vars(si_analysis_type)}]} {
               append comments "# - vars(si_analysis_type)\n"
               append args " -analysisType $arg"
            } else {
               append ucomments "# - vars(si_analysis_type)\n"
            }
            set args ""
            if {$vars(enable_ocv) != "false"} {
               append comments "# - vars(enable_ocv)\n"
               append args "-analysisType onChipVariation "
               if {$vars(enable_aocv)} {
                  append comments "# - vars(enable_aocv)\n"
                  append args "-aocv true "
               } else {
                  append ucomments "# - vars(enable_aocv)\n"
               }
            } else {
               append ucomments "# - vars(enable_ocv) \"pre_signoff\"\n"
               append ucomments "# - vars(enable_aocv) \"true\"\n"
            }
            if {$vars(enable_cppr) != "false"} {
               append comments "# - vars(enable_cppr)\n"
               append args "-cppr $vars(enable_cppr) "
            } else {
               append ucomments "# - vars(enable_cppr)\n"
            }
            if {$args != ""} {
               set command "setAnalysisMode $args\n"
               append commands [FF::wrap_command signoff,set_analysis_mode $command]
            }
            if {[regexp "9.1" $vars(version)]} {
               if {$vars(enable_ss) == "pre_signoff"} {
                  set command "setDelayCalMode -engine signalStorm -signoff true\n"
                  append commands [FF::wrap_command signoff,set_delay_cal_mode $command]
                  append comments "# - vars(enable_ss)\n"
               } else {
                  append ucomments "# - vars(enable_ss) \"pre_signoff\"\n"
               }
            } else {
#               if {$vars(enable_si_aware)} {
#                  append comments "# - vars(enable_si_aware)\n"
#                  append command "-siAware true -engine aae\n "
                  if {$vars(enable_ss) == "pre_signoff"} {
                     set command "setDelayCalMode -engine signalStorm -signoff true\n"
                     append commands [FF::wrap_command signoff,set_delay_cal_mode $command]
#                     append commands "<FF> Variable vars(enable_ss) ignore when vars(enable_si_aware) is set"
#                     set warnings($vars(warning_count)) "Variable vars(enable_ss) ignore when vars(enable_si_aware) is set"
#                     incr vars(warning_count)
                  } else {
                     append ucomments "# - vars(enable_ss) \"pre_signoff\"\n"
                  }
#               } else {
#                  append ucomments "# - vars(enable_si_aware)\n"
#                  if {$vars(enable_ss) == "pre_signoff"} {
#                     append comments "# - vars(enable_ss)\n"
#                     append command "-engine signalStorm -signoff true "
#                  } else {
#                     append ucomments "# - vars(enable_ss) \"pre_signoff\"\n"
#                  }
#               }
            }

            if {$vars(skip_signoff_checks)} {
               set command "  setExtractRCMode -engine postRoute -effortLevel $vars(signoff_extraction_effort) -coupled true\n"
               append commands [FF::wrap_command signoff,set_extract_rc_mode $command]
            } else {
               append commands "set vars(active_rc_corners) \[list\]\n"
               append commands "foreach view \[concat \[all_setup_analysis_views\] \[all_hold_analysis_views\]\] {\n"
               append commands "   set corner \[get_delay_corner \[get_analysis_view \$view -delay_corner\] -rc_corner\]\n"
               append commands "   if {\[lsearch \$vars(active_rc_corners) \$corner\] == -1 } {\n"
               append commands "      lappend vars(active_rc_corners) \$corner\n"
               append commands "   }\n"
               append commands "}\n"
               append commands "Puts \"<FF> ACTIVE RC CORNER LIST: \$vars(active_rc_corners)\"\n"
   
               append commands "set empty_corners \[list\]\n"
               append commands "foreach corner \$vars(active_rc_corners) {\n"
               append commands "   if {!\[file exists \[get_rc_corner \$corner -qx_tech_file\]\]} {\n"
               append commands "      lappend empty_corners \$corner\n"
               append commands "   }\n"
               append commands "}\n"
               append commands "if {\[llength \$empty_corners\] == 0} {\n"
               set command "  setExtractRCMode -engine postRoute -effortLevel $vars(signoff_extraction_effort) -coupled true\n"
               append commands [FF::wrap_command signoff,set_extract_rc_mode $command]
               append commands "} else {\n"
               append commands "      Puts \"<FF> CAN'T RUN SIGNOFF EXTRACTION BECAUSE qx_tech_file IS NOT DEFINED FOR these corners: \$empty_corners\"\n"
               set command "      setExtractRCMode -engine postRoute -effortLevel low -coupled true\n"
               append commands [FF::wrap_command signoff,set_extract_rc_mode $command]
               append commands "}\n"
            }
         }
      }
      if {[info exists ucomments]} {
         if {$ucomments == ""} {
            if {[info exists vars(ucomments)]} {
               unset vars(ucomments)
            }
         } else {
            set vars(ucomments) $ucomments
         }
      }
      if {[info exists comments]} {
         if {$comments == ""} {
            if {[info exists vars(comments)]} {
               unset vars(comments)
            }
         } else {
            set vars(comments) $comments 
         }
      }
      return $commands
   }

   proc save_results {{step ""} {format 0}} {

      global vars
      global errors
      global env

      if {[info exists vars(hier)]} {
         set hier true
      } else {
         set hier false
      }
      if {$step != ""} {
         set vars(step) $step
      }

      if {$vars(debug)} {
         puts "<DEBUG> Saving results for $vars(step) ..."
      }

      set commands ""
      if {$vars(batch)} {

         if {$vars(verbose)} {
            append commands "#\n"
            append commands "# SAVING RESULTS\n"
            append commands "#\n"
         }
   
#         if {[regexp _hold $vars(step)] && (![lsearch $vars(fix_hold) $vars(step)] <0)} {
#   
#            if {!$format} {
#               set commands ""
#            } else {
#               if {$vars(report_run_time)} {
#                  append commands "FF_EDI::report_time $vars(step)\n"
#               }
#            }
#            if {$vars(codegen)} {
#               return $commands
#            } else {
#                uplevel #0 eval $commands
#            }
#         } 


         set args ""
         if {[info exists vars(save_rc)] && $vars(save_rc)} {
            if {[regexp "route" $vars(step)]} {
               append args " -rc"
             }
         }
         if {[info exists vars(save_constraints)] && $vars(save_constraints)} {
            append args " -tcon"
         }
  
         # BCL: Added subst around vars(dbs_dir) to resolve vars(rundir)
         set dir [subst $vars(dbs_dir)]
         set design $vars(design)
         if {[string compare -nocase $vars(dbs_format) "oa"]==0} {
            if {[lindex [split $vars(version) "."]  0] > 10} {
               if {$hier} {
                  set command "saveDesign $args -cellview {$vars(oa_partition_lib) $vars(design) $vars(step)}\n"
               } else {
                  set command "saveDesign $args -cellview {$vars(oa_design_lib) $vars(design) $vars(step)}\n"
               }
            } else {
               set command "saveOaDesign $vars(oa_design_lib) $design $vars(step)\n"
            }
         } else {
            if {[info exists vars(relative_path)] && $vars(relative_path)} {
               append args " -relativePath"
            }
            if {[info exists vars(absolute_lib_path)] && $vars(absolute_lib_path)} {
               append args " -absoluteLibPath"
            }
            set command "saveDesign $args $dir/$vars(step).enc -compress\n"
         }

         append commands [FF::wrap_command $step,save_design $command]

         if {![info exists env(VPATH)]} {
            set env(VPATH) "make"
         }

         append commands "if {\[info exists env(VPATH)\]} {\n"
         append commands "exec /bin/touch \$env(VPATH)/$vars(step)\n"
         append commands "}\n"
   
         set header "#---------------------------------------------------------------------\n"
         append header "# <FF> GENERATING REPORTS\n"
         append header "#---------------------------------------------------------------------\n"
   
         if {$vars(report_power)} {
            if {[info exists vars(power_analysis_view)] && ($vars(power_analysis_view) != "")} {
               set command "report_power -view $vars(power_analysis_view) -outfile $vars(rpt_dir)/$vars(step).power.rpt\n"
            } else {
               set command "report_power -outfile $vars(rpt_dir)/$vars(step).power.rpt\n"
            }
            append commands [FF::wrap_command $vars(step),report_power $command]
         }
   
         if {[FF::is_lp_flow] && [info exists vars(power_domains)] && [llength $vars(power_domains)] > 0} {
            append commands $header
            set header ""
   
            ######################################################################
            # Verify power domain
            ######################################################################
   
            set command "verifyPowerDomain -bind -gconn"
            append command " -isoNetPD $vars(rpt_dir)/$vars(step).isonets.rpt"
            append command " -xNetPD $vars(rpt_dir)/$vars(step).xnets.rpt\n"

            append commands [FF::wrap_command $step,verify_power_domain $command]
   
            ######################################################################
            # Run CLP
            ######################################################################
   
            if {$vars(run_clp) && ([auto_execok lec] != "")} {
               set command "runCLP "
               if {[info exists vars(clp_options)]} {
                  append command $vars(clp_options)
               }
               append command "\n"
               append commands [FF::wrap_command $step,run_clp $command]
            } else {
               if {![info exists vars(clp_warning)]} {
                  puts "<FF> WARNING: UNABLE TO RUN CLP ... PLEASE MAKE SURE IT IS IN YOUR PATH"
                  set vars(clp_warning) true
               }
            }
         }
   
#         append commands "#\n"
#         append commands "# HOUSEKEEPING\n"
#         append commands "#\n"
   
         if {[info exists vars(mail,to)]} {
            switch $vars(step) {
               init     { set summary_file preplace.summary }
               assemble { set summary_file signoff.summary }
               default  { set summary_file $vars(step).summary }
            } 
            if {![info exists vars(mail,steps)] || \
                ([info exists vars(mail,steps)] && ([lsearch $vars(mail,steps) $vars(step)] != -1))} {
               append commands "Puts \"<FF> MAILING RESULTS TO $vars(mail,to)\"\n"
               append commands "if {\[file exists $vars(rpt_dir)/$summary_file\]} {\n"
               append commands "   exec /bin/mail -s \"FF: $vars(design), $vars(step) completed (\[pwd\])\" < $vars(rpt_dir)/$summary_file $vars(mail,to)\n"
               append commands "} else {\n"
               append commands "   exec /bin/mail -s \"FF: $vars(design), $vars(step) completed (\[pwd\])\" < /dev/null $vars(mail,to)\n"
               append commands "}\n"
            }
         }
   
#         append commands "exec /bin/touch \$env(VPATH)/$vars(step)\n"
   
         if {$format} {
            if {$vars(report_run_time)} {
               append commands "ff_procs::report_time\n"
            }
            if {$vars(capture_metrics)} {
               append commands [eval FF::capture_metrics]
            }
         }
   
         if {$vars(enable_qor_check)} {
#            if {[info exists vars($step,qor_tcl]} {
#               set qor_file $vars($step,qor_tcl)
#               if {[file exists $qor_file]} {
#                  set qor [catch {exec $qor_file} msg]
#                  set make_file [open $this_semaphore w]
#                  puts $make_file "$qor"
#                  close $make_file
#               }
#            }
            if {[info exists vars($step,qor_tcl)]} {
               if {[file exists $vars($step,qor_tcl)]} {
                  append commands [FF::source_plug ${step},qor_tcl]
               } else {
                  append commands "<FF> WARNING: QOR file $vars($step,qor_tcl) does not exist"
                  set warnings($warning_count) "WARNING: QOR file $vars($step,qor_tcl) does not exist"
                  incr warning_count
               }
            } else {
               if {$vars(makefile)} {
                  append commands "\nif {\[info exists env(VPATH)\]} {\n"
                  append commands "   exec /bin/touch \$env(VPATH)/${step}_qor\n"
                  append commands "}\n"
               }
            }
         }
         append commands [FF::source_plug final_always_source_tcl]

      } else {
         append commands "Puts \"<FF> =================================================\"\n"
         append commands "Puts \"<FF> INFO: Running in interactive mode ...\"\n"
         append commands "Puts \"<FF>       Please run 'FF_EDI::save_results <current_step>' \"\n"
         append commands "Puts \"<FF>       to prepare a database for the next step\"\n"
         append commands "Puts \"<FF> =================================================\"\n"
         if {$vars(makefile)} { 
            append commands "if {\[info exists env(VPATH)\]} {\n"
            append commands "exec /bin/touch \$env(VPATH)/$vars(step)\n"
            append commands "}\n"
         }
      }

      if {$vars(codegen)} {
         return $commands
      } else {
         uplevel #0 eval $commands
      }

   }

   proc initialize_multicpu {} {

   global vars

      set commands ""
#         append commands "#\n"
#         append commands "#  SETTING UP MULTI PROCESS DISTRIBUTION AND THREADING\n"
#         append commands "#\n"

      global vars

      if {[info exists vars(distribute_timeout)]} {
         set command "setDistributeHost -timeOut $vars(distribute_timeout) "
      } else {
         set command "setDistributeHost "
      }

      if {[info exists vars(distribute)]} {
         switch $vars(distribute) {
            "rsh" {
#               append commands "#  RUNNING RSH on $vars(rsh,host_list)\n"
               append command "-rsh -add \[list $vars(rsh,host_list)\]\n"
               set vars(remote_hosts) [llength $vars(rsh,host_list)]
             }
            "local" {
               append command "-local\n"
            }
            "custom" {
#               append commands "#  RUNNING CUSTOM ($vars(custom,script))\n"
               append command "-custom -custom_script { $vars(custom,script) }\n"
            }
            "lsf" {
#               append commands "#  RUNNING LSF ($vars(lsf,queue), $vars(lsf,resource), $vars(lsf,args)\n"
               append command "-lsf -queue $vars(lsf,queue) -resource { $vars(lsf,resource) } -lsf_args { $vars(lsf,args) }\n"
            }
            default {
                puts  "<FF> DISTRIBUTION TYPE $vars(distribute) NOT SUPPORTED\n"
            }
         }

#         append commands $command
         append commands [FF::wrap_command $vars(step),set_distribute_host $command]

         set command "setMultiCpuUsage "
         append command "-localCpu $vars(local_cpus) "
         append command "-remoteHost $vars(remote_hosts) "
         append command "-cpuPerRemoteHost $vars(cpus_per_remote_host)\n"
         append commands [FF::wrap_command $vars(step),set_multi_cpu_usage $command]

      } else {

         append command "-local\n"
         append commands [FF::wrap_command $vars(step),set_distribute_host $command]

         set command "setMultiCpuUsage -localCpu $vars(local_cpus)\n"
         append commands [FF::wrap_command $vars(step),set_multi_cpu_usage $command]

      }

      return $commands

   }
   proc derate_timing  {{type minmax}} {

      global vars
      global errors

      if {$vars(enable_aocv)} {
         set commands ""
         foreach corner $vars(delay_corners) {
            append commands "reset_timing_derate -delay_corner $corner\n"
         }   
         return $commands
      }

      set commands "Puts \"<FF> DERATING DELAY CORNERS ...\"\n"
      if {$vars(verbose)} {
         append commands "#\n"
         append commands "#  DERATING DELAY CORNERS ($type) ...\n"
         append commands "#\n"
      }
      switch $type {
         "mmmc" {
            set found_corner 0
            foreach corner $vars(delay_corners) {
               set derate_file 0
               set command($corner) ""
               if {[info exists vars($corner,derate_tcl)]} {
                  set derate_file 1
                  incr found_corner 1
                  if {[file exists $vars($corner,derate_tcl)]} {
                     if {$command($corner) == ""} {
                        append command($corner) [FF::source_plug "$corner,derate_tcl"]
                     }
                  }
               }
               if {!$derate_file} {
                  foreach object "cell net" {
                     foreach mode "early late" {
                        foreach type "data clock" {
                           if {[info exists vars($corner,${type}_${object}_${mode})]} {
                              append command($corner) "   set_timing_derate -$type -${object}_delay -$mode -delay_corner $corner $vars($corner,${type}_${object}_${mode})\n"
                              set found_corner 1
                           }
                           if {[info exists vars($corner,${object}_${type}_${mode})]} {
                              append command($corner) "   set_timing_derate -$type -${object}_delay -$mode -delay_corner $corner $vars($corner,${object}_${type}_${mode})\n"
                              set found_corner 1
                           }
                        }
                        if {[info exists vars($corner,cell_check_${mode})]} {
                           append command($corner) "   set_timing_derate -cell_check -$mode -delay_corner $corner $vars($corner,cell_check_${mode})\n"
                           set found_corner 1
                        }
                        if {[info exists vars($corner,check_cell_${mode})]} {
                           append command($corner) "   set_timing_derate -cell_check -$mode -delay_corner $corner $vars($corner,check_cell_${mode})\n"
                           set found_corner 1
                        }
                     }
                  }
               }
            }
            #########################################################################
            # There can only be one ilm_non_sdc_file, so need to combine them with 
            # the timing derate commands if both exists
            #########################################################################
            if {$found_corner>0} {
               if $vars(ilm) {
                  set op [open .ilm_non_sdc_file.tcl w]
                  if {[info exists vars(ilm_non_sdc_file)] && [file exists $vars(ilm_non_sdc_file)]} { 
                     set fhr [open $vars(ilm_non_sdc_file) r]
                     puts $op "#"
                     puts $op "# Contents of $vars(ilm_non_sdc_file)"
                     puts $op "#"
                     while {[gets $fhr line]>=0} {
                        puts $op "   $line"
                     }
                     close $fhr
                     puts $op "# -------------------------------------------"
                     set vars(save_ilm_non_sdc_file) $vars(ilm_non_sdc_file)
                     unset vars(ilm_non_sdc_file)
                  } 
                  if {[info exists vars(derate_tcl)]} {
                        puts $op "source $vars(derate_tcl)"
                  } else {
                     foreach corner $vars(delay_corners) {
                        puts $op $command($corner)
                     }
                  }
                  close $op
                  if {[lindex [split $vars(version) "."]  0] <= 10} {
                     append commands "loadTimingCon -ilmNonSdcFile .ilm_non_sdc_file.tcl\n"
                  } else {
                     append commands "setIlmNonSdcConstraintFile .ilm_non_sdc_file.tcl\n"
                  }
               } else {
                  if {[info exists vars(derate_tcl)]} {
                        append commands [FF::source_plug derate_tcl]
                        append commands "\n"
                  } else {
                     append commands "set active_corners \[all_delay_corners\]\n"
                     foreach corner $vars(delay_corners) {
                        if {$command($corner) != ""} {
                           append commands "if {\[lsearch \$active_corners $corner\] != -1} {\n"
                           append commands $command($corner)
                           append commands "}\n"
                        }
                     }
                  }
               }
            } else {
               if {[info exists vars(derate_tcl)]} {
                     append commands [FF::source_plug derate_tcl]
                     append commands "\n"
               }
            }
         }
         "minmax" {

            set corners(min) $vars($vars(default_hold_view),delay_corner)
            set corners(max) $vars($vars(default_setup_view),delay_corner)

            ################################################################################
            # Derate timing if derating factors are defined
            ################################################################################
            foreach object "cell net" {
               foreach corner "min max" {
                  foreach type "data clock" {
                     foreach mode "early late" {
                        if {[info exists vars($corners($corner),${type}_${object}_${mode})]} {
                           append commands "set_timing_derate -$corner -$type -${object}_delay -$mode $vars($corners($corner),${type}_${object}_${mode})\n"
                        }
                        if {[info exists vars($corners($corner),${object}_${type}_${mode})]} {
                           append commands "set_timing_derate -$corner -$type -${object}_delay -$mode $vars($corners($corner),${object}_${type}_${mode})\n"
                        }
                     }
                  }
               }
            }
            foreach corner "min max" {
               foreach mode "early late" {
                  if {[info exists vars($corners($corner),cell_check_${mode})]} {
                     append commands "set_timing_derate -cell_check -$mode $vars($corners($corner),cell_check_${mode})\n"
                  }
                  if {[info exists vars($corners($corner),check_cell_${mode})]} {
                     append commands "set_timing_derate -cell_check -$mode $vars($corners($corner),check_cell_${mode})\n"
                  }
               }
            }
         }
         default {
            Puts "<FF> INVALID OPTION ... MUST BE EITHER minmax OR mmmc"
         }
      }
      if {[lindex [split $vars(version) "."]  0] > 10} {
         set op [open $vars(script_dir)/timingderate.sdc w]
         puts $op $commands
         close $op
         set commands "source \$vars(script_dir)/timingderate.sdc\n"
      } 
      return $commands
   }
   #####################################################################################
   # The code below updates timing depending on whether the current module is
   # - top partition in a hierarchical flow
   # - partition in a hierarchical flow
   # - chip or block in a flat flow
   # Timing is updated by incrementally adding the vars(incr_cts_sdc) to each
   # constraint mode that has one defined
   #####################################################################################
   proc update_timing {{type minmax} {switch_to_propagated true}} {

      global vars

      if {![info exists vars(constraint_modes)]} {
         return
      }

      set commands "Puts \"<FF> UPDATING TIMING ...\"\n"

      set ptn [file tail [pwd]]
      set parent [file tail [file dirname [pwd]]]
      set update true
      if {[info exists vars(partition_list)] && ($parent == "$vars(partition_dir)")} {
         if {[lsearch $vars(partition_list) $ptn] != -1} {
#            set ilm false
            set update false
         }
      }

#      append commands "#  ILM $vars(ilm), UPDATE $update\n"

      if {$switch_to_propagated} {
         append commands "set op \[open prop.sdc w\]\n"
         append commands "puts \$op \"set_propagated_clock \\\[all_clocks\\\]\"\n"
         if {$vars(ilm)} {
            if {$vars(flat) != "none"} {
               append commands [FF_EDI::get_clock_ports]
            } else {
               append commands "set clock_ports \[FF_EDI::get_clock_ports\]\n"
            }
            append commands "if {\[llength \$clock_ports\] > 0} {\n"
            append commands "   foreach port \$clock_ports {\n"
            append commands "      puts \$op \"set_propagated_clock \$port\"\n"
            append commands "   }\n"
            append commands "}\n"
         }
         append commands "close \$op\n"
      }

      switch $type {

         "minmax" {
            if {$vars(ilm) && $update} {
               if {[info exists vars(incr_cts_sdc)]} {
                  foreach file $vars(incr_cts_sdc) {
                     append commands "loadTimingCon -ilm -incr $file\n"
                  }
               } elseif {[info exists vars(post_cts_sdc)]} {
                  append command "unloadTimingCon\n"
                  append commands "loadTimingCon  [lindex $vars(post_cts_sdc) 0]\n"
                  foreach sdc [lrange $vars(post_cts_sdc) 1 end] {
                    append commands "loadTimingCon -ilm -incr $sdc\n"
                  }
               }
               if {$switch_to_propagated} {
                  append commands "loadTimingCon -ilm -incr prop.sdc\n"
               }
            } else {
               if {$update} {
                  if {[info exists vars(incr_cts_sdc)]} {
                     foreach file $vars(incr_cts_sdc) {
                        append commands "loadTimingCon -incr $file\n"
                     }
                  } elseif {[info exists vars(post_cts_sdc)]} {
                     append commands "unloadTimingCon\n"
                     append commands "loadTimingCon [lindex $vars(post_cts_sdc) 0]\n"
                     foreach sdc [lrange $vars(post_cts_sdc) 1 end] {
                       append commands "loadTimingCon -incr $sdc\n"
                     }
                  }
               }
               if {$switch_to_propagated} {
                  append commands "loadTimingCon -incr prop.sdc\n"
               }
            }
         }
         "mmmc" {
#            if {[info exists vars(update_io_latency)] && $vars(update_io_latency)} {
#               update_io_latency
#            }
            if {$switch_to_propagated} {
               set prop_sdc "prop.sdc"
            } else {
               set prop_sdc ""
            }
            foreach mode $vars(constraint_modes) {
               append commands "if {\[lsearch \[all_constraint_modes\] $mode\] != -1} {\n"
               if {$update} {
                  if {[info exists vars($mode,incr_cts_sdc)]} {
                     if {$vars(ilm)} {
                        append commands "set vars($mode,post_cts_sdc_list) \[concat \[get_constraint_mode $mode -ilm_sdc_files\] $vars($mode,incr_cts_sdc) $prop_sdc\]\n"
                     } else {
                        append commands "set vars($mode,post_cts_sdc_list) \[concat \[get_constraint_mode $mode -sdc_files\] $vars($mode,incr_cts_sdc) $prop_sdc\]\n"
                     }
                     if {[info exists vars($mode,post_cts_sdc)]} {
                        puts  "<FF> WARNING: BOTH vars($mode,incr_cts_sdc) AND vars($mode,post_cts_sdc) ARE DEFINED ..."
                        puts  "<FF>          USING vars($mode,incr_cts_sdc)"
                     }
                  } else {
                     if {[info exists vars($mode,post_cts_sdc)]} {
                        append commands "set vars($mode,post_cts_sdc_list) \[concat $vars($mode,post_cts_sdc) $prop_sdc\]\n"
                     } else {
                        if {$vars(ilm)} {
                           append commands "set vars($mode,post_cts_sdc_list) \[concat \[get_constraint_mode $mode -ilm_sdc_files\] $prop_sdc\]\n"
                        } else {
                           append commands "set vars($mode,post_cts_sdc_list) \[concat \[get_constraint_mode $mode -sdc_files\] $prop_sdc\]\n"
                        }
                     }
                  }
               } else {
                  if {$vars(ilm)} {
                     append commands "set vars($mode,post_cts_sdc_list) \[concat \[get_constraint_mode $mode -ilm_sdc_files\] $prop_sdc\]\n"
                  } else {
                     append commands "set vars($mode,post_cts_sdc_list) \[concat \[get_constraint_mode $mode -sdc_files\] $prop_sdc\]\n"
                  }
               }
               append commands "}\n"
            }

            if {!$vars(ilm)} {
               append commands "set restore \[get_global timing_defer_mmmc_object_updates\]\n"
               append commands "set_global timing_defer_mmmc_object_updates true\n"
            }
#            append commands "set active_constraint_modes \[all_constraint_modes -active\]\n"
            foreach mode $vars(constraint_modes) {
               append commands "if \{\[lsearch \[all_constraint_modes\] $mode\] != -1\} \{\n" 
               append commands "   update_constraint_mode"
               append commands "      -name $mode"
               if {$vars(ilm)} {
                  append commands "      -ilm_sdc_files \$vars($mode,post_cts_sdc_list)"
               } else {
                  append commands "      -sdc_files \$vars($mode,post_cts_sdc_list)"
               }
               append commands "\n"
               append commands "\}\n"
            }
            if {!$vars(ilm)} {
               append commands "set_analysis_view -update_timing\n"
               append commands "set_global timing_defer_mmmc_object_updates \$restore\n"
            }
            set this_index [lsearch $vars(steps) $vars(step)]
            set prior [lindex $vars(steps) [expr $this_index - 1]]
            # BCL: Added subst around vars(dbs_dir)
            if {[file isfile [subst $vars(dbs_dir)]/$prior.enc.dat/mmmc/pathgroup.sdc]} {
               # BCL: Added subst around vars(dbs_dir)
               set vars(path_group_sdc) [subst $vars(dbs_dir)]/$prior.enc.dat/mmmc/pathgroup.sdc
               append commands "ff_procs::load_path_groups $vars(path_group_sdc)\n"
            }
         }
         default {
            puts $vars(codgen_log) "<FF> INVALID OPTION ... MUST BE EITHER minmax OR mmmc"
         }
      }
      return $commands
   }

   proc initialize_timing {{type mmmc}} {
      global vars
      global env

      set commands "Puts \"<FF> INITIALIZING [string toupper $type] TIMING ...\"\n"

      if {$vars(verbose)} {
         append commands "#\n"
         append commands "#  INITIALIZING [string toupper $type] TIMING\n"
         append commands "#\n"
      }

      if {$vars(debug)} {
          puts "<DEBUG> Executing proc: initialize_timing ..."
      }

      switch $type {
         minmax {
#            if {([llength $vars(rc_corners)] > 1)} {
#               puts  "<FF> WARNING: THE \"default\" FLOW SHOULD ONLY HAVE A SINGLE RC CORNER"
#               puts  "<FF>          BUT [llength $vars(rc_corners)] CORNERS ARE DEFINED ($vars(rc_corners))"
#            }

            ###################################################################
            # Define RC corners and set the appropriate temperatures.  This
            # requires that the cap tables use -best/-worst syntax in the
            # configuration file.  Scaling factors should be derived using
            # Ostrich Values for the default timing environment is derived
            # from the default setup and hold analysis views
            ###################################################################

            set corners(min) $vars($vars(default_hold_view),delay_corner)
            set corners(max) $vars($vars(default_setup_view),delay_corner)
            set corner $vars($corners(max),rc_corner)

#           if {[info exists env(FF_KIT_PATH)]} {
            if {![catch {set max $vars($vars($corners(max),rc_corner),T)}] &&
                ![catch {set min $vars($vars($corners(min),rc_corner),T)}]} {
               append commands \
                  "defineRCCorner -late worst $max -early best $min\n"
            }
#           } else {
#              Puts "<FF> USING SINGLE RC CORNER $vars($corners(max),rc_corner)"
#              if {[info exists vars($vars($corners(max),rc_corner),T)]} {
#                 setExtractRCMode -scOpTemp $vars($vars($corners(max),rc_corner),T)
#              }
#           }

            ###################################################################
            # Set scaling factors ... for pre-route optimization, the detailed
            # cap factor is set to the detailed clock cap factor.  This will
            # be reset post-route
            ###################################################################

           set args ""
            if {![catch {set arg $vars($corner,pre_route_res_factor)}]} {
               append args " -preRoute_res $arg"
            }
            if {![catch {set arg $vars($corner,pre_route_cap_factor)}]} {
               append args " -preRoute_cap $arg"
            }
            if {![catch {set arg $vars($corner,pre_route_clk_res_factor)}]} {
               append args " -preRoute_clkres $arg"
            }
            if {![catch {set arg $vars($corner,pre_route_clk_cap_factor)}]} {
               append args " -preRoute_clkcap $arg"
            }
            if {![catch {set arg $vars($corner,post_route_res_factor)}]} {
               append args " -postRoute_res "
               if {[llength $arg] > 1} {
                  append args "\"[lindex $arg 2],[lindex $arg 1],[lindex $arg 0]\""
               } else {
                  append args $arg
               }
            }
            if {![catch {set arg $vars($corner,post_route_cap_factor)}]} {
               append args " -postRoute_cap "
               if {[llength $arg] > 1} {
                  append args "\"[lindex $arg 2],[lindex $arg 1],[lindex $arg 0]\""
               } else {
                  append args $arg
               }
            }
            if {![catch {set arg $vars($corner,post_route_clk_res_factor)}]} {
               append args " -postRoute_clkres "
               if {[llength $arg] > 1} {
                  append args "\"[lindex $arg 2],[lindex $arg 1],[lindex $arg 0]\""
               } else {
                  append args $arg
               }
            }
            if {![catch {set arg $vars($corner,post_route_clk_cap_factor)}]} {
               append args " -postRoute_clkcap "
               if {[llength $arg] > 1} {
                  append args "\"[lindex $arg 2],[lindex $arg 1],[lindex $arg 0]\""
               } else {
                  append args $arg
               }
            }
            if {![catch {set arg $vars($corner,post_route_xcap_factor)}]} {
               append args " -postRoute_xcap "
               if {[llength $arg] > 1} {
                  append args "\"[lindex $arg 2],[lindex $arg 1],[lindex $arg 0]\""
               } else {
                  append args $arg
               }
            }
            if {$args != ""} {
               set command "setRCFactor $args\n"
               append commands [FF::wrap_command $vars(step),set_rc_factor $command]
            }
            set command [FF_EDI::derate_timing minmax]
            append commands [FF::wrap_command $vars(step),derate_timing $command]
         }
         mmmc {
            if {$vars(verbose)} {
               append commands "#\n"
               append commands "#  CREATING RC CORNERS ...\n"
               append commands "#\n"
            }
            foreach rc $vars(rc_corners) {
#               set command "\n"
               set command ""
               set non_command ""
               if {[info exists vars($rc,scale_tcl)]} {
                  append command "create_rc_corner -name $rc"
#                  append command " -cap_table $vars($rc,cap_table) "
                  foreach option "cap_table T qx_tech_file qx_conf_file qx_lib_file" {
                     if {![catch {set arg $vars($rc,$option)}]} {
                        append command " -$option $arg"
                     }
                  }
                  append command "\n"
                  append command [FF::source_plug "$rc,scale_tcl"]
               } else {
                  append command "create_rc_corner -name $rc"
                  foreach option "cap_table T qx_tech_file qx_conf_file qx_lib_file" {
                     if {![catch {set arg $vars($rc,$option)}]} {
                        append command " -$option $arg"
                     }
                  }
#                  append command "\n"
#                  append command " -cap_table $vars($rc,cap_table) "
                  if {![catch {set arg $vars($rc,pre_route_res_factor)}]} {
                     append command " -preRoute_res $arg"
                  } else {
                     append non_command "# -preRoute_res \$vars($rc,pre_route_res_factor)\n"
                  }
                  if {![catch {set arg $vars($rc,pre_route_cap_factor)}]} {
                     append command " -preRoute_cap $arg"
                  } else {
                     append non_command "# -preRoute_cap \$vars($rc,pre_route_cap_factor)\n"
                  }
                  if {![catch {set arg $vars($rc,pre_route_clk_res_factor)}]} {
                     append command " -preRoute_clkres $arg"
                  } else {
                     append non_command "# -preRoute_clkres \$vars($rc,pre_route_clk_res_factor)\n"
                  }
                  if {![catch {set arg $vars($rc,pre_route_clk_cap_factor)}]} {
                     append command " -preRoute_clkcap $arg"
                  } else {
                     append non_command "# -preRoute_clkcap \$vars($rc,pre_route_clk_cap_factor)\n"
                  }
                  if {![catch {set arg $vars($rc,post_route_res_factor)}]} {
                     append command " -postRoute_res "
                     if {[llength $arg] > 1} {
                        append command "\"$arg\""
                     } else {
                        append command $arg
                     }
                  } else {
                     append non_command "# -postRoute_res \$vars($rc,post_route_res_factor)\n"
                  }
                  if {![catch {set arg $vars($rc,post_route_cap_factor)}]} {
                     append command " -postRoute_cap "
                     if {[llength $arg] > 1} {
                        append command "\"$arg\""
                     } else {
                        append command $arg
                     }
                  } else {
                     append non_command "# -postRoute_cap \$vars($rc,post_route_cap_factor)\n"
                  }
                  if {![catch {set arg $vars($rc,post_route_clk_res_factor)}]} {
                     append command " -postRoute_clkres "
                     if {[llength $arg] > 1} {
                        append command "\"$arg\""
                     } else {
                        append command $arg
                     }
                  } else {
                     append non_command "# -postRoute_res \$vars($rc,post_route_clk_res_factor)\n"
                  }
                  if {![catch {set arg $vars($rc,post_route_clk_cap_factor)}]} {
                     append command " -postRoute_clkcap "
                     if {[llength $arg] > 1} {
                        append command "\"$arg\""
                     } else {
                        append command $arg
                     }
                  } else {
                     append non_command "# -postRoute_clkcap \$vars($rc,post_route_clk_cap_factor)\n"
                  }
                  if {![catch {set arg $vars($rc,post_route_xcap_factor)}]} {
                     append command " -postRoute_xcap "
                     if {[llength $arg] > 1} {
                        append command "\"$arg\""
                     } else {
                        append command $arg
                     }
                  } else {
                     append non_command "# -postRoute_xcap \$vars($rc,post_route_xcap_factor)\n"
                  }
               }
               append command "\n"
               append commands [FF::wrap_command $vars(step),create_rc_corner $command]
               if {$non_command != ""} {
                  append commands "#------------------------------------------------\n"
                  append commands "# Additional (unused) options ....\n"
                  append commands "#------------------------------------------------\n"
                  append commands $non_command
                  append commands "#------------------------------------------------\n"
               }
            }
            if {![info exists vars(cpf_file)] || ([info exists vars(cpf_file)] && !$vars(cpf_timing))} {
               ################################################################
               # CPF_TIMING == FALSE
               ################################################################
               set command ""
               if {$vars(verbose)} {
                  append command "#\n"
                  append command "# <FF> CREATING LIBRARY SETS ...\n"
                  append command "#\n"
               }
               append commands $command
               foreach set $vars(library_sets) {
                  set command ""
                  append command "create_library_set -name $set -timing \[list "
                  append command "$vars($set,timing) "
                  append command "\]\n"
                  append commands [FF::wrap_command $vars(step),create_library_set $command]
               }
               if {[info exists vars(opconds)]} {
                  if {$vars(verbose)} {
                     append command "#\n"
                     append command "# <FF> CREATING OPERATING CONDITIONS ...\n"
                     append command "#\n"
                  }
                  foreach opcond $vars(opconds) {
                     set command "create_op_cond -name $opcond"
                     # We already checked so we know these options exist
                     foreach option "library_file P V T" {
                        append command " -$option $vars($opcond,$option)"
                     }
                     append command "\n"
                     append commands [FF::wrap_command $vars(step),create_op_cond $command]
                  }
               }
               set command ""
               if {$vars(verbose)} {
                  append command "#\n"
                  append command "# <FF> CREATING DELAY CORNERS ...\n"
                  append command "#\n"
               }
               append commands $command
               foreach c $vars(delay_corners) {
               set command ""
                  append command "create_delay_corner -name $c"
                  if {![catch {set arg $vars($c,library_set)}]} {
                     append command " -library_set $arg"
                  } elseif {![catch {set early $vars($c,early_library_set)}] &&
                            ![catch {set late $vars($c,late_library_set)}]} {
                     append command " -early_library_set $early"
                     append command " -late_library_set $late"
                  }  else {
                     Puts "<FF> ERROR: Library sets for delay corner $c not defined properly"
                  }
                  append command " -rc_corner $vars($c,rc_corner)"
                  if {![catch {set opcond $vars($c,opcond)}] &&
                      ![catch {set library $vars($c,opcond_library)}]} {
                     append command " -opcond_library $library"
                     append command " -opcond $opcond"
                  } else {
                     if {![catch {set early $vars($c,early_opcond_library)}] &&
                         ![catch {set late $vars($c,late_opcond_library)}]} {
                        append command " -early_opcond_library $early"
                        append command " -late_opcond_library $late"
                     }
                     if {![catch {set early_opcond $vars($c,early_opcond)}] &&
                         ![catch {set late_opcond $vars($c,late_opcond)}]} {
                        append command " -early_opcond $early_opcond"
                        append command " -late_opcond $late_opcond"
                     }
                  }
                  append command "\n"
                  if {![catch {set domains $vars($c,power_domains)}]} {
                     set attribute_list "library_set opcond_library opcond irdrop_file \
                                         late_library_set early_library_set \
                                         late_opcond_library early_opcond_library \
                                         late_opcond early_opcond late_irdrop_file early_irdrop_file"
                     foreach domain $domains {
                        append command " update_delay_corner -name $c -power_domain \"$domain\""
                         foreach attr $attribute_list {
                            if {[info exists vars($c,$domain,$attr)]} {
                               append command " -$attr $vars($c,$domain,$attr)"
                            } 
                         } 
                         append command "\n"
                     }
#                        if {![catch {set opcond $vars($domain,opcond)}] &&
#                            ![catch {set library $vars($domain,opcond_library)}]} {
#                           append command " -opcond_library $library"
#                           append command " -opcond $opcond"
#                        }
                  }
                  append commands [FF::wrap_command $vars(step),create_delay_corner $command]
               }
#               if {[info exists vars(save_cpf)]} {
#                  set command "saveCPF \[pid \].cpf; loadCPF \[pid\].cpf; commitCPF\n"
#                  append commands [FF::wrap_command $vars(step),save_cpf $command]
#               }

               set command ""
               if {$vars(verbose)} {
                  append command "#\n"
                  append command "# <FF> CREATING CONSTRAINT MODES ...\n"
                  append command "#\n"
               }
               append commands $command
               set ccommand ""
               foreach constraint_mode $vars(constraint_modes) {
                  if {!$vars(ilm)} {
                     if {[info exists vars($constraint_mode,pre_cts_sdc)]} {
                        set command  "create_constraint_mode -name $constraint_mode "
                        append command "-sdc_files \[list $vars($constraint_mode,pre_cts_sdc)\] "
                        append command "\n"
                        append ccommand [FF::wrap_command $vars(step),create_constraint_mode $command]
                     } else {
                        puts "Constraint file not found for $constraint_mode ..." 
                     }
                  } else {
                     if {[info exists vars(partition_list)]} {
                        set command  "update_constraint_mode -name $constraint_mode "
                     } else {
                        set command  "create_constraint_mode -name $constraint_mode "
                     }
                     if {[info exists vars($constraint_mode,pre_cts_ilm_sdc)]} {
                        append command "-sdc_files \[list $vars($constraint_mode,pre_cts_sdc)\] "
                        append command "-ilm_sdc_files \[list $vars($constraint_mode,pre_cts_ilm_sdc)\] "
                     } else {
                        append command "-ilm_sdc_files \[list $vars($constraint_mode,pre_cts_sdc)\] "
                     }
                     append command "\n"
                     if {[info exists vars(partition_list)]} {
                        append ccommand [FF::wrap_command $vars(step),update_constraint_mode $command]
                        append ccommand [FF::wrap_command $vars(step),flattenIlm "flattenIlm\n"]
                     } else {
                        append ccommand [FF::wrap_command $vars(step),create_constraint_mode $command]
                     }
                  }
               }
               append commands $ccommand
               if {($vars(user_mode) == "hier")} {
                  if {($vars(step) == "assemble") || ($vars(step) == "rebudget") || ($vars(step) == "flexilm") || ($vars(step) == "partition")} {
                     # Create mmmc file for assemble and partition step
                     if {[info exists vars(cpf_file)] && $vars(cpf_timing)} {
                        set mmmc_file $vars(script_dir)/incr_view_definition.tcl
                     } else {
                        set mmmc_file $vars(script_dir)/view_definition.tcl
                     }
                     set op [open $mmmc_file w]
                     puts $op [FF::pretty_print $commands 1]
                     close $op
                     #return $commands
                  } else {
                  # Return only constraint mode updates for top level flow
                     return $ccommand
                  }
               }

               if {![info exists vars(power_analysis_view)]} {
                  set vars(power_analysis_view) ""
               }
               set vars(all_analysis_views) \
                  [lsort -unique [concat $vars(setup_analysis_views) \
                          $vars(hold_analysis_views) \
                          $vars(power_analysis_view)]]
               set command ""
               if {$vars(verbose)} {
                  append command "#\n"
                  append command "# <FF> CREATING ANALYSIS VIEWS ...\n"
                  append command "#\n"
               }
               foreach view $vars(all_analysis_views) {
                  append command "if {\[lsearch \[all_analysis_views\] $view\] == -1} {\n"
                  append command "   create_analysis_view"
                  append command "      -name $view"
                  append command "      -constraint_mode $vars($view,constraint_mode)"
                  append command "      -delay_corner $vars($view,delay_corner)\n"
                  append command "}\n"
               }
               append commands [FF::wrap_command $vars(step),create_analysis_view $command]
               if {![info exists vars(gen_postload)]} { 
                  if {[lindex [split $vars(version) "."]  0] <= 10} {
                     # Legacy support, so no IEEE 1801 support
                     if {[info exists vars(cpf_file)] && !$vars(cpf_timing)} {
      #                  append commands "Puts \"<FF> LOADING CPF FILE $vars(cpf_file)\"\n"
                        set command "loadCPF $vars(cpf_file)\n"
                        append commands [FF::wrap_command init,load_cpf $command]
                        set command "commitCPF"
                        if {$vars(cpf_keep_rows)} {
                           append command " -keepRows"
                        }
                        if {$vars(cpf_power_domain)} {
                           append command " -power_domain"
                        }
                        if {$vars(cpf_isolation)} {
                           append command " -isolation"
                        }
                        if {$vars(cpf_state_retention)} {
                           append command " -state_retention"
                        }
                        if {$vars(cpf_level_shifter)} {
                           append command " -level_shifter"
                        }
                        if {$vars(cpf_power_switch)} {
                           append command " -power_switch"
                        }
                        append command "\n"
                        append commands [FF::wrap_command init,commit_cpf $command]
                     }
                     set command ""
                     foreach c $vars(delay_corners) {
                        if {![catch {set domains $vars($c,power_domains)}]} {
                           foreach domain $domains {
                              append command " update_delay_corner -name $c -power_domain \"$domain\"\n"
      #                        if {![catch {set opcond $vars($domain,opcond)}] &&
      #                            ![catch {set library $vars($domain,opcond_library)}]} {
      #                           append command " -opcond_library $library"
      #                           append command " -opcond $opcond"
      #                        }
                           }
                        }
                     }
                     append commands [FF::wrap_command init,update_delay_corner $command]
                  }
               }
            } else {
               ################################################################
               # CPF_TIMING == TRUE
               # Since the delay corner names are derived from the CPF, they
               # are not known.  However, they can be retrieved from the
               # analysis_views
               ################################################################

#               if {$vars(verbose)} {
#                  append commands "#  UPDATING DELAY CORNERS  ...\n"
#               }
               if {![info exists vars(delay_corners)]} {
                  set vars(delay_corners) [FF::[get_by_suffix vars ",rc_corner"]]
               }
               set command ""
               foreach corner $vars(delay_corners) {
                  append command "if {\[lsearch -exact \[all_delay_corners\] $corner\] != -1} {\n"
                  append command "   update_delay_corner -name $corner -rc_corner $vars($corner,rc_corner)\n"
                  append command "}\n"
               }
               append commands [FF::wrap_command $vars(step),update_delay_corner $command]
               ###################################################################
               # Update constraints modes if an ILM flow
               ###################################################################
               set ccommand ""
               foreach constraint_mode $vars(constraint_modes) {
                  if {$vars(ilm)} {
                     if {[info exists vars(partition_list)]} {
                        set command  "update_constraint_mode -name $constraint_mode "
                     } else {
                        set command  "create_constraint_mode -name $constraint_mode "
                     }
                     if {[info exists vars($constraint_mode,pre_cts_ilm_sdc)]} {
                        append command "-sdc_files \[list $vars($constraint_mode,pre_cts_sdc)\] "
                        append command "-ilm_sdc_files \[list $vars($constraint_mode,pre_cts_ilm_sdc)\] "
                     } else {
                        exec /bin/touch empty.sdc
                        append command "-sdc_files empty.sdc "
                        append command "-ilm_sdc_files \[list $vars($constraint_mode,pre_cts_sdc)\] "
                     }
                     append command "\n"
                     if {[info exists vars(partition_list)]} {
                        append ccommand [FF::wrap_command $vars(step),update_constraint_mode $command]
                     } else {
                        append ccommand [FF::wrap_command $vars(step),create_constraint_mode $command]
                     }
                  }
               }

               ###################################################################
               # Return early for partition implementation flows ...
               ###################################################################
               if {(($vars(mode) == "hier") || ([info exists vars(hier)] && $vars(hier))) && ($vars(step) != "partition")} {
                  set commands $ccommand
                  return $commands
               } else {
                  append commands $ccommand
               }
            }

            ###################################################################
            # Update library_sets with SI libraries if defined
            ###################################################################

#            if {$vars(verbose)} {
#               append commands "#  UPDATING LIBRARY SETS  ...\n"
#            }
            set command ""
            foreach set $vars(library_sets) {
               if {([info exists vars($set,si)] && ($vars($set,si) != "")) || \
                   ([info exists vars($set,aocv)] && ($vars($set,aocv) != ""))} {
                  append command "update_library_set -name $set"
               }
               if {[info exists vars($set,aocv)] && ($vars($set,aocv) != "")} {
                  append command " -aocv \[list"
                  foreach file $vars($set,aocv) {
                     append command " $file"
                  }
                  append command "\]"
               }
               if {[info exists vars($set,si)] && ($vars($set,si) != "")} {
                  append command " -si \[list"
                  foreach file $vars($set,si) {
                     append command " $file"
                  }
                  append command "\]"
               }
               append command "\n"
            }
            append commands [FF::wrap_command $vars(step),update_library_set $command]

            if {$vars(flow) != "mmmc"} {
               append commands [FF_EDI::update_timing mmmc]
            }
#            set command [FF_EDI::derate_timing mmmc]
#            append commands [FF::wrap_command $vars(step),derate_timing $command]

            ###################################################################
            # Define setup / hold analysis views and enable the default views
            # for each
            ###################################################################

            append commands "set_analysis_view"
            append commands " -setup \[list $vars(active_setup_views)\]"
            append commands " -hold \[list $vars(active_hold_views)\]\n"
#            set command "set_default_view -setup $vars(default_setup_view) -hold $vars(default_hold_view)\n"
#            append commands [FF::wrap_command $vars(step),set_default_view $command]
#            set command [FF_EDI::derate_timing mmmc]
#            append commands [FF::wrap_command $vars(step),derate_timing $command]
            if {[info exists vars(power_analysis_view)] && ($vars(power_analysis_view) != "")} {
               set command "set_power_analysis_mode -analysis_view $vars(power_analysis_view)\n"
               append commands [FF::wrap_command $vars(step),set_power_analysis_mode $command]
            }
            file mkdir $vars(script_dir)
            if {[lindex [split $vars(version) "."]  0] <= 10} {
               if {$vars(flat) != "full"} {
                  set op [open $vars(script_dir)/mmmc.tcl w]
                  puts $op [FF::pretty_print $commands 1]
                  close $op
                  set commands "source \$vars(script_dir)/mmmc.tcl\n"
               }
            } else {
               if {[info exists vars(cpf_file)] && $vars(cpf_timing)} {
                  set mmmc_file $vars(script_dir)/incr_view_definition.tcl
               } else {
                  set mmmc_file $vars(script_dir)/view_definition.tcl
               }
                set op [open $mmmc_file w]
                puts $op [FF::pretty_print $commands 1]
                close $op
#               if {$vars(step) == "assemble"} {
#                  set commands "source $vars(script_dir)/view_definition.tcl\n"
#                  return $commands
#               } else {
               if {![info exists vars(gen_postload)]} { 
                  if {[info exists vars(cpf_file)]} {
                     if {!$vars(cpf_timing)} {
                        set commands ""
                        set command "loadCPF $vars(cpf_file)\n"
                        append commands [FF::wrap_command init,load_cpf $command]
                        set command "commitCPF"
                        if {$vars(cpf_keep_rows)} {
                           append command " -keepRows"
                        }
                        if {$vars(cpf_power_domain)} {
                           append command " -power_domain"
                        }
                        if {$vars(cpf_isolation)} {
                           append command " -isolation"
                        }
                        if {$vars(cpf_state_retention)} {
                           append command " -state_retention"
                        }
                        if {$vars(cpf_level_shifter)} {
                           append command " -level_shifter"
                        }
                        if {$vars(cpf_power_switch)} {
                           append command " -power_switch"
                        }
                        append command "\n"
                        append commands [FF::wrap_command init,commit_cpf $command]
                        return $commands
                     } else {
                        if {$vars(flat) != "full"} {
   #                        set op [open $vars(script_dir)/mmmc.tcl w]
   #                        puts $op [FF::pretty_print $commands 1]
   #                        close $op
                           set commands "source $mmmc_file\n"
                        }
                        return $commands
                     }
                  } elseif {[info exists vars(ieee1801_file)]} {
                     set commands "setBetaFeature msvSupportIEEE1801 1\n"
                        set command "read_power_intent $vars(ieee1801_file) -1801\n"
                        append commands [FF::wrap_command init,load_ieee1801 $command]
                        set command "commit_power_intent"
                        if {$vars(ieee1801_keep_rows)} {
                           append command " -keepRows"
                        }
                        if {$vars(ieee1801_power_domain)} {
                           append command " -power_domain"
                        }
                        if {$vars(ieee1801_isolation)} {
                           append command " -isolation"
                        }
                        if {$vars(ieee1801_state_retention)} {
                           append command " -state_retention"
                        }
                        if {$vars(ieee1801_level_shifter)} {
                           append command " -level_shifter"
                        }
                        if {$vars(ieee1801_power_switch)} {
                           append command " -power_switch"
                        }
                        append command "\n"
                        append commands [FF::wrap_command init,commit_ieee1801 $command]
                        return $commands
                  }
               }
               return
#               } 
            }
         }
         default {
            puts  "<FF> INVALID OPTION ... MUST BE EITHER minmax OR mmmc"
         }
      }
      return $commands
   }

   proc update_rc_corners {} {

      global vars

      foreach rc_corner [all_rc_corners] {
         if {$rc_corner != "default_rc_corner"} {
            set update false
            set command "update_rc_corner -name $rc_corner "
            if {[get_rc_corner $rc_corner -cap_table] != $vars($rc_corner,cap_table)} {
               set update true
               append command "-cap_table $vars($rc_corner,cap_table) "
            }
            if {[get_rc_corner $rc_corner -preRoute_res] != $vars($rc_corner,pre_route_res_factor)} {
               set update true
               append command "-preRoute_res $vars($rc_corner,pre_route_res_factor) "
            }
            if {[get_rc_corner $rc_corner -preRoute_cap] != $vars($rc_corner,pre_route_cap_factor)} {
               set update true
               append command "-preRoute_cap $vars($rc_corner,pre_route_cap_factor) "
            }
            if {[get_rc_corner $rc_corner -postRoute_res] != $vars($rc_corner,post_route_res_factor)} {
               set update true
               append command "-postRoute_res \"$vars($rc_corner,post_route_res_factor)\" "
            }
            if {[get_rc_corner $rc_corner -postRoute_cap] != $vars($rc_corner,post_route_cap_factor)} {
               set update true
               append command "-postRoute_cap \"$vars($rc_corner,post_route_cap_factor)\" "
            }
            if {[get_rc_corner $rc_corner -preRoute_clkres] != $vars($rc_corner,pre_route_clk_res_factor)} {
               set update true
               append command "-preRoute_clkres $vars($rc_corner,pre_route_clk_res_factor) "
            }
            if {[get_rc_corner $rc_corner -preRoute_clkcap] != $vars($rc_corner,pre_route_clk_cap_factor)} {
               set update true
               append command "-preRoute_clkcap $vars($rc_corner,pre_route_clk_cap_factor) "
            }
            if {[get_rc_corner $rc_corner -postRoute_clkres] != $vars($rc_corner,post_route_clk_res_factor)} {
               set update true
               append command "-postRoute_clkres \"$vars($rc_corner,post_route_clk_res_factor)\" "
            }
            if {[get_rc_corner $rc_corner -postRoute_clkcap] != $vars($rc_corner,post_route_clk_cap_factor)} {
               set update true
               append command "-postRoute_clkcap \"$vars($rc_corner,post_route_clk_cap_factor)\" "
            }
            if {[get_rc_corner $rc_corner -postRoute_xcap] != $vars($rc_corner,post_route_xcap_factor)} {
               set update true
               append command "-postRoute_xcap \"$vars($rc_corner,post_route_xcap_factor)\" "
            }
            foreach option "T qx_tech_file qx_conf_file qx_lib_file" {
                if {[info exists vars($rc_corner,$option)]} {
                   if {[get_rc_corner $rc_corner -$option] != $vars($rc_corner,$option)} {
                      set update true
                      append command "-$option $vars($rc_corner,$option) "
                   }
                }
            }
            if {$update} {
               uplevel #0 eval $command
            }
         }
      }
   }
   proc reset_rc_corners {} {

      global vars

      foreach corner $vars(rc_corners) {
         update_rc_corner -name $corner \
            -preRoute_res 1.0 \
            -preRoute_clkres 1.0 \
            -preRoute_cap 1.0 \
            -preRoute_clkcap 1.0 \
            -postRoute_res 1.0 \
            -postRoute_clkres 1.0 \
            -postRoute_cap 1.0 \
            -postRoute_clk_ap 1.0 \
            -postRoute_xcap 1.0
      }
   }
   proc add_views {} {

      global vars

      Puts "<FF> CREATING RC CORNERS ..."
      foreach rc_corner $vars(rc_corners) {
         if {[lsearch [all_rc_corners] $rc_corner] == -1} {
            set command "create_rc_corner -name $rc_corner "
            append command "-cap_table $vars($rc_corner,cap_table)\] "
            append command "-preRoute_res $vars($rc_corner,pre_route_res_factor) "
            append command "-preRoute_clkres $vars($rc_corner,pre_route_clk_res_factor) "
            append command "-preRoute_cap $vars($rc_corner,pre_route_cap_factor) "
            append command "-preRoute_clkcap $vars($rc_corner,pre_route_clk_cap_factor) "
            append command "-postRoute_res \"$vars($rc_corner,post_route_res_factor)\" "
            append command "-postRoute_clkres \"$vars($rc_corner,post_route_clk_res_factor)\" "
            append command "-postRoute_cap \"$vars($rc_corner,post_route_cap_factor)\" "
            append command "-postRoute_clkcap \"$vars($rc_corner,post_route_clk_cap_factor)\" "
            append command "-postRoute_xcap $vars($rc_corner,post_route_xcap_factor) "
            foreach option "T qx_tech_file qx_conf_file qx_lib_file" {
                if {[info exists vars($rc_corner,$option)]} {
                     append command "-$option $vars($rc_corner,$option) "
                }
            }
            uplevel #0 eval $command
         }
      }

      if {![FF::is_lp_flow] || \
          ([FF::is_lp_flow] && ([llength [all_analysis_views]] == 2))} {

         Puts "<FF> CREATING LIBRARY SETS ..."
         foreach library_set $vars(library_sets) {
            if {[lsearch [all_library_sets] $library_set] == -1} {
               create_library_set -name $library_set \
                                  -timing $vars($library_set,timing)
            }
         }

         Puts "<FF> CREATING DELAY CORNERS ...\n"
         foreach delay_corner $vars(delay_corners) {
            if {[lsearch [all_delay_corners] $delay_corner] == -1} {
               set command "create_delay_corner -name $delay_corner "
               append command "-library_set $vars($delay_corner,library_set) "
               append command "-rc_corner $vars($delay_corner,rc_corner) "
               if {[info exists vars($delay_corner,opcond)] && [info exists vars($delay_corner,opcond_library)]} {
                  append command "-opcond_library $vars($delay_corner,opcond_library) "
                  append command "-opcond $vars($delay_corner,opcond) "
               }
               uplevel #0 eval $command
               if {![catch {set domains $vars($c,power_domains)}]} {
                  set command " update_delay_corner -name $c -power_domains \"$domains\""
                  uplevel #0 eval $command
               }
            }
         }

         Puts "<FF> UPDATING CONSTRAINT MODES ..."
         foreach mode $vars(constraint_modes) {
            if {[lsearch [all_constraint_modes] $mode] == -1} {
               if {[info exists vars($mode,pre_cts_sdc,full)]} {
                  append commands "create_constraint_mode "
                  append commands " -name $mode "
                  append commands " -sdc_files $vars($mode,pre_cts_sdc,full)\n"
               } elseif {[info exists vars($mode,pre_cts_sdc)} {
                  append commands "create_constraint_mode "
                  append commands " -name $mode "
                  append commands " -sdc_files $vars($mode,pre_cts_sdc)\n"
               }
            }
         }

         set vars(all_analysis_views) [lsort -uniq [concat $vars(setup_analysis_views) $vars(hold_analysis_views)]]
         Puts "<FF> UPDATING ANALYSIS VIEWS ..."

         foreach analysis_view $vars(all_analysis_views) {
            if {[lsearch [all_analysis_views] $analysis_view] == -1} {
               create_analysis_view -name $analysis_view \
                                    -constraint_mode $vars($analysis_view,constraint_mode) \
                                    -delay_corner $vars($analysis_view,delay_corner)
            }
         }
      } else {

   ############################################################################
   # Since the delay corner names are derived from the CPF, they are not
   # known.  However, they can be retrieved from the analysis_views
   ############################################################################
         Puts "<FF> UPDATING DELAY CORNERS  ..."
         foreach corner $vars(delay_corners) {
            Puts "Updating delay corner $corner with RC Corner $vars($corner,rc_corner) ..."
            update_delay_corner -name $corner -rc_corner $vars($corner,rc_corner)
         }
      }

   ############################################################################
   # Update library_sets with SI libraries if defined
   ############################################################################
      Puts "<FF> UPDATING LIBRARY SETS  ..."
      foreach library_set $vars(library_sets) {
         if {[info exists vars($library_set,si)] && ($vars($library_set,si) != "")} {
            update_library_set -name $library_set \
                               -si $vars($library_set,si)
         }
      }
      foreach library_set $vars(library_sets) {
         if {[info exists vars($library_set,aocv)] && ($vars($library_set,aocv) != "")} {
            update_library_set -name $library_set \
                               -aocv $vars($library_set,aocv)
         }
      }


      set_interactive_constraint_modes [all_constraint_modes -active]

      Puts "<FF> DERATING DELAY CORNERS ..."
      FF_EDI::derate_timing mmmc

      if {$vars(flow) != "mmmc"} {
         FF_EDI::update_timing mmmc
      }

   ############################################################################
   # Define setup / hold analysis views and enable the default views for each
   ############################################################################
      set_analysis_view -setup $vars(active_setup_views) -hold $vars(active_hold_views)
      set_default_view -setup $vars(default_setup_view) -hold $vars(default_hold_view)
   }

   proc get_power_domains_code {} {

      global vars

      set commands "set domains \[list\]\n"
      append commands "dbForEachPowerDomain \[dbgHead\] domain {\n"
      append commands "   if {\[dbGroupHInstList \[dbPowerDomainName \$domain\]\] != \"0x0\"} {\n"
      append commands "      lappend domains \[dbPowerDomainName \$domain\]\n"
      append commands "   }\n"
      append commands "}\n"
      return $commands
   }


   proc get_clock_ports {} {

      global vars

      set commands ""

      if {!$vars(codegen) || ($vars(codegen) && ($vars(flat) != "none"))} {

         if {$vars(ilm)} {
            if {$vars(step) != "cts"} { 
               append commands "setIlmType -model si\n"
            }
         }
         append commands "set clock_ports \[list\]\n"
         append commands "set clocks \[get_clocks *\]\n"

         append commands "foreach_in_collection clock \$clocks {\n"
         append commands "   set sources  \[get_property \$clock sources\]\n"
         append commands "   foreach_in_collection source \$sources {\n"
         append commands "     set source_name \[get_property \$source hierarchical_name\]\n"
         append commands "     set source_type \[get_property \$source object_type\]\n"
         append commands "     if {\$source_type == \"port\"} {\n"
         append commands "       lappend clock_ports \$source_name\n"
         append commands "    }\n"
         append commands "  }\n"
         append commands "}\n"
      } else {
         append commands "FF::get_clock_ports\n"
      }
      return $commands
   }

   proc add_tie_cells {{mode true} {add true}} {
      #########################################################################
      # This procedure inserts tie hi/lo cells based on information in the
      # setup.tcl
      #########################################################################

      global vars
      global errors

      set commands ""
      if {$vars(verbose)} {
         append commands "#\n"
         append commands "# ADDING TIE CELLS\n"
         append commands "#\n"
      }

      if {[FF::is_lp_flow] && ([info exists vars(power_domains)] && ([llength $vars(power_domains)] > 0))} {

#         if {!$add} {
#            return ""
#         }

         set mode true

         #
         # If we were running in EDI/Encounter, we'd perform an interactive
         # query to get the power domains and iterate over them to issue
         # commands.  From outside of EDI, we don't know what domains are in
         # the design.  Thus, we need to create code to get the same
         # effect
         #
         set command [FF_EDI::get_power_domains_code]

         #
         # Get the set of tie cells to use, both domain-specific and generic.
         #

         set all_tie_cells [list]

         set has_default false
         if {![catch {set default_cells $vars(tie_cells)}]} {
            set has_default true
            lappend all_tie_cells $vars(tie_cells)
         }
         set has_specific false
         foreach domain [FF::get_by_suffix vars ",tie_cells"] {
            set cells $vars($domain,tie_cells)
            lappend all_tie_cells $vars($domain,tie_cells)
            if {![llength $cells]} {
               continue
            }
            set has_specific true
            append command "set tie_cells($domain) \[list $cells\]\n"
         }
         if {![info exists vars(tie_cell_mode)]} {
            append commands $command
         }

         #
         # If there are no tie cells at all, there's nothing to do
         #

         set all_tie_cells [lsort -unique [join $all_tie_cells]]

         if {!$has_default && !$has_specific} {
            return ""
         }

         #
         # If there are no domain-specific entries, life is real simple
         #

         if {!$has_specific} {
            set command "setTieHiLoMode -cell \"$default_cells\""
            if {[info exists vars(tie_cells,max_distance)]} {
               append command " -maxDistance $vars(tie_cells,max_distance)"
            }
            if {[info exists vars(tie_cells,max_fanout)]} {
               append command " -maxFanout $vars(tie_cells,max_fanout)"
            }
            append command "\n"
            if {$mode} {
               append commands [FF::wrap_command $vars(step),set_tie_hi_lo_mode $command]
            }
            if {$add} {
               foreach cell $default_cells {
                  append commands "setDontUse $cell false\n"
               }
               if {[llength $vars(power_domains)] > 0} {
                  append commands "foreach domain \$domains {\n"
                  append commands  "   addTieHiLo -powerDomain \$domain -prefix \$domain\n"
                  append commands "}\n"
               }
               foreach cell $default_cells {
                  append commands "setDontUse $cell true\n"
               }
            }
            return $commands
         }

         #
         # We want to generate the following code:
         #       set known_domains [array names tie_cells]
         #       foreach domain $domains {
         #          if {[lsearch $known_domains $domain] != -1} {
         #             set cells $tie_cells($domain)
         #          } else {
         #             set cells $default_tie_cells
         #          }
         #          foreach cell $cells {
         #             setDontUse $cell false
         #          }
         #          setTieHiLoMode -cell { $cells }
         #          addTieHiLo -powerDomain $domain -prefix $domain
         #          foreach cell $cells {
         #             setDontUse $cell true
         #          }
         #       }
         # Of course, if we don't have any default tie cells, the loop breaks
         # out:
         #       set known_domains [array names tie_cells]
         #       foreach domain $domains {
         #          if {[lsearch $known_domains $domain] != -1} {
         #             set cells $tie_cells($domain)
         #          } else {
         #             continue
         #          }
         #          ...
         #       }
         #

#         if {$has_default} {
#            append commands "set default_tie_cells \[list $default_cells\]\n"
#         }
#         append commands "set known_domains \[array names tie_cells\]\n"
#         set known_domains [array names tie_cells]

         append commands "foreach domain \$domains {\n"
         set command  "   if {\[info exists tie_cells(\$domain)\]} {\n"
         append command  "      set cells \$tie_cells(\$domain)\n"
         append command  "   } else {\n"
         if {$has_default} {
            append command "   set cells \"$default_cells\"\n"
         } else {
            append command "   continue\n"
         }
         append command "   }\n"
         append commands $command
         set command "   setTieHiLoMode -cell \"\$cells\""
         if {[info exists vars(tie_cells,max_distance)]} {
            append command " -maxDistance $vars(tie_cells,max_distance)"
         }
         if {[info exists vars(tie_cells,max_fanout)]} {
            append command " -maxFanout $vars(tie_cells,max_fanout)"
         }
         append command "\n"
         if {$mode} {
            append commands [FF::wrap_command $vars(step),set_tie_hi_lo_mode $command]
         }
            set command "foreach cell \$cells {\n"
         append command "   setDontUse \$cell false\n"
         append command "}\n"
         if {[llength $vars(power_domains)] > 0} {
            append command "addTieHiLo -powerDomain \$domain\n"
            append command "foreach cell \$cells {\n"
            append command "   setDontUse \$cell true\n"
            append command "}\n"
         }
         if {$add} {
            append commands $command
         }
         append commands "}\n"
      } elseif {![catch {set cells $vars(tie_cells)}]} {
         set command "setTieHiLoMode -cell \"$cells\""
         if {[info exists vars(tie_cells,max_distance)]} {
            append command " -maxDistance $vars(tie_cells,max_distance)"
         }
         if {[info exists vars(tie_cells,max_fanout)]} {
            append command " -maxFanout $vars(tie_cells,max_fanout)"
         }
         append command "\n"
         if {$mode} {
            append commands [FF::wrap_command $vars(step),set_tie_hi_lo_mode $command]
         }
            set command "foreach cell \{$cells\} {\n"
         append command "   setDontUse \$cell false\n"
         append command "}\n"
         append command "addTieHiLo\n"
         append command "foreach cell \{$cells\} {\n"
         append command "   setDontUse \$cell true\n"
         append command "}\n"
         if {$add} {
            append commands $command
         }
      } else {
         set commands ""
      }

      if {$mode} {
         set vars(tie_cell_mode) true
      }

      return $commands
   }

   proc process_filler_cells {add_or_delete} {
      #
      # This routine will add or delete filler cells based upon the value of
      # add_or_delete
      #

      global vars
      global errors

      if {($add_or_delete != "add") &&
          ($add_or_delete != "delete")} {
         puts "<FF> ERROR: Must specify \"add\" or \"delete\"."
         exit -111
      } else {
         if {$add_or_delete == "add"} {
            set comment "ADDING"
         } else {
            set comment "REMOVING"
         }
      }
      set ccommands ""
      if {$vars(verbose)} {
         append ccommands "#\n"
         append ccommands "# $comment FILLER CELLS\n"
         append ccommands "#\n"
      }

      set commands ""

      #
      # Now we can get to the business of processing the filler cells
      #

      if {![llength [FF::get_by_suffix vars "filler_cells"]]} {
         return ""
      }

      set prefix FILL
      set set_filler "setFillerMode -corePrefix $prefix -core \"%s\"\n"

      if {[FF::is_lp_flow] && ([info exists vars(power_domains)] && ([llength $vars(power_domains)] > 0))} {

         #
         # The logic behind this code is very similar to the logic behind
         # add_tie_cells (with respect to power domains).  Take a look at that
         # code for comments
         #

         append commands [FF_EDI::get_power_domains_code]

         #
         # Get the set of filler cells to use, both domain-specific and
         # generic.
         #

         set has_default false
         if {![catch {set default_cells $vars(filler_cells)}]} {
            set has_default true
         }
         set has_specific false
         foreach domain [FF::get_by_suffix vars ",filler_cells"] {
            set cells $vars($domain,filler_cells)
            if {![llength $cells]} {
               continue
            }
            set has_specific true
            append commands "set filler_cells($domain) \[list $cells\]\n"
         }

         #
         # If there are no filler cells at all, there's nothing to do
         #

         if {!$has_default && !$has_specific} {
            return ""
         }

         #
         # If there are no domain-specific entries, life is real simple
         #

         if {!$has_specific} {
            if {![regexp "route" $vars(step)]} { return } 
            if {$add_or_delete == "add"} {
               append commands [format $set_filler $default_cells]
#               append commands "foreach domain \$domains {\n"
#               append commands "   addFiller -powerDomain \$domain\n"
#               append commands "}\n"
               append commands "   addFiller \n"
            } else {
               append commands "   deleteFiller -cell \"$default_cells\"\n"
            }
            append ccommands $commands
            if {$vars(codegen)} {
               return $ccommands
            } else {
                eval $ccommands
            }
         }

         #
         # If there are domain-specific entries, we need to loop through
         # the domains and execute the appropriate calls
         #       foreach domain $domains {
         #          if {[lsearch $known_domains $domain] != -1} {
         #             set cells $filler_cells($domain)
         #          } else {
         #             set cells $default_filler_cells
         #          }
         #          setFillerMode -corePrefix $prefix -core "$cells"
         #          addFiller/deleteFiller ...
         #       }
         #

         if {$has_default} {
            append commands "set default_filler_cells \[list $default_cells\]\n"
         }
         if {$add_or_delete == "add"} {
            append commands "set known_domains \[array names filler_cells\]\n"
            append commands "foreach domain \$domains {\n"
            append commands  "   if {\[lsearch \$known_domains \$domain\] != -1} {\n"
            append commands  "      set cells \$filler_cells(\$domain)\n"
            append commands  "   } else {\n"
            if {$has_default} {
               append commands "   set cells \$default_filler_cells\n"
            } else {
               append commands "   continue\n"
            }
            append commands "   }\n"
            append commands [format $set_filler \$cells]
            append commands "   addFiller -powerDomain \$domain\n"
            append commands "}\n"
         } else {
            append commands "set known_domains \[array names filler_cells\]\n"
            append commands "foreach domain \$domains {\n"
            append commands "   if {\[lsearch \$known_domains \$domain\] != -1} {\n"
            append commands "      deleteFiller -cell \$filler_cells(\$domain)\n"
            append commands "   }\n"
            append commands "}\n"
            if {$has_default} {
               append commands "deleteFiller -cell \$default_filler_cells\n"
            }
         }
      } elseif {![catch {set cells $vars(filler_cells)}]} {
         if {[regexp "route" $vars(step)]} {
            append commands [format $set_filler $cells]
            append commands "${add_or_delete}Filler\n"
         } else {
            set ccommands ""
            set commands ""
         }
      } else {
         set ccommands ""
         set commands ""
      } 
      append ccommands $commands
      return $ccommands
   }

   proc add_filler_cells {} {

      global vars

      #########################################################################
      # Add filler cells
      #########################################################################

      set commands [process_filler_cells "add"]
      return $commands
   }

   proc delete_filler_cells {} {

      global vars

      #########################################################################
      # Remove filler cells
      #########################################################################

      set commands [process_filler_cells "delete"]
      return $commands
   }

   proc insert_welltaps_endcaps {{outline false}} {

      global vars

      #########################################################################
      # Insert welltaps and pre/post endcaps
      #########################################################################

      global vars
      global errors
      global warnings

      set commands ""

      if {[FF::is_lp_flow] && ([info exist vars(power_domains)] && ([llength $vars(power_domains)] > 0))} {

         if {$vars(flat) == "full"} {
            #
            # Just like tie and filler cells, we can have power domain-specific
            # cells and settings that we need to worry about.
            #
   
            append commands [FF_EDI::get_power_domains_code]
   
            #
            # Get the set of domains that we need to worry about
            #
   
            set pre [FF::get_by_suffix vars ",pre_endcap"]
            set post [FF::get_by_suffix vars ",post_endcap"]
            set endcaps [FF::lintersection $pre $post]
            set welltaps [FF::get_by_suffix vars ",welltaps"]
   
            #
            # For every domain in the union, we need to issue statements if that
            # domain is one of the power domains in the design
            #
            # NOTE: We really don't need to worry about indenting the commands
            #       to look nice since the output routine will format it correctly
            #
   
            set domains [FF::lunion $endcaps $welltaps]

            foreach domain $domains {
               append commands "if {\[lsearch \$domains $domain\] != -1} {\n"
   
               #
               # Handle the end caps
               #
   
               set std_args "-prefix $domain -powerDomain $domain"
               set add "   addEndCap $std_args"
               if {![catch {set pre $vars($domain,pre_endcap)}] &&
                   ![catch {set post $vars($domain,post_endcap)}]} {
                  append commands "$add -preCap $pre -postCap $post\n"
               } elseif {![catch {set pre $vars(pre_endcap)}] &&
                         ![catch {set post $vars(post_endcap)}]} {
                  append commands "$add -preCap $pre -postCap $post\n"
               }
   
               set taps ""
               if {[catch {set taps $vars($domain,welltaps)}]} {
                  catch {set taps $vars(welltaps)}
               }
               if {$taps == ""} {
                  append commands "\}\n"
                  continue
               }
   
               #
               # Handle well taps
               #
   
               append commands "   addWellTap $std_args -cell \[list $taps\]"
   
               if {![catch {set i $vars($domain,welltaps,cell_interval)}]} {
                  append commands " -cellInterval $i"
               } elseif {![catch {set i $vars(welltaps,cell_interval)}]} {
                  append commands " -cellInterval $i"
               }
   
               if {![catch {set offset $vars($domain,welltaps,row_offset)}] ||
                   ![catch {set offset $vars(welltaps,row_offset)}]} {
                  append commands " -inRowOffset $offset"
               }
   
               if {![catch {set checker $vars($domain,welltaps,checkerboard)}] ||
                   ![catch {set checker $vars(welltaps,checkerboard)}]} {
                  if {$checker} {
                     append commands " -checkerboard"
                  }
               }
               append commands "\n"
   
               #
               # Add a verify step, if requested
               #
   
               if {![catch {set rule $vars($domain,welltaps,verify_rule)}] ||
                   ![catch {set rule $vars(welltaps,verify_rule)}]} {
                  append commands "verifyWellTap -cells \[list $taps\]"
                  append commands " -powerDomain $domain"
                  append commands " -report $vars(rpt_dir)/$domain.welltap.rpt"
                  append commands " -rule $rule\n"
               }
   
               append commands "}\n"
            }

            #
            # We've taken care of all of the domains that we have explicit
            # settings for.  However, we may still have domains in the design
            # that we know nothing explicit about.  We need to handle these
            # with a different set of code.
            #
            # We are going to cheat.  Since the code we need is already written
            # (below), we are going to recursively call this routine to get
            # the skeleton that we need and wrap it up into a for-loop.  This
            # should get us something that looks like the following:
            #       set processed [list domain1 domain2 domain3]
            #       foreach domain $domains {
            #          if {[lsearch $processed_domains $domain] == -1} {
            #             addEndCap -powerDomain $domain -prefix $domain ...
            #             addWellTap -powerDomain $domain -prefix $domain ...
            #             verifyWellTap -powerDomain $domain ...
            #          }
            #       }
            #
            # NOTE: The output routine will take care of making this look pretty
            #       at the end.  We don't need to worry about indentation for
            #       the inserted commands
            #
   
#            set save $vars(cpf_file)
#            unset vars(cpf_file)
#            set default_insert [insert_welltaps_endcaps true]
#            if {$default_insert != ""} {
#               append commands "set processed_domains \[list $domains\]\n"
#               append commands "foreach domain \$domains {\n"
#               append commands "   if {\[lsearch \$processed_domains \$domain\] == -1} {\n"
#               append commands "      $default_insert"
#               append commands "   }\n"
#               append commands "}\n"
#            }
#            set vars(cpf_file) $save
         } else {
            append commands "FF_EDI::insert_welltaps_endcaps\n"
         }
      } else {
         #
         # There is no CPF file that we need to worry about.  However, if
         # $outline is true, it means that the code (above) that handles power
         # domains called this routine recursively, and we need to change
         # the commands a little bit to include variables for power domains
         #
         # Start with the simple case: endcaps
         #

         if {![catch {set pre $vars(pre_endcap)}] &&
             ![catch {set post $vars(post_endcap)}]} {

            append commands "addEndCap -preCap $pre -postCap $post"
            if {!$outline} {
               append commands " -prefix ENDCAP\n"
            } else {
               append commands " -prefix \$domain -powerDomain \$domain\n"
            }
         }

         #
         # Now process welltaps
         #

         if {![catch {set taps $vars(welltaps)}]} {
            append commands "addWellTap -cell \[list $taps\]"
            if {!$outline} {
               append commands " -prefix WELLTAP"
            } else {
               append commands " -prefix \$domain -powerDomain \$domain"
            }

            if {![catch {set max_gap $vars(welltaps,max_gap)}]} {
               append commands " -maxGap $max_gap"
            } elseif {![catch {set interval $vars(welltaps,cell_interval)}]} {
               append commands " -cellInterval $interval"
            }

            if {![catch {set offset $vars(welltaps,row_offset)}]} {
               append commands " -inRowOffset $offset"
            }

            if {![catch {set checker $vars(welltaps,checkerboard)}]} {
               if {$checker} {
                  append commands " -checkerboard"
               }
            }
            append commands "\n"

            #
            # If a verify request has been made, create the command to
            # do so.  Again, take into account the potential for a recursive
            # call to this routine.
            #

            if {![catch {set rule $vars(welltaps,verify_rule)}]} {
               append commands "verifyWellTap -cells \[list $taps\] "
               append commands " -report $vars(rpt_dir)/"
               if {!$outline} {
                  append commands "welltap.rpt"
               } else {
                  append commands "\$domain.welltap.rpt -powerDomain \$domain"
               }
               append commands " -rule $rule\n"
            } elseif {!$outline} {
#               puts  "<FF> Cannot run verifyWellTap because vars(welltaps,verify_rule) is not defined"
               set warnings($vars(warning_count)) "Cannot run verifyWellTap because vars(welltaps,verify_rule) is not defined"
               incr vars(warning_count)
            }
         }
      }

      #
      # If we created any commands to be executed, prefix the commands with a
      # header
      #

      if {($commands != "") && !$outline} {
         set body $commands

         set commands ""
         if {$vars(verbose)} {
            append commands "#\n"
            append commands "# INSERTING WELLTAPS AND/OR ENDCAPS\n"
            append commands "#\n"
         }
         append commands $body
      }

      return $commands
   }
   proc route_secondary_pg_nets {} {

      global vars
      global errors

      #
      # Don't try to route unless the proper flags are in place to do so
      #

      if {![info exists vars(route_secondary_pg_nets)] ||
          !$vars(route_secondary_pg_nets)} {
         return ""
      }

      set commands "# <FF> ROUTING SECONDARY POWER NETS ...\n"

      #
      # Enable global pin pairs (if defined)
      #

      if {[catch {set arg $vars(secondary_pg,cell_pin_pairs)}]} {
         puts "<FF> =========================================================="
         puts "<FF> ERROR: No cell/pin pairs defined.  Please define cell/pin"
         puts "<FF>        pairs in your setup.tcl using the variable"
         puts "<FF>        vars(secondary_pg,cell_pin_pairs)"
         puts "<FF> =========================================================="
         if {$vars(codegen)} {
            return $commands
         } else {
             uplevel #0 eval $commands
         }
      }
      append commands "setPGPinUseSignalRoute $arg\n"

      #
      # Build commands for individual nets (if defined)
      #

      if {[info exists vars(secondary_pg,nets)]} {
         foreach net $vars(secondary_pg,nets) {
            if {![catch {set arg $vars($net,cell_pin_pairs)}]} {
               append commands "setPGPinUseSignalRoute $arg\n"
            }
         }
         set nets $vars(secondary_pg,nets)
         set netFormat " -nets %s"
      } else {
         set nets [list "secondary_pg"]
         set netFormat ""
      }

      foreach net $nets {
         set route "routePGPinUseSignalRoute"
         append route [format $netFormat $net]
         catch {append route " -pattern $vars($net,pattern)"}
         catch {append route " -maxFanout $vars($net,max_fanout)"}
         catch {append route " -nonDefaultRule $vars($net,non_default_rule)"}
         append commands "$route\n"
      }
      return $commands
   }

   proc add_power_switches {{domains ""}} {

      global vars
      global errors
      global map

      source $vars(script_path)/ETC/EDI/map_options.tcl

      if {$domains == ""} {
          append commands [FF_EDI::get_power_domains_code]
#         eval [FF::get_power_domains_code]
      }

      foreach domain $domains {
         if {[info exists vars($domain,switchable)] &&
             $vars($domain,switchable)} {
            set type $vars($domain,switch_type)

            deletePowerSwitch -$type -powerDomain $domain

            set command "addPowerSwitch -powerDomain $domain -$type"

            if {[info exists vars($domain,checker_board)] &&
                $vars($domain,checker_board)} {
               append command " -checkerBoard"
            }
            if {[info exists vars($domain,back_to_back_chain)] &&
                $vars($domain,back_to_back_chain)} {
               append command " -backToBackChain"
            }
            if {[info exists vars($domain,loop_back_at_end)] &&
                $vars($domain,loop_back_at_end)} {
               append command " -loopbackAtEnd"
            }
            if {[info exists vars($domain,check_height)] &&
                !$vars($domain,check_height)} {
               append command " -noDoubleHeightCheck"
            }
            if {[info exists vars($domain,verify_rows)] &&
                !$vars($domain,verify_rows)} {
               append command " -noRowVerify"
            }
            if {[info exists vars($domain,enable_chain)] &&
                !$vars($domain,enable_chain)} {
               append command " -noEnableChain"
            }

            foreach option [array names map] {
               if {[info exists vars($domain,$option)]} {
                  append command " -$map($option) $vars($domain,$option)"
               }
            }

            uplevel #0 eval $command
         }
      }
   }

   proc run_clock_eco {args} {

      global vars
      global errors

      if {[llength $args] != 1} {
         puts "<FF> Internal error in run_clock_eco.  Wrong number of args."
         exit -111
      }

      set commands ""
#      append commands "# <FF> RUNNING CLOCK ECO\n"
      switch $args {
         "post_route" {
            append commands [FF_EDI::delete_filler_cells]
            append commands "ckECO -postRoute -useSpecFileCellsOnly\n"
            append commands [FF_EDI::add_filler_cells]
            append commands "changeClockStatus -all -noFixedNetWires\n"
         }
         "post_cts" { 
            append commands "ckECO -postCTS -useSpecFileCellsOnly\n"
         }
         default {
            puts "<FF> Internal error in run_clock_eco."
            puts "<FF> Invalid argument; valid arguments are post_cts and post_route."
            exit -111
         }
      }
   #   if {$vars(codegen)} {
         return $commands
   #   } else {
   #       uplevel #0 eval $commands
   #   }
   }

   ############################################################################
   # Main foundation flow step procedures
   ############################################################################

   proc run_init {{format 1}} {

      global vars
      global env
      global errors
      global warnings
      global env

      set commands ""
      set ucomments ""
      set comments ""
      if {![info exists vars(step)] || ($vars(step) != "feedthrough" &&
                                        $vars(step) != "model_gen")} { 
         append commands "set vars(step) init\n"
         set vars(step) init
      } 

      if {$vars(report_run_time)} {
         append commands "set vars($vars(step),start_time) \[clock seconds\]\n"
         append comments "# - vars(report_run_time)\n"
      } else {
         append ucomments "# - vars(report_run_time)\n"
      }

      if {[info exists vars($vars(step),rpt_dir)]} {
         set vars(rpt_dir) $vars($vars(step),rpt_dir)
      } else {
         set vars(rpt_dir) $vars(orig_rpt_dir)
      }

      ###############################################################################
      # Make sure necessary data is defined
      # Create make directory if it doesn't exists
      ###############################################################################
      if {!$vars(codegen)}  { 
         set command "FF_EDI::check_setup\n"
         append command "sleep 3\n"
         uplevel #0 eval $command 
      }

      ###############################################################################
      # Make sure necessary data is defined
      ###############################################################################

      if {![info exists env(VPATH)]} {
         set env(VPATH) "make"  
      }
      append commands "exec mkdir -p \$env(VPATH)\n"

      if {$vars(backup_data)} {
         puts "# <FF> BACKING UP PRIOR RUN DATA IF IT EXISTS...\n"
         set date [string toupper [clock format [clock seconds] -format {%h%d_%H:%M}]]
         exec mkdir -p BACKUP/$date
         # BCL: Added subst to handle dererencing variables
        
         foreach dir "[subst $vars(dbs_dir)] [subst $vars(rpt_dir)] [subst $vars(log_dir)]" {
            if {[file isdirectory $dir]} {
               exec mv $dir BACKUP/$date
               # BCL: Changed to file mkdir
               puts "Making $dir"
               file mkdir $dir
            }
         }
#         append commands "sleep 5\n"
      }
      # BCL: Added subst to handle dererencing variables
      foreach dir "[subst $vars(dbs_dir)] [subst $vars(rpt_dir)] [subst $vars(log_dir)]" {
         set newDir [subst $dir]
         if {![file exists $newDir]}  {
            file mkdir $newDir
         }
      }

      if {[info exists vars(buffer_tie_assign)] && $vars(buffer_tie_assign)}  {
         append commands "setImportMode -bufferTieAssign true\n"
         append comments "# - vars(buffer_tie_assign)\n"
      } else {
         append ucomments "# - vars(buffer_tie_assign)\n"
      }

      ###############################################################################
      # Load pre-initializatiaon plug-in script
      ###############################################################################
      append commands [FF::source_plug pre_init_tcl]

      ###############################################################################
      # These flow scripts support the following:
      # - Flat chip or block
      # - Hierarchical partition
      # - Top level partition
      #
      # The data loading mechanism are slightly different for each so we determine
      # first if we are in a hierarchical flow (i.e. vars(partition_list) is
      # defined and, if so, whether we are in a hierarchical partition flow
      # or a top partition flow (i.e. cwd == $vars(design) - see below)
      #
      ###############################################################################

       FF_EDI::check_flow

#      append commands "#---------------------------------------------------------------------\n"
#      append commands "#                           EXECUTING FLOW\n"
#      append commands "#---------------------------------------------------------------------\n"

      set hier 0
      
      if {[info exists vars($vars(step),starting_dbs)]} {
         if {[string compare -nocase $vars(dbs_format) "oa"]==0} {
           # Interpret the starting DBS as an OA triple
           set restore_command "[list restoreDesign -cellview $vars($vars(step),starting_dbs)]\n"
         } else {
            if {[file isdirectory $vars($vars(step),starting_dbs)]} {
              set restore_command "restoreDesign $vars($vars(step),starting_dbs) $vars(design)\n"
            } elseif {[file exists $vars($vars(step),starting_dbs)]} {
              set restore_command "restoreDesign $vars($vars(step),starting_dbs).dat $vars(design)\n"
            } else {
              puts "<FF> Starting DBS ($vars($vars(step),starting_dbs)) defined but does not exist"
              set restore_command "restoreDesign $vars($vars(step),starting_dbs).dat $vars(design)\n"
              set warnings($vars(warning_count)) "Starting DBS ($vars($vars(step),starting_dbs)) defined but does not exist"
              incr vars(warning_count)
            }
         }

         append commands [FF::wrap_command $vars(step),restore_design $restore_command]

      } else {

         if {![info exists vars(partition_list)] || ([info exists vars(partition_list)] && \
              ([file tail [file dirname [pwd]]] != "$vars(partition_dir)"))} {
   
            ###############################################################################
            # Partition step or flat init step
            ###############################################################################
   
   #         set hier 1 ??
   
            if {$vars(verbose)} {
               if {![info exists vars(partition_list)]} {
                  append commands "#\n"
                  append commands "# FLAT IMPLEMENTATION FLOW\n"
                  append commands "#\n"
               } else {
                  append commands "#\n"
                  append commands "# PARTITIONING FLOW\n"
                  append commands "#\n"
               }
            }
   
            if {$vars(verbose)} {
               append commands "#\n"
               append commands "# LOADING DESIGN DATA\n"
               append commands "#\n"
            }
            ###############################################################################
            # Load design configuration file
            ###############################################################################
   
            if {[lindex [split $vars(version) "."] 0] <= 10} {
               source $vars(script_path)/ETC/EDI/generic.conf
            }
            if {$vars(ilm)} {
               set ilm_list $vars(ilm_list)
               append comments "# - vars(ilm_list) \"<list of ILMs>\"\n"
               if {$vars(mode) == "bottom_up"} {
                  foreach part $vars(partition_list) {
                     if {[info exists vars($part,ilm_dir)]} {
                        append comments "# - vars(<ilm>,ilm_dir) \"<path to ILM directory>\"\n"
                        if {[lsearch $ilm_list $part] == -1} {
                           lappend ilm_list $part
                        }
                     }
                  }
               }
               foreach ilm $ilm_list {
                  if {[info exists vars($ilm,lef_file)] && [file exists $vars($ilm,lef_file)]} {
                     append comments "# - vars(<ilm>,lef_file) \"<LEF file for block associated with ILM>\"\n"
                     if {[lindex [split $vars(version) "."]  0] <= 10} {
                        lappend rda_Input(ui_leffile) $vars($ilm,lef_file)
                     } else {
                        if {[string compare $vars(dbs_format) "fe"]==0} {
                           lappend vars(lef_files) $vars($ilm,lef_file)
                        }
                     }
                  } else {
                     puts "<FF> WARNING: LEF file either not defined or doesn't exist for $ilm"
                     puts "<FF>          Please make sure it is in your vars(lef_files) list"
                     set warnings($vars(warning_count)) "LEF file either not defined or doesn't exist for $ilm\n\tPlease make sure it is in your vars(lef_files) list"
                     incr vars(warning_count)
                  }
                  if {[info exists vars($ilm,setup_lib)] && [file exists $vars($ilm,setup_lib)]} {
                     append comments "# - vars(<ilm>,setup_lib) \"<LIB file for block associated with ILM>\"\n"
                     if {[lindex [split $vars(version) "."]  0] <= 10} { 
                        lappend rda_Input(ui_timelib) $vars($ilm,setup_lib)
                     } else {
                        if {[string compare $vars(dbs_format) "fe"]==0} {
                           foreach set $vars(library_sets) {
                              if {[lsearch $vars($set,timing) $vars($ilm,setup_lib)] == -1} {
                                 lappend vars($set,timing) $vars($ilm,setup_lib)
                              }
                           }
                        }
                     }
                  } else {
                     puts "<FF> WARNING: LIB file either not defined or doesn't exist for $ilm"
                     puts "<FF>          Please make sure it is in your library set definitions"
                     set warnings($vars(warning_count)) "LIB file either not defined or doesn't exist for $ilm\n\tPlease make sure it is in your library set definitions"
                     incr vars(warning_count)
                  }
               }
            } else {
               append ucomments "# - vars(ilm_list) \"<list of ILMs>\"\n"
               append ucomments "# - vars(<ilm>,ilm_dir) \"<path to ILM directory>\"\n"
               append ucomments "# - vars(<ilm>,lef_file) \"<LEF file for block associated with ILM>\"\n"
               append ucomments "# - vars(<ilm>,setup_lib) \"<LIB file for block associated with ILM>\"\n"
            }
   
            FF_EDI::dump_config
   
            if {[lindex [split $vars(version) "."]  0] <= 10} {
                  set command "loadConfig \$vars(script_dir)/run.conf\n"
               append commands [FF::wrap_command $vars(step),load_config $command]
            } else {
               if {[string compare -nocase $vars(netlist_type) "verilog"]>=0} {
                  set command "source \$vars(script_dir)/init.tcl\n"
                  append command "init_design\n"
                  append commands [FF::wrap_command $vars(step),init_design $command]
               } else {
                  if {$hier} {
                     if {$vars(step) == "feedthrough"} { 
                       set command "restoreDesign -cellview \[list $vars(oa_design_lib) $vars(oa_design_cell) $vars(oa_design_view)\]\n"
                     } else {
                       set command "restoreDesign -cellview \[list $vars(oa_partition_lib) $vars(oa_design_cell) $vars(oa_design_view)\]\n"
                     } 
                  } else {
                    set command "restoreDesign -cellview \[list $vars(oa_design_lib) $vars(oa_design_cell) $vars(oa_design_view)\]\n"
                  }
                  append commands [FF::wrap_command $vars(step),restore_design $command]
               }
   #            if {!$vars(codegen)} {
   #               Puts "<FF> ---------------------------------------"
   #               Puts "<FF> $commands"
   #               Puts "<FF> ---------------------------------------"
   #               uplevel #0 eval $commands
   #               set commands ""  
   #            }  
            }
   
   
            ###############################################################################
            # Load "always source" plug-in script
            ###############################################################################
            append commands [FF::source_plug always_source_tcl]
   
            ###############################################################################
            # Check for the existence of either a floorplan file, a
            # DEF file, or both and load them
            ###############################################################################
            set command "" 
            if {[info exists vars(fp_tcl_file)] || [info exists vars(fp_tcl_proc)]} {
               append comments "# - vars(fp_tcl_file)\n"
               append comments "# - vars(fp_tcl_proc)\n"
               if {[info exists vars(fp_tcl_file)] && ![info exists vars(fp_tcl_proc)]} {
                  append command "ff_procs::source_file $vars(fp_tcl_file)\n"
               } elseif {![info exist vars(fp_tcl_file)] && [info exists vars(fp_tcl_proc)]} {
                  append command "$vars(fp_tcl_proc)\n"
               } else {
                  append command "#  ERROR: Both fp_tcl_file and fp_tcl_proc are defined but are mutually exclusive\n"
                  set errors($vars(error_count)) "Both fp_tcl_file and fp_tcl_proc are defined but are mutually exclusive"
                  incr vars(error_count)
               }
            } else {
               append ucomments "# - vars(fp_tcl_file)\n"
               append ucomments "# - vars(fp_tcl_proc)\n"
               if {[info exists vars(fp_file)]} {
                  if {[file exists $vars(fp_file)]} {
   #                  append command "Puts \"<FF> LOADING FP FILE $vars(fp_file)\"\n"
                     append command "loadFPlan $vars(fp_file)\n"
                  }
                  append comments "# - vars(fp_file)\n"
               } else {
                  append ucomments "# - vars(fp_file)\n"
               }
               if {[info exists vars(oa_fp)]} {
                  append command "oaIn $vars(oa_fp)\n"
                  append comments "# - vars(oa_fp)\n"
               } else {
                  append ucomments "# - vars(oa_fp)\n"
               }
               if {[info exists vars(def_files)]} {
                  # BCL: Added subst to handle dererencing variables
                  foreach def_file [subst $vars(def_files)] {
                     if {$vars(rc)} {
                        append command "defIn $def_file\n"
                     } else {
                        if {[file exists $def_file]} {
   #                        append command "Puts \"<FF> LOADING DEF FILE $def_file\"\n"
                           append command "defIn $def_file\n"
                        }
                     }
                  }
                  append comments "# - vars(def_files)\n"
               } else {
                  append ucomments "# - vars(def_files)\n"
               }
            }
            append commands [FF::wrap_command $vars(step),load_floorplan $command]
   
            if {($vars(parent) == "rc") && $vars(rc)} {
               set commands [FF::source_plug always_source_tcl]
               if {$vars(report_run_time)} {
                  append commands "set vars($vars(step),start_time) \[clock seconds\]\n"
               }
               append commands [FF::source_plug pre_init_tcl]
            }
   
   #         if {[info exists vars(guides)]} {
   #            set command "\nbuild_guides\n"
   #            append commands [FF::wrap_command init,build_guides $command]
   #         }
   #         if {[info exists vars(blockages)]} {
   #            set command "\nadd_blockages\n"
   #            append commands [FF::wrap_command init,add_blockages $command]
   #         }

            if {$vars(generate_tracks)} {
               set command "generateTracks\n"
               if {[info exists vars(honor_pitch)] && $vars(honor_pitch)} {
                  set command " generateTracks -honorPitch\n"
               }
               append commands [FF::wrap_command $vars(step),generate_tracks $command]
               append comments "# - vars(generate_tracks)\n"
            } else {
               append ucomments "# - vars(generate_tracks)\n"
            }
   
   
            ###############################################################################
            # Load CPF file if it is defined (low power flow)
            ###############################################################################
            if {[info exists vars(cpf_file)] && $vars(cpf_timing)} {
               set command "loadCPF $vars(cpf_file)\n"
               append commands [FF::wrap_command $vars(step),load_cpf $command]
               set command "commitCPF"
               if {$vars(cpf_keep_rows)} {
                  append command " -keepRows"
               }
               if {$vars(cpf_power_domain)} {
                  append command " -power_domain"
               }
               if {$vars(cpf_isolation)} {
                  append command " -isolation"
               }
               if {$vars(cpf_state_retention)} {
                  append command " -state_retention"
               }
               if {$vars(cpf_level_shifter)} {
                  append command " -level_shifter"
               }
               if {$vars(cpf_power_switch)} {
                  append command " -power_switch"
               }
               append command "\n"
               append commands [FF::wrap_command $vars(step),commit_cpf $command]
               append comments "# - vars(cpf_file)\n"
               append comments "# - vars(cpf_isolation)\n"
               append comments "# - vars(cpf_state_retention)\n"
               append comments "# - vars(cpf_level_shifter)\n"
               append comments "# - vars(cpf_power_switch)\n"
               append comments "# - vars(cpf_power_domain)\n"
               append comments "# - vars(cpf_keep_rows)\n"
            } elseif {[info exists vars(ieee1801_file)]} {
               append comments "# - vars(ieee1801_file)\n"
               append comments "# - vars(ieee1801_isolation)\n"
               append comments "# - vars(ieee1801_state_retention)\n"
               append comments "# - vars(ieee1801_level_shifter)\n"
               append comments "# - vars(ieee1801_power_switch)\n"
               append comments "# - vars(ieee1801_power_domain)\n"
               append comments "# - vars(ieee1801_keep_rows)\n"
            } else {
               append ucomments "# - vars(cpf_file)\n"
               append ucomments "# - vars(cpf_isolation)\n"
               append ucomments "# - vars(cpf_state_retention)\n"
               append ucomments "# - vars(cpf_level_shifter)\n"
               append ucomments "# - vars(cpf_power_switch)\n"
               append ucomments "# - vars(cpf_power_domain)\n"
               append ucomments "# - vars(cpf_keep_rows)\n"
            }
            if {[info exists vars(activity_file)]} {
   #            append commands $header
   #            set header ""
               set command "readActivityFile -format $vars(activity_file_format) $vars(activity_file)\n"
               append commands [FF::wrap_command $vars(step),read_activity_file $command]
               append comments "# - vars(activity_file)\n"
               append comments "# - vars(activity_file_format)\n"
            } else {
               append ucomments "# - vars(activity_file)\n"
               append ucomments "# - vars(activity_file_format)\n"
            }
   
            ###############################################################################
            # Specify ILMs if defined
            ###############################################################################
            if {[info exists ilm_list] && ($ilm_list != "")} {
               set command ""
               foreach cell $ilm_list {
                  if {[info exists vars($cell,ilm_dir)] && [file isdirectory $vars($cell,ilm_dir)]} {
                     if {[lindex [split $vars(version) "."]  0] <= 10} {
                        append command "specifyIlm -cell $cell -dir $vars($cell,ilm_dir)\n"
                     } else {
                       if {[string compare -nocase $vars(dbs_format) "oa"]==0} {
                           append command "specifyIlm -cell $cell\n"
                        } else {
                           append command "specifyIlm -cell $cell -dir $vars($cell,ilm_dir)\n"
                        }
                     }
                  } else {
                     puts "<FF> ERROR: ilm directory missing for $cell"
                     set errors($vars(error_count)) "ILM directory missing for $cell"
                     incr vars(error_count)
                  }
               }
               if {$command != ""} {
                  append commands [FF::wrap_command $vars(step),specify_ilm $command]
               }
            }
   
            if {$vars(ilm) && [info exists vars(ilm_non_sdc_file)]} {
               if {[file exists $vars(ilm_non_sdc_file)]} {
                  if {[lindex [split $vars(version) "."]  0] <= 10} {
                     set command "loadTimingCon -ilmNonSdcFile $vars(ilm_non_sdc_file)\n"
                  } else {
                     set command "setIlmNonSdcConstraintFile $vars(ilm_non_sdc_file)\n"
                  }
                  append commands [FF::wrap_command $vars(step),load_ilm_non_sdc_file $command]
               }
               append comments "# - vars(ilm_non_sdc_file)\n"
            } else {
               append ucomments "# - vars(ilm_non_sdc_file)\n"
            }
   
            ###############################################################################
            # Load timing enviroment based on the flow setting in the
            # setup.tcl file. If the flow is mmmc, load the mmmc setup
            # here else load the default timing environment
            ###############################################################################
   #         append commands "#\n"
   #         append commands "# SETTING UP TIMING ENVIRONMENT\n"
   #         append commands "#\n"
            if {$vars(flow) == "mmmc"} {
               set command [FF_EDI::initialize_timing mmmc]
            } else {
               set command [FF_EDI::initialize_timing minmax]
            }
   
   #     foreach var [array name vars] {
   #        if {($var != "step") && ($var != "mode") && ($var != "ilm") && \
   #            ($var != "flavor") && ($var != "user_mode") && ($var != "flat") && \
   #            ($var != "report_run_time") && ($var != "makefile") && ($var != "codegen") && \
   #            ($var != "backup_data") && ($var != "verbose") && ($var != "format_lines") && \
   #            ($var != "warning_count") && ($var != "error_count") && ($var != "rc") && \
   #            ($var != "generate_tracks") && ($var != "fix_hold") && ($var != "honor_pitch") && \
   #            ($var != "script_path") && ($var != "fix_hold") && ($var != "honor_pitch") && \
   #            ($var != "steps") && ($var != "sourced") && ($var != "version")} {
   #           set vars($var) "\\\$vars($var)"
   #        }
   #     }
      
            append commands [FF::wrap_command $vars(step),initialize_timing $command]
            if {$vars(flow) == "mmmc"} {
               set command [FF_EDI::derate_timing mmmc]
               append commands [FF::wrap_command $vars(step),derate_timing $command]
            }
   
            ###############################################################################
            # Load scan DEF if it exists
            ###############################################################################
            if {[info exists vars(scan_def)]} {
               if {[file exists $vars(scan_def)]} {
                  if {$vars(verbose)} {
                     append commands "#\n"
                     append commands "# <FF> LOADING SCAN DEF FILE\n"
                     append commands "#\n"
                  }
                  set command "defIn $vars(scan_def)\n"
                  append commands [FF::wrap_command $vars(step),load_scan $command]
               }
               append comments "# - vars(scan_def)\n"
            } else {
               append ucomments "# - vars(scan_def)\n"
            }
   
            ###############################################################################
            # Specify spare gates for placement and optimization consideration; this assumes
            # the spare cells are in the netlist.
            ###############################################################################
   
            set command ""
            if {[info exists vars(spare_cells)]} {
               foreach spare_cell $vars(spare_cells) {
                  append command "specifySpareGate -inst $spare_cell\n"
               }
               append comments "# - vars(spare_cells)\n"
            } else {
               append ucomments "# - vars(spare_cells)\n"
            }
            append commands [FF::wrap_command $vars(step),specify_spare_gates $command]
   
            ###############################################################################
            # Load the recommended command mode settings
            ###############################################################################
            if {$vars(verbose)} {
               append commands "#\n"
               append commands "# DEFINING MODE SETTINGS\n"
               append commands "#\n"
            }
   
            ###############################################################################
            # Set don't use cells; disable some (clock buffers, strong buffers, etc.),
            # enable others that may have "dont_use true" in the library (like delay cells
            # for hold fixing)
            ###############################################################################
            set command ""
            if {[info exists vars(dont_use_list)]} {
               foreach cell $vars(dont_use_list) {
                  append command "setDontUse $cell true\n"
               }
               append comments "# - vars(dont_use_list)\n"
            } else {
               append ucomments "# - vars(dont_use_list)\n"
            }
            if {[info exists vars(dont_use_file)] && [file exists $vars(dont_use_file)]} {
               append command "source $vars(dont_use_file)\n"
               append comments "# - vars(dont_use_file)\n"
            } else {
               append ucomments "# - vars(dont_use_file)\n"
            }
            if {[info exists vars(use_list)]} {
               foreach cell $vars(use_list) {
                  append command "setDontUse $cell false\n"
               }
               append comments "# - vars(use_list)\n"
            } else {
               append ucomments "# - vars(use_list)\n"
            }
            if {$command != ""} {
               append commands [FF::wrap_command $vars(step),set_dont_use $command]
            }
   
            ###############################################################################
            # Set maximum routing layers
            ###############################################################################
            if {[info exists vars(max_route_layer)]} {
               set command "setMaxRouteLayer $vars(max_route_layer)\n"
               append commands [FF::wrap_command $vars(step),set_max_route_layer $command]
               append comments "# - vars(max_route_layer)\n"
            } else {
               append ucomments "# - vars(max_route_layer)\n"
            }
   
            ###############################################################################
            # Set design mode
            ###############################################################################
            set process [regsub "nm" $vars(process) ""]
            set command "setDesignMode -process $process\n"
            append commands [FF::wrap_command $vars(step),set_design_mode $command]
   
            ###############################################################################
            # Insert welltaps and pre/post endcaps
            ###############################################################################
            if {([FF::get_by_suffix vars "welltaps"] != "") ||
                (([FF::get_by_suffix vars "pre_endcap"] != "") &&
                 ([FF::get_by_suffix vars "post_endcap"] != ""))} {
               set command [FF_EDI::insert_welltaps_endcaps]
               append commands [FF::wrap_command $vars(step),insert_welltaps_endcaps $command]
               append comments "# - vars(welltaps)\n"
               append comments "# - vars(pre_endcap)\n"
               append comments "# - vars(post_endcap)\n"
            } else {
               append ucomments "# - vars(welltaps)\n"
               append ucomments "# - vars(pre_endcap)\n"
               append ucomments "# - vars(post_endcap)\n"
            }
   
         } else {
   
            ###############################################################################
            # Partition init step
            ###############################################################################
   
            set ptn [file tail [pwd]]
            set vars(design) $ptn
   #         set vars(ilm) 0
            ###############################################################################
            if {[lsearch $vars(partition_list) $ptn] == -1} {
               append commands "#------------------------------------------------------------\n"
               append commands "#        TOP ($ptn) IMPLEMENTATION FLOW\n"
               append commands "#------------------------------------------------------------\n"
               if {[lindex [split $vars(version) "."]  0] <= 10} {
                  set command "loadConfig $ptn.conf 0\n"
                  if {[info exists vars(save_ilm_non_sdc_file)]} {
                     set vars(ilm_non_sdc_file) $vars(save_ilm_non_sdc_file)
                  }
                  append command "global rda_Input\n"
                  foreach part $vars(partition_list) {
                    append command "lappend rda_Input(ui_leffile) ../$part/$part.antenna.lef\n"
                  }
                  append command "commitConfig\n"
                  append commands [FF::wrap_command $vars(step),load_config $command]
               } else {
                  if {[string compare $vars(dbs_format) "oa"]==0} {
                    set command "restoreDesign -cellView \[list $vars(oa_partition_lib) $ptn layout\]\n"
                  } else {
                     set command "restoreDesign . $ptn\n"
                     foreach part $vars(partition_list) {
                          append command "if {\[file exists ../$part/$part.antenna.lef\]} {\n"
                          append command "loadLefFile ../$part/$part.antenna.lef\n"
                          append command "}\n"
                     }
   #                  set command "source $ptn.globals\n"
   #                  foreach part $vars(partition_list) {
   #                    append command "lappend init_lef_file ../$part/$part.antenna.lef\n"
   #                  }
   #                  append command "init_design\n"
                  }
                  append commands [FF::wrap_command $vars(step),restore_design $command]
                  set restore_design true
                  
                  # Set the ILM mode
                  if $vars(top) {
                     if {!$vars(enable_dlm) || ($vars(enable_dlm) && !$vars(black_box))} {
                        append commands [FF::wrap_command $vars(step),setIlmMode "setIlmMode -keepFlatten true\n"]
                     }
                  }                  
               }
            } else {
               append commands "#------------------------------------------------------------\n"
               append commands "# PARTITION ($ptn) IMPLEMENTATION FLOW\n"
               append commands "#------------------------------------------------------------\n"
               if {[lindex [split $vars(version) "."]  0] <= 10} {
                  set command "loadConfig $ptn.conf\n"
                  append commands [FF::wrap_command $vars(step),load_config $command]
               } else {
                  if {[string compare $vars(dbs_format) "oa"]==0} {
                    set command "restoreDesign -cellView \[list $vars(oa_partition_lib) $ptn layout\]\n"
                  } else {
                     set command "restoreDesign . $ptn\n"
   #                  set command "source $ptn.globals\n"
   #                  append command "init_design\n"
                  }
                  append commands [FF::wrap_command $vars(step),restore_design $command]
                  set restore_design true
               }
            }

            if {[info exists vars(use_flexmodels)] && $vars(use_flexmodels)} {
               set command "ff_replace_flexmodel_with_full_netlist\n"
               append commands [FF::wrap_command $vars(step),ff_replace_flexmodel_with_full_netlist $command]
            }
   
   #         if {[regexp "^10" $vars(version)] || [regexp "^9" $vars(version)]} {
   #            append commands [FF::wrap_command $vars(step),load_config $command]
   #         } else { 
   #            if {[string compare -nocase $vars(dbs_format) "fe"]==0} {
   #               append commands [FF::wrap_command $vars(step),init_design $command]
   #            } else {
   #               set command "restoreDesign -cellview {$vars(oa_partition_lib) $ptn layout}\n"
   #               append commands [FF::wrap_command $vars(step),restore_design $command]
   #            }
   #         }
            append commands [FF::source_plug always_source_tcl]
   
            ###############################################################################
            # Load floorplan file or DEF; use defIn to load a DEF file
            ###############################################################################
            if {[string compare $vars(dbs_format) "fe"]==0} {
               if {![info exists restore_design]} {
                  append commands "loadFPlan $ptn.fp\n"
                  append commands "source $ptn.mode\n"
                  if {[file exists $ptn.scan.def]} {
                     append commands "Puts \"<FF> LOADING SCAN DEF FILE $ptn.scan.def\"\n"
                     append commands "defIn $ptn.scan.def\n"
                  }
               }
            }
   
            ###############################################################################
            # Override maximum routing layer if defined for the partition
            ###############################################################################
            if {[info exists vars($ptn,max_route_layer)]} {
               append commands "setMaxRouteLayer $vars($ptn,max_route_layer)\n"
               append comments "# - vars(max_route_layer)\n"
            } else {
               append ucomments "# - vars(max_route_layer)\n"
            }
   
            ###############################################################################
            # Specify the ILM models for the top partition
            ###############################################################################
   #         if $vars(top) {
   #            set command ""
   #            foreach part $vars(partition_list) {
   #               if {[info exists vars($part,ilm_dir)] && ($vars(codegen) || [file isdirectory $vars($part,ilm_dir)])} {
   #                  if {[lindex [split $vars(version) "."]  0] <= 10} {
   #                     append command "specifyIlm -cell $part -dir $vars($part,ilm_dir)\n"
   #                  } else {
   #                    if {[string compare -nocase $vars(dbs_format) "oa"]==0} {
   #                        append command "specifyIlm -cell $part\n"
   #                     } else {
   #                        append command "specifyIlm -cell $part -dir $vars($part,ilm_dir)\n"
   #                     }
   #                  }
   #               } else {
   #                  if {[lindex [split $vars(version) "."]  0] <= 10} {
   #                     append command "specifyIlm -cell $part -dir ../$part/$part.ilm\n"
   #                  } else {
   #                    if {[string compare -nocase $vars(dbs_format) "oa"]==0} {
   #                        append command "specifyIlm -cell $part\n"
   #                     } else {
   #                        append command "specifyIlm -cell $part -dir ../$part/$part.ilm\n"
   #                     }
   #                  }
   #               }
   #            }
   #            if {$command != ""} {
   #               append commands [FF::wrap_command $vars(step),specify_ilm $command]
   #            }
   #            if {$vars(ilm) && [info exists vars(ilm_non_sdc_file)]} {
   #               if {[file exists $vars(ilm_non_sdc_file)]} {
   #                  if {[lindex [split $vars(version) "."]  0] <= 10} {
   #                     set command "loadTimingCon -ilmNonSdcFile $vars(ilm_non_sdc_file)\n"
   #                  } else {
   #                      set command "setIlmNonSdcConstraintFile $vars(ilm_non_sdc_file)\n"
   #                  }
   #                  append commands [FF::wrap_command $var(step),load_ilm_non_sdc_file $command]
   #               }
   #            }
   #
   #            set command [FF_EDI::initialize_timing mmmc]
   #            if {![info exists vars(cpf_file)]} {
   #               append commands [FF::wrap_command $vars(step),initialize_timing $command]
   #            } else {
   #               set defer_commands [FF::wrap_command $vars(step),initialize_timing $command] 
   #            }
   #         }
            ###############################################################################
            # Load CPF file if it is defined (low power flow)
            ###############################################################################
            if {([info exists vars(cpf_file)]) && ($vars(cpf_file) != "")} {
               if {$vars(top)} {
                  set command "loadCPF $vars(cpf_file)\n"
               } else {
                  set command "loadCPF $ptn.cpf\n"
               }
               append commands [FF::wrap_command $vars(step),load_cpf $command]
               set command "commitCPF"
               if {$vars(cpf_keep_rows)} {
                  append command " -keepRows"
               }
               if {$vars(cpf_power_domain)} {
                  append command " -power_domain"
               }
               if {$vars(cpf_isolation)} {
                  append command " -isolation"
               }
               if {$vars(cpf_state_retention)} {
                  append command " -state_retention"
               }
               if {$vars(cpf_level_shifter)} {
                  append command " -level_shifter"
               }
               if {$vars(cpf_power_switch)} {
                  append command " -power_switch"
               }
               append command "\n"
               append commands [FF::wrap_command $vars(step),commit_cpf $command]
   #            if {$vars(top)} {
   #                append commands $defer_commands
   #            }
               append comments "# - vars(cpf_file)\n"
               append comments "# - vars(cpf_isolation)\n"
               append comments "# - vars(cpf_state_retention)\n"
               append comments "# - vars(cpf_level_shifter)\n"
               append comments "# - vars(cpf_power_switch)\n"
               append comments "# - vars(cpf_power_domain)\n"
               append comments "# - vars(cpf_keep_rows)\n"
            } elseif {[info exists vars(ieee1801_file)]} {
               append commands "setBetaFeature msvSupportIEEE1801 1\n"
               set command "read_power_intent $vars(ieee1801_file) -1801\n"
               append commands [FF::wrap_command $vars(step),load_ieee1801 $command]
               set command "commit_power_intent"
               if {$vars(ieee1801_keep_rows)} {
                  append command " -keepRows"
               }
               if {$vars(ieee1801_power_domain)} {
                  append command " -power_domain"
               }
               if {$vars(ieee1801_isolation)} {
                  append command " -isolation"
               }
               if {$vars(ieee1801_state_retention)} {
                  append command " -state_retention"
               }
               if {$vars(ieee1801_level_shifter)} {
                  append command " -level_shifter"
               }
               if {$vars(ieee1801_power_switch)} {
                  append command " -power_switch"
               }
               append command "\n"
               append commands [FF::wrap_command $vars(step),commit_ieee1801 $command]

               append comments "# - vars(ieee1801_file)\n"
               append comments "# - vars(ieee1801_isolation)\n"
               append comments "# - vars(ieee1801_state_retention)\n"
               append comments "# - vars(ieee1801_level_shifter)\n"
               append comments "# - vars(ieee1801_power_switch)\n"
               append comments "# - vars(ieee1801_power_domain)\n"
               append comments "# - vars(ieee1801_keep_rows)\n"
            } else {
               append ucomments "# - vars(cpf_file)\n"
               append ucomments "# - vars(cpf_isolation)\n"
               append ucomments "# - vars(cpf_state_retention)\n"
               append ucomments "# - vars(cpf_level_shifter)\n"
               append ucomments "# - vars(cpf_power_switch)\n"
               append ucomments "# - vars(cpf_power_domain)\n"
               append ucomments "# - vars(cpf_keep_rows)\n"
            }
            ###############################################################################
            # Specify the ILM models for the top partition
            ###############################################################################
            if $vars(top) {
               if {!$vars(enable_dlm) || ($vars(enable_dlm) && !$vars(black_box))} {
                  set command ""
                  foreach part $vars(partition_list) {
                     if {[info exists vars($part,ilm_dir)] && ($vars(codegen) || [file isdirectory $vars($part,ilm_dir)])} {
                        if {[lindex [split $vars(version) "."]  0] <= 10} {
                           append command "specifyIlm -cell $part -dir $vars($part,ilm_dir)\n"
                        } else {
                          if {[string compare -nocase $vars(dbs_format) "oa"]==0} {
                              append command "specifyIlm -cell $part\n"
                           } else {
                              append command "specifyIlm -cell $part -dir $vars($part,ilm_dir)\n"
                           }
                        }
                     } else {
                        if {[lindex [split $vars(version) "."]  0] <= 10} {
                           append command "specifyIlm -cell $part -dir ../$part/$part.ilm\n"
                        } else {
                          if {[string compare -nocase $vars(dbs_format) "oa"]==0} {
                              append command "specifyIlm -cell $part\n"
                           } else {
                              append command "specifyIlm -cell $part -dir ../$part/$part.ilm\n"
                           }
                        }
                     }
                  }
                  if {$command != ""} {
                     append commands [FF::wrap_command $vars(step),specify_ilm $command]
                  }
                  if {$vars(ilm) && [info exists vars(ilm_non_sdc_file)]} {
                     if {[file exists $vars(ilm_non_sdc_file)]} {
                        if {[lindex [split $vars(version) "."]  0] <= 10} {
                           set command "loadTimingCon -ilmNonSdcFile $vars(ilm_non_sdc_file)\n"
                        } else {
                            set command "setIlmNonSdcConstraintFile $vars(ilm_non_sdc_file)\n"
                        }
                        append commands [FF::wrap_command $var(step),load_ilm_non_sdc_file $command]
                     }
                  }
   
                  set command [FF_EDI::initialize_timing mmmc]
   #               if {![info exists vars(cpf_file)]} {
                     append commands [FF::wrap_command $vars(step),initialize_timing $command]
   #               } else {
   #                  set defer_commands [FF::wrap_command $vars(step),initialize_timing $command] 
   #               }
               }
            }
         }
      }

      ###############################################################################
      # Load post-initialization plug-in script
      ###############################################################################
      append commands [FF::source_plug post_init_tcl 0]

      ###############################################################################
      # Check pre-place timing (and generate timing graph for placement)
      ###############################################################################
      if {$vars(step) != "model_gen"} {
         if {![info exists vars(time_design_options,setup)]} {
            set command "timeDesign -preplace -prefix preplace -outDir $vars(rpt_dir)\n"
         } else {
            set command [format "timeDesign -preplace -prefix preplace -outDir $vars(rpt_dir) %s\n" $vars(time_design_options,setup)]
         }
         append commands [FF::wrap_command $vars(step),time_design $command]
      }

      ###############################################################################
      # Check data setup (sanity check)
      ###############################################################################
      set command "checkDesign -all\n"
      append commands [FF::wrap_command $vars(step),check_design $command]

      if {!$vars(ilm)} {
         set command "check_timing\n"
         append commands [FF::wrap_command $vars(step),check_timing $command]
      }

      ###############################################################################
      # Generate reports
      #------------------------------------------------------------------------------
      # Report power domain for level-shifters, isolation and pg nets
      #------------------------------------------------------------------------------
      if {[FF::is_lp_flow] && ([info exists vars(power_domains)] && ([llength $vars(power_domains)] > 0))} {
#         set command "set domains \[FF_EDI::get_power_domains_code\]\n"
         set command [FF_EDI::get_power_domains_code]

         append command "foreach domain \$domains {\n"
         append command "   set domain_file \[regsub -all {\[\]\[<>|\\/?*:\]} \$domain _\]\n"
         append command "   reportPowerDomain -powerDomain \$domain -file $vars(rpt_dir)/\${domain_file}.rpt -shifter -isoInst -pgNet\n"

      #------------------------------------------------------------------------------
      # Report library binding for power domains
      #------------------------------------------------------------------------------
         append command "   foreach analysis_view \[all_setup_analysis_views\] {\n"
         append command "      set_default_view -setup \$analysis_view\n"
         append command "      reportPowerDomain -powerDomain \$domain -file $vars(rpt_dir)/\${domain_file}_\$analysis_view.rpt -bindLib\n"
         append command "   }\n"

         append command "     setAnalysisMode -checkType hold\n"

         append command "   foreach analysis_view \[all_hold_analysis_views\] {\n"
         append command "      set_default_view -hold \$analysis_view\n"
         append command "      reportPowerDomain -powerDomain \$domain -file $vars(rpt_dir)/\${domain_file}_\$analysis_view.rpt -bindLib\n"
         append command "   }\n"

         append command "   setAnalysisMode -checkType setup\n"
         append command "}\n"
         append commands [FF::wrap_command $vars(step),report_power_domains $command]
         if {$vars(flow) =="mmmc"} {
            append commands "set_default_view -setup $vars(default_setup_view) -hold $vars(default_hold_view)\n"
         }
      }

      if {[info exists comments]} {
         if {$comments == ""} {
            if {[info exists vars(comments)]} {
               unset vars(comments)
            }
         } else {
            set vars(comments) $comments
         }
      }
      if {[info exists ucomments]} {
         if {$ucomments == ""} {
            if {[info exists vars(ucomments)]} {
               unset vars(ucomments)
            }
         } else {
            set vars(ucomments) $ucomments
         }
      }
      set fcommands [FF_EDI::insert_comments] 
      append fcommands $commands

      if {$vars(codegen)} {
         return $fcommands
      } else {
          uplevel #0 eval $commands
      }

   }

   proc run_place {{format 1}} {

      global vars
      global env
      global errors

      if {[info exists vars(parent)] && ($vars(parent) == "rc")} {
         set vars(step) rcp
      } else {
         if {$vars(step) != "feedthrough"} {
            set vars(step) place
         }
      }
      set commands ""
#      append commands "set vars(step) $vars(step)\n"

      #########################################################################
      # Initialize step ...
      #########################################################################
      set command [FF_EDI::initialize_step place]
      append commands [FF_EDI::insert_comments] 
      append commands [FF::wrap_command $vars(step),initialize_step $command]

      append commands "Puts \"<FF> RUNNING PLACEMENT ...\"\n"

      if {$vars(verbose)} {
         append commands "#\n"
         append commands "# RUNNING PLACEMENT\n"
         append commands "#\n"
      }

      #########################################################################
      # Load optional pre placement file (plug-in)
      #########################################################################

      append commands [FF::source_plug pre_place_tcl]

      #########################################################################
      # Flexmodel setup
      #########################################################################
      if {$vars(step) == "feedthrough" &&
          [info exists vars(use_flexmodels)] && $vars(use_flexmodels)} {
         set command "set_proto_model_physical_constraint -type soft_guide\n"
         append command "setPlaceMode -softGuideStrength high\n"
         if {!([info exists vars(placement_based_ptn)] && $vars(placement_based_ptn))} {
            append command "set_proto_mode -place_effort default\n"
            append command "set_proto_mode -timing_net_delay_model use_actual_wire\n"
         }
         append commands [FF::wrap_command $vars(step),set_proto_model $command]         
      }

      #########################################################################
      # Run standard cell placement or load placement plug-in
      #########################################################################

      set command ""
      if {[info exists vars(place_tcl)]} {
          if {[file exists $vars(place_tcl)]} {
            append command [FF::source_plug place_tcl]
          } else {
            set errors($vars(error_count)) "Plug-in vars(place_tcl) defined but the file does not exist"
            incr vars(error_count)
#            set vars(abort) 1
          }
      } else {
         if {[info exists vars(sdp_files)]} {
            foreach file $vars(sdp_files) {
               append command "#readSdpFile -file $file -hierPath <instance> -origin <x y> -leftOverGroup <true | false>\n"
            }
            append command "#planDesign -useSdpGroup\n"
         }
         if {[info exists vars(parent)] && ($vars(parent) == "rc")} {
            append command "placeDesign \n"
         } else {
            append command "placeDesign "
            if {[info exists vars(in_place_opt)] && $vars(in_place_opt)} {
               append command " -inPlaceOpt"
            }
            if {[info exists vars(no_pre_place_opt)] && $vars(no_pre_place_opt)} {
               append command " -noPrePlaceOpt"
            }
            append command "\n"
         }

      }

      if {[info exist vars(parent)] && ($vars(parent) != "rc") &&  $vars(rc) && $vars(physical_flow)} {
         set command "ecoPlace\n"
         append commands [FF::wrap_command $vars(step),eco_place $command]
      } else {
         append commands [FF::wrap_command $vars(step),place_design $command]
      }

      #########################################################################
      # Load optional post placement file (plug-in)
      #########################################################################

      append commands [FF::source_plug post_place_tcl 0]

      #########################################################################
      # Add tie cells for logic 0/1 nets
      #########################################################################

      set command [FF_EDI::add_tie_cells false true]
      append commands [FF::wrap_command $vars(step),add_tie_cells $command]

      ###############################################################################
      # Check post-place timing
      ###############################################################################
      if {![info exists vars(time_design_options,setup)]} {
         set command "timeDesign -prects -prefix place -outDir $vars(rpt_dir)\n"
      } else {
         set command [format "timeDesign -prects -prefix place -outDir $vars(rpt_dir) %s\n" $vars(time_design_options,setup)]
      }
      append commands [FF::wrap_command $vars(step),time_design $command]

      if {$vars(codegen)} {
         return $commands
      } else {
         uplevel #0 eval $commands
      }
   }

   proc run_prects {{format 1}} {

      global vars
      global env
      global errors

      if {[info exists vars(parent)] && ($vars(parent) == "rc")} {
         set vars(step) rcp
      } else {
         set vars(step) prects
      }

      set commands ""
#      append commands "set vars(step) $vars(step)\n"

      #########################################################################
      # Initialize step ...
      #########################################################################

      set command [FF_EDI::initialize_step prects]
      append commands [FF_EDI::insert_comments] 
      append commands [FF::wrap_command $vars(step),initialize_step $command]

      append commands "Puts \"<FF> RUNNING PRE-CTS OPTIMIZATION ...\"\n"

      if {$vars(verbose)} {
         append commands "#\n"
         append commands "# RUNNING PRE-CTS OPTIMIZATION\n"
         append commands "#\n"
      }

      #########################################################################
      # Load optional pre CTS file (plug-in)
      #########################################################################

      append commands [FF::source_plug pre_prects_tcl]

      if {[info exists vars(parent)] && ($vars(parent) == "rc")} {
         return $commands
      }

      #########################################################################
      # Run pre-CTS optimization
      #########################################################################

      set command "optDesign -preCTS -outDir $vars(rpt_dir) -prefix prects\n"
      append commands [FF::wrap_command $vars(step),opt_design $command]

      #########################################################################
      # Load optional post CTS file (plug-in)
      #########################################################################

      append commands [FF::source_plug post_prects_tcl 0]

      if {[info exists vars(clock_gate_clone)] && $vars(clock_gate_clone)} {
         if {$vars(verbose)} {
            append commands "#\n"
            append commands "# RUNNING CLOCK GATE CLONING\n"
            append commands "#\n"
         }
         # Set spec_file if one is defined
         if {[info exists vars(cts_spec)]} {
            set spec_file $vars(cts_spec)
         }
         if {([info exists vars(partition_list)]) &&
             ([file tail [file dirname [pwd]]] == "$vars(partition_dir)")} {
            set ptn [file tail [pwd]]
            # Override with partition spec if defined
            if {[info exists vars($ptn,cts_spec)]} {
               set spec_file $vars($ptn,cts_spec)
            }
         }
         # Load final spec file or generate one
#         if {[info exists spec_file]} {
#            append commands "cleanupSpecifyClockTree\n"
#            foreach spec $spec_file {
#               append commands "specifyClockTree -file $spec\n"
#            }
#         } else {
#            append commands "createClockTreeSpec\n"
#            if {[info exists vars(cts_cells)]} {
#              append commands "specifyClockTree -update \"AutoCTSRootPin * Buffer \[list $vars(cts_cells)\]\"\n"
#            }
#         }
#         if {[info exists vars(route_clock_nets)] && $vars(route_clock_nets)} {
#            append commands "specifyClockTree -update \"AutoCTSRootPin * RouteClkNet YES\"\n"
#         }
   
         set command "ckCloneGate -timingDriven -forceReconvergent\n"
         append commands [FF::wrap_command $vars(step),ck_clone_gate $command]
      }
      if {($vars(user_mode) == "hier") && $vars(enable_dlm)} {
         set ptn [file tail [pwd]]
         if {[info exists vars(partition_list)] && ([lsearch $vars(partition_list) $ptn] != -1)} {
            if {!$vars(black_box)} {
               if {[string compare -nocase $vars(dbs_format) "fe"]==0} {
                  set command "createInterfaceLogic -modelType timing -dir $ptn.ilm -hold\n"
               } else {
                  set command "createInterfaceLogic -modelType timing -cellview {$vars(oa_partition_lib) $ptn abstract}\n"
               }
            }
            append commands [FF::wrap_command $vars(step),create_ilm $command]
            set command "createInterfaceLogic -dir $ptn.flexilm -useType flexIlm -optStage preCTS\n"
            append commands [FF::wrap_command $vars(step),create_flex_ilm $command]
         }
      }

      if {$vars(codegen)} {
         return $commands
      } else {
          uplevel #0 eval $commands
      }
   }

   proc run_cts {{format 1}} {
      global vars
      global errors

      if {$vars(skip_cts)} {
         return ""
      }

      set vars(step) cts
      set commands ""
      set ucomments ""
#      append commands "set vars(step) $vars(step)\n"

      #########################################################################
      # Initialize step ...
      #########################################################################

      set command [FF_EDI::initialize_step cts]
      append commands [FF_EDI::insert_comments] 
      append commands [FF::wrap_command cts,initialize_step $command]

      if {$vars(top) && ($vars(user_mode) == "hier") && ($vars(hier_flow_type) == "2pass") && $vars(enable_dlm)} {
         set command ""
         foreach part $vars(partition_list) {
            if {[info exists vars($part,ilm_dir)] && ($vars(codegen) || [file isdirectory $vars($part,ilm_dir)])} {
               if {[lindex [split $vars(version) "."]  0] <= 10} {
                  append command "specifyIlm -cell $part -dir $vars($part,ilm_dir)\n"
               } else {
                 if {[string compare -nocase $vars(dbs_format) "oa"]==0} {
                     append command "specifyIlm -cell $part\n"
                  } else {
                     append command "specifyIlm -cell $part -dir $vars($part,ilm_dir)\n"
                  }
               }
            } else {
               if {[lindex [split $vars(version) "."]  0] <= 10} {
                  append command "specifyIlm -cell $part -dir ../$part/$part.ilm\n"
               } else {
                 if {[string compare -nocase $vars(dbs_format) "oa"]==0} {
                     append command "specifyIlm -cell $part\n"
                  } else {
                     append command "specifyIlm -cell $part -dir ../$part/$part.ilm\n"
                  }
               }
            }
         }
         if {$command != ""} {
            append commands [FF::wrap_command $vars(step),specify_ilm $command]
         }

         set command [FF_EDI::initialize_timing mmmc]
#         if {![info exists vars(cpf_file)] || ([info exists vars(cpf_file)] && !$vars(cpf_timing)) } {
            append commands [FF::wrap_command $vars(step),initialize_timing $command]
#         } else {
#            set defer_commands [FF::wrap_command $vars(step),initialize_timing $command] 
#         }
      }

      append commands "Puts \"<FF> RUNNING CLOCK TREE SYNTHESIS ...\"\n"

      if {$vars(verbose)} {
         append commands "#\n"
         append commands "# RUNNING CLOCK TREE SYNTHESIS\n"
         append commands "#\n"
      }

      #########################################################################
      # Load pre-CTS file (plug-in)
      #########################################################################
      if {$vars(cts_engine) == "cts"} {
         append commands [FF::source_plug pre_cts_tcl]
      }

      #########################################################################
      # Run CTS
      #------------------------------------------------------------------------
      # Generate the clock tree using clockDesign which:
      # - loads the clock specification file
      # - removes existing buffers in the clock tree (not marked don't touch);
      #   if a clock tree has been previously inserted, use changeClockStatus
      #   to unfix the tree so that it can be removed
      # - unfixes the clock nets after tree insertion
      # Need to make sure the clock gating cells are usable during clockDesign.
      # Disable them afterwards.
      #########################################################################

      set clock_gate_cells [list]
      set command ""
      if {[info exists vars(clock_gate_cells)]} {
         set clock_gate_cells $vars(clock_gate_cells)
         foreach cell $clock_gate_cells {
             append command "setDontUse $cell false\n"
         }
      }
      append commands [FF::wrap_command cts,enable_clock_gate_cells $command]

      #########################################################################
      # Run CTS
      #########################################################################

      set command ""
      if {[string tolower $vars(cts_engine)] == "cts"} {
         if {[info exists vars(cts_tcl)]} {
            if {[file exists $vars(cts_tcl)]} {
               append commands [FF::source_plug cts_tcl]
            } else {
               set errors($vars(error_count)) "Plug-in vars(cts_tcl) defined but the file does not exist"
               incr vars(error_count)
#               set vars(abort) 1
            }
         } else {
            if {[info exists vars(cts_spec)]} {
               append command "cleanupSpecifyClockTree\n"
               foreach spec $vars(cts_spec) {
                  append command "specifyClockTree -file $spec\n"
               }
            } else {
               if {!$vars(ilm)} { 
                  append command "createClockTreeSpec\n"
                  if {[info exists vars(cts_cells)]} {
                       append command "specifyClockTree -update \"AutoCTSRootPin * Buffer $vars(cts_cells)\"\n"
                  }
               }
            }
            if {[info exists vars(route_clock_nets)] && $vars(route_clock_nets)} {
              append command "specifyClockTree -update \"AutoCTSRootPin * RouteClkNet YES\"\n"
            }
            append commands [FF::wrap_command cts,create_clock_tree_spec $command]
            set command ""
            if {$vars(update_io_latency)} {
               append command "clockDesign -skipTimeDesign -updateIoLatency -outDir $vars(rpt_dir)\n"
            } else {
               append command "clockDesign -skipTimeDesign -outDir $vars(rpt_dir)\n"
            }
            append commands [FF::wrap_command cts,clock_design $command]
         }
         set command ""
         foreach cell $clock_gate_cells {
            append command "setDontUse $cell true\n"
         }
         append commands [FF::wrap_command cts,disable_clock_gate_cells $command]

         #########################################################################
         # Run ckECO if requested
         #########################################################################

         if {[info exists vars(clock_eco)] && (($vars(clock_eco) == "post_cts") || ($vars(clock_eco) == "both"))} {
            set command [FF_EDI::run_clock_eco post_cts]
            append commands [FF::wrap_command cts,run_clock_eco $command]
         }

         #########################################################################
         # Update timing based on vars(<mode>,incr_cts_sdc) and
         # vars(<mode>,post_cts_sdc)
         #########################################################################

         if {$vars(flow) == "mmmc"} {
            set command [FF_EDI::update_timing mmmc]
            append commands [FF::wrap_command cts,update_timing $command]
            set command [FF_EDI::derate_timing mmmc]
            append commands [FF::wrap_command $vars(step),derate_timing $command]
         } else {
            set command [FF_EDI::update_timing minmax]
            append commands [FF::wrap_command cts,update_timing $command]
            set command [FF_EDI::derate_timing minmax]
            append commands [FF::wrap_command $vars(step),derate_timing $command]
         }
         if {$vars(ilm) && [info exists vars(ilm_non_sdc_file)]} {
            if {[file exists $vars(ilm_non_sdc_file)]} {
               if {[lindex [split $vars(version) "."]  0] <= 10} {
                  set command "loadTimingCon -ilmNonSdcFile $vars(ilm_non_sdc_file)\n"
               } else {
                  set command "setIlmNonSdcConstraintFile $vars(ilm_non_sdc_file)\n"
               }
               append commands [FF::wrap_command $var(step),load_ilm_non_sdc_file $command]
            }
         }
      } else {
         #########################################################################
         # Run ccoptDesign ... convert to propagated timing first in scripted integration
         #########################################################################
         if {[info exists vars(cts_tcl)]} {
            if {[file exists $vars(cts_tcl)]} {
               append commands [FF::source_plug pre_cts_tcl]
               append commands [FF::source_plug cts_tcl]
            } else {
               set errors($vars(error_count)) "Plug-in vars(cts_tcl) defined but the file does not exist"
               incr vars(error_count)
            }
         } else {
            set is_native [expr {$vars(ccopt_integration) == "native"}]
            set command [FF_EDI::update_timing mmmc [expr !$is_native]]
            append commands [FF::wrap_command cts,update_timing $command]
            set command [FF_EDI::derate_timing mmmc]
            append commands [FF::wrap_command $vars(step),derate_timing $command]
            append commands "saveDesign $vars(dbs_dir)/pre_ccopt.enc -compress\n"
            append commands [FF::source_plug pre_cts_tcl]

            # Create a CCOpt clock tree spec if running with native integration
            if {$vars(cts_engine) == "ccopt"} {
               set ccoptCommand "ccoptDesign"
            } else {
               set ccoptCommand "ccoptDesign -cts"
            }

            if {$is_native} {
               if {$vars(cts_engine) == "ccopt_cts" && [info exists vars(cts_spec)]} {
                  append ccoptCommand " -ckSpec"
               } else {
                  set command "create_ccopt_clock_tree_spec -immediate\n"
                  append commands [FF::wrap_command cts,create_ccopt_clock_tree_spec $command]
               }
            }

            append ccoptCommand "\n"
            append commands [FF::wrap_command cts,ccopt_design $ccoptCommand]
         }
      }

      #########################################################################
      # Load optional post CTS file (plug-in)
      #########################################################################

      append commands [FF::source_plug post_cts_tcl 0]

      #########################################################################
      # Reset clock gating cell usage
      #########################################################################
      ###############################################################################
      # Check post-cts timing
      ###############################################################################
      if {![info exists vars(time_design_options,setup)]} {
         set command "timeDesign -postcts -prefix cts -outDir $vars(rpt_dir)\n"
      } else {
         set command [format "timeDesign -postcts -prefix cts -outDir $vars(rpt_dir) %s\n" $vars(time_design_options,setup)]
      }
      append commands [FF::wrap_command cts,time_design $command]

      if {$vars(hier_flow_type) == "2pass"} {
         set ptn [file tail [pwd]]
         if {[info exists vars(partition_list)] && ([lsearch $vars(partition_list) $ptn] != -1)} {
            if {[string compare -nocase $vars(dbs_format) "fe"]==0} {
               set command "createInterfaceLogic -modelType timing -dir $ptn.ilm -hold\n"
            } else {
               if {[lindex [split $vars(version) "."]  0] > 10} {
                  set command "createInterfaceLogic -modelType timing -cellview {$vars(oa_partition_lib) $ptn abstract}\n"
               } else {
                  set command "createInterfaceLogic -modelType timing -dir $ptn.ilm -hold\n"
               }
            }
            append commands [FF::wrap_command $vars(step),create_ilm $command]
         }
      }

      if {$vars(codegen)} {
         return $commands
      } else {
          uplevel #0 eval $commands
      }
   }

   proc run_postcts {{format 1}} {

      global vars
      global env
      global errors

      if {$vars(skip_cts)} {
         return ""
      }

      set vars(step) postcts
      set commands ""
#      append commands "set vars(step) $vars(step)\n"
 
      #########################################################################
      # Initialize step ...
      #########################################################################

      set command [FF_EDI::initialize_step postcts]
      append commands [FF_EDI::insert_comments] 
      append commands [FF::wrap_command postcts,initialize_step $command]

      ###############################################################################
      # Specify the ILM models for the top partition (only for 2pass flow)
      ###############################################################################
      if {$vars(top) && ($vars(user_mode) == "hier") && ($vars(hier_flow_type) == "2pass") && !$vars(enable_dlm)} {
#         if {!$(vars(black_box)} { 
            set command ""
            foreach part $vars(partition_list) {
               if {[info exists vars($part,ilm_dir)] && ($vars(codegen) || [file isdirectory $vars($part,ilm_dir)])} {
                  if {[lindex [split $vars(version) "."]  0] <= 10} {
                     append command "specifyIlm -cell $part -dir $vars($part,ilm_dir)\n"
                  } else {
                    if {[string compare -nocase $vars(dbs_format) "oa"]==0} {
                        append command "specifyIlm -cell $part\n"
                     } else {
                        append command "specifyIlm -cell $part -dir $vars($part,ilm_dir)\n"
                     }
                  }
               } else {
                  if {[lindex [split $vars(version) "."]  0] <= 10} {
                     append command "specifyIlm -cell $part -dir ../$part/$part.ilm\n"
                  } else {
                    if {[string compare -nocase $vars(dbs_format) "oa"]==0} {
                        append command "specifyIlm -cell $part\n"
                     } else {
                        append command "specifyIlm -cell $part -dir ../$part/$part.ilm\n"
                     }
                  }
               }
            }
            if {$command != ""} {
               append commands [FF::wrap_command $vars(step),specify_ilm $command]
            }
            if {$vars(flow) == "mmmc"} {
               set command [FF_EDI::update_timing mmmc]
               append commands [FF::wrap_command postcts,update_timing $command]
               set command [FF_EDI::derate_timing mmmc]
               append commands [FF::wrap_command $vars(step),derate_timing $command]
            } else {
               set command [FF_EDI::update_timing minmax]
               append commands [FF::wrap_command postcts,update_timing $command]
               set command [FF_EDI::derate_timing minmax]
               append commands [FF::wrap_command $vars(step),derate_timing $command]
            }
            if {$vars(ilm) && [info exists vars(ilm_non_sdc_file)]} {
               if {[file exists $vars(ilm_non_sdc_file)]} {
                  if {[lindex [split $vars(version) "."]  0] <= 10} {
                     set command "loadTimingCon -ilmNonSdcFile $vars(ilm_non_sdc_file)\n"
                  } else {
                     set command "setIlmNonSdcConstraintFile $vars(ilm_non_sdc_file)\n"
                  }
                  append commands [FF::wrap_command $var(step),load_ilm_non_sdc_file $command]
               }
            }
#         }

#         set command [FF_EDI::initialize_timing mmmc]
#         if {![info exists vars(cpf_file)]} {
#            append commands [FF::wrap_command $vars(step),initialize_timing $command]
#         } else {
#            set defer_commands [FF::wrap_command $vars(step),initialize_timing $command] 
#         }
      }

      append commands "Puts \"<FF> RUNNING POST-CTS OPTIMIZATION ...\"\n"

      if {$vars(verbose)} {
         append commands "#\n"
         append commands "# RUNNING POST-CTS OPTIMIZATION\n"
         append commands "#\n"
      }

      #########################################################################
      # Load optional pre postCTS file (plug-in)
      #########################################################################

      append commands [FF::source_plug pre_postcts_tcl]

      if {$vars(cts_engine) == "ccopt" && $vars(ccopt_integration) == "native"} {
         set command "Puts \"<FF> NO POST-CTS OPTIMIZATION REQUIRED FOR CCOPT NATIVE INTEGRATION\"\n"
         append commands [FF::wrap_command postcts,opt_design $command]
      } else {
         #########################################################################
         # Run post-CTS optimization
         #########################################################################
         
         set command "optDesign -postCTS -outDir $vars(rpt_dir) -prefix postcts\n"
         append commands [FF::wrap_command postcts,opt_design $command]
      }
         
      #########################################################################
      # Load optional post postCTS file (plug-in)
      #########################################################################

      append commands [FF::source_plug post_postcts_tcl 0]
      if {$vars(codegen)} {
         return $commands
      } else {
          uplevel #0 eval $commands
      }
   }

   proc run_postcts_hold {{format 1}} {

      global vars
      global env
      global errors

      if {$vars(skip_cts) || ([lsearch $vars(fix_hold) postcts] < 0)} {
         return ""
      }

      set vars(step) postcts_hold
      set commands "" 
#      append commands "set vars(step) $vars(step)\n"

      #########################################################################
      # Initialize step ...
      #########################################################################

      set command [FF_EDI::initialize_step postcts_hold]
      append commands [FF_EDI::insert_comments] 
      append commands [FF::wrap_command postcts_hold,initialize_step $command]

      append commands "Puts \"<FF> RUNNING POST-CTS HOLD FIXING ...\"\n"

      if {$vars(verbose)} {
         append commands "#\n"
         append commands "# RUNNING POST-CTS HOLD FIXING\n"
         append commands "#\n"
      }

      #########################################################################
      # Load pre-postCTS hold file (plug-in)
      #########################################################################

      append commands [FF::source_plug pre_postcts_hold_tcl]

      set command "optDesign -postCTS -hold -outDir $vars(rpt_dir) -prefix postcts_hold\n"
      append commands [FF::wrap_command postcts_hold,opt_design $command]

      #########################################################################
      # Load post-postCTS hold file (plug-in)
      #########################################################################

      append commands [FF::source_plug post_postcts_hold_tcl 0]

      if {$vars(codegen)} {
         return $commands
      } else {
          uplevel #0 eval $commands
      }
   }

   proc run_route {{format 1}} {

      global vars
      global env
      global errors

      set vars(step) route
      set commands ""
#      append commands "set vars(step) $vars(step)\n"

      #########################################################################
      # Initialize step ...
      #########################################################################

      set command [FF_EDI::initialize_step route]
      append commands [FF_EDI::insert_comments] 
      append commands [FF::wrap_command route,initialize_step $command]
      set command [FF_EDI::add_filler_cells]
      append commands [FF::wrap_command route,add_filler_cells $command]

      append commands "Puts \"<FF> RUNNING GLOBAL/DETAIL ROUTING ...\"\n"

      if {$vars(verbose)} {
         append commands "#\n"
         append commands "# RUNNING GLOBAL/DETAIL ROUTING\n"
         append commands "#\n"
      }

      #########################################################################
      # Load optional pre route file (plug-in)
      #########################################################################

      append commands [FF::source_plug pre_route_tcl]

      set command [FF_EDI::route_secondary_pg_nets]
      append commands [FF::wrap_command route,route_secondary_pg_nets $command]

      set command "checkPlace $vars(rpt_dir)/$vars(step),check_place.rpt\n"
      append commands [FF::wrap_command route,check_place $command]

      #########################################################################
      # Route the design
      #########################################################################

      set command ""
      set args ""
      if {($vars(enable_ocv) == "pre_postroute") || ($vars(enable_ocv) == "pre_postcts")} {
#         if {$vars(flow) != "default"} {
            append comments "# - vars(enable_ocv)\n"
            append args "-analysisType onChipVariation "
#         }
         if {$vars(enable_aocv)} {
            append comments "# - vars(enable_aocv)\n"
            append args "-aocv true "
         } else {
            append ucomments "# - vars(enable_aocv)\n"
         }
      } else {
         append ucomments "# - vars(enable_ocv) \"pre_postroute\"\n"
         append ucomments "# - vars(enable_aocv) \"true\"\n"
      }
      if {$args != ""} {
         set command "setAnalysisMode $args\n"
         append commands [FF::wrap_command route_design,set_analysis_mode $command]
      }
      set command "routeDesign\n"
      append commands [FF::wrap_command route,route_design $command]

      #########################################################################
      # Run ckECO if requested
      #########################################################################

      if {[info exists vars(clock_eco)] && (($vars(clock_eco) == "post_route") || ($vars(clock_eco) == "both"))} {
         set command [FF_EDI::run_clock_eco post_route]
         append commands [FF::wrap_command route,run_clock_eco $command]
      }

      #########################################################################
      # Optionally run wire spreading
      #########################################################################

      if {$vars(postroute_spread_wires)} {
         set command "setNanoRouteMode -droutePostRouteSpreadWire true -routeWithTimingDriven false\n"
         append command "routeDesign -wireOpt\n"
         append command "setNanoRouteMode -droutePostRouteSpreadWire false\n"
         append commands [FF::wrap_command route,spread_wires $command]
      }

      #########################################################################
      # Optionally run LPA
      #########################################################################

      if {$vars(verify_litho)} {
         file mkdir $vars(rpt_dir)/LPA/DMC
         set command "verifyLitho -routingLayersOnly -techFile $vars(lpa_tech_file) -dir $vars(rpt_dir)/LPA\n"
         append command "violationBrowser -all -no_display_false\n"
         append command "loadViolationReport -type CDNLitho -filename $vars(rpt_dir)/LPA/DMC/merged.hif\n"
         append commands [FF::wrap_command route,verify_litho $command]
      }

      #########################################################################
      # Set extraction mode to postroute
      #########################################################################
      set command "setExtractRCMode -engine postRoute"
      if {![catch {set arg $vars(postroute_extraction_effort)}]} {
         append comments "# - vars(postroute_extraction_effort)\n"
         append command " -effortLevel $arg"
      } else {
         append ucomments "# - vars(postroute_extraction_effort)\n"
      }
      if {![catch {set arg $vars(total_c_thresh)}]} {
         append comments "# - vars(total_c_thresh)\n"
         append command " -total_c_th $arg"
      } else {
         append ucomments "# - vars(total_c_thresh)\n"
      }
      if {![catch {set arg $vars(relative_c_thresh)}]} {
         append comments "# - vars(relative_c_thresh)\n"
         append command " -relative_c_th $arg"
      } else {
         append ucomments "# - vars(relative_c_thresh)\n"
      }
      if {![catch {set arg $vars(coupling_c_thresh)}]} {
         append comments "# - vars(coupling_c_thresh)\n"
         append command " -coupling_c_th $arg"
      } else {
         append ucomments "# - vars(relative_c_thresh)\n"
      }
      if {![catch {set arg $vars(qrc_layer_map)}]} {
         append comments "# - vars(qrc_layer_map)\n"
         append command " -lefTechFileMap $arg"
      } else {
         append ucomments "# - vars(qrc_layer_map)\n"
      }
      append command "\n"
      append commands [FF::wrap_command route,set_extract_rc_mode $command]

      #########################################################################
      # Load optional post route file (plug-in)
      #########################################################################

      append commands [FF::source_plug post_route_tcl 0]

      #########################################################################
      # Update to MMMC if flow is "pr_mmmc"
      #########################################################################

      if {$vars(flow) != "default"} {
         if {$vars(flow) == "pr_mmmc"} {
            set command [FF_EDI::initialize_timing mmmc]
            append commands [FF::wrap_command route,initialize_timing $command]
         }
      }

      if {![info exists vars(time_design_options,setup)]} {
         set command "timeDesign -postroute -prefix route -outDir $vars(rpt_dir)\n"
      } else {
         set command [format "timeDesign -postroute -prefix route -outDir $vars(rpt_dir) %s\n" $vars(time_design_options,setup)]
      }
      append commands [FF::wrap_command route,time_design $command]

      if {$vars(codegen)} {
         return $commands
      } else {
          uplevel #0 eval $commands
      }
   }

   proc run_postroute {{format 1}} {

      global vars
      global env
      global errors

      set vars(step) postroute
      set commands  ""
#      append commands "set vars(step) $vars(step)\n"

      #########################################################################
      # Initialize step ...
      #########################################################################

      set command [FF_EDI::initialize_step postroute]
      append commands [FF_EDI::insert_comments] 
      append commands [FF::wrap_command postroute,initialize_step $command]

      if {$vars(metalfill) == "pre_postroute"} {
         set command [FF::source_plug metalfill_tcl]
         append commands [FF::wrap_command postroute,add_metalfill $command]
      }

      #########################################################################
      # Run ckECO if requested
      #########################################################################

      if {[info exists vars(clock_eco)] && (($vars(clock_eco) == "post_route") || ($vars(clock_eco) == "both"))} {
         set command [FF_EDI::run_clock_eco post_route]
         append commands "Puts \"<FF> RUNNING POST-ROUTE CLOCK ECO ...\"\n"
         append commands [FF::wrap_command route,run_clock_eco $command]
      }

      append commands "Puts \"<FF> RUNNING POST-ROUTE OPTIMIZATION ...\"\n"

      if {$vars(verbose)} {
         append commands "#\n"
         append commands "# RUNNING POST-ROUTE OPTIMIZATION\n"
         append commands "#\n"
      }

      #########################################################################
      # Load optional pre postroute file (plug-in)
      #########################################################################

      append commands [FF::source_plug pre_postroute_tcl]
      if {$vars(high_timing_effort) && [regexp "9.1" $vars(version)]} {
         append commands "optLeakagePower -fixTimingOnly\n"
      }
      set command [FF_EDI::delete_filler_cells]
      append commands [FF::wrap_command postroute,delete_filler_cells $command]
      set command "optDesign -postRoute -outDir $vars(rpt_dir) -prefix postroute\n"
      append commands [FF::wrap_command postroute,opt_design $command]
      set command [FF_EDI::add_filler_cells]
      append commands [FF::wrap_command postroute,add_filler_cells $command]

      #########################################################################
      # Trim metal fill if added
      #########################################################################

      if {$vars(metalfill) == "pre_postroute"} {
         set command "trimMetalFill\n"
         append commands [FF::wrap_command postroute,trim_metalfill $command]
      }

      #########################################################################
      # Optionally run LPA
      #########################################################################

      if {$vars(verify_litho)} {
         # BCL: Added subst to handle dererencing variables
         file mkdir [subst $vars(rpt_dir)]/LPA/DMC
         set command "verifyLitho -routingLayersOnly -techFile $vars(lpa_tech_file) -dir $vars(rpt_dir)/LPA\n"
         append command "violationBrowser -all -no_display_false\n"
         append command "loadViolationReport -type CDNLitho -filename $vars(rpt_dir)/LPA/DMC/merged.hif\n"
         append commands [FF::wrap_command route,verify_litho $command]
      }

      #########################################################################
      # Load optional post postRoute file (plug-in)
      #########################################################################

      append commands [FF::source_plug post_postroute_tcl 0]

      if {$vars(codegen)} {
         return $commands
      } else {
          uplevel #0 eval $commands
      }
   }

   proc run_postroute_hold {{format 1}} {

      global vars
      global env
      global errors

      if {[lsearch $vars(fix_hold) postroute] < 0} {
         return ""
      }

      #########################################################################
      # Initialize step ...
      #########################################################################

      set vars(step) postroute_hold
      set commands ""
#      append commands "set vars(step) $vars(step)\n"

      set command [FF_EDI::initialize_step postroute_hold]
      append commands [FF_EDI::insert_comments] 
      append commands [FF::wrap_command postroute_hold,initialize_step $command]

      append commands "Puts \"<FF> RUNNING POST-ROUTE HOLD FIXING ...\"\n"

      if {$vars(verbose)} {
         append commands "#\n"
         append commands "# RUNNING POST-ROUTE HOLD FIXING\n"
         append commands "#\n"
      }

      #########################################################################
      # Load optional pre postRoute hold file (plug-in)
      #########################################################################

      append commands [FF::source_plug pre_postroute_hold_tcl]
      set command [FF_EDI::delete_filler_cells]
      append commands [FF::wrap_command postroute_hold,delete_filler_cells $command]
      set command "optDesign -postRoute -hold"
      append command " -outDir $vars(rpt_dir) -prefix postroute_hold\n"
      append commands [FF::wrap_command postroute_hold,opt_design $command]
      set command [FF_EDI::add_filler_cells]
      append commands [FF::wrap_command postroute_hold,add_filler_cells $command]

      #########################################################################
      # Trim metal fill if added
      #########################################################################

      if {$vars(metalfill) == "pre_postroute"} {
         set command "trimMetalFill\n"
         append commands [FF::wrap_command postroute_hold,trim_metalfill $command]
      }

      #########################################################################
      # Optionally run LPA
      #########################################################################

      if {$vars(verify_litho)} {
         # BCL: Added subst to handle dererencing variables
         file mkdir  [subst $vars(rpt_dir)]/LPA/DMC
         set command "verifyLitho -routingLayersOnly -techFile $vars(lpa_tech_file) -dir $vars(rpt_dir)/LPA\n"
         append command "violationBrowser -all -no_display_false\n"
         append command "loadViolationReport -type CDNLitho -filename $vars(rpt_dir)/LPA/DMC/merged.hif\n"
         append commands [FF::wrap_command route,verify_litho $command]
      }

      #########################################################################
      # Load optional post postRoute hold file (plug-in)
      #########################################################################

      append commands [FF::source_plug post_postroute_hold_tcl 0]

      if {$vars(codegen)} {
         return $commands
      } else {
          uplevel #0 eval $commands
      }
   }

   proc run_postroute_si_hold {{format 1}} {

      global vars
      global env
      global errors

      if {[lsearch $vars(fix_hold) postroute_si] < 0} {
         return ""
      }

      set vars(step) postroute_si_hold
      set commands ""
#      append commands "set vars(step) $vars(step)\n"

      #########################################################################
      # Initialize step ...
      #########################################################################

      set command [FF_EDI::initialize_step postroute_si_hold]
      append commands [FF_EDI::insert_comments] 
      append commands [FF::wrap_command postroute_si_hold,initialize_step $command]

      append commands "Puts \"<FF> RUNNING POST-ROUTE SI-AWARE HOLD FIXING ...\"\n"

      if {$vars(verbose)} {
         append commands "#\n"
         append commands "# RUNNING POST-ROUTE SI AWARE HOLD FIXING\n"
         append commands "#\n"
      }

      #########################################################################
      # Force celtic based SI delay calculation
      #########################################################################

      set command "setDelayCalMode -engine signalStorm -siAware false\n"
      append commands [FF::wrap_command postroute_si_hold,set_delay_cal_mode $command]

      #########################################################################
      # Load pre-postRoute SI hold file (plug-in)
      #########################################################################

      append commands [FF::source_plug pre_postroute_si_hold_tcl]

      #########################################################################
      # Load optional metalfill plug-in
      #########################################################################

      if {$vars(metalfill) == "pre_postroute_si"} {
         set command [FF::source_plug metalfill_tcl]
         append commands [FF::wrap_command postroute_si_hold,add_metalfill $command]
      }

      #########################################################################
      # Run postroute SI hold fixing
      #########################################################################

      set command [FF_EDI::delete_filler_cells]
      append commands [FF::wrap_command postroute_si_hold,delete_filler_cells $command]
      set command "optDesign -postRoute -si -hold"
      append command " -outDir $vars(rpt_dir) -prefix postroute_si_hold\n"
      append commands [FF::wrap_command postroute_si_hold,opt_design $command]
      set command [FF_EDI::add_filler_cells]
      append commands [FF::wrap_command postroute_si_hold,add_filler_cells $command]

      #########################################################################
      # Trim metal fill if added
      #########################################################################

      if {($vars(metalfill) == "pre_postroute") ||
          ($vars(metalfill) == "pre_postroute_si")} {
         set command "trimMetalFill\n"
         append commands [FF::wrap_command postroute_si_hold,trim_metalfill $command]
      }

      #########################################################################
      # Optionally run LPA
      #########################################################################

      if {$vars(verify_litho)} {
         # BCL: Added subst to handle dererencing variables
         file mkdir  [subst $vars(rpt_dir)]/LPA/DMC
         set command "verifyLitho -routingLayersOnly -techFile $vars(lpa_tech_file) -dir $vars(rpt_dir)/LPA\n"
         append command "violationBrowser -all -no_display_false\n"
         append command "loadViolationReport -type CDNLitho -filename $vars(rpt_dir)/LPA/DMC/merged.hif\n"
         append commands [FF::wrap_command route,verify_litho $command]
      }

      #########################################################################
      # Load optional post postRoute SI hold file (plug-in)
      #########################################################################

      append commands [FF::source_plug post_postroute_si_hold_tcl 0]

      if {$vars(codegen)} {
         return $commands
      } else {
          uplevel #0 eval $commands
      }
   }

   proc run_postroute_si {{format 1}} {

      global vars
      global env
      global errors

      set vars(step) postroute_si
      set commands ""
#      append commands "set vars(step) $vars(step)\n"

      #########################################################################
      # Initialize step ...
      #########################################################################

      set command [FF_EDI::initialize_step postroute_si]
      append commands [FF_EDI::insert_comments] 
      append commands [FF::wrap_command postroute_si,initialize_step $command]

      #########################################################################
      # Force celtic based SI delay calculation
      #########################################################################

      set command "setDelayCalMode -engine signalStorm -siAware false\n"
      append commands [FF::wrap_command postroute_si,set_delay_cal_mode $command]

      #########################################################################
      # Load optional metalfill plug-in
      #########################################################################

      if {$vars(metalfill) == "pre_postroute_si"} {
         set command [FF::source_plug metalfill_tcl]
         append commands [FF::wrap_command postroute_si,add_metalfill $command]
      }

      append commands "Puts \"<FF> RUNNING POST-ROUTE SI-AWARE OPTIMIZATION ...\"\n"

      if {$vars(verbose)} {
         append commands "#\n"
         append commands "# RUNNING POST-ROUTE SI AWARE OPTIMIZATION\n"
         append commands "#\n"
      }

      #########################################################################
      # Load optional pre postRoute SI file (plug-in)
      #########################################################################

      append commands [FF::source_plug pre_postroute_si_tcl]

      #########################################################################
      # Run post route setup fixing w/SI
      #########################################################################

      set command [FF_EDI::delete_filler_cells]
      append commands [FF::wrap_command postroute_si,delete_filler_cells $command]
      set command "optDesign -postRoute -si"
      append command " -outDir $vars(rpt_dir) -prefix postroute_si\n"
      append commands [FF::wrap_command postroute_si,opt_design $command]
      set command [FF_EDI::add_filler_cells]
      append commands [FF::wrap_command postroute_si,add_filler_cells $command]

      #########################################################################
      # Trim metal fill if added
      #########################################################################

      if {($vars(metalfill) == "pre_postroute") ||
          ($vars(metalfill) == "pre_postroute_si")} {
         set command "trimMetalFill\n"
         append commands [FF::wrap_command postroute_si_hold,trim_metalfill $command]
      }

      #########################################################################
      # Optionally run LPA
      #########################################################################

      if {$vars(verify_litho)} {
         # BCL: Added subst to handle dererencing variables
         file mkdir [subst $vars(rpt_dir)]/LPA/DMC
         set command "verifyLitho -routingLayersOnly -techFile $vars(lpa_tech_file) -dir $vars(rpt_dir)/LPA\n"
         append command "violationBrowser -all -no_display_false\n"
         append command "loadViolationReport -type CDNLitho -filename $vars(rpt_dir)/LPA/DMC/merged.hif\n"
         append commands [FF::wrap_command route,verify_litho $command]
      }

      #########################################################################
      # Load optional post postRoute SI file (plug-in)
      #########################################################################

      append commands [FF::source_plug post_postroute_si_tcl 0]

      if {$vars(codegen)} {
         return $commands
      } else {
          uplevel #0 eval $commands
      }
   }

   proc run_signoff {{format 1}} {

      global vars
      global env
      global errors
      global env

      if {$vars(step) != "assemble"} {
         set vars(step) signoff
      }
      set commands ""

      ###############################################################################
      # Optionally verify/fix litho
      ###############################################################################
      if {$vars(fix_litho)} {
         # BCL: Added subst to handle dererencing variables
         file mkdir  [subst $vars(rpt_dir)]/LPA/DMC
         set command "loadViolationReport -type CDNLitho -filename $vars(rpt_dir)/LPA/DMC/merged.hif\n"
         append command "setNanoRouteMode -droutePostRouteLithoRepair true \\\n"
         append command "                 -drouteMinimizeTopologyChange true\n"
         append command "globalDetailRoute\n"
         append command "writeHif -file $vars(rpt_dir)/LPA/incr_verify.hif\n"
         append command "verifyLitho -signOff \\\n" 
         append command "            -dir $vars(dbs_dir)/LPA2 \\\n"
         append command "            -cpu $vars(local_cpus) \\\n"
         append command "            -config $vars(lpa_conf_file) \\\n"
         append command "            -incrCheck $vars(rpt_dir)/LPA/incr_verify.hif\n"
         append command "violationBrowser -all -no_display_false\n"
         append command "loadViolationReport -type CDNLitho -filename $vars(rpt_dir)/LPA2/DMC/merged.hif\n"

         append commands [FF::wrap_command signoff,fix_litho $command]
      }

      ###############################################################################
      # Load optional metalfill plug-in
      ###############################################################################
      if {$vars(metalfill) == "pre_signoff"} {
         set command [FF::source_plug metalfill_tcl]
         append commands [FF::wrap_command signoff,add_metalfill $command]
      }

      set command [FF_EDI::initialize_step signoff]
      append commands [FF_EDI::insert_comments] 
#      append commands [FF::wrap_command signoff,initialize_step $command]
      append commands $command

      ###############################################################################
      # Load optional pre signoff file (plug-in)
      ###############################################################################
      append commands [FF::source_plug pre_signoff_tcl]

      ###############################################################################
      # Run RC Extraction
      ###############################################################################

      append commands "Puts \"<FF> RUNNING FINAL SIGNOFF ...\"\n"

      if {$vars(verbose)} {
         append commands "#\n"
         append commands "# RUNNING FINAL SIGNOFF\n"
         append commands "#\n"
      }

      set command "extractRC\n"
      append commands [FF::wrap_command signoff,extract_rc $command]

      ###############################################################################
      # Dump SPEF for signoff STA
      ###############################################################################

      if {$vars(skip_signoff_checks)} {
         set command ""
         foreach corner $vars(rc_corners) {
         append command "rcOut -rc_corner $corner -spef $corner.spef.gz\n"
         }
      } else {
         set command "foreach corner \$vars(active_rc_corners) {\n"
         append command "   rcOut -rc_corner \$corner -spef \$corner.spef.gz\n"
         append command "}\n"
      } 
      append commands [FF::wrap_command signoff,dump_spef $command]

      if {[info exists vars(enable_signoff_eco)] && $vars(enable_signoff_eco)} {
         set command "signoffTimeDesign -reportOnly -noEcoDb\n"
         append commands [FF::wrap_command signoff,signoff_time_design $command]         
      } else {
         if {$vars(enable_si_aware)} {
            if {![info exists vars(time_design_options,setup)]} {
               set command "timeDesign -prefix signoff -signoff -reportOnly -outDir $vars(rpt_dir)\n"
            } else {
               set command [format "timeDesign -prefix signoff -signoff -reportOnly -outDir $vars(rpt_dir) %s\n" $vars(time_design_options,setup)]
            }
         } else {
            if {![info exists vars(time_design_options,setup)]} {
               set command "timeDesign -prefix signoff -signoff -si -reportOnly -outDir $vars(rpt_dir)\n"
            } else {
               set command [format "timeDesign -prefix signoff -signoff -si -reportOnly -outDir $vars(rpt_dir) %s\n" $vars(time_design_options,setup)]
            }
         }
         append commands [FF::wrap_command signoff,time_design_setup $command]
         if {$vars(enable_si_aware)} {
            if {![info exists vars(time_design_options,hold)]} {
               set command "timeDesign -prefix signoff -signoff -reportOnly -hold -outDir $vars(rpt_dir)\n"
            } else {
               set command [format "timeDesign -prefix signoff -signoff -reportOnly -hold -outDir $vars(rpt_dir) %s\n" $vars(time_design_options,hold)]
            }
         } else {
            if {![info exists vars(time_design_options,hold)]} {
               set command "timeDesign -prefix signoff -signoff -si -reportOnly -hold  -outDir $vars(rpt_dir)\n"
            } else {
               set command [format "timeDesign -prefix signoff -signoff -si -reportOnly -hold -outDir $vars(rpt_dir) %s\n" $vars(time_design_options,hold)]
            }
         }
         append commands [FF::wrap_command signoff,time_design_hold $command]
      }

      ###############################################################################
      # Dump GDS and/or OA data base
      ###############################################################################
      if {[info exists vars(gds_layer_map)]} {
         set command "streamOut $vars(design).gds.gz -mapFile $vars(gds_layer_map) "
         if {[info exists vars(gds_files)]} {
            append command "-merge { "
            foreach file $vars(gds_files) {
               if {[file exists $file]} {
                  append command "$file "
               } else {
                  puts  "<FF> WARNING: GDS FILE $file DOES NOT EXIST .... SKIPPING\n"
               }
            }
            append command "}"
         }
         append command "\n"
         append commands [FF::wrap_command signoff,stream_out $command]
      }
      if {[info exists vars(oasis_layer_map)]} {
         set command "oasisOut $vars(design).oasis.gz -mapFile $vars(oasis_layer_map) "
         if {[info exists vars(oasis_files)]} {
            append command "-merge { "
            foreach file $vars(oasis_files) {
               if {[file exists $file]} {
                  append command "$file "
               } else {
                  puts  "<FF> WARNING: OASIS FILE $file DOES NOT EXIST .... SKIPPING\n"
               }
            }
            append command "}"
         }
         append command "\n"
         append commands [FF::wrap_command signoff,oasis_out $command]
      }

#      if {([info exists vars(oa_ref_lib)] && ($vars(oa_ref_lib) != "")) &&
#          ([info exists vars(oa_design_lib)] && ($vars(oa_design_lib) != ""))} {
#         set command "saveOaDesign $vars(oa_design_lib) $vars(design) signoff\n"
#         append commands [FF::wrap_command signoff,save_oa_design $command]
#      }

      ###############################################################################
      # Dump Model for Top Level (Hierarchical Flow Only)
      ###############################################################################
      set ptn [file tail [pwd]]
      if {[info exists vars(partition_list)]} {
         if {([lsearch $vars(partition_list) $ptn] != -1)} {
            if {[string compare -nocase $vars(dbs_format) "fe"]==0} {
               set command "createInterfaceLogic -dir $ptn.ilm\n"
            } else {
               if {[lindex [split $vars(version) "."]  0] > 10} {
                  set command "createInterfaceLogic -cellview {$vars(oa_partition_lib) $ptn abstract}\n"
               } else {
                  set command "createInterfaceLogic -dir $ptn.ilm\n"
               }
            } 
            append commands [FF::wrap_command signoff,create_ilm $command]
         } elseif {$vars(step) != "assemble"} {
            append commands [FF::wrap_command signoff,unflattenIlm "unflattenIlm\n"]
         }
      }

      if {$vars(verbose)} {
         append commands "#\n"
         append commands "# RUNNING VERIFY COMMANDS\n"
         append commands "#\n"
      }

      ###############################################################################
      # Run verify commands
      ###############################################################################
      if {!([info exists vars(enable_signoff_eco)] && $vars(enable_signoff_eco))} {
         set command "summaryReport -outDir $vars(rpt_dir)\n"
         append commands [FF::wrap_command signoff,summary_report $command]
      }
      set command "verifyConnectivity -noAntenna\n"
      append commands [FF::wrap_command signoff,verify_connectivity $command]
      set command "[verify_geometry_command]\n"
      append commands [FF::wrap_command signoff,verify_geometry $command]
      set command "verifyMetalDensity\n"
      append commands [FF::wrap_command signoff,verify_metal_density $command]
      if {[info exists vars(partition_list)] && ([lsearch $vars(partition_list) $ptn] != -1)} {
         if {[string compare $vars(dbs_format) "fe"]==0} {
           set command "verifyProcessAntenna -leffile $ptn.antenna.lef\n"
         } else {
           set command "verifyProcessAntenna\n"
         # Not sure yet  how save_abstract  would be called- skip this for now.
         }
      } else {
         set command "verifyProcessAntenna\n"
      }
      append commands [FF::wrap_command signoff,verify_process_antenna $command]

      ###############################################################################
      # Load optional post signoff file (plug-in)
      ###############################################################################
      append commands [FF::source_plug post_signoff_tcl 0]

      if {$vars(codegen)} {
         return $commands
      } else {
          uplevel #0 eval $commands
      }

   }

   proc run_assemble {{format 1}} {

      global vars
      global errors
      global env

      set vars(step) assemble
      set commands ""
      append commands "set vars(step) $vars(step)\n"

      FF_EDI::initialize_step assemble

#      if {$vars(report_run_time)} {
#         append commands "set vars($vars(step),start_time) \[clock seconds\]\n"
#      }

      if {$vars(verbose)} {
         append commands "#\n"
         append commands "# ASSEMBLING DESIGN\n"
         append commands "#\n"
      }
      ###############################################################################
      # Load "pre assemble" plug-in script
      ###############################################################################
      append commands [FF::source_plug pre_assemble_tcl]

      ###############################################################################
      # Assemble the design
      ###############################################################################
      set vars(ilm) false
      set ilm_list [list]
      set pac_list [list]
      if {$vars(enable_pac)} {
         foreach part $vars(partition_list) {
            if {[info exists vars($part,pac_mode)]}  {
               if {$vars($part,pac_mode) == "ilm"} {
                  lappend ilm_list $part
               } else {
                  lappend pac_list $part
               }
            }
         }
      }
      if {[info exists vars(ilm_list)] && ($vars(ilm_list) != "")} {
         foreach ilm $vars(ilm_list) {
            if {([lsearch $ilm_list $ilm] == -1) && ([lsearch $pac_list $ilm] == -1)} {
               lappend ilm_list $ilm
            }
         }
      }
      if {$ilm_list != ""} {
         set vars(ilm) true 
      }

      # BCL: Added tail of subst of vars(dbs_dir)
      # Note - EDIFF Hierarchical flow is currently INCOMPATIBLE with FF dir structure
      # The following code appears to rely on vars(dbs_dir) always being under $vars(partition_dir)/$vars(design)
      # This needs to be reconciled

      if {$vars(hier_flow_type) == "2pass"} {
         set partition_dir $vars(partition_dir_pass2)
       } else {
         set partition_dir $vars(partition_dir)
      }
      set dir [file tail [subst $vars(dbs_dir)]]

      if {[lindex [split $vars(version) "."]  0] > 10} {
         set command [FF_EDI::initialize_timing mmmc]
         if {[info exists vars(cpf_file)] && $vars(cpf_timing)} {
            set mmmc_file $vars(script_dir)/incr_view_definition.tcl
          } else {
            set mmmc_file $vars(script_dir)/view_definition.tcl
          }
      }
      if {([string compare -nocase $vars(dbs_format) "oa"]==0) && ([lindex [split $vars(version) "."]  0] > 10)} {

         if {[info exists vars($vars(design),assemble_step)]} {
            set command "assembleDesign -topDesign {$vars(oa_partition_lib) $vars(design) $vars($vars(design),assemble_step)} -mmmcFile $mmmc_file"
         } else {
            set command "assembleDesign -topDesign {$vars(oa_partition_lib) $vars(design) signoff} -mmmcFile $mmmc_file"
         }
         foreach part $vars(partition_list) {
            if {[lsearch $ilm_list $part] == -1} {
               if {[info exists vars($part,assemble_step)]} {
                  append command "\\\n   -block {$vars(oa_partition_lib) $part $vars($vars($part),assemble_step)}"
               } else {
                  append command "\\\n   -block {$vars(oa_partition_lib) $part signoff}"
               }
            }
         }
      } else {
#         append commands [FF::wrap_command assemble,initialize_timing $command]
         if {[lindex [split $vars(version) "."]  0] > 10} {
            if {[info exists vars(cpf_file)] && $vars(cpf_timing)} {
               set assemble_command "assembleDesign -cpfFile $vars(cpf_file)"
            } else {
               set assemble_command "assembleDesign -mmmcFile $mmmc_file"
            }
         } else {
            set assemble_command "assembleDesign"
         }
         if {[info exists vars($vars(design),assemble_dbs)]} {
            set command "$assemble_command -fe -topDir $vars($vars(design),assemble_dbs)"
         } elseif {[info exists vars($vars(design),assemble_step)]} {
            set command "$assemble_command -fe $partition_dir/$vars(design)/$dir/$vars($vars(design),assemble_step).enc.dat"
         } else {
            set command "$assemble_command -fe -topDir $partition_dir/$vars(design)/$dir/signoff.enc.dat "
         }
         foreach part $vars(partition_list) {
            if {[lsearch $ilm_list $part] == -1} {
               if {[info exists vars($part,assemble_dbs)]} {
                  append command "\\\n   -blockDir $vars($part,assemble_dbs)"
               } elseif {[info exists vars($part,assemble_step)]} {
                  append command "\\\n   -blockDir $partition_dir/$part/$dir/$vars($part,assemble_step).enc.dat"
               } else {
                  append command "\\\n   -blockDir $partition_dir/$part/$dir/signoff.enc.dat"
               }
            }
         }
      }
      if {$vars(enable_pac)} {
         append command "\\\n -hierDir $vars(pac_scratch_dir)"
      }
      append command "\n\n"

      append commands [FF::wrap_command assemble,assemble_design $command]
      if {([lindex [split $vars(version) "."]  0] > 10) && $vars(cpf_timing)} {
         append commands "source $mmmc_file\n"
      }
      if {$vars(flow) == "mmmc"} {
         set command [FF_EDI::derate_timing mmmc]
         append commands [FF::wrap_command $vars(step),derate_timing $command]
      }

      append commands [FF::source_plug always_source_tcl]

      ###############################################################################
      # Load "post assemble" plug-in script
      ###############################################################################
      append commands [FF::source_plug post_assemble_tcl 0]

      ###############################################################################
      # Specify ILMs if defined
      ###############################################################################
      if {$vars(ilm)} {
         if {$vars(verbose)} {
            append commands "#\n"
            append commands "# SPECIFYING ILMs\n"
            append commands "#\n"
         }
         set command "" 
         foreach cell $ilm_list {
            if {[info exists vars($cell,ilm_dir)] && [file isdirectory $vars($cell,ilm_dir)]} {
               append command "specifyIlm -cell $cell -dir $vars($cell,ilm_dir)\n"
            } else {
               puts "<FF> WARNING: ILM DIRECTORY MISSING FOR $cell ... SKIPPING"
            }
         } 
  
         append commands [FF::wrap_command assemble,specify_ilm $command]
  
         if {[info exists vars(ilm_non_sdc_file)]} {
            if {[lindex [split $vars(version) "."]  0] <= 10} {
               set command "loadTimingCon -ilmNonSdcFile $vars(ilm_non_sdc_file)\n"
            } else {
               set command "setIlmNonSdcConstraintFile $vars(ilm_non_sdc_file)\n"
            }
            append commands [FF::wrap_command assemble,load_ilm_non_sdc_file $command]
         }
      }

#      if {[lindex [split $vars(version) "."]  0] <= 10} {
         if {[info exists vars(cpf_file)]} {
            set command "loadCPF $vars(cpf_file)\n"
            append commands [FF::wrap_command assemble,load_cpf $command]
            set command "commitCPF"
            if {$vars(cpf_keep_rows)} {
               append command " -keepRows"
            }
            if {$vars(cpf_power_domain)} {
               append command " -power_domain"
            }
            if {$vars(cpf_isolation)} {
               append command " -isolation"
            }
            if {$vars(cpf_state_retention)} {
               append command " -state_retention"
            }
            if {$vars(cpf_level_shifter)} {
               append command " -level_shifter"
            }
            if {$vars(cpf_power_switch)} {
               append command " -power_switch"
            }
            append command "\n"
            append commands [FF::wrap_command assemble,commit_cpf $command]
         }
#      }

      if {[lindex [split $vars(version) "."]  0] <= 10} {
         set command [FF_EDI::initialize_timing mmmc]
         append commands [FF::wrap_command assemble,initialize_timing $command]
      } elseif {[info exists vars(cpf_file)] && $vars(cpf_timing)} {
         set command [FF_EDI::initialize_timing mmmc]
         append commands [FF::wrap_command assemble,initialize_timing $command]
      }

      set command [FF_EDI::update_timing mmmc ]
      append commands [FF::wrap_command assemble,update_timing $command]

      if {[info exists vars(enable_signoff_eco)] && $vars(enable_signoff_eco)} {
         append commands [FF::source_plug pre_signoff_eco_tcl 0]
         set command "verifyConnectivity\n"
         append commands [FF::wrap_command assemble,pre_signoff_eco_verify_connectivity $command]
         set command "[verify_geometry_command]\n"
         append commands [FF::wrap_command assemble,pre_signoff_eco_verify_geometry $command]

         if {$vars(verbose)} {
            append commands "#\n"
            append commands "# RUNNING SIGN-OFF ECO\n"
            append commands "#\n"
         }

         # Ensure that the beta feature is enabled, if it exists
         append commands "catch {setBetaFeature encSignoffECO 1}\n"

         set command [FF_EDI::delete_filler_cells]
         append commands [FF::wrap_command assemble,delete_filler_cells $command]
         set command "extractRC\n"
         append commands [FF::wrap_command assemble,extract_rc $command]
         set command "signoffTimeDesign -reportOnly\n"
         append commands [FF::wrap_command assemble,signoff_time_design $command]
         set command "signoffOptDesign -setup -noEcoRoute\n"
         append commands [FF::wrap_command assemble,signoff_opt_design $command]
         set command "addFiller\n"
         append commands [FF::wrap_command assemble,add_filler_cells $command]
         set command "ecoRoute\n"
         append commands [FF::wrap_command assemble,eco_route $command]

         #########################################################################
         # Optionally run LPA
         #########################################################################
   
         if {$vars(verify_litho)} {
            # BCL: Added subst to handle dererencing variables
            file mkdir  [subst $vars(rpt_dir)]/LPA/DMC
            set command "verifyLitho -routingLayersOnly -techFile $vars(lpa_tech_file) -dir $vars(rpt_dir)/LPA\n"
            append command "violationBrowser -all -no_display_false\n"
            append command "loadViolationReport -type CDNLitho -filename $vars(rpt_dir)/LPA/DMC/merged.hif\n"
            append commands [FF::wrap_command route,verify_litho $command]
         }

         append commands [FF::source_plug post_signoff_eco_tcl 0]
         set command "verifyConnectivity\n"
         append commands [FF::wrap_command assemble,post_signoff_eco_verify_connectivity $command]
         set command "[verify_geometry_command]\n"
         append commands [FF::wrap_command assemble,post_signoff_eco_verify_geometry $command]
      } elseif {$vars(enable_pac)} {
         set command "verifyConnectivity\n"
         append commands [FF::wrap_command assemble,pre_pac_verify_connectivity $command]
         set command "[verify_geometry_command]\n"
         append commands [FF::wrap_command assemble,pre_pac_verify_geometry $command]

         if {$vars(verbose)} {
            append commands "#\n"
            append commands "# DEFINING PAC MODES\n"
            append commands "#\n"
         }
         append commands [FF::source_plug pre_pac_tcl 0]
         set command ""
         foreach part $pac_list {
               append command "set hinst \[dbHInstName \[dbCellHInst \[dbGetCellByName $part\]\]\]\n"
            if {[info exists vars($part,pac_mode)]} {
               if {$vars($part,pac_mode) == "read_only"} { set vars($part,pac_mode) "readOnly" }
               append command "setModuleView -hinst \$hinst -type $vars($part,pac_mode)\n"
            } 
         }

         append command "getModuleView\n"
         append commands [FF::wrap_command assemble,set_module_view $command]

         if {$vars(verbose)} {
            append commands "#\n"
            append commands "# RUNNING POST ASSEMBLY CLOSURE\n"
            append commands "#\n"
         }
         set command [FF_EDI::delete_filler_cells]
         append commands [FF::wrap_command assemble,delete_filler_cells $command]
         set command "optDesign -postRoute -outDir $vars(rpt_dir) -prefix pac\n"
         append commands [FF::wrap_command assemble,opt_design $command]
         set command [FF_EDI::add_filler_cells]
         append commands [FF::wrap_command assemble,add_filler_cells $command]

         #########################################################################
         # Optionally run LPA
         #########################################################################
   
         if {$vars(verify_litho)} {
            # BCL: Added subst to handle dererencing variables
            file mkdir  [subst $vars(rpt_dir)]/LPA/DMC
            set command "verifyLitho -routingLayersOnly -techFile $vars(lpa_tech_file) -dir $vars(rpt_dir)/LPA\n"
            append command "violationBrowser -all -no_display_false\n"
            append command "loadViolationReport -type CDNLitho -filename $vars(rpt_dir)/LPA/DMC/merged.hif\n"
            append commands [FF::wrap_command route,verify_litho $command]
         }

         append commands [FF::source_plug post_pac_tcl 0]
         set command "verifyConnectivity\n"
         append commands [FF::wrap_command assemble,post_pac_verify_connectivity $command]
         set command "[verify_geometry_command]\n"
         append commands [FF::wrap_command assemble,post_pac_verify_geometry $command]
      }

      if {!$vars(codegen)} {
         uplevel #0 eval $commands
         set commands "" 
      }

      append commands [FF_EDI::run_signoff $format]

#      if {$vars(makefile)} { 
#          append commands "if {\[info exists env(VPATH)\]} {\n"
#          append commands "exec /bin/touch \$env(VPATH)/assemble\n"
#          append commands "}\n"
#       }

      if {$vars(codegen)} {
         return $commands
      } else {
         uplevel #0 eval $commands
      }
   }

   proc run_rebudget {{format 1}} {

      global vars
      global errors
      global env

      set vars(step) rebudget
      set commands ""
#      append commands "set vars(step) $vars(step)\n"

      FF_EDI::initialize_step $vars(step)

#      if {$vars(report_run_time)} {
#         append commands "set vars($vars(step),start_time) \[clock seconds\]\n"
#      }
      if {!$vars(enable_dlm)} {
         append commands "\nif {\[file isfile $vars(pac_scratch_dir)/.pacFlowLock\]} {\n"
         append commands "   file delete $vars(pac_scratch_dir)/.pacFlowLock\n"
         append commands "}\n"
       } else {
#         append commands "if {\[file isfile $vars(script_dir)/view_definition.tcl]} {\n"
#         append commands "   file copy -force $vars(script_dir)/view_definition.tcl $vars(partition_dir)/$vars(design)/viewDefinition.tcl\n"
#         append commands "}\n"
       }

      if {$vars(verbose)} {
         append commands "#\n"
         append commands "# ASSEMBLING DESIGN\n"
         append commands "#\n"
      }
      ###############################################################################
      # Load "pre rebudget" plug-in script
      ###############################################################################
      append commands [FF::source_plug pre_rebudget_tcl]

      ###############################################################################
      # Get the FlexILM ECO paths
      ###############################################################################
      if {$vars(enable_dlm)} {
         append commands "if {\[file isfile \$env(VPATH)/flexilm\]} {\n"
         append commands "   source \$env(VPATH)/flexilm\n"
         append commands "}\n"
      }

      ###############################################################################
      # Assemble the design
      ###############################################################################
      set vars(ilm) false
      set ilm_list [list]
      set pac_list [list]
      if {$vars(enable_pac)} {
         foreach part $vars(partition_list) {
            if {[info exists vars($part,pac_mode)]}  {
               if {$vars($part,pac_mode) == "ilm"} {
                  lappend ilm_list $part
               } else {
                  lappend pac_list $part
               }
            }
         }
      }
      if {[info exists vars(ilm_list)] && ($vars(ilm_list) != "")} {
         foreach ilm $vars(ilm_list) {
            if {([lsearch $ilm_list $ilm] == -1) && ([lsearch $pac_list $ilm] == -1)} {
               lappend ilm_list $ilm
            }
         }
      }
      if {$ilm_list != ""} {
         set vars(ilm) true 
      }

      # BCL: Added tail of subst of vars(dbs_dir)
      # Note - EDIFF Hierarchical flow is currently INCOMPATIBLE with FF dir structure
      # The following code appears to rely on vars(dbs_dir) always being under $vars(partition_dir)/$vars(design)
      # This needs to be reconciled
      set dir [file tail [subst $vars(dbs_dir)]]

      if {[lindex [split $vars(version) "."]  0] > 10} {
         set command [FF_EDI::initialize_timing mmmc]
         if {[info exists vars(cpf_file)] && $vars(cpf_timing)} {
            set mmmc_file $vars(script_dir)/incr_view_definition.tcl
          } else {
            set mmmc_file $vars(script_dir)/view_definition.tcl
          }
      }
      if {([string compare -nocase $vars(dbs_format) "oa"]==0) && ([lindex [split $vars(version) "."]  0] > 10)} {

         if {[info exists vars($vars(design),rebudget_assemble_step)]} {
            set command "assembleDesign -topDesign {$vars(oa_partition_lib) $vars(design) $vars($vars(design),rebudget_assemble_step)} -mmmcFile $mmmc_file"
         } else {
            set command "assembleDesign -topDesign {$vars(oa_partition_lib) $vars(design) cts} -mmmcFile $mmmc_file"
         }
         foreach part $vars(partition_list) {
            if {[lsearch $ilm_list $part] == -1} {
               if {[info exists vars($part,rebudget_assemble_step)]} {
                  append command "\\\n   -block {$vars(oa_partition_lib) $part $vars($vars($part),rebudget_assemble_step)}"
               } else {
                  append command "\\\n   -block {$vars(oa_partition_lib) $part cts}"
               }
            }
         }
      } else {
#         append commands [FF::wrap_command rebudget,initialize_timing $command]
         if {[lindex [split $vars(version) "."]  0] > 10} {
            if {[info exists vars(cpf_file)] && $vars(cpf_timing)} {
               set assemble_command "assembleDesign -cpfFile $vars(cpf_file)"
            } else {
               set assemble_command "assembleDesign -mmmcFile $mmmc_file"
            }
         } else {
            set assemble_command "assembleDesign"
         }
         if {[info exists vars($vars(design),rebudget_assemble_dbs)]} {
            set command "$assemble_command -fe -topDir $vars($vars(design),rebudget_assemble_dbs)"
         } elseif {[info exists vars($vars(design),rebudget_assemble_step)]} {
            set command "$assemble_command -fe $vars(partition_dir)/$vars(design)/$dir/$vars($vars(design),rebudget_assemble_step).enc.dat"
         } else {
            if {$vars(enable_dlm)} {
#               set command "$assemble_command \\\n   -fe \\\n   -topDir $vars(partition_dir_pass2)/$vars(design) "
               set command "$assemble_command \\\n   -fe \\\n   -topDir $vars(partition_dir)_FLEXILM/$vars(design) "
            } else {
               set command "$assemble_command -fe -topDir $vars(partition_dir)/$vars(design)/$dir/cts.enc.dat "
            }
         }
         foreach part $vars(partition_list) {
            if {[lsearch $ilm_list $part] == -1} {
               if {[info exists vars($part,rebudget_assemble_dbs)]} {
                  append command "\\\n   -blockDir $vars($part,rebudget_assemble_dbs)"
               } elseif {[info exists vars($part,rebudget_assemble_step)]} {
                  append command "\\\n   -blockDir $vars(partition_dir)/$part/$dir/$vars($part,rebudget_assemble_step).enc.dat"
               } else {
                  if {$vars(enable_dlm)} {
                     append command "\\\n   -blockDir \$vars($part,cdtv) "
                  } else {
                     append command "\\\n   -blockDir $vars(partition_dir)/$part/$dir/cts.enc.dat"
                  }
               }
            }
         }
      }
      if {$vars(enable_pac)} {
         append command "\\\n -hierDir $vars(pac_scratch_dir)"
      }
      append command "\n"

      append commands [FF::wrap_command $vars(step),assemble_design $command]
      if {([lindex [split $vars(version) "."]  0] > 10) && $vars(cpf_timing)} {
         append commands "source $mmmc_file\n"
      }
      if {$vars(flow) == "mmmc"} {
         set command [FF_EDI::derate_timing mmmc]
         append commands [FF::wrap_command $vars(step),derate_timing $command]
      }

      append commands [FF::source_plug always_source_tcl]

      ###############################################################################
      # Load "post rebudget" plug-in script
      ###############################################################################
      append commands [FF::source_plug post_rebudget_tcl 0]

      ###############################################################################
      # Specify ILMs if defined
      ###############################################################################
      if {$vars(ilm)} {
         if {$vars(verbose)} {
            append commands "#\n"
            append commands "# SPECIFYING ILMs\n"
            append commands "#\n"
         }
         set command "" 
         foreach cell $ilm_list {
            if {[info exists vars($cell,ilm_dir)] && [file isdirectory $vars($cell,ilm_dir)]} {
               append command "specifyIlm -cell $cell -dir $vars($cell,ilm_dir)\n"
            } else {
               puts "<FF> WARNING: ILM DIRECTORY MISSING FOR $cell ... SKIPPING"
            }
         } 
  
         append commands [FF::wrap_command $vars(step),specify_ilm $command]
  
         if {[info exists vars(ilm_non_sdc_file)]} {
            if {[lindex [split $vars(version) "."]  0] <= 10} {
               set command "loadTimingCon -ilmNonSdcFile $vars(ilm_non_sdc_file)\n"
            } else {
               set command "setIlmNonSdcConstraintFile $vars(ilm_non_sdc_file)\n"
            }
            append commands [FF::wrap_command $vars(step),load_ilm_non_sdc_file $command]
         }
      }

#      if {[lindex [split $vars(version) "."]  0] <= 10} {
         if {[info exists vars(cpf_file)]} {
            set command "loadCPF $vars(cpf_file)\n"
            append commands [FF::wrap_command $vars(step),load_cpf $command]
            set command "commitCPF"
            if {$vars(cpf_keep_rows)} {
               append command " -keepRows"
            }
            if {$vars(cpf_power_domain)} {
               append command " -power_domain"
            }
            if {$vars(cpf_isolation)} {
               append command " -isolation"
            }
            if {$vars(cpf_state_retention)} {
               append command " -state_retention"
            }
            if {$vars(cpf_level_shifter)} {
               append command " -level_shifter"
            }
            if {$vars(cpf_power_switch)} {
               append command " -power_switch"
            }
            append command "\n"
            append commands [FF::wrap_command $vars(step),commit_cpf $command]
         }
#      }

      if {[lindex [split $vars(version) "."]  0] <= 10} {
         set command [FF_EDI::initialize_timing mmmc]
         append commands [FF::wrap_command $vars(step),initialize_timing $command]
      } elseif {[info exists vars(cpf_file)] && $vars(cpf_timing)} {
         set command [FF_EDI::initialize_timing mmmc]
         append commands [FF::wrap_command $vars(step),initialize_timing $command]
      }

      if {!$vars(enable_dlm)} {
         set command [FF_EDI::update_timing mmmc ]
         append commands [FF::wrap_command $vars(step),update_timing $command]
      }

      if {$vars(enable_pac)} {

         if {$vars(verbose)} {
            append commands "#\n"
            append commands "# DEFINING PAC MODES\n"
            append commands "#\n"
         }
         append commands [FF::source_plug pre_pac_tcl 0]
         set command ""
         foreach part $pac_list {
               append command "set hinst \[dbHInstName \[dbCellHInst \[dbGetCellByName $part\]\]\]\n"
            if {[info exists vars($part,pac_mode)]} {
               if {$vars($part,pac_mode) == "read_only"} { set vars($part,pac_mode) "readOnly" }
               append command "setModuleView -hinst \$hinst -type $vars($part,pac_mode)\n"
            } 
         }

         append command "getModuleView\n"
         append commands [FF::wrap_command $vars(step),set_module_view $command]

         if {!$vars(enable_dlm)} {
            if {$vars(verbose)} {
               append commands "#\n"
               append commands "# RUNNING POST ASSEMBLY CLOSURE\n"
               append commands "#\n"
            }
            set command "optDesign -postCTS -outDir $vars(rpt_dir) -prefix pac\n"
            append commands [FF::wrap_command $vars(step),opt_design $command]
   
            append commands [FF::source_plug post_pac_tcl 0]
         }
      }

      set command "setTrialRouteMode -handlePartitionComplex true -honorPin true\n"
      append command "trialRoute\n"
      append command "deriveTimingBudget -noTrialIPO -noConstantModel\n"
      append commands [FF::wrap_command $vars(step),derive_timing_budget $command]

      if {[string compare -nocase $vars(dbs_format) "oa"]==0} {
         if {[lindex [split $vars(version) "."]  0] > 10} {
            set command "saveDesign -cellview {$vars(oa_design_lib) $vars(design) budget}\n"
         } else {
            set command "saveOaDesign $vars(oa_design_lib) $vars(design) budget\n"
         }
      } else {
         set command "saveDesign $vars(dbs_dir)/budget.enc -compress\n"
      }
      append commands [FF::wrap_command $vars(step),save_budget_dbs $command]

      ###############################################################################
      # Partition and save the partitions into the
      # directory PARTITION
      ###############################################################################
#      append commands [FF::source_plug pre_partition_tcl]

#      set command "set ptngPtnTimingLibFormat lib\npartition -buildScan\n"
      set command "partition -buildScan\n"
      append commands [FF::wrap_command $vars(step),partition $command]
      if {[lindex [split $vars(version) "."]  0] > 10} {
         if {([string compare $vars(dbs_format) "oa"]==0)} {
            if {$vars(hier_flow_type) == "1pass"} {
               set command "savePartition -ptnLib $vars(oa_partition_lib) -dir $vars(partition_dir)\n"
            } else {
               set command "savePartition -ptnLib $vars(oa_partition_lib) -dir $vars(partition_dir_pass2)\n"
            }
         } else {
            if {$vars(hier_flow_type) == "1pass"} {
               set command "savePartition -dir $vars(partition_dir) -def -scanDef\n"
            } else {
               set command "savePartition -dir $vars(partition_dir_pass2) -def -scanDef\n"
            }
         }
      } else {
         set command "savePartition -dir $vars(partition_dir) -def -scanDef\n"
      }
      append commands [FF::wrap_command $vars(step),save_partition $command]
#      append commands [FF::source_plug post_partition_tcl]

      append commands "#---------------------------------------------------------------------\n"
      append commands "# <FF> GENERATING REPORTS\n"
      append commands "#---------------------------------------------------------------------\n"

      if {$vars(report_power)} {
         if {[info exists vars(power_analysis_view)] && ($vars(power_analysis_view) != "")} {
            set command "report_power -view $vars(power_analysis_view) -outfile $vars(rpt_dir)/$vars(step).power.rpt\n"
         } else {
            set command "report_power -outfile $vars(rpt_dir)/$vars(step).power.rpt\n"
         }
         append commands [FF::wrap_command $vars(step),report_power $command]
      }

      if {[FF::is_lp_flow] && [info exists vars(power_domains)] && [llength $vars(power_domains)] > 0} {

         ######################################################################
         # Verify power domain
         ######################################################################

         set command "verifyPowerDomain -bind -gconn"
         append command " -isoNetPD $vars(rpt_dir)/$vars(step).isonets.rpt"
         append command " -xNetPD $vars(rpt_dir)/$vars(step).xnets.rpt\n"

         append commands [FF::wrap_command $vars(step),verify_power_domain $command]

         ######################################################################
         # Run CLP
         ######################################################################

         if {$vars(run_clp) && ([auto_execok lec] != "")} {
            set command "runCLP "
            if {[info exists vars(clp_options)]} {
               append command $vars(clp_options)
            }
            append command "\n"
            append commands [FF::wrap_command $vars(step),run_clp $command]
         } else {
            if {![info exists vars(clp_warning)]} {
               puts "<FF> WARNING: UNABLE TO RUN CLP ... PLEASE MAKE SURE IT IS IN YOUR PATH"
               set vars(clp_warning) true
            }
         }
      }
      if {!$vars(codegen)} {
         uplevel #0 eval $commands
         set commands "" 
      }

#      if {$vars(makefile)} { 
          append commands "if {\[info exists env(VPATH)\]} {\n"
          append commands "exec /bin/touch \$env(VPATH)/$vars(step)\n"
          append commands "}\n"
#       }

#      if {$vars(enable_dlm)} {
#         append commands "# Copy Makefiles in case they get deleted during the flow ...\n"
#         foreach part [concat $vars(design) $vars(partition_list)] {
#            append commands "file copy -force $vars(script_dir)/$part.Makefile $vars(partition_dir_pass2)/$part/Makefile\n"
#         }
#         append commands "file copy -force $vars(partition_dir)/Makefile $vars(partition_dir_pass2)/Makefile\n"
#         append commands "file copy -force $vars(partition_dir)/Makefile.partition $vars(partition_dir_pass2)/Makefile.partition\n"
#      }

      if {$vars(codegen)} {
         return $commands
      } else {
         uplevel #0 eval $commands
      }
   }

   proc run_flexilm {{format 1}} {

      global vars
      global errors
      global env

      set vars(step) flexilm
      set commands ""
#      append commands "set vars(step) $vars(step)\n"

      FF_EDI::initialize_step flexilm

#      if {$vars(report_run_time)} {
#         append commands "set vars($vars(step),start_time) \[clock seconds\]\n"
#      }

      if {$vars(verbose)} {
         append commands "#\n"
         append commands "# RESTORING DESIGN\n"
         append commands "#\n"
      }
      ###############################################################################
      # Load "pre flexilm" plug-in script
      ###############################################################################
      append commands [FF::source_plug pre_flexilm_tcl]

      ###############################################################################
      # Restore the design
      ###############################################################################
      set vars(ilm) false
      set ilm_list [list]
      set pac_list [list]
      if {$vars(enable_pac)} {
         foreach part $vars(partition_list) {
            if {[info exists vars($part,pac_mode)]}  {
               if {$vars($part,pac_mode) == "ilm"} {
                  lappend ilm_list $part
               } else {
                  lappend pac_list $part
               }
            }
         }
      }
      if {[info exists vars(ilm_list)] && ($vars(ilm_list) != "")} {
         foreach ilm $vars(ilm_list) {
            if {([lsearch $ilm_list $ilm] == -1) && ([lsearch $pac_list $ilm] == -1)} {
               lappend ilm_list $ilm
            }
         }
      }
      if {$ilm_list != ""} {
         set vars(ilm) true 
      }

      # BCL: Added tail of subst of vars(dbs_dir)
      # Note - EDIFF Hierarchical flow is currently INCOMPATIBLE with FF dir structure
      # The following code appears to rely on vars(dbs_dir) always being under $vars(partition_dir)/$vars(design)
      # This needs to be reconciled
      set dir [file tail [subst $vars(dbs_dir)]]

      if {[lindex [split $vars(version) "."]  0] > 10} {
         set command [FF_EDI::initialize_timing mmmc]
         if {[info exists vars(cpf_file)] && $vars(cpf_timing)} {
            set mmmc_file $vars(script_dir)/incr_view_definition.tcl
          } else {
            set mmmc_file $vars(script_dir)/view_definition.tcl
          }
      }

      append commands "setLimitedAccessFeature encFlexILM 1\n"

      append commands "file copy -force $vars(script_dir)/view_definition.tcl $vars(partition_dir)/$vars(design)/$vars(dbs_dir)/prects.enc.dat/viewDefinition.tcl\n"

      set cwd [exec pwd]
      append commands "cd $vars(partition_dir)/$vars(design)\n"

#      set command "restoreDesign . $vars(design)\n"
      set command "restoreDesign $vars(dbs_dir)/prects.enc.dat $vars(design)\n"
      append commands [FF::wrap_command flexilm,restore_design $command]

#      if {([lindex [split $vars(version) "."]  0] > 10) && $vars(cpf_timing)} {
#         append commands "source $mmmc_file\n"
#      }
      append commands [FF::source_plug always_source_tcl]

      ###############################################################################
      # Load "post flexilm" plug-in script
      ###############################################################################
      append commands [FF::source_plug post_flexilm 0]

      ###############################################################################
      # Specify ILMs if defined
      ###############################################################################
      if {$vars(ilm)} {
         if {$vars(verbose)} {
            append commands "#\n"
            append commands "# SPECIFYING ILMs\n"
            append commands "#\n"
         }
         set command "" 
         foreach cell $ilm_list {
            if {[info exists vars($cell,ilm_dir)] && [file isdirectory $vars($cell,ilm_dir)]} {
               append command "specifyIlm -cell $cell -dir $vars($cell,ilm_dir)\n"
            } else {
               puts "<FF> WARNING: ILM DIRECTORY MISSING FOR $cell ... SKIPPING"
            }
         } 
  
         append commands [FF::wrap_command $vars(step),specify_ilm $command]
  
         if {[info exists vars(ilm_non_sdc_file)]} {
            if {[lindex [split $vars(version) "."]  0] <= 10} {
               set command "loadTimingCon -ilmNonSdcFile $vars(ilm_non_sdc_file)\n"
            } else {
               set command "setIlmNonSdcConstraintFile $vars(ilm_non_sdc_file)\n"
            }
            append commands [FF::wrap_command $vars(step),load_ilm_non_sdc_file $command]
         }
      }

#      if {[lindex [split $vars(version) "."]  0] <= 10} {
         if {[info exists vars(cpf_file)]} {
            set command "loadCPF $vars(cpf_file)\n"
            append commands [FF::wrap_command $vars(step),load_cpf $command]
            set command "commitCPF"
            if {$vars(cpf_keep_rows)} {
               append command " -keepRows"
            }
            if {$vars(cpf_power_domain)} {
               append command " -power_domain"
            }
            if {$vars(cpf_isolation)} {
               append command " -isolation"
            }
            if {$vars(cpf_state_retention)} {
               append command " -state_retention"
            }
            if {$vars(cpf_level_shifter)} {
               append command " -level_shifter"
            }
            if {$vars(cpf_power_switch)} {
               append command " -power_switch"
            }
            append command "\n"
            append commands [FF::wrap_command $vars(step),commit_cpf $command]
         }
#      }

#      if {[info exists vars(cpf_file)] && $vars(cpf_timing)} {
         set command [FF_EDI::initialize_timing mmmc]
         append commands [FF::wrap_command $vars(step),initialize_timing $command]
#      }

#      set command [FF_EDI::update_timing mmmc ]
#      append commands [FF::wrap_command $vars(step),update_timing $command]

      foreach mode $vars(constraint_modes) {
         set command "update_constraint_mode -name $mode -ilm_sdc_files \[get_constraint_mode $mode -sdc_files\]\n"
         append commands [FF::wrap_command $vars(step),update_constraint_mode $command]
      }

      append commands "cd $cwd\n"

      set command ""
      foreach part $vars(partition_list) {
         append command "set_module_model -cell $part \\\n"
         append command "-type flexIlm \\\n"
         append command "-dir $vars(partition_dir)/$part/$part.flexilm\n"
      }

      append commands [FF::wrap_command $vars(step),set_module_model $command]

      set command "commit_module_model\n"
      append commands [FF::wrap_command $vars(step),commit_module_model $command]

      set command "" 
      foreach part $vars(partition_list) {
         append command "setModuleView -partition $part -type interface\n"
      }
      append commands [FF::wrap_command $vars(step),set_module_view $command]

      set command "getModuleView\n"
      append commands [FF::wrap_command $vars(step),get_module_view $command]

      if {$vars(flow) == "mmmc"} {
         set command [FF_EDI::derate_timing mmmc]
         append commands [FF::wrap_command $vars(step),derate_timing $command]
         set command ""
#         foreach mode $vars(constraint_modes) {
#            append command "update_constraint_mode -name $mode -sdc_files \"$vars($mode,pre_cts_sdc)\"\n"   
#         }
#         append commands [FF::wrap_command $vars(step),update_constraint_mode $command]
      }

      #set_analysis_view -setup [all_setup_analysis_views] -hold [all_hold_analysis_views]
      #Puts "<FF> SETUP -> [all_setup_analysis_views]" 
      #Puts "<FF> HOLD -> [all_hold_analysis_views]" 

      set command "createActiveLogicView -type topCritical -preCTS\n"
      append commands [FF::wrap_command $vars(step),create_active_logic_view $command]
      set command "setHierMode -optStage preCTS\n"
      append commands [FF::wrap_command $vars(step),set_hier_mode $command]
      set command "setOptMode -addInstancePreFix FlexILMI_ -addNetPreFix FlexILMN_\n"
      append commands [FF::wrap_command $vars(step),set_opt_mode $command]

      append commands [FF::source_plug pre_flexilm_tcl 0]
      set command ""
      foreach part $pac_list {
            append command "set hinst \[dbHInstName \[dbCellHInst \[dbGetCellByName $part\]\]\]\n"
         if {[info exists vars($part,pac_mode)]} {
            if {$vars($part,pac_mode) == "read_only"} { set vars($part,pac_mode) "readOnly" }
            append command "setModuleView -hinst \$hinst -type $vars($part,pac_mode)\n"
         } 
      }

      append command "getModuleView\n"
      append commands [FF::wrap_command $vars(step),set_module_view $command]

      if {$vars(verbose)} {
         append commands "#\n"
         append commands "# RUNNING FLEXILM OPTIMIZATION\n"
         append commands "#\n"
      }
      set command "optDesign -preCTS -outDir $vars(rpt_dir) -prefix flexilm\n"
      append commands [FF::wrap_command $vars(step),opt_design $command]

      append commands [FF::source_plug post_flexilm_tcl 0]

#      set command "setTrialRouteMode -handlePartitionComplex true -honorPin true\n"
#      append command "trialRoute\n"
#      append command "deriveTimingBudget -noConstantModel\n"
#      append commands [FF::wrap_command $vars(step),derive_timing_budget $command]

      if {[string compare -nocase $vars(dbs_format) "oa"]==0} {
         if {[lindex [split $vars(version) "."]  0] > 10} {
            set command "saveDesign -cellview {$vars(oa_design_lib) $vars(design) flexilm}\n"
         } else {
            set command "saveOaDesign $vars(oa_design_lib) $vars(design) flexilm\n"
         }
      } else {
         set command "saveDesign $vars(dbs_dir)/flexilm.enc -compress\n"
      }
      append commands [FF::wrap_command $vars(step),save_dbs $command]

      set command "clearActiveLogicView\n"
      append commands [FF::wrap_command $vars(step),clear_active_logic_view $command]

### save postOpt data and commit ECO ###

#      set command "update_partition -flexIlmECO \\\n"
#      append command "    -goldenDir $vars(partition_dir) \\\n"
#      append command "    -flexIlmDir $vars(partition_dir)_FLEXILM\n"
#      append commands [FF::wrap_command $vars(step),update_partition $command]

      set command "update_partition -flexIlmECO \\\n"
      foreach part $vars(partition_list) { 
         append command "    -goldenBlockDir $vars(partition_dir)/$part/$vars(dbs_dir)/prects.enc.dat \\\n"
      } 
      append command "    -flexIlmDir $vars(partition_dir)_FLEXILM\n"
      append commands [FF::wrap_command $vars(step),update_partition $command]

      set command "report_resource -end opt_flexIlm\n"
      append commands [FF::wrap_command $vars(step),report_resource $command]

      append commands "#---------------------------------------------------------------------\n"
      append commands "# <FF> GENERATING REPORTS\n"
      append commands "#---------------------------------------------------------------------\n"

      if {$vars(report_power)} {
         if {[info exists vars(power_analysis_view)] && ($vars(power_analysis_view) != "")} {
            set command "report_power -view $vars(power_analysis_view) -outfile $vars(rpt_dir)/$vars(step).power.rpt\n"
         } else {
            set command "report_power -outfile $vars(rpt_dir)/$vars(step).power.rpt\n"
         }
         append commands [FF::wrap_command $vars(step),report_power $command]
      }

      if {[FF::is_lp_flow] && [info exists vars(power_domains)] && [llength $vars(power_domains)] > 0} {

         ######################################################################
         # Verify power domain
         ######################################################################

         set command "verifyPowerDomain -bind -gconn"
         append command " -isoNetPD $vars(rpt_dir)/$vars(step).isonets.rpt"
         append command " -xNetPD $vars(rpt_dir)/$vars(step).xnets.rpt\n"

         append commands [FF::wrap_command $vars(step),verify_power_domain $command]

         ######################################################################
         # Run CLP
         ######################################################################

         if {$vars(run_clp) && ([auto_execok lec] != "")} {
            set command "runCLP "
            if {[info exists vars(clp_options)]} {
               append command $vars(clp_options)
            }
            append command "\n"
            append commands [FF::wrap_command $vars(step),run_clp $command]
         } else {
            if {![info exists vars(clp_warning)]} {
               puts "<FF> WARNING: UNABLE TO RUN CLP ... PLEASE MAKE SURE IT IS IN YOUR PATH"
               set vars(clp_warning) true
            }
         }
      }
      if {!$vars(codegen)} {
         uplevel #0 eval $commands
         set commands "" 
      }

#      if {$vars(makefile)} { 
          append commands "if {\[info exists env(VPATH)\]} {\n"
          append commands "set op \[open $env(VPATH)/flexilm w\]\n"
          foreach part $vars(partition_list) {
             append commands "puts \$op \"set vars($part,cdtv) \$::Rda_CDTV::ilmDataInfo($part,blockDir)\"\n"
          }
          append commands "close \$op\n"
#          foreach part $vars(partition_list) {
#             append commands "file copy -force $vars(partition_dir_pass2)/$part/Makefile $vars(partition_dir_pass2)/$part.Makefile\n"
#          }

          append commands "exec /bin/touch \$env(VPATH)/$vars(step)\n"
          append commands "}\n"
#       }


      if {$vars(codegen)} {
         return $commands
      } else {
         uplevel #0 eval $commands
      }
   }

   proc run_feedthrough {{format 1}} {
      global vars
      global errors
      global env

      set vars(step) feedthrough
      set vars(hier) true
      if {[info exists vars(time_design_options,setup)]} {
         set tmp_time_design_options_setup $vars(time_design_options,setup)
      } else {
         set vars(time_design_options,setup) ""
      }

      set commands ""

      if {[info exists vars(use_flexmodels)] && $vars(use_flexmodels)} {
         set command "timeDesign -proto -preplace -prefix preplace -outdir $vars(rpt_dir)\n"
         append commands [FF::wrap_command $vars(step),time_design $command]

         # Use -proto timing when using flexmodels
         lappend vars(time_design_options,setup) "-proto"
      } else {
         # Initialise the design
         if {$vars(codegen)} { 
            append commands [FF_EDI::run_init $format]
         } else {
            FF_EDI::run_init $format
         }
         
         if {[string compare -nocase $vars(dbs_format) "oa"]==0} {
            if {[lindex [split $vars(version) "."]  0] > 10} {
               set command "saveDesign -cellview {$vars(oa_design_lib) $vars(design) init}\n"
            } else {
               set command "saveOaDesign $vars(oa_design_lib) $vars(design) init\n"
            }
         } else {
            set command "saveDesign $vars(dbs_dir)/init.enc -compress\n"
         }

         append commands [FF::wrap_command $vars(step),save_init_dbs $command]
      }

      # Additional timing setup
      if {[info exists vars($vars(design),latency_sdc)]} {
         append command "foreach mode \[all_constraint_modes -active\] {\n"
         append command "   set sdc_files \[get_constraint_mode \$mode -sdc_files\]\n"
         append command "   set sdc_list \[concat \$sdc_files $vars($vars(design),latency_sdc)\]\n"
         append command "   update_constraint_mode -name \$mode -sdc_files \$sdc_list\n"
         append command "}\n"

         append commands [FF::wrap_command $vars(step),update_constraint_mode $command]
      }

      foreach view [concat $vars(setup_analysis_views) $vars(hold_analysis_views)] {
         foreach ptn $vars(partition_list) {
            if {[info exists vars($ptn,$view,latency_sdc)]} {
               set latency($view,$ptn) $vars($ptn,$view,latency_sdc)
            } elseif {[info exists vars($ptn,latency_sdc)]} {
               set latency($view,$ptn) $vars($ptn,latency_sdc)
            } else {
               set latency($view,$ptn) "none"
            }
         }
      }
      
      set command ""
      foreach view [concat $vars(setup_analysis_views) $vars(hold_analysis_views)] {
         foreach ptn $vars(partition_list) {
            if {$latency($view,$ptn) != "none"} {
               append command "   setPtnUserCnsFile -view $view -fileName $latency($view,$ptn) -ptnName $ptn\n"
            }
         }
      }

      if {$command != ""} {      
         append commands [FF::wrap_command $vars(step),set_ptn_user_cns_file $command]
      }

      # Place design (without pre-placement optimization)
      set command "setPlaceMode -reorderScan false\n"
      append commands [FF::wrap_command $vars(step),set_place_mode $command]

      if {[info exists vars(no_pre_place_opt)]} { set tmp_nppo $vars(no_pre_place_opt) }
      set vars(no_pre_place_opt) 1
      if {$vars(codegen)} { 
         append commands [FF_EDI::run_place $format]
      } else {
         uplevel #0 eval $commands 
         FF_EDI::run_place $format
         set commands ""
      }
      if {[info exists tmp_nppo]} {
         set vars(no_pre_place_opt) $tmp_nppo
      } else {
         unset vars(no_pre_place_opt)
      }

      if {[string compare -nocase $vars(dbs_format) "oa"]==0} {
         if {[lindex [split $vars(version) "."]  0] > 10} {
            set command "saveDesign -cellview {$vars(oa_design_lib) $vars(design) place}\n"
         } else {
            set command "saveOaDesign $vars(oa_design_lib) $vars(design) place\n"
         }
      } else {
         set command "saveDesign $vars(dbs_dir)/place.enc -compress\n"
      }
      append commands [FF::wrap_command $vars(step),save_place_dbs $command]

      # Insert feedthrough and trial route, as appropriate
      set do_trial_route_time_design 1
      if {[info exists vars(placement_based_ptn)] && $vars(placement_based_ptn) } {
         if {[info exists vars(abutted_design)] && $vars(abutted_design)} {
            # placement based & abutted design -> Run placement based FT
            set command "insertPtnFeedthrough -saveTopoFile topo.txt -netMapping netmapping.txt\n"
            append commands [FF::wrap_command $vars(step),insert_ptn_feedthrough $command]
         } else {
            set do_trial_route_time_design 0            
         }
      } elseif {[info exists vars(abutted_design)] && $vars(abutted_design)} {
         # route based & abutted design -> Route based FT
         set command "trialRoute\n"
         append command "insertPtnFeedthrough -saveTopoFile topo.txt -netMapping netmapping.txt -routeBased\n"
         append command "setTrialRouteMode -keepExistingRoutes true\n"
         append command "trialRoute\n"
         append commands [FF::wrap_command $vars(step),trial_route $command]
      } else {
         # route based & channel based design -> no FT and route based pin assingment
         set command "setTrialRouteMode -handlePartitionComplex true\n"
         append command "trialRoute\n"
         append commands [FF::wrap_command $vars(step),trial_route $command]
      }

      if {$do_trial_route_time_design} {
         set command "timeDesign -prects -prefix feedthrough -outDir $vars(rpt_dir)"
         if {[info exists vars(use_flexmodels)] && $vars(use_flexmodels)} {
            append command " -proto"
         }
         append commands [FF::wrap_command $vars(step),trial_route_time_design "$command\n"]
      }

      if {[info exists tmp_time_design_options_setup]} {
         set vars(time_design_options,setup) $tmp_time_design_options_setup
      } else {
         unset vars(time_design_options,setup)
      }

      # Output or run the generated commands
      if {$vars(codegen)} {
         return $commands
      } else {
          uplevel #0 eval $commands
      }

   }

   proc run_assignpin {{format 1}} {
      global vars
      global errors
      global env

      set vars(step) assignpin
      set vars(hier) true
      set commands ""

      ###############################################################################
      # Assign partition pins via plug-in as this the
      # pitch, depth, and layer values are design specific
      # Also, verify the pin assignment and fix them
      ###############################################################################

      append commands [FF::source_plug pre_assignpin_tcl]

      set command "assignPtnPin\n"
      append commands [FF::wrap_command $vars(step),assign_ptn_pins $command]

      append commands [FF::source_plug post_assignpin_tcl]

      set command "checkPinAssignment -outFile pincheck.rpt\n"
      append commands [FF::wrap_command $vars(step),check_pin_assignment $command]

      set command "reportUnalignedNets -rptFile $vars(rpt_dir)/unaligned.rpt\n"
      append commands [FF::wrap_command $vars(step),report_unaligned_nets $command]

      set command "setTrialRouteMode -honorPin true -handlePartitionComplex true\n"
      append command "trialRoute\n"
      append commands [FF::wrap_command $vars(step),trial_route $command]

      if {$vars(codegen)} {
         return $commands
      } else {
          uplevel #0 eval $commands
      }
   }

   proc run_model_gen {{format 1}} {
      global vars
      global errors
      global env

      set vars(step) model_gen
      set vars(hier) true
      set commands ""

      # Initialise the design
      if {$vars(codegen)} { 
         append commands [FF_EDI::run_init $format]
      } else {
         FF_EDI::run_init $format
      }
      
      if {[string compare -nocase $vars(dbs_format) "oa"]==0} {
         if {[lindex [split $vars(version) "."]  0] > 10} {
            set command "saveDesign -cellview {$vars(oa_design_lib) $vars(design) init}\n"
         } else {
            set command "saveOaDesign $vars(oa_design_lib) $vars(design) init\n"
         }
      } else {
         set command "saveDesign $vars(dbs_dir)/init.enc -compress\n"
      }
      
      append commands [FF::wrap_command $vars(step),save_init_dbs $command]

      append commands [FF::source_plug pre_model_gen_tcl]
      
      # Should we use ART-based model generation?
      set ART_based [expr {[info exists vars(model_gen,art_based)] && $vars(model_gen,art_based)}]

      if {$ART_based} {
         set command "create_ps_per_micron_model\n"
         append commands [FF::wrap_command $vars(step),create_ps_per_micron_model $command]
      }

      set command "identify_proto_model\n"
      append commands [FF::wrap_command $vars(step),identify_proto_model $command]

      if {[info exists vars(model_gen,min_inst)]} {
         set min_inst $vars(model_gen,min_inst)
      } else {
         set min_inst 1000
      }
      set command "report_proto_model -min_inst $min_inst\n"
      append commands [FF::wrap_command $vars(step),report_proto_model $command]

      set command "setIlmMode -highFanoutPort false\n"
      append commands [FF::wrap_command $vars(step),setIlmMode $command]
      
      if {$ART_based} {
         set command "create_proto_model -flat_top $vars(dbs_dir)/model_gen.enc\n"
         append commands [FF::wrap_command $vars(step),create_proto_model $command]
         set command "create_flexfiller_route_blockage\n"
         append commands [FF::wrap_command $vars(step),create_flexfiller_route_blockage $command]
      } else {
         set command "create_proto_model\n"
         append commands [FF::wrap_command $vars(step),create_proto_model $command]
         set command "report_proto_model -created\n"
         append commands [FF::wrap_command $vars(step),report_proto_model $command]
         set command "saveDesign $vars(dbs_dir)/model_gen.enc -compress\n"
         append commands [FF::wrap_command $vars(step),saveDesign $command]
      }

      append commands [FF::source_plug post_model_gen_tcl]

      if {$vars(codegen)} {
         return $commands
      } else {
          uplevel #0 eval $commands
      }
   }

   proc run_partition {{format 1}} {

      global vars
      global errors
      global env

      set vars(step) partition
      set vars(hier) true

      set commands ""

      if {[info exists vars(use_flexmodels)] && $vars(use_flexmodels)} {
         # Use psPM budgeting
         set command "timeDesign -proto\n"
         append commands [FF::wrap_command $vars(step),time_design_proto $command]
         
         set command "set tbgMMMCUseSameTGraph 1\n"
         append command "set_global timing_support_hierarchical_pin_constraints true\n"
         append command "set tbgWriteLatencyPerClock 1\n"
         append command "set tbgPrintExceptionInfoInJustify 1\n"
         append commands [FF::wrap_command $vars(step),set_pspm_vars $command]
         
         set no_hold_view [expr {[info exists vars(pspm_budget,no_hold_view)] && $vars(pspm_budget,no_hold_view)}]
         set command "setBudgetingMode -noHoldView $no_hold_view\n"
         append command "setBudgetingMode -trialIPO false\n"
         append commands [FF::wrap_command $vars(step),set_budgeting_mode $command]
      }

      ###############################################################################
      # Budget the blocks, requires a new trialRoute
      # with the pins honored
      ###############################################################################
      set command "deriveTimingBudget -justify\n"
      append commands [FF::wrap_command $vars(step),derive_timing_budget $command]

      ###############################################################################
      # Run CLP
      ###############################################################################
      if {[FF::is_lp_flow] && [info exists vars(power_domains)] && [llength $vars(power_domains)] > 0} {
         if {$vars(run_clp) && ([auto_execok lec] != "")} {
            set command "runCLP "
            if {[info exists vars(clp_options)]} {
               append command $vars(clp_options)
            }
            append command "\n"
            append commands [FF::wrap_command $vars(step),run_clp $command]
         }
      }

      ###############################################################################
      # Partition and save the partitions into the
      # directory PARTITION
      ###############################################################################
      append commands [FF::source_plug pre_partition_tcl]

#      set command "set ptngPtnTimingLibFormat lib\npartition -buildScan\n"
      set command "partition -buildScan\n"
      append commands [FF::wrap_command $vars(step),partition $command]
      if {[lindex [split $vars(version) "."]  0] > 10} {
         if {([string compare $vars(dbs_format) "oa"]==0)} {
            set command "savePartition -ptnLib $vars(oa_partition_lib) -dir $vars(partition_dir)\n"
         } else {
            set command "savePartition -dir $vars(partition_dir) -def -scanDef\n"
         }
      } else {
         set command "savePartition -dir $vars(partition_dir) -def -scanDef\n"
      }
      append commands [FF::wrap_command $vars(step),save_partition $command]

      append commands [FF::source_plug post_partition_tcl]

      append commands "#---------------------------------------------------------------------\n"
      append commands "# <FF> GENERATING REPORTS\n"
      append commands "#---------------------------------------------------------------------\n"

      if {$vars(report_power)} {
         if {[info exists vars(power_analysis_view)] && ($vars(power_analysis_view) != "")} {
            set command "report_power -view $vars(power_analysis_view) -outfile $vars(rpt_dir)/$vars(step).power.rpt\n"
         } else {
            set command "report_power -outfile $vars(rpt_dir)/$vars(step).power.rpt\n"
         }
         append commands [FF::wrap_command $vars(step),report_power $command]
      }

      if {[FF::is_lp_flow] && [info exists vars(power_domains)] && [llength $vars(power_domains)] > 0} {

         ######################################################################
         # Verify power domain
         ######################################################################

         set command "verifyPowerDomain -bind -gconn"
         append command " -isoNetPD $vars(rpt_dir)/$vars(step).isonets.rpt"
         append command " -xNetPD $vars(rpt_dir)/$vars(step).xnets.rpt\n"

         append commands [FF::wrap_command $vars(step),verify_power_domain $command]

         ######################################################################
         # Run CLP
         ######################################################################

         if {$vars(run_clp) && ([auto_execok lec] != "")} {
            set command "runCLP "
            if {[info exists vars(clp_options)]} {
               append command $vars(clp_options)
            }
            append command "\n"
            append commands [FF::wrap_command $vars(step),run_clp $command]
         } else {
            if {![info exists vars(clp_warning)]} {
               puts "<FF> WARNING: UNABLE TO RUN CLP ... PLEASE MAKE SURE IT IS IN YOUR PATH"
               set vars(clp_warning) true
            }
         }
      }

      if {!$vars(codegen)} {
          uplevel #0 eval $commands
      }

      set path [file normalize $vars(script_path)]
   
      file mkdir $vars(partition_dir)
   
      if {![file exists $vars(partition_dir)/Makefile.partition]} {
         file copy $vars(script_path)/ETC/EDI/Makefile.partition $vars(partition_dir)
      }
      set op [open $vars(partition_dir)/Makefile w]
      if {![info exists env(VPATH)]} {
         set env(VPATH) "make"
      }
      puts $op "VPATH=$env(VPATH)"
      puts $op "BLOCKS = $vars(partition_list)"
      puts $op ""
      puts $op "include Makefile.partition"
      close $op
   
      foreach var [array names vars] {
         set svars($var) $vars($var)
      }
      set vars(mode) flat
#      set vars(hier) true
      set link [file normalize $vars(script_root)]
      foreach block [concat $vars(design) $vars(partition_list)] {
         exec mkdir -p $vars(partition_dir)/$block
#         if {[file exists .ff.tcl]} {
#            file copy -force .ff.tcl $vars(partition_dir)/$block
#         }
         if {[file exists $vars(partition_dir)/$block/Makefile]} {
            file delete $vars(partition_dir)/$block/Makefile
         }
         if {[info exists vars($block,edi_config_tcl)] && [file exists $vars($block,edi_config_tcl)]} {
            puts "<FF> Sourcing $vars($block,edi_config_tcl)"
            source $vars($block,edi_config_tcl)
         } 
         set cwd [pwd]
        
         if {([lindex [split $vars(version) "."]  0] > 10)  && ([string compare $vars(dbs_format) "oa"]==0)} {
            if {[file exists cds.lib]} {
               set ip [open cds.lib r]
               set i 0 
               while {[gets $ip line]>=0} {
                  set cds_lib($i) $line
                  incr i
               }
               close $ip
            } else {
               puts "<FF> ERROR: A cds.lib file is required for open access flows ..."
            }
         } 
         cd $vars(partition_dir)/$block
         set vars(design) $block
         if {$vars(codegen)} {
            if {[info exists vars(proc_file)]} {
               unset vars(proc_file)
            }
            unset vars(steps)
         } 
         if {[info exists vars(cts_spec)]} {
            unset vars(cts_spec)
         }
         if {[info exists vars($block,cts_spec)]} {
            set vars(cts_spec) $vars($block,cts_spec)
         }

         if {!$vars(codegen)} { 
            exec ln -s $link SCRIPTS
            exec ln -s SCRIPTS/Makefile.edi.flat Makefile
         } else {
            set vars(mode) flat
            set vars(hier) true 
            unset vars(step)
            execute_flow all $vars(format_lines)
            FF::dump_vars
         }
         cd $cwd
         foreach var [array names vars] {
            unset vars($var)
         }
         foreach var [array names svars] {
            set vars($var) $svars($var)
         }
      }
      if {$vars(hier_flow_type) == "2pass"} {
         foreach block [concat $vars(design) $vars(partition_list)] {
            exec mkdir -p $vars(partition_dir_pass2)/$block/$vars(script_dir)/EDI
            if {[file isdirectory $vars(partition_dir_pass2)/$block/$vars(script_dir)/ETC]} {
               file delete -force $vars(partition_dir_pass2)/$block/$vars(script_dir)/ETC
            }
#            file copy -force $vars(partition_dir)/$block/$vars(script_dir)/ETC $vars(partition_dir_pass2)/$block/$vars(script_dir)/ETC
            foreach file [glob $vars(partition_dir)/Make*] {
               if {[file isfile $file]} {
                  file copy -force $file $vars(partition_dir_pass2)
                }
            }
            foreach file [glob $vars(partition_dir)/$block/$vars(script_dir)/*] {
               if {[file isfile $file]} {
                  file copy -force $file $vars(partition_dir_pass2)/$block/$vars(script_dir)
                }
            }
            if {[file isfile $vars(partition_dir)/$block/.ilm_non_sdc_file.tcl]} {
               file copy -force $vars(partition_dir)/$block/.ilm_non_sdc_file.tcl $vars(partition_dir_pass2)/$block
            }
            if {[file isfile $vars(partition_dir)/$block/empty.sdc]} {
               file copy -force $vars(partition_dir)/$block/empty.sdc $vars(partition_dir_pass2)/$block
            }
            if {$vars(enable_dlm)} {
               set index [lsearch $vars(steps) cts]
            } else {
               set index [lsearch $vars(steps) postcts]
            }
            foreach step [lrange $vars(steps) $index end] {
               if {[lsearch $vars(fsteps) $step] != -1} {
                  if {[file isfile $vars(partition_dir)/$block/$vars(script_dir)/EDI/run_$step.tcl]} {
                     file copy  -force $vars(partition_dir)/$block/$vars(script_dir)/EDI/run_$step.tcl \
                                       $vars(partition_dir_pass2)/$block/$vars(script_dir)/EDI
                     file delete  -force $vars(partition_dir)/$block/$vars(script_dir)/EDI/run_$step.tcl
                  }
               }
            }
#            if {$vars(enable_dlm)} {
#               file copy -force $vars(partition_dir)/$block/Makefile.pass2 $vars(partition_dir_pass2)/$block.Makefile
#             } else {
#               file copy -force $vars(partition_dir)/$block/Makefile.pass2 $vars(partition_dir_pass2)/$block/Makefile
#             }
#            cd $vars(partition_dir)_CTS/$block
#               FF::gen_makefile [lrange $vars(steps) $index end] flat
#            cd $cwd
         }
      }
 
      foreach var [array names vars] {
         unset vars($var)
      }
      foreach var [array names svars] {
         set vars($var) $svars($var)
      }

      if {$vars(codegen)} {
#         if {$vars(makefile)} {
#            append commands "\nexec /bin/touch $env(VPATH)/partition\n"
#         }
         return $commands
      } else {
         exec /bin/touch $env(VPATH)/partition
      }
   }
   proc run_debug {{format 1}} {

      global vars
      global errors
      global env

      set commands ""
      append commands "\nglobal env\n"

      append commands "if {\[info exists env(STEP)\]} {\n"
      append commands "[FF_EDI::load_design \$env(STEP)]\n"
      append commands "}\n"

#      append commands "[FF::source_plug always_source_tcl]\n"

      append commands "win\n"

      if {$vars(codegen)} {
         return $commands
      } else {
          uplevel #0 eval $commands
      }

   }

   proc run_lec {} {

      global vars
      global errors
      global env

      set commands ""

      append commands "vpxmode\n"
      append commands "set dofile abort exit\n"
      append commands "set undefined cell black_box -noascend -both\n"
      append commands "tclmode\n"
      append commands "// setup variables \n"
      append commands "global vars\n"
      append commands "proc Puts {args} {\n"
      append commands "   puts \$args\n"
      append commands "}\n"

      append command "// Define the netlist to be verify\n"
      append commands "if {\[info exists env(STEP)\] && \[file exists $vars(dbs_dir)/\$env(STEP).enc.dat/$vars(design).v.gz\]} {\n"
      append commands "   set revisedNetlist $vars(dbs_dir)/\$env(STEP).enc.dat/$vars(design).v.gz\n"
      append commands "} else {\n"
      append commands "   Puts \"<FF> Failed to find netlist  DBS/\$env(STEP).enc.dat/$vars(design).v.gz\"\n"
      append commands "}\n"

      if {[info exists vars(threads)]} {
         append commands "vpx set compare option -threads $vars(threads)\n"
      }

      append commands "// read liberty cell definitions\n"
      if {[info exists vars($vars(default_setup_view),delay_corner)]} {
         if {[info exists vars($vars($vars(default_setup_view),delay_corner),library_set)]} {
            set set $vars($vars($vars(default_setup_view),delay_corner),library_set)
         } else {
            return
         }
      } else {
            return
      }
      append commands "vpx read library -statetable -both -liberty \[list $vars($set,timing)\]\n"

      append commands "// read reference netlist\n"
      append commands "vpx read design -verilog -sensitive -golden $vars(netlist)\n"

      append commands "// read post-implementation netlist\n"
      append commands "vpx read design -verilog -sensitive -revised \$revisedNetlist\n"

      append commands "//set top level\n"
      append commands "vpx set root module $vars(design) -both\n"

      regsub -all "#" [FF::source_plug pre_lec_tcl] "//" temp
      append commands $temp

      append commands "vpxmode\n"
      append commands "report design data\n"
      append commands "report black box\n"

      append commands "set mapping method -name first\n"
      append commands "set flatten model -seq_constant -seq_constant_x_to 0\n"
      append commands "set flatten model -nodff_to_dlat_zero -nodff_to_dlat_feedback\n"
      append commands "set flatten model -gated_clock\n"
      append commands "set system mode lec\n"
      append commands "add compare point -all\n"
      append commands "compare -gate_to_gate\n"
      append commands "usage\n"
      append commands "//   vpx report compare data"
      append commands "report compare data -class nonequivalent -class abort -class notcompared\n"
      append commands "report verification -verbose\n"
      append commands "report statistics\n"

      append commands "tclmode\n"
      append commands "set points_count \[get_compare_points -count\]\n"
      append commands "set diff_count \[get_compare_points -diff -count\]\n"
      append commands "set abort_count \[get_compare_points -abort -count\]\n"
      append commands "set unknown_count \[get_compare_points -unknown -count\]\n"
      append commands "if {\$points_count == 0} {\n"
      append commands "    puts \"---------------------------------\"\n"
      append commands "    puts \"ERROR: No compare points detected\"\n"
      append commands "    puts \"---------------------------------\"\n"
      append commands "}\n"
      append commands "if {\$diff_count > 0} {\n"
      append commands "    puts \"------------------------------------\"\n"
      append commands "    puts \"ERROR: Different Key Points detected\"\n"
      append commands "    puts \"------------------------------------\"\n"
      append commands "}\n"
      append commands "if {\$abort_count > 0} {\n"
      append commands "    puts \"-----------------------------\"\n"
      append commands "    puts \"ERROR: Abort Points detected \"\n"
      append commands "    puts \"-----------------------------\"\n"
      append commands "}\n"
      append commands "if {\$unknown_count > 0} {\n"
      append commands "    puts \"----------------------------------\"\n"
      append commands "    puts \"ERROR: Unknown Key Points detected\"\n"
      append commands "    puts \"----------------------------------\"\n"
      append commands "}\n"
      append commands "puts \"No of compare points = \$points_count\"\n"
      append commands "puts \"No of diff points    = \$diff_count\"\n"
      append commands "puts \"No of abort points   = \$abort_count\"\n"
      append commands "puts \"No of unknown points = \$unknown_count\"\n"
      append commands "exit 0\n"

      if {$vars(codegen)} {
         return $commands
      } else {
          uplevel #0 eval $commands
      }

   }

   proc dump_config {} {

      global vars
      global udm
      global rda_Input
      global rda_defaults

#      set commands ""
      file mkdir $vars(script_dir)
      if {[info command FFF::get_tool] ne "" && [FFF::get_tool] eq "rc"} {
        tcl_source $vars(script_path)/ETC/EDI/udm.tcl
      } else { 
        source $vars(script_path)/ETC/EDI/udm.tcl
      }
      if {[info exists vars(cpf_file)]} {
         if {$vars(cpf_timing)} {
            unset init(mmmc_file)
         } else {
            unset init(cpf_file)
         }
      }
      if {[lindex [split $vars(version) "."]  0] > 10} {
         set op [open $vars(script_dir)/init.tcl w]
         puts $op "# ======================  INIT  =========================="
         # BCL: Trying to fix embedded paths...
         set relativizeMesgLog ""
         set relativizeMesgLog "$relativizeMesgLog [FF::remove_outer_braces [FF::relativizeFileOrDir -arr init -vardir ff_exe_dir -relativePathsOk]]"

         foreach var [array names init] {
            puts $op "set init_$var \"$init($var)\""
         }
         puts $op "# ======================  CONF  =========================="
         foreach var [array names conf] {
            puts $op "set conf_$var \"$conf($var)\""
         }
         puts $op "# ======================  CTS   =========================="
         foreach var [array names cts] {
            puts $op "set cts_$var \"$cts($var)\""
         }
         puts $op "# ===================== DELAYCAL ========================="
         foreach var [array names delaycal] {
            puts $op "set delaycal_$var \"$delaycal($var)\""
         }
         puts $op "# ===================== EXTRACT =========================="
         foreach var [array names extract] {
            puts $op "set extract_$var \"$extract($var)\""
         }
#         puts $op "# ========================================================"
#         foreach var [array names fp] {
#            puts $op "set fp_$var \{$fp($var)\}"
#         }
         puts $op "# ======================  OPT  ==========================="
         foreach var [array names opt] {
            puts $op "set opt_$var \"$opt($var)\""
         }
#         puts $op "# ========================================================"
#         foreach var [array names rda_Input] {
#            puts $op "set rda_Input($var) \{$rda_Input($var)\}"
#         }
#         foreach var [array names rda_defaults] {
#            puts $op "set rda_Input($var) \{$vars($var)\}"
#         }
      } else {
         set op [open $vars(script_dir)/run.conf w]
         #BCL: Added .ff.tcl sourcing in run.conf in order to pull in codegen variables
         puts $op "# Set up codegen variables (possibly) needed to resolve some conf variables"
         #puts $op "if {\[file exists .ff.tcl\]} {"
         #puts $op "  source .ff.tcl"
         #puts $op "}"
         #BCL: Only enclose in curlies if subst is not part of the netlist name
         foreach var [array names rda_Input] {
           # BCL: only use curlies if the variable doesn't contain subst (otherwise subst will not be performed)
           if {[regexp {subst} $rda_Input($var)]} {
             puts $op "set rda_Input($var) \"$rda_Input($var)\""
           } else {
             puts $op "set rda_Input($var) \{$rda_Input($var)\}"
           }
         }
#         if {$vars(flat) != "full"} {
#            puts $op "set rda_Input(ui_view_definition_file) \"$vars(script_dir)/view_definition.tcl\""
#         }
      }
      close $op
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
                  if {![regexp "^#" [string trimleft $line] ] && ($i != [expr $length-1])} {
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

   proc normalize_files {} {
   
      global vars
      global errors

      if {[info exists vars(normalize_files)] && !$vars(normalize_files)} {
         return
      }

      foreach file_var [list cpf_file def_files netlist cts_spec lef_files \
                         gds_files activity_file ilm_non_sdc_file ] {
         if {[info exists vars($file_var)]} {
            set temp [list]
            foreach file $vars($file_var) {  
               lappend temp [file normalize $file]
            }
            set vars($file_var) $temp
         }
      }
   }

   proc normalize_constraints {} {

      global vars

      set cwd [pwd]
      cd $vars(cwd)

      foreach mode $vars(constraint_modes) {
         foreach var "pre_cts_sdc incr_cts_sdc post_cts_sdc" {
            if {[info exists vars($mode,$var)]} {
                  set temp [list]
               foreach file $vars($mode,$var) {
                  lappend temp [file normalize $file]
               }
               set vars($mode,$var) $temp
            }
         }
      }
      cd $cwd
   }

   proc denormalize_files {} {
   
      global vars
      global tvars
   
      foreach var [array names vars] {
         if {($var != "setup_path") && ($var != "script_dir") && ($var != "script_path") && ($var == "execute_string")} {
            set tvars($var) $vars($var)
         }
      }

#      set op [open .setup.ff.tcl w]
      catch {unset path_array}
      set path_list [list]
      set path_vars [list]
      foreach var [array names tvars] {
         if [file isdirectory $tvars($var)] {
            set path_array($tvars($var)) $var
            lappend path_vars $var
            lappend path_list $tvars($var)  
         }
      }
      
      set sorted_path_list [lsort -decreasing $path_list]
#      puts "-> Found [llength $sorted_path_list]"
      foreach path $sorted_path_list {
#         puts "$path -> $path_array($path) ([string length $path])"
#         puts $op "set vars($path_array($path)) $path"
      }
      
      foreach var [array names tvars] {
         set found 0
         foreach path $sorted_path_list {
             if {($var == $path_array($path)) || ([string first "\["  $var] != -1)} {
                break
             }
      #      puts $op "[format "regsub -all \"%s\" \"%s\" \\$%s" $path [join $tvars($var)] $path_array($path) temp]"
            if {[catch {set command [format "regsub -all \"%s\" \"%s\" \\\$vars(%s) temp" $path [join $tvars($var)] $path_array($path)]}]} {
               break
            }
            set foo [eval $command]
            if {$foo > 0} {
#               puts $op "set vars($var) \"[join $temp]\""
               if {[llength $temp] > 1} {
                  set vars($var) [join $temp]
               } else {
                  set vars($var) $temp
               }
               set found 1
            }
         }
#         if {!$found} {
#            puts $op "set vars($var) \"[join $vars($var)]\""
#         }
      }
#      foreach path $sorted_path_list {
#         set vars($path_array($path)) $path
#      }
#      close $op
#      source .setup.ff.tcl 
   }

   proc source_config_files {} {

      global vars
      global env
      global user_vars
      global desc
      global errors

      puts "<FF> LOADING CONFIGURATION FILES:"
      set vars(config_files) [list]
      foreach file "setup.tcl edi_config.tcl lp_config.tcl" {
         set temp [regsub "\\." $file "_"]
         set vars($temp) [list] 
         if {[file exists $vars(setup_path)/$file]} {
            FF::source_file $vars(setup_path)/$file
            lappend vars($temp) $vars(setup_path)/$file
            lappend vars(config_files) $vars(setup_path)/$file
         }
         if {($vars(setup_path) != ".") && [file exists $file]} {
            FF::source_file $file
            lappend vars($temp) $file
            lappend vars(config_files) $file
         }
         if {$vars($temp) != ""} {
            puts "<FF>    $temp -> $vars($temp)"
         }
      }

      foreach var [array names vars] {
         set user_vars($var) $vars($var)
#         puts $var
      }

      if {[FF::is_lp_flow]} {
         set vars(required_procs) \
            "source_file system_info get_clock_ports get_power_domains modify_power_domains add_power_switches \
             route_secondary_pg_nets insert_welltaps_endcaps report_time buffer_always_on_nets \
             save_results load_applet get_tool load_path_groups"
      } else {
         set vars(required_procs) \
            "source_file system_info get_clock_ports report_time insert_welltaps_endcaps \
             save_results load_applet get_tool load_path_groups "
      }
   }

   proc gen_check {} {

      global vars
      global errors

      set op [open $vars(script_dir)/check_qor.tcl w]

      puts $op "#![lindex $vars(execute_string) 0]"
      
      puts $op "if {!\[llength \$argv\]} {"
      puts $op "   puts \"<FF> ERROR: MISSING QOR RESULT FILE NAME\""
      puts $op "   exit -1"
      puts $op "}"
      
      puts $op "foreach name \$argv {"
      puts $op "   if {!\[file exists \$name\]} {"
      puts $op "      puts \"<FF> ERROR: QOR RESULT FILE MISSING (\$name)\""
      puts $op "      exit -1"
      puts $op "   }"
      
      puts $op "   file stat \$name qor_stat"
      puts $op "   if {!\$qor_stat(size)} {"
      puts $op "      continue"
      puts $op "   }"
      puts $op "   set qor_file \[open \$name r\]"
      puts $op "   gets \$qor_file qor_result"
      puts $op "   if {\[expr \$qor_result\]} {"
      puts $op "      exit -1"
      puts $op "   }"
      puts $op "}"
      
      puts $op "exit 0"

      close $op

      exec chmod +x  $vars(script_dir)/check_qor.tcl
   }

   proc execute_flow {step {format 1} {abort ""}} {
      #
      # This is the entry point, responsible for calling functions and
      # aggregating results for each step in the flow
      #
      global vars
      global dargs
      global fargs
      global svars
      global env
      global errors

      if {![info exists vars(sourced)]} { set vars(sourced) 0 }
#      if {![info exists vars(single)]} { set vars(single) 0 }
      if {![info exists vars(catch_errors)]} { set vars(catch_errors) 0 }
      if {![info exists vars(stop_step)]} { set vars(stop_step) "signoff" }
      if {![info exists vars(initialized)]} { set vars(initialized) 0 }
      if {![info exists vars(loaded)]} { set vars(loaded) 0 }
      if {![info exists vars(bsteps)]} { set vars(bsteps) [list] }
      if {![info exists env(VPATH)]} { set env(VPATH) make }

      #
      # If no steps are defined, set the steps to execute based upon the
      # mode that the system is running in.  We need to do this because the
      # hierarchical flow will unset the vars() array before recursively
      # calling this routine.
      #

      if {![info exists vars(steps)]} {
         # BCL: Moved the following if / else up (it must always execute)
         if {![info exists vars(mode)]} { 
            if {[info exists fargs(mode)]} {
               set vars(mode) $fargs(mode)
            } else {
               set vars(mode) $dargs(mode)
            }
         }
#         if {[info exists vars(hier)] && !$vars(hier)} {
#            FF::set_steps $vars(mode) $format
#            unset vars(mode)
#         } else {
#            FF::set_steps $vars(mode) $format
#         }
      }

      #
      # Set the procedures that we will need to include within each file that
      # we create to run a step.
      #

#      set vars(required_procs) \
#         "source_plug get_clock_ports get_power_domains report_time"

      #
      # Make sure that the variables are actually sourced from the
      # configuration files
      #

      if {!$vars(sourced) && ($step != "source")} {
         execute_flow "source" $format $abort
      }

      if {$vars(sourced)} { 
         if {[info exists vars(hier)] && !$vars(hier)} {
            FF::set_steps $vars(mode) $format
            unset vars(mode)
         } else {
            FF::set_steps $vars(mode) $format
         }
      }
      #
      # Execute the appropriate step per the command
      #

      set action ""
      switch -- $step {
         "source" {
            if {!$vars(sourced)} {
               FF_EDI::source_config_files
               if {[info exists fargs(version)]} {
                  if {![regexp "^10" $fargs(version)] && ![regexp "^9" $fargs(version)]} {
                     FF_EDI::denormalize_files
                  }
               } elseif {[info exists dargs(version)]} {
                  if {![regexp "^10" $dargs(version)] && ![regexp "^9" $dargs(version)]} {
                     FF_EDI::denormalize_files
                  }
               }
               foreach arg [join $vars(arg_list)] {
                  if {[info exists vars($arg)]} {
                     if {[info exists fargs($arg)]} {
                        if {$vars($arg) != $fargs($arg)} {
                           puts "<FF> WARNING: Overwriting vars($arg) from $vars($arg) to $fargs($arg) ..."
                        }
                        set vars($arg) $fargs($arg)
                     } else {
                        # Only set the farg if it wasn't set in a config file
                        if {![info exists vars($arg)]} {
                          set vars($arg) $dargs($arg)
                        }
                     }
                  } else {
                     if {[info exists fargs($arg)]} {
                        set vars($arg) $fargs($arg)
                     } else {
                        set vars($arg) $dargs($arg)
                     }
                  } 
               } 
               FF_EDI::seed_variables
#               FF_EDI::check_setup
#               FF_EDI::normalize_files 
               set vars(sourced) true
               set vars(top_cell) $vars(design)
            }
         }
         "source_only" {
            # BCL: Added this in since i want to source the variables w/out calling check_setup
            if {!$vars(sourced)} {
               FF_EDI::source_config_files
               if {[info exists fargs(version)]} {
                  if {![regexp "^10" $fargs(version)] && ![regexp "^9" $fargs(version)]} {
                     FF_EDI::denormalize_files
                  }
               } elseif {[info exists dargs(version)]} {
                  if {![regexp "^10" $dargs(version)] && ![regexp "^9" $dargs(version)]} {
                     FF_EDI::denormalize_files
                  }
               }
               foreach arg [join $vars(arg_list)] {
                  if {[info exists vars($arg)]} {
                     if {[info exists fargs($arg)]} {
                        if {$vars($arg) != $fargs($arg)} {
                           puts "<FF> WARNING: Overwriting vars($arg) from $vars($arg) to $fargs($arg) ..."
                        }
                        set vars($arg) $fargs($arg)
                     } else {
                        # Only set the farg if it wasn't set in a config file
                        if {![info exists vars($arg)]} {
                          set vars($arg) $dargs($arg)
                        }
                     }
                  } else {
                     if {[info exists fargs($arg)]} {
                        set vars($arg) $fargs($arg)
                     } else {
                        set vars($arg) $dargs($arg)
                     }
                  } 
               } 
               FF_EDI::seed_variables
#               FF_EDI::check_setup
#               FF_EDI::normalize_files 
#               set vars(sourced) true
               set vars(top_cell) $vars(design)
            }
         }
         "check" {
            if {$abort == ""} {
               set abort $vars(abort)
            }
            set save $vars(abort)
            set vars(abort) $abort
            set vars(abort) $save
            if {![info exists vars(mode)]} {
               if {[info exists fargs(mode)]} {
                  set vars(mode) $fargs(mode)
               } else {
                  set vars(mode) $dargs(mode)
               }
            }
            if {$vars(mode) == "hier"} {
               if {![info exists vars(partition_list)]} {
                  puts "<FF> FLOW MODE $vars(mode) SELECTED BUT \$vars(partition_list) NOT DEFINED"
                  exit 99
               }
               if {[file tail [file dirname [pwd]]] != "$vars(partition_dir)"} {
                  FF_EDI::check_setup
               }
            } else {
                  FF_EDI::check_setup
            }

            FF::process_file_lists
         }

         "all" {

            #
            # We have already sourced in all of the files.  Now execute the
            # rest of the steps, including check
            #

            puts "-------------------------------------------------"
            puts "<FF> Generating scripts for $vars(design)"
            puts "-------------------------------------------------"
            execute_flow check $format $abort
            # BCL: changed to file mkdir
            file mkdir $vars(script_dir)/EDI

            set vars(steps) [join $vars(steps)]
            set vars(all) true
            set commands ""

            if {$vars(mode) == "hier"} {
               if {[file tail [file dirname [pwd]]] == "$vars(partition_dir)"} {
                  set all_steps $vars(fsteps)
               } else {
                  set all_steps $vars(hsteps)
               }
            } else {
               set fhr [open $vars(script_path)/EDI/run_all.tcl r] 
               set fhw [open $vars(script_dir)/EDI/run_all.tcl w] 
               while {[gets $fhr line]>=0} {
                  regsub "source FF" $line "source $vars(script_dir)" line
                  puts $fhw "   $line"
               }
               close $fhr
               close $fhw
               set all_steps $vars(steps)
            }
            #
            # Execute each step of the flow and get a composite list of the
            # actual steps that had actions generated for them.  Then create
            # a Makefile for those steps
            #
            if {[info exists vars(rc_steps)]} {
               set actions $vars(rc_steps)
            } else {
              set actions [list]
            }
            # BCL: Steps no longer has RC steps, just EDI steps
            foreach step $all_steps {
               set commands [execute_flow $step $format $abort]
               if {$commands != ""} {
                   lappend actions $commands
               }
            }
            if {($vars(user_mode) == "hier") && ($vars(hier_flow_type) == "2pass")} {
               # Only generate steps up to (and including) cts for 2pass flows
               # Go ahead and generate both Makefiles as the actions are known
               if {$vars(enable_dlm)} {
                  set index [lsearch $actions "prects"]
                  FF::gen_makefile [lrange $actions [expr $index+1] end] $vars(mode)
                  file copy -force Makefile Makefile.pass2
                  FF::gen_makefile [lrange $actions 0 $index] $vars(mode)
               } else {
                  set index [lsearch $actions "cts"]
                  FF::gen_makefile [lrange $actions [expr $index+1] end] $vars(mode)
                  file copy -force Makefile Makefile.pass2
                  FF::gen_makefile [lrange $actions 0 $index] $vars(mode)
               }
            } else {
               FF::gen_makefile $actions $vars(mode)
            }
            if {$vars(enable_qor_check)} { 
               FF_EDI::gen_check
            }
            execute_flow debug $format $abort
            if {[info exists vars(run_lec)] && $vars(run_lec)} {
               execute_flow lec $format $abort
            }
         }
         "lec" {
#            puts "-------------------------------------------------"
#            puts "<FF> Generating scripts for $vars(design)"
            puts "-------------------------------------------------"
            if {![info exists vars(netlist)]} {
               puts "<FF> Cannot generate 'lec' step w/o verilog netlist defined"
            } else {
               # BCL: Changed to tcl file mkdir
               file mkdir $vars(script_dir)/EDI
               set op [open $vars(script_dir)/EDI/run_lec.tcl w]
               puts $op "//"
               puts $op "// EDI Foundation Flow Code Generator, [exec date]"
               puts $op "//"
               if {$step == "lec"} {
                  puts $op "tclmode"
               }
               #puts $op "if {\[file exists .ff.tcl\]} {"
               #puts $op "   source .ff.tcl"
               #puts $op "}"
               set varsFile [FF::relPathTo [file normalize $vars(script_dir)/vars.tcl] [file normalize $vars(rundir)]]
               puts $op "if {\[file exists $varsFile\]} {"
               puts $op "   source $varsFile"
               puts $op "}"
               puts $op "source \$vars(script_dir)/procs.tcl"
               puts  "<FF> Generating step $step"
               set commands [FF_EDI::run_lec]
   
               puts $op [FF::pretty_print $commands $format]
               close $op
            }
#            FF::gen_makefile lec $vars(mode)
         }
         "default" {

            #
            # Run each step either singuarly or recursively
            #
            #
            # Create the list of commands that happen at the begining of
            # each script
            #

            if {([lsearch $vars(steps) $step] == -1) && ($step != "debug")} {
               puts  "<FF> ERROR: Unknown Foundation Flow step \"$step\"."
               exit 99
            }

#            if {([lsearch $vars(steps) $step] == -1) && ($step != "debug")} {
#               puts  "<FF> ERROR: Unknown Foundation Flow step \"$step\"."
#               exit 99
#            } else {
#               if {($vars(fix_hold) || (!$vars(fix_hold) && ![regexp "_hold" $step])) &&
#                   !($vars(skip_cts) && (($step == "cts") || [regexp "postcts" $step]))} {
#                  puts  "<FF> Generating step $step"
#               }
#            }

            #
            # We need to ensure that we check the variable contents and
            # initialize the flow at least once in a given run, no matter
            # what step the user wants to execute
            #

#            set header "\n#\n# Commands for $step\n#\n\n"

            if {![info exists vars(all)]} {
               execute_flow check $format $abort
            }
            # BCL: Changed to tcl file mkdir
            file mkdir $vars(script_dir)/EDI
            set commands ""
#            set commands "post-10.10-b009\n"
            if {!$vars(initialized)} {
               set vars(step) $step
               append commands [FF_EDI::initialize_flow]
#               unset vars(step)
               set vars(init_commands) $commands
               set vars(initialized) 1
               if {![info exists vars(warning_count)]} {
                  set vars(warning_count) 0
               }
               if {![info exists vars(error_count)]} {
                  set vars(error_count) 0
               }
            }

            #
            # Get the commands to execute the step.  We also need to get the
            # commands to load the database for that step, assuming that a
            # database exists from a prior step.  Those load commands are
            # prepended to the execution commands.  Save commands are
            # appended
            #
            if {[info commands ::FF_EDI::run_$step] ne ""}  {
               set temp_commands [FF_EDI::run_$step $format]
               if {$temp_commands == ""} {
                  return ""
               } else {
                  set step_commands "\n#-------------------------------------------------------------\n"
                  if {$vars(report_run_time) && ($step != "init")} {
                     append step_commands "set vars(step) ${step}\n"
                     append step_commands "set vars(${step},start_time) \[clock seconds\]\n"
                     append step_commands "#-------------------------------------------------------------\n\n"
                  }
                  append step_commands $temp_commands
                  append step_commands "#-------------------------------------------------------------\n\n"
                  puts  "<FF> Generating step $step"
               }
            } elseif {[info exists vars(custom_step_dir)]} {
               if {[file isfile $vars(custom_step_dir)/run_${step}.tcl]} {
                  puts  "<FF> Generating step $step"
                  set fhr [open $vars(custom_step_dir)/run_$step.tcl r]
                  set step_commands "\n#-------------------------------------------------------------\n"
                  append step_commands "# Sourcing custom script ...\n"
                  append step_commands "#-------------------------------------------------------------\n"
                  if {$vars(report_run_time) && ($step != "init")} {
                     append step_commands "set vars(step) ${step}\n"
                     append step_commands "set vars(${step},start_time) \[clock seconds\]\n"
                     append step_commands "#-------------------------------------------------------------\n\n"
                  }
                  while {[gets $fhr line]>=0} {
                      append step_commands "$line\n"
                  }
#                  append step_commands "source $vars(custom_step_dir)/run_$step.tcl\n"
                  append step_commands "#-------------------------------------------------------------\n\n"
               } else {
                  puts "<FF> ERROR: Unable to generate step $step"
                  set errors($vars(error_count)) "Unable to generate step $step - procedure 'run_$step' must be defined or a \$vars(custom_step_dir)/run_$step.tcl file must be provided"
                  incr vars(error_count)
                  return ""
               }
            } else {
               puts "<FF> ERROR: Unable to generate step $step"
                  set errors($vars(error_count)) "Unable to generate step $step - procedure 'run_$step' must be defined or a \$vars(custom_step_dir)/run_$step.tcl file must be provided"
               incr vars(error_count)
               return ""
            }

            set this_index [lsearch $vars(steps) $step]
            set prior [lindex $vars(steps) [expr $this_index - 1]]
#            if {!$vars(fix_hold) && [regexp _hold $prior]} {
#               set prior [lindex $vars(steps) [expr $this_index - 2]]
#               if {[regexp _hold $prior]} {
#                  set prior [lindex $vars(steps) [expr $this_index - 3]]
#               }
#            }
            if {[regexp _hold $prior] && ([lsearch $vars(fix_hold) [regsub _hold $prior ""]]<0)} {
               set prior [lindex $vars(steps) [expr $this_index - 2]]
               if {[regexp _hold $prior] && ([lsearch $vars(fix_hold) [regsub _hold $prior ""]]<0)} {
                  set prior [lindex $vars(steps) [expr $this_index - 3]]
               }
            }

            if {($step == "route") && $vars(skip_cts)} {
               set prior "prects"
            }

            set no_db_steps [list "init" "rebudget" "flexilm" "assemble" "debug"]
            if {[info exists vars(use_flexmodels)] && $vars(use_flexmodels)} {
               lappend no_db_steps "model_gen"
            } else {
               lappend no_db_steps "feedthrough"
            }
            if {[lsearch $no_db_steps $step] == -1} {
               set load_commands [FF_EDI::load_design $prior $step]
#               set restore_commands [lindex [FF_EDI::load_design $format $prior] 1]
            } else {
               set load_commands ""
#               set restore_commands ""
            }

            if {!$vars(loaded)} {
               set vars(loaded) 1
               append commands $load_commands
            }

            # model_gen saves its database explicitly
            set no_save_steps [list "debug" "model_gen"]
            if {[lsearch $no_save_steps $step] == -1} {
               set save_commands [FF_EDI::save_results $step $format]
            } else {
               set save_commands ""
            }

            #
            # Write the commands to a file, named for the step we are
            # executing
            #

            set op [open $vars(script_dir)/EDI/run_${step}.tcl w]

            if {$vars(debug)} {
#               puts "<DEBUG> Opening file: $vars(script_dir)/EDI/run_${step}.tcl in [exec pwd] -> $op"
            }

            puts $op [string repeat "#" 68]
            puts $op "# EDI Foundation Flow Code Generator, [exec date]"
            puts $op "# Version : 17.10-p003_1"
            puts $op [string repeat "#" 68]
            #puts $op "if {\[file exists .ff.tcl\]} {"
            #puts $op "  source .ff.tcl"
            #puts $op "}"

            if {[file tail [file dirname [pwd]]] != "$vars(partition_dir)"} {
               set varsFile [FF::relPathTo [file normalize $vars(script_dir)/vars.tcl] [file normalize $vars(rundir)]]
            } else {
               set varsFile $vars(script_dir)/vars.tcl
            }
            puts $op "\nif {\[file exists $varsFile\]} {"
            puts $op "   source $varsFile"
            puts $op "}"
            #puts $op "if {\[file exists \$vars(script_dir)/vars.tcl\]} {"
            #puts $op "   source \$vars(script_dir)/vars.tcl"
            #puts $op "}\n"
            if {[file tail [file dirname [pwd]]] != "$vars(partition_dir)"} {
               puts $op "foreach file \$vars(config_files) {"
               puts $op "   source \$file"
               puts $op "}\n"
            }
            puts $op "source \$vars(script_dir)/procs.tcl"
            if {!$format} {
               puts $op $header
            }
            regsub -all "init," $vars(init_commands) "$step," commands
            set of [open $vars(script_dir)/EDI/.head w]
            puts $of [FF::pretty_print $vars(init_commands) $format]
            close $of 
#            set commands ""
            if {($step != "partition") && ($step != "rebudget") && ($step != "flexilm")} {
               if {![regexp _hold $step]} {
                  append commands $load_commands $step_commands $save_commands
               } else {
#                  if {!([lsearch $vars(fix_hold) [regsub _hold $step ""]]<0)} {
#                     append commands $step_commands
#                  } else {
                     append commands $load_commands $step_commands $save_commands
#                  }
               }
#               if {$step == "debug"} {
#                  set vars(step) debug
#               }
            } else {
               append commands $load_commands $step_commands
            }
            lappend vars(bsteps) $step
            set of [open $vars(script_dir)/EDI/.load_$step w]
#            puts $of [FF::pretty_print $restore_commands $format]
            puts $of [FF::pretty_print $load_commands $format]
            close $of
            set of [open $vars(script_dir)/EDI/.$step w]
            puts $of [FF::pretty_print $step_commands $format]
            puts $of [FF::pretty_print $save_commands $format]
            close $of
#            if {[regexp "postroute_si" $step] && $skip_commands != ""} {
#               set commands $skip_commands
#            }
            if {!$format} {
               set commands [FF::strip_lines $commands [list "puts" "#"]]
            }
            if {$vars(catch_errors) && ($step != "debug")} {
               puts $op "\nif { \[catch {\n"
               puts $op [FF::pretty_print $commands $format]
               puts $op "} step_error\]} {\n"
               puts $op "   Puts \"<FF> =========== STEP EXECUTION ERROR ============\""
               puts $op "   Puts \"<FF> ERROR RUNNING STEP '$step'\""
               if {$vars(save_on_catch)} {
                  puts $op "   Puts \"<FF> ---------------------------------------------\""
                  puts $op "   Puts \"<FF> ... SAVING DESIGN TO $vars(dbs_dir)/$vars(step).catch.enc\""
                  if {[string compare -nocase $vars(dbs_format) "oa"]==0} {
                     if {[lindex [split $vars(version) "."]  0] > 10} {
                        puts $op "   saveDesign -cellview {$vars(oa_design_lib) $vars(design) $vars(step).catch}\n"
                     } else {
                        puts $op "   saveOaDesign $vars(oa_design_lib) $vars(design) $vars(step).catch\n"
                     }
                  } else {
                     puts $op "   saveDesign $vars(dbs_dir)/$vars(step).catch.enc -compress\n"
                  }
               } 
               puts $op "   Puts \"<FF> ---------------------------------------------\""
               puts $op "   Puts \"<FF> \$step_error\""
               puts $op "   Puts \"<FF> ------------------- DETAILS ------------------\""
               puts $op "   Puts \"<FF> \$errorInfo\""
               puts $op "   Puts \"<FF> ==============================================\""
               if {$vars(batch)} {
                  puts $op "   exit -1"
               }
               puts $op "}"
            } else {
               puts $op [FF::pretty_print $commands $format]
            }
            if {$vars(batch) && ($step != "debug")} {
               puts $op "if {!\[info exists vars(single)\]} {\n   exit 0\n}\n"
            }

            close $op

            set action $step

#            if [file isdirectory $vars(script_dir)/ETC] {
#               file delete -force $vars(script_dir)/ETC
#            }
#            file mkdir $vars(script_dir)/ETC
#            file copy -force $vars(script_path)/ETC/applet.tcl $vars(script_dir)/ETC
#            file copy -force $vars(script_path)/ETC/compatibility.tcl $vars(script_dir)/ETC
#            file copy -force $vars(script_path)/ETC/applets $vars(script_dir)/ETC


         }
      }

      #
      # Create a file that sets up all of the variable settings that were
      # used in this invocation
      #

   # GDG - is this needed anymore
   if {0} {
      # BCL: Changed to tcl file mkdir
      file mkdir $vars(script_dir)
      set op [open $vars(script_dir)/vars.tcl w]
      puts $op "# this is the one"
      puts $op "if {!\[info exists vars\]} {"
      puts $op "   global vars"
      puts $op "}"
#      if {[info exists vars(user_arrays)]} {
#         foreach array $vars(user_arrays) {
#            puts $op "#----------------------------------------------"
#            puts $op "global $array"
#            set cmd  "array names $array"
#            set uvars [eval $cmd]
#            foreach var $uvars {
#               if {[regexp {\$} $vars($var)]} {
#                 puts $op "set $array($var) \"$$array($var)\""
#               } else {
#                 puts $op "set $array($var) \{$array($var)\}"
#               }
#            }
#         }
#      }
      ## BCL: Added sourcing .ff.tcl to vars.tcl
      #puts $op "if {\[file exists .ff.tcl\]} {"
      #puts $op "  source .ff.tcl"
      #puts $op "}"
      puts $op "global env\n\n"
      puts $op "#----------------------------------------------"
      puts $op "set env(VPATH) $env(VPATH)"
      puts $op "set vars(rundir) $vars(rundir)"
      foreach var [lsort [array names vars]] {
         # BCL: Only write out variable values in curlies if not using $vars() in the value of the variable
         if {[regexp {\$} $vars($var)]} {
           puts $op "set vars($var) \"$vars($var)\""
         } else {
           puts $op "set vars($var) \{$vars($var)\}"
         }
      }
      puts $op "set vars(restore_design) {true}"
#      if {[info exists vars(cpf_file)]} {
#         puts $op "catch {alias ff_modify_power_domains FF_EDI::modify_power_domains}"
#         puts $op "catch {alias ff_add_power_switches FF_EDI::add_power_switches}"
#         puts $op "catch {alias ff_route_secondary_pg_nets FF_EDI::route_secondary_pg_nets}"
#         puts $op "catch {alias ff_get_power_domains FF_EDI::get_power_domains}"
#         puts $op "catch {alias ff_buffer_always_on_nets FF_EDI::buffer_always_on_nets}"
#         puts $op "catch {alias ff_insert_welltaps_endcaps FF_EDI::insert_welltaps_endcaps}"
#      }
      close $op
   }

      return $action
   }

   proc gen_postload {} {

      global vars

      set vars(gen_postload) true
      execute_flow "source" 1 0
      set save $vars(flat)
      set vars(flat) full
      set header [string repeat "#" 68]
      append header "\n# EDI Foundation Flow Code Generator, [exec date]\n"
      append header "# Version : 17.10-p003_1\n"
      append header [string repeat "#" 68]
#      append header "if {\[file exists \$vars(script_dir)/vars.tcl\]} {"

      set varsFile [FF::relPathTo [file normalize $vars(script_dir)/vars.tcl] [file normalize $vars(rundir)]]
      append header "\nif {\[file exists $varsFile\]} {\n"
      append header "   source $varsFile\n"
      append header "}\n"
      #append header "source \$vars(script_dir)/vars.tcl"
#      append header "}"
#      append header "\nif {!\[info exists vars\]} {\n"
#      append header "   source $vars(script_dir)/vars.tcl\n"
#      append header "}\n"
      append header "foreach file \$vars(config_files) {\n"
      append header "   source \$file\n"
      append header "}\n"
      append header "source $vars(script_dir)/procs.tcl\n"
#      if {[info exists vars(cpf_file)]} {
#         save cpf_file $vars(cpf_file)
#         unset vars(cpf_file)
#      }
      append header "set vars(step) rcp\n"
      set timing_commands [FF_EDI::initialize_timing mmmc]
      set init_commands [FF_EDI::run_init 0]
      set place_commands [FF_EDI::run_place 0]  

      set commands [FF_EDI::initialize_flow]
#      append commands $timing_commands 
      append commands $init_commands 
      append commands $place_commands

      set commands [regsub placeDesign $commands @]

      set before [string range $commands 0 [expr [string first @ $commands] - 1]]

#      if {[info exists cpf_file]} {
#         unset vars(cpf_file) $cpf_file
#      }
      unset vars(gen_postload)
      set var(flat) $save
      set return_string $header
      append return_string $before
#      return $before
      return $return_string
   }

   proc gen_preexport {} {

      global vars

      set save $vars(flat)
      set vars(flat) full
      set header [string repeat "#" 68]
      append header "\n# EDI Foundation Flow Code Generator, [exec date]\n"
      append header "# Version : 17.10-p003_1\n"
      append header [string repeat "#" 68]

      set varsFile [FF::relPathTo [file normalize $vars(script_dir)/vars.tcl] [file normalize $vars(rundir)]]
      append header "\nif {\[file exists $varsFile\]} {\n"
      append header "   source $varsFile\n"
      append header "}\n"
      #append header "\nif {!\[info exists vars\]} {\n"
      #append header "   source $vars(script_dir)/vars.tcl\n"
      #append header "}\n"

      append header "foreach file \$vars(config_files) {\n"
      append header "   source \$file\n"
      append header "}\n"
      append header "source $vars(script_dir)/procs.tcl\n"

      set place_commands [FF_EDI::run_place 0]  
      set prects_commands [FF_EDI::run_prects 0]

      set commands $place_commands
      append commands $prects_commands

      set commands [regsub placeDesign $commands @]

      set after [string trim [string range $commands [expr [string first @ $commands] + 1] \
                [string length $commands]] ""]

      set var(flat) $save

      return $after
   }
   proc insert_comments {} {

      global vars

      set comments ""
      append comments "######################################################################\n"
      append comments "# Variables affecting this step:\n"
      append comments "#---------------------------------------------------------------------\n"
      if {[info exists vars(comments)]} {
         append comments $vars(comments)
         unset vars(comments)
      } else {
         append comments "#    No variables defined for this step ...\n"
      }
      append comments "######################################################################\n"
      if {[info exists vars(ucomments)]} {
         append comments "# Additional variables for this step:\n"
         append comments "#---------------------------------------------------------------------\n"
         append comments $vars(ucomments)
         append comments "######################################################################\n"
         unset vars(ucomments)
      }
      return $comments
   }

   proc run_all {} {
 
      global vars

      set time 0
      set index 0
      set stop_step signoff
      set vars(codegen) false
      if {![info exists vars(vpath)]} { set vars(vpath) make }
      
      foreach step $vars(steps) {
         if {[file exists $vars(vpath)/$step]} {
            if {[file mtime $vars(vpath)/$step] > $time} {
               if {[lindex $vars(steps) $index] == "signoff"} {
                  Puts "<FF> STEP signoff COMPLETE ... NOTHING TO DO"
               } else {
                  set start_step [lindex $vars(steps) [expr $index + 1]]
               }
            }
         } else {
            set start_step $step
            break
         }
         incr index
      }
      
      puts "<FF> -----------------------------------------------------"
      if {$start_step == $stop_step} {
         puts "<FF> RUNNING STEP $start_step ..."
      } else {
         puts "<FF> RUNNING STEP $start_step through $stop_step ..."
      }
      puts "<FF> -----------------------------------------------------"
      sleep 5
      
      #
      # Emulate the functionality of the "make" program.  If a file doesn't exist,
      # or if it's predecessor step has executed more recently, run the current
      # step and update the time/date stamps of the files we track progress with
      #
      
      set vars(stop_step) $stop_step
      
      set last_step ""
      set vars(restore_design) 1
      if {$vars(enable_qor_check)} {
         set check_qor $vars(script_dir)/check_qor.tcl
      }
      exec mkdir -p make
      foreach step $vars(steps) {
         set vars(step) $step
         Puts "<FF> STEP $vars(step) ..."
         set this_semaphore "$vars(vpath)/$step"
         set last_semaphore "$vars(vpath)/$last_step"
      
         set run_step false
         if {![file exists $this_semaphore]} {
            set run_step true
         } elseif {$last_step != ""} {
            file stat $this_semaphore this_stat
            file stat $last_semaphore last_stat
            if {$this_stat(mtime) < $last_stat(mtime)} {
               set run_step true
            }
         }
      
         #
         # Check the quality of results from the last step.  If the results aren't
         # as expected, don't proceed to the next step
         #
         if {$vars(enable_qor_check)} {
            if {$step != "init"} {
               set qor [catch {exec $check_qor $last_semaphore} msg]
               if {$qor} {
                  puts "<FF> ERROR: QOR RESULT CHECK INDICATES A PROBLEM IN STEP $last_step"
                  exit -111
               }
            }
         }
      
         set last_step $step
         if {!$run_step} {
            continue
         }
      
         #
         # Source the control file that runs the step.  If it had an error, exit
         # immediately.  Otherwise, update the time/date stamp of the corresponding
         #
         #
      
         if {[catch {FF_EDI::run_$step} message]} {
            puts $message
            exit -111
         }
         set vars(restore_design) 0
      
         #
         # If there is a QOR check file for this step, execute it and place the
         # result into the make file.  Otherwise just touch the file
         #
      
         if {$vars(enable_qor_check)} {
            if {[info exists vars($step,qor_tcl]} {
               set qor_file $vars($step,qor_tcl)
               if {[file exists $qor_file]} {
                  set qor [catch {exec $qor_file} msg]
                  set make_file [open $this_semaphore w]
                  puts $make_file "$qor"
                  close $make_file
               }
            }
         }
         exec /bin/touch $this_semaphore
      
         if {$step == $stop_step} {
            Puts "<FF> Done" 
         }
      }
   }
}
namespace eval ff_edi:: {
   proc run_init {} {
      uplevel #0 eval [FF_EDI::run_init]
   }
   proc run_place {} {
      uplevel #0 eval [FF_EDI::run_place]
   }
   proc run_prects {} {
      uplevel #0 eval [FF_EDI::run_prects]
   }
   proc run_cts {} {
      uplevel #0 eval [FF_EDI::run_cts]
   }
   proc run_postcts {} {
      uplevel #0 eval [FF_EDI::run_postcts]
   }
   proc run_postcts_hold {} {
      uplevel #0 eval [FF_EDI::run_postcts_hold]
   }
   proc run_route {} {
      uplevel #0 eval [FF_EDI::run_route]
   }
   proc run_postroute {} {
      uplevel #0 eval [FF_EDI::run_postroute]
   }
   proc run_postroute_hold {} {
      uplevel #0 eval [FF_EDI::run_postroute_hold]
   }
   proc run_postroute_si_hold {} {
      uplevel #0 eval [FF_EDI::run_postroute_si_hold]
   }
   proc run_postroute_si {} {
      uplevel #0 eval [FF_EDI::run_postroute_si]
   }
   proc run_signoff {} {
      uplevel #0 eval [FF_EDI::run_signoff]
   }
   proc run_assemble {} {
      uplevel #0 eval [FF_EDI::run_assemble]
   }
   proc run_rebudget {} {
      uplevel #0 eval [FF_EDI::run_rebudget]
   }
   proc run_flexilm {} {
      uplevel #0 eval [FF_EDI::run_flexilm]
   }
   proc run_partition {} {
      uplevel #0 eval [FF_EDI::run_partition]
   }
   proc run_lec {} {
      uplevel #0 eval [FF_EDI::run_lec]
   }
   proc run_all {} {
      uplevel #0 FF_EDI::run_all
   }
   proc help {args} {
      uplevel #0 FF::help $args
   }
}
