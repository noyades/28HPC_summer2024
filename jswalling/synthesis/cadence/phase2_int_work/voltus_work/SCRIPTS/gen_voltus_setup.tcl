proc pad {a {add 0}} {
   
   if {[expr [string length $a] + $add] < 6} {
      return "\t\t\t\t"
   } elseif {[expr [string length $a] + $add] < 12} { 
      return "\t\t\t"
   } elseif {[expr [string length $a] + $add] < 18} { 
      return "\t\t"
   } elseif {[expr [string length $a] + $add] < 24} { 
      return "\t"
   }

}

proc format_string {a b {large 0}} {

   set add 0

   if {[regexp "#" $a]} {
      regsub "#" $a "" a
      set add 1
   }

#   puts "$a, [string length $a]"

   if {$large} {
      if {[expr [string length $a] + $add] < 4} {
         set tabs "\t\t\t\t\t\t\t\t\t\t"
      } elseif {[expr [string length $a] + $add] < 8} {
         set tabs "\t\t\t\t\t\t\t\t\t"
      } elseif {[expr [string length $a] + $add] < 12} {
         set tabs "\t\t\t\t\t\t\t\t"
      } elseif {[expr [string length $a] + $add] < 16} {
         set tabs "\t\t\t\t\t\t\t"
      } elseif {[expr [string length $a] + $add] < 20} {
         set tabs "\t\t\t\t\t\t"
      } elseif {[expr [string length $a] + $add] < 24} {
         set tabs "\t\t\t\t\t"
      } elseif {[expr [string length $a] + $add] < 28} {
         set tabs "\t\t\t\t"
      } elseif {[expr [string length $a] + $add] < 32} {
         set tabs "\t\t\t"
      } else {
         set tabs "\t\t"
      }
   } else {
      if {[expr [string length $a] + $add] < 4} {
         set tabs "\t\t\t\t\t\t"
      } elseif {[expr [string length $a] + $add] < 8} {
         set tabs "\t\t\t\t\t"
      } elseif {[expr [string length $a] + $add] < 12} {
         set tabs "\t\t\t\t"
      } elseif {[expr [string length $a] + $add] < 16} {
         set tabs "\t\t\t"
      } elseif {[expr [string length $a] + $add] < 20} {
         set tabs "\t\t"
      } else {
         set tabs "\t"
      }
   }
   if {$add} {
      return [format "#set $a%s%s" $tabs $b]
   } else {
      return [format "set $a%s%s" $tabs $b]
   }
}

proc get_line_match {pattern file {last 1}} {

   set ip [open $file r]

   while {[gets $ip line]>=0} {
      if {[regexp "$pattern" $line]>0} {
        if {$last} {
#	set last [expr $last-1]
           set match $line
         } else {
           lappend match $line
         }
      }
   }
   if {[info exists match]} {
      return $match
   }
}

set single_lib 0 

