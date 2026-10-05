################################################################################
#                     SET-STATIC-RAIL-MODE PLUG-IN
################################################################################
#
#  This plug-in will be called in-place of "set_rail_analysis_mode" command
#  executed with options specified in voltus_config.tcl
#
#   User can specify their own options for Static Rail Analysis
#   NOTE: This step doesn't support incremental command.
#         So user has to provide full command
#
################################################################################
# This script should contain only the VOLTUS supported commands
# Such as for example:
################################################################################
Puts "Set Static Rail Analysis Mode PLUG-IN"

#set_rail_analysis_mode
#-method {static | dynamic}
#-accuracy {fast | accurate | fast_accurate}
#-power_grid_library dir_list 
#[-analysis_view view]
#[-off_rails net_name_list]
#[-power_switch_eco {true | false}]
#[-em_models file]
#[-default_package_resistor value]
#[-default_package_inductor value]
#[-default_package_capacitor value]
#[-vsrc_search_distance value]
#[-report_msmv_format {true | false}]
#[-generate_movies {true | false}]
#[-decap_opt_method {removal | feasibility | timing | area | 
#feasibility_removal}]
#[-decap_removal_method {conservative | aggresssive}]
#[-max_leakage value]
#[-generate_decap_eco {true | false}]
#[-generate_block_boundary_voltage_file {list of instance names}] 
#[-temp_directory_name directory] 
#[-save_transient_states {true | false}] 
#[-report_via_current_direction {true | false}] 
#[-save_current_files {true | false}] 
#[-gds_purpose {flipChip | fullChip}] 
#[-gds_file file [-gds_offset {x y}]] 
#[-gds_top_cell cell_name ] 
#[-dont_touch_decaps file] 
#[-decap_cell_list { cell1 cell2 ... celln }] 
#[-filler_cell_list { cell1 cell2 ... celln }] 
#[-decap_eco_file file] 
#[-rms_em_analysis {true | false}] 
#[-suppress_message {message_id + }] 
#[-disable_analysis_types {list of analysis types}]
#[-gds_map file]
#[-enable_sensitivity_analysis {true | false}] 
#[-cell_ignore_file filename] 
#[-save_voltage_waveforms {true | false}] 
#[-read_thermal_map thermal_map_file_for_QRC] 
#[-temperature value] 
#[-solver_memory_option [1 | 2]] 
#[-extractor_include filename] 
#[-max_viacluster_mode {true | false}] 
#[-use_fast_view_list filename] 
#[-use_fast_accurate_view_list filename] 

