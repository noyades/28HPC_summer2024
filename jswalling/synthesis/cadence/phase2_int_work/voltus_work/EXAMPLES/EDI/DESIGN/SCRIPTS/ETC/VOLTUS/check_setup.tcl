###############################################################################
#                       CADENCE COPYRIGHT NOTICE
#         © 2008-2013 Cadence Design Systems, Inc. All rights reserved.
#------------------------------------------------------------------------------
#
# This Foundation Flow is provided as an example of how to perform specialized
# tasks within Voltus IC Power Integrity Solution.
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

################################################################################
# The setup and eps_config verification script for EPS FF
################################################################################

global vars

source setup.tcl
source eps_config.tcl
source SCRIPTS/ETC/EPS/default_settings.tcl

set check(files) [list]
set check(lib_files) [list]
set check(lef_files) [list]
set check(pgv_files) [list]
set check(plugins) [list]
set check(pwr_inc_files) [list]
set check(pwr_data_files) [list]
set check(vstorm_inc_files) [list]
set check(spice_files) [list]
set check(pp_files) [list]
set check(req_eps_analysis) [list]
set check(dynamic_rail_gds_files) [list]
set check(decap_gds_files) [list]
set check(twf_files) [list]
set check(activity_files) [list]
set check(package_files) [list]
set check(em_model_file) [list]
set vars(req_eps_rail_analysis) [list]
set vars(req_eps_pwr_analysis) [list]
set design_error 0
set count 0
set abort 0

if {![info exists vars(abort)]} {
   set vars(abort) 1
}

Puts "<FF> =============================================="
Puts "<FF>  EPS Foundation Flow Version: post-10.10-d003 "
Puts "<FF> =============================================="
Puts "<FF>       EPS Foundation Flow Requirements"
if {[info exists vars(flow)] && (($vars(flow) == "default") || ($vars(flow) == "cpf"))} {
   Puts "<FF> =============================================="
   Puts "<FF>       The defined flow type is $vars(flow)"
} else {
   Puts "<FF> =============================================="
   Puts "<FF> ERROR: Required variable vars(flow) not defined"
   set errors($abort) "The proper variable for vars(flow) must be defined"
   incr abort
}

Puts "<FF> =============================================="
Puts "<FF>          Design Requirement Files"
Puts "<FF> =============================================="
if {[info exists vars(EDI_design)]} {
   set vars(design_req_files) "EDI_design"
} else {
   if {[info exists vars(flow)] && ($vars(flow) == "cpf")} {
      set vars(design_req_files) "netlist def_file cpf_file design"
   } else {
      set vars(design_req_files) "netlist def_file sdc_file design"
   }
   set vars(lib_req_files) "timing lef_files"
}
set vars(parasitic_req_files) "common_spef" ;# max_spef min_spef"

if {[info exists vars(design_req_files)]} {
   if {$vars(design_req_files) == "EDI_design"} {
      lappend check(files) $vars($vars(design_req_files))
      Puts "<FF> INFO:    $vars(design_req_files) = $vars($vars(design_req_files))"
   } else {
      foreach required $vars(design_req_files) {
         if {($required != "sdc_file") && (![info exists vars($required)]) ||
             ([info exists vars($required)] && ($vars($required) == ""))} {
            set design_error 1
         }
      }
      if {$design_error == 1} {
         set design_error 0
         Puts "<FF> ERROR: Either EDI_design or The following design files must be defined"
         Puts "<FF>"
         set errors($abort) "Either EDI_design or The 3rd party design files must be defined"
         incr abort
      }
      foreach required $vars(design_req_files) {
         if {[info exists vars($required)] && ($vars($required) != "")} {
            set first 1
            foreach file $vars($required) {
               if {$first == 1} {
                  Puts "<FF> INFO:    $required = $file"
                  set first 0
               } else {
                  Puts "<FF> INFO:                $file"
               }
               if {$required != "design"} {
                  lappend check(files) $file
               }
            }
         } else {
            if {$required == "def_file"} {
               Puts "<FF> ERROR: Required file vars($required) not defined,\
                                 can continue ONLY STATIC_POWER_ANALYSIS..."
               set errors($abort) "3rd party required file vars($required) not defined"
               incr abort
            } elseif {$required == "design"} {
               Puts "<FF> ERROR: Required top_design variable vars($required) not defined"
               set errors($abort) "3rd party top_design variable vars($required) not defined"
               incr abort
            } elseif {$required == "sdc_file"} {
               Puts "<FF> WARNING: 3rd party design file vars($required) not defined ... continuing "
               ## set errors($abort) " 3rd party design file vars($required) not defined"
               ## incr abort
            } else {
               Puts "<FF> ERROR: Required file vars($required) not defined"
               set errors($abort) "3rd party required file vars($required) not defined"
               incr abort
            }
         }
      }
   }
}

if {[info exists vars(flow)] && ($vars(flow) == "cpf")} {
   Puts "<FF> =============================================="
   Puts "<FF>                 RC Corners"
   Puts "<FF> =============================================="
   if {[info exists vars(rc_corners)]} {
      set check(rc_corners) [list]
      Puts "<FF> INFO: The RC_Corners : $vars(rc_corners)"
   } else {
      Puts "<FF> WARNING: RC Corners information does not exist... continuing"
   }
}

Puts "<FF> =============================================="
Puts "<FF>           Parasitics file information"
Puts "<FF> =============================================="
if {[info exists vars(parasitic_req_files)]} {
   foreach required $vars(parasitic_req_files) {
      if {[info exists vars($required)] && ($vars($required) != "")} {
            set first 1
            foreach file $vars($required) {
               if {$first == 1} {
                  Puts "<FF> INFO:    $required = $file"
                  set first 0
               } else {
                  Puts "<FF> INFO:                $file"
               }
               lappend check(files) $file
            }
         incr count
      }
   }
}

if {[info exists vars(flow)] && ($vars(flow) == "cpf")} {
   if {[info exists vars(rc_corners)]} {
      foreach rc_corner $vars(rc_corners) {
         if {[info exists vars($rc_corner,spef)]} {
            if {[file exists $vars($rc_corner,spef)]} {
               incr count
               Puts "<FF> INFO: The spef file for $rc_corner: $vars($rc_corner,spef)"
            } else {
               Puts "<FF> ERROR: spef file for $rc_corner vars($rc_croner,spef) is not defined"
               set errors($abort) "spef file for $rc_corner vars($rc_corner,spef) is not defined"
               incr abort 
            }
         }
      }
   }
}

if {$count == 0} {
   if {[info exists vars(EDI_design)]} {
      if {[file exists $vars(EDI_design).dat/$vars(design).rcdb.d]} {
         Puts "<FF> INFO: The .enc database contains rcdb file"
      } else {
         Puts "<FF> ERROR: Specify alteast 1-spef, as .enc database donot contain rcdb file"
         set errors($abort) "Specify alteast 1-spef, as .enc database donot contain rcdb file"
         incr abort 
      }
   } else {
      Puts "<FF> ERROR: spef file is not defined, at least 1-spef file needs to be defined"
      set errors($abort) "spef file is not defined, at least 1-spef file needs to be defined"
      incr abort 
   }
}
set count 0