#   Puts "[array names rda_Input]"
set slow_libs [list]
set fast_libs [list]

   if {$rda_Input(ui_timelib,max) != ""} {
      foreach lib $rda_Input(ui_timelib,max) {
         foreach glob_lib [glob $lib] {
            if {[file isdirectory $glob_lib]} {
               foreach nested_glob_lib [glob $glob_lib/\*] {
                  lappend slow_libs $nested_glob_lib
               }
            } else {
               lappend slow_libs $glob_lib
            }
         }
      }
      foreach lib $rda_Input(ui_timelib) {
         foreach glob_lib [glob $lib] {
            if {[file isdirectory $glob_lib]} {
               foreach nested_glob_lib [glob $glob_lib/\*] {
                  lappend slow_libs $nested_glob_lib
               }
            } else {
               lappend slow_libs $glob_lib
            }
         }
      }
   #   set slow_libs [concat $rda_Input(ui_timelib,max) $rda_Input(ui_timelib)]
   } else {
      foreach lib $rda_Input(ui_timelib) {
         foreach glob_lib [glob $lib] {
            if {[file isdirectory $glob_lib]} {
               foreach nested_glob_lib [glob $glob_lib/\*] {
                  lappend slow_libs $nested_glob_lib
               }
            } else {
               lappend slow_libs $glob_lib
            }
         }
      }
   #   set slow_libs $rda_Input(ui_timelib)
   }
   if {$rda_Input(ui_timelib,min) != ""} {
      foreach lib $rda_Input(ui_timelib,min) {
         foreach glob_lib [glob $lib] {
            if {[file isdirectory $glob_lib]} {
               foreach nested_glob_lib [glob $glob_lib/\*] {
                  lappend fast_libs $nested_glob_lib
               }
            } else {
               lappend fast_libs $glob_lib
            }
         }
      }
      foreach lib $rda_Input(ui_timelib) {
         foreach glob_lib [glob $lib] {
            if {[file isdirectory $glob_lib]} {
               foreach nested_glob_lib [glob $glob_lib/\*] {
                  lappend fast_libs $nested_glob_lib
               }
            } else {
               lappend fast_libs $glob_lib
            }
         } 
      }
   #   set fast_libs [concat $rda_Input(ui_timelib,min) $rda_Input(ui_timelib)]
   } else {
      if [info exists slow_libs] { 
         set fast_libs $slow_libs 
         if {([llength [all_analysis_views]] == 2 && (![string match {1[1-9].*} [getversion]])) || ([info comm ::ETS::getTimingSysMode] != "" && [string match "emulate*" [::ETS::getTimingSysMode]]) } { 
            puts {[INFO]: min/max lib is the same in this design} 
            set single_lib 1
         }
      } 
   }
   
   #puts "--------------------------------------------------------------------------------------" 
   #puts "PQRS: $slow_libs"
   #puts "PQRS: $fast_libs"
   #puts "--------------------------------------------------------------------------------------" 

   if {[info exists rda_Input(ui_aocvlib)] && $rda_Input(ui_aocvlib) != "" } {
       set aocv_lib [list]
       foreach aocv_file $rda_Input(ui_aocvlib) {
         lappend aocv_lib $aocv_file
       }
       set aocv_lib_max $aocv_lib
       set aocv_lib_min $aocv_lib 
   }

   if {[info exists rda_Input(ui_aocvlib,max)] && $rda_Input(ui_aocvlib,max) != "" } {
       set aocv_lib_max [list]
       foreach aocv_file $rda_Input(ui_aocvlib,max) {
         lappend aocv_lib_max $aocv_file
       }
   }   

   if {[info exists rda_Input(ui_aocvlib,min)] && $rda_Input(ui_aocvlib,min) != "" } {
       set aocv_lib_min [list]
       foreach aocv_file $rda_Input(ui_aocvlib,min) {
         lappend aocv_lib_min $aocv_file
       }
   }

   set func_sdc [list]
   foreach sdc_file $rda_Input(ui_timingcon_file) {
      lappend func_sdc $sdc_file
   }

   set lef_files [list]
   foreach lef_edi_files $rda_Input(ui_leffile) {
      lappend lef_files $lef_edi_files
   }
 
   set lef_oa [list]
   foreach lef_oa_files $rda_Input(ui_oa_reflib) {
      lappend lef_oa $lef_oa_files
   }
   
   if {$rda_Input(ui_cdb_file,max) != ""} {
      set slow_cdbs [concat $rda_Input(ui_cdb_file,max) $rda_Input(ui_cdb_file)]
   } else {
      if {$rda_Input(ui_cdb_file) != ""} {
         set slow_cdbs $rda_Input(ui_cdb_file)
      }
   }
   if {$rda_Input(ui_cdb_file,min) != ""} {
      set fast_cdbs [concat $rda_Input(ui_cdb_file,min) $rda_Input(ui_cdb_file)]
   } else {
      if {$rda_Input(ui_cdb_file) != ""} {
         set fast_cdbs $rda_Input(ui_cdb_file)
      } else {
         if {[info exists slow_cdbs] && ($slow_cdbs != "")} {
            set fast_cdbs $slow_cdbs
         }
     }
   }

