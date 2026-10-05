################################################################################
#                  SET-DYNAMIC-RAIL-PAD-LOCATION PLUG-IN
################################################################################
#
#  This plug-in will be called in-place of "set_power_pads" command
#  executed with options specified in voltus_config.tcl
#
#   User can specify their own power pad location files as per the requirement
#   NOTE: This step doesn't support incremental command.
#         So user has to provide full command
#
################################################################################
# This script should contain only the VOLTUS supported commands
# Such as for example:
################################################################################
Puts "Set Power Pad Location PLUG-IN"

#set_power_pads -reset
#set_power_pads  \
	-format <defpin|padcell|xy|boundary> \
	-net <power net name> \
	-file <file name>
#set_power_pads  \
	-format <defpin|padcell|xy|boundary> \
	-net <ground net name> \
	-file <file name>
