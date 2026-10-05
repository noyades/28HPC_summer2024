#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Mon Jan 20 22:26:25 2025                
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
gui_select -point {7.60000 179.31550}
gui_select -append -point {8.13200 179.35100}
gui_select -append -point {19.58100 179.42150}
gui_select -append -point {20.21900 179.45700}
gui_select -append -point {31.37350 179.38600}
gui_select -append -point {32.15350 179.49250}
gui_select -append -point {43.46100 179.42150}
gui_select -append -point {44.34700 179.45700}
gui_select -append -point {55.50200 179.52800}
gui_select -append -point {56.24600 179.31500}
gui_select -append -point {67.44750 179.49250}
gui_select -append -point {68.15650 179.45700}
gui_select -append -point {91.39500 179.45700}
gui_select -append -point {92.24550 179.45700}
gui_select -append -point {103.41150 179.56350}
gui_select -append -point {104.08500 179.59850}
gui_select -append -point {115.52300 179.45700}
gui_select -append -point {116.16100 179.49250}
gui_select -append -point {127.36250 179.42150}
gui_select -append -point {128.07150 179.56350}
gui_select -append -point {139.51350 179.35050}
gui_select -append -point {140.08050 179.52800}
delete_selected_from_floorplan
gui_select -append -point {151.41600 179.42150}
gui_select -append -point {152.05400 179.45700}
gui_select -append -point {163.43250 179.35050}
gui_select -append -point {164.14150 179.45700}
gui_select -append -point {175.54450 179.45700}
gui_select -append -point {176.11150 179.52800}
gui_select -append -point {187.56100 179.52800}
gui_select -append -point {188.16350 179.45700}
delete_selected_from_floorplan
gui_select -append -point {199.60550 178.50000}
gui_select -append -point {200.20800 178.53550}
delete_selected_from_floorplan
gui_select -rect {74.91900 181.74400 84.77100 174.97100}
gui_select -rect {75.53500 184.82250 85.07900 169.42950}
gui_select -point {-9.74400 169.12150}
gui_select -point {79.50950 178.65000}
gui_select -append -point {80.10700 178.65000}
delete_selected_from_floorplan
source ../scripts/init.tcl 
source ../scripts/cts.tcl 
source ../scripts/postcts.tcl 
source ../scripts/route.tcl 
source ../scripts/postroute.tcl 
write_netlist pp_fir_u_5_struct_inn.v
write_stream pp_fir_u_5_struct_inn.gds -map_file /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/arm_tech/r1p0/lef/1p9m_6x2z_utalrdl/tech.map -lib_name DesignLib -unit 2000 -mode all
exit
