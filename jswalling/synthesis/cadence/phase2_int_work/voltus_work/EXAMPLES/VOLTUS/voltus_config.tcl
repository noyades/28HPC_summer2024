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
# VOLTUS ANALYSIS variables, make "true" to run the flows
# If vars(generate_pg) == "true", PG library generation flow will be added before
# any pwoer/rail analysis
# If vars(pg_only) == "true", Only PG library generation flow will run.
################################################################################
#set vars(generate_pg)		 "true"
#set vars(pg_only)		 "true"
set vars(static_power)           "true"
#set vars(static_rail)            "true"
set vars(dynamic_power)          "true"
set vars(dynamic_rail)           "true"

################################################################################
#                       POWER ANALYSIS PARAMETERS
################################################################################
# Specify the Global switching activity for all primary inputs, nets, and
# other instances whose activity has not been defined through TCF or VCD files
#
# The following are the options to define the switching activity of the design
# ------------------------------------------------------------------------------
# set vars(input_activity)       "<primary input activity>" (OPTIONAL)
# set vars(seq_activity)         "<activity at sequential logic output>" (OPTIONAL)
# set vars(global_activity)      "<activity for all unset nodes>" (OPTIONAL)
################################################################################
#set vars(input_activity) "0.25"
#set vars(seq_activity)   "0.25"

###############################################################################
#                        POWER OUTPUT DIRECTORY (OPTIONAL)
###############################################################################
# Specify the directory PATH to write the power reports
# and more important, current files
# For both the static & dynamic
#
# The default directory for static power analysis: $vars(rpt_dir)/static_power
# The default directory for dynamic power analysis: $vars(rpt_dir)/dynamic_power
# ------------------------------------------------------------------------------
# set vars(static_power_reports)   "<static_power_directory_name>"  (OPTIONAL)
# set vars(dynamic_power_reports)  "<dynamic_power_directory_name>" (OPTIONAL)
###############################################################################
#set vars(static_power_reports)       "RPT/STATIC_POWER"
#set vars(dynamic_power_reports)      "RPT/DYNAMIC_POWER"

################################################################################
#                        STATIC POWER CALCULATION
################################################################################
# specify the power analysis view for MMMC design
#-------------------------------------------------------------------------------
# set vars(static_power,analysis_view) "$vars(active_analysis_view)"
# ------------------------------------------------------------------------------
# For non-MMMC design, define the power analysis library corner, default:max
# ------------------------------------------------------------------------------
# set vars(static_power,corner) "min/max"
# ------------------------------------------------------------------------------
# set true to create power analysis binary db, default:false
# ------------------------------------------------------------------------------
# set vars(static_power,create_binary_db) "true/false"
# ------------------------------------------------------------------------------
# set the transition time method, default:max
# ------------------------------------------------------------------------------
# set vars(static_power,transition_time_method) "min/avg/max"
# ------------------------------------------------------------------------------
# To write the static current files, default:false
# ------------------------------------------------------------------------------
# set vars(static_power,write_static_currents) "true/false"
################################################################################
#set vars(static_power,analysis_view) AV_wc_on
set vars(static_power,write_static_currents) "true"
set vars(static_power,create_binary_db) "true"

################################################################################
#                       DYNAMIC POWER CALCULATION
################################################################################
# Specify the method of analysis to be performed, default:dynamic_vectorless
# ------------------------------------------------------------------------------
# set vars(dynamic_power,method) "dynamic_vectorless/dynamic_vectorbased"
#-------------------------------------------------------------------------------
# specify the power analysis view for MMMC setup
#-------------------------------------------------------------------------------
# set vars(dynamic_power,analysis_view) "$vars(active_analysis_view)"
# ------------------------------------------------------------------------------
# For non-MMMC designs define the library corner, default:max
# ------------------------------------------------------------------------------
# set vars(dynamic_power,corner) "min/max"
# ------------------------------------------------------------------------------
# set true to create power analysis binary db, default:false
# ------------------------------------------------------------------------------
# set vars(dynamic_power,create_binary_db) "true/false"
# ------------------------------------------------------------------------------
# set the transition time method, default:max
# ------------------------------------------------------------------------------
# set vars(dynamic_power,transition_time_method) "min/avg/max"
# ------------------------------------------------------------------------------
# To perform Static Power Analysis during Dynamic, default:true
# ------------------------------------------------------------------------------
# set vars(dynamic_power,disable_static) "true/false"
# ------------------------------------------------------------------------------
# To write the static current files, default:false
# ------------------------------------------------------------------------------
# set vars(dynamic_power,write_static_currents) "true/false"
################################################################################
#set vars(dynamic_power,analysis_view)   $vars(active_analysis_view)
#set vars(dynamic_power,method) "dynamic_vectorbased"

