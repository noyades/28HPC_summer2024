#!/usr/bin/env tclsh
# -*-TCL-*-

###############################################################################
#                       CADENCE COPYRIGHT NOTICE
#     (C)   2008-2013 Cadence Design Systems, Inc. All rights reserved.
#------------------------------------------------------------------------------
#
# This Foundation Flow is provided as an example of how to perform specialized
# tasks within Voltus IC Power Integrity Solution System.
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

set tcl_version [info tclversion]
set version [split $tcl_version "."]
set major [lindex $version 0]
set minor [lindex $version 1]
set valid_version 1
if {$major != "8"} {
   set valid_version 0
} else {
   if {[expr $minor] < 4} {
      set valid_version 0
   }
}
if {!$valid_version} {
   puts "-------------------------------------------------"
   puts "<FF> ERROR: TCL VERSION MUST BE 8.4 OR GREATER."
   puts "            YOUR TCL VERSION IS $tcl_version."
   puts "            PLEASE RUN THE FLOW GENERATOR USING"
   puts "            VOLTUS (WITH -e OPTION)"
   puts "-------------------------------------------------"
   exit -1
} else {
   puts "-------------------------------------------------"
   puts "<FF>  TCL VERSION -> $tcl_version"
   puts "-------------------------------------------------"
}

set vars(version) "post-13.2"
set vars(cwd) [exec pwd]
set vars(info_count) 0
set vars(warning_count) 0
set vars(error_count) 0

set vars(execute_string)  [format "%s %s %s" [info nameofexecutable] [file normalize $argv0] $argv]

##############################################################################
# Copyright (C) 2009 Cadence Design Systems, Inc.  All rights reserved.      #
#                                                                            #
# This script runs the commands to create a Foundation Flow script for a     #
# specific design or block.                                                  #
#                                                                            #
#----------------------------------------------------------------------------#
#                                                                            #
# Below are various messages that may be printed out to the display based on #
# user input.                                                                #
##############################################################################


namespace eval ::FFMM:: {
   set validModes [list "mmmc" "default"]

   set missingFiles "<FF> ERROR: Could not find Foundation Flow script files in directory \"%s\""

   set missingSetupFile "<FF> ERROR: Could not find setup.tcl in directory \"%s\""

   set noFlat "<FF> ERROR: \"-f\" option specified without a valid option"

   set noPath "<FF> ERROR: \"-p\" option specified without a directory path"

   set nosetup_path "<FF> ERROR: \"-s\" option specified without a directory path"

   set noSuchPath "<FF> ERROR: Directory path \"%s\" not found."

   set unknownMode "<FF> ERROR: Unknown runtime mode specified \"%s\" "

   set unknownOption "<FF> ERROR: Unrecognized option \"%s\" "

   set usage "

   Options may be one or more of the following:
     -1          : Prints each VOLTUS command out on a single line.
                   By default, the VOLTUS commands may be printed across lines
                   with an approximate line size of 80-90 characters.
     -h | --help : Print this message
     -f | --flat : Level of unrolling ... full, partial, none
     -d | --dir  : Output directory for generated scripts.
     -s | --setup : Provide the directory containing the setup.tcl setup file
                   requried to run the Foundation Flow.  Examples:
                       -s /directory
"
}

##############################################################################
# Parse the arguments passed in to the script.  These set up the environment #
# for the rest of the system                                                 #
##############################################################################

if {![info exists vars(script_dir)]} {
   set vars(script_dir) "FF"
}

set vars(check_setup) 1

