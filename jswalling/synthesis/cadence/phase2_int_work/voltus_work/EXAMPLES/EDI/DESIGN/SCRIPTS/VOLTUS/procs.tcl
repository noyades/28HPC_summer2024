###############################################################################
#                       CADENCE COPYRIGHT NOTICE
#		2008-2013 Cadence Design Systems, Inc. All rights reserved.
#------------------------------------------------------------------------------
#
# This Foundation Flow is provided as an example of how to perform specialized
# tasks within Tempus Timing Signoff Solution System.
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

namespace eval FF_VOLTUS {

#GP#
set vars(generate_flow_steps) 0

   ################################################################################
   # The setup and voltus_config verification script for TEMPUS FF
   ################################################################################
   
   proc check_setup {} {
   
      global vars
      global errors
      global warnings
      
      set check(files) [list]
      set check(lib_files) [list]
      set check(lef_files) [list]
      set check(pgv_files) [list]
      set check(plugins) [list]
      set check(data_files) [list]
      set check(pp_files) [list]
      set check(pwr_inc_files) [list]
      set check(vstorm_inc_files) [list]
      set check(em_model_file) [list]
	set check(pg_files)	[list]
      set vars(req_eps_rail_analysis) [list]
      set vars(req_eps_pwr_analysis) [list]
      set design_error 0
      set count 0
      set abort 0
      set pwr_ascii 0
      
      if {![info exists vars(abort)]} {
         set vars(abort) 1
      }

      set commands ""
      
      append commands "<FF> ================================================================================\n"
      append commands "<FF>                         VOLTUS Foundation Flow Requirements\n"
      append commands "<FF> ================================================================================\n"
      append commands "<FF>                             Design Requirement Files\n"
      append commands "<FF> ================================================================================\n"
	# for pg only flow
      if {[info exists vars(pg_only)] && ($vars(pg_only) == "true")} {
	# Also could try
	# set vars(lib_req_files) "lef_files"
	 append commands "<FF> ================================================================================\n"
         append commands "<FF>                           Physical Libraries (lef) \n"
         append commands "<FF> ================================================================================\n"
	if {[info exists vars(lef_files)] && ($vars(lef_files) != "")} {
               append commands "<FF> INFO:    lef_files = \n"
               foreach lib $vars(lef_files) {
                  lappend check(lef_files) $lib
                  append commands "<FF> INFO:       $lib\n"
               }
            } else {
		append commands "<FF> ERROR: Required files vars(lef_files) not defined\n"
               set errors($abort) "Required files vars(lef_files) not defined"
               incr abort
	}
      } else {
	if {[info exists vars(load_edi_db)] && ($vars(load_edi_db) == "true")} {
         set vars(design_req_files) "edi_db_name"
      } elseif {[info exists vars(view_definition_file)] && ($vars(view_definition_file) != "")} {  
	# incase use read_view_definition
	set vars(design_req_files) "netlist design def_files"
         set vars(lib_req_files) "lef_files"
	} else {
         set vars(design_req_files) "netlist def_files sdc_files design"
         set vars(lib_req_files) "timing lef_files"
      }
      set vars(mmmc_files) "cpf_file mmmc_setup_file"
      set vars(parasitic_req_files) "spef"
      
      if {[info exists vars(design_req_files)]} {
         if {$vars(design_req_files) == "edi_db_name"} {
            if {[info exists vars($vars(design_req_files))]} {
               lappend check(files) $vars($vars(design_req_files))
               append commands "<FF> INFO:    $vars(design_req_files) = $vars($vars(design_req_files))\n"
            } else {
               set design_error 1
            }
         } else {
            foreach required $vars(design_req_files) {
               if {[info exists vars($required)] && ($vars($required) != "")} {
                  set first 1
                  foreach file $vars($required) {
                     if {$first == 1} {
                        append commands "<FF> INFO:    $required = $file\n"
                        set first 0
                     } else {
                        append commands "<FF> INFO:                $file\n"
                     }
                     if {$required != "design"} {
                        lappend check(files) $file
                     }
                  }
               } else {
                  if {$required == "def_files"} {
                     append commands "<FF> ERROR: Required file vars($required) not defined,\
                                       can continue ONLY STATIC_POWER_ANALYSIS...But
                                       will not generate net based current files for Rail Analysis"
                     set errors($abort) "Non-EDI design required file vars($required) not defined"
                     incr abort
                  } elseif {$required == "design"} {
                     append commands "<FF> ERROR: Required top_design variable vars($required) not defined\n"
                     set errors($abort) "Non-EDI design top_design variable vars($required) not defined"
                     incr abort
                  } elseif {$required == "sdc_files"} {
                     append commands "<FF> WARNING: 3rd party design file vars($required) not defined ... continuing, But\
                                         accuracy is not guaranteed\n"
                     ## set errors($abort) " 3rd party design file vars($required) not defined"
                     ## incr abort
                  } else {
                     append commands "<FF> ERROR: Required file vars($required) not defined\n"
                     set errors($abort) "Non-EDI design required file vars($required) not defined"
                     incr abort
                  }
               }
            }
         }
      }
      
      if {$design_error == 1} {
         set design_error 0
         append commands "<FF> ERROR: Either EDI_design or non-EDI design files must be defined\n"
         append commands "<FF>\n"
         set errors($abort) "Either EDI_design or non-EDI design files must be defined"
         incr abort
      }
      
      if {[info exists vars(flow)] && ($vars(flow) == "mmmc")} {
         if {[info exists vars(rc_corners)]} {
            append commands "<FF> ================================================================================\n"
            append commands "<FF>                                  RC Corners\n"
            append commands "<FF> ================================================================================\n"
            set check(rc_corners) [list]
            foreach rc_corner $vars(rc_corners) {
               append commands "<FF> INFO: $rc_corner:\n"
            }
            append commands "<FF> ================================================================================\n"
            append commands "<FF>                                  Spef files\n"
            append commands "<FF> ================================================================================\n"
            foreach rc_corner $vars(rc_corners) {
               if {[info exists vars($rc_corner,spef)] && ($vars($rc_corner,spef) != "")} {
                  set first 1
                  foreach file $vars($rc_corner,spef) {
                     if {$first == 1} {
                        append commands "<FF> INFO:    $rc_corner,spef = $file\n"
                        set first 0
                     } else {
                        append commands "<FF> INFO:                      $file\n"
                     }
                     lappend check(files) $file
                  }
               } else {
                  append commands "<FF> WARNING: spef for $rc_corner is not defined, accuracy is not guaranteed... continuing\n"
               }
            }
         } else {
            append commands "<FF> WARNING: RC Corners are not defined for mmmc designs... continuing\n"
            append commands "<FF>\n"
         }
      } else {
         if {[info exists vars(parasitic_req_files)]} {
            foreach required $vars(parasitic_req_files) {
               if {[info exists vars($required)] && ($vars($required) != "")} {
                     set first 1
                     foreach file $vars($required) {
                        if {$first == 1} {
                           append commands "<FF> INFO:    $required = $file\n"
                           set first 0
                        } else {
                           append commands "<FF> INFO:                $file\n"
                        }
                        lappend check(files) $file
                     }
               } else {
                  append commands "<FF> WARNING: spef is not defined, accuracy is not guaranteed... continuing\n"
                  append commands "<FF>\n"
               }
            }
         }
      }
      

      append commands "<FF> ================================================================================\n"
      append commands "<FF>                         Power Grid Library Information\n"
      append commands "<FF> ================================================================================\n"
      append commands "<FF>           Power-Grid Libraries\n"
	if {[info exist vars(generate_pg)] && ($vars(generate_pg) == "true") && (![info exists vars(cl_views)] || ($vars(cl_views) == ""))} {
	append commands "<FF> INFO:  vars(cl_views) isn't defined and pg generation flow is on, use Power Grid Library on the fly\n"
	set vars(cl_views) ""
	if {[info exist vars(techonly_outdir)] && ($vars(techonly_outdir) != "")} {
	 if {[info exist vars(techonly_prefix)]} {
	 lappend vars(cl_views) "${vars(techonly_outdir)}/${techonly_prefix}_techonly.cl"
	 } else {
	 lappend vars(cl_views) "${vars(techonly_outdir)}/techonly.cl"
	 }
	}

	if {[info exist vars(stdcells_outdir)] && ($vars(stdcells_outdir) != "")} {
	 if {[info exist vars(stdcells_prefix)]} {
	 lappend vars(cl_views) "${vars(stdcells_outdir)}/${stdcells_prefix}_stdcells.cl"
	 } else {
	 lappend vars(cl_views) "${vars(stdcells_outdir)}/stdcells.cl"
	 }
	}

	if {[info exist vars(macros_outdir)] && ($vars(macros_outdir) != "")} {
	 if {[info exist vars(macros_prefix)]} {
	 lappend vars(cl_views) "${vars(macros_outdir)}/${macros_prefix}_macros.cl"
	 } else {
	 lappend vars(cl_views) "${vars(macros_outdir)}/macros.cl"
	 }
	}
#	if {[info exist vars(macros_outdir)] && ($vars(macros_outdir) != "")} {
#	lappend vars(cl_views) [glob $vars(macros_outdir)/*.cl]
#	}
	
	}
      if {[info exists vars(cl_views)] && ($vars(cl_views) != "")} {
         append commands "<FF> INFO:    cl_views = \n"
         foreach lib $vars(cl_views) {
            lappend check(pgv_files) $lib
            append commands "<FF> INFO:       $lib\n"
         }
      } elseif {(![info exists vars(static_rail)] || ($vars(static_rail) != "true")) &&
		(![info exists vars(dynamic_power)] || ($vars(dynamic_power) != "true")) &&
		(![info exists vars(dynamic_rail)] || ($vars(dynamic_rail) != "true"))} {
		append commands "<FF> INFO:	Only static power is required, PGV is not mandatory\n"
	} else {
         append commands "<FF> ERROR: Required files vars(cl_views) not defined\n"
         set errors($abort) "Required files vars(cl_views) not defined"
         incr abort
      }
      #############Enhance for vars(lib_req_files)###############
	set check_timing 0
#	set check_lef_files 0
	
	if {[info exists vars(lib_req_files)] && ([lsearch $vars(lib_req_files) timing] >= 0)} { set check_timing 1}
#	if {([lsearch $vars(lib_req_files) lef_files] >= 0)} { set check_lef_files 1}
	######################
      if {![info exists vars(load_edi_db)] ||
          ([info exists vars(load_edi_db)] && ($vars(load_edi_db) == "false"))} {
	#for read_view_definition
	if {$check_timing} {
         append commands "<FF> ================================================================================\n"
         append commands "<FF>                            Timing Libraries\n"
         append commands "<FF> ================================================================================\n"
         if {[info exists vars(library_sets)]} {
            foreach library_set $vars(library_sets) {
               if {[info exists vars(lib_req_files)]} {
		#
                  append commands "<FF> INFO: $library_set:\n"
                  if {[info exists vars($library_set,timing)] && ($vars($library_set,timing) != "")} {
                     append commands "<FF> INFO:    timing = \n"
                     foreach lib $vars($library_set,timing) {
                        lappend check(lib_files) $lib
                        append commands "<FF> INFO:       $lib\n"
                     }
                  } else {
                     append commands "<FF> ERROR: Required files vars($library_set,timing) not defined\n"
                     set errors($abort) "Required files vars($library_set,timing) not defined"
                     incr abort
                  }
               }
            }
      
         } else {
            append commands "<FF> ERROR: Required variable vars(library_sets) not defined\n"
            set errors($abort) "Required variable vars(library_sets) not defined"
            incr abort
         }
      }
         append commands "<FF> ================================================================================\n"
         append commands "<FF>                           Physical Libraries\n"
         append commands "<FF> ================================================================================\n"
         if {[info exists vars(lib_req_files)]} {
            if {[info exists vars(lef_files)] && ($vars(lef_files) != "")} {
               append commands "<FF> INFO:    lef_files = \n"
               foreach lib $vars(lef_files) {
                  lappend check(lef_files) $lib
                  append commands "<FF> INFO:       $lib\n"
               }
            } else {
               ## append commands "<FF> WARNING: files vars(lef_files) not defined... continuing\n"
               append commands "<FF> ERROR: Required files vars(lef_files) not defined\n"
               set errors($abort) "Required files vars(lef_files) not defined"
               incr abort
            }
         }
      }
      
      if {[info exists vars(analysis_views)] && ($vars(analysis_views) != "")} {
         append commands "<FF> ================================================================================\n"
         append commands "<FF>                              Analysis Views\n"
         append commands "<FF> ================================================================================\n"
         set check(analysis_views) [list]
         foreach analysis_view $vars(analysis_views) {
            append commands "<FF> INFO: $analysis_view:\n"
            if {($analysis_view != "")} {
               append commands "<FF> INFO:    analysis_view = $analysis_view\n"
               lappend check(analysis_view) $analysis_view
            } else {
               append commands "<FF> ERROR: Required variable vars(analysis_views) not defined\n"
               set errors($abort) "Required variable vars(analysis_views) not defined"
               incr abort
            }
         }
      }
      
	
      append commands "<FF> ================================================================================\n"
      append commands "<FF>                                Plug-ins\n"
      append commands "<FF> ================================================================================\n"
      foreach plugin "user_load_design_tcl \
		      set_write_twf_tcl \
		      signal_em_tcl \
		      set_esd_analyze_tcl \
                      pre_static_power_tcl report_static_power_tcl post_static_power_tcl \
                      pre_dynamic_power_tcl post_dynamic_power_tcl \
                      set_static_rail_mode_tcl set_static_rail_pg_nets_tcl \
                      set_static_rail_power_data_tcl set_static_rail_pad_location_tcl \
                      set_static_rail_analysis_domain_tcl \
                      pre_static_rail_tcl post_static_rail_tcl \
                      set_dynamic_rail_mode_tcl set_dynamic_rail_pg_nets_tcl \
                      set_dynamic_rail_power_data_tcl set_dynamic_rail_pad_location_tcl \
                      set_dynamic_rail_analysis_domain_tcl \
		      set_advanced_pg_library_mode_tcl \
                      pre_dynamic_rail_tcl post_dynamic_rail_tcl" {
         if {[info exists vars($plugin)] && ($vars($plugin) != "")} {
            append commands "<FF> INFO: Plug-in $plugin = $vars($plugin)\n"
            lappend check(plugins) $vars($plugin)
         } else {
            append commands "<FF> INFO: Plug-in $plugin not defined\n"
         }  
      }
      
      if {[info exists vars(em_models_file)]} {
         append commands "<FF> ================================================================================\n"
         append commands "<FF>                     Electromigration(EM) Model File\n"
         append commands "<FF> ================================================================================\n"
         if {$vars(em_models_file) != ""} {
            append commands "<FF> INFO: EM model file = $vars(em_models_file)\n"
            lappend check(em_model_file) $vars(em_models_file)
         } else {
            append commands "<FF> ERROR: Required file vars(em_models_file) not defined\n"
            set errors($abort) "Required file vars(em_models_file) not defined"
            incr abort
         }
      }
      }
      ## The VOLTUS FF supported VOLTUS analysis types, their options to be verified 
      set vars(eps_analysis_types) "static_power static_rail dynamic_power dynamic_rail generate_pg"
	#set vars(eps_analysis_types) "static_power static_rail dynamic_power dynamic_rail"
      set vars(req_eps_analysis) ""
 
# regular, pg and design will be checked together
      foreach type $vars(eps_analysis_types) {
         if {[info exists vars($type)] && $vars($type)} { 
            lappend vars(req_eps_analysis) $type
         }
      }
  

      append commands "<FF> ================================================================================\n"
      append commands "<FF>                        The VOLTUS FF set for the following\n"
      append commands "<FF>                              VOLTUS Flow Types\n"
      append commands "<FF> ================================================================================\n"
      if {![info exists vars(req_eps_analysis)] || ([info exists vars(req_eps_analysis)] && ($vars(req_eps_analysis) == ""))} {
         append commands "<FF> WARNING: There is no VOLTUS flow defined\n"
         puts "<FF> WARNING: There is no VOLTUS flow defined\n"
         return
      } else {
         set first 1
         foreach analysis $vars(eps_analysis_types) {
            if {[info exists vars($analysis)] && ($vars($analysis) == "true")} {
               if {$first == 1} {
                  append commands "<FF> INFO: Voltus Flow Types: $analysis\n"
                  set first 0
               } else {
                  append commands "<FF> INFO:                    $analysis\n"
               }
               lappend check(req_eps_analysis) $analysis
            }
         }
      }
      
      
      if {[info exists vars(distribute)]} {
         append commands "<FF> ================================================================================\n"
         append commands "<FF>                    The VOLTUS tool control Settings:\n"
         append commands "<FF> ================================================================================\n"
         if {$vars(distribute) == "local"} {
            append commands "<FF> INFO: The job distribution type = $vars(distribute)\n"
            append commands "<FF> INFO: Number of Local Host CPUs = $vars(local_cpus)\n"
         } elseif {$vars(distribute) == "rsh"} {
            append commands "<FF> INFO: The job distribution type = $vars(distribute)\n"
            if {[info exists vars(remote_hosts)]} {
               append commands "<FF> INFO: Number of Remote Hosts = $vars(remote_hosts)\n"
            } else {
               append commands "<FF> ERROR: Required variable vars(remote_hosts) not defined\n"
               set errors($abort) "Required variable vars(remote_hosts) not defined"
               incr abort
            }
            if {[info exists vars(cpu_per_remote_host)]} {
               append commands "<FF> INFO: Number of CPUs per Remote Host = $vars(cpu_per_remote_host)\n"
            } else {
               append commands "<FF> ERROR: Required variable vars(cpu_per_remote_host) not defined\n"
               set errors($abort) "Required variable vars(cpu_per_remote_host) not defined"
               incr abort
            }
            if {[info exists vars(rsh,host_list)]} {
               append commands "<FF> INFO: Remote Hosts list = $vars(rsh,host_list)\n"
            } else {
               append commands "<FF> ERROR: Required variable vars(rsh,host_list) not defined\n"
               set errors($abort) "Required variable vars(rsh,host_list) not defined"
               incr abort
            }
         } elseif {$vars(distribute) == "lsf"} {
            append commands "<FF> INFO: The job distribution type = $vars(distribute)\n"
            if {[info exists vars(lsf,queue)]} {
               append commands "<FF> INFO: LSF Queue = $vars(lsf,queue)\n"
            } else {
               append commands "<FF> ERROR: Required variable vars(lsf,queue) not defined\n"
               set errors($abort) "Required variable vars(lsf,queue) not defined"
               incr abort
            }
            if {[info exists vars(lsf,resource)]} {
               append commands "<FF> INFO: LSF Resource = $vars(lsf,resource)\n"
            } else {
               append commands "<FF> ERROR: Required variable vars(lsf,resource) not defined\n"
               set errors($abort) "Required variable vars(lsf,resource) not defined"
               incr abort
            }
            if {[info exists vars(lsf,args)]} {
               append commands "<FF> INFO: LSF Args = $vars(lsf,args)\n"
            } else {
               append commands "<FF> ERROR: Required variable vars(lsf,args) not defined\n"
               set errors($abort) "Required variable vars(lsf,args) not defined"
               incr abort
            }
         } elseif {$vars(distribute) == "custom"} {
            append commands "<FF> INFO: The job distribution type = $vars(distribute)\n"
            if {[info exists vars(custom,script)]} {
               append commands "<FF> INFO: LSF Custom Script = $vars(custom,script)\n"
            } else {
               append commands "<FF> ERROR: Required variable vars(custom,script) not defined\n"
               set errors($abort) "Required variable vars(custom,script) not defined"
               incr abort
            }
         } else {
            append commands "<FF> ERROR: Required variable vars(distribute) not defined\n"
            set errors($abort) "Required variable vars(distribute) not defined"
            incr abort
         }
      }
      ## check for pg generation
	foreach analysis $check(req_eps_analysis) {
	if {($analysis == "generate_pg")} {
		# variable for skipping other file check
		#set pg_file_check_exist 1
                  append commands "<FF> ================================================================================\n"
                  append commands "<FF>                          Checking Power-Grid Library Generation Files\n"
                  append commands "<FF> ================================================================================\n"
			   append commands "<FF> INFO: Mandatory options for all Power-Grid Library Generation\n"
		if {[info exists vars(extraction_tech_file)]} {
                           append commands "<FF> INFO:  extraction tech file = $vars(extraction_tech_file)\n"
				lappend check(pg_files) $vars(extraction_tech_file)			
                        } else {
                           append commands "<FF> ERROR: Required variable vars(extraction_tech_file) not defined\n"
                           set errors($abort) "Required variable vars(extraction_tech_file) not defined"
                           incr abort
                        }
		if {[info exists vars(lef_layermap)]} {
                           append commands "<FF> INFO:  lef layer map file = $vars(lef_layermap)\n"
			lappend check(pg_files) $vars(lef_layermap)
                        } else {
                           append commands "<FF> ERROR: Required variable vars(lef_layermap) not defined\n"
                           set errors($abort) "Required variable vars(lef_layermap) not defined"
                           incr abort
                        }
		if {[info exists vars(techonly_pg_creation)] && ($vars(techonly_pg_creation) == "true")} {
		  append commands "<FF> ================================================================================\n"
                  append commands "<FF>                      Checking options for techonly pg Generation\n"
                  append commands "<FF> ================================================================================\n"
		if {[info exists vars(techonly_ground_pins)]} {
                           append commands "<FF> INFO:  ground pins for techonly = $vars(techonly_ground_pins)\n"			
                        } else {
             		   Puts "<FF> WARNING No ground pins be defined in techonly PG, Voltus will set defualt voltage"
                        }
		if {[info exists vars(techonly_power_pins)]} {
                           append commands "<FF> INFO:  power pins for techonly = $vars(techonly_power_pins)\n"			
                        } else {
             		   Puts "<FF> WARNING No power pins be defined in techonly PG, Voltus will set defualt voltage"
                        }
		if {[info exists vars(techonly_outdir)]} {
                           append commands "<FF> INFO:  techonly pg library outdir = $vars(techonly_outdir)\n"			
                        } else {
                           append commands "<FF> ERROR: Required variable vars(techonly_outdir) not defined\n"
                           set errors($abort) "Required variable vars(techonly_outdir) not defined"
                           incr abort
                        }
		if {[info exists vars(techonly_outdir)]} {
                           append commands "<FF> INFO:  techonly optinal options = $vars(techonly_other_options)\n"			
                        } 
		}

		if {[info exists vars(stdcells_pg_creation)] && ($vars(stdcells_pg_creation) == "true")} {
		  append commands "<FF> ================================================================================\n"
                  append commands "<FF>                      Checking options for stdcells pg Generation\n"
                  append commands "<FF> ================================================================================\n"
		if {[info exists vars(stdcells_ground_pins)]} {
                           append commands "<FF> INFO:  ground pins for stdcells = $vars(stdcells_ground_pins)\n"		
                        } else {
			   Puts "<FF> WARNING No ground pins be defined in stdcell PG, Voltus will set defualt voltage"
                        }
		if {[info exists vars(stdcells_power_pins)]} {
                           append commands "<FF> INFO:  power pins for stdcells = $vars(stdcells_power_pins)\n"			
                        } else {
			   Puts "<FF> WARNING No power pins be defined in stdcell PG, Voltus will set defualt voltage"
                        }
		if {[info exists vars(stdcells_spice_models)]} {
                           append commands "<FF> INFO:  stdcells spice models = $vars(stdcells_spice_models)\n"		
				lappend check(pg_files) $vars(stdcells_spice_models)
                        } else {
                           append commands "<FF> ERROR: Required variable vars(stdcells_spice_models) not defined\n"
                           set errors($abort) "Required variable vars(stdcells_spice_models) not defined"
                           incr abort
                        }
		if {[info exists vars(stdcells_spice_subckts)]} {
                           append commands "<FF> INFO:  stdcells spice subckts = $vars(stdcells_spice_subckts)\n"	
				lappend check(pg_files) $vars(stdcells_spice_subckts)		
                        } else {
                           append commands "<FF> ERROR: Required variable vars(stdcells_spice_subckts) not defined\n"
                           set errors($abort) "Required variable vars(stdcells_spice_subckts) not defined"
                           incr abort
                        }
		if {[info exists vars(stdcells_outdir)]} {
                           append commands "<FF> INFO:  stdcells pg library outdir = $vars(stdcells_outdir)\n"			
                        } else {
                           append commands "<FF> ERROR: Required variable vars(stdcells_outdir) not defined\n"
                           set errors($abort) "Required variable vars(stdcells_outdir) not defined"
                           incr abort
                        }
		if {[info exists vars(stdcells_outdir)]} {
                           append commands "<FF> INFO:  stdcells optinal options = $vars(stdcells_other_options)\n"			
                        } 
		}

		if {[info exists vars(macros_pg_creation)] && ($vars(macros_pg_creation) == "true")} {
		  append commands "<FF> ================================================================================\n"
                  append commands "<FF>                      Checking options for macros pg Generation\n"
                  append commands "<FF> ================================================================================\n"
		if {[info exists vars(macros_ground_pins)]} {
                           append commands "<FF> INFO:  ground pins for macros = $vars(macros_ground_pins)\n"			
                        } else {
			   Puts "<FF> WARNING No ground pins be defined in macros PG, Voltus will set defualt voltage"
                        }
		if {[info exists vars(macros_power_pins)]} {
                           append commands "<FF> INFO:  power pins for macros = $vars(macros_power_pins)\n"			
                        } else {
			   Puts "<FF> WARNING No power pins be defined in macros PG, Voltus will set defualt voltage"
                        }
		if {[info exists vars(macros_cell_list_file)]} {
                           append commands "<FF> INFO:  built cell list for macros = $vars(macros_cell_list_file)\n"		
				lappend check(pg_files) $vars(macros_cell_list_file)	
                        } else {
                           append commands "<FF> ERROR: Required variable vars(macros_cell_list_file) not defined\n"
                           set errors($abort) "Required variable vars(macros_cell_list_file) not defined"
                           incr abort
                        }

		if {[info exists vars(macros_gds_files)]} {
                           append commands "<FF> INFO:  macros gds files = $vars(macros_gds_files)\n"		
				lappend check(pg_files) $vars(macros_gds_files)	
                        } else {
                           append commands "<FF> ERROR: Required variable vars(macros_gds_files) not defined\n"
                           set errors($abort) "Required variable vars(macros_gds_files) not defined"
                           incr abort
                        }
		if {[info exists vars(macros_gds_layermap)]} {
                           append commands "<FF> INFO:  macros gds files = $vars(macros_gds_layermap)\n"		
				lappend check(pg_files) $vars(macros_gds_layermap)
                        } else {
                           append commands "<FF> ERROR: Required variable vars(macros_gds_layermap) not defined\n"
                           set errors($abort) "Required variable vars(macros_gds_layermap) not defined"
                           incr abort
                        }
		if {[info exists vars(macros_spice_subckts)]} {
                           append commands "<FF> INFO:  macros spice subckts = $vars(macros_spice_subckts)\n"		
					lappend check(pg_files)  $vars(macros_spice_subckts)
                        } else {
                           append commands "<FF> ERROR: Required variable vars(macros_spice_subckts) not defined\n"
                           set errors($abort) "Required variable vars(macros_spice_subckts) not defined"
                           incr abort
                        }
		if {[info exists vars(macros_outdir)]} {
                           append commands "<FF> INFO:  macros pg library outdir = $vars(macros_outdir)\n"			
                        } else {
                           append commands "<FF> ERROR: Required variable vars(macros_outdir) not defined\n"
                           set errors($abort) "Required variable vars(macros_outdir) not defined"
                           incr abort
                        }
		if {[info exists vars(macros_outdir)]} {
                           append commands "<FF> INFO:  macros optinal options = $vars(macros_other_options)\n"			
                        } 
		}
	}
	}
	
#	if {[info exists pg_file_check_exist] && ($pg_file_check_exist == 1) && [info exists vars(pg_only)] && ($vars(pg_only) == "true")} 

	if {!([info exists vars(pg_only)] && ($vars(pg_only) == "true"))} {
      foreach analysis $check(req_eps_analysis) {
         if {($analysis == "static_power") || ($analysis == "dynamic_power")} {
            lappend vars(req_eps_pwr_analysis) $analysis
         }
      }
      
      if {[info exists vars(req_eps_pwr_analysis)] && ($vars(req_eps_pwr_analysis) != "")} {
         set first 1
         foreach analysis $vars(req_eps_pwr_analysis) {
            if {$analysis == "dynamic_power"} {
               set vars(file_name) "dynamic_power_inc_file"
            }
      
            if {[info exists vars(file_name)] && [info exists vars($vars(file_name))] &&
                [file exists $vars($vars(file_name))]} {
               if {$first == 1} {
                  append commands "<FF> ================================================================================\n"
                  append commands "<FF>                          Checking Power-include Files\n"
                  append commands "<FF> ================================================================================\n"
                  append commands "<FF> INFO: $vars(file_name) = $vars($vars(file_name))\n"
                  set first 0
               } else {
                  append commands "<FF> INFO: $vars(file_name) = $vars($vars(file_name))\n"
               }
                  lappend check(pwr_inc_files) $vars($vars(file_name))
                  unset vars(file_name)
            }
         }
      
         append commands "<FF> ================================================================================\n"
         append commands "<FF>                        Power Analysis Options\n"
         append commands "<FF> ================================================================================\n"
         foreach analysis $vars(req_eps_pwr_analysis) {
            if {$analysis == "dynamic_power"} {
               if {[info exists vars($analysis,method)] && ($vars($analysis,method) == "dynamic_vectorbased")} {
                  append commands "<FF> INFO: Load activity vector files through plug-in : vars(pre_dynamic_power_tcl)\n"
               } else {
                  append commands "<FF> ================================================================================\n"
                  append commands "<FF> INFO: There is NO mandatory options for \"$analysis\" ANALYSIS:\n"
               }
            } else {
               append commands "<FF> ================================================================================\n"
               append commands "<FF> INFO: There is NO mandatory options for \"$analysis\" ANALYSIS:\n"
            }
            append commands "<FF> ================================================================================\n"
            append commands "<FF> INFO: Options being used for \"$analysis\" ANALYSIS:\n"
            foreach power_option "method analysis_view corner create_binary_db transition_time_method \
                                  disable_static write_static_currents" { 
               if {[info exists vars($analysis,$power_option)]} {
                  append commands "<FF> INFO:     $power_option = $vars($analysis,$power_option)\n"
               }
            }
         }
      }
      
      foreach analysis $check(req_eps_analysis) {
         if {($analysis == "static_rail") || ($analysis == "dynamic_rail")} {
            lappend vars(req_eps_rail_analysis) $analysis
         }
      }
      
      if {[info exists vars(req_eps_rail_analysis)] && ($vars(req_eps_rail_analysis) != "")} {
         append commands "<FF> ================================================================================\n"
         append commands "<FF>                Checking for design's PG net variables\n"
         append commands "<FF> ================================================================================\n"
         append commands "<FF> INFO: Mandatory options for Rail Analysis\n"
         if {[info exists vars(power_domains)] && ($vars(power_domains) != "")} {
            foreach domain $vars(power_domains) {
               foreach rail_option "pwr_nets gnd_nets" {
                  if {[info exists vars($domain,$rail_option)]} {
                     append commands "<FF> INFO:  $rail_option for $domain = $vars($domain,$rail_option)\n"
                     if {$rail_option == "pwr_nets"} {
                     foreach pg_net $vars($domain,$rail_option) {
                        if {[info exists vars($pg_net,voltage)]} {
                           append commands "<FF> INFO:  $pg_net voltage = $vars($pg_net,voltage)\n"
                        } else {
                           append commands "<FF> ERROR: Required variable vars($pg_net,voltage) not defined\n"
                           set errors($abort) "Required variable vars($pg_net,voltage) not defined"
                           incr abort
                        }
                     }
                     }
                  } else {
                     append commands "<FF> ERROR: Required variable vars($domain,$rail_option) not defined\n"
                     set errors($abort) "Required variable vars($domain,$rail_option) not defined"
                     incr abort
                  }
               }
            }
      } else {
         append commands "<FF> ERROR: Required variable vars(power_domains) not defined\n"
         set errors($abort) "Required variable vars(power_domains) not defined"
         incr abort
      }
      
      append commands "<FF> ================================================================================\n"
      append commands "<FF>                   Checking for Power Pad Location Files\n"
      append commands "<FF> ================================================================================\n"
      if {[info exists vars(power_domains)] && ($vars(power_domains) != "")} {
         foreach domain $vars(power_domains) {
            foreach rail_option "pwr_nets gnd_nets" {
               if {[info exists vars($domain,$rail_option)]} {
                  foreach pg_net $vars($domain,$rail_option) {
                     if {[info exists vars($pg_net,format)] && ($vars($pg_net,format) != "defpin")} {
                        if {[info exists vars($pg_net,pad_file)] && ($vars($pg_net,pad_file) != "")} {
                           set first 1
                           append commands "<FF> INFO: $pg_net net's\n"
                           foreach file_name $vars($pg_net,pad_file) {
                              if {$first == 1} {
                                 append commands "<FF> INFO:        pad_file = $file_name\n"
                                 set first 0
                              } else {
                                 append commands "<FF> INFO:                         $file_name\n"
                              }
                              lappend check(pp_files) $file_name
                           }
                        } else { 
                          append commands "<FF> ERROR: Required variable vars($pg_net,pad_file) not defined\n"
                           set errors($abort) "Required variable vars($pg_net,pad_file) not defined"
                           incr abort
                               }  
                #     } elseif {![info exists vars($pg_net,format)]} {
                #        append commands "<FF> ERROR: Required variable vars($pg_net,format) not defined\n"
                #        set errors($abort) "Required variable vars($pg_net,format) not defined"
                #        incr abort
                     } else {
                       append commands "<FF> INFO: $pg_net net's format is \"defpin\", pad_file is not required\n"
                   }
                  }
               } else {
                  append commands "<FF> WARNING: For PG nets under $domain Power-Domain, Please Make sure the\n"
                  append commands "<FF>             PP Location Files and/or PP file formats defined\n"
               }
            }
         }
      }
      
      append commands "<FF> ================================================================================\n"
      append commands "<FF>                          Rail Analysis Options\n"
      foreach analysis $vars(req_eps_rail_analysis) {
         append commands "<FF> ================================================================================\n"
         append commands "<FF>       Checking for Power Data Files required for \"$analysis\" Analysis\n"
         append commands "<FF> ================================================================================\n"
         if {[info exists vars(power_domains)] && ($vars(power_domains) != "")} {
            set vars(type) [lindex [split $analysis "_"] 0]
            set vars(utype) [string toupper $vars(type)]
            set vars(data_path) $vars(rpt_dir)/$vars(utype)_power
            foreach domain $vars(power_domains) {
               foreach rail_option "pwr_nets gnd_nets" {
                  if {[info exists vars($domain,$rail_option)]} {
                     foreach pg_net $vars($domain,$rail_option) {
                        if {$pwr_ascii == 1} {
                           set pwr_ascii 0
                           append commands "<FF> INFO: ascii format Instance Power File for Power Net is provided, so\n"
                           append commands "<FF>       it is not mandatory to have power file for Ground Net\n"
                        }
                        if {[info exists vars($analysis,$pg_net,pti_file)] && ($vars($analysis,$pg_net,pti_file) != "")} {
                           set first 1
                           append commands "<FF> INFO: \"$pg_net\" net's current data files\n"
                           foreach file_name $vars($analysis,$pg_net,pti_file) {
                              if {$first == 1} {
                                 append commands "<FF> INFO:        pti_file = $file_name\n"
                                 set first 0
                              } else {
                                 append commands "<FF> INFO:                   $file_name\n"
                              }
                              lappend check(data_files) $file_name
                           }
                        } elseif {[info exists vars($analysis,$pg_net,ascii_file)] && ($vars($analysis,$pg_net,ascii_file) != "")} {
                           set first 1
                           append commands "<FF> INFO: \"$pg_net\" net's power data files\n"
                           foreach file_name $vars($analysis,$pg_net,ascii_file) {
                              if {$first == 1} {
                                 append commands "<FF> INFO:        ascii_file = $file_name\n"
                                 set first 0
                              } else {
                                 append commands "<FF> INFO:                     $file_name\n"
                              }
                              lappend check(data_files) $file_name
                           }
                           if {$rail_option == "pwr_nets"} {
                              set pwr_ascii 1
                           }
                        } elseif {[info exists vars(data_path)/$vars(type)_$pg_net.ptiavg]} {
                           append commands "<FF> INFO: \"$pg_net\" net's pti data files\n"
                           append commands "<FF> INFO:        pti_file = $file_name\n"
                           lappend check(data_files) $file_name
                        } elseif {$vars(type) == "static"} {
                           if {(![info exists vars(static_power)]) ||
                               ([info exists vars(static_power)] && ($vars(static_power) != "true"))} {
                              append commands "<FF> WARNING: Make sure $vars(type)_$pg_net.ptiavg file available for analysis else\n"
                              append commands "<FF>          enable \"$vars(type)_power\" to generate those files\n"
                           } else {
                              append commands "<FF> INFO: Power Data File for \"$pg_net\" will be generated by \"static_power\" Analysis\n"
                           }
                        } elseif {$vars(type) == "dynamic"} {
                           if {(![info exists vars(dynamic_power)]) ||
                               ([info exists vars(dynamic_power)] && ($vars(dynamic_power) != "true"))} {
                              append commands "<FF> WARNING: Make sure $vars(type)_$pg_net.ptiavg file available for analysis else\n"
                              append commands "<FF>          enable \"$vars(type)_power\" to generate those files\n"
                           } else {
                              append commands "<FF> INFO: Power Data File for \"$pg_net\" will be generated by \"dynamic_power\" Analysis\n"
                           }
                        }
                     }
                  }
               }
            }
         }
      
         append commands "<FF> ================================================================================\n"
         if {[info exists vars($analysis,analyze_domains)]} {
            append commands "<FF> INFO: The analysis will be performed on $vars($analysis,analyze_domains):\n"
         } else {
            append commands "<FF> ERROR: Required variable vars($analysis,analyze_domains) not defined\n"
            set errors($abort) "Required variable vars($analysis,analyze_domains) not defined"
            incr abort
         }
         append commands "<FF> ================================================================================\n"
         append commands "<FF> INFO: Options being used for \"$analysis\" ANALYSIS:\n"
         foreach rail_option "analyze_type accuracy analysis_view temperature dist_solver_processing \
                              powering_up_nets gen_power_switch_eco gen_decap_eco decap_opt_method \
                              decap_removal_method save_voltage_waveforms gen_bb_voltage_file \
                              save_current_files ignore_shorts decap_eco_file cell_ignore_file fast_views_list \
                              fast_accurate_views_list accurate_views_list ext_inc_file dis_analysis_types" {
            if {[info exists vars($analysis,$rail_option)]} {
               append commands "<FF> INFO:     $rail_option = $vars($analysis,$rail_option)\n"
               if {($rail_option == "cell_ignore_file") ||
                   ($rail_option == "decap_eco_file") ||
                   ($rail_option == "fast_views_list") ||
                   ($rail_option == "fast_accurate_views_list") ||
                   ($rail_option == "accurate_views_list") ||
                   ($rail_option == "ext_inc_file")} {
                  lappend check(vstorm_inc_files) $vars($analysis,$rail_option)
               }
            }
         }
      
         set vars(vstorm_inc_req_files) "vstorm2_begin_file vstorm2_end_file"
         set first 1
         foreach file_name $vars(vstorm_inc_req_files) {
            if {[info exists vars($analysis,$file_name)] && ($vars($analysis,$file_name) != "")} {
               if {$first == 1} {
                  append commands "<FF> ================================================================================\n"
                  append commands "<FF>                     Checking for Rail Analysis Files\n"
                  append commands "<FF> ================================================================================\n"
                  append commands "<FF> INFO: $analysis $file_name = $vars($analysis,$file_name)\n"
                  set first 0
               } else {
                  append commands "<FF> INFO: $analysis $file_name = $vars($analysis,$file_name)\n"
               }
               lappend check(vstorm_inc_files) $vars($analysis,$file_name)
            }
         }
      }
      }
      }
	

      append commands "<FF> ================================================================================\n"
      append commands "<FF>                                  File Check\n"
      append commands "<FF> ================================================================================\n"
      set files 0
      append commands "<FF> INFO: Checking design files ...\n"
	# whatever the flow is, check lef first
	if {1} {
	 append commands "<FF> INFO: Checking LEF files ...\n"
         if {[info exists vars(lef_files)]} {
            foreach file $vars(lef_files) {
      #   append commands "<FF> INFO: $file ...\n"
               if {![file exists $file]} {
                  append commands "<FF> ERROR: File does not exist ($file) ...\n"
                  set errors($abort) "File does not exist ($file)"
                  incr abort
               } else {
                  incr files
               }
            } 
         }
         append commands "<FF> INFO:    ... found $files files\n"
         set files 0
	} 
	# debug
	# puts $check(files)
	if {($check(pg_files) != "")} {
	append commands "<FF> INFO: Checking files for pg library generation ...\n"
	foreach file $check(pg_files) {
		if {![file exists $file]} {
		append commands "<FF> ERROR: File does not exist ($file) ...\n"
               set errors($abort) "File does not exist ($file)"
               incr abort
		} else { 
			incr files 
		}
	  }
	append commands "<FF> INFO:    ... found $files files\n"
         set files 0
	}
	if {!([info exists vars(pg_only)] && ($vars(pg_only) == "true"))} {
      foreach file $check(files) {
      #   append commands "<FF> INFO:    $file ...\n"
         if {![file exists $file]} {
            append commands "<FF> ERROR: File does not exist ($file) ...\n"
            set errors($abort) "File does not exist ($file)"
            incr abort
         } else {
            incr files
         }
      }
      append commands "<FF> INFO:    ... found $files files\n"
      set files 0
      if {![info exists vars(load_edi_db)] ||
          ([info exists vars(load_edi_db)] && ($vars(load_edi_db) == "false"))} {
      ## if {($check(lib_files) != "")} 
         if {[info exists vars(library_sets)]} {
            foreach library_set $vars(library_sets) {
               append commands "<FF> INFO: Checking .libs for \"$library_set\" library set ...\n"
               if {[info exists vars($library_set,timing)]} {
                  foreach file $vars($library_set,timing) {
         #      append commands "<FF> INFO:    $file ...\n"
                     if {![file exists $file]} {
                        append commands "<FF> ERROR: File does not exist ($file) ...\n"
                        set errors($abort) "File does not exist ($file)"
                        incr abort
                     } else {
                        incr files
                     }
                  }
               }
               append commands "<FF> INFO:    ... found $files files\n"
               set files 0
            }
         }
      }
      if {![info exists vars(load_edi_db)] ||
          ([info exists vars(load_edi_db)] && ($vars(load_edi_db) == "false"))} {
      ## if {($check(lef_files) != "")} 
         append commands "<FF> INFO: Checking LEF files ...\n"
         if {[info exists vars(lef_files)]} {
            foreach file $vars(lef_files) {
      #   append commands "<FF> INFO: $file ...\n"
               if {![file exists $file]} {
                  append commands "<FF> ERROR: File does not exist ($file) ...\n"
                  set errors($abort) "File does not exist ($file)"
                  incr abort
               } else {
                  incr files
               }
            } 
         }
         append commands "<FF> INFO:    ... found $files files\n"
         set files 0
      }
      if {($check(pgv_files) != "")} {
#GP#         append commands "<FF> INFO: Checking cl_views...\n"
#GP#         if {[info exists vars(cl_views)]} {
#GP#            foreach file $vars(cl_views) {
#GP#      #    append commands "<FF> INFO:    $file ...\n"
#GP#               if {![file exists $file]} {
#GP#                  append commands "<FF> ERROR: File does not exist ($file) ...\n"
#GP#                  set errors($abort) "File does not exist ($file)"
#GP#                  incr abort
#GP#               } else {
#GP#                  incr files
#GP#               }
#GP#            }
 #GP#        }
         append commands "<FF> INFO:    ... found $files files\n"
         set files 0
      }
      if {($check(plugins) != "")} {
         append commands "<FF> INFO: Checking plug-in files ...\n"
         foreach file $check(plugins) {
      #   append commands "<FF> INFO:    $file ...\n"
            if {![file exists $file]} {
               append commands "<FF> WARNING: File does not exist ($file) ... continuing\n"
      #      set errors($abort) "File does not exist ($file)"
      #      incr abort
            } else {
               incr files
            }
         }
         append commands "<FF> INFO:    ... found $files files\n"
         set files 0
      }
      if {($check(pwr_inc_files) != "")} {
         append commands "<FF> INFO: Checking power_include files ...\n"
         foreach file $check(pwr_inc_files) {
      #   append commands "<FF> INFO:    $file ...\n"
            if {![file exists $file]} {
               append commands "<FF> ERROR: File does not exist ($file) ...\n"
               set errors($abort) "File does not exist ($file)"
               incr abort
            } else {
               incr files
            }
         }
         append commands "<FF> INFO:    ... found $files files\n"
         set files 0
      }
      if {($check(vstorm_inc_files) != "")} {
         append commands "<FF> INFO: Checking Voltage-Storm_include files ...\n"
         foreach file $check(vstorm_inc_files) {
      #   append commands "<FF> INFO:    $file ...\n"
            if {![file exists $file]} {
               append commands "<FF> ERROR: File does not exist ($file) ...\n"
               set errors($abort) "File does not exist ($file)"
               incr abort
            } else {
               incr files
            }
         }
         append commands "<FF> INFO:    ... found $files files\n"
         set files 0
      }
      if {($check(data_files) != "")} {
         append commands "<FF> INFO: Checking Power Data files ...\n"
         foreach file $check(data_files) {
      #   append commands "<FF> INFO:    $file ...\n"
            if {![file exists $file]} {
               append commands "<FF> ERROR: File does not exist ($file) ...\n"
               set errors($abort) "File does not exist ($file)"
               incr abort
            } else {
               incr files
            }
         }
         append commands "<FF> INFO:    ... found $files files\n"
         set files 0
      }
      if {($check(pp_files) != "")} {
         append commands "<FF> INFO: Checking Power-PAD location files ...\n"
         foreach file $check(pp_files) {
      #   append commands "<FF> INFO:    $file ...\n"
            if {![file exists $file]} {
               append commands "<FF> ERROR: File does not exist ($file) ...\n"
               set errors($abort) "File does not exist ($file)"
               incr abort
            } else {
               incr files
            }
         }
         append commands "<FF> INFO:    ... found $files files\n"
         set files 0
      }
      if {($check(em_model_file) != "")} {
         append commands "<FF> INFO: Checking EM models file ...\n"
         foreach file $check(em_model_file) {
      #   append commands "<FF> INFO:    $file ...\n"
            if {![file exists $file]} {
               append commands "<FF> WARNING: File does not exist ($file) ... continuing\n"
               ## set errors($abort) "File does not exist ($file)"
               ## incr abort
            } else {
               incr files
            }
         }
         append commands "<FF> INFO:    ... found $files files\n"
         set files 0
      }
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
         append commands "<FF> ================================================================================\n"
         append commands "<FF>                             SETUP CHECK PASSED\n"
         append commands "<FF> ================================================================================\n"
#         exit 0
      }


      file mkdir $vars(script_dir)
      set op [open $vars(script_dir)/voltus.check.rpt w]

      puts $op $commands

      close $op

#      if {$vars(abort) && ($error_count > 0)} {
#         puts "<FF> Aborting due to previous errors ..."
#         puts "<FF> See $vars(script_dir)/check.rpt for details"
#         puts ""
#         puts "                  Error Summary"
#         puts "                  -------------"
#
#         for {set i 0} {$i<$error_count} {incr i} {
#            puts "   ([expr $i + 1]) $errors($i)"
#         }
#         puts "-------------------------------------------------"
#         exit -1
#      }

      
   }