################################################################################
#          POWER INCLUDE FILE FOR DYNAMIC POWER CALCULATION (OPTIONAL)
################################################################################
# All additional PowerMeter options can be given through this include file.
# ------------------------------------------------------------------------------
# set vars(dynamic_power_inc_file) "<power_include_file.inc>"
################################################################################
#set vars(dynamic_power_inc_file) $vars(script_root)/dynamic_power.inc

################################################################################
#                COMMON PARAMETERS REQUIRED FOR RAIL ANALYSIS
################################################################################
# Specify the analysis Temporary Directory PATH
#-------------------------------------------------------------------------------
# set vars(rail_analysis_temp_dir)  "./tmp"
#-------------------------------------------------------------------------------
# Specify the power domains in the design, if
#-------------------------------------------------------------------------------
# set vars(power_domains)    "<domain1 domain2>"
#-------------------------------------------------------------------------------
# specify list of Power & Ground nets under each power domain (REQUIRED)
#-------------------------------------------------------------------------------
# set vars(<domain1>,pwr_nets) "<pwr_net1 pwr_net2 ...>"
# set vars(<domain2>,pwr_nets) "<pwr_net1 pwr_net2 ...>"
#
# set vars(<domain1>,gnd_nets) "<gnd_net1 gnd_net2 ...>"
# set vars(<domain2>,gnd_nets) "<gnd_net1 gnd_net2 ...>"
#-------------------------------------------------------------------------------
# specify list of Power & Ground nets under each power domain, default all pwr_nets/gnd_nets will be analyzed (OPTIONAL)
#-------------------------------------------------------------------------------
# set vars(<domain1>,analyze_pwr_nets) "<pwr_net1 pwr_net2 >"
# set vars(<domain2>,analyze_gnd_nets) "<gnd_net1 gnd_net2 >"
#-------------------------------------------------------------------------------
# specify the supply voltage for the POWER nets
#-------------------------------------------------------------------------------
# set vars(<pg_net1>,voltage) "<supply_voltage>"
# set vars(<pg_net2>,voltage) "<supply_voltage>"
#-------------------------------------------------------------------------------
# Specify the voltage threshold in per-centage (OPTIONAL) default is 5
#-------------------------------------------------------------------------------
# set vars(threshold_percent) "<threshold_percent>"
#-------------------------------------------------------------------------------
# specify the threshold voltage per P/G net (OPTIONAL) else tool evaluates
#-------------------------------------------------------------------------------
# set vars(<pg_net1>,threshold)   "<user_specified_threshold_value>"
# set vars(<pg_net2>,threshold)   "<user_specified_threshold_value>"
#-------------------------------------------------------------------------------
# Specify power supply tolerance in per-centage (OPTIONAL) default is 30
#-------------------------------------------------------------------------------
# set vars(supply_tolerance_percent) "<supply_tolerance>"
#-------------------------------------------------------------------------------
# specify the supply tolerance per P/G net (OPTIONAL) else tool evaluates
#-------------------------------------------------------------------------------
# set vars(<pg_net1>,tolerance)   "<user_specified_tolerance_value>"
# set vars(<pg_net2>,tolerance)   "<user_specified_tolerance_value>"
################################################################################
set vars(rail_analysis_temp_dir)     "./tmp"
set vars(power_domains)              "domain1"

