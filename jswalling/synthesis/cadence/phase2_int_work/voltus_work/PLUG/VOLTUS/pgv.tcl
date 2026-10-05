#set_advanced_pg_library_mode -common_supply_pins {IO GND VDD} \
   -esd_cells {SMALL_ESDCLAMP_1V0 SMALL_ESDCLAMP_1V0_40UX90U VDDCORE_1V0_3V3SF_CL_LIN VDDCORE_1V0_3V3SF_FC_INNER VDDCORE_1V0_3V3SF_FC_LIN VDDCORE_1V0_SF_CL_LIN VDDCORE_1V0_SF_FC_INNER VDDCORE_1V0_SF_FC_LIN GND_VDD_SF_FC_2ROWS VDDGND_SF_CL_LIN VDDGND_SF_CL_LIN_PHY VDDGND_SF_FC_LIN VDDGND_SF_FC_LIN_PHY VDD_GND_SF_FC_2ROWS }

##qinglong add for test 
# read_lib -lef $vars(lef_files)

eval "set_advanced_pg_library_mode $vars(advanced_pg_library_mode)"


##### qinglong add
#set_advanced_pg_library_mode -default_frequency 400.0e6 -thunder_command_file ../data/voltus/thunder.cmd   (work)
#set_advanced_pg_library_mode -default_frequency $vars(frequency) -thunder_command_file $vars(thunder_file) (work) 

#Tech PGV
set_pg_library_mode -celltype techonly  -extraction_tech_file $vars(extraction_tech_file)  -lef_layermap $vars(lef_layermap)  -default_area_cap 0 -filler_cells {*FILL*}  -decap_cells {*DECAP*}  -current_distribution propagation  -stop@via V1

generate_pg_library -output $vars(pg_dir)

#Macro PGV script example
#You need to fill it and create one script/per Library.
if {[file exists PLUG/VOLTUS/macros_pgv.tcl]} {
source PLUG/VOLTUS/macros_pgv.tcl}

#Power switch PGV script example
#You need to fill it.
if {[file exists PLUG/VOLTUS/power_switch_pgv.tcl]} {
source PLUG/VOLTUS/power_switch_pgv.tcl}

