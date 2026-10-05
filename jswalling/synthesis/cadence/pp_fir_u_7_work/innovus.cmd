#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Wed Jan 22 05:03:50 2025                
#                                                     
#######################################################

#@(#)CDS: Innovus v22.10-p001_1 (64bit) 09/29/2022 11:03 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: NanoRoute 22.10-p001_1 NR220915-0329/22_10-UB (database version 18.20.590) {superthreading v2.19}
#@(#)CDS: AAE 22.10-p002 (64bit) 09/29/2022 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: CTE 22.10-p004_1 () Sep  7 2022 21:57:29 ( )
#@(#)CDS: SYNTECH 22.10-p001_1 () Aug  8 2022 11:26:34 ( )
#@(#)CDS: CPE v22.10-p005
#@(#)CDS: IQuantus/TQuantus 21.2.0-s201 (64bit) Wed Jul 6 19:14:09 PDT 2022 (Linux 3.10.0-693.el7.x86_64)

read_db
read_db INVS/
read_floorplan ../../pp_fir_u_0_power.fp
gui_select -point {7.49150 178.45600}
gui_select -toggle -point {8.33050 178.45600}
gui_select -toggle -point {19.42100 178.54900}
gui_select -toggle -point {20.16650 178.50250}
gui_select -toggle -point {31.49000 178.64250}
gui_select -toggle -point {32.28200 178.54900}
gui_select -toggle -point {43.55800 178.51900}
gui_select -toggle -point {44.18800 178.51900}
gui_select -toggle -point {55.57450 178.51900}
gui_select -toggle -point {56.24950 178.60900}
gui_select -toggle -point {67.59050 178.56400}
gui_select -toggle -point {68.22100 178.56400}
gui_select -toggle -point {79.50300 178.51900}
gui_select -toggle -point {80.26800 178.51900}
gui_select -toggle -point {91.42950 178.47400}
gui_select -toggle -point {92.23950 178.51900}
gui_select -toggle -point {103.49100 178.65400}
gui_select -toggle -point {104.21100 178.60900}
gui_select -toggle -point {115.53350 177.70900}
gui_select -toggle -point {116.16350 177.61900}
gui_select -toggle -point {127.64000 177.75400}
gui_select -toggle -point {128.31500 177.61900}
gui_select -toggle -point {139.47600 177.52900}
gui_select -toggle -point {140.24100 177.52900}
gui_select -toggle -point {151.52350 177.52900}
gui_select -toggle -point {152.28850 177.61900}
gui_select -toggle -point {163.54000 177.61900}
gui_select -toggle -point {164.44000 177.57400}
gui_select -toggle -point {164.57500 177.52900}
gui_select -toggle -point {164.57500 177.52900}
gui_select -toggle -point {164.30500 178.51900}
delete_selected_from_floorplan
gui_select -toggle -point {175.31300 178.45550}
gui_select -toggle -point {176.18900 178.58700}
gui_select -toggle -point {187.44850 178.58700}
gui_select -toggle -point {188.10550 178.58700}
gui_select -toggle -point {199.40850 178.63100}
gui_select -toggle -point {200.10950 178.63100}
gui_select -toggle -point {197.30600 178.58700}
delete_selected_from_floorplan
source ../scripts/init.tcl 
source ../scripts/cts.tcl 
source ../scripts/postcts.tcl 
source ../scripts/route.tcl 
source ../scripts/postroute.tcl 
write_netlist pp_fir_u_7_struct_inn.v
write_stream pp_fir_u_7_struct_inn.gds -map_file /software/RFIC/PDK/tsmc/28nm/stdcells/arm/tsmc/cln28ht/arm_tech/r1p0/lef/1p9m_6x2z_utalrdl/tech.map -lib_name DesignLib -unit 2000 -mode all