Puts "<FF> =============================================="
Puts "<FF>              Library Information"
Puts "<FF> =============================================="
Puts "<FF>           Power-Grid View Libraries"
if {[info exists vars(library_sets)]} {
   foreach library_set $vars(library_sets) {
      Puts "<FF> INFO: $library_set:"
      if {[info exists vars($library_set,cl_views)] && ($vars($library_set,cl_views) != "")} {
         Puts "<FF> INFO:    cl_views = "
         foreach lib $vars($library_set,cl_views) {
            lappend check(pgv_files) $lib
            Puts "<FF> INFO:       $lib"
         }
      } else {
         Puts "<FF> WARNING: Atleast one set of required cl_views must be defined"
         # Puts "<FF> ERROR: Required files vars($library_set,cl_views) not defined"
         # set errors($abort) "Required files vars($library_set,cl_views) not defined"
         # incr abort
      }
   }
} else {
   Puts "<FF> ERROR: Required variable vars(library_sets) not defined"
   set errors($abort) "Required variable vars(library_sets) not defined"
   incr abort
}
if {![info exists vars(EDI_design)]} {
   Puts "<FF> =============================================="
   Puts "<FF>               Timing Libraries"
   if {[info exists vars(library_sets)]} {
      foreach library_set $vars(library_sets) {
         if {[info exists vars(lib_req_files)]} {
            Puts "<FF> INFO: $library_set:"
            if {[info exists vars($library_set,timing)] && ($vars($library_set,timing) != "")} {
               Puts "<FF> INFO:    timing = "
               foreach lib $vars($library_set,timing) {
                  lappend check(lib_files) $lib
                  Puts "<FF> INFO:       $lib"
               }
            } else {
               Puts "<FF> ERROR: Required files vars($library_set,timing) not defined"
               set errors($abort) "Required files vars($library_set,timing) not defined"
               incr abort
            }
         }
      }

   } else {
      Puts "<FF> ERROR: Required variable vars(library_sets) not defined"
   }
}

if {![info exists vars(EDI_design)]} {
   Puts "<FF> =============================================="
   Puts "<FF>              Physical Libraries"
   if {[info exists vars(lib_req_files)]} {
      if {[info exists vars(lef_files)] && ($vars(lef_files) != "")} {
         Puts "<FF> INFO:    lef_files = "
         foreach lib $vars(lef_files) {
            lappend check(lef_files) $lib
            Puts "<FF> INFO:       $lib"
         }
      } else {
         ## Puts "<FF> WARNING: files vars(lef_files) not defined... continuing"
         Puts "<FF> ERROR: Required files vars(lef_files) not defined"
         set errors($abort) "Required files vars(lef_files) not defined"
         incr abort
      }
   }
}

if {[info exists vars(flow)] && ($vars(flow) == "cpf")} {
   Puts "<FF> =============================================="
   Puts "<FF>               Analysis Views"
   Puts "<FF> =============================================="
   if {[info exists vars(setup_analysis_view)] && ($vars(setup_analysis_view) != "") && 
       [info exists vars(hold_analysis_view)] && ($vars(hold_analysis_view) != "")} {
      set vars(analysis_views) "$vars(setup_analysis_view) $vars(hold_analysis_view)"
   } elseif {[info exists vars(setup_analysis_view)] && ($vars(setup_analysis_view) != "")} {
      set vars(analysis_views) "$vars(setup_analysis_view)"
   } elseif {[info exists vars(hold_analysis_view)] && ($vars(hold_analysis_view) != "")} {
      set vars(analysis_views) "$vars(hold_analysis_view)"
   }
   if {[info exists vars(analysis_views)] && ($vars(analysis_views) != "")} {
      foreach analysis_view $vars(analysis_views) {
         Puts "<FF> INFO: setup/hold_analysis_view:"
         if {($analysis_view != "")} {
            Puts "<FF> INFO:    analysis_view = $analysis_view"
            lappend check(analysis_view) $analysis_view
         } else {
            Puts "<FF> ERROR: Required variable vars(setup/hold_analysis_view) not defined"
            set errors($abort) "Required variable vars(setup/hold_analysis_view) not defined"
            incr abort
         }
      }
   } else {
      Puts "<FF> ERROR: Required variable vars(setup/hold_analysis_view) not defined"
      set errors($abort) "Required variable vars(setup/hold_analysis_view) not defined"
      incr abort
   }
}

Puts "<FF> =============================================="
Puts "<FF>                 Plug-ins"
Puts "<FF> =============================================="
foreach plugin "pre_static_power_tcl post_static_power_tcl \
                pre_static_rail_tcl post_static_rail_tcl \
                pre_dynamic_power_tcl post_dynamic_power_tcl \
                pre_dynamic_rail_tcl post_dynamic_rail_tcl \
                pre_powerup_tcl post_powerup_tcl pre_powerup_rail_tcl \
                post_powerup_rail_tcl pre_decap_tcl post_decap_tcl" {
   if {[info exists vars($plugin)] && ($vars($plugin) != "")} {
      Puts "<FF> INFO: Plug-in $plugin = $vars($plugin)"
      lappend check(plugins) $vars($plugin)
   } else {
      Puts "<FF> INFO: Plug-in $plugin not defined"
   }  
}

if {[info exists vars(timing_window_files)]} {
   Puts "<FF> =============================================="
   Puts "<FF>        Timing Window Format Files"
   Puts "<FF> =============================================="
   foreach file_name $vars(timing_window_files) {
      if {[info exists vars($file_name,file)] && ($vars($file_name,file) != "")} {
         Puts "<FF> INFO: $file_name file = $vars($file_name,file)"
         lappend check(twf_files) $vars($file_name,file)
      } else {
         Puts "<FF> WARNING: Required file vars($file_name,file) not defined"
      }
   }
}

if {[info exists vars(activity_vectors)]} {
   Puts "<FF> =============================================="
   Puts "<FF>            Activity Vector Files"
   Puts "<FF> =============================================="
   foreach file_name $vars(activity_vectors) {
      if {[info exists vars($file_name,activity_file)] && ($vars($file_name,activity_file) != "")} {
         if {[info exists vars($file_name,format)] && ($vars($file_name,format) != "")} {
            Puts "<FF> INFO: $file_name $vars($file_name,format) file = $vars($file_name,activity_file)"
         } else {
            Puts "<FF> ERROR: Required variable vars($file_name,format) not defined"
            set errors($abort) "Required variable vars($file_name,format) not defined"
            incr abort
         }
         lappend check(activity_files) $vars($file_name,activity_file)
      } else {
         Puts "<FF> WARNING: Required file vars($file_name,activity_file) not defined"
      }
   }
}

