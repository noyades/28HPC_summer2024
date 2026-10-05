###############################################################################
#                       CADENCE COPYRIGHT NOTICE
#         © 2008-2013 Cadence Design Systems, Inc. All rights reserved.
#------------------------------------------------------------------------------
#
# This Foundation Flow is provided as an example of how to perform specialized
# tasks.
#
# This work may not be copied, re-published, uploaded, or distributed in any way,
# in any medium, whether in whole or in part, without prior written permission
# from Cadence. Notwithstanding any restrictions herein, subject to compliance
# with the terms and conditions of the Cadence software license agreement under
# which this material was provided, this material may be copied and internally
# distributed solely for internal purposes for use with Cadence tools.
#
# This work is Cadence intellectual property and may under no circumstances be
# given to third parties, neither in original nor in modified versions, without
# explicit written permission from Cadence. The information contained herein is
# the proprietary and confidential information of Cadence or its licensors, and
# is supplied subject to, and may be used only by Cadence's current customers
# in accordance with, a previously executed license agreement between Cadence
# and its customer.
#
#------------------------------------------------------------------------------
# THIS MATERIAL IS PROVIDED BY CADENCE "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
# IN NO EVENT SHALL CADENCE BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL
# OR CONSEQUENTIAL DAMAGES HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT  (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  MATERIAL, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
###############################################################################

################################################################################
#                             CDNS FOUNDATION FLOW
#-------------------------------------------------------------------------------
# This is the foundation flow setup file.  It contains all the necessary design
# data to drive all the CDNS foundation flows. Each flow will also require an
# additional configuration file to define flow specific information:
#-------------------------------------------------------------------------------
#    VOLTUS ->   voltus_config.tcl
################################################################################

################################################################################
# Define variables to point data, libraries, reports and scripts
################################################################################
set vars(script_root) SCRIPTS
set vars(plug_root)   PLUG/VOLTUS
set vars(rpt_dir)     RPT
set vars(log_dir)     LOG

set vars(data_root)   "DATA"
set vars(libs_root)   "DATA/libs"

################################################################################
# The following variables are REQUIRED to define
# the design data for the flow. 
# ------------------------------------------------------------------------------
# set vars(edi_db_name)    <EDI_design_path> 
# set vars(load_edi_db)    "true"
# ------------------------------------------------------------------------------
# Below variables for non-EDI design 
# ------------------------------------------------------------------------------
# set vars(netlist)      <verilog netlist file> 
# set vars(def_files)     <def file> 
# set vars(sdc_files)     <timing constraints>
# set vars(design)        <top_design>
# ------------------------------------------------------------------------------
# Ignore undefined cells while loading the design, default is false
# ------------------------------------------------------------------------------
# set vars(ignore_undefined_cell)       "<true/false>"
# set vars(ignore_timing_library_check) "<true/false>";# must be false for power
# ------------------------------------------------------------------------------
# Specify SPEF, if the design is non-MMMC
# ------------------------------------------------------------------------------
# set vars(spef)         <spef only for non-mmmc design>
################################################################################
#set vars(edi_db_name)      $vars(data_root)/srio_mac_assembled.enc
#set vars(load_edi_db)      "true"

set vars(netlist)        ../design/postRouteOpt.enc.dat/super_filter.v.gz
set vars(def_files)       ../design/postRoute.def
set vars(sdc_files)       ../design/base.sdc
set vars(design)          "super_filter"
set vars(spef)            "../design/postRouteOpt_RC_wc_125.spef.gz"

################################################################################
# Supported flows -> default or mmmc
################################################################################
set vars(flow)    "mmmc"