   proc gen_makefile {} {

      global vars
      global env
      global errors

      puts "-------------------------------------------------"
      puts "<FF> Generating Makefile ..."
      puts "-------------------------------------------------"

      set vars(makefile_name) Makefile.voltus

      set fhw [open $vars(makefile_name) w]

      puts $fhw "VERSION=post-13.2"
      puts $fhw "DATE=`date +%m_%d_%Y`"
      puts $fhw "TOOL=voltus"

      puts $fhw "ARGS=``"

      puts $fhw "all: help"

      puts $fhw "version:"
      puts $fhw "	@echo \"# The VOLTUS Foundation Flows Version \$(VERSION)\""

      puts $fhw "help:"
      puts $fhw "\t@echo \"===================================================\""
      puts $fhw "\t@echo \"           \$(VERSION) VOLTUS Foundation Flow\""
      puts $fhw "\t@echo \"===================================================\""
      puts $fhw "\t@echo \" Makefile Targets\""
      puts $fhw "\t@echo \"===================================================\""
      puts $fhw "\t@echo \"            help : usage of this Makefile\""
      puts $fhw "\t@echo \"         version : The VOLTUS Foundation Flow version\""
      puts $fhw "\t@echo \"            flow : sets up and runs the flow\""
      puts $fhw "\t@echo \"===================================================\""
      puts $fhw "\t@echo \" Makefile Options\""
      puts $fhw "\t@echo \"===================================================\""
      puts $fhw "\t@echo \"    TOOL : VOLTUS executable    (default voltus)\""
      puts $fhw "\t@echo \"    ARGS : VOLTUS arguments     (default NA )\""
      puts $fhw "\t@echo \"===================================================\""
      puts $fhw "\t@echo \" usage: make flow\""
      puts $fhw "\t@echo \" usage: make flow ARGS=\\\"-tpsl -32 -nowin\\\"\""
      puts $fhw "\t@echo \"===================================================\""

      puts $fhw "setup:"
      puts $fhw "\t@if \[ -r $vars(log_dir) \] ; then \\"
      puts $fhw "\t\techo \"INFO: The $vars(log_dir) directory already exists, VOLTUS FF using the existing $vars(log_dir) directory.\" ;\\"
      puts $fhw "\telse \\"
      puts $fhw "\t\tmkdir $vars(log_dir) ;\\"
      puts $fhw "\tfi"

      puts $fhw "pgv: version setup"
      puts $fhw "\t\$(TOOL) -init $vars(script_dir)/VOLTUS/run_pgv.tcl -log $vars(log_dir)/voltus_flow_pgv_\$(DATE).log -cmd $vars(log_dir)/voltus_flow_pgv_\$(DATE).cmd \$(ARGS)"

      puts $fhw "static: version setup"
      puts $fhw "\t\$(TOOL) -init $vars(script_dir)/VOLTUS/run_static.tcl -log $vars(log_dir)/voltus_flow_static_\$(DATE).log -cmd $vars(log_dir)/voltus_flow_static_\$(DATE).cmd \$(ARGS)"

      puts $fhw "dynamic: version setup"
      puts $fhw "\t\$(TOOL) -init $vars(script_dir)/VOLTUS/run_dynamic.tcl -log $vars(log_dir)/voltus_flow_dynamic_\$(DATE).log -cmd $vars(log_dir)/voltus_flow_dynamic_\$(DATE).cmd \$(ARGS)"

      puts $fhw "signal_em: version setup"
      puts $fhw "\t\$(TOOL) -init $vars(script_dir)/VOLTUS/run_signal_em.tcl -log $vars(log_dir)/voltus_flow_sem_\$(DATE).log -cmd $vars(log_dir)/voltus_flow_sem_\$(DATE).cmd \$(ARGS)"

      puts $fhw "esd: version setup"
      puts $fhw "\t\$(TOOL) -init $vars(script_dir)/VOLTUS/run_esd.tcl -log $vars(log_dir)/voltus_flow_esd_\$(DATE).log -cmd $vars(log_dir)/voltus_flow_esd_\$(DATE).cmd \$(ARGS)"

      puts $fhw "all: version setup"
      puts $fhw "\t\$(TOOL) -init $vars(script_dir)/VOLTUS/run_pg_static_dynamic.tcl -log $vars(log_dir)/voltus_flow_all_\$(DATE).log -cmd $vars(log_dir)/voltus_flow_all_\$(DATE).cmd \$(ARGS)"

      puts $fhw "reset: version setup"
      puts $fhw "\trm -rf ./LOG/* ./RPT/* ./PGV/* ./FF/VOLTUS/*"

      puts $fhw "clean: version setup"
      puts $fhw "\trm -rf ./LOG ./RPT ./PGV ./FF Makefile*"

      close $fhw
   }

