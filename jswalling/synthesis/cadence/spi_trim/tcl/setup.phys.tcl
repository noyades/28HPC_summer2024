# ********************************************************
# * Script Name : Genus Initialization Script
# ********************************************************

set LOCAL_DIR "[exec pwd]/.."
set SYNTH_DIR    ${LOCAL_DIR}/work
set TCL_PATH     ${LOCAL_DIR}/tcl
set REPORTS_PATH ${LOCAL_DIR}/work/reports

set LIB_PATH "/software/RFIC/PDK/globalFoundries/22FDX-EXT/std_cells/v-logic_gf22nsdvlogl28edl116a/DesignWare_logic_libs/globalfoundaries22nhsda/28hd/edl/ulvt/latest/lef /software/RFIC/PDK/globalFoundries/22FDX-EXT/std_cells/v-logic_gf22nsdvlogl28edl116a/DesignWare_logic_libs/globalfoundaries22nhsda/28hd/edl/ulvt/latest/liberty"

set RTL_PATH {../rtl}
set top_module "topPLLDigital"
set MODULE $top_module

set MSGS_TO_BE_SUPPRESSED {LBR-30 LBR-31 LBR-58 LBR-40 LBR-41 LBR-83 VLOGPT-35}

set SYN_EFFORT high
set MAP_EFFORT high
set INC_EFFORT high

set THE_DATE   [exec date +%m%d.%H%M]

# ********************************************************
# * Display the system info and Start Time
# ********************************************************

puts "The Output file PREFIX is ${THE_DATE} \n"

# ********************************************************
# * Define the Diagnostic Variables 
# ********************************************************
set iopt_stats 1
set map_fancy_names 1

# ********************************************************
# * Define Tool Setup and Compatibility
# ********************************************************
set_db information_level 9
set_db tns_opto false

# ********************************************************
# * Strain out extraneous messages
# ********************************************************
suppress_messages $MSGS_TO_BE_SUPPRESSED

set_db lp_power_unit uW
set_db init_lib_search_path ${LIB_PATH}
set_db init_hdl_search_path ${RTL_PATH}
set_db script_search_path ${TCL_PATH}
set_db hdl_track_filename_row_col true

echo on