set vars(domain1,pwr_nets)           "VDD_AO VDD_external VDD_ring VDD_column"
set vars(domain1,analyze_pwr_nets)   "VDD_AO VDD_external"
set vars(domain1,gnd_nets)           "VSS"
set vars(domain1,analyze_gnd_nets)	"VSS"
set vars(VDD_AO,voltage)               0.9
set vars(VDD_external,voltage)               0.9
set vars(VDD_ring,voltage)               0.9
set vars(VDD_column,voltage)               0.9
set vars(VDD_AO,threshold)	0.85
#set vars(threshold_percent)           2.5
#set vars(supply_tolerance_percent)    40

################################################################################
#                     STATIC RAIL ANALYSIS PARAMETERS
################################################################################
# specify the list of power domains to be analyzed for Static Rail (REQUIRED)
#-------------------------------------------------------------------------------
# set vars(static_rail,analyze_domains) "<domain1 domain2 ....>"
#-------------------------------------------------------------------------------
# specify the type of rail analysis to be performed, default:domain
#-------------------------------------------------------------------------------
# set vars(static_rail,analyze_type)   "<net/domain>"
#-------------------------------------------------------------------------------
# specify the accuracy of the analysis, default:hd
#-------------------------------------------------------------------------------
# set vars(static_rail,accuracy)        "xd/hd"
#-------------------------------------------------------------------------------
# specify the analysis view for MMMC designs only
#-------------------------------------------------------------------------------
# set vars(static_rail,analysis_view) "$vars(active_analysis_view)"
#-------------------------------------------------------------------------------
# Specify the analysis Temperature, default:25
#-------------------------------------------------------------------------------
# set vars(static_rail,temperature)     "<user_set_temp>"
#-------------------------------------------------------------------------------
# Enable parellel distributed process for solver, default:false (OPTIONAL)
#-------------------------------------------------------------------------------
# set vars(static_rail,dist_solver_processing) "true/false"
#-------------------------------------------------------------------------------
# write the block boundary interface nodes voltage to the file specified (OPTIONAL)
#-------------------------------------------------------------------------------
# set vars(static_rail,gen_bb_voltage_file) "<list of instance names>"
#-------------------------------------------------------------------------------
# ignore shorts during signoff mode of analysis, default:false (OPTIONAL)
#-------------------------------------------------------------------------------
# set vars(static_rail,ignore_shorts) "true/false"
#-------------------------------------------------------------------------------
# cells to be ignored during rail analysis (OPTIONAL)
#-------------------------------------------------------------------------------
# set vars(static_rail,cell_ignore_file)   "<cell_ignore_file>"
#-------------------------------------------------------------------------------
# list of fast PGVs to be used for rail analysis (OPTIONAL)
#-------------------------------------------------------------------------------
# set vars(static_rail,fast_views_list)   "<fast_views_cell_file>"
#-------------------------------------------------------------------------------
# list of fast_accurate PGVs to be used for rail analysis (OPTIONAL)
#-------------------------------------------------------------------------------
# set vars(static_rail,fast_accurate_views_list)   "<fast_accurate_views_cell_file>"
#-------------------------------------------------------------------------------
# list of accurate PGVs to be used for rail analysis (OPTIONAL)
#-------------------------------------------------------------------------------
# set vars(static_rail,accurate_views_list)   "<accurate_views_cell_file>"
#-------------------------------------------------------------------------------
# specify extractor include file to control ZX extractor (OPTIONAL)
#-------------------------------------------------------------------------------
# set vars(static_rail,ext_inc_file)    "<extractor_include_file>"
#-------------------------------------------------------------------------------
# Disable analysis types (OPTIONAL)
#-------------------------------------------------------------------------------
# set vars(static_rail,dis_analysis_types) "<list analysis types to be disabled>"
#-------------------------------------------------------------------------------
# Specify pti current files for all the PG nets (OPTIONAL)
#-------------------------------------------------------------------------------
# set vars(static_rail,<pwr_net1>,pti_file)     "<pti_current_file>"
#-------------------------------------------------------------------------------
# Specify ascii format instance power file (OPTIONAL)
#-------------------------------------------------------------------------------
# set vars(static_rail,<pwr_net1>,ascii_file)     "<ascii_file>"
#-------------------------------------------------------------------------------
# Specify scaling of the power/curent data provided (OPTIONAL) default is 1.00
#-------------------------------------------------------------------------------
# set vars(static_rail,<pwr_net1>,scale)     "<real_number>"
################################################################################
set vars(static_rail,analyze_domains)       "domain1"
#set vars(static_rail,analyze_type)          "net"
#set vars(static_rail,analysis_view)         AV_wc_on
#set vars(static_rail,accuracy)              "hd"
#set vars(static_rail,temperature)           "125"
#set vars(static_rail,vdd\!,scale)           "5.00"
#set vars(static_rail,gnd\!,scale)           "10.00"
#set vars(static_rail,gnd\!,pti_file)        $vars(rpt_dir)/STATIC_POWER/static_gnd\!.ptiavg
#set vars(static_rail,vdd\!,ascii_file)      $vars(rpt_dir)/static_power/Instance_pin_power.rpt
#set vars(static_rail,ext_inc_file)           ./extractor_include_file.txt

