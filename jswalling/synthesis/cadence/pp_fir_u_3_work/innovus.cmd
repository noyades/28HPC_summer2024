#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Mon Jan 13 11:40:06 2025                
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
gui_select -point {7.43350 178.54400}
gui_select -toggle -point {8.18600 178.54400}
gui_select -toggle -point {19.47700 178.54400}
gui_select -toggle -point {20.35550 178.54400}
gui_select -toggle -point {31.43750 178.46000}
gui_select -toggle -point {32.19000 178.50200}
delete_selected_from_floorplan
gui_select -toggle -point {43.59050 178.58550}
gui_select -toggle -point {44.17600 178.58550}
gui_select -toggle -point {55.55100 178.62750}
gui_select -toggle -point {56.22000 178.50200}
gui_select -toggle -point {67.51100 178.58550}
gui_select -toggle -point {68.13850 178.66900}
delete_selected_from_floorplan
gui_select -toggle -point {79.74800 179.58900}
gui_select -point {80.12450 179.29650}
gui_select -toggle -point {79.66450 179.38000}
gui_select -toggle -point {91.41550 179.42200}
gui_select -toggle -point {92.08450 179.46400}
gui_select -toggle -point {103.37600 179.54750}
gui_select -toggle -point {103.96100 179.46400}
gui_select -toggle -point {115.61700 179.29650}
gui_select -toggle -point {116.07700 179.38000}
gui_select -toggle -point {127.36800 179.46400}
gui_select -toggle -point {128.07900 179.42200}
gui_select -toggle -point {139.49550 179.54750}
gui_select -toggle -point {140.29000 179.29650}
gui_select -toggle -point {151.31800 179.38000}
gui_select -toggle -point {152.15450 179.54750}
gui_select -toggle -point {163.48750 179.46400}
gui_select -toggle -point {164.19850 179.46400}
gui_select -toggle -point {175.56100 179.38000}
gui_select -toggle -point {176.10500 179.50550}
gui_select -toggle -point {187.52150 179.38000}
gui_select -toggle -point {188.06500 179.33850}
gui_select -toggle -point {199.59900 179.38000}
gui_select -toggle -point {200.10100 179.46400}
delete_selected_from_floorplan
source ../scripts/init.tcl 
source ../scripts/cts.tcl 
source ../scripts/postcts.tcl 
source ../scripts/route.tcl 
source ../scripts/postroute.tcl 
write_stream pp_fir_u_3_struct_inn.gds -map_file /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/arm_tech/r1p0/lef/1p9m_6x2z_utalrdl/tech.map -lib_name DesignLib -unit 2000 -mode all
write_netlist pp_fir_u_3_struct_inn.v
set_layer_preference node_layer -is_visible 0
set_layer_preference M8 -is_visible 1
gui_select -point {129.52200 183.77400}
set_layer_preference M7 -is_visible 1
set_layer_preference M6 -is_visible 1