   proc insert_comments {} {

      global vars

      set comments ""
      if {[info exists vars(comments)]} {
         append comments "# Variables affecting this step:\n"
         append comments "#---------------------------------------------------------------------\n"
         append comments $vars(comments)
         append comments "#---------------------------------------------------------------------\n"
#         append comments "######################################################################\n"
         unset vars(comments)
      }
      if {[info exists vars(ucomments)]} {
         append comments "# Additional variables for this step:\n"
         append comments "#---------------------------------------------------------------------\n"
         append comments $vars(ucomments)
         append comments "#---------------------------------------------------------------------\n"
#         append comments "######################################################################\n"
         unset vars(ucomments)
      }
      return $comments
   }

   proc initialize_multicpu {} {
   
      global vars

      set commands ""
      set comments ""
      set ucomments ""
   
      #Puts "<FF> SETTING UP MULTI PROCESS DISTRIBUTION AND THREADING"
      
      if {[info exists vars(distribute)]} {
         switch $vars(distribute) {
            "rsh" {
               if {[info exists vars(rsh,host_list)]} {
                  #puts "<FF> Running rsh ($vars(rsh,host_list))"
                  set command "set_distribute_host -rsh -add $vars(rsh,host_list)"
               }
            }
            "local" {
               #puts "<FF> Running local machine"
               set command "set_distribute_host -local\n"
            }
            "custom" {
               if {[info exists vars(custom,script)]} {
                  #puts "<FF> Running custom ($vars(custom,script))"
                  set command "set_distribute_host -custom -custom_script $vars(custom,script)"
               }
            }
            "lsf" {
               if {[info exists vars(lsf,queue)]} {
                  #puts "<FF> Running LSF ($vars(lsf,queue))"
                  set command "set_distribute_host -lsf -queue $vars(lsf,queue)"
               }
               if {[info exists command] &&
                   [info exists vars(lsf,resource)]} {
                  append command " -resource \{$vars(lsf,resource)\}"
                  #append command " -resource $vars(lsf,resource)"
		
               }
               if {[info exists command] &&
                   [info exists vars(lsf,args)]} {
                  append command " -lsf_args \{$vars(lsf,args)\}"
                  #append command " -lsf_args $vars(lsf,args)"
               }
            }
            default {
                #puts "<FF> Distribution type $vars(distribute) not supported"
            }
         }
         append commands [FF::wrap_command set_distribute_host $command]
         set command "\nset_multi_cpu_usage -localCpu $vars(local_cpus)"
         if {[info exists vars(remote_hosts)]} {
            append command " -remoteHost $vars(remote_hosts)"
         }
         if {[info exists vars(cpu_per_remote_host)]} {
            append command " -cpuPerRemoteHost $vars(cpu_per_remote_host)"
         }
         append command " -threadInfo 2 -verbose"
         if {[info exists vars(keep_license)]} {
            append command " -keepLicense $vars(keep_license)" 
         }
         append commands [FF::wrap_command set_multi_cpu_usage $command]
      } else {
         set command "set_distribute_host -local"
         append commands [FF::wrap_command set_distribute_host $command]
         set command "set_multi_cpu_usage -localCpu $vars(local_cpus) -threadInfo 2 -verbose"
         if {[info exists vars(keep_license)]} {
            append command " -keepLicense $vars(keep_license)"
         } 
         append commands [FF::wrap_command set_multi_cpu_usage $command]
      }

      return $commands
      
   }


      ################################################################################
      # The script to load EDI database for VOLTUS FF and setup Analysis
      ################################################################################
   proc load_edi {} {

      global vars
      
      set comments ""
      set ucomments ""

if {[info exists vars(edi_db_name)] && [file exists $vars(edi_db_name)] &&
    [info exists vars(load_edi_db)] && ($vars(load_edi_db) == "true")} {

    set command "read_design -physical_data $vars(edi_db_name)\n"
    	 append commands [FF::wrap_command read_design $command]

            if {[info exists vars(rc_corners)]} {
               append comments "#   - vars(rc_corners)\n"
               set command ""
               foreach corner $vars(rc_corners) {
                  if {[info exists vars($corner,spef)] && [file exists $vars($corner,spef)]} {
                     append comments "#   - vars($corner,spef)\n"
                     #Puts "<FF> Reading spef file for $corner : $vars($corner,spef)" 
                     append command "read_spef -rc_corner $corner $vars($corner,spef)\n"
                  } else {
                     append ucomments "#   - vars($corner,spef)\n"
                  }
               }
               append commands [FF::wrap_command read_spef $command]
            } else {
	append commands "# rc_corner doesn't been defined in spef, Voltus only read spef !\n"
	set command "read_spef $vars(spef)\n"
        append commands [FF::wrap_command read_spef $command]
	} 
   } else {	puts "<INFO> Signal_em analysis FF can't be performed successfully !"
		puts "<INFO> Please Include Voltus or Innovus Database for Signal_em Flow !\n"
	}
}


  proc load_design_pgv {} {

      global vars
      
      set comments ""
      set ucomments ""

     if {([info exists vars(generate_pg)] && ($vars(generate_pg) == "true")) || ([info exists vars(pg_only)] && ($vars(pg_only) != ""))} {
	if {[info exists vars(lef_files)] && ([llength $vars(lef_files)] >= 1)} {
               append comments "#   - vars(lef_files)\n"
               #Puts "<FF> Reading physical library sets:"
      append commands "#---------------------------------------------------------------------\n"
      append commands "# Power Grid library generation only flow, only lef files are loaded\n"
      append commands "#---------------------------------------------------------------------\n"
               set command "read_lib -lef \"$vars(lef_files)\"\n"
               append commands [FF::wrap_command read_lef $command]
           }
     }
}


  proc load_design_esd {} {

      global vars
      
      set comments ""
      set ucomments ""

     if {([info exists vars(esd_analyze)] && ($vars(esd_analyze) == "true")) && ([info exists vars(specify_def)] && $vars(specify_def) != "")} {
	if {[info exists vars(lef_files)] && ([llength $vars(lef_files)] >= 1)} {
               append comments "#   - vars(lef_files)\n"
               #puts "<FF> Reading physical library sets:"
               set command "read_lib -lef $vars(lef_files)\n"
               append commands [FF::wrap_command read_lef $command]
           }
        if {[info exists vars(library_sets)]} {
               append comments "#   - vars(library_sets)\n"
               #Puts "<FF> Reading timing library sets: $vars(library_sets)..." 
           foreach library_set $vars(library_sets) {
             if {[info exists vars($library_set,timing)] && ($vars($library_set,timing) != "")} {
                if {($library_set == "min") || ($library_set == "max")} {
                   set command "read_lib -$library_set \"$vars($library_set,timing)\"\n"
                   } else {
                   set command "read_lib \"$vars($library_set,timing)\"\n"}
                   }
               }
                   append commands [FF::wrap_command read_lib $command]
            }
	if {[info exists vars(specify_def)] && ($vars(specify_def) != "")} {
		#puts "specify_def file read"
		append commands "specify_def $vars(def_files)\n"
	}
     } else {
	if {[info exists vars(lef_files)] && ([llength $vars(lef_files)] >= 1)} {
               append comments "#   - vars(lef_files)\n"
               #Puts "<FF> Reading physical library sets:"
               set command "read_lib -lef \"$vars(lef_files)\"\n"
               append commands [FF::wrap_command read_lef $command]
           }
        if {[info exists vars(library_sets)]} {
               append comments "#   - vars(library_sets)\n"
               #Puts "<FF> Reading timing library sets: $vars(library_sets)..." 
           foreach library_set $vars(library_sets) {
             if {[info exists vars($library_set,timing)] && ($vars($library_set,timing) != "")} {
                if {($library_set == "min") || ($library_set == "max")} {
                   set command "read_lib -$library_set \"$vars($library_set,timing)\"\n"
                   } else {
                   set command "read_lib \"$vars($library_set,timing)\"\n"}
                   }
               }
                   append commands [FF::wrap_command read_lib $command]
            }

	if {[info exists vars(netlist)] && ([llength $vars(netlist)] >= 1)} {
               append comments "#   - vars(netlist)\n"
               #Puts "<FF> Reading netlist(s): " 
               set command "\nread_verilog \"$vars(netlist)\"\n"
               append commands [FF::wrap_command read_verilog $command]
            }
	if {[info exists vars(design)]} {
               append comments "#   - vars(design)\n"
               #Puts "<FF> Setting the top_design : $vars(design)..."
               set command "set_top_module"
               if {[info exists vars(ignore_undefined_cell)] && ($vars(ignore_undefined_cell) == "true")} {
                  append command " -ignore_undefined_cell"
                  append comments "#   - vars(ignore_undefined_cell)\n"
               } else {
                  append ucomments "#   - vars(ignore_undefined_cell)\n"
               }
        if {[info exists vars(ignore_timing_library_check)] && ($vars(ignore_timing_library_check) == "true")} {
                  append command " -ignore_timing_library_check"
                  append comments "#   - vars(ignore_timing_library_check)\n"
               } else {
                  append ucomments "#   - vars(ignore_timing_library_check)\n"
               }
               append command " $vars(design)\n"
               append commands [FF::wrap_command set_top_module $command]
            }
		set strs ""
		if {[info exists vars(rdl_def)] && ([llength $vars(rdl_def)] >= 1)} {
			append strs " -rdl_def $vars(rdl_def)"
		}
		if {[info exists vars(rdl_placement)] && ($vars(rdl_placement) != "")} {
			append strs " -rdl_placement \{$vars(rdl_placement)\}"
		}
		if {[info exists vars(rdl_orientation)] && ($vars(rdl_orientation) != "")} {
			append strs " -rdl_orientation $vars(rdl_orientation)"
		}
		if {[info exists vars(def_files)] && ([llength $vars(def_files)] >= 1)} {
		append commands "\n"
		set command "read_def $vars(def_files) $strs\n"
               	append commands [FF::wrap_command read_def $command]
		}
	}
}