proc ff_conv2mmmc {} {

   global rda_Input
   global slow_libs
   global fast_libs
   global slow_cdbs
   global fast_cdbs
   
#   if {$wc_cap_table == ""} {
#      Puts "--------------------------------------------------------------------------------------" 
#      Puts "\[PQRS\]\[ERROR\] No cap tables defined for this testcase ... aborting"
#      Puts "--------------------------------------------------------------------------------------" 
#      exit 1
#   }
   
   if {([info exists dgn_max_temp] == 0) || ([info exists dgn_max_temp] && $dgn_max_temp == "")} {
      set max_temp ""
   } else {
      set max_temp $dgn_max_temp
   }
   
   if {([info exists dgn_min_temp] == 0) || ([info exists dgn_min_temp] && $dgn_min_temp == "")} {
      set min_temp ""
   } else {
      set min_temp [expr abs($dgn_min_temp)]
   }



   create_rc_corner -name rc_max  
    
   create_rc_corner -name rc_min
   
    
   if {[info exists slow_cdbs] && ($slow_cdbs != "")} {
      create_library_set -name libs_max -timing $slow_libs -si $slow_cdbs 
      create_library_set -name libs_min -timing $fast_libs -si $fast_cdbs 
   } else {
      create_library_set -name libs_max -timing $slow_libs
      create_library_set -name libs_min -timing $fast_libs
   }
   
   create_delay_corner -name corner_max -library_set libs_max -rc_corner rc_max
   create_delay_corner -name corner_min -library_set libs_min -rc_corner rc_min
   Puts "\[INFO\] create_constraint_mode setup_func_mode with "
   Puts "\[INFO\]   SDC files: $func_sdc"
   if {([info exists dgn_ilm_sdc]) && ($dgn_ilm_sdc != "")} {
     Puts "\[INFO\]   ILM SDC files: $dgn_ilm_sdc" 
     create_constraint_mode -name setup_func_mode -sdc_files $func_sdc -ilm_sdc_files $dgn_ilm_sdc
   } else {
     create_constraint_mode -name setup_func_mode -sdc_files $func_sdc 
   }
   create_analysis_view -name setup_func -constraint_mode setup_func_mode -delay_corner corner_max
   if {([info exists dgn_hold_func_sdc]) && ($dgn_hold_func_sdc != "")} {
     Puts "\[INFO\] create_constraint_mode hold_func_mode with "
     Puts "\[INFO\]   SDC files: $dgn_hold_func_sdc"
     if {([info exists dgn_ilm_sdc]) && ($dgn_ilm_sdc != "")} {
       Puts "\[INFO\]   ILM SDC files: $dgn_ilm_sdc" 
       create_constraint_mode -name hold_func_mode -sdc_files $dgn_hold_func_sdc -ilm_sdc_files $dgn_ilm_sdc
     } else {
       create_constraint_mode -name hold_func_mode -sdc_files $dgn_hold_func_sdc
     }
     create_analysis_view -name hold_func -constraint_mode hold_func_mode -delay_corner corner_min
   } else {
     create_analysis_view -name hold_func -constraint_mode setup_func_mode -delay_corner corner_min
   }
   set_analysis_view -setup {setup_func} -hold {hold_func} 
   set_default_view -setup {setup_func} -hold {hold_func} 
   set_interactive_constraint_modes [all_constraint_modes -active] 
}

# yangww global definiation: mmmc
set nondefault_rc_corner [list]
	foreach rc_corner [all_rc_corners] {
	    if {![regexp {^default_} $rc_corner]} {
		lappend nondefault_rc_corner $rc_corner
	    }
          }

