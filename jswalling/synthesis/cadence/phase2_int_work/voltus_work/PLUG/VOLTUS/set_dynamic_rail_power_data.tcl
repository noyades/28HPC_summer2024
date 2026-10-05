################################################################################
#                     SET-DYNAMIC-RAIL-POWER-DATA PLUG-IN
################################################################################
#
#  This plug-in will be called in-place of "set_power_data" command
#  executed with options specified in voltus_config.tcl
#
#   User can specify instance power/current data files
#   NOTE: This step doesn't support incremental command.
#         So user has to provide full command
#
################################################################################
# This script should contain only the VOLTUS supported commands
# Such as for example:
################################################################################
Puts "Set Power Data Files PLUG-IN"

#set_power_data -reset
#set_power_data \
   -format {current | ascii | area} \
   -instance instance_name \
   -offset offset_value \
   -power value \
   -scale factor \
   -repeat time \
   -bias_voltage value \
   -die_instance_name dieinstname \
   file_list
#set_power_data  \
	-format <current/area>  \
	-scale 1 {power/ground current files from RPT/DYNAMIC_POWER directory}
#set_power_data \
	-format ascii \
	-bias_voltage <nominal voltage> <dynamic power file>