   proc load_design {} {

      global vars
      
      set comments ""
      set ucomments ""

      ################################################################################
      # The script to load the design for VOLTUS FF and setup Analysis
      ################################################################################
	# add pg only flow
     if {[info exists vars(pg_only)] && ($vars(pg_only) == "true")} {
	if {[info exists vars(lef_files)] && ([llength $vars(lef_files)] >= 1)} {
               append comments "#   - vars(lef_files)\n"
               #Puts "<FF> Reading physical library sets:"
      append commands "#---------------------------------------------------------------------\n"
      append commands "# Power Grid library generation only flow, only lef files are loaded\n"
      append commands "#---------------------------------------------------------------------\n"
               set command "read_lib -lef \"$vars(lef_files)\"\n"
               append commands [FF::wrap_command read_lef $command]
            }
     } else {
      if {[info exists vars(user_load_design_tcl)] &&
          [file exists $vars(user_load_design_tcl)]} {
      #   Puts "<FF> LOADING USER DEFINED PLUG-IN : $vars(user_load_design_tcl)"
         append commands "#---------------------------------------------------------------------\n"
         append commands "# This script can be modified using the plug-in -> vars(user_load_design_tcl)\n"
         append commands "#---------------------------------------------------------------------\n"
         append commands [FF::source_plug user_load_design_tcl]
      } else {
        if {[info exists vars(edi_db_name)] &&
            [file exists $vars(edi_db_name)] &&
            [info exists vars(load_edi_db)] &&
            ($vars(load_edi_db) == "true")} {

           append comments "#   - vars(edi_db_name)\n"
           append comments "#   - vars(load_edi_db)\n"
           append comments "#   - vars(design)\n"
           append comments "#   - vars(netlist)\n"
           append comments "#   - vars(library_sets)\n"
           append comments "#   - vars(lef_files)\n"

           set command "set_import_mode -syncRelativePath false\n"
           append commands [FF::wrap_command set_import_mode $command]
           set command "read_design -physical_data $vars(edi_db_name)\n"
           append commands [FF::wrap_command read_design $command]
        
         } elseif {0} {
       # for read_view_definition
	} else {
            append ucomments "#   - vars(edi_db_name)\n"
            append ucomments "#   - vars(load_edi_db)\n"
            set command ""
            if {[info exists vars(library_sets)]} {
               append comments "#   - vars(library_sets)\n"
               #Puts "<FF> Reading timing library sets: $vars(library_sets)..." 
               foreach library_set $vars(library_sets) {
                  if {[info exists vars($library_set,timing)] && ($vars($library_set,timing) != "")} {
                     if {($library_set == "min") || ($library_set == "max")} {
                        append command "read_lib -$library_set \"$vars($library_set,timing)\"\n"
                     } else {
                        append command "read_lib \"$vars($library_set,timing)\"\n"
                     }
                  }
               }
               append commands [FF::wrap_command read_lib $command]
            }
      
            if {[info exists vars(lef_files)] && ([llength $vars(lef_files)] >= 1)} {
               append comments "#   - vars(lef_files)\n"
               #Puts "<FF> Reading physical library sets:"
               set command "read_lib -lef \"$vars(lef_files)\"\n"
               append commands [FF::wrap_command read_lef $command]
            }
	# if specify_def =true, design should be ignored
	  if {[info exists vars(specify_def)] && ($vars(specify_def) != "")} {
	 	append commands " specify_def $vars(def_files)\n"
	 	#set command " specify_def $vars(def_files)\n"
	   } else {
            if {[info exists vars(netlist)] && ([llength $vars(netlist)] >= 1)} {
               append comments "#   - vars(netlist)\n"
               #Puts "<FF> Reading netlist(s): " 
               set command "read_verilog \"$vars(netlist)\"\n"
               append commands [FF::wrap_command read_verilog $command]
            }
            if {[info exists vars(design)]} {
               append comments "#   - vars(design)\n"
               #Puts "<FF> Setting the top_design : $vars(design)..."
               set command "set_top_module"
               if {[info exists vars(ignore_undefined_cell)] &&
                   ($vars(ignore_undefined_cell) == "true")} {
                  append command " -ignore_undefined_cell"
                  append comments "#   - vars(ignore_undefined_cell)\n"
               } else {
                  append ucomments "#   - vars(ignore_undefined_cell)\n"
               }
               if {[info exists vars(ignore_timing_library_check)] &&
                   ($vars(ignore_timing_library_check) == "true")} {
                  append command " -ignore_timing_library_check"
                  append comments "#   - vars(ignore_timing_library_check)\n"
               } else {
                  append ucomments "#   - vars(ignore_timing_library_check)\n"
               }
               append command " $vars(design)\n"
               append commands [FF::wrap_command set_top_module $command]
            	}
              
		set strs ""
                if {[info exists vars(rdl_def)] && ([llength $vars(rdl_def)] >= 1)} {
                        append strs " -rdl_def $vars(rdl_def)"
                }
                if {[info exists vars(rdl_placement)] && ($vars(rdl_placement) != "")} {
                        append strs " -rdl_placement \{$vars(rdl_placement)\}"
                }
                if {[info exists vars(rdl_orientation)] && ($vars(rdl_orientation) != "")} {
                        append strs " -rdl_orientation $vars(rdl_orientation)"
                }
                if {[info exists vars(def_files)] && ([llength $vars(def_files)] >= 1)} {
                append commands "\n"
                set command "read_def $vars(def_files) $strs\n"
                append commands [FF::wrap_command read_def $command]
                }
	}
            if {[info exists vars(sdc_files)] && ([llength $vars(sdc_files)] >= 1)} {
               #Puts "<FF> Loading Constraints file(s) : "
               set command "read_sdc $vars(sdc_files)\n"
               append commands [FF::wrap_command read_sdc $command]
               append comments "#   - vars(sdc_files)\n"
            } else {
               append ucomments "#   - vars(sdc_files)\n"
            }
         }
         
	if {[info exists vars(twf_files)] && [llength $vars(twf_files)] >= 1} {
        #Puts "<FF> READ TWF FILE FROM setup.tcl "
        set command "read_twf $vars(twf_files)\n"
        append commands [FF::wrap_command read_twf $command]
        }

      if {[info exists vars(set_write_twf_tcl)] && [file exists $vars(set_write_twf_tcl)]} {
        #Puts "<FF> LOADING READ TWF PLUG-IN : $vars(set_write_twf_tcl)"
         append commands "#---------------------------------------------------------------------\n"
         append commands "# This script can be modified using the plug-in -> vars(set_write_twf_tcl)\n"
         append commands "#---------------------------------------------------------------------\n"
         append commands [FF::source_plug set_write_twf_tcl]
        }

         if {[info exists vars(cpf_file)] && [file exists $vars(cpf_file)]} {
            #Puts "<FF> Reading cpf file : $vars(cpf_file)"
            set command "read_power_domain -cpf $vars(cpf_file)\n"
            append commands [FF::wrap_command read_power_domain $command]
         }
         if {[info exists vars(mmmc_setup_file)] && [file exists $vars(mmmc_setup_file)]} {
#            Puts "<FF> Loading mmmc setup file : $vars(mmmc_setup_file)"
            append comments "#   - vars(mmmc_setup_file)\n"
            append commands "source $vars(mmmc_setup_file)\n"
         } else {
            append ucomments "#   - vars(mmmc_setup_file)\n"
         }
         
         if {([info exists vars(static_power)] && ($vars(static_power) == "true")) ||
             ([info exists vars(dynamic_power)] && ($vars(dynamic_power) == "true"))} {
            append comments "#   - vars(static_power)\n"
            append comments "#   - vars(dynamic_power)\n"
            if {[info exists vars(rc_corners)]} {
               append comments "#   - vars(rc_corners)\n"
               set command ""
               foreach corner $vars(rc_corners) {
                  if {[info exists vars($corner,spef)] && [file exists $vars($corner,spef)]} {
                     append comments "#   - vars($corner,spef)\n"
                     #Puts "<FF> Reading spef file for $corner : $vars($corner,spef)" 
                     append command "read_spef -rc_corner $corner $vars($corner,spef)\n"
                  } else {
                     append ucomments "#   - vars($corner,spef)\n"
                  }
               }
               append commands [FF::wrap_command read_spef $command]
            } else {
               append ucomments "#   - vars(rc_corners)\n"
               if {[info exists vars(spef)] && ([llength $vars(spef)] >= 1)} {
                  append comments "#   - vars(spef)\n"
                  Puts "<FF> Loading Parasitic file(s)"
                  set command "read_spef $vars(spef)\n"
                  append commands [FF::wrap_command read_spef $command]
               } else {
                  append comments "#   - vars(spef)\n"
               }
            }
         } else {
            append ucomments "#   - vars(static_power)\n"
            append ucomments "#   - vars(dynamic_power)\n"
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

    }
      
      set fcommands [FF_VOLTUS::insert_comments]
      append fcommands $commands

      return $fcommands
   }



proc run_esd_analysis {} {

      global vars

      set comments ""
      set ucomments ""

 if {[info exists vars(set_esd_analyze_tcl)] && [file exists $vars(set_esd_analyze_tcl)]} {
	append commands "\n"
	append commands [FF::source_plug set_esd_analyze_tcl]
	} elseif {[info exists vars(esd_analyze)] && ($vars(esd_analyze) == "true")} {
	append commands "analyze_esd"	
	if {[info exists vars(esd_method)]} {
	append commands " -method $vars(esd_method) "
	}
	if {[info exists vars(esd_cell_list)]} {
	append commands " -esd_cell_list $vars(esd_cell_list)"
	}
	if {[info exists vars(bump_instance_list)]} {
	append commands " -bump_instance_list \{$vars(bump_instance_list)\}"
	}
	if {[info exists vars(pwr_net)]} {
	append commands " -pwr_net $vars(pwr_net)"
	}
	if {[info exists vars(gnd_net)]} {
	append commands " -gnd_net $vars(gnd_net)"
	}
	if {[info exists vars(esd_threshold)]} {
	append commands " -threshold $vars(esd_threshold)"
	}
	if {[info exists vars(esd_loop_threshold)]} {
	append commands " -loop_threshold $vars(esd_loop_threshold)"
	}
	if {[info exists vars(esd_output)]} {
	append commands " -output $vars(esd_output)"
	}
	if {[info exists vars(esd_output_dir)]} {
	append commands " -output_dir $vars(esd_output_dir)"
	}
     }
return $commands
}


proc run_signal_em {} {

      global vars

      set comments ""
      set ucomments ""
      append commands "#---------------------------------------------------------------------\n"
      append commands "# This script can be modified using the plug-in -> vars(signal_em_tcl)\n"
      append commands "#---------------------------------------------------------------------\n"
      ###############################################################################
      # Read activity file (optinal)
      ###############################################################################
	if {[info exists vars(read_activity_file_sem)] && ($vars(read_activity_file_sem) != "true")} {
	    append commands "read_activity_file -reset\n"
	    set urgs ""
	    if {[info exists vars(activity_file_sem,name)] && ($vars(activity_file_sem,name) != "")} {
	          append urgs " $vars(activity_file_sem,name)"
	    }
	    if {[info exists vars(activity_file_sem,block)] && ($vars(activity_file_sem,block) != "")} {
	          append urgs " -block $vars(activity_file_sem,block)"
	    }
	    if {[info exists vars(activity_file_sem,format)] && ($vars(activity_file_sem,format) != "")} {
	          append urgs " -format $vars(activity_file_sem,format)"
	    }
	    if {[info exists vars(activity_file_sem,scope)] && ($vars(activity_file_sem,scope) != "")} {
	          append urgs " -scope $vars(activity_file_sem,scope)"
	    }
	    if {[info exists vars(activity_file_sem,start)] && ($vars(activity_file_sem,start) != "")} {
	          append urgs " -start $vars(activity_file_sem,start)"
	    }
	    if {[info exists vars(activity_file_sem,end)] && ($vars(activity_file_sem,end) != "")} {
	          append urgs " -end $vars(activity_file_sem,end)"
	    }
	    if {[info exists vars(activity_file_sem,set_net_freq)] && ($vars(activity_file_sem,set_net_freq) != "")} {
	          append urgs " -set_net_freq $vars(activity_file_sem,set_net_freq)"
	    }
	    if {$urgs != ""} {
	          set command "read_activity_file $urgs\n"
	          append commands [FF::wrap_command activity,dynamic_power $command]
	    }
	  } else {
      	append commands "set_default_switching_activity -reset\n"
        set args ""
	if {[info exists vars(input_activity)]} {
	   append args " -input_activity $vars(input_activity)"
	   append comments "#   - vars(input_activity)\n"
	} else {
	   append ucomments "#   - vars(input_activity) \"factor\";# default:0.2\n"
	}
	if {[info exists vars(seq_activity)]} {
	   append args " -seq_activity $vars(seq_activity)"
	   append comments "#   - vars(seq_activity)\n"
	} else {
	   append ucomments "#   - vars(seq_activity) \"factor\";# Specifies activity on Outputs of seq logic\n"
	}
	if {[info exists vars(global_activity)]} {
	   append args " -global_activity $vars(global_activity)"
	   append comments "#   - vars(global_activity)\n"
	} else {
	   append ucomments "#   - vars(global_activity) \"factor\";# Specified activity on all unset nodes\n"
	}
	if {[info exists vars(clock_period)]} {
	   append args " -period $vars(clock_period)"
	   append comments "#   - vars(clock_period)\n"
	} else {
	   append ucomments "#   - vars(clock_period) \"clock_time_period\";#Specify dominent clock period\n"
	}
	if {$args != ""} {
	   set command "set_default_switching_activity $args\n"
	   append commands [FF::wrap_command activity,static_power $command]
	}
        if {[info exists vars(propagate_activity)] && ($vars(propagate_activity) == "true")} {
          append commands "propagate_activity -set_net_freq true\n"
        }
        }
	if {[info exists vars(set_delay_cal_mode)]} {
	append commands "\nset_delay_cal_mode -$vars(set_delay_cal_mode)"
	}
 if {[info exists vars(signal_em_tcl)] && [file exists $vars(signal_em_tcl)]} {
	append commands "\n"
	append commands [FF::source_plug signal_em_tcl]
	} elseif {
	[info exists vars(signal_em)] && ($vars(signal_em) == "true")} {
	set strs ""
	if {[info exists vars(signal_em_method)]} {
	   append strs " -method $vars(signal_em_method)"
	   append comments "#  -vars(signal_em_method)\n" 
	}
	if {[info exists vars(avgRecovery)]} {
	   append strs " -avgRecovery $vars(avgRecovery)"
	   append comments "# -vars(avgRecovery)\n"
	}
	if {[info exist vars(signal_em_report)]} {
	   append strs " -report $vars(signal_em_report)"
	   append comments "# -vars(signal_em_report)\n"
	}
	if {$strs != ""} {
        append commands "\n"
	set command "\nverify_AC_limit -detailed -useQRCTech -use_db_freq $strs\n"
	append commands [FF::wrap_command verify_AC_limit $command]
	}
 }
return $commands
 }



   proc run_dynamic_power {} {

      global vars

      set comments ""
      set ucomments ""

      ###############################################################################
      # Dynamic Power Analysis mode settings
      ###############################################################################
     if {[info exists vars(pre_dynamic_power_tcl)]} {
         if {[file exists $vars(pre_dynamic_power_tcl)]} { 
	 Puts "<FF> LOADING PRE-DYNAMIC POWER PLUG-IN : $vars(pre_dynamic_power_tcl)"
         append commands [FF::source_plug pre_dynamic_power_tcl]
         }
      } else {
      set command "set_power_analysis_mode -reset\n"
      append commands [FF::wrap_command mode,dynamic_power $command]
      set args ""
      append commands "#---------------------------------------------------------------------\n"
      append commands "# Any additional options for this script can be modified using the plug-in -> vars(pre_dynamic_power_tcl)\n"
      append commands "#---------------------------------------------------------------------\n"
      if {[info exists vars(dynamic_power,method)]} {
         append args " -method $vars(dynamic_power,method)"
         append comments "#   - vars(dynamic_power,method)\n"
         append ucomments "#   - vars(dynamic_power,method) \"dynamic_vectorless/dynamic_vectorbased\"\n"
      }
      if {[info exists vars(cl_views)]} {
            append args " -power_grid_library \{ $vars(cl_views) \}" 
            append comments "#   - vars(cl_views)\n"
         } else {
            append ucomments "#   - vars(cl_views);# Power-Grid Views must be specified\n"
         }
      if {[info exists vars(dynamic_power,analysis_view)]} {
         append args " -analysis_view $vars(dynamic_power,analysis_view)"
         append comments "#   - vars(dynamic_power,analysis_view)\n"
      } else {
         append ucomments "#   - vars(dynamic_power,analysis_view) \"mmmc_view\";# No default for MMMC\n"
      }
      if {[info exists vars(dynamic_power,corner)]} {
         append args " -corner $vars(dynamic_power,corner)"
         append comments "#   - vars(dynamic_power,corner)\n"
      } else {
         append ucomments "#   - vars(dynamic_power,corner) \"min/max\";# default:max for non-MMMC\n"
      }
      if {[info exists vars(dynamic_power,create_binary_db)]} {
         append args " -create_binary_db $vars(dynamic_power,create_binary_db)"
         append comments "#   - vars(dynamic_power,create_binary_db)\n"
      } else {
         append ucomments "#   - vars(dynamic_power,create_binary_db) \"true/false\";# default:false\n"
      }
      if {[info exists vars(dynamic_power,transition_time_method)]} {
         append args " -transition_time_method $vars(dynamic_power,transition_time_method)"
         append comments "#   - vars(dynamic_power,transition_time_method)\n"
      } else {
         append ucomments "#   - vars(dynamic_power,transition_time_method) \"min/avg/max\";# default:max\n"
      }
      if {[info exists vars(dynamic_power,disable_static)]} {
         append args " -disable_static $vars(dynamic_power,disable_static)"
         append comments "#   - vars(dynamic_power,disable_static)\n"
      } else {
         append ucomments "#   - vars(dynamic_power,disable_static) \"true/false\";# default:true\n"
      }
      if {[info exists vars(dynamic_power,write_static_currents)]} {
         append args " -write_static_currents $vars(dynamic_power,write_static_currents)"
         append comments "#   - vars(dynamic_power,write_static_currents)\n"
      } else {
         append ucomments "#   - vars(dynamic_power,write_static_currents) \"true/false\";# default:false\n"
      }
      if {$args != ""} {
         set command "set_power_analysis_mode $args\n"
         append commands [FF::wrap_command mode,dynamic_power $command]
      }
	
      ###############################################################################
      # Simulation period set for dynamic (optional)
      ###############################################################################
      if {[info exists vars(dynamic_power_sim)] && ($vars(dynamic_power_sim) == "true")} {
	append commands "set_dynamic_power_simulation -reset\n"
	set sim ""
	if {[info exists vars(dynamic_power,period)] && ($vars(dynamic_power,period)) != ""} {
	append sim " -period $vars(dynamic_power,period)"
	}
	if {[info exists vars(dynamic_power,resolution)] && ($vars(dynamic_power,resolution)) != ""} {
	append sim " -resolution $vars(dynamic_power,resolution)"
	}
      if {$sim != ""} {
	set command "set_dynamic_power_simulation $sim\n"
        append commands [FF::wrap_command simulation,dynamic_power $command]
	}
      }	
 
      ###############################################################################
      # Read activity file (optinal)
      ###############################################################################
      if {[info exists vars(read_activity_file)] && ($vars(read_activity_file) != "true")} {
	  append commands "read_activity_file -reset\n"
	  set urgs ""
	  if {[info exists vars(activity_file,name)] && ($vars(activity_file,name) != "")} {
	  	append urgs " $vars(activity_file,name)"
	  }
	  if {[info exists vars(activity_file,block)] && ($vars(activity_file,block) != "")} {
	  	append urgs " -block $vars(activity_file,block)"
	  }
	  if {[info exists vars(activity_file,format)] && ($vars(activity_file,format) != "")} {
	  	append urgs " -format $vars(activity_file,format)"
	  }
	  if {[info exists vars(activity_file,scope)] && ($vars(activity_file,scope) != "")} {
	  	append urgs " -scope $vars(activity_file,scope)"
	  }
	  if {[info exists vars(activity_file,start)] && ($vars(activity_file,start) != "")} {
	  	append urgs " -start $vars(activity_file,start)"
	  }
	  if {[info exists vars(activity_file,end)] && ($vars(activity_file,end) != "")} {
	  	append urgs " -end $vars(activity_file,end)"
	  }
	  if {[info exists vars(activity_file,set_net_freq)] && ($vars(activity_file,set_net_freq) != "")} {
	  	append urgs " -set_net_freq $vars(activity_file,set_net_freq)"
	  }
	  if {$urgs != ""} {
	 	set command "read_activity_file $urgs\n"
		append commands [FF::wrap_command activity,dynamic_power $command]
	  }
	}
      ###############################################################################
      # Setting Default Global switching activity
      ###############################################################################
      set command "set_default_switching_activity -reset\n"
      append commands [FF::wrap_command activity,dynamic_power $command]
      set args ""
      append commands "#---------------------------------------------------------------------\n"
      append commands "# This script can be modified using the plug-in -> vars(pre_dynamic_power_tcl)\n"
      append commands "#---------------------------------------------------------------------\n"
      if {[info exists vars(input_activity)]} {
         append args " -input_activity $vars(input_activity)"
         append comments "#   - vars(input_activity)\n"
      } else {
         append ucomments "#   - vars(input_activity) \"factor\";# default:0.2\n"
      } 
      if {[info exists vars(seq_activity)]} {
         append args " -seq_activity $vars(seq_activity)"
         append comments "#   - vars(seq_activity)\n"
      } else {
         append ucomments "#   - vars(seq_activity) \"factor\";# Specifies activity on Outputs of seq logic\n"
      } 
      if {[info exists vars(global_activity)]} {
         append args " -global_activity $vars(global_activity)"
         append comments "#   - vars(global_activity)\n"
      } else {
         append ucomments "#   - vars(global_activity) \"factor\";# Specified activity on all unset nodes\n"
      } 
      if {[info exists vars(clock_period)]} {
         append args " -period $vars(clock_period)"
         append comments "#   - vars(clock_period)\n"
      } else {
         append ucomments "#   - vars(clock_period) \"clock_time_period\";#Specify dominent clock period\n"
      } 
      if {$args != ""} {
         set command "set_default_switching_activity $args\n"
         append commands [FF::wrap_command activity,dynamic_power $command]
      }
      if {[info exists vars(propagate_activity)] && ($vars(propagate_activity) == "true")} {
	append commands "propagate_activity\n"
      }
      
      ###############################################################################
      # Power meter include file for Dynamic Power Analysis
      ###############################################################################
      if {[info exists vars(dynamic_power_inc_file)] &&
          [file exists $vars(dynamic_power_inc_file)]} {
         set command "set_power_include_file $vars(dynamic_power_inc_file)\n"
         append commands [FF::wrap_command power_inc,dynamic_power $command]
      }
      
      ###############################################################################
      # Setting the directory PATH to write the power reports & current files
      ###############################################################################
      
      set command "set_power_output_dir -reset\n"
      append commands [FF::wrap_command power_dir,dynamic_power $command]
      if {[info exists vars(dynamic_power_reports)]} {
      set command "set_power_output_dir $vars(dynamic_power_reports)\n"
      } else {
      set vars(dynamic_power_reports) $vars(rpt_dir)/dynamic_power
      set command "set_power_output_dir $vars(dynamic_power_reports)\n"
      }
      append commands [FF::wrap_command power_dir,dynamic_power $command]
      
      ###############################################################################
      # write the tcf file
      ###############################################################################
      #Puts "<FF> WRITING TCF FILE FOR DYNAMIC POWER CALCULATION"
      #if {[info exists vars(report_power,outfile)]} {
      #   set command "write_tcf $vars(report_power,outfile).tcf\n"
      #} else {
      #   set command "write_tcf $vars(rpt_dir)/dynamic_power/design.tcf\n"
      #}
      #append commands [FF::wrap_command tcf,dynamic_power $command]
      
      ###############################################################################
      # Calculate and report the dynamic power
      ###############################################################################
      }
#end for pre-dynamic plug in 
      set args ""
      append commands "#---------------------------------------------------------------------\n"
      append commands "# To report dynamic power with any other option, use plug-in -> vars(post_dynamic_power_tcl)\n"
      append commands "#---------------------------------------------------------------------\n"
     if {[info exists vars(post_dynamic_power_tcl)]} {
         if {[file exists $vars(post_dynamic_power_tcl)]} {
           Puts "<FF> LOADING POST-DYNAMIC-POWER PLUG-IN $vars(post_dynamic_power_tcl)"
           append commands [FF::source_plug post_dynamic_power_tcl]
         }
      } else {
      set command "report_power\n"
      append commands [FF::wrap_command report_power,dynamic_power $command]
      }

      ###############################################################################
      # create the file at "make" dir to specify the status of the run
      ###############################################################################

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

      set fcommands [FF_VOLTUS::insert_comments]
      append fcommands $commands

      return $fcommands
   }
     
   proc run_dynamic_rail {} {

      global vars
     
      set comments ""
      set ucomments ""

     ###############################################################################
     # Dynamic Rail Analysis mode settings
     ###############################################################################
     set args ""
     append commands "#---------------------------------------------------------------------\n"
     append commands "# This script can be modified using the plug-in -> vars(set_dynamic_rail_mode_tcl)\n"
     append commands "#---------------------------------------------------------------------\n"
     if {[info exists vars(set_dynamic_rail_mode_tcl)]} {
        if {[file exists $vars(set_dynamic_rail_mode_tcl)]} {
           #Puts "<FF> LOADING USER DEFINED PLUG-IN : $vars(set_dynamic_rail_mode_tcl)"
           append commands [FF::source_plug set_dynamic_rail_mode_tcl]
        }
     } else {
        #Puts "<FF> SETTING DYNAMIC RAIL ANALYSIS MODE :"
        append args " -method dynamic"
        if {[info exists vars(dynamic_rail,accuracy)]} {
           append args " -accuracy $vars(dynamic_rail,accuracy)"
           append comments "#   - vars(dynamic_rail,accuracy)\n"
           append ucomments "#   - vars(dynamic_rail,accuracy) \"xh/hd\";# default:hd\n"
        }
        if {[info exists vars(dynamic_rail,analysis_view)]} {
           append args " -analysis_view $vars(dynamic_rail,analysis_view)"
           append comments "#   - vars(dynamic_rail,analysis_view)\n"
        } else {
           append ucomments "#   - vars(dynamic_rail,analysis_view) \"mmmc_view\"\n"
        }
        if {[info exists vars(cl_views)]} {
           append args " -power_grid_library \{ $vars(cl_views) \}" 
           append comments "#   - vars(cl_views)\n"
        } else {
           append ucomments "#   - vars(cl_views);# Power-Grid Views must be specified\n"
        }
	if {[info exists vars(rdl_def)] && ([llength $vars(rdl_def)] >= 1)} {
		append args " -rdl_def $vars(rdl_def)"
         }
        if {[info exists vars(rdl_placement)] && ($vars(rdl_placement) != "")} {
		append args " -rdl_placement \{$vars(rdl_placement)\}"
        }
       	if {[info exists vars(rdl_orientation)] && ($vars(rdl_orientation) != "")} {
		append args " -rdl_orientation $vars(rdl_orientation)"
	}
        if {[info exists vars(rail_analysis_temp_dir)]} {
           append args " -temp_directory_name $vars(rail_analysis_temp_dir)"
           append comments "#   - vars(rail_analysis_temp_dir)\n"
        } else {
           append ucomments "#   - vars(rail_analysis_temp_dir) \"specify_tmp_dir_path\";# default:./tmp\n"
        }
        if {[info exists vars(dynamic_rail,temperature)]} {
           append args " -temperature $vars(dynamic_rail,temperature)"
           append comments "#   - vars(dynamic_rail,temperature)\n"
        } else {
           append ucomments "#   - vars(dynamic_rail,temperature) \"temperature\";# default:25\n"
        }
        if {[info exists vars(dynamic_rail,dist_solver_processing)]} {
           append args " -enable_distributed_processing_in_solver $vars(dynamic_rail,dist_solver_processing)"
           append comments "#   - vars(dynamic_rail,dist_solver_processing)\n"
        } else {
           append ucomments "#   - vars(dynamic_rail,dist_solver_processing) \"true/false\";# default:false\n"
        }
        if {[info exists vars(dynamic_rail,powering_up_nets)]} {
           append args " -powering_up_rails $vars(dynamic_rail,powering_up_nets)"
           append comments "#   - vars(dynamic_rail,powering_up_nets)\n"
        } else {
           append ucomments "#   - vars(dynamic_rail,powering_up_nets) \"switchable_PG_nets\";# For steady state & transient Rail Analysis\n"
        }
        if {[info exists vars(dynamic_rail,gen_power_switch_eco)]} {
           append args " -power_switch_eco $vars(dynamic_rail,gen_power_switch_eco)"
           append comments "#   - vars(dynamic_rail,gen_power_switch_eco)\n"
        } else {
           append ucomments "#   - vars(dynamic_rail,gen_power_switch_eco) \"true/false\";# default:false\n"
        }
        if {[info exists vars(dynamic_rail,gen_decap_eco)]} {
           append args " -generate_decap_eco $vars(dynamic_rail,gen_decap_eco)"
           append comments "#   - vars(dynamic_rail,gen_decap_eco)\n"
        } else {
           append ucomments "#   - vars(dynamic_rail,gen_decap_eco) \"true/false\";# default:false\n"
        }
        if {[info exists vars(dynamic_rail,decap_opt_method)]} {
           append args " -decap_opt_method $vars(dynamic_rail,decap_opt_method)"
           append comments "#   - vars(dynamic_rail,decap_opt_method)\n"
        } else {
           append ucomments "#   - vars(dynamic_rail,decap_opt_method) \"area/feasibility/timing/removal/feasibility_removal\";# default:feasibility\n"
        }
        if {[info exists vars(dynamic_rail,decap_removal_method)]} {
           append args " -decap_removal_method $vars(dynamic_rail,decap_removal_method)"
           append comments "#   - vars(dynamic_rail,decap_removal_method)\n"
        } else {
           append ucomments "#   - vars(dynamic_rail,decap_removal_method) \"conservative/aggressive\"\n"
        }
        if {[info exists vars(dynamic_rail,save_voltage_waveforms)]} {
           append args " -save_voltage_waveforms $vars(dynamic_rail,save_voltage_waveforms)"
           append comments "#   - vars(dynamic_rail,save_voltage_waveforms)\n"
        } else {
           append ucomments "#   - vars(dynamic_rail,save_voltage_waveforms) \"true/false\";# default:false\n"
        }
        if {[info exists vars(dynamic_rail,gen_bb_voltage_file)]} {
           append args " -generate_block_boundary_voltage_file $vars(dynamic_rail,gen_bb_voltage_file)"
           append comments "#   - vars(dynamic_rail,gen_bb_voltage_file)\n"
        } else {
           append ucomments "#   - vars(dynamic_rail,gen_bb_voltage_file) \"<list of instace names>\"\n"
        }
        if {[info exists vars(dynamic_rail,save_current_files)]} {
           append args " -save_current_files $vars(dynamic_rail,save_current_files)"
           append comments "#   - vars(dynamic_rail,save_current_files)\n"
        } else {
           append ucomments "#   - vars(dynamic_rail,save_current_files) \"true/false\";# default:false\n"
        }
        if {[info exists vars(dynamic_rail,ignore_shorts)]} {
           append args " -ignore_shorts $vars(dynamic_rail,ignore_shorts)"
           append comments "#   - vars(dynamic_rail,ignore_shorts)\n"
        } else {
           append ucomments "#   - vars(dynamic_rail,ignore_shorts) \"true/false\";# default:false\n"
        }
        if {[info exists vars(dynamic_rail,dis_analysis_types)]} {
           append args " -disable_analysis_types $vars(dynamic_rail,dis_analysis_types)"
           append comments "#   - vars(dynamic_rail,dis_analysis_types)\n"
        } else {
           append ucomments "#   - vars(dynamic_rail,dis_analysis_types) \"<list analysis types to be disabled>\"\n"
        }
        if {[info exists vars(dynamic_rail,decap_eco_file)]} {
           append args " -decap_eco_file $vars(dynamic_rail,decap_eco_file)"
           append comments "#   - vars(dynamic_rail,decap_eco_file)\n"
        } else {
           append ucomments "#   - vars(dynamic_rail,decap_eco_file) \"<decap_eco_file>\"\n"
        }
        if {[info exists vars(dynamic_rail,cell_ignore_file)]} {
           append args " -cell_ignore_file $vars(dynamic_rail,cell_ignore_file)"
           append comments "#   - vars(dynamic_rail,cell_ignore_file)\n"
        } else {
           append ucomments "#   - vars(dynamic_rail,cell_ignore_file) \"<cell_ignore_file>\"\n"
        }
        if {[info exists vars(dynamic_rail,fast_views_list)]} {
           append args " -use_fast_view_list $vars(dynamic_rail,fast_views_list)"
           append comments "#   - vars(dynamic_rail,fast_views_list)\n"
        } else {
           append ucomments "#   - vars(dynamic_rail,fast_views_list) \"<fast_views_cell_file>\"\n"
        }
        if {[info exists vars(dynamic_rail,fast_accurate_views_list)]} {
           append args " -use_fast_accurate_view_list $vars(dynamic_rail,fast_accurate_views_list)"
           append comments "#   - vars(dynamic_rail,fast_accurate_views_list)\n"
        } else {
           append ucomments "#   - vars(dynamic_rail,fast_accurate_views_list) \"<list_of_fast_accurate_pgv_cells>\"\n"
        }
        if {[info exists vars(dynamic_rail,accurate_views_list)]} {
           append args " -use_accurate_view_list $vars(dynamic_rail,accurate_views_list)"
           append comments "#   - vars(dynamic_rail,accurate_views_list)\n"
        } else {
           append ucomments "#   - vars(dynamic_rail,accurate_views_list) \"<list_of_accurate_pgv_cells>\"\n"
        }
        if {[info exists vars(dynamic_rail,ext_inc_file)]} {
           append args " -extractor_include $vars(dynamic_rail,ext_inc_file)"
           append comments "#   - vars(dynamic_rail,ext_inc_file)\n"
        } else {
           append ucomments "#   - vars(dynamic_rail,ext_inc_file) \"<extractor_include_file>\"\n"
        }
     }
     if {$args != ""} {
        set command "set_rail_analysis_mode $args\n"
        append commands [FF::wrap_command mode,dynamic_rail $command]
     }
     
     ###############################################################################
     # Setting Power/Ground Nets Bias Vol, Threshold Vol and the Tolerance per-centage
     ###############################################################################
     if {[info exists vars(power_domains)]} {
        foreach vars(pd) $vars(power_domains) {
           if {[info exists vars($vars(pd),pwr_nets)]} {
              foreach net $vars($vars(pd),pwr_nets) {
                 if {[info exists vars($net,voltage)]} {
                    set threshold_volt [expr $vars(threshold_percent) * $vars($net,voltage) / 100.00]
                    if {![info exists vars($net,threshold)]} {
                       set vars($net,threshold) [expr $vars($net,voltage) - $threshold_volt]
                    }
                    if {![info exists vars($net,tolerance)]} {
                       set vars($net,tolerance) [expr $vars(supply_tolerance_percent) / 100.00]
                    }
                 }
              }
           }
           if {[info exists vars($vars(pd),gnd_nets)]} {
              foreach net $vars($vars(pd),gnd_nets) {
                 if {![info exists vars($net,threshold)]} {
                    set vars($net,threshold) $threshold_volt
                 }
                 if {![info exists vars($net,tolerance)]} {
                    set vars($net,tolerance) [expr $vars(supply_tolerance_percent) / 100.00]
                 }
              }
           }
        }
     }
     
     ################################################################################
     # Uniquefy all the PG nets of the design for analysis
     ################################################################################
     set global_nets [FF_VOLTUS::get_global_nets]
     
     append commands "#---------------------------------------------------------------------\n"
     append commands "# This script can be modified using the plug-in -> vars(set_dynamic_rail_pg_nets_tcl)\n"
     append commands "#---------------------------------------------------------------------\n"
     if {[info exists vars(set_dynamic_rail_pg_nets_tcl)] &&
         [file exists $vars(set_dynamic_rail_pg_nets_tcl)]} {
        #Puts "<FF> LOADING USER DEFINED PLUG-IN : $vars(set_dynamic_rail_pg_nets_tcl)"
        append commands [FF::source_plug set_dynamic_rail_pg_nets_tcl]
     } else {
        if {[info exists global_nets]} {
           #Puts "<FF> SETTING PG NET VOLTAGES FOR DYNAMIC-RAIL ANALYSIS :"
           foreach net $global_nets {
              set args ""
              if {[info exists vars($net,voltage)] &&
                 ($vars($net,voltage) != 0)} {
                 append args " -net $net -voltage $vars($net,voltage)"
              } else {
                 append args " -net $net -voltage 0.00"
              }
              if {[info exists vars($net,threshold)]} {
                 append args " -threshold $vars($net,threshold)"
              }
              if {[info exists vars($net,tolerance)]} {
                 append args " -tolerance $vars($net,tolerance) -force"
              } else {
                 append args " -force"
              }
              if {$args != ""} {
                 set command "set_pg_nets $args\n"
                 append commands [FF::wrap_command pg_nets,dynamic_rail $command]
              }
           }
        }
     }
     
     ###############################################################################
     # Setting PG nets instance power/current files
     ###############################################################################
     set command "set_power_data -reset\n"
     append commands [FF::wrap_command power_data,dynamic_rail $command]
     append commands "#---------------------------------------------------------------------\n"
     append commands "# This script can be modified using the plug-in -> vars(set_dynamic_rail_power_data_tcl)\n"
     append commands "#---------------------------------------------------------------------\n"
     if {[info exists vars(set_dynamic_rail_power_data_tcl)] &&
         [file exists $vars(set_dynamic_rail_power_data_tcl)]} {
        #Puts "<FF> LOADING USER DEFINED PLUG-IN : $vars(set_dynamic_rail_power_data_tcl)"
        append commands [FF::source_plug set_dynamic_rail_power_data_tcl]
     } else {
        #Puts "<FF> SETTING PG NETS POWER/CURRENT FILES FOR DYNAMIC-RAIL ANALYSIS :"
       # set vars(dynamic_power_reports) $vars(rpt_dir)/dynamic_power
        if {[info exists global_nets]} {
           foreach net $global_nets {
              set args ""
              if {[info exists vars(dynamic_rail,$net,scale)]} {
                 append args " -scale $vars(dynamic_rail,$net,scale)"
              } else {
                 append args " -scale 1"
              }
              if {[info exists vars(dynamic_rail,$net,pti_file)] &&
                  [file exists $vars(dynamic_rail,$net,pti_file)]} {
                 append args " -format current $vars(dynamic_rail,$net,pti_file)"
              } else {
                 append args " -format current $vars(dynamic_power_reports)/dynamic_$net.ptiavg"
              }
              if {$args != ""} {
                 set command "set_power_data $args\n"
                 append commands [FF::wrap_command power_data,dynamic_rail $command]
              }
           }
        }
     }
     
     ###############################################################################
     # Setting PG nets pad location files
     ###############################################################################
     append commands "#---------------------------------------------------------------------\n"
     append commands "# This script can be modified using the plug-in -> vars(set_dynamic_rail_pad_location_tcl)\n"
     append commands "#---------------------------------------------------------------------\n"
     if {[info exists vars(set_dynamic_rail_pad_location_tcl)] &&
         [file exists $vars(set_dynamic_rail_pad_location_tcl)]} {
        #Puts "<FF> LOADING USER DEFINED PLUG-IN : $vars(set_dynamic_rail_pad_location_tcl)"
        append commands [FF::source_plug set_dynamic_rail_pad_location_tcl]
     } else {
        #Puts "<FF> SETTING PG NETS PAD LOCATION FILES FOR DYNAMIC-RAIL ANALYSIS :"
        set command "set_power_pads -reset\n"
        #eval $command
        append commands [FF::wrap_command power_pad,dynamic_rail $command]
        if {[info exists global_nets]} {
	   foreach net $global_nets {
              if {[info exists vars($net,format)]} {
                set args " -net $net" 
		append args " -format $vars($net,format)"
                 if {($vars($net,format) != "defpin") &&
                     [info exists vars($net,pad_file)] &&
                     [file exists $vars($net,pad_file)]} {
                    append args " -file $vars($net,pad_file)"
                 }
		set command "set_power_pads $args\n"
                append commands [FF::wrap_command power_pad,dynamic_rail $command]
              } else {
                 append ucomments "#   -format vars($net,format) \"xy/padcell/defpin/boundary\"\n"
              }
           }
        }
     }
     
     ###############################################################################
     # Setting Power Domain for Domain based Rail Analysis
     ###############################################################################
     append commands "#---------------------------------------------------------------------\n"
     append commands "# This script can be modified using the plug-in -> vars(set_dynamic_rail_analysis_domain_tcl)\n"
     append commands "#---------------------------------------------------------------------\n"
     if {[info exists vars(set_dynamic_rail_analysis_domain_tcl)] &&
         [file exists $vars(set_dynamic_rail_analysis_domain_tcl)]} {
        #Puts "<FF> LOADING USER DEFINED PLUG-IN : $vars(set_dynamic_rail_analysis_domain_tcl)"
        append commands [FF::source_plug set_dynamic_rail_analysis_domain_tcl]
     } else {
        if {[info exists vars(dynamic_rail,analyze_type)] &&
            ($vars(dynamic_rail,analyze_type) == "domain")} {
           #Puts "<FF> SETTING POWER DOMAINS FOR DOMAIN BASED DYNAMIC-RAIL ANALYSIS :"
           if {[info exists vars(dynamic_rail,analyze_domains)]} {
              foreach vars(pd) $vars(dynamic_rail,analyze_domains) {
                 set args " -name $vars(pd)"
                 if {[info exists vars($vars(pd),pwr_nets)]} {
                     append args " -pwrnets \"$vars($vars(pd),pwr_nets)\""
                     append comments "#   - vars($vars(pd),pwr_nets)\n"
                 } else {
                     append ucomments "#   - vars($vars(pd),pwr_nets)\n"
                 }
                 if {[info exists vars($vars(pd),gnd_nets)]} {
                     append args " -gndnets \"$vars($vars(pd),gnd_nets)\""
                     append comments "#   - vars($vars(pd),gnd_nets)\n"
                  } else {
                     append ucomments "#   - vars($vars(pd),gnd_nets)\n"
                 }
                 set command "set_rail_analysis_domain $args\n"
                 append commands [FF::wrap_command analysis_domain,dynamic_rail $command]
              }
           }
        }
     }
     
     ###############################################################################
     # Load pre-dynamic-rail-analysis plug-in
     ###############################################################################
     if {[info exists vars(pre_dynamic_rail_tcl)]} {
        if {[file exists $vars(pre_dynamic_rail_tcl)]} {
           #Puts "<FF> LOADING PRE-DYNAMIC-RAIL-ANALYSIS PLUG-IN : $vars(pre_dynamic_rail_tcl)"
           append commands [FF::source_plug pre_dynamic_rail_tcl]
        }
     }
     
     ###############################################################################
     # Setting up vstorm2 advanced rail options
     ###############################################################################
     if {[info exists vars(dynamic_rail,vstorm2_begin_file)] ||
         [info exists vars(dynamic_rail,vstorm2_end_file)]} {
        #Puts "<FF> SETTING VSTORM2 RAIL OPTIONS INC FILE FOR DYNAMIC-RAIL ANALYSIS :"
        set command "set_advanced_rail_options -reset\n"
        append commands [FF::wrap_command vstorm_inc,dynamic_rail $command]
        set command "set_advanced_rail_options"
        if {[info exists vars(dynamic_rail,vstorm2_begin_file)] && [file exists $vars(dynamic_rail,vstorm2_begin_file)]} {
           append command " -vstorm2_include_file_begin $vars(dynamic_rail,vstorm2_begin_file)\n"
        }
        if {[info exists vars(dynamic_rail,vstorm2_end_file)] && [file exists $vars(dynamic_rail,vstorm2_end_file)]} {
           append command " -vstorm2_include_file_end $vars(dynamic_rail,vstorm2_end_file)\n"
        }
        if {$command != "set_advanced_rail_options"} {
           append commands [FF::wrap_command vstorm_inc,dynamic_rail $command]
        }
     }
     
     ###############################################################################
     # Analyze Dynamic Rail Analysis on the design
     ###############################################################################
     set vars(dynamic_rail_reports) $vars(rpt_dir)/dynamic_rail
     if {[info exists vars(dynamic_rail,analyze_type)] &&
         ($vars(dynamic_rail,analyze_type) == "net")} {
        if {[info exists global_nets]} {
           foreach net $global_nets {
              #Puts "ANALYZING DYNAMIC-RAIL ANALYSIS ON $net :"
              set command "analyze_rail -type net -output $vars(dynamic_rail_reports) $net\n"
              append commands [FF::wrap_command analyze,dynamic_rail $command]
#              exec /bin/touch make/dynamic_rail_on_$net
           }
        }
     } else {
        if {[info exists vars(dynamic_rail,analyze_domains)]} {
           foreach vars(pd) $vars(dynamic_rail,analyze_domains) {
              #Puts "ANALYZING DYNAMIC-RAIL ANALYSIS ON $vars(pd) :"
              set command "analyze_rail -type domain -output $vars(dynamic_rail_reports) $vars(pd)\n"
              append commands [FF::wrap_command analyze,dynamic_rail $command]
#              exec /bin/touch make/dynamic_rail_on_$vars(pd)
           }
        }
     }
     
     ###############################################################################
     # Load post-dynamic-rail-analysis plug-in
     ###############################################################################
     if {[info exists vars(post_dynamic_rail_tcl)]} {
        if {[file exists $vars(post_dynamic_rail_tcl)]} {
          #Puts "<FF> LOADING POST-DYNAMIC-RAIL-ANALYSIS PLUG-IN : $vars(post_dynamic_rail_tcl)"
          append commands [FF::source_plug post_dynamic_rail_tcl]
        }
     }

#      append commands "exec /bin/touch make/dynamic_rail\n"

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

      set fcommands [FF_VOLTUS::insert_comments]
      append fcommands $commands

      return $fcommands

   }

   proc run_static_power {} {

      global vars

      set comments ""
      set ucomments ""

      ###############################################################################
      # Static Power Analysis mode settings
      ###############################################################################
      set command "set_power_analysis_mode -reset\n"
      append commands [FF::wrap_command mode,static_power $command]
      set args ""
      append commands "#---------------------------------------------------------------------\n"
      append commands "# Any additional options for this script can be modified using the plug-in -> vars(pre_static_power_tcl)\n"
      append commands "#---------------------------------------------------------------------\n"
      if {[info exists vars(static_power,method)]} {
         append args " -method $vars(static_power,method)"
         append comments "#   - vars(static_power,method)\n"
      }
      if {[info exists vars(static_power,analysis_view)]} {
         append args " -analysis_view $vars(static_power,analysis_view)"
         append comments "#   - vars(static_power,analysis_view)\n"
      } else {
         append ucomments "#   - vars(static_power,analysis_view) \"mmmc_view\";# No default for MMMC\n"
      }
      if {[info exists vars(static_power,corner)]} {
         append args " -corner $vars(static_power,corner)"
         append comments "#   - vars(static_power,corner)\n"
      } else {
         append ucomments "#   - vars(static_power,corner) \"min/max\";# default:max for non-MMMC\n"
      }
      if {[info exists vars(static_power,create_binary_db)]} {
         append args " -create_binary_db $vars(static_power,create_binary_db)"
         append comments "#   - vars(static_power,create_binary_db)\n"
      } else {
         append ucomments "#   - vars(static_power,create_binary_db) \"true/false\";# default:false\n"
      }
      if {[info exists vars(static_power,transition_time_method)]} {
         append args " -transition_time_method $vars(static_power,transition_time_method)"
         append comments "#   - vars(static_power,transition_time_method)\n"
      } else {
         append ucomments "#   - vars(static_power,transition_time_method) \"min/avg/max\";# default:max\n"
      }
      if {[info exists vars(static_power,write_static_currents)]} {
         append args " -write_static_currents $vars(static_power,write_static_currents)"
         append comments "#   - vars(static_power,write_static_currents)\n"
      } else {
         append ucomments "#   - vars(static_power,write_static_currents) \"true/false\";# default:false\n"
      }
      if {$args != ""} {
         set command "set_power_analysis_mode $args\n"
         append commands [FF::wrap_command mode,static_power $command]
      }
      
      ###############################################################################
      # Setting Default Global switching activity
      ###############################################################################
      ###set_global_activity
      #Puts "<FF> SETTING DEFAULT GLOBAL SWITCHING ACTIVITY : "
      set command "set_default_switching_activity -reset\n"
      append commands [FF::wrap_command activity,static_power $command]
      set args ""
      append commands "#---------------------------------------------------------------------\n"
      append commands "# This script can be modified using the plug-in -> vars(pre_static_power_tcl)\n"
      append commands "#---------------------------------------------------------------------\n"
      if {[info exists vars(input_activity)]} {
         append args " -input_activity $vars(input_activity)"
         append comments "#   - vars(input_activity)\n"
      } else {
         append ucomments "#   - vars(input_activity) \"factor\";# default:0.2\n"
      } 
      if {[info exists vars(seq_activity)]} {
         append args " -seq_activity $vars(seq_activity)"
         append comments "#   - vars(seq_activity)\n"
      } else {
         append ucomments "#   - vars(seq_activity) \"factor\";# Specifies activity on Outputs of seq logic\n"
      } 
      if {[info exists vars(global_activity)]} {
         append args " -global_activity $vars(global_activity)"
         append comments "#   - vars(global_activity)\n"
      } else {
         append ucomments "#   - vars(global_activity) \"factor\";# Specified activity on all unset nodes\n"
      } 
      if {[info exists vars(clock_period)]} {
         append args " -period $vars(clock_period)"
         append comments "#   - vars(clock_period)\n"
      } else {
         append ucomments "#   - vars(clock_period) \"clock_time_period\";#Specify dominent clock period\n"
      } 
      if {$args != ""} {
         set command "set_default_switching_activity $args\n"
         append commands [FF::wrap_command activity,static_power $command]
      }
      
      ###############################################################################
      # Load pre-static-power-analysis plug-in, if any
      ###############################################################################
      if {[info exists vars(pre_static_power_tcl)]} {
         if {[file exists $vars(pre_static_power_tcl)]} {
            #Puts "<FF> LOADING PRE-STATIC-POWER PLUG-IN $vars(pre_static_power_tcl)"
            #Puts "source $vars(pre_static_power_tcl)"
            append commands [FF::source_plug pre_static_power_tcl]
         }
      }
      
      ###############################################################################
      # Setting the directory PATH to write the power reports & current files
      ###############################################################################
      
      set command "set_power_output_dir -reset\n"
      append commands [FF::wrap_command power_dir,static_power $command]
      if {[info exists vars(static_power_reports)]} {
      set command "set_power_output_dir $vars(static_power_reports)\n"
      } else {
      set vars(static_power_reports) $vars(rpt_dir)/static_power
      set command "set_power_output_dir $vars(static_power_reports)\n"
      }
      append commands [FF::wrap_command power_dir,static_power $command]
      
      ###############################################################################
      # write the tcf file
      ###############################################################################
      #Puts "<FF> WRITING TCF FILE FOR STATIC POWER CALCULATION"
      #set command "write_tcf $vars(static_power_reports)/design.tcf\n"

      ###############################################################################
      # Calculate and report the static power
      ###############################################################################
      set args ""
      append commands "#---------------------------------------------------------------------\n"
      append commands "# To report static power with any other option, use plug-in -> vars(report_static_power_tcl)\n"
      append commands "#---------------------------------------------------------------------\n"
      if {[info exists vars(report_static_power_tcl)]} {
         if {[file exists $vars(report_static_power_tcl)]} {
            #Puts "<FF> REPORT STATIC-POWER THROUGH PLUG-IN $vars(report_static_power_tcl)"
            #Puts "source $vars(report_static_power_tcl)"
            append commands [FF::source_plug report_static_power_tcl]
         }
      } else {
         append args " -cell_type all -outfile static_power.report"
         append comments "#   -cell_type all -outfile static_power.report\n"
      }
      if {$args != ""} {
         set command "report_power $args\n"
         append commands [FF::wrap_command report_power,static_power $command]
      }

      
      ###############################################################################
      # Load post-static-power-analysis plug-in, if any
      ###############################################################################
#      if {[info exists vars(post_static_power_tcl)]} {
#         if {[file exists $vars(post_static_power_tcl)]} {
            #Puts "<FF> LOADING POST-STATIC-POWER PLUG-IN $vars(post_static_power_tcl)"
            #Puts "source $vars(post_static_power_tcl)"
            append commands [FF::source_plug post_static_power_tcl]
#         }
#      }
      
      ###############################################################################
      # create the file at "make" dir to specify the status of the run
      ###############################################################################
      
#      append commands "exec /bin/touch make/static_power\n"

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

      set fcommands [FF_VOLTUS::insert_comments]
      append fcommands $commands

      return $fcommands

   }

   proc run_esd_rail {} {


      global vars

      set comments ""
      set ucomments ""
      ###############################################################################
      # Static Rail Analysis mode settings for ESD analysis
      ###############################################################################
         if {[info exists vars(set_static_rail_mode_tcl)] && [file exists $vars(set_static_rail_mode_tcl)]} {
            append commands [FF::source_plug set_static_rail_mode_tcl]
         } elseif {[info exists vars(static_rail)] && ($vars(static_rail) == "true")} {
         	append commands " set_rail_analysis_mode -method static"
		if {[info exists vars(static_rail,accuracy)]} {
            	append commands " -accuracy $vars(static_rail,accuracy)"
         	}
		if {[info exists vars(rdl_def)] && ([llength $vars(rdl_def)] >= 1)} {
		append commands " -rdl_def $vars(rdl_def)"
		}
		if {[info exists vars(rdl_placement)] && ($vars(rdl_placement) != "")} {
		append commands " -rdl_placement \{$vars(rdl_placement)\}"
		}
		if {[info exists vars(rdl_orientation)] && ($vars(rdl_orientation) != "")} {
		append commands " -rdl_orientation $vars(rdl_orientation)"
		}
		if {[info exists vars(cl_views)]} {
           	append commands " -power_grid_library $vars(cl_views)"
         	}
	}
}

   proc run_static_rail {} {

      global vars

      set comments ""
      set ucomments ""

      ###############################################################################
      # Static Rail Analysis mode settings
      ###############################################################################
      set args ""
      append commands "#---------------------------------------------------------------------\n"
      append commands "# This script can be modified using the plug-in -> vars(set_static_rail_mode_tcl)\n"
      append commands "#---------------------------------------------------------------------\n"
      if {[info exists vars(set_static_rail_mode_tcl)]} {
         if {[file exists $vars(set_static_rail_mode_tcl)]} {
            #Puts "<FF> LOADING USER DEFINED PLUG-IN : $vars(set_static_rail_mode_tcl)"
            #Puts "source $vars(set_static_rail_mode_tcl)"
            append commands [FF::source_plug set_static_rail_mode_tcl]
         }
      } else {
         #Puts "<FF> SETTING STATIC RAIL ANALYSIS MODE :"
         append args " -method static"
         if {[info exists vars(static_rail,accuracy)]} {
            append args " -accuracy $vars(static_rail,accuracy)"
            append comments "#   - vars(static_rail,accuracy)\n"
            append ucomments "#   - vars(static_rail,accuracy) \"ad/hd\";# default:hd\n"
         }

         if {[info exists vars(static_rail,analysis_view)]} {
            append args " -analysis_view $vars(static_rail,analysis_view)"
            append comments "#   - vars(static_rail,analysis_view)\n"
         } else {
            append ucomments "#   - vars(static_rail,analysis_view) \"mmmc_view\"\n"
         }
         if {[info exists vars(cl_views)]} {
            append args " -power_grid_library \{ $vars(cl_views) \}" 
            append comments "#   - vars(cl_views)\n"
         } else {
            append ucomments "#   - vars(cl_views);# Power-Grid Views must be specified\n"
         }	
	if {[info exists vars(rdl_def)] && ([llength $vars(rdl_def)] >= 1)} {
		append args " -rdl_def $vars(rdl_def)"
         }
        if {[info exists vars(rdl_placement)] && ($vars(rdl_placement) != "")} {
		append args " -rdl_placement \{$vars(rdl_placement)\}"
        }
       	if {[info exists vars(rdl_orientation)] && ($vars(rdl_orientation) != "")} {
		append args " -rdl_orientation $vars(rdl_orientation)"
	}
         if {[info exists vars(em_models_file)]} {
            append args " -em_models $vars(em_models_file)"
            append comments "#   - vars(em_models_file)\n"
         } else {
            append ucomments "#   - vars(em_models_file) \"EM_models_file\"\n"
         }
	# for qrc TechFile
	 if {[info exists vars(rail_extraction_tech_file)]} {
            append args " -extraction_tech_file $vars(rail_extraction_tech_file)"
		append args " -process_techgen_em_rules true"
            append comments "#   - vars(rail_extraction_tech_file)\n"
         } else {
            append ucomments "#   - vars(rail_extraction_tech_file) \"EM_models_file\"\n"
         }
         if {[info exists vars(rail_analysis_temp_dir)]} {
            append args " -temp_directory_name $vars(rail_analysis_temp_dir)"
            append comments "#   - vars(rail_analysis_temp_dir)\n"
         } else {
            append ucomments "#   - vars(rail_analysis_temp_dir) \"specify_tmp_dir_path\";# default:./tmp\n"
         }
         if {[info exists vars(static_rail,temperature)]} {
            append args " -temperature $vars(static_rail,temperature)"
            append comments "#   - vars(static_rail,temperature)\n"
         } else {
            append ucomments "#   - vars(static_rail,temperature) \"temperature\";# default:25\n"
         }
         if {[info exists vars(static_rail,dist_solver_processing)]} {
            append args " -enable_distributed_processing_in_solver $vars(static_rail,dist_solver_processing)"
            append comments "#   - vars(static_rail,dist_solver_processing)\n"
         } else {
            append ucomments "#   - vars(static_rail,dist_solver_processing) \"true/false\";# default:false\n"
         }
         if {[info exists vars(static_rail,gen_bb_voltage_file)]} {
            append args " -generate_block_boundary_voltage_file $vars(static_rail,gen_bb_voltage_file)"
            append comments "#   - vars(static_rail,gen_bb_voltage_file)\n"
         } else {
            append ucomments "#   - vars(static_rail,gen_bb_voltage_file) \"<list of instace names>\"\n"
         }
         if {[info exists vars(static_rail,ignore_shorts)]} {
            append args " -ignore_shorts $vars(static_rail,ignore_shorts)"
            append comments "#   - vars(static_rail,ignore_shorts)\n"
         } else {
            append ucomments "#   - vars(static_rail,ignore_shorts) \"true/false\";# default:false\n"
         }
         if {[info exists vars(static_rail,dis_analysis_types)]} {
            append args " -disable_analysis_types $vars(static_rail,dis_analysis_types)"
            append comments "#   - vars(static_rail,dis_analysis_types)\n"
         } else {
            append ucomments "#   - vars(static_rail,dis_analysis_types) \"<list analysis types to be disabled>\"\n"
         }
         if {[info exists vars(static_rail,cell_ignore_file)]} {
            append args " -cell_ignore_file $vars(static_rail,cell_ignore_file)"
            append comments "#   - vars(static_rail,cell_ignore_file)\n"
         } else {
            append ucomments "#   - vars(static_rail,cell_ignore_file) \"<cell_ignore_file>\"\n"
         }
         if {[info exists vars(static_rail,fast_views_list)]} {
            append args " -use_fast_view_list $vars(static_rail,fast_views_list)"
            append comments "#   - vars(static_rail,fast_views_list)\n"
         } else {
            append ucomments "#   - vars(static_rail,fast_views_list) \"<fast_views_cell_file>\"\n"
         }
         if {[info exists vars(static_rail,fast_accurate_views_list)]} {
            append args " -use_fast_accurate_view_list $vars(static_rail,fast_accurate_views_list)"
            append comments "#   - vars(static_rail,fast_accurate_views_list)\n"
         } else {
            append ucomments "#   - vars(static_rail,fast_accurate_views_list) \"<list_of_fast_accurate_pgv_cells>\"\n"
         }
         if {[info exists vars(static_rail,accurate_views_list)]} {
            append args " -use_accurate_view_list $vars(static_rail,accurate_views_list)"
            append comments "#   - vars(static_rail,accurate_views_list)\n"
         } else {
            append ucomments "#   - vars(static_rail,accurate_views_list) \"<list_of_accurate_pgv_cells>\"\n"
         }
         if {[info exists vars(static_rail,ext_inc_file)]} {
            append args " -extractor_include $vars(static_rail,ext_inc_file)"
            append comments "#   - vars(static_rail,ext_inc_file)\n"
         } else {
            append ucomments "#   - vars(static_rail,ext_inc_file) \"<extractor_include_file>\"\n"
         }
      }
      if {$args != ""} {
         set command "set_rail_analysis_mode $args\n"
         append commands [FF::wrap_command mode,static_rail $command]
      }
      
      ###############################################################################
      # Setting Power/Ground Nets Bias Vol, Threshold Vol and the Tolerance per-centage
      ###############################################################################
      if {[info exists vars(power_domains)]} {
         foreach vars(pd) $vars(power_domains) {
            if {[info exists vars($vars(pd),pwr_nets)]} {
               foreach net $vars($vars(pd),pwr_nets) {
                  if {[info exists vars($net,voltage)]} {
                     set threshold_volt [expr $vars(threshold_percent) * $vars($net,voltage) / 100.00]
                     if {![info exists vars($net,threshold)]} {
                        set vars($net,threshold) [expr $vars($net,voltage) - $threshold_volt]
                     }
                     if {![info exists vars($net,tolerance)]} {
                        set vars($net,tolerance) [expr $vars(supply_tolerance_percent) / 100.00]
                     }
                  }
               }
            }
            if {[info exists vars($vars(pd),gnd_nets)]} {
               foreach net $vars($vars(pd),gnd_nets) {
                  if {![info exists vars($net,threshold)]} {
                     set vars($net,threshold) $threshold_volt
                  }
                  if {![info exists vars($net,tolerance)]} {
                     set vars($net,tolerance) [expr $vars(supply_tolerance_percent) / 100.00]
                  }
               }
            }
         }
      }
      
      ################################################################################
      # Uniquefy all the PG nets of the design for analysis
      ################################################################################
      set global_nets [FF_VOLTUS::get_global_nets]

      append commands "#---------------------------------------------------------------------\n"
      append commands "# This script can be modified using the plug-in -> vars(set_static_rail_pg_nets_tcl)\n"
      append commands "#---------------------------------------------------------------------\n"
      if {[info exists vars(set_static_rail_pg_nets_tcl)] &&
          [file exists $vars(set_static_rail_pg_nets_tcl)]} {
         #Puts "<FF> LOADING USER DEFINED PLUG-IN : $vars(set_static_rail_pg_nets_tcl)"
         append commands [FF::source_plug set_static_rail_pg_nets_tcl]
      } else {
         if {[info exists global_nets]} {
            #Puts "<FF> SETTING PG NET VOLTAGES FOR STATIC-RAIL ANALYSIS :"
            foreach net $global_nets {
               set args ""
               if {[info exists vars($net,voltage)] &&
                  ($vars($net,voltage) != 0)} {
                  append args " -net $net -voltage $vars($net,voltage)"
               } else {
                  append args " -net $net -voltage 0.00"
               }
               if {[info exists vars($net,threshold)]} {
                  append args " -threshold $vars($net,threshold)"
               }
               if {[info exists vars($net,tolerance)]} {
                  append args " -tolerance $vars($net,tolerance) -force"
               } else {
                  append args " -force"
               }
               if {$args != ""} {
                  set command "set_pg_nets $args\n"
                  append commands [FF::wrap_command pg_nets,static_rail $command]
               }
            }
         }
      }
      
      ###############################################################################
      # Setting PG nets instance power/current files
      ###############################################################################
      set command "set_power_data -reset\n"
      append commands [FF::wrap_command power_data,static_rail $command]
      append commands "#---------------------------------------------------------------------\n"
      append commands "# This script can be modified using the plug-in -> vars(set_static_rail_power_data_tcl)\n"
      append commands "#---------------------------------------------------------------------\n"
      if {[info exists vars(set_static_rail_power_data_tcl)] &&
          [file exists $vars(set_static_rail_power_data_tcl)]} {
         #Puts "<FF> LOADING USER DEFINED PLUG-IN : $vars(set_static_rail_power_data_tcl)"
         append commands [FF::source_plug set_static_rail_power_data_tcl]
      } else {
         #Puts "<FF> SETTING PG NETS POWER/CURRENT FILES FOR STATIC-RAIL ANALYSIS :"
      #   set vars(static_power_reports) $vars(rpt_dir)/static_power
         if {[info exists global_nets]} {
            foreach net $global_nets {
               set args ""
               if {[info exists vars(static_rail,$net,scale)]} {
                  append args " -scale $vars(static_rail,$net,scale)"
               } else {
                  append args " -scale 1"
               }
               if {[info exists vars(static_rail,$net,pti_file)] &&
                   [file exists $vars(static_rail,$net,pti_file)]} {
                  append args " -format current $vars(static_rail,$net,pti_file)"
               } elseif {[info exists vars(static_rail,$net,ascii_file)] &&
                         [file exists $vars(static_rail,$net,ascii_file)]} {
                  append args " -bias_voltage 1.00 -format ascii $vars(static_rail,$net,ascii_file)"
               } else {
                  append args " -format current $vars(static_power_reports)/static_$net.ptiavg"
               }
               if {$args != ""} {
                  set command "set_power_data $args\n"
                  append commands [FF::wrap_command power_data,static_rail $command]
               }
            }
         }
      }
      
      ###############################################################################
      # Setting PG nets pad location files
      ###############################################################################
      append commands "#---------------------------------------------------------------------\n"
      append commands "# This script can be modified using the plug-in -> vars(set_static_rail_pad_location_tcl)\n"
      append commands "#---------------------------------------------------------------------\n"
      if {[info exists vars(set_static_rail_pad_location_tcl)] &&
          [file exists $vars(set_static_rail_pad_location_tcl)]} {
         #Puts "<FF> LOADING USER DEFINED PLUG-IN : $vars(set_static_rail_pad_location_tcl)"
         append commands [FF::source_plug set_static_rail_pad_location_tcl]
      } else {
         #Puts "<FF> SETTING PG NETS PAD LOCATION FILES FOR STATIC-RAIL ANALYSIS :"
         set command "set_power_pads -reset\n"
         append commands [FF::wrap_command power_pad,static_rail $command]
         if {[info exists global_nets]} {
            foreach net $global_nets {
               
               if {[info exists vars($net,format)]} {
		set args " -net $net"
                  append args " -format $vars($net,format)"
                  if {($vars($net,format) != "defpin") &&
                      [info exists vars($net,pad_file)] &&
                      [file exists $vars($net,pad_file)]} {
                     append args " -file $vars($net,pad_file)"
                  }
		set command "set_power_pads $args\n"
               append commands [FF::wrap_command power_pad,static_rail $command]
               } else {
                  append ucomments "#   -format vars($net,format) \"xy/padcell/defpin/boundary\"\n"
               }
               
            }
         }
      }
      
      ###############################################################################
      # Setting Power Domain for Domain based Rail Analysis
      ###############################################################################
      append commands "#---------------------------------------------------------------------\n"
      append commands "# This script can be modified using the plug-in -> vars(set_static_rail_analysis_domain_tcl)\n"
      append commands "#---------------------------------------------------------------------\n"
      if {[info exists vars(set_static_rail_analysis_domain_tcl)] &&
          [file exists $vars(set_static_rail_analysis_domain_tcl)]} {
         #Puts "<FF> LOADING USER DEFINED PLUG-IN : $vars(set_static_rail_analysis_domain_tcl)"
         append commands [FF::source_plug set_static_rail_analysis_domain_tcl]
      } else {
         if {[info exists vars(static_rail,analyze_type)] &&
             ($vars(static_rail,analyze_type) == "domain")} {
            #Puts "<FF> SETTING POWER DOMAINS FOR DOMAIN BASED STATIC-RAIL ANALYSIS :"
            if {[info exists vars(static_rail,analyze_domains)]} {
               foreach vars(pd) $vars(static_rail,analyze_domains) {
                  set args " -name $vars(pd)"
		# for net selecting
		if {[info exists vars($vars(pd),analyze_pwr_nets)]} {
		set vars($vars(pd),pwr_nets) $vars($vars(pd),analyze_pwr_nets)
		}
                  if {[info exists vars($vars(pd),pwr_nets)]} {
                     append args " -pwrnets \"$vars($vars(pd),pwr_nets)\""
                     append comments "#   - vars($vars(pd),pwr_nets)\n"
                  } else {
                     append comments "#   - vars($vars(pd),pwr_nets)\n"
                  }

		if {[info exists vars($vars(pd),analyze_gnd_nets)]} {
		set vars($vars(pd),gnd_nets) $vars($vars(pd),analyze_gnd_nets)
		}
                  if {[info exists vars($vars(pd),gnd_nets)]} {
                     append args " -gndnets \"$vars($vars(pd),gnd_nets)\""
                     append comments "#   -  vars($vars(pd),gnd_nets)\n"
                  } else {
                     append ucomments "#   - vars($vars(pd),gnd_nets)\n"
                  }
                  set command "set_rail_analysis_domain $args\n"
                  append commands [FF::wrap_command analysis_domain,static_rail $command]
               }
            }
         }
      }
      
      ###############################################################################
      # Load pre-static-rail-analysis plug-in
      ###############################################################################
#      if {[info exists vars(pre_static_rail_tcl)]} {
#         if {[file exists $vars(pre_static_rail_tcl)]} {
            #Puts "<FF> LOADING PRE-STATIC-RAIL-ANALYSIS PLUG-IN : $vars(pre_static_rail_tcl)"
            append commands [FF::source_plug pre_static_rail_tcl]
#         }
#      }
      
      ###############################################################################
      # Setting up vstorm2 advanced rail options
      ###############################################################################
      if {[info exists vars(static_rail,vstorm2_begin_file)] ||
          [info exists vars(static_rail,vstorm2_end_file)]} {
         #Puts "<FF> SETTING VSTORM2 RAIL OPTIONS INC FILE FOR STATIC-RAIL ANALYSIS :"
         set command "set_advanced_rail_options -reset\n"
         append commands [FF::wrap_command vstorm_inc,static_rail $command]
         set command "set_advanced_rail_options"
         if {[info exists vars(static_rail,vstorm2_begin_file)] && [file exists $vars(static_rail,vstorm2_begin_file)]} {
            append command " -vstorm2_include_file_begin $vars(static_rail,vstorm2_begin_file)\n"
         }
         if {[info exists vars(static_rail,vstorm2_end_file)] && [file exists $vars(static_rail,vstorm2_end_file)]} {
            append command " -vstorm2_include_file_end $vars(static_rail,vstorm2_end_file)\n"
         }
         if {$command != "set_advanced_rail_options"} {
            append commands [FF::wrap_command vstorm_inc,static_rail $command]
         }
      }
      
      ###############################################################################
      # Analyze Static Rail Analysis on the design
      ###############################################################################
      set vars(static_rail_reports) $vars(rpt_dir)/static_rail
      if {[info exists vars(static_rail,analyze_type)] &&
          ($vars(static_rail,analyze_type) == "net")} {
         if {[info exists global_nets]} {
            foreach net $global_nets {
               #Puts "ANALYZING STATIC-RAIL ANALYSIS ON $net :"
               set command "analyze_rail -type net -output $vars(static_rail_reports) $net\n"
               append commands [FF::wrap_command analyze,static_rail $command]
#               exec /bin/touch make/static_rail_on_$net
            }
         }
      } else {
         if {[info exists vars(static_rail,analyze_domains)]} {
            foreach vars(pd) $vars(static_rail,analyze_domains) {
               #Puts "ANALYZING STATIC-RAIL ANALYSIS ON $vars(pd) :"
               set command "analyze_rail -type domain -output $vars(static_rail_reports) $vars(pd)\n"
               append commands [FF::wrap_command analyze,static_rail $command]
#               exec /bin/touch make/static_rail_on_$vars(pd)
            }
         }
      }
      
      ###############################################################################
      # Load post-static-rail-analysis plug-in
      ###############################################################################
#      if {[info exists vars(post_static_rail_tcl)]} {
#         if {[file exists $vars(post_static_rail_tcl)]} {
            #Puts "<FF> LOADING POST-STATIC-RAIL-ANALYSIS PLUG-IN : $vars(post_static_rail_tcl)"
            append commands [FF::source_plug post_static_rail_tcl]
#         }
#      }
      
#      append commands "exec /bin/touch make/static_rail\n"

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

      set fcommands [FF_VOLTUS::insert_comments]
      append fcommands $commands

      return $fcommands

   }

   proc run_pg_generation {} {

      global vars

      set comments ""
      set ucomments ""

      ###############################################################################      
      ###############################################################################
	set common_args ""
	append common_args " -extraction_tech_file $vars(extraction_tech_file)"
	append common_args " -lef_layermap $vars(lef_layermap)"

# define setup.tcl priority is higher than plugin for advanced_pg_library_mode
	if {[info exists vars(set_advanced_pg_library_mode_tcl)] && [file exists $vars(set_advanced_pg_library_mode_tcl)]} {
        append commands "#---------------------------------------------------------------------\n"
        append commands "# This script can be modified using the plug-in -> vars(set_advanced_pg_library_mode_tcl)\n"
        append commands "#---------------------------------------------------------------------\n"
        append commands [FF::source_plug set_advanced_pg_library_mode_tcl]
	} elseif {
	[info exists vars(advanced_pg_library_mode)] && ($vars(advanced_pg_library_mode) != "")} {
        set args " $vars(advanced_pg_library_mode)"
        set command "set_advanced_pg_library_mode $args\n"
        append commands [FF::wrap_command mode,pg_generation $command]
        }

      if {[info exists vars(techonly_pg_creation)] && ($vars(techonly_pg_creation) == "true")} {
      append commands "#---------------------------------------------------------------------\n"
      append commands "# Scripts for generate techonly pg library\n"
      append commands "#---------------------------------------------------------------------\n"

	set args " -celltype techonly"
        append args " $common_args"
	if {[info exists vars(techonly_power_pins)]} {
        append args " -power_pins \{ $vars(techonly_power_pins) \}"
        }
        if {[info exists vars(techonly_ground_pins)]} {
        append args " -ground_pins \{ $vars(techonly_ground_pins) \}"
        }
	append args " $vars(techonly_other_options)"

      if {$args != ""} {
         set command "set_pg_library_mode $args\n"
         append commands [FF::wrap_command mode,pg_generation $command]
      }
	# seperate other options
#	if {[info exists vars(techonly_other_options)] && ($vars(techonly_other_options) != "")} {
#	 set command "set_pg_library_mode $vars(techonly_other_options)\n"
#	 append commands [FF::wrap_command mode,pg_generation $command]
#	}

	set args ""
	#append args " -output $vars(techonly_outdir)"
	append args " -output $vars(pg_dir)/$vars(techonly_outdir)"
     if {[info exists vars(techonly_prefix)]} {
         append args " -library_prefix $vars(techonly_prefix)"
      } 
	set command "generate_pg_library $args\n"
	append commands [FF::wrap_command generate_pg_library,pg_generation $command]
  }

      if {[info exists vars(stdcells_pg_creation)] && ($vars(stdcells_pg_creation) == "true")} {
      append commands "#---------------------------------------------------------------------\n"
      append commands "# Scripts for generate stdcell pg library\n"
      append commands "#---------------------------------------------------------------------\n"

	set args " -celltype stdcells"
	append args " $common_args"
	if {[info exists vars(stdcells_power_pins)]} {
        append args " -power_pins \{ $vars(stdcells_power_pins) \}"
        }
        if {[info exists vars(stdcells_ground_pins)]} {
        append args " -ground_pins \{ $vars(stdcells_ground_pins) \}"
        }
	append args " -spice_models $vars(stdcells_spice_models)"
	append args " -spice_subckts $vars(stdcells_spice_subckts)"
	append args " $vars(stdcells_other_options)"

      if {$args != ""} {
         set command "set_pg_library_mode $args\n"
         append commands [FF::wrap_command mode,pg_generation $command]
      }
	# seperate other options
#	if {[info exists vars(stdcells_other_options)] && ($vars(stdcells_other_options) != "")} {
#	 set command "set_pg_library_mode $vars(stdcells_other_options)\n"
#	 append commands [FF::wrap_command mode,pg_generation $command]
#	}

	set args ""
	#append args " -output $vars(stdcells_outdir)"
	append args " -output $vars(pg_dir)/$vars(stdcells_outdir)"
     if {[info exists vars(stdcells_prefix)]} {
         append args " -library_prefix $vars(stdcells_prefix)"
      } 
	set command "generate_pg_library $args\n"
	append commands [FF::wrap_command generate_pg_library,pg_generation $command]
}

      if {[info exists vars(macros_pg_creation)] && ($vars(macros_pg_creation) == "true")} {
      append commands "#---------------------------------------------------------------------\n"
      append commands "# Scripts for generate macro pg library\n"
      append commands "#---------------------------------------------------------------------\n"

	set args " -celltype macros"
	append args " $common_args"
	append args " -cell_list_file $vars(macros_cell_list_file)"
	if {[info exists vars(macros_power_pins)]} {
        append args " -power_pins \{ $vars(macros_power_pins) \}"
        }
        if {[info exists vars(macros_ground_pins)]} {
        append args " -ground_pins \{ $vars(macros_ground_pins) \}"
        }
	append args " -spice_models $vars(macros_spice_models)"
	append args " -spice_subckts $vars(macros_spice_subckts)"
	append args " -gds_files $vars(macros_gds_files)"
	append args " -gds_layermap $vars(macros_gds_layermap)"
	append args " $vars(macros_other_options)"

      if {$args != ""} {
         set command "set_pg_library_mode $args\n"
         append commands [FF::wrap_command mode,pg_generation $command]
      }
	# seperate other options
#	if {[info exists vars(macros_other_options)] && ($vars(macros_other_options) != "")} {
#	 set command "set_pg_library_mode $vars(macros_other_options)\n"
#	 append commands [FF::wrap_command mode,pg_generation $command]
#	}

	set args ""
	#append args " -output $vars(macros_outdir)"
	append args " -output $vars(pg_dir)/$vars(macros_outdir)"
     if {[info exists vars(macros_prefix)]} {
         append args " -library_prefix $vars(macros_prefix)"
      } 
	set command "generate_pg_library $args\n"
	append commands [FF::wrap_command generate_pg_library,pg_generation $command]
 }	
      set fcommands [FF_VOLTUS::insert_comments]
      append fcommands $commands
      return $fcommands
 }

   proc execute_flow_pgv {} {

      global vars

      ##############################################################################
      # VOLTUS Foundation Flow Main Run Script for only generate PGV Flow
      ##############################################################################
     
      file mkdir $vars(script_dir)/VOLTUS 
      set op [open $vars(script_dir)/VOLTUS/run_pgv.tcl w]

      set vars(flat) full
      
      puts "########################################################################"
      puts "# VOLTUS Foundation Flow Code Generator, [exec date]"
      puts "# Version : %VersionNumber%"
      puts "########################################################################"
     
      source $vars(setup_path)/setup.tcl 
      if {[file exists $vars(setup_path)/voltus_config.tcl]} {
         source $vars(setup_path)/voltus_config.tcl
      } 

      FF_VOLTUS::check_setup
     
      puts "-------------------------------------------------"
      if {[info exists vars(design)]} {
      puts "<FF> Generating scripts for $vars(design)"
      } else {
      puts "<FF> Generating scripts for $vars(edi_db_name)"
      }
      puts "-------------------------------------------------"

      set ov [open $vars(script_dir)/VOLTUS/vars_pgv.tcl w] 
      foreach var [array names vars] {
         puts $ov "set vars($var) \{$vars($var)\}" 
         #puts $ov "set vars($var) \"$vars($var)\"" 
      } 

      puts $op "source $vars(script_dir)/VOLTUS/vars_pgv.tcl"

      puts $op "source $vars(script_path)/ETC/VOLTUS/utils.tcl"

      puts $op [FF::pretty_print [FF_VOLTUS::initialize_multicpu] 1]
      puts $op "#-----------------------------------------------------------------------"
      puts $op "# Load Design"
      puts $op "#-----------------------------------------------------------------------"
      puts $op [FF::pretty_print [FF_VOLTUS::load_design_pgv] 1]

# enable generate pgv library
	if {[info exists vars(generate_pg)] && ($vars(generate_pg) == "true")} {
         puts  "<FF> Generating script for Power-Grid Library Generation ..."
         puts $op "#-----------------------------------------------------------------------"
         puts $op "# Power-Grid Library Generation"
         puts $op "#-----------------------------------------------------------------------"
         puts $op [FF::pretty_print [FF_VOLTUS::run_pg_generation] 1]
	}
# when pg_only = true, load_design shouldn't be invoke in run_pgv.tcl
      if {[info exists vars(pg_only)] && ($vars(pg_only) == "true")} {
	puts	"<INFO> Only run_pgv.tcl can be performed when pg_only = true"
# when pg_only = true, power or rail analysis commands will be deleted in run_pgv.tcl
      if {!([info exists vars(pg_only)] && ($vars(pg_only) == "true")) && [info exists vars(static_power)] && ($vars(static_power) == "true")} {
         puts  "<FF> Generating script for static power analysis ..."
         puts $op "#-----------------------------------------------------------------------"
         puts $op "# Static Power Analysis"
         puts $op "#-----------------------------------------------------------------------"
         puts $op [FF::pretty_print [FF_VOLTUS::run_static_power] 1]
      }
      
# when pg_only = true, power or rail analysis commands will be deleted in run_pgv.tcl
      if {!([info exists vars(pg_only)] && ($vars(pg_only) == "true")) && [info exists vars(static_rail)] && ($vars(static_rail) == "true")} {
         puts  "<FF> Generating script for static rail analysis ..."
         puts $op "#-----------------------------------------------------------------------"
         puts $op "# Static Rail Analysis"
         puts $op "#-----------------------------------------------------------------------"
         puts $op [FF::pretty_print [FF_VOLTUS::run_static_rail] 1]
      }
      
# when pg_only = true, power or rail analysis commands will be deleted in run_pgv.tcl
      if {!([info exists vars(pg_only)] && ($vars(pg_only) == "true")) && [info exists vars(dynamic_power)] && ($vars(dynamic_power) == "true")} {
         puts  "<FF> Generating script for dynamic power analysis ..."
         puts $op "#-----------------------------------------------------------------------"
         puts $op "# Dynamic Power Analysis"
         puts $op "#-----------------------------------------------------------------------"
         puts $op [FF::pretty_print [FF_VOLTUS::run_dynamic_power] 1]
      }
      
# when pg_only = true, power or rail analysis commands will be deleted in run_pgv.tcl
      if {!([info exists vars(pg_only)] && ($vars(pg_only) == "true")) && [info exists vars(dynamic_rail)] && ($vars(dynamic_rail) == "true")} {
         puts  "<FF> Generating script for dynamic rail analysis ..."
         puts $op "#-----------------------------------------------------------------------"
         puts $op "# Dynamic Rail Analysis"
         puts $op "#-----------------------------------------------------------------------"
         puts $op [FF::pretty_print [FF_VOLTUS::run_dynamic_rail] 1]
      }
     } else {
        puts "<INFO> When set pg_only = false or comment, run_static.tcl, run_dynamic.tcl and run_pg_static_dynamic.tcl can work !"
	}
 
      puts $op "exit"
      close $op

      FF_VOLTUS::gen_makefile

   }

   proc execute_flow_static {} {

      global vars

      ##############################################################################
      # VOLTUS Foundation Flow Main Run Script for the only Static Flow
      ##############################################################################
     
      file mkdir $vars(script_dir)/VOLTUS 
      set op [open $vars(script_dir)/VOLTUS/run_static.tcl w]

      set vars(flat) full
      
      puts "########################################################################"
      puts "# VOLTUS Foundation Flow Code Generator, [exec date]"
      puts "# Version : %VersionNumber%"
      puts "########################################################################"
     
      source $vars(setup_path)/setup.tcl 
         source $vars(setup_path)/voltus_config.tcl
#      if {[file exists $vars(setup_path)/voltus_config.tcl]} {
#         source $vars(setup_path)/voltus_config.tcl
#      } 

      FF_VOLTUS::check_setup
     
      puts "-------------------------------------------------"
      if {[info exists vars(design)]} {
      puts "<FF> Generating scripts for $vars(design)"
      } else {
      puts "<FF> Generating scripts for $vars(edi_db_name)"
      }
      puts "-------------------------------------------------"
    #  set dbg [open $vars(setup_path)/dbg.tcl w] 
      set ov [open $vars(script_dir)/VOLTUS/vars_static.tcl w] 
      foreach var [array names vars] {
#	puts $dbg "$avar"
	puts $ov "set vars($var) \{$vars($var)\}" 
      } 
      puts $op "source $vars(script_dir)/VOLTUS/vars_static.tcl"

      puts $op "source $vars(script_path)/ETC/VOLTUS/utils.tcl"

      puts $op [FF::pretty_print [FF_VOLTUS::initialize_multicpu] 1]
      puts $op "#-----------------------------------------------------------------------"
      puts $op "# Load Design"
      puts $op "#-----------------------------------------------------------------------"
      puts $op [FF::pretty_print [FF_VOLTUS::load_design] 1]

#   no matter what pg_only = false or comment, power analysis will be written in run_static.tcl 
      if {[info exists vars(static_power)] && ($vars(static_power) == "true")} {
         puts  "<FF> Generating script for static power analysis ..."
         puts $op "#-----------------------------------------------------------------------"
         puts $op "# Static Power Analysis"
         puts $op "#-----------------------------------------------------------------------"
         puts $op [FF::pretty_print [FF_VOLTUS::run_static_power] 1]
      }
      
#   no matter what pg_only = false or comment, rail analysis will be written in run_static.tcl 
      if {[info exists vars(static_rail)] && ($vars(static_rail) == "true")} {
         puts  "<FF> Generating script for static rail analysis ..."
         puts $op "#-----------------------------------------------------------------------"
         puts $op "# Static Rail Analysis"
         puts $op "#-----------------------------------------------------------------------"
         puts $op [FF::pretty_print [FF_VOLTUS::run_static_rail] 1]
      }
      puts $op "exit"
      close $op

      FF_VOLTUS::gen_makefile

   }

   proc execute_flow_dynamic {} {

      global vars

      ##############################################################################
      # VOLTUS Foundation Flow Main Run Script for the only Dynamic Flow
      ##############################################################################
     
      file mkdir $vars(script_dir)/VOLTUS 
      set op [open $vars(script_dir)/VOLTUS/run_dynamic.tcl w]

      set vars(flat) full
      
      puts "########################################################################"
      puts "# VOLTUS Foundation Flow Code Generator, [exec date]"
      puts "# Version : %VersionNumber%"
      puts "########################################################################"
     
      source $vars(setup_path)/setup.tcl 
      if {[file exists $vars(setup_path)/voltus_config.tcl]} {
         source $vars(setup_path)/voltus_config.tcl
      } 

      FF_VOLTUS::check_setup
     
      puts "-------------------------------------------------"
      if {[info exists vars(design)]} {
      puts "<FF> Generating scripts for $vars(design)"
      } else {
      puts "<FF> Generating scripts for $vars(edi_db_name)"
      }
      puts "-------------------------------------------------"

      set ov [open $vars(script_dir)/VOLTUS/vars_dynamic.tcl w] 
      foreach var [array names vars] {
         puts $ov "set vars($var) \{$vars($var)\}" 
      } 

      puts $op "source $vars(script_dir)/VOLTUS/vars_dynamic.tcl"

      puts $op "source $vars(script_path)/ETC/VOLTUS/utils.tcl"

      puts $op [FF::pretty_print [FF_VOLTUS::initialize_multicpu] 1]
      puts $op "#-----------------------------------------------------------------------"
      puts $op "# Load Design"
      puts $op "#-----------------------------------------------------------------------"
      puts $op [FF::pretty_print [FF_VOLTUS::load_design] 1]

#   no matter what pg_only = false or comment, power analysis will be written in run_dynamic.tcl 
      if {[info exists vars(dynamic_power)] && ($vars(dynamic_power) == "true")} {
         puts  "<FF> Generating script for dynamic power analysis ..."
         puts $op "#-----------------------------------------------------------------------"
         puts $op "# Dynamic Power Analysis"
         puts $op "#-----------------------------------------------------------------------"
         puts $op [FF::pretty_print [FF_VOLTUS::run_dynamic_power] 1]
      }
     
#   no matter what pg_only = false or comment, rail analysis will be written in run_dynamic.tcl 
      if {[info exists vars(dynamic_rail)] && ($vars(dynamic_rail) == "true")} {
         puts  "<FF> Generating script for dynamic rail analysis ..."
         puts $op "#-----------------------------------------------------------------------"
         puts $op "# Dynamic Rail Analysis"
         puts $op "#-----------------------------------------------------------------------"
         puts $op [FF::pretty_print [FF_VOLTUS::run_dynamic_rail] 1]
      }
      
      puts $op "exit"
      close $op

      FF_VOLTUS::gen_makefile

   }


proc execute_flow_signal_em {} {

      global vars

      set comments ""
      set ucomments ""

      ##############################################################################
      # VOLTUS Foundation Flow Main Run Script for the only Signal_em Flow
      ##############################################################################
     
      file mkdir $vars(script_dir)/VOLTUS 
      set op [open $vars(script_dir)/VOLTUS/run_signal_em.tcl w]

      set vars(flat) full
      
      puts "########################################################################"
      puts "# VOLTUS Foundation Flow Code Generator, [exec date]"
      puts "# Version : %VersionNumber%"
      puts "########################################################################"
     
      source $vars(setup_path)/setup.tcl 
      if {[file exists $vars(setup_path)/voltus_config.tcl]} {
         source $vars(setup_path)/voltus_config.tcl
      } 

      FF_VOLTUS::check_setup
     
      puts "-------------------------------------------------"
      if {[info exists vars(design)]} {
      puts "<FF> Generating scripts for $vars(design)"
      } else {
      puts "<FF> Generating scripts for $vars(edi_db_name)"
      }
      puts "-------------------------------------------------"

      set ov [open $vars(script_dir)/VOLTUS/vars_signal_em.tcl w] 
      foreach var [array names vars] {
         puts $ov "set vars($var) \{$vars($var)\}" 
      } 

      puts $op "source $vars(script_dir)/VOLTUS/vars_signal_em.tcl"

      puts $op "source $vars(script_path)/ETC/VOLTUS/utils.tcl"

      puts $op [FF::pretty_print [FF_VOLTUS::initialize_multicpu] 1]

      puts $op "#-----------------------------------------------------------------------"
      puts $op "# Load Design"
      puts $op "#-----------------------------------------------------------------------"
      puts  "<FF> Signal_EM analysis recommend use VOltus or Innovus DB !"
      puts $op [FF::pretty_print [FF_VOLTUS::load_design] 1]

	if {[info exists vars(signal_em)] && ($vars(signal_em) == "true")} {
         puts  "<FF> Generating script for signal em  analysis "
         puts $op "#-----------------------------------------------------------------------"
         puts $op "# Signal EM Analysis"
         puts $op "#-----------------------------------------------------------------------"
         puts $op [FF::pretty_print [FF_VOLTUS::run_signal_em] 1]
	} 
	
      puts $op "exit"
      close $op

      FF_VOLTUS::gen_makefile

   }

  proc execute_flow_esd {} {

	global vars

      ##############################################################################
      # VOLTUS Foundation Flow Main Run Script For the ESD voltus FF Flow
      ##############################################################################
     
      file mkdir $vars(script_dir)/VOLTUS 
      set op [open $vars(script_dir)/VOLTUS/run_esd.tcl w]

      set vars(flat) full
      
      puts "########################################################################"
      puts "# VOLTUS Foundation Flow Code Generator, [exec date]"
      puts "# Version : %VersionNumber%"
      puts "########################################################################"
     
      source $vars(setup_path)/setup.tcl 
      if {[file exists $vars(setup_path)/voltus_config.tcl]} {
         source $vars(setup_path)/voltus_config.tcl
      } 

      FF_VOLTUS::check_setup
     
      puts "-------------------------------------------------"
      if {[info exists vars(design)]} {
      puts "<FF> Generating scripts for $vars(design)"
      } else {
      puts "<FF> Generating scripts for $vars(edi_db_name)"
      }
      puts "-------------------------------------------------"

      set ov [open $vars(script_dir)/VOLTUS/vars_esd.tcl w] 
      foreach var [array names vars] {
         #puts $ov "set vars($var) {\"$vars($var)\"}" 
         puts $ov "set vars($var) \{$vars($var)\}" 
      } 

      puts $op "source $vars(script_dir)/VOLTUS/vars_esd.tcl"

      puts $op "source $vars(script_path)/ETC/VOLTUS/utils.tcl"

      puts $op [FF::pretty_print [FF_VOLTUS::initialize_multicpu] 1]
      puts $op "#-----------------------------------------------------------------------"
      puts $op "# Load Design For ESD Analysis"
      puts $op "#-----------------------------------------------------------------------"
      puts $op [FF::pretty_print [FF_VOLTUS::load_design_esd] 1]

	if {[info exists vars(static_rail)] && ($vars(static_rail) == "true")} {
         puts  "<FF> Generating rail analysis scripts for ESD analysis  ..."
         puts $op "#-----------------------------------------------------------------------"
         puts $op "# Static Rail Analysis For ESD"
         puts $op "#-----------------------------------------------------------------------"
         puts $op [FF::pretty_print [FF_VOLTUS::run_esd_rail] 1]
	}

	if {[info exists vars(esd_analyze)] && ($vars(esd_analyze) == "true")} {
         puts  "<FF> Generating script for ESD analysis ..."
         puts $op "#-----------------------------------------------------------------------"
         puts $op "# ESD Analysis"
         puts $op "#-----------------------------------------------------------------------"
         puts $op [FF::pretty_print [FF_VOLTUS::run_esd_analysis] 1]
	}

      puts $op "exit"
      close $op

      FF_VOLTUS::gen_makefile

}

   proc execute_flow_all {} {

      global vars

      ##############################################################################
      # VOLTUS Foundation Flow Main Run Script for the all voltus FF Flow
      ##############################################################################
     
      file mkdir $vars(script_dir)/VOLTUS 
      set op [open $vars(script_dir)/VOLTUS/run_pg_static_dynamic.tcl w]

      set vars(flat) full
      
      puts "########################################################################"
      puts "# VOLTUS Foundation Flow Code Generator, [exec date]"
      puts "# Version : %VersionNumber%"
      puts "########################################################################"
     
      source $vars(setup_path)/setup.tcl 
      if {[file exists $vars(setup_path)/voltus_config.tcl]} {
         source $vars(setup_path)/voltus_config.tcl
      } 

      FF_VOLTUS::check_setup
     
      puts "-------------------------------------------------"
      if {[info exists vars(design)]} {
      puts "<FF> Generating scripts for $vars(design)"
      } else {
      puts "<FF> Generating scripts for $vars(edi_db_name)"
      }
      puts "-------------------------------------------------"

      set ov [open $vars(script_dir)/VOLTUS/vars_all.tcl w] 
      foreach var [array names vars] {
         #puts $ov "set vars($var) {\"$vars($var)\"}" 
         puts $ov "set vars($var) \{$vars($var)\}" 
      } 

      puts $op "source $vars(script_dir)/VOLTUS/vars_all.tcl"

      puts $op "source $vars(script_path)/ETC/VOLTUS/utils.tcl"

      puts $op [FF::pretty_print [FF_VOLTUS::initialize_multicpu] 1]
      puts $op "#-----------------------------------------------------------------------"
      puts $op "# Load Design"
      puts $op "#-----------------------------------------------------------------------"
      puts $op [FF::pretty_print [FF_VOLTUS::load_design] 1]

#   pg_generation need in All FF flow 
	if {[info exists vars(generate_pg)] && ($vars(generate_pg) == "true")} {
         puts  "<FF> Generating script for Power-Grid Library Generation ..."
         puts $op "#-----------------------------------------------------------------------"
         puts $op "# Power-Grid Library Generation"
         puts $op "#-----------------------------------------------------------------------"
         puts $op [FF::pretty_print [FF_VOLTUS::run_pg_generation] 1]
	}

#   When pg_only = false or comment, power analysis will be written in run_voltus.tcl 
      if {[info exists vars(static_power)] && ($vars(static_power) == "true")} {
         puts  "<FF> Generating script for static power analysis ..."
         puts $op "#-----------------------------------------------------------------------"
         puts $op "# Static Power Analysis"
         puts $op "#-----------------------------------------------------------------------"
         puts $op [FF::pretty_print [FF_VOLTUS::run_static_power] 1]
      }
      
#   When pg_only = false or comment, rail analysis will be written in run_voltus.tcl 
      if {[info exists vars(static_rail)] && ($vars(static_rail) == "true")} {
         puts  "<FF> Generating script for static rail analysis ..."
         puts $op "#-----------------------------------------------------------------------"
         puts $op "# Static Rail Analysis"
         puts $op "#-----------------------------------------------------------------------"
         puts $op [FF::pretty_print [FF_VOLTUS::run_static_rail] 1]
      }
      
#   When pg_only = false or comment, power analysis will be written in run_voltus.tcl 
      if {[info exists vars(dynamic_power)] && ($vars(dynamic_power) == "true")} {
         puts  "<FF> Generating script for dynamic power analysis ..."
         puts $op "#-----------------------------------------------------------------------"
         puts $op "# Dynamic Power Analysis"
         puts $op "#-----------------------------------------------------------------------"
         puts $op [FF::pretty_print [FF_VOLTUS::run_dynamic_power] 1]
      }
     
#   When pg_only = false or comment, rail analysis will be written in run_voltus.tcl 
      if {[info exists vars(dynamic_rail)] && ($vars(dynamic_rail) == "true")} {
         puts  "<FF> Generating script for dynamic rail analysis ..."
         puts $op "#-----------------------------------------------------------------------"
         puts $op "# Dynamic Rail Analysis"
         puts $op "#-----------------------------------------------------------------------"
         puts $op [FF::pretty_print [FF_VOLTUS::run_dynamic_rail] 1]
      }
      
      puts $op "exit"
      close $op

      FF_VOLTUS::gen_makefile

   }

   proc get_global_nets {} {
   
      global vars
   
      if {[info exists vars(power_domains)]} {
         set all_nets ""
         set unique_nets ""
         foreach pd $vars(power_domains) {
            if {[info exists vars($pd,pwr_nets)] ||
                [info exists vars($pd,gnd_nets)]} {
               append all_nets "$vars($pd,pwr_nets) $vars($pd,gnd_nets) "
            }
         }
         set unique_nets [lsort -unique $all_nets]
         unset all_nets
      }
   
      return $unique_nets
   }
}

