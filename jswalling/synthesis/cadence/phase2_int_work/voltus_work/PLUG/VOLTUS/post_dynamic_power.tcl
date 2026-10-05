################################################################################
#                     POST-DYNAMIC-POWER PLUG-IN
################################################################################
#
#  This plug-in will be called after completion of dynamic "report_power"
#
################################################################################
#restore_power_database -file $vars(dynamic_power_reports)/Power.db
#report_power
#[-cap]
#[-cell { cell_list } ]
#[-cell_type {all | { macro io combinational sequential clock_combinational clock_sequential } }]
#[-clock_domain names ]
#[-clock_network {all | { clock_list } }]
#[-count_seq_elements_in_clock_network]
#[-instances { instance_list } ]
#[-hierarchy {all | hierarchy_level} ]
#[-leakage]
#[-net [-nworst]]
#[-no_wrap]
#[-outfile filename ]
#[-pg_net {all | pg_net_name_list }]
#[-power_domain {all | { power_domain_list } } ]
#[-rail_analysis_format { VS }]
#[-sort {internal | switching | leakage | total}]
#[-threshold value ]
#[-view view_name ]
#[-threshold_voltage_group { all | group_name }]
#[-clock_gating_efficiency]
#[-register_gating_efficiency]
#[¨Ccluster_gating_efficiency]
#[-thermal_leakage_temp { temp1 temp2 temp3 ¡­}]
#[-thermal_power_map_file file_name ]
#[-thermal_power_map_tile { Xint Yint }]
#[-thermal_power_map_format {simple | stack }]
#[-pg_pin]
#[-thermal_conductivity_inputs file_name ]
#[-output directory ]
#[-o directory ]
#[-report_prefix prefix ]
#[-toggle_rate]
#[-format { simple | detailed } ]
#[ -comb_seq_power ]