if {[info exists vars(package,spice_model)] || [info exists vars(package,mapping)]} {
   Puts "<FF> =============================================="
   Puts "<FF>             Package Model Files"
   Puts "<FF> =============================================="
   if {[info exists vars(package,spice_model)] && ($vars(package,spice_model) != "")} {
      Puts "<FF> INFO: Package spice_model file = $vars(package,spice_model)"
      lappend check(package_files) $vars(package,spice_model)
   } else {
      Puts "<FF> ERROR: Required file vars(package,spice_model) not defined"
      set errors($abort) "Required file vars(package,spice_model) not defined"
      incr abort
   }
   if {[info exists vars(package,mapping)] && ($vars(package,mapping) != "")} {
      Puts "<FF> INFO: Package mapping file = $vars(package,mapping)"
      lappend check(package_files) $vars(package,mapping)
   } else {
      Puts "<FF> ERROR: Required file vars(package,mapping) not defined"
      set errors($abort) "Required file vars(package,mapping) not defined"
      incr abort
   }
}

if {[info exists vars(em_models_file)]} {
   Puts "<FF> =============================================="
   Puts "<FF>       Electromigration(EM) Model File"
   Puts "<FF> =============================================="
   if {$vars(em_models_file) != ""} {
      Puts "<FF> INFO: EM model file = $vars(em_models_file)"
      lappend check(em_model_file) $vars(em_models_file)
   } else {
      Puts "<FF> ERROR: Required file vars(em_models_file) not defined"
      set errors($abort) "Required file vars(em_models_file) not defined"
      incr abort
   }
}

## The EPS FF supported EPS analysis types, their options to be verified 
set vars(eps_analysis_types) "static_power static_rail \
                              dynamic_power dynamic_rail \
                              powerup powerup_rail decap \
                              jitter_power jitter_rail"

Puts "<FF> =============================================="
Puts "<FF>       The EPS FF set for the following"
Puts "<FF>             EPS Analysis Types"
Puts "<FF> =============================================="
set first 1
foreach analysis $vars(eps_analysis_types) {
   if {[info exists vars($analysis)] && ($vars($analysis) == "true")} {
      if {$first == 1} {
         Puts "<FF> INFO: Analysis Types: $analysis"
         set first 0
      } else {
         Puts "<FF> INFO:                 $analysis"
      }
      lappend check(req_eps_analysis) $analysis
   }
}

if {[info exists check(req_eps_analysis)] && ($check(req_eps_analysis) == "")} {
   Puts "<FF> WARNING: There is no EPS Analysis types defined"
}

if {[info exists vars(distribute)]} {
   Puts "<FF> =============================================="
   Puts "<FF>        The EPS tool control Settings:"
   Puts "<FF> =============================================="
   if {$vars(distribute) == "local"} {
      Puts "<FF> INFO: The job distribution type = $vars(distribute)"
      Puts "<FF> INFO: Number of Local Host CPUs = $vars(local_cpus)"
   } elseif {$vars(distribute) == "rsh"} {
      Puts "<FF> INFO: The job distribution type = $vars(distribute)"
      if {[info exists vars(remote_hosts)]} {
         Puts "<FF> INFO: Number of Remote Hosts = $vars(remote_hosts)"
      } else {
         Puts "<FF> ERROR: Required variable vars(remote_hosts) not defined"
         set errors($abort) "Required variable vars(remote_hosts) not defined"
         incr abort
      }
      if {[info exists vars(cpu_per_remote_host)]} {
         Puts "<FF> INFO: Number of CPUs per Remote Host = $vars(cpu_per_remote_host)"
      } else {
         Puts "<FF> ERROR: Required variable vars(cpu_per_remote_host) not defined"
         set errors($abort) "Required variable vars(cpu_per_remote_host) not defined"
         incr abort
      }
      if {[info exists vars(rsh,host_list)]} {
         Puts "<FF> INFO: Remote Hosts list = $vars(rsh,host_list)"
      } else {
         Puts "<FF> ERROR: Required variable vars(rsh,host_list) not defined"
         set errors($abort) "Required variable vars(rsh,host_list) not defined"
         incr abort
      }
   } elseif {$vars(distribute) == "lsf"} {
      Puts "<FF> INFO: The job distribution type = $vars(distribute)"
      if {[info exists vars(lsf,queue)]} {
         Puts "<FF> INFO: LSF Queue = $vars(lsf,queue)"
      } else {
         Puts "<FF> ERROR: Required variable vars(lsf,queue) not defined"
         set errors($abort) "Required variable vars(lsf,queue) not defined"
         incr abort
      }
      if {[info exists vars(lsf,resource)]} {
         Puts "<FF> INFO: LSF Resource = $vars(lsf,resource)"
      } else {
         Puts "<FF> ERROR: Required variable vars(lsf,resource) not defined"
         set errors($abort) "Required variable vars(lsf,resource) not defined"
         incr abort
      }
      if {[info exists vars(lsf,args)]} {
         Puts "<FF> INFO: LSF Args = $vars(lsf,args)"
      } else {
         Puts "<FF> ERROR: Required variable vars(lsf,args) not defined"
         set errors($abort) "Required variable vars(lsf,args) not defined"
         incr abort
      }
   } elseif {$vars(distribute) == "custom"} {
      Puts "<FF> INFO: The job distribution type = $vars(distribute)"
      if {[info exists vars(custom,script)]} {
         Puts "<FF> INFO: LSF Custom Script = $vars(custom,script)"
      } else {
         Puts "<FF> ERROR: Required variable vars(custom,script) not defined"
         set errors($abort) "Required variable vars(custom,script) not defined"
         incr abort
      }
   } else {
      Puts "<FF> ERROR: Required variable vars(distribute) not defined"
      set errors($abort) "Required variable vars(distribute) not defined"
      incr abort
   }
}

foreach analysis $check(req_eps_analysis) {
   if {($analysis == "static_power") || ($analysis == "dynamic_power") || ($analysis == "powerup") || ($analysis == "jitter_power")} {
      lappend vars(req_eps_pwr_analysis) $analysis
   }
}

