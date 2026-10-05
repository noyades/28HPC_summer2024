################################################################################
#                     WRITE-TWF PLUG-IN
################################################################################
# This plug-in will be called in-place of "set_write_twf_tcl" command
# executed with options specified in voltus_config.tcl
#
# This script will generate TWF with customer's definition and only support dynamic
# power analysis in vectorless method.
# The TWF file mainly contains the earliest and the latest possible arrival times
# that a signal may arrive on a net or a pin.
################################################################################
Puts "Loading Write TWF PLUG-IN"

#write_twf
#outfile \
#[-exclude_instances < string >] \
#[-include_instances < string >] \
#[-pin] \
#[-ssta_sigma_multiplier < float >] \
#[-view < string >] \
#[-voltage_threshold < string >]