################################################################################
#                        For MMMC Designs
################################################################################
# The following parameter for CPF based MMMC design ONLY
# ------------------------------------------------------------------------------
# set vars(cpf_file)       <CPF_file>
# ------------------------------------------------------------------------------
# The following view definition file will be loaded by "read_view_definition"
# ------------------------------------------------------------------------------
# set vars(view_definition_file) <file>
# ------------------------------------------------------------------------------
# The following parameter is MMMC setup file
# ------------------------------------------------------------------------------
# set vars(mmmc_setup_file)  <view_definations_file>
# ------------------------------------------------------------------------------
# Define rc corners for mmmc design...
# ------------------------------------------------------------------------------
# set vars(rc_corners)     "<corner1> <corner2> ..."
# ------------------------------------------------------------------------------
# set vars(<corner1>,spef) <corner1_spef>
# set vars(<corner2>,spef) <corenr2_spef>
# ------------------------------------------------------------------------------
# Define analysis views for mmmc design...
# ------------------------------------------------------------------------------
# set vars(analysis_views) "<view1> <view2>"
################################################################################
set vars(cpf_file)         ../design/super_filter.cpf
#set vars(view_definition_file) ../design/postRouteOpt.enc.dat/viewDefinition.tcl
#set vars(mmmc_setup_file)  $vars(data_root)/viewDefinition.tcl
#set vars(rc_corners)       "RC_wc_125"
#set vars(RC_wc_125,spef)    "../design/postRouteOpt_RC_wc_125.spef.gz"
#set vars(rc_best,spef)     $vars(data_root)/srio_mac_assembled_rc_best.spef.gz
#set vars(analysis_views)   "setup_view1 hold_view1 setup_view2  hold_view2"

################################################################################
# Define active analysis view
################################################################################
#set vars(active_analysis_view) "<active view>"
#set vars(active_analysis_view) [lindex $vars(analysis_views) 0]

################################################################################
# Define library sets ... REQUIRED for non-EDI database
# ------------------------------------------------------------------------------
# set vars(library_sets) "max min"
# set vars(max,timing) <list of lib files> 
# set vars(min,timing) <list of lib files> 
# ------------------------------------------------------------------------------
# Define LEF files
# set vars(lef_files) <list of lef files> 
# ------------------------------------------------------------------------------
# Define Power-Grid views
# set vars(cl_views) <list of .cl files>
################################################################################
set vars(library_sets) "LS_wc"

#set vars(max,timing) "\
      $vars(libs_root)/nlc13_slow108V125C.lib \
      $vars(libs_root)/TUNC13gLib_slow108V125C.lib \
      $vars(libs_root)/tse_rf256x8p1_slow_syn.lib \
      $vars(libs_root)/tse_ra280x67p2_slow_syn.lib \
"
set vars(LS_wc,timing) [list ../data/libs/slow.lib_ecsm\
    ../data/libs/pll.lib\
    ../data/libs/bufao.lib\
    ../data/libs/pso_header.lib\
    ../data/libs/pso_ring.lib]

set vars(lef_files) "\
 ../data/lef/gsclib090_tech.lef \
../data/lef/gsclib090_macro.lef \
../data/lef/pso_header.lef  \
../data/lef/pso_ring.lef \
../data/lef/pll.lef \
../data/lef/decap.lef
 "
set vars(cl_views) "\
     FFtest_techonly/techonly.cl FFtest_stdcells/stdcells.cl FFtest_macros/macros_pll.cl
