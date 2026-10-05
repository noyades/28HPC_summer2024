#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Thu Jan 16 00:47:26 2025                
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
gui_select -point {15.12350 178.46300}
gui_select -append -point {15.71300 178.73100}
gui_select -append -point {45.19650 178.67700}
gui_select -append -point {45.57150 178.51650}
delete_selected_from_floorplan
gui_select -point {75.11900 178.73400}
gui_select -toggle -point {75.56150 178.55200}
gui_select -toggle -point {105.06150 177.71850}
gui_select -toggle -point {105.71250 177.71850}
gui_select -point {97.77150 184.48800}
gui_select -point {75.06700 178.63000}
gui_select -toggle -point {75.58750 178.60400}
gui_select -toggle -point {105.03550 177.64050}
gui_select -toggle -point {105.53050 177.66650}
gui_select -toggle -point {134.95200 178.63000}
gui_select -toggle -point {135.44700 178.68200}
gui_select -toggle -point {164.92100 178.70800}
gui_select -toggle -point {165.52000 178.65600}
gui_select -toggle -point {194.99400 178.57800}
gui_select -toggle -point {195.41050 178.57800}
delete_selected_from_floorplan
read_floorplan ../../pp_fir_u_0_power.fp
gui_select -point {7.48100 178.50300}
gui_select -toggle -point {8.13750 178.40950}
gui_select -toggle -point {19.58300 178.50300}
gui_select -toggle -point {20.28650 178.59700}
gui_select -toggle -point {31.49700 178.59700}
gui_select -toggle -point {32.10700 178.64400}
gui_select -toggle -point {43.41150 178.55000}
gui_select -toggle -point {44.39650 178.55000}
gui_select -toggle -point {55.41950 178.50300}
gui_select -toggle -point {56.35750 178.69050}
gui_select -toggle -point {67.66200 178.50300}
gui_select -toggle -point {68.17800 178.59700}
gui_select -toggle -point {79.52950 177.61200}
gui_select -toggle -point {80.32700 177.70550}
gui_select -toggle -point {91.44400 177.70550}
gui_select -toggle -point {92.19450 177.56500}
gui_select -toggle -point {103.40500 177.61200}
gui_select -toggle -point {104.20250 177.70550}
gui_select -toggle -point {115.36600 177.61200}
gui_select -toggle -point {116.16350 177.70550}
gui_select -toggle -point {127.51500 177.75250}
gui_select -toggle -point {128.17200 177.79950}
gui_select -toggle -point {139.42950 177.65900}
gui_select -toggle -point {140.32050 177.65900}
gui_select -toggle -point {151.53100 177.61200}
gui_select -toggle -point {152.42250 177.65900}
gui_select -toggle -point {152.18800 176.86150}
delete_selected_from_floorplan
gui_select -toggle -point {163.62800 178.55350}
gui_select -toggle -point {164.19800 178.72450}
gui_select -toggle -point {175.40550 178.66750}
gui_select -toggle -point {176.26100 178.61050}
gui_select -toggle -point {187.52500 178.61050}
gui_select -toggle -point {188.20950 178.66750}
gui_select -toggle -point {199.50250 178.61050}
gui_select -toggle -point {200.21550 178.61050}
delete_selected_from_floorplan
source ../scripts/init.tcl 
source ../scripts/cts.tcl 
source ../scripts/postcts.tcl 
source ../scripts/route.tcl 
source ../scripts/postroute.tcl 
exit