proc create_flow {argv0 argv} {

   global vars
   global errors
   global warnings

   interp alias {} Puts {} puts

   if {![info exists vars(script_path)]} {
      set vars(script_path) ""
   }
   set normalized [file normalize $argv0]
   if {[file isdirectory $normalized]} {
      set default_script_path $normalized
   } elseif {[file isdirectory [file dirname $normalized]]} {
      set default_script_path [file dirname $normalized]
   }

   if {[info exists env(FF_SETUP_PATH)] && [file exists $env(FF_SETUP_PATH)]} {
      set setup_path $env(FF_SETUP_PATH)
   } else {
      set setup_path "."
   }

#   if {![info exists argv] || ![llength $argv]} {
#      set argv "-h"
#   }

   set vars(format_lines) true

   while {[string match "-*" [lindex $argv 0]]} {
      if {![llength $argv]} {
         break
      }
      set option [lindex $argv 0]
      set argv [lreplace $argv 0 0]

      switch -regexp -- $option {
         -1 {
            #
            # Turn off formatted printing
            #

            set vars(format_lines) false
         }

         ^-(h|-help)$ {
            puts $::FFMM::usage
            exit 0
         }

         ^-(f|-flat)$ {
            #
            # Get the path to the scripts.
            #

            if {[llength $argv]} {
               set newFlat [lindex $argv 0]
               set argv [lreplace $argv 0 0]
            } else {
               puts $::FFMM::noFlat
               exit -1
            }
            if {($newFlat != "full") && ($newFlat != "partial") && ($newFlat != "none")} {
               puts $::FFMM::noFlat
               exit -1
            }
            puts "<FF> FLAT == $newFlat"
            set vars(flat) $newFlat
         }
         ^-(e|-eps)$ {
            #
            # Enable EPS mode

            if {[llength $argv]} {
               set vars(eps) true
#               set argv [lreplace $argv 0 0]
            }
            puts "<FF> EPS == $vars(eps)"
         }

         ^-(d|-dir)$ {
            #
            # Define output directory path
            #

            if {[llength $argv]} {
               set newDir [lindex $argv 0]
               set argv [lreplace $argv 0 0]
            } else {
               puts $::FFMM::noPath
               exit -1
            }

            puts "<FF> OUTPUT DIRECTORY == $newDir"
            set vars(script_dir) $newDir
         }

         ^-(s|-setup)$ {
            #
            # Get the path to the directory containing the setup.tcl control
            # file
            #

            if {[llength $argv]} {
               set newPath [lindex $argv 0]
               set argv [lreplace $argv 0 0]
            } else {
               puts $::FFMM::nosetup_path
               puts $::FFMM::usage
               exit -1
            }

            #
            # Does the path exist?  If not, error out.  Make sure that the path
            # exists and contains the source files
            #

            if {![file exists $newPath]} {
               puts [format $::FFMM::noSuchPath $newPath]
               puts $::FFMM::usage
               exit -1
            }
            set setup_path $newPath
            puts "<FF> SETUP PATH == $setup_path"
         }

         default {
            puts [format $::FFMM::unknownOption $option]
            puts $::FFMM::usage
            exit -1
         }
      }
   }

   #
   # Check the paths to make sure that the files that we need actually exist
   #

   if {$vars(script_path) == ""} {
      set vars(script_path) $default_script_path
   }

   if {![file exists $vars(script_path)/VOLTUS/procs.tcl]} {
      puts [format $::FFMM::missingFiles $vars(script_path)]
      exit -1
   }
   if {![file exists $setup_path/setup.tcl]} {
      puts [format $::FFMM::missingSetupFile $setup_path]
      exit -1
   } else {
      set vars(setup_path) $setup_path
      source $vars(setup_path)/setup.tcl
	puts "read setup"
   }
   if {[file exists $vars(setup_path)/voltus_config.tcl]} {
         source $vars(setup_path)/voltus_config.tcl
#	puts "read voltus confg"
      }
	
   #
   # Source the other Tcl files to execute the flow.  Then do so
   source $vars(script_path)/VOLTUS/procs.tcl
   source $vars(script_path)/ETC/utils.tcl
  # source $vars(script_path)/ETC/VOLTUS/default_settings.tcl
  # source $vars(script_path)/ETC/VOLTUS/utils.tcl

   global vars
   if {![info exists vars(flat)]} {set vars(flat) off}
#   if {![info exists vars(flat)]} {set vars(flat) full}
   if {![info exists vars(codegen)]} {set vars(codegen) true}
#   if {![info exists mode]} {set mode single}
#   set vars(mode) $mode

   if {![llength $argv]} {
      set step flow
   } else {
      set step $argv
   }
##-----------------------------------------------------------------------------------------#
## generate four run_*.tcl once for all in different voltus_config.tcl and setup.tcl script.
##-----------------------------------------------------------------------------------------#

if {[info exists vars(generate_pg)] && ($vars(generate_pg) == "true")} { 
#	puts "<>read generate_pg vars"
   ::FF_VOLTUS::execute_flow_pgv} 

if {!([info exists vars(pg_only)] && ($vars(pg_only) == "true")) && ([info exists vars(static_power)] && ($vars(static_power) == "true") || [info exists vars(static_rail)] && ($vars(static_rail) == "true"))} { 
#	puts "read pg_only and static power or rail vars"
   ::FF_VOLTUS::execute_flow_static}
 
if {!([info exists vars(pg_only)] && ($vars(pg_only) == "true")) && ([info exists vars(dynamic_power)] && ($vars(dynamic_power) == "true") || [info exists vars(dynamic_rail)] && ($vars(dynamic_rail) == "true")) } { 
#	puts "read pg_only and dynamic power or rail vars"
   ::FF_VOLTUS::execute_flow_dynamic}

if {[info exists vars(signal_em)] && ($vars(signal_em) == "true")} {
#	puts "read signal_em vars"
   ::FF_VOLTUS::execute_flow_signal_em}

if {([info exists vars(esd_analyze)] && ($vars(esd_analyze) == "true")) && ([info exists vars(static_rail)] && ($vars(static_rail) == "true"))} {
#	puts "read esd vars"
   ::FF_VOLTUS::execute_flow_esd}

if {[info exists vars(generate_pg)] && ($vars(generate_pg) == "true") &&
    [info exists vars(pg_only)] && ($vars(pg_only) == "false") &&
    [info exists vars(static_power)] && ($vars(static_power) == "true") &&
    [info exists vars(static_rail)] && ($vars(static_rail) == "true") &&
    [info exists vars(dynamic_power)] && ($vars(dynamic_power) == "true") &&
    [info exists vars(dynamic_rail)] && ($vars(dynamic_rail) == "true")} {
#	puts "read generate_pg, static_power/rail, dynamic_power/rail vars"
   ::FF_VOLTUS::execute_flow_all} 
}

