################################################################################
#                     POST-STATIC-POWER PLUG-IN
################################################################################
#
#  This plug-in will be called after completion of static "report_power"
#
################################################################################
# This script should contain only the VOLTUS supported commands
# Such as for example:
################################################################################
Puts "Post Static Power PLUG-IN"

################################################################################
#   This plug-in can include:
#       VOLTUS commands to view the static power analysis reports for debugging
################################################################################
#restore_power_database -file $vars(static_power_reports)/Power.db