if {[info exists vars(req_eps_pwr_analysis)] && ($vars(req_eps_pwr_analysis) != "")} {
   set first 1
   foreach analysis $vars(req_eps_pwr_analysis) {
      if {$analysis == "dynamic_power"} {
         set vars(file_name) "dynamic_power_include_file"
      } elseif {$analysis == "powerup"} {
         set vars(file_name) "powerup_power_include_file"
      }

      if {[info exists vars(file_name)] && [info exists vars($vars(file_name))]} {
         if {$first == 1} {
            Puts "<FF> =============================================="
            Puts "<FF>         Checking Power-include Files"
            Puts "<FF> =============================================="
            Puts "<FF> INFO: $vars(file_name) = $vars($vars(file_name))"
            set first 0
         } else {
            Puts "<FF> INFO: $vars(file_name) = $vars($vars(file_name))"
         }
            lappend check(pwr_inc_files) $vars($vars(file_name))
            unset vars(file_name)
      }
   }

   Puts "<FF> =============================================="
   Puts "<FF>            Power Analysis Options"
   foreach analysis $vars(req_eps_pwr_analysis) {
      if {$analysis == "static_power"} {
         Puts "<FF> =============================================="
         Puts "<FF> INFO: There is NO Mandatory options for $analysis ANALYSIS:"
         Puts "<FF> =============================================="
         Puts "<FF> INFO: User set & Default options for $analysis ANALYSIS:"
         if {$vars(flow) == "cpf"} {
            if {[info exist vars($analysis,analysis_view)]} {
               Puts "<FF> INFO:     analysis_view = $vars($analysis,analysis_view)"
            } else {
               Puts "<FF> WARNING: Required variable vars($analysis,analysis_view) not defined... continuing"
               # set errors($abort) "Required variable vars($analysis,analysis_view) not defined"
               # incr abort
            }
         }
         foreach pwr_option "corner off_pg_nets" {
            if {[info exists vars($analysis,$pwr_option)]} {
               Puts "<FF> INFO:     $pwr_option = $vars($analysis,$pwr_option)"
            }
         }
      }
   ## 

   ## foreach analysis $vars(req_eps_pwr_analysis) 
      if {($analysis == "dynamic_power") || ($analysis == "jitter_power")} {
         Puts "<FF> =============================================="
         if {[info exists vars(dynamic_power,method)] && ($vars(dynamic_power,method) == "dynamic_vectorbased")} {
            Puts "<FF> INFO: Mandatory options for $analysis ANALYSIS:"
            if {$check(activity_files) == ""} {
               Puts "<FF> ERROR: This is vector based analysis, Activity files are not defined"
               set errors($abort) "$analysis analysis is vector based, Activity files are not defined"
               incr abort
            } else {
               Puts "<FF> INFO: This is vector based analysis, Activity files are defined"
            }
         } else {
            Puts "<FF> INFO: There is NO Mandatory options for $analysis ANALYSIS:"
         }
         Puts "<FF> =============================================="
         Puts "<FF> INFO: User set & Default options for $analysis ANALYSIS:"
         if {$vars(flow) == "cpf"} {
            if {[info exist vars(dynamic_power,analysis_view)]} {
               Puts "<FF> INFO:     analysis_view = $vars(dynamic_power,analysis_view)"
            } else {
               Puts "<FF> WARNING: Required variable vars(dynamic_power,analysis_view) not defined... continuing"
               # set errors($abort) "Required variable vars(dynamic_power,analysis_view) not defined"
               # incr abort
            }
         }
         foreach pwr_option "method corner off_pg_nets" {
            if {[info exists vars(dynamic_power,$pwr_option)]} {
               Puts "<FF> INFO:     $pwr_option = $vars(dynamic_power,$pwr_option)"
            }
         }
      }
   ##  

   ## foreach analysis $vars(req_eps_pwr_analysis) 
      if {$analysis == "powerup"} {
         Puts "<FF> =============================================="
         Puts "<FF> INFO: Mandatory options for $analysis ANALYSIS:"
         if {[info exists vars($analysis,method)] && ($vars($analysis,method) == "dynamic_vectorbased")} {
            if {$check(activity_files) == ""} {
               Puts "<FF> ERROR: This is vector based analysis, Activity files are not defined"
               set errors($abort) "$analysis analysis is vector based, Activity files are not defined"
               incr abort
            } else {
               Puts "<FF> INFO: This is vector based analysis, Activity files are defined"
            }
         }
         foreach pwr_option "alwayson_net off_pg_nets powerup_pg_nets resolution" {
            if {[info exists vars($analysis,$pwr_option)]} {
               Puts "<FF> INFO:     $pwr_option\t = $vars($analysis,$pwr_option)"
            } else {
               Puts "<FF> ERROR: Required variable vars($analysis,$pwr_option) not defined"
               set errors($abort) "Required variable vars($analysis,$pwr_option) not defined"
               incr abort
            }
         }
         if {[info exists vars($analysis,period)]} {
            Puts "<FF> INFO:     period\t\t = $vars($analysis,period)"
         } else {
            Puts "<FF> ERROR: Required variable vars($analysis,period) not defined"
            set errors($abort) "Required variable vars($analysis,period) not defined"
            incr abort
         }
         if {[info exists vars($analysis,pin_stimulus)]} {
            Puts "<FF> INFO:     pin_stimulus\t = $vars($analysis,pin_stimulus)"
         } elseif {[info exists vars($analysis,default_stimulus)]} {
            Puts "<FF> INFO:     default_stimulus\t = $vars($analysis,default_stimulus)"
         } else {
            Puts "<FF> ERROR: Required variable vars($analysis,default_stimulus/pin_stimulus) not defined"
            set errors($abort) "Required variable vars($analysis,default_stimulus/pin_stimulus) not defined"
            incr abort
         }
         if {[info exists vars($analysis,spice_corners)]} {
            Puts "<FF> INFO:     spice_corners\t = $vars($analysis,spice_corners)"
         } else {
            Puts "<FF> ERROR: Required variable vars($analysis,spice_corners) not defined"
            set errors($abort) "Required variable vars($analysis,spice_corners) not defined"
            incr abort
         }
         foreach pwr_option "spice_models spice_subckts" {
            if {[info exists vars($analysis,$pwr_option)]} {
               set first 1
               foreach file $vars($analysis,$pwr_option) {
                  if {$first == 1} {
                     Puts "<FF> INFO:     $pwr_option\t = $file"
                     set first 0
                  } else {
                     Puts "<FF> INFO:                \t = $file"
                  }
                  lappend check(spice_files) $file
               }
            } else {
               Puts "<FF> ERROR: Required variable vars($analysis,$pwr_option) not defined"
               set errors($abort) "Required variable vars($analysis,$pwr_option) not defined"
               incr abort
            }
         }
         if {[info exists vars($analysis,spice_include)]} {
            Puts "<FF> INFO:     spice_include\t = $vars($analysis,spice_include)"
            lappend check(spice_files) $vars($analysis,spice_include)
         }
         Puts "<FF> =============================================="
         Puts "<FF> INFO: User set & Default options for $analysis ANALYSIS:"
         if {$vars(flow) == "cpf"} {
            if {[info exist vars($analysis,analysis_view)]} {
               Puts "<FF> INFO:     analysis_view = $vars($analysis,analysis_view)"
            } else {
               Puts "<FF> WARNING: Required variable vars($analysis,analysis_view) not defined... continuing"
               # set errors($abort) "Required variable vars($analysis,analysis_view) not defined"
               # incr abort
            }
         }
         foreach pwr_option "method macro_powerup_view dynamic_period dynamic_resolution \
                             extraction_mode usim_mode run_transient_analysis run_powerup_only" {
            if {[info exists vars($analysis,$pwr_option)]} {
               Puts "<FF> INFO:     $pwr_option = $vars($analysis,$pwr_option)"
            }
         }
      }
   }
}

