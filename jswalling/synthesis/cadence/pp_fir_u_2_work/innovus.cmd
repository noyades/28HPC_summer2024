#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Sun Jan 12 19:24:31 2025                
#                                                     
#######################################################

#@(#)CDS: Innovus v22.10-p001_1 (64bit) 09/29/2022 11:03 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: NanoRoute 22.10-p001_1 NR220915-0329/22_10-UB (database version 18.20.590) {superthreading v2.19}
#@(#)CDS: AAE 22.10-p002 (64bit) 09/29/2022 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: CTE 22.10-p004_1 () Sep  7 2022 21:57:29 ( )
#@(#)CDS: SYNTECH 22.10-p001_1 () Aug  8 2022 11:26:34 ( )
#@(#)CDS: CPE v22.10-p005
#@(#)CDS: IQuantus/TQuantus 21.2.0-s201 (64bit) Wed Jul 6 19:14:09 PDT 2022 (Linux 3.10.0-693.el7.x86_64)

read_db INVS/
read_floorplan ../../pp_fir_u_0_power.fp
gui_select -point {7.47150 178.83900}
gui_select -toggle -point {8.28900 178.58750}
gui_select -toggle -point {19.42000 178.49300}
gui_select -toggle -point {20.11200 178.52450}
gui_select -toggle -point {31.42300 178.52450}
gui_select -toggle -point {32.17750 178.58700}
gui_select -toggle -point {43.59150 178.58700}
gui_select -toggle -point {44.09450 178.58700}
gui_select -toggle -point {55.40550 178.52450}
gui_select -toggle -point {56.09750 178.58700}
gui_select -toggle -point {67.44850 178.71300}
gui_select -toggle -point {68.26600 178.52450}
delete_selected_from_floorplan
gui_select -toggle -point {79.34400 179.36050}
gui_select -toggle -point {80.02150 179.48600}
gui_select -toggle -point {91.28750 179.46100}
gui_select -toggle -point {92.29100 179.46100}
gui_select -toggle -point {103.57150 179.41100}
gui_select -toggle -point {104.12350 179.56150}
gui_select -toggle -point {115.54000 178.50750}
gui_select -toggle -point {116.01700 178.60800}
gui_select -toggle -point {127.62350 178.65800}
gui_select -toggle -point {128.05000 178.70800}
gui_select -toggle -point {139.71750 178.65800}
gui_select -toggle -point {140.21900 178.60800}
gui_select -toggle -point {151.42450 178.75850}
gui_select -toggle -point {152.10150 178.55750}
gui_select -toggle -point {163.56850 178.65800}
gui_select -toggle -point {164.12050 178.60800}
gui_select -toggle -point {175.50100 178.70800}
gui_select -toggle -point {176.15350 178.63300}
gui_select -toggle -point {187.49500 178.78350}
gui_select -toggle -point {188.02200 178.70800}
gui_select -toggle -point {199.42750 178.65800}
gui_select -toggle -point {200.20550 178.60800}
delete_selected_from_floorplan
time_design -pre_cts 
opt_design -pre_cts 
source ../scripts/init.tcl 
source ../scripts/cts.tcl 
source ../scripts/postcts.tcl 
source ../scripts/route.tcl 
source ../scripts/postroute.tcl 
check_connectivity -type all -geometry_connect -error 1000 -warning 50
set_db check_drc_disable_rules {}
set_db check_drc_ndr_spacing auto
set_db check_drc_check_only default
set_db check_drc_inside_via_def true
set_db check_drc_exclude_pg_net false
set_db check_drc_ignore_trial_route false
set_db check_drc_ignore_cell_blockage false
set_db check_drc_use_min_spacing_on_block_obs auto
set_db check_drc_report pp_fir_u_2.drc.rpt
set_db check_drc_limit 1000
check_drc
set_db check_drc_area {0 0 0 0}
write_db pp_fir_u_2_postroute.enc
write_netlist pp_fir_u_2_struct_inn.v
gui_select -point {86.39100 181.99950}
write_stream pp_fir_u_2_struct_inn.gds -map_file /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/arm_tech/r1p0/lef/1p9m_6x2z_utalrdl/tech.map -lib_name DesignLib -unit 2000 -mode all