create_flow $argv0 $argv

puts "-------------------------------------------------"
if {[info exists vars(plug_files)] && ($vars(plug_files) != "")} {
   puts "\n		Plug-ins Imported"
   puts "		-------------------"                                                    
   foreach file $vars(plug_files) {
      puts "		$file"
   }
}
if {[info exists vars(warning_count)] && ($vars(warning_count) > 0)} {
   puts "\n		Warning Summary"
   puts "		-------------------"                                                    
   for {set i 0} {$i<$vars(warning_count)} {incr i} {
      puts "		([expr $i + 1]) $warnings($i)"
   }
}
if {[info exists vars(error_count)] && ($vars(error_count) > 0)} {
   puts "\n		Error Summary"
   puts "		-------------------"                                                    
   for {set i 0} {$i<$vars(error_count)} {incr i} {
      puts "		([expr $i + 1]) $errors($i)"
   }
   if {$vars(abort)} {
      puts "\n"
      puts "-------------------------------------------------"
      puts "<FF> CODE GENERATION COMPLETED WITH ERRORS"
      puts "-------------------------------------------------"
      exit 1
   }
}
puts "\n"
puts "-------------------------------------------------"
puts "<FF> CODE GENERATION COMPLETE"
puts "-------------------------------------------------"
puts "<FF> ... VERSION  -> $vars(version)"
puts "<FF> ... SCRIPTS  -> $vars(script_dir)/VOLTUS"
#puts "<FF> ... PLUGINS  -> $plugins_defined defined, $plugins_found found"
if {[info exists vars(check_vars)] && $vars(check_vars)} {
   puts "<FF> ... REPORTS  -> $vars(script_dir)/voltus.check.rpt"
   puts "<FF> ...          -> $vars(script_dir)/check_vars.rpt"
} else {
   puts "<FF> ... REPORT   -> $vars(script_dir)/voltus.check.rpt"
}
if {[info exists vars(makefile_name)] && [file isfile [subst $vars(makefile_name)]]} {
   puts "<FF> ... MAKEFILE -> $vars(makefile_name) (link to Makefile)"
}

	exec ln -sf $vars(makefile_name) Makefile 
