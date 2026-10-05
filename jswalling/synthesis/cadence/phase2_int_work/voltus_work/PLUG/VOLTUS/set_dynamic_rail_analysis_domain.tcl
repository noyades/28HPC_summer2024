################################################################################
#                  SET-DYNAMIC-RAIL-ANALYSIS-DOMAIN PLUG-IN
################################################################################
#
#  This plug-in will be called in-place of "set_rail_analysis_domain" command
#  executed with options specified in voltus_config.tcl
#
#   User can create their own power domains to run Dynamic Rail Analysis
#   NOTE: This step doesn't support incremental command.
#         So user has to provide full command
#
################################################################################
# This script should contain only the VOLTUS supported commands
# Such as for example:
################################################################################
Puts "Set Dynamic Rail Analysis Domain PLUG-IN"

#set_rail_analysis_domain  \
	-name core \
	-pwrnets {power net names} \
	-gndnets {ground net names} \
	-threshold <threshold value>
