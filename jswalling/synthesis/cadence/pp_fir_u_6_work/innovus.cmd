#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Tue Jan 21 16:26:46 2025                
#                                                     
#######################################################

#@(#)CDS: Innovus v22.10-p001_1 (64bit) 09/29/2022 11:03 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: NanoRoute 22.10-p001_1 NR220915-0329/22_10-UB (database version 18.20.590) {superthreading v2.19}
#@(#)CDS: AAE 22.10-p002 (64bit) 09/29/2022 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: CTE 22.10-p004_1 () Sep  7 2022 21:57:29 ( )
#@(#)CDS: SYNTECH 22.10-p001_1 () Aug  8 2022 11:26:34 ( )
#@(#)CDS: CPE v22.10-p005
#@(#)CDS: IQuantus/TQuantus 21.2.0-s201 (64bit) Wed Jul 6 19:14:09 PDT 2022 (Linux 3.10.0-693.el7.x86_64)

set_db edit_wire_type regular
read_db INVS/
read_floorplan ../../pp_fir_u_0_power.fp
gui_select -point {7.59850 178.39050}
gui_select -toggle -point {8.31500 178.39050}
gui_select -toggle -point {19.44750 178.39050}
gui_select -toggle -point {20.16450 178.43800}
gui_select -toggle -point {31.58350 178.62900}
gui_select -toggle -point {32.15700 178.53350}
gui_select -toggle -point {43.46650 178.62900}
gui_select -toggle -point {44.13500 178.62900}
gui_select -toggle -point {55.50700 178.43800}
gui_select -toggle -point {56.03250 178.43800}
gui_select -toggle -point {67.64300 178.67700}
gui_select -toggle -point {68.12050 178.67700}
delete_selected_from_floorplan
gui_select -toggle -point {79.57300 178.58150}
gui_select -toggle -point {80.24200 178.48600}
gui_select -toggle -point {91.66150 178.53350}
gui_select -toggle -point {92.23450 178.53350}
gui_select -toggle -point {103.55850 178.53350}
gui_select -toggle -point {104.03650 178.53350}
gui_select -toggle -point {115.63200 178.48600}
gui_select -toggle -point {116.30100 178.48600}
gui_select -toggle -point {127.52900 178.53350}
gui_select -toggle -point {128.29350 178.53350}
gui_select -toggle -point {139.45950 178.48600}
gui_select -toggle -point {140.17600 178.48600}
gui_select -toggle -point {151.50000 178.48600}
gui_select -toggle -point {152.12100 178.48600}
gui_select -toggle -point {163.58800 178.43800}
gui_select -toggle -point {164.25700 178.43800}
gui_select -toggle -point {175.56650 178.39000}
gui_select -toggle -point {176.23500 178.39000}
gui_select -toggle -point {187.46350 178.39000}
gui_select -toggle -point {188.18000 178.43800}
gui_select -toggle -point {199.50400 178.43800}
gui_select -toggle -point {200.22050 178.43800}
delete_selected_from_floorplan
source ../scripts/init.tcl 
source ../scripts/cts.tcl 
source ../scripts/postcts.tcl 
source ../scripts/route.tcl 
source ../scripts/postroute.tcl 
report_power
write_netlist pp_fir_u_6_struct_inn.v
write_stream pp_fir_u_6_struct_inn.gds -map_file /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/arm_tech/r1p0/lef/1p9m_6x2z_utalrdl/tech.map -lib_name DesignLib -unit 2000 -mode all