"
################################################################################
# Define PGV sets ... REQUIRED for creation of Power Grid 
# ------------------------------------------------------------------------------
# Below variables are for common pg creation
# ------------------------------------------------------------------------------
# set vars(extraction_tech_file) 	 <technology file>
# set vars(lef_layermap)	  	 "<file>" 
# ------------------------------------------------------------------------------
# Specify advanced options of command "set_advanced_pg_library_mode", like "-default_frequency"
# ------------------------------------------------------------------------------
# set vars(advanced_pg_library_mode)	"<advanced options>" ;
# ------------------------------------------------------------------------------
# Below variables are for techonly pg 
# ------------------------------------------------------------------------------
# set vars(techonly_pg_creation) 	"<true/false>"       ;# set to true if you want to create techonly pg
# set vars(techonly_ground_pins)	"<ground_pin_list>"
# set vars(techonly_power_pins) 	"<pin1 voltage1 ... pinN voltageN>"
# set vars(techonly_other_options)	"<other options>"    ;# specify optional options like "-temperature <>"
# set vars(techonly_outdir) 		"<dir_name>"  
# set vars(techonly_prefix) 		"<prefix>"           ;# the file name will be prefix_techonly.cl (default: techonly.cl)
# ------------------------------------------------------------------------------
# Below variables are for std cells
# ------------------------------------------------------------------------------
# set vars(stdcells_pg_creation)  	"<true/false>"    ;# set to true if you want to create stdcells pg
# set vars(stdcells_ground_pins)	"<ground_pin_list>"
# set vars(stdcells_power_pins) 	"<pin1 voltage1 ... pinN voltageN>"
# set vars(stdcells_spice_models)	"<file_list>"     ;
# set vars(stdcells_spice_subckts)	"<file_list>"
# set vars(stdcells_other_options)	"<other options>" ;# specify optional options like "-powergate_parameters" "-decap_cells" "-current_distribution" 
# set vars(stdcells_outdir)		"<dir_name>"
# set vars(stdcells_prefix) 		"<prefix>"        ;# the file name will be prefix_stdcells.cl (default: stdcells.cl)
# ------------------------------------------------------------------------------
# Below variables are for macro cells
# ------------------------------------------------------------------------------
# set vars(macros_pg_creation)          "<true/false>"
# set vars(macros_ground_pins)		"<ground_pin_list>"
# set vars(macros_power_pins) 		"<pin1 voltage1 ... pinN voltageN>"
# set vars(macros_cell_list_file)	"<built_cells_list>"
# set vars(macros_gds_files)		"<gds_file_list>"
# set vars(macros_gds_layermap)		"<gds_layermap_file>"
# set vars(macros_spice_models)		"<file_list>"
# set vars(macros_spice_subckts)	"<file_list>"
# set vars(macros_other_options)	"<other options>" ;# specify optional options like "-powergate_parameters" "-spice_corners" "-current_distribution"
# set vars(macros_outdir)		"<dir_name>"
# set vars(macros_prefix) 		"<prefix>"        ;# the file name will be prefix_cellname.cl (default: macros_cellname.cl)
# ------------------------------------------------------------------------------
################################################################################
set vars(extraction_tech_file) 		"../data/qrc/gpdk090_9l.tch"

set vars(lef_layermap)	  	 "../data/eps/lefdef.layermap" 
set vars(advanced_pg_library_mode)	"-default_frequency    400.0e6 -thunder_command_file ../data/eps/thunder.cmd" 
# -----------------------------------------------------------
set vars(techonly_pg_creation) true
set vars(techonly_other_options) "-temperature 25 -decap_cells  {DECAP8 DECAP64 DECAP4 DECAP32 DECAP2 DECAP16 DECAP1} -filler_cells {FILL8 FILL64 FILL4 FILL32 FILL2 FILL16 FILL1 } -cell_decap_file ../data/eps/decap.cmd -current_distribution propagation"
set vars(techonly_outdir) 	"FFtest_techonly"
set vars(techonly_ground_pins)			 "VSS"
set vars(techonly_power_pins) 			 "VDD .9 VDDG .9 TVDD .9"

 set vars(stdcells_pg_creation)  	"true"    ;# set to true if you want to create stdcells pg
 set vars(stdcells_spice_models)	"../data/netlists/spectre_load.sp"     ;
 set vars(stdcells_spice_subckts)	"../data/netlists/gsclib090.sp"
 set vars(stdcells_other_options)	"-decap_cells {DECAP8 DECAP64 DECAP4 DECAP32 DECAP2 DECAP16 DECAP1 } -filler_cells { FILL8 FILL64 FILL4 FILL32 FILL2 FILL16 FILL1 } -current_distribution propagation -cell_decap_file ../data/eps/decap.cmd -temperature 25" ;# specify optional options like "-powergate_parameters" "-decap_cells" "-current_distribution" 
 set vars(stdcells_outdir)		"FFtest_stdcells"
set vars(stdcells_ground_pins)			 "VSS"
set vars(stdcells_power_pins) 			 "VDD .9"

 set vars(macros_pg_creation)          "true"
 set vars(macros_cell_list_file)	"../data/eps/macro.list"
 set vars(macros_gds_files)		"../data/gds/pll.gds"
 set vars(macros_gds_layermap)		"../data/eps/gds.layermap"
 set vars(macros_spice_models)		"../data/netlists/spectre_load.sp"
 set vars(macros_spice_subckts)		"../data/netlists/pll.sp"
 set vars(macros_other_options)		"-temperature 25 -stop@via CONT -current_distribution propagation" ;# specify optional options like "-powergate_parameters" "-spice_corners" "-current_distribution"
 set vars(macros_outdir)		"FFtest_macros"
set vars(macros_ground_pins)			 "VSS"
set vars(macros_power_pins) 			 "VDD .9"

Puts "<FF> Finished loading setup.tcl"
