#-----------------------------------------------------------------------
# ESD Analysis
#-----------------------------------------------------------------------
analyze_esd -method bump_to_esd_resistance \
   -pwr_net DVDD0V9 \
   -gnd_net GND \
   -threshold 0.5 \
   -output ESD.rpt
#view ESD violation in GUI, please turn it on if you need!
#view_esd_violation -file <output> -threshold <lower_threshold> -limit <upper_threshold>

exit