foreach analysis $check(req_eps_analysis) {
   if {($analysis == "static_rail") || ($analysis == "dynamic_rail") ||
       ($analysis == "powerup_rail") || ($analysis == "decap") || ($analysis == "jitter_rail")} {
      lappend vars(req_eps_rail_analysis) $analysis
   }
}

if {[info exists vars(req_eps_rail_analysis)] && ($vars(req_eps_rail_analysis) != "")} {
   Puts "<FF> =============================================="
   Puts "<FF>     Checking for design's PG net variables"
   Puts "<FF> =============================================="
   Puts "<FF> INFO: Mandatory options for Rail Analysis"
   if {[info exists vars(power_domains)] && ($vars(power_domains) != "")} {
      foreach domain $vars(power_domains) {
         if {$vars(flow) == "default"} {
            foreach rail_option "pwr_nets gnd_nets" {
               if {[info exists vars($domain,$rail_option)]} {
                  Puts "<FF> INFO:  $rail_option of $domain = $vars($domain,$rail_option)"
                  foreach pg_net $vars($domain,$rail_option) {
                     if {[info exists vars($pg_net,voltage)]} {
                        Puts "<FF> INFO:  $pg_net voltage = $vars($pg_net,voltage)"
                     } else {
                        Puts "<FF> ERROR: Required variable vars($pg_net,voltage) not defined"
                        set errors($abort) "Required variable vars($pg_net,voltage) not defined"
                        incr abort
                     }
                  }
               } else {
                  Puts "<FF> ERROR: Required variable vars($domain,$rail_option) not defined"
                  set errors($abort) "Required variable vars($domain,$rail_option) not defined"
                  incr abort
               }
            }
         } else {
            Puts "<FF> INFO: For CPF based designs the PG nets information for $domain of the"
            Puts "<FF>             Design will be extraced during the Analysis"
         }

         Puts "<FF> INFO:        cl_views set for:"
         if {[info exists vars($domain,cl_views)]} {
            Puts "<FF> INFO:               $domain = $vars($domain,cl_views)"
         } else {
            Puts "<FF> ERROR: Required variable vars($domain,cl_views) not defined"
            set errors($abort) "Required variable vars($domain,cl_views) not defined"
            incr abort
         }
      }
   } else {
      Puts "<FF> ERROR: Required variable vars(power_domains) not defined"
      set errors($abort) "Required variable vars(power_domains) not defined"
      incr abort
   }

   Puts "<FF> =============================================="
   Puts "<FF>     Checking for Power Pad Location Files"
   Puts "<FF> =============================================="
   if {[info exists vars(design_pg_nets)]} {
      foreach pg_net $vars(design_pg_nets) {
         if {[info exists vars($pg_net,power_pad_file)] && ($vars($pg_net,power_pad_file) != "")} {
            set first 1
            Puts "<FF> INFO: $pg_net net's"
            foreach file_name $vars($pg_net,power_pad_file) {
               if {$first == 1} {
                  Puts "<FF> INFO:        power_pad_file = $file_name"
                  set first 0
               } else {
                  Puts "<FF> INFO:                         $file_name"
               }
               lappend check(pp_files) $file_name
            }
         # } else {
            # Puts "<FF> ERROR: Required variable vars($pg_net,power_pad_file) not defined"
            # set errors($abort) "Required variable vars($pg_net,power_pad_file) not defined"
            # incr abort
         }
      }
   } elseif {[info exists vars(power_domains)] && ($vars(power_domains) != "")} {
      foreach domain $vars(power_domains) {
         ## foreach rail_option "pwr_nets gnd_nets other_pwr_nets other_gnd_nets"
         foreach rail_option "pwr_nets gnd_nets" {
            if {[info exists vars($domain,$rail_option)]} {
               foreach pg_net $vars($domain,$rail_option) {
                  if {[info exists vars($pg_net,power_pad_file)] && ($vars($pg_net,power_pad_file) != "")} {
                     set first 1
                     Puts "<FF> INFO: $pg_net net's"
                     foreach file_name $vars($pg_net,power_pad_file) {
                        if {$first == 1} {
                           Puts "<FF> INFO:        power_pad_file = $file_name"
                           set first 0
                        } else {
                           Puts "<FF> INFO:                         $file_name"
                        }
                        lappend check(pp_files) $file_name
                     }
                  }
               }
            } else {
               Puts "<FF> WARNING: For PG nets under $domain Power-Domain, Please Make sure the"
               Puts "<FF>             PP Location Files and/or PP file formats defined"
            }
         }
      }
   }

   Puts "<FF> =============================================="
   Puts "<FF>  The current/power files setting information:"
   Puts "<FF> =============================================="
   if {[info exists vars(power_data_format)]} {
      if {$vars(power_data_format) == "current"} {
         Puts "<FF>  The current/power file Format Type = $vars(power_data_format)"
      } elseif {$vars(power_data_format) == "ascii"} {
         Puts "<FF>  The current/power file Format Type = $vars(power_data_format)"
         if {[info exists vars(inst_power_file)]} {
            Puts "<FF>  The instance power file = $vars(inst_power_file)"
            lappend check(pwr_data_files) $vars(inst_power_file)
         } else {
            Puts "<FF> ERROR: Required variable vars(inst_power_file) not defined"
            set errors($abort) "Required variable vars(inst_power_file) not defined"
            incr abort
         }
      } else {
         Puts "<FF> ERROR: INVALID CURRENT/POWER DATA FORMAT: Supports only \"current/ascii\" Type Format"
         set errors($abort) "INVALID CURRENT/POWER DATA FORMAT: Supports only \"current/ascii\" Type Format"
         incr abort
      }
   } else {
      Puts "<FF> ERROR: Required variable vars(power_data_format) not defined"
      set errors($abort) "Required variable vars(power_data_format) not defined"
      incr abort
   }

   set vars(vstorm_inc_req_files) "vstorm_begin_inc_file vstorm_end_inc_file"
   set first 1
   foreach analysis $vars(req_eps_rail_analysis) {
      foreach file_name $vars(vstorm_inc_req_files) {
         if {[info exists vars($analysis,$file_name)] && ($vars($analysis,$file_name) != "")} {
            if {$first == 1} {
               Puts "<FF> =============================================="
               Puts "<FF>        Checking for Vstorm-include Files"
               Puts "<FF> =============================================="
               Puts "<FF> INFO: $analysis $file_name = $vars($analysis,$file_name)"
               set first 0
            } else {
               Puts "<FF> INFO: $analysis $file_name = $vars($analysis,$file_name)"
            }
            lappend check(vstorm_inc_files) $vars($analysis,$file_name)
         }
      }
   }

   Puts "<FF> =============================================="
   Puts "<FF>            Rail Analysis Options"
   foreach analysis $vars(req_eps_rail_analysis) {

      if {$analysis == "static_rail"} {
         Puts "<FF> =============================================="
         if {[info exists vars(static_power)] && ($vars(static_power) == "true")} {
            Puts "<FF> INFO: There is NO Mandatory options for $analysis ANALYSIS:"
         } else {
            Puts "<FF> INFO: The Mandatory options for $analysis ANALYSIS:"
            Puts "<FF> WARNING: Make sure corresponding .ptiavg files available at the PATH else"
            Puts "<FF>          enable \"static_power\" to generate those files"
         }
         Puts "<FF> =============================================="
         Puts "<FF> INFO: User set & Default options for $analysis ANALYSIS:"
         if {$vars(flow) == "cpf"} {
            if {[info exist vars($analysis,analysis_view)]} {
               Puts "<FF> INFO:     analysis_view = $vars($analysis,analysis_view)"
            } else {
               Puts "<FF> WARNING: Required variable vars($analysis,analysis_view) not defined... continuing"
               # set errors($abort) "Required variable vars($analysis,analysis_view) not defined"
               # incr abort
            }
         }
         foreach rail_option "accuracy temperature analyze_type threshold_percent" {
            if {[info exists vars($analysis,$rail_option)]} {
               Puts "<FF> INFO:     $rail_option = $vars($analysis,$rail_option)"
            }
         }
         if {[info exists vars(power_domains)] && ($vars(power_domains) != "")} {
            foreach power_domain $vars(power_domains) {
               if {[info exists vars($analysis,$power_domain,off_rails)]} {
                  Puts "<FF> INFO:     off_rails of $power_domain = $vars($analysis,$power_domain,off_rails)"
               }
            }
         }
      }

      if {($analysis == "dynamic_rail") || ($analysis == "jitter_rail")} {
         Puts "<FF> =============================================="
         if {[info exists vars(dynamic_power)] && ($vars(dynamic_power) == "true")} {
            Puts "<FF> INFO: There is NO Mandatory options for $analysis ANALYSIS:"
         } else {
            Puts "<FF> INFO: The Mandatory options for $analysis ANALYSIS:"
            Puts "<FF> WARNING: Make sure corresponding .ptiavg files available at the PATH else"
            Puts "<FF>          enable \"dynamic_power\" to generate those files"
         }
         Puts "<FF> =============================================="
         Puts "<FF> INFO: User set & Default options for $analysis ANALYSIS:"
         if {$vars(flow) == "cpf"} {
            if {[info exist vars(dynamic_rail,analysis_view)]} {
               Puts "<FF> INFO:     analysis_view = $vars(dynamic_rail,analysis_view)"
            } else {
               Puts "<FF> WARNING: Required variable vars(dynamic_rail,analysis_view) not defined... continuing"
               # set errors($abort) "Required variable vars(dynamic_rail,analysis_view) not defined"
               # incr abort
            }
         }
         foreach rail_option "accuracy temperature analyze_type threshold_percent \
                              save_current_files gen_movies gen_voltage_waves \
                              die_model generate_bb_voltage_file \
                              gds_top_cell gds_purpose" {
            if {[info exists vars(dynamic_rail,$rail_option)]} {
               Puts "<FF> INFO:     $rail_option = $vars(dynamic_rail,$rail_option)"
            }
         }
         foreach rail_option "gds_file gds_map_file" {
            if {[info exists vars(dynamic_rail,$rail_option)]} {
               Puts "<FF> INFO:     $rail_option = $vars(dynamic_rail,$rail_option)"
               lappend check(dynamic_rail_gds_files) $vars(dynamic_rail,$rail_option)
            }
         }
         if {[info exists vars(power_domains)] && ($vars(power_domains) != "")} {
            foreach power_domain $vars(power_domains) {
               if {[info exists vars(dynamic_rail,$power_domain,off_rails)]} {
                  Puts "<FF> INFO:     off_rails of $power_domain = $vars(dynamic_rail,$power_domain,off_rails)"
               }
            }
         }
      }

      if {$analysis == "powerup_rail"} {
         Puts "<FF> =============================================="
         if {[info exists vars(powerup)] && ($vars(powerup) == "true")} {
            if {[info exists vars(powerup_rail,use_dynamic_pti_files)] &&
                ($vars(powerup_rail,use_dynamic_pti_files) == "true")} {
               if {[info exists vars(dynamic_power)] && ($vars(dynamic_power) == "true")} {
                  Puts "<FF> INFO: There is NO Mandatory options for $analysis ANALYSIS:"
               } else {
                  Puts "<FF> INFO: The Mandatory options for $analysis ANALYSIS:"
                  Puts "<FF> WARNING: Make sure corresponding .ptiavg files available at the PATH else"
                  Puts "<FF>          enable \"dynamic_power\" to generate those files"
               }
            } else {
               Puts "<FF> INFO: There is NO Mandatory options for $analysis ANALYSIS:"
            }
         } else {
            if {[info exists vars(powerup_rail,use_dynamic_pti_files)] &&
                ($vars(powerup_rail,use_dynamic_pti_files) == "true")} {
               if {[info exists vars(dynamic_power)] && ($vars(dynamic_power) == "true")} {
                  Puts "<FF> INFO: The Mandatory options for $analysis ANALYSIS:"
                  Puts "<FF> WARNING: Make sure corresponding .ptipeak files available at the PATH else"
                  Puts "<FF>          enable \"powerup\" to generate those files"
               } else {
                  Puts "<FF> INFO: The Mandatory options for $analysis ANALYSIS:"
                  Puts "<FF> WARNING: Make sure corresponding .ptiavg files available at the PATH else"
                  Puts "<FF>          enable \"dynamic_power\" to generate those files"
                  Puts "<FF> WARNING: Make sure corresponding .ptipeak files available at the PATH else"
                  Puts "<FF>          enable \"powerup\" to generate those files"
               }
            } else {
               Puts "<FF> INFO: The Mandatory options for $analysis ANALYSIS:"
               Puts "<FF> WARNING: Make sure corresponding .ptipeak files available at the PATH else"
               Puts "<FF>          enable \"powerup\" to generate those files"
            }
         }
         Puts "<FF> =============================================="
         Puts "<FF> INFO: Mandatory options for $analysis ANALYSIS:"
         ## foreach rail_option "power_domain analyze_nets off_rails"
         foreach rail_option "power_domain alwayson_net" {
            if {[info exists vars($analysis,$rail_option)]} {
               Puts "<FF> INFO:     $rail_option = $vars($analysis,$rail_option)"
            } else {
               Puts "<FF> ERROR: Required variable vars($analysis,$rail_option) not defined"
               set errors($abort) "Required variable vars($analysis,$rail_option) not defined"
               incr abort
            }
         }
         foreach rail_option "cl_views" {
            foreach power_domain $vars($analysis,power_domain) {
               if {[info exists vars($power_domain,$rail_option)]} {
                  Puts "<FF> INFO:     $rail_option for $power_domain = $vars($power_domain,$rail_option)"
               } else {
                  Puts "<FF> ERROR: Required variable vars($power_domain,$rail_option) not defined"
                  set errors($abort) "Required variable vars($power_domain,$rail_option) not defined"
                  incr abort
               }
            }
         }
         foreach rail_option "off_rails" {
            foreach power_domain $vars($analysis,power_domain) {
               if {[info exists vars($analysis,$power_domain,$rail_option)]} {
                  Puts "<FF> INFO:     $rail_option of $power_domain = $vars($analysis,$power_domain,$rail_option)"
               } else {
                  Puts "<FF> ERROR: Required variable vars($analysis,$power_domain,$rail_option) not defined"
                  set errors($abort) "Required variable vars($analysis,$power_domain,$rail_option) not defined"
                  incr abort
               }
            }
         }
         Puts "<FF> =============================================="
         Puts "<FF> INFO: User set & Default options for $analysis ANALYSIS:"
         if {$vars(flow) == "cpf"} {
            if {[info exist vars($analysis,analysis_view)]} {
               Puts "<FF> INFO:     analysis_view = $vars($analysis,analysis_view)"
            } else {
               Puts "<FF> WARNING: Required variable vars($analysis,analysis_view) not defined... continuing"
               # set errors($abort) "Required variable vars($analysis,analysis_view) not defined"
               # incr abort
            }
         }
         foreach rail_option "temperature use_dynamic_pti_files accuracy power_switch_eco \
                              gen_movies gen_voltage_waves threshold_percent \
                              analyze_type" {
            if {[info exists vars($analysis,$rail_option)]} {
               Puts "<FF> INFO:     $rail_option = $vars($analysis,$rail_option)"
            }
         }
         if {[info exists vars($vars($analysis,power_domain),other_pwr_nets)]} {
            Puts "<FF> INFO:     other_pwr_nets = $vars($vars($analysis,power_domain),other_pwr_nets)"
         }
      }

      if {$analysis == "decap"} {
         Puts "<FF> =============================================="
         if {[info exists vars(dynamic_power)] && ($vars(dynamic_power) == "true")} {
            Puts "<FF> INFO: There is NO Mandatory options for $analysis ANALYSIS:"
         } else {
            Puts "<FF> INFO: The Mandatory options for $analysis ANALYSIS:"
            Puts "<FF> WARNING: Make sure corresponding .ptiavg files available at the PATH else"
            Puts "<FF>          enable \"dynamic_power\" to generate those files"
         }
         foreach rail_option "power_domain" {
            if {[info exists vars($analysis,$rail_option)]} {
               Puts "<FF> INFO:     $rail_option\t= $vars($analysis,$rail_option)"
            } else {
               Puts "<FF> ERROR: Required variable vars($analysis,$rail_option) not defined"
               set errors($abort) "Required variable vars($analysis,$rail_option) not defined"
               incr abort
            }
         }
         foreach rail_option "cl_views" {
            foreach power_domain $vars($analysis,power_domain) {
               if {[info exists vars($power_domain,$rail_option)]} {
                  Puts "<FF> INFO:     $rail_option for $power_domain = $vars($power_domain,$rail_option)"
               } else {
                  Puts "<FF> ERROR: Required variable vars($power_domain,$rail_option) not defined"
                  set errors($abort) "Required variable vars($power_domain,$rail_option) not defined"
                  incr abort
               }
            }
         }
         Puts "<FF> =============================================="
         Puts "<FF> INFO: User set & Default options for $analysis ANALYSIS:"
         if {$vars(flow) == "cpf"} {
            if {[info exist vars($analysis,analysis_view)]} {
               Puts "<FF> INFO:     analysis_view = $vars($analysis,analysis_view)"
            } else {
               Puts "<FF> WARNING: Required variable vars($analysis,analysis_view) not defined... continuing"
               # set errors($abort) "Required variable vars($analysis,analysis_view) not defined"
               # incr abort
            }
         }
         foreach rail_option "accuracy temperature decap_opt_method \
                              gen_decap_eco gen_movies gen_voltage_waves analyze_type \
                              threshold_percent decal_cell_list filler_cell_list decap_removal_method \
                              dont_touch_decaps max_leakage generate_bb_voltage_file \
                              gds_purpose gds_top_cell" {
            if {[info exists vars($analysis,$rail_option)]} {
               Puts "<FF> INFO:     $rail_option = $vars($analysis,$rail_option)"
            }
         }
         foreach rail_option "gds_file gds_map_file" {
            if {[info exists vars($analysis,$rail_option)]} {
               Puts "<FF> INFO:     $rail_option = $vars($analysis,$rail_option)"
               lappend check(decap_gds_files) $vars($analysis,$rail_option)
            }
         }
         if {[info exists vars(power_domains)] && ($vars(power_domains) != "")} {
            foreach power_domain $vars(power_domains) {
               if {[info exists vars($analysis,$power_domain,off_rails)]} {
                  Puts "<FF> INFO:     off_rails for $power_domain = $vars($analysis,$power_domain,off_rails)"
               }
            }
         }
      }
   }
}

