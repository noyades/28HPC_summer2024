################################################################################
#
# Genus(TM) Synthesis Solution setup file
# Created by Genus(TM) Synthesis Solution 21.11-s126_1
#   on 05/10/2024 16:54:20
#
# This file can only be run in Genus Common UI mode.
#
################################################################################


# This script is intended for use with Genus(TM) Synthesis Solution version 21.11-s126_1


# Remove Existing Design
################################################################################
if {[::legacy::find -design design:topVcoDigital] ne ""} {
  puts "** A design with the same name is already loaded. It will be removed. **"
  delete_obj design:topVcoDigital
}


# To allow user-readonly attributes
################################################################################
::legacy::set_attribute -quiet force_tui_is_remote 1 /


# Source INIT Setup file
################################################################################
source ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/.genus2invs.genus_init.tcl

phys::read_script ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/genus2invs.g.gz

phys::read_lec_taf ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/genus2invs.lec.taf.gz
read_def -design design:topVcoDigital ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/genus2invs.def.gz
puts "\n** Restoration Completed **\n"


# Data Integrity Check
################################################################################
# program version
if {"[string_representation [::legacy::get_attribute program_version /]]" != "21.11-s126_1"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-91] "golden program_version: 21.11-s126_1  current program_version: [string_representation [::legacy::get_attribute program_version /]]"
}
# license
if {"[string_representation [::legacy::get_attribute startup_license /]]" != "Genus_Synthesis"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-91] "golden license: Genus_Synthesis  current license: [string_representation [::legacy::get_attribute startup_license /]]"
}
# slack
set _slk_ [::legacy::get_attribute slack design:topVcoDigital]
if {[regexp {^-?[0-9.]+$} $_slk_]} {
  set _slk_ [format %.1f $_slk_]
}
if {$_slk_ != "-299.5"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden slack: -299.5,  current slack: $_slk_"
}
unset _slk_
# multi-mode slack
if {"[string_representation [::legacy::get_attribute slack_by_mode design:topVcoDigital]]" != "{{mode:topVcoDigital/view_wcl_slow -299.5} {mode:topVcoDigital/view_wcl_fast 227.5} {mode:topVcoDigital/view_wcl_typical 4968.8}}"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden slack_by_mode: {{mode:topVcoDigital/view_wcl_slow -299.5} {mode:topVcoDigital/view_wcl_fast 227.5} {mode:topVcoDigital/view_wcl_typical 4968.8}}  current slack_by_mode: [string_representation [::legacy::get_attribute slack_by_mode design:topVcoDigital]]"
}
# tns
set _tns_ [::legacy::get_attribute tns design:topVcoDigital]
if {[regexp {^-?[0-9.]+$} $_tns_]} {
  set _tns_ [format %.0f $_tns_]
}
if {$_tns_ != "43278"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden tns: 43278,  current tns: $_tns_"
}
unset _tns_
# cell area
set _cell_area_ [::legacy::get_attribute cell_area design:topVcoDigital]
if {[regexp {^-?[0-9.]+$} $_cell_area_]} {
  set _cell_area_ [format %.0f $_cell_area_]
}
if {$_cell_area_ != "533"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden cell area: 533,  current cell area: $_cell_area_"
}
unset _cell_area_
# net area
set _net_area_ [::legacy::get_attribute net_area design:topVcoDigital]
if {[regexp {^-?[0-9.]+$} $_net_area_]} {
  set _net_area_ [format %.0f $_net_area_]
}
if {$_net_area_ != "126"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden net area: 126,  current net area: $_net_area_"
}
unset _net_area_
# library domain count
if {[llength [::legacy::find /libraries -library_domain *]] != "3"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden # library domains: 3  current # library domains: [llength [::legacy::find /libraries -library_domain *]]"
}
