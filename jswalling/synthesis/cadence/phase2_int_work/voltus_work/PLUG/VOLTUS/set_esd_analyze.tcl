################################################################################
#                     SET-ESD-ANALYZE PLUG-IN
################################################################################
#
#  This plug-in will be called in-place of "analyze_esd" command
#  executed with options specified in voltus_config.tcl
#
#   User can specify their own options for ESD Analysis
#   NOTE: This step doesn't support incremental command.
#         So user has to provide full command
#
################################################################################
# This script should contain only the VOLTUS supported commands
# Such as for example:
################################################################################
Puts "Set ESD Analysis Mode PLUG-IN"

#analyze_esd \
	-common_supply_pins pin_list \
	-display \
	-esd_cell_list celllist \
	-loop_threshold value \
	-method {bump_to_esd_resistance | bump_to_esd_loop_resistance} \
	-output filename \
	-output_dir directory \
	-pwr_net pwrNetName \
	-gnd_net gndNetName \
	-threshold value \
	-bump_cell_list instlist \
	-bump_instance_list instlist \
	-report_threshold value \
	-use_power_pad {true | false}