puts {[INFO]: Recommend to use CPF file and viewDefinition file to load the design if needed}

set op1 [open setup.auto.tcl w]

puts $op1 "##########################################################################################"
puts $op1 "#                             CDNS FOUNDATION FLOW"
puts $op1 "#-----------------------------------------------------------------------------------------"
puts $op1 "################################################################################"
puts $op1 "#                             CDNS FOUNDATION FLOW"
puts $op1 "#-------------------------------------------------------------------------------"
puts $op1 "# This is the foundation flow setup file.  It contains all the necessary design"
puts $op1 "# data to drive all the CDNS foundation flows. Each flow will also require an"
puts $op1 "# additional configuration file to define flow specific information:"
puts $op1 "#-------------------------------------------------------------------------------"
puts $op1 "#    VOLTUS ->   voltus_config.tcl"
puts $op1 "################################################################################"
puts $op1 ""
puts $op1 "################################################################################"
puts $op1 "# Define variables to point data, libraries, reports and scripts"
puts $op1 "################################################################################"
puts $op1 {}
puts $op1 {set vars(script_root) SCRIPTS}
puts $op1 {set vars(plug_root)   PLUG/VOLTUS}
puts $op1 {set vars(rpt_dir)     RPT}
puts $op1 {set vars(log_dir)     LOG}
puts $op1 {}
puts $op1 {set vars(data_root)   "DATA"}
puts $op1 {set vars(libs_root)   "DATA/libs"}
puts $op1 {}
puts $op1 {################################################################################}
puts $op1 {# The following variables are REQUIRED to define}
puts $op1 {# the design data for the flow.}
puts $op1 {# ------------------------------------------------------------------------------}
puts $op1 {# set vars(edi_db_name)    <EDI_design_path>}
puts $op1 {# set vars(load_edi_db)    "true"}
puts $op1 {# ------------------------------------------------------------------------------}
puts $op1 {# Below variables for non-EDI design}
puts $op1 {# ------------------------------------------------------------------------------}
puts $op1 {# set vars(netlist)      <verilog netlist file>}
puts $op1 {# set vars(def_files)     <def file>}
puts $op1 {# set vars(sdc_files)     <timing constraints>}
puts $op1 {# set vars(design)        <top_design>}
puts $op1 {# ------------------------------------------------------------------------------}
puts $op1 {# Ignore undefined cells while loading the design, default is false}
puts $op1 {# ------------------------------------------------------------------------------}
puts $op1 {# set vars(ignore_undefined_cell)       "<true/false>"}
puts $op1 {# set vars(ignore_timing_library_check) "<true/false>";# must be false for power}
puts $op1 {# ------------------------------------------------------------------------------}
puts $op1 {# Specify SPEF, if the design is non-MMMC}
puts $op1 {# ------------------------------------------------------------------------------}
puts $op1 {# set vars(spef)         <spef only for non-mmmc design>}
puts $op1 {################################################################################}
puts $op1 {#set vars(edi_db_name)      <EDI_design_path>}
puts $op1 {#set vars(load_edi_db)      "true"}
puts $op1 {}

if {[info exists rda_Input(ui_netlist)]} {
   set vars(netlist) [list]
   foreach  file $rda_Input(ui_netlist) {
      lappend vars(netlist) [file normalize $file]
   }
} else {
   catch {set vars(netlist) [file normalize [lindex [get_line_match "Reading netlist file" [getLogFileName]] 3]]}
}

if {[info exists vars(netlist)]} {
#      puts $op1 [format "set vars(netlist)%s%s" [pad vars(netlist)] $vars(netlist)]
      puts $op1 [format_string vars(netlist) \"$vars(netlist)\"]
#      puts $op1 [format_string vars(netlist_type) verilog]
   }

puts $op1 {# set vars(def_files)     <def file>	  ; # Can't determine sdc automatically}

if {[info exists rda_Input(ui_timingcon_file)] && ($rda_Input(ui_timingcon_file) != "")} {
	set vars(sdc_files) [list]
	foreach  file $rda_Input(ui_timingcon_file) {
	 lappend vars(sdc_files) [file normalize $file]
 }
	puts $op1 [format_string vars(sdc_files) \"$vars(sdc_files)\"]
} else {
	puts $op1 {# set vars(sdc_files)     <timing constraints>   ; # Can't determine sdc automatically}
}

puts $op1 [format_string vars(design) [dbCellName [dbgTopCell]]]

puts $op1 {# set vars(spef)         <spef only for non-mmmc design>}
puts $op1 {}
puts $op1 {################################################################################}
puts $op1 {# Supported flows -> default or mmmc}
puts $op1 {################################################################################}


if {[llength $nondefault_rc_corner] >= 2} {
	puts $op1 {set vars(flow)    	"mmmc"}
} else {
	puts $op1 {set vars(flow)    	"default"}
}
#if {$single_corner == 0} {
#	puts $op1 {set vars(flow)    	"mmmc"}
#} else {
#	puts $op1 {set vars(flow)    	"default"}
#}

puts $op1 {}
puts $op1 {################################################################################}
puts $op1 {#                        For MMMC Designs}
puts $op1 {################################################################################}
puts $op1 {# The following parameter for CPF based MMMC design ONLY}
puts $op1 {# ------------------------------------------------------------------------------}
puts $op1 {# set vars(cpf_file)       <CPF_file>}
puts $op1 {# ------------------------------------------------------------------------------}
puts $op1 {# The following parameter is MMMC setup file}
puts $op1 {# ------------------------------------------------------------------------------}
puts $op1 {# set vars(mmmc_setup_file)  <view_definations_file>}
puts $op1 {# ------------------------------------------------------------------------------}
puts $op1 {# Define rc corners for mmmc design...}
puts $op1 {# ------------------------------------------------------------------------------}
puts $op1 {# set vars(rc_corners)     "<corner1> <corner2> ..."}
puts $op1 {# ------------------------------------------------------------------------------}
puts $op1 {# set vars(<corner1>,spef) <corner1_spef>}
puts $op1 {# set vars(<corner2>,spef) <corenr2_spef>}
puts $op1 {# ------------------------------------------------------------------------------}
puts $op1 {# Define analysis views for mmmc design...}
puts $op1 {# ------------------------------------------------------------------------------}
puts $op1 {# set vars(analysis_views) "<view1> <view2>"}
puts $op1 {################################################################################}

if {[info exists ::CPF::cpf_file]} {
	set vars(cpf_file) [file normalize $::CPF::cpf_file]
	puts $op1 [format_string vars(cpf_file) \"$vars(cpf_file)\"]
} else {
puts $op1 {#set vars(cpf_file)        <CPF_file> }
}

if {[info exists init_mmmc_file] && ![regexp {^.ets_emulate_} $init_mmmc_file]} {
	set vars(mmmc_setup_file) [file normalize $init_mmmc_file]
	puts $op1 [format_string vars(mmmc_setup_file) \"$vars(mmmc_setup_file)\"]
} else {
	puts $op1 {#set vars(mmmc_setup_file)  <view_definations_file>}
}



if {$nondefault_rc_corner != ""} {
	puts $op1 "[format_string vars(rc_corners) \"$nondefault_rc_corner\"]	\; # Only non-default rc corners are listed "
}

set nondefault_analysis_view [list]
	foreach analysis_view [all_analysis_views] {
	    if {![regexp {^default_} $analysis_view]} {
		lappend nondefault_analysis_view $analysis_view
	    }
          }

if {$nondefault_analysis_view != ""} {
	puts $op1 "[format_string vars(analysis_views) \"$nondefault_analysis_view\"]	  \; # Only non-default analysis views are listed "
}
puts $op1 {}
puts $op1 {################################################################################}
puts $op1 {# Define active analysis view}
puts $op1 {################################################################################}
puts $op1 {#set vars(active_analysis_view) "<active view>"}

#This is incorrect
#Usage: redirect [-help] [<file_or_var_name>] [<command>] [-tee] [-stdin | -append | -variable ] [-stderr | -stdin ]

report_analysis_views -type active > .active_view.tmp
set active_view [open .active_view.tmp r]

#redirect -variable active_view [report_analysis_views -type active]
set nondefault_active_view [list]
while { [ gets $active_view line ] >= 0 } {
	if {[string match "*Analysis View:*" $line] } {
		set view_name [lindex $line 3]
		if {[info exists view_name] && ![regexp {^default_} $view_name]} {
			lappend nondefault_active_view $view_name
	}
  }
}

if {$nondefault_active_view != ""} {
	puts $op1 "[format_string vars(active_analysis_view) \"$nondefault_active_view\"]	  \; # Only non-default active analysis views are listed "
}

puts $op1 {}
puts $op1 {################################################################################}
puts $op1 {# Define library sets ... REQUIRED for non-EDI database}
puts $op1 {# ------------------------------------------------------------------------------}
puts $op1 {# set vars(library_sets) "max min"}
puts $op1 {# set vars(max,timing) <list of lib files> }
puts $op1 {# set vars(min,timing) <list of lib files> }
puts $op1 {# ------------------------------------------------------------------------------}
puts $op1 {# Define LEF files}
puts $op1 {# set vars(lef_files) <list of lef files> }
puts $op1 {# ------------------------------------------------------------------------------}
puts $op1 {# Define Power-Grid views}
puts $op1 {# set vars(cl_views) <list of .cl files>}
puts $op1 {################################################################################}
puts $op1 {}

set vars(library_sets) [list]
set vars(max,timing) [list]
set vars(min,timing) [list]
if {[info exists slow_libs] && ($slow_libs != "")} {
	lappend vars(library_sets) max
        set vars(max,timing) [file normalize $slow_libs]
} 
if {[info exists fast_libs] && ($fast_libs != "") && ($single_lib == 0)} {
	lappend vars(library_sets) min
	set vars(min,timing) [file normalize $fast_libs]
}

if {($vars(library_sets) == "")} {
	puts $op1 "# This design has multiple library sets: "
	puts $op1 "# [all_library_sets]"
	puts $op1 {# The library sets will not be defined here}
	puts $op1 {}
}

if {[info exists vars(library_sets)] && ($vars(library_sets) != "")} {
	puts $op1 [format_string vars(library_sets) \"$vars(library_sets)\"]
	puts $op1 {}
}

if {[info exists vars(max,timing)] && ($vars(max,timing) != "")} {
	puts $op1 [format_string vars(max,timing) \"$vars(max,timing)\"]
	puts $op1 {}
}

if {[info exists vars(min,timing)] && ($vars(min,timing) != "")} {
	puts $op1 [format_string vars(min,timing) \"$vars(min,timing)\"]
	puts $op1 {}
}

if {[info exists rda_Input(ui_leffile)]} {
	set vars(lef_files) [list]
	foreach  file $rda_Input(ui_leffile) {
      lappend vars(lef_files) [file normalize $file]
   }
}

if {[info exists vars(lef_files)]} {
	puts $op1 [format_string vars(lef_files) \"$vars(lef_files)\"]
	puts $op1 {}
}

set PGV [get_rail_analysis_mode -power_grid_library]
if {($PGV != "")} {
	puts $op1 [format_string vars(cl_views) \"$PGV\"]
} else {
	puts $op1 {# Can't determine vars(cl_views) unless "set_rail_analysis_mode -power_grid_library" is specified}
}

puts {[INFO]: setup.auto.tcl has been generated under PWD}

close $op1
