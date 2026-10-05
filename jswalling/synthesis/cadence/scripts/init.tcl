set_db init_ground_nets VSS
set_db init_ground_nets VDD
connect_global_net VDD -type pgpin -pin VDD -inst *
connect_global_net VSS -type pgpin -pin VSS -inst *
connect_global_net VDD -type pgpin -pin VDD -inst *
connect_global_net VSS -type pgpin -pin VSS -inst *
add_tieoffs -lib_cell {TIELO_X1M_A9PP140ZTL_C30 TIEHI_X1M_A9PP140ZTL_C30} -prefix LTIE

time_design -pre_cts
opt_design -pre_cts