################################################################################
#          VSTORM INCLUDE FILE FOR STATIC RAIL ANALYSIS (OPTIONAL)
################################################################################
# The vstorm include file with an additional VSTORM options, which are
# not supported by present version of VOLTUS.
# All additional VSTORM options can be given though this include file.
# The VSTORM options included before the "analyze_rail"
# ------------------------------------------------------------------------------
# set vars(static_rail,vstorm2_begin_file) "<vstorm_begin_file.inc>"
# ------------------------------------------------------------------------------
# The VSTORM options included after the "analyze_rail"
# ------------------------------------------------------------------------------
# set vars(static_rail,vstorm2_end_file) "<vstorm_end_file.inc>"
################################################################################
# set vars(static_rail,vstorm2_begin_file) "<vstorm_begin_file.inc>"
# set vars(static_rail,vstorm2_end_file)   "<vstorm_end_file.inc>"

################################################################################
#                  ELECTROMIGRATION (EM) MODEL FILE (OPTIONAL)
################################################################################
# This file is required for electromigration(em)/current_density(rj) analysis
# ------------------------------------------------------------------------------
# set vars(em_models_file) "<em_models_file>"
#-------------------------------------------------------------------------------
# Specify qrcTechFile with EM model inside to run EM analysis (advanced node)
#-------------------------------------------------------------------------------
# set vars(rail_extraction_tech_file)  "<qrcTechFile>"
################################################################################

################################################################################
#                        POWER PADS LOCATION FILES
################################################################################
# Specify the format of the pad locations "defpin/xy/padcell/boundary"
#-------------------------------------------------------------------------------
# set vars(<pg_net1>,format)          "defpin"
#-------------------------------------------------------------------------------
# Specify the power pad location files of all the analysis nets
#-------------------------------------------------------------------------------
# set vars(<pg_net1>,pad_file) "<net1_pp_location_file1.pp \
#                              net1_pp_location_file2.pp \
#                              net1_pp_location_file3.pp>"
# set vars(<pg_net2>,pad_file) "<net2_pp_location_file1.pp \
#                              net2_pp_location_file2.pp \
#                              net2_pp_location_file3.pp>"
#-------------------------------------------------------------------------------
################################################################################
set vars(VDD_AO,format)   "xy"
set vars(VDD_AO,pad_file) 	"../design/super_filter_VDD_AO.pp"
set vars(VDD_external,format)   "xy"
set vars(VDD_external,pad_file) 	"../design/super_filter_VDD_external.pp"
set vars(VSS,format)   "xy"
set vars(VSS,pad_file)		"../design/super_filter_VSS.pp"

