################################################################################
#                        PRE-DYNAMIC-RAIL PLUG-IN
################################################################################
#
#  This plug-in will be called before executing "analyze_rail" command
#
################################################################################
# This script should contain only the VOLTUS supported commands
# Such as for example:
################################################################################
Puts "Pre Dynamic Rail Analysis PLUG-IN"

#set_net_group -reset
#set_net_group \
    -name <net_name> \
    -type <power/ground> \
    -nets {PG_nets}
#set_package \
    -spice model_file \
    -mapping mapping_file \
    -offset {x y}
#set_dynamic_rail_simulation -reset
#set_dynamic_rail_simulation \
    -start value \
    -stop value \
    -resolution value