Puts "<FF> =============================================="
Puts "<FF>                File Check"
Puts "<FF> =============================================="
set files 0
Puts "<FF> INFO: Checking design files ..."
foreach file $check(files) {
#   Puts "<FF> INFO:    $file ..."
   if {![file exists $file]} {
      Puts "<FF> ERROR: File does not exist ($file) ..."
      set errors($abort) "File does not exist ($file)"
      incr abort
   } else {
      incr files
   }
}
Puts "<FF> INFO:    ... found $files files"
set files 0
if {![info exists vars(EDI_design)]} {
## if {($check(lib_files) != "")} 
   if {[info exists vars(library_sets)]} {
      foreach library_set $vars(library_sets) {
         Puts "<FF> INFO: Checking .libs for \"$library_set\" library set ..."
         if {[info exists vars($library_set,timing)]} {
            foreach file $vars($library_set,timing) {
   #      Puts "<FF> INFO:    $file ..."
               if {![file exists $file]} {
                  Puts "<FF> ERROR: File does not exist ($file) ..."
                  set errors($abort) "File does not exist ($file)"
                  incr abort
               } else {
                  incr files
               }
            }
         }
         Puts "<FF> INFO:    ... found $files files"
         set files 0
      }
   }
}
if {![info exists vars(EDI_design)]} {
## if {($check(lef_files) != "")} 
   Puts "<FF> INFO: Checking LEF files ..."
   if {[info exists vars(lef_files)]} {
      foreach file $vars(lef_files) {
#   Puts "<FF> INFO: $file ..."
         if {![file exists $file]} {
            Puts "<FF> ERROR: File does not exist ($file) ..."
            set errors($abort) "File does not exist ($file)"
            incr abort
         } else {
            incr files
         }
      } 
   }
   Puts "<FF> INFO:    ... found $files files"
   set files 0
}
if {($check(pgv_files) != "")} {
   if {[info exists vars(library_sets)]} {
      foreach library_set $vars(library_sets) {
         Puts "<FF> INFO: Checking cl_views for \"$library_set\" library set..."
         if {[info exists vars($library_set,cl_views)]} {
            foreach file $vars($library_set,cl_views) {
   #      Puts "<FF> INFO:    $file ..."
               if {![file exists $file]} {
                  Puts "<FF> ERROR: File does not exist ($file) ..."
                  set errors($abort) "File does not exist ($file)"
                  incr abort
               } else {
                  incr files
               }
            }
         }
         Puts "<FF> INFO:    ... found $files files"
         set files 0
      }
   }
}
if {($check(plugins) != "")} {
   Puts "<FF> INFO: Checking plug-in files ..."
   foreach file $check(plugins) {
#   Puts "<FF> INFO:    $file ..."
      if {![file exists $file]} {
         Puts "<FF> WARNING: File does not exist ($file) ... continuing"
#      set errors($abort) "File does not exist ($file)"
#      incr abort
      } else {
         incr files
      }
   }
   Puts "<FF> INFO:    ... found $files files"
   set files 0
}
if {($check(pwr_inc_files) != "")} {
   Puts "<FF> INFO: Checking power_include files ..."
   foreach file $check(pwr_inc_files) {
#   Puts "<FF> INFO:    $file ..."
      if {![file exists $file]} {
         Puts "<FF> ERROR: File does not exist ($file) ..."
         set errors($abort) "File does not exist ($file)"
         incr abort
      } else {
         incr files
      }
   }
   Puts "<FF> INFO:    ... found $files files"
   set files 0
}
if {($check(pwr_data_files) != "")} {
   Puts "<FF> INFO: Checking Instance-power files ..."
   foreach file $check(pwr_data_files) {
#   Puts "<FF> INFO:    $file ..."
      if {![file exists $file]} {
         Puts "<FF> ERROR: File does not exist ($file) ..."
         set errors($abort) "File does not exist ($file)"
         incr abort
      } else {
         incr files
      }
   }
   Puts "<FF> INFO:    ... found $files files"
   set files 0
}
if {($check(vstorm_inc_files) != "")} {
   Puts "<FF> INFO: Checking Voltage-Storm_include files ..."
   foreach file $check(vstorm_inc_files) {
#   Puts "<FF> INFO:    $file ..."
      if {![file exists $file]} {
         Puts "<FF> ERROR: File does not exist ($file) ..."
         set errors($abort) "File does not exist ($file)"
         incr abort
      } else {
         incr files
      }
   }
   Puts "<FF> INFO:    ... found $files files"
   set files 0
}
if {($check(spice_files) != "")} {
   Puts "<FF> INFO: Checking Spice required files ..."
   foreach file $check(spice_files) {
#   Puts "<FF> INFO:    $file ..."
      if {![file exists $file]} {
         Puts "<FF> ERROR: File does not exist ($file) ..."
         set errors($abort) "File does not exist ($file)"
         incr abort
      } else {
         incr files
      }
   }
   Puts "<FF> INFO:    ... found $files files"
   set files 0
}
if {($check(pp_files) != "")} {
   Puts "<FF> INFO: Checking Power-PAD location files ..."
   foreach file $check(pp_files) {
#   Puts "<FF> INFO:    $file ..."
      if {![file exists $file]} {
         Puts "<FF> ERROR: File does not exist ($file) ..."
         set errors($abort) "File does not exist ($file)"
         incr abort
      } else {
         incr files
      }
   }
   Puts "<FF> INFO:    ... found $files files"
   set files 0
}
if {($check(dynamic_rail_gds_files) != "")} {
   Puts "<FF> INFO: Checking Dynamic Rail GDS files ..."
   foreach file $check(dynamic_rail_gds_files) {
#   Puts "<FF> INFO:    $file ..."
      if {![file exists $file]} {
         Puts "<FF> ERROR: File does not exist ($file) ..."
         set errors($abort) "File does not exist ($file)"
         incr abort
      } else {
         incr files
      }
   }
   Puts "<FF> INFO:    ... found $files files"
   set files 0
}
if {($check(decap_gds_files) != "")} {
   Puts "<FF> INFO: Checking Decap Opt Analysis GDS files ..."
   foreach file $check(decap_gds_files) {
#   Puts "<FF> INFO:    $file ..."
      if {![file exists $file]} {
         Puts "<FF> ERROR: File does not exist ($file) ..."
         set errors($abort) "File does not exist ($file)"
         incr abort
      } else {
         incr files
      }
   }
   Puts "<FF> INFO:    ... found $files files"
   set files 0
}
if {($check(twf_files) != "")} {
   Puts "<FF> INFO: Checking TWF files ..."
   foreach file $check(twf_files) {
#   Puts "<FF> INFO:    $file ..."
      if {![file exists $file]} {
         Puts "<FF> WARNING: File does not exist ($file) ... Continuing"
         ## set errors($abort) "File does not exist ($file)"
         ## incr abort
      } else {
         incr files
      }
   }
   Puts "<FF> INFO:    ... found $files files"
   set files 0
}
if {($check(activity_files) != "")} {
   Puts "<FF> INFO: Checking Activity files ..."
   foreach file $check(activity_files) {
#   Puts "<FF> INFO:    $file ..."
      if {![file exists $file]} {
         Puts "<FF> ERROR: File does not exist ($file) ..."
         set errors($abort) "File does not exist ($file)"
         incr abort
      } else {
         incr files
      }
   }
   Puts "<FF> INFO:    ... found $files files"
   set files 0
}
if {($check(package_files) != "")} {
   Puts "<FF> INFO: Checking Package files ..."
   foreach file $check(package_files) {
#   Puts "<FF> INFO:    $file ..."
      if {![file exists $file]} {
         Puts "<FF> ERROR: File does not exist ($file) ..."
         set errors($abort) "File does not exist ($file)"
         incr abort
      } else {
         incr files
      }
   }
   Puts "<FF> INFO:    ... found $files files"
   set files 0
}
if {($check(em_model_file) != "")} {
   Puts "<FF> INFO: Checking EM models file ..."
   foreach file $check(em_model_file) {
#   Puts "<FF> INFO:    $file ..."
      if {![file exists $file]} {
         Puts "<FF> WARNING: File does not exist ($file) ... continuing"
         ## set errors($abort) "File does not exist ($file)"
         ## incr abort
      } else {
         incr files
      }
   }
   Puts "<FF> INFO:    ... found $files files"
   set files 0
}

if {$abort > 0} {
   Puts "<FF> -----------------------------------------------------"
   Puts "<FF>                   Error Summary"
   Puts "<FF> -----------------------------------------------------"
   for {set i 0} {$i<$abort} {incr i} {
      Puts "<FF> ([expr $i + 1]) $errors($i)"
   }
   Puts "<FF> -----------------------------------------------------"

   if $vars(abort) {
      Puts "<FF> Aborting due to previous errors ..."
      exit 1
   }
} else {
      Puts "<FF>"
      Puts "<FF>                  SETUP CHECK PASSED"
      Puts "<FF> ====================================================="
}