################################################################################
#                     DYNAMIC RAIL ANALYSIS PARAMETERS
################################################################################
# specify the list of power domains to be analyzed for Dynamic Rail (REQUIRED)
#-------------------------------------------------------------------------------
# set vars(dynamic_rail,analyze_domains) "<domain1 domain2 ....>"
#-------------------------------------------------------------------------------
# specify the type of rail analysis to be performed, default:domain
#-------------------------------------------------------------------------------
# set vars(dynamic_rail,analyze_type) "net/domain"
#-------------------------------------------------------------------------------
# specify the accuracy of the analysis, default:hd
#-------------------------------------------------------------------------------
# set vars(dynamic_rail,accuracy) "xd/hd"
#-------------------------------------------------------------------------------
# specify the analysis view for MMMC designs only
#-------------------------------------------------------------------------------
# set vars(dynamic_rail,analysis_view) "$vars(active_analysis_view)"
#-------------------------------------------------------------------------------
# Specify the analysis Temperature, default:25
#-------------------------------------------------------------------------------
# set vars(dynamic_rail,temperature)  "<user_set_temp>"
#-------------------------------------------------------------------------------
# Enable parellel distributed process for solver, default:false (OPTIONAL)
#-------------------------------------------------------------------------------
# set vars(dynamic_rail,dist_solver_processing) "true/false"
#-------------------------------------------------------------------------------
# Specify the list of powering up nets for dynamic rail and powerup analysis
#-------------------------------------------------------------------------------
# set vars(dynamic_rail,powering_up_nets)  "<switchable_PGnets>"
#-------------------------------------------------------------------------------
# Generate power switch Eco file, default:false (OPTIONAL)
#-------------------------------------------------------------------------------
# set vars(dynamic_rail,gen_power_switch_eco) "true/false"
#-------------------------------------------------------------------------------
# Generate decap Eco file, default:false (OPTIONAL)
#-------------------------------------------------------------------------------
# set vars(dynamic_rail,gen_decap_eco) "true/false"
#-------------------------------------------------------------------------------
# Decap opt method, can be "area/feasibility/timing/removal/feasibility_removal" (OPTIONAL)
#-------------------------------------------------------------------------------
# set vars(dynamic_rail,decap_opt_method) "feasibility"
#-------------------------------------------------------------------------------
# Decap removal method, can be "conservative/aggressive" (OPTIONAL)
#-------------------------------------------------------------------------------
# set vars(dynamic_rail,decap_removal_method) "<user_specified>"
#-------------------------------------------------------------------------------
# save voltage waveforms, can be "true/false" (OPTIONAL)
#-------------------------------------------------------------------------------
# set vars(dynamic_rail,save_voltage_waveforms) "false"
#-------------------------------------------------------------------------------
# write the block boundary interface nodes voltage to the file specified (OPTIONAL)
#-------------------------------------------------------------------------------
# set vars(dynamic_rail,gen_bb_voltage_file) "<list of instance names>"
#-------------------------------------------------------------------------------
# save the current files for dynamic hierchical power_view creation, default:false (OPTIONAL)
#-------------------------------------------------------------------------------
# set vars(dynamic_rail,save_current_files) "true/false"
#-------------------------------------------------------------------------------
# ignore shorts during signoff mode of analysis, default:false (OPTIONAL)
#-------------------------------------------------------------------------------
# set vars(dynamic_rail,ignore_shorts) "true/false"
#-------------------------------------------------------------------------------
# Decap ECO file to be considered for dynamic ir drop analysis (OPTIONAL)
#-------------------------------------------------------------------------------
# set vars(dynamic_rail,decap_eco_file)   "<decap_eco_file>"
#-------------------------------------------------------------------------------
# cells to be ignored during rail analysis (OPTIONAL)
#-------------------------------------------------------------------------------
# set vars(dynamic_rail,cell_ignore_file)   "<cell_ignore_file>"
#-------------------------------------------------------------------------------
# list of fast PGVs to be used for rail analysis (OPTIONAL)
#-------------------------------------------------------------------------------
# set vars(dynamic_rail,fast_views_list)   "<fast_views_cell_file>"
#-------------------------------------------------------------------------------
# list of fast_accurate PGVs to be used for rail analysis (OPTIONAL)
#-------------------------------------------------------------------------------
# set vars(dynamic_rail,fast_accurate_views_list)   "<fast_accurate_views_cell_file>"
#-------------------------------------------------------------------------------
# list of accurate PGVs to be used for rail analysis (OPTIONAL)
#-------------------------------------------------------------------------------
# set vars(dynamic_rail,accurate_views_list)   "<accurate_views_cell_file>"
#-------------------------------------------------------------------------------
# specify extractor include file to control ZX extractor (OPTIONAL)
#-------------------------------------------------------------------------------
# set vars(dynamic_rail,ext_inc_file)    "<extractor_include_file>"
#-------------------------------------------------------------------------------
# Disable analysis types (OPTIONAL)
#-------------------------------------------------------------------------------
# set vars(dynamic_rail,dis_analysis_types) "<list analysis types to be disabled>"
#-------------------------------------------------------------------------------
# Specify pti current files for all the PG nets (OPTIONAL)
#-------------------------------------------------------------------------------
# set vars(dynamic_rail,<pwr_net1>,pti_file)     "<pti_current_file>"
#-------------------------------------------------------------------------------
# Specify scaling of the power/curent data provided (OPTIONAL) default is 1.00
#-------------------------------------------------------------------------------
# set vars(dynamic_rail,<pwr_net1>,scale)     "<real_number>"
################################################################################
set vars(dynamic_rail,analyze_domains)    "domain1"
#set vars(dynamic_rail,analysis_view)      $vars(active_analysis_view)
#set vars(dynamic_rail,accuracy)           "hd"
#set vars(dynamic_rail,temperature)        125
#set vars(dynamic_rail,vdd\!,scale)        "10.00"
#set vars(dynamic_rail,gnd\!,scale)        "10.00"
#set vars(dynamic_rail,cell_ignore_file)   ./cell_ignore_list.txt

