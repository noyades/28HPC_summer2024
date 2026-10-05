################################################################################
#                     SET-ADVANCED-PG-LIBRARY-MODE PLUG-IN
################################################################################
#
#  This plug-in will be called in-place of "set_advanced_pg_library_mode" command
#  executed with options specified in voltus_config.tcl
#
#   User can specify their own options for advanced pg library generation 
#   NOTE: This step doesn't support incremental command.
#         So user has to provide full command
#
################################################################################
# This script should contain only the VOLTUS supported commands
# Such as for example:
################################################################################
Puts "Set Advanced PG Library Mode PLUG-IN"

#set_advanced_pg_library_mode
#[-add_port_labels file_name ]
#[-assume_foreigns {true | false}]
#[-assume_foreigns_mode [1 | 0]]
#[-cell_accura_data_file file ]
#[-cell_pinnet_map_file file ]
#[-circuit_include_file thunder.inc ]
#[-cluster_via_size value ]
#[-common_supply_pins { net_name+ }]
#[-create_static_view_from_dynamic_view {true | false}]
#[-damping_decap_cell_list { cell1 cell2 ..}]
#[-damping_decap_frequency value ]
#[-default_frequency value ]
#[-default_power_voltage value ]
#[-esd_cells { cell_list }]
#[-extraction_command_file file ]
#[-import_xdspf_list_file filename ]
#[-libgen_command_file file ]
#[-macro_parasitic_file filename ]
#[-marker_layermap filename ]
#[-pgdb_list_file filename ]
#[-pgdb_layermap filename ]
#[-powergate_characterization_voltages { val1 val2 val3 .... }]
#[-process_bulk_diffusion_ports {true|false}]
#[-remove_emview_dangling_resistor {true|false} ]
#[-schematic {true|false} ]
#[-source_location_file { filename } ]
#[-techgen_dir directory ]
#[-thunder_command_file file ]
#[-verbosity {true | false}]
#[-well_cap_file filename ]
#[-xdspf_layermap filename ]
#[-xtc_command_file filename ]
#[-xtc_include_file_for_qdv filename ]
#[-followpins_tap_layer {lowest_lef_pin_layer | all_lef_pin_layers}]
#[-use_embedded_spectre {true | false}]
#[-strict_input_check {true|false} ]
#[-ignore_pg_nets {{ cellname netname }+} ]
#[ -tap_node_distance value ]
#[ -delete_ddv_fsdb_files {true|false} ]

