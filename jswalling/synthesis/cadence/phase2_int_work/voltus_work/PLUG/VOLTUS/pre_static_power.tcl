################################################################################
#                     PRE-STATIC-POWER PLUG-IN
################################################################################
#
#  This plug-in will be called before executing "report_power" command
#
################################################################################
# This script should contain only the VOLTUS supported commands
# Such as for example:
################################################################################
Puts "Pre Static Power Calculation PLUG-IN"

################################################################################
# Any additional options for command "set_power_analysis_mode" can be modified here
################################################################################
#set_power_analysis_mode -reset
#set_power_analysis_mode \
#        -method static \
#        -create_binary_db true \
#        -binary_db_name StaticPower.db \
#        -write_static_currents true \
#       -decap_cell_list {list of decap cells} \
#       -corner <min|max> \
#       -transition_time_method <min|avg|max> \
#       -analysis_view <view name> \
#       -off_pg_nets {list of off pgnets}

################################################################################
# set_power can be used to specify design/cell/instance power
# set_power 1500mw. This will set the total chip power to 1500mw
# set_power -type cell NAND* 5mw. This will set the power of all cells which match the pattern NAND* to 5mw 
# set_power -type instance ram_256x12 15mw. This will set the power of instance ram_256x12 to 15mw
# set_power -type cell DCAP* -leakage 2mw. This will set the leakage power for cells which match the pattern DCAP* as 2mw 
################################################################################
#set_power -reset
#set_power <chip power>mw
#set_power -cell <cellname> <power>mw
#set_power -instance <instname> <power>mw
#set_power -cell <decap cell names> -leakage <power>mw

################################################################################
# set_switching_activity can used to specify user defined activties at pins/nets/ports
# -pin/net/port (specify the name of the pin/net/port for which activities need to be defined)
# -activity (specifies the number of times the net/pin/port switches in a clock cycle)
# -period (specifies the period that the activity is referenced to. If not specified default period is used)
# -density (specifies the transition density for the net/pin/port)
# -duty (specifies the duty cycle for the net/pin/port.If not specifed then specification through set_default_switching_activity command)
################################################################################
#set_switching_activity -reset
#set_switching_activity \
	-pin <pinname> \
	-activity <activity factor> \
       -period <period value> \
       -density <density factor> \
       -duty <duty factor>
#set_switching_activity \
	-net <netname> \
       -activity <activity factor> \
       -period <period value> \
       -density <density factor> \
       -duty <duty factor>
#set_switching_activity \
	-port <portname> \
	-activity <activity factor> \
	-period <period value> \
	-density <density factor> \
	-duty <duty factor>

################################################################################
# read_activity_file can be used to specify user defined activity files such as VCD/FSDB/TCF
# -format (choose between a VCD/FSDB/TCF format)
# -vcd/fsdb/tcf_scope (specify the scope of the activity file)
# -start/-end (specify the window of interest for VCD/FSDB file, if none given the whole duration is used)
# -vcd/fsdb/tcf_block (for block level activity file specify the block name)
################################################################################
#read_activity_file -reset
#read_activity_file \
	-format VCD <vcd file> \
	-vcd_scope <scopename> \
	-start {time} \
	-end {time} \
	-report_missing_nets true \
	-vcd_block <blockname>
#read_activity_file \
	-format FSDB <fsdb file> \
	-fsdb_scope <scopename> \
	-start {time} \
	-end {time} \
	-report_missing_nets true \
	-fsdb_block <blockname>
#read_activity_file \
	-format TCF <tcf file> \
	-tcf_scope <scopename> \
	-report_missing_nets true \
	-tcf_block <blockname>

################################################################################
# report_vector_profile can be used to identify windows of high activity and power in VCD/FSDB files. It is 
# highly recommended that users run this to identify worst case activity/power window for use in dynamic 
# vectorbased analysis. 
# -activity/-power (enables activity and power profiling respectively)
# -write_profiling_db (writes out a profiling db which can be used to view profiling histograms in the GUI)
# -outfile (specifies the output report which contains the activity/power profile)
# -step (specify the step size in ns. Profiling will be done for every <stepsize> nanoseconds). Default is 2*fastest clock 
################################################################################
#report_vector_profile \
	-activity \
	-write_profiling_db true \
	-outfile activity.rep \
	-step <step size in ns>
#report_vector_profile \
	-power \
	-write_profiling_db true \
	-outfile power.rep \
	-step <step size in ns>

################################################################################
# set_default switching_activity is needed to specify design level activities.
# -input_activity (specifies the activity at the primary inputs. Default is 0.2
# -seq_activity (specifies the activity at the output of sequential cells.It is highly recommended that users specify this
#	         in the absence of a activity file. If activty file is given then users should comment out this option)
# -clock_gates_output (specifies the activity at the output of clock gate cells.It is highly recommended that users specify
#                      this in the absence of a activity file. If activty file is given then users should comment out this option)
# -period (specifies the default operating period of the design. By default the period of the dominant clock is taken)
# -global_activity (specifies the activity for all nets belonging to the data network in the design. This is not required if above
# 		    activity specifications are given)  
################################################################################
#set_default_switching_activity -reset
#set_default_switching_activity \
	-input_activity 0.2 \
	-seq_activity <activity at output of seq cells> \
	-clock_gates_output <activity at output of clock gate cells> \
	-period <default operating period> \
	-global_activity <activity factor>   		

################################################################################
# read_twf command can be used to specify a external timing window file. This will disable the in-built timing engine
# -view (specifies the view name for which twf is provided. This is a required option in CPF flow)
################################################################################
#read_twf -reset
#read_twf <twf filename> \
	-view <view name>

################################################################################
# set_dc_sources can be used to specify the operating voltages of the power/ground nets
# set_dc_sources {VDD VDD1} -power -voltage 1.2. This will assign 1.2v to VDD & VDD1 power net
################################################################################
#set_dc_sources {power net name} -power -voltage <voltage value>
#set_dc_sources {ground net name} -ground -voltage 0.0

###############################################################################
# write_tcf will write out a net based TCF file for all the nets in the design
###############################################################################
#write_tcf RPT/STATIC_POWER/Power.tcf
