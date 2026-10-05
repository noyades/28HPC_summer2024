################################################################################
#                     SET-DYNAMIC-RAIL-PG-NETS PLUG-IN
################################################################################
#
#  This plug-in will be called in-place of "set_pg_nets" command
#  executed with options specified in voltus_config.tcl
#
#   User can specify net voltage, threshold and tolerances for all PG nets
#   NOTE: This step doesn't support incremental command.
#         So user has to provide full command
#
################################################################################
# This script should contain only the VOLTUS supported commands
# Such as for example:
################################################################################
Puts "Set PG Nets PLUG-IN"

#set_pg_nets  \
	-net <power net name>  \
	-voltage  <value> \
	-threshold <value> \
	-tolerance 0.3 \
	-force
#set_pg_nets  \
	-net <ground net name>  \
	-voltage 0 \
	-threshold <value> \
	-tolerance 0.3 \
	-force
