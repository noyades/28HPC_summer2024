################################################################################
#                     USER-LOAD-DESIGN PLUG-IN
################################################################################
# This script should contain only the VOLTUS supported commands
# For loading the design.
# User can put all the design loading VOLTUS commands in this file to load
# the design for analysis.
# If this file is enabled in voltus_config.tcl all other design loading parameters
# are not required to be provided.
################################################################################
Puts "Loading Design through PLUG-IN"
################################################################################
# The following variables are REQUIRED to define
# the design data for the flow. 
# ------------------------------------------------------------------------------
# set vars(edi_db_name)    <EDI_design_path> 
# set vars(load_edi_db)    "true"
# ------------------------------------------------------------------------------
# Below variables for non-EDI design 
# ------------------------------------------------------------------------------
# set vars(netlist)      ../design/postRouteOpt.enc.dat/super_filter.v.gz 
# set vars(def_files)    ../design/super_filter.def.gz 
# set vars(sdc_files)    ../design/base.sdc 
# set vars(design)        super_filter
# ------------------------------------------------------------------------------
# Ignore undefined cells while loading the design, default is false
# ------------------------------------------------------------------------------
# set vars(ignore_undefined_cell)       "true"
# set vars(ignore_timing_library_check) "<true/false>";# must be false for power
# ------------------------------------------------------------------------------
# Specify SPEF, if the design is non-MMMC
# ------------------------------------------------------------------------------
# set vars(spef)         <spef only for non-mmmc design>
################################################################################

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