################################################################################
#          VSTORM INCLUDE FILE FOR DYNAMIC RAIL ANALYSIS (OPTIONAL)
################################################################################
# The vstorm include file with an additional VSTORM options, which are
# not supported by present version of VOLTUS.
# All additional VSTORM options can be given though this include file.
# The VSTORM options included before the "analyze_rail"
# ------------------------------------------------------------------------------
# set vars(dynamic_rail,vstorm2_begin_file) "<vstorm_begin_file.inc>"
# ------------------------------------------------------------------------------
# The VSTORM options included after the "analyze_rail"
# ------------------------------------------------------------------------------
# set vars(dynamic_rail,vstorm2_end_file) "<vstorm_end_file.inc>"
################################################################################


################################################################################
#                      VOLTUS Tool Control Settings
################################################################################
# ------------------------------------------------------------------------------
# Set the distribution process type, default:local
# ------------------------------------------------------------------------------
# set vars(distribute)      "local/rsh/lsf/custom"
# ------------------------------------------------------------------------------
# Set the number of local cpus, set any integer_number or "max", default:0
# ------------------------------------------------------------------------------
# set vars(local_cpus)           "<num_local_cpus>"
# ------------------------------------------------------------------------------
# Set number of remote hosts for distribute type non-local
# ------------------------------------------------------------------------------
# set vars(remote_hosts)         "<number_of_hosts>"
# ------------------------------------------------------------------------------
# Set number of CPUs per host for distribute type non-local
# ------------------------------------------------------------------------------
# set vars(cpu_per_remote_host)  "<number_of_cpus_per_host>"
# ------------------------------------------------------------------------------
# Set Host list for distribute type "rsh"
# ------------------------------------------------------------------------------
# set vars(rsh,host_list)        "<host1 host2 host2 ......>"
# ------------------------------------------------------------------------------
# set lsf queue name for distribute type "lsf"
# ------------------------------------------------------------------------------
# set vars(lsf,queue)            "<queue_name>"
# ------------------------------------------------------------------------------
# set lsf resource string for distribute type "lsf"
# ------------------------------------------------------------------------------
# set vars(lsf,resource)         "<lsf_resource_string>"
# ------------------------------------------------------------------------------
# set lsf args for distribute type "lsf"
# ------------------------------------------------------------------------------
# set vars(lsf,args)             "<lef_args>"
# ------------------------------------------------------------------------------
# specify the lsf custom scripts for distribute type "custom"
# ------------------------------------------------------------------------------
# set vars(custom,script)        "<specify_lsf_custom_script>"
# ------------------------------------------------------------------------------
# specify whether to keep the multiple CPU-licenses, default:true (OPTIONAL)
# ------------------------------------------------------------------------------
# set vars(keep_license)         "true/false"
################################################################################
#set vars(distribute)              lsf
#set vars(remote_hosts)            2
#set vars(cpu_per_remote_hosts)    2
#set vars(lsf,queue)               "rnd"
#set vars(remote_hosts)            3
#set vars(cpu_per_remote_host)     2
#set vars(rsh,host_list)           "kitsopt11 kitsopt11 kitsopt12 kitsopt12 kitsopt13 kitsopt13"
#set vars(keep_license)            "false"
set vars(local_cpus)              "8"

