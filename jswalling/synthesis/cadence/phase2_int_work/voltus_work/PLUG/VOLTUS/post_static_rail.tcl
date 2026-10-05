################################################################################
#                        POST-STATIC-RAIL PLUG-IN
################################################################################
#
#  This plug-in will be called after executing "analyze_rail" command
#
################################################################################
# This script should contain only the VOLTUS supported commands
# Such as for example:
################################################################################
Puts "Post Static Rail Analysis PLUG-IN"

#view_analysis_results \
    -state_directory dir \
    -power_db file \
    -pwr_iv_file file \
    -gnd_iv_file file \
    -effective_iv_file file \
    -enable_violation_browser {true | false} \
    -enable_voltage_sources {true | false} \
    -display overlay | clear \
    -free_data \
    -temp_directory dir \
    -visible_layer {layers} \
    -plot plot_type \
    -min_filter value1 -max_filter value2 | -filter filter_values \
    -measure_region x1 y1 x2 y2 \
    -report filename \
    -report_limit N \
    -report_instance instance_name -append \
    -show_eco_decap {true | false} \
    -cell_library {library1.cl} \
    -enable_pgdb_name_mapping {true | false}