# Generate Makefile with different vars in voltus_config.tcl
# generate run_pgv.tcl when generate_pg=true
if {[info exists vars(generate_pg)] && ($vars(generate_pg) == "true")} { 
	exec ln -sf $vars(makefile_name) Makefile } else {
	puts "<INFO> The run_pgv.tcl couldn't be generated!\n<INFO> Please Set generate_pg = true"}

# generate run_static.tcl when pg_only=false && static_power=true 
if {!([info exists vars(pg_only)] && ($vars(pg_only) == "true")) && ([info exists vars(static_power)] && ($vars(static_power) == "true") || [info exists vars(static_rail)] && ($vars(static_rail) == "true"))} {
	exec ln -sf $vars(makefile_name) Makefile } else {
	puts "<INFO> The static power analysis doesn't exist in run_static.tcl\n<INFO> Please Set static_power = true && pg_only=false"}

# generate run_dynamic.tcl when pg_only=false && dynamic_power=true
if {!([info exists vars(pg_only)] && ($vars(pg_only) == "true")) && ([info exists vars(dynamic_power)] && ($vars(dynamic_power) == "true") || [info exists vars(dynamic_rail)] && ($vars(dynamic_rail) == "true"))} { exec ln -sf $vars(makefile_name) Makefile } else {
	puts "<INFO> The dynamic power analysis doesn't exist in run_dynamic.tcl\n<INFO> Please Set dynamic_power = true && pg_only=false"}

# generate run_signal_em.tcl when signal_em=true
if {[info exists vars(signal_em)] && ($vars(signal_em) == "true")} {
	exec ln -sf $vars(makefile_name) Makefile } else {
	puts "<INFO> The run_signal_em.tcl couldn't be generated!\n<INFO> Please Set signal_em = true"}

# generate run_esd.tcl when esd_analyze=true
if {([info exists vars(esd_analyze)] && ($vars(esd_analyze) == "true")) && ([info exists vars(static_rail)] && ($vars(static_rail) == "true"))} {
	exec ln -sf $vars(makefile_name) Makefile } else {
	puts "<INFO> The run_esd.tcl couldn't be generated!\n<INFO> Please Set esd_analyze = true"}

# generate run_voltus_pg_static_dynamic.tcl when generate_pg=true && static_power/rail=true && dynamic_power/rail=true
if {[info exists vars(generate_pg)] && ($vars(generate_pg) == "true") &&
    [info exists vars(pg_only)] && ($vars(pg_only) == "false") &&
    [info exists vars(static_power)] && ($vars(static_power) == "true") &&
    [info exists vars(static_rail)] && ($vars(static_rail) == "true") &&
    [info exists vars(dynamic_power)] && ($vars(dynamic_power) == "true") &&
    [info exists vars(dynamic_rail)] && ($vars(dynamic_rail) == "true")} {
	exec ln -sf $vars(makefile_name) Makefile } else {
	puts "<INFO> The run_pg_static_dynamic.tcl couldn't be generated!\n<INFO> Please Set vars:generate_pg/static_power/static_rail/dynamic_power/dynamic_rail/ to true and pg_only=false!"}

puts "-------------------------------------------------"

exit