###############################################################################
# The following plugins are supported when needed ...
###############################################################################
#set vars(set_advanced_pg_library_mode_tcl)	 $vars(plug_root)/set_advanced_pg_library_mode.tcl
#set vars(user_load_design_tcl)                  $vars(plug_root)/user_load_design.tcl
#set vars(pre_static_power_tcl)                  $vars(plug_root)/pre_static_power.tcl
#set vars(report_static_power_tcl)               $vars(plug_root)/report_static_power.tcl
#set vars(post_static_power_tcl)                 $vars(plug_root)/post_static_power.tcl
#set vars(pre_dynamic_power_tcl)                 $vars(plug_root)/pre_dynamic_power.tcl
#set vars(post_dynamic_power_tcl)                $vars(plug_root)/post_dynamic_power.tcl
#set vars(set_static_rail_mode_tcl)              $vars(plug_root)/set_static_rail_mode.tcl
#set vars(set_static_rail_pg_nets_tcl)           $vars(plug_root)/set_static_rail_pg_nets.tcl
#set vars(set_static_rail_power_data_tcl)        $vars(plug_root)/set_static_rail_power_data.tcl
#set vars(set_static_rail_pad_location_tcl)      $vars(plug_root)/set_static_rail_pad_location.tcl
#set vars(set_static_rail_analysis_domain_tcl)   $vars(plug_root)/set_static_rail_analysis_domain.tcl
#set vars(pre_static_rail_tcl)                   $vars(plug_root)/pre_static_rail.tcl
#set vars(post_static_rail_tcl)                  $vars(plug_root)/post_static_rail.tcl
#set vars(set_dynamic_rail_mode_tcl)             $vars(plug_root)/set_dynamic_rail_mode.tcl
#set vars(set_dynamic_rail_pg_nets_tcl)          $vars(plug_root)/set_dynamic_rail_pg_nets.tcl
#set vars(set_dynamic_rail_power_data_tcl)       $vars(plug_root)/set_dynamic_rail_power_data.tcl
#set vars(set_dynamic_rail_pad_location_tcl)     $vars(plug_root)/set_dynamic_rail_pad_location.tcl
#set vars(set_dynamic_rail_analysis_domain_tcl)  $vars(plug_root)/set_dynamic_rail_analysis_domain.tcl
#set vars(pre_dynamic_rail_tcl)                  $vars(plug_root)/pre_dynamic_rail.tcl
#set vars(post_dynamic_rail_tcl)                 $vars(plug_root)/post_dynamic_rail.tcl

Puts "<FF> Finished loading voltus_config.tcl"
