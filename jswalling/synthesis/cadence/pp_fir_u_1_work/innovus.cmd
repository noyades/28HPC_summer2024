#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Sun Jan 12 14:31:54 2025                
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
gui_select -point {7.38300 179.35250}
delete_selected_from_floorplan
gui_select -point {8.30050 179.57900}
delete_selected_from_floorplan
gui_select -point {19.49700 179.60400}
gui_select -toggle -point {20.36700 179.47950}
gui_select -toggle -point {31.55050 179.41750}
gui_select -toggle -point {32.23350 179.41750}
gui_select -toggle -point {43.54150 179.41750}
gui_select -toggle -point {44.28700 179.35550}
gui_select -toggle -point {55.53250 179.35550}
gui_select -toggle -point {56.15400 179.47950}
gui_select -toggle -point {67.44300 179.60400}
gui_select -toggle -point {68.18850 179.47950}
gui_select -toggle -point {79.62050 179.47950}
gui_select -toggle -point {80.11750 179.35550}
gui_select -toggle -point {91.42550 179.54150}
gui_select -toggle -point {92.04650 179.47950}
gui_select -toggle -point {103.47850 179.35550}
gui_select -toggle -point {104.10000 179.41750}
gui_select -toggle -point {115.38900 179.47950}
gui_select -toggle -point {116.13450 179.35550}
gui_select -toggle -point {127.50450 179.29300}
gui_select -toggle -point {128.49850 179.35550}
gui_select -point {25.36250 186.40950}
gui_select -point {19.33500 179.35600}
gui_select -toggle -point {20.10450 179.35600}
gui_select -toggle -point {31.64650 179.48400}
gui_select -toggle -point {32.09550 179.48400}
gui_select -toggle -point {43.50900 179.48400}
gui_select -toggle -point {44.21450 179.09950}
gui_select -toggle -point {44.29300 179.61100}
delete_selected_from_floorplan
gui_select -point {55.47500 179.51300}
gui_select -toggle -point {56.09600 179.56500}
gui_select -toggle -point {67.43500 179.40950}
gui_select -toggle -point {68.00450 179.40950}
gui_select -toggle -point {79.60250 179.40950}
gui_select -toggle -point {80.01650 179.35800}
gui_select -toggle -point {91.35550 179.30600}
gui_select -toggle -point {92.18350 179.51300}
gui_select -toggle -point {103.49250 179.48950}
gui_select -toggle -point {104.13750 179.48950}
gui_select -toggle -point {115.48250 179.27450}
gui_select -toggle -point {116.12750 179.48950}
gui_select -toggle -point {127.47250 179.48950}
gui_select -toggle -point {128.11800 179.38200}
gui_select -toggle -point {139.46250 179.48950}
gui_select -toggle -point {140.21550 179.38200}
gui_select -toggle -point {151.48900 179.59550}
gui_select -toggle -point {152.07550 179.52200}
gui_select -toggle -point {163.50750 179.52200}
gui_select -toggle -point {164.31350 179.37550}
gui_select -toggle -point {175.59900 179.30200}
gui_select -toggle -point {176.11200 179.30200}
gui_select -toggle -point {187.48950 179.45950}
gui_select -toggle -point {188.25300 179.52450}
gui_select -toggle -point {199.54750 179.52450}
gui_select -toggle -point {199.93950 179.48100}
delete_selected_from_floorplan
source ../scripts/init.tcl 
gui_select -point {6.81800 182.27300}
set_layer_preference node_layer -is_visible 0
set_layer_preference AP -is_visible 1
set_layer_preference M9 -is_visible 1
set_layer_preference M8 -is_visible 1
set_layer_preference M7 -is_visible 1
set_layer_preference M6 -is_visible 1
set_layer_preference M5 -is_visible 1
set_layer_preference VIA4 -is_visible 1
time_design -pre_cts 
opt_design -pre_cts 
write_db pp_fir_u_1_04_postcts.enc
source ../scripts/cts.tcl 
gui_select -point {130.64300 118.93950}
write_db pp_fir_u_1_05_postcts.enc
source ../scripts/route.tcl 
source ../scripts/postroute.tcl 
report_power
write_db pp_fir_u_1_postroute.enc
write_netlist pp_fir_u_1_struct_inn.v
write_stream pp_fir_u_1_struct_inn.gds -map_file /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/arm_tech/r1p0/lef/1p9m_6x2z_utalrdl/tech.map -lib_name DesignLib -unit 2000 -mode all
