#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Fri Jan 16 15:02:23 2026                
#                                                     
#######################################################

#@(#)CDS: Innovus v23.14-s088_1 (64bit) 02/28/2025 12:25 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: NanoRoute 23.14-s088_1 NR250219-0822/23_14-UB (database version 18.20.661) {superthreading v2.20}
#@(#)CDS: AAE 23.14-s018 (64bit) 02/28/2025 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: CTE 23.14-s036_1 () Feb 22 2025 01:17:26 ( )
#@(#)CDS: SYNTECH 23.14-s010_1 () Feb 19 2025 23:56:49 ( )
#@(#)CDS: CPE v23.14-s082
#@(#)CDS: IQuantus/TQuantus 23.1.1-s336 (64bit) Mon Jan 20 22:11:00 PST 2025 (Linux 3.10.0-693.el7.x86_64)

read_db INVS/
source ../scripts/init.tcl 
source ../scripts/cts.tcl 
report_timing
source ../scripts/postcts.tcl 
report_timing
source ../scripts/route.tcl 
set_db add_fillers_cells {{} {FILLSGCAP128_A9PP140ZTL_C30 \
FILLSGCAP16_A9PP140ZTUL_C30 FILLSGCAP2_A9PP140ZTUL_C30 \
FILLSGCAP32_A9PP140ZTUL_C30 FILLSGCAP3_A9PP140ZTUL_C30 \
FILLSGCAP4_A9PP140ZTUL_C30 FILLSGCAP64_A9PP140ZTUL_C30 \
FILLSGCAP8_A9PP140ZTUL_C30} \
{FILL8_A9PP140ZTUL_C30 FILL64_A9PP140ZTUL_C30 \
FILL4_A9PP140ZTUL_C30 FILL3_A9PP140ZTUL_C30 \
FILL32_A9PP140ZTUL_C30 FILL2_A9PP140ZTUL_C30 \
FILL1_A9PP140ZTUL_C30 FILL16_A9PP140ZTUL_C30 \
FILL128_A9PP140ZTUL_C30}}
set_db route_design_antenna_cell_name ANTENNA2_A9PP140ZTUL_C30
add_fillers
source ../scripts/postroute.tcl 
source ../scripts/route.tcl 
exit
