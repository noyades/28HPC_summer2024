#===========================================================================
# File Name	: @Source: /net/splinter/fed/cvs/ae-ware/rc/generate_report.tcl,v @
# Date Created	: 09/10/2006
# Date Modified	: @Date: 2012/03/16 00:00:17 @
# Version	: @Revision: 1.64 @
# Summary	: Generate HTML comparison report or append to exisiting one
# Keywords      : report HTML QoR QoS compare results
#
# Description:
#	This scripts allows the user to generate and HTML report with general
#	results as well as some general settings. This way users can compare
#	the results across multiple runs with different setting / constraints
#       and / or HDL
#
# Assumptions:
#	None
#
#===========================================================================
# pragma protect
# pragma protect begin

if {![info exists ::ns(compat)]}  { set ::ns(compat) "::aeware" }
if {![info exists ::ns(genrpt)]}  { set ::ns(genrpt) "${::ns(compat)}::genrpt" }

package require ::applet::time_info

namespace eval $::ns(genrpt) {
    variable grpNameW 150
    variable grpFieldW 100
    variable fieldW 125
    variable lockExists 1
    variable notify
    variable runName
    variable htmlReportTitle
    variable cgState "OFF"
    variable leakOpto "OFF"
    variable dynoOpto "OFF"
    variable designMetrics

    variable gtColor     "rgb(255, 204, 102)"
    variable ltColor     "rgb(204, 204, 255)"
    variable blankColor  "rgb(153, 153, 153)"

    namespace export generate_report

    if {![info exists ::ns(lock)]} { variable lockExists 0 }
    
    if {![llength [find /object_types/root/attributes -attr genrpt_name_field]]} { 
	define_attribute			\
	    -category enhacement		\
	    -data_type string			\
	    -obj_type root			\
	    -default_value "Run Name"		\
	    -skip_in_db				\
	    -help_string "Row name for the -name command-line option (default is \"Run Name\"" \
	    genrpt_name_field
    }
    
    # Nede an atribute to define the list of recipients when the -notify option is used
    if {![llength [find /object_types/root/attributes -attr genrpt_notify_recipients]]} { 
	define_attribute			\
	    -category enhacement		\
	    -data_type string			\
	    -obj_type root			\
	    -default_value $::env(USER)		\
	    -skip_in_db				\
	    -help_string "List of emails or aliases for reports to be sent upon job completion" \
	    genrpt_notify_recipients
    }
    
    # Need to create an attribute to only allow testcase creation once user is aware of 
    # caveats of doing it post-unmapped stage
    if {![llength [find /object_types/root/attributes -attr genrpt_lock_filename]]} { 
	define_attribute			\
	    -category enhacement		\
	    -data_type string			\
	    -obj_type root			\
	    -default_value $::env(HOME)/.genRpt-lock \
	    -skip_in_db				\
	    -help_string "lock file full path for atomic operation" \
	    genrpt_lock_filename
    }
    
    if {![llength [find /object_types/root/attributes -attr genrpt_lock_timeout]]} { 
	define_attribute			\
	    -category enhacement		\
	    -data_type integer			\
	    -obj_type root			\
	    -default_value 1200000		\
	    -skip_in_db				\
	    -help_string "lock timeout value in ms (0=inifity)" \
	    genrpt_lock_timeout
    }
    
    if {![llength [find /object_types/root/attributes -attr genrpt_allow_multiple_users]]} { 
	define_attribute			\
	    -category enhacement		\
	    -data_type boolean			\
	    -obj_type root			\
	    -default_value false		\
	    -skip_in_db				\
	    -help_string "Allow multiple users to append to the same report file" \
	    genrpt_allow_multiple_users
    }
    
    if {![llength [find /object_types/root/attributes -attr genrpt_skip_empty_cg]]} { 
	define_attribute			\
	    -category enhacement		\
	    -data_type boolean			\
	    -obj_type root			\
	    -default_value false		\
	    -skip_in_db				\
	    -help_string "Do not include cost groups without paths in the report" \
	    genrpt_skip_empty_cg
    }
    
    if {![llength [find /object_types/root/attributes -attr genrpt_skip_cg]]} { 
	define_attribute			\
	    -category enhacement		\
	    -data_type string			\
	    -obj_type root			\
	    -default_value {}			\
	    -skip_in_db				\
	    -help_string "List of cost groups to skipped" \
	    genrpt_skip_cg
    }
    
    if {![llength [find /object_types/root/attributes -attr genrpt_cg_sort_parameter]]} { 
	define_attribute			\
	    -category enhacement		\
	    -data_type string			\
	    -obj_type root			\
	    -default_value "alpha"		\
	    -skip_in_db				\
	    -help_string "parameter to sort timing cost_groups(alpha|slack|tns|viol)" \
	    genrpt_cg_sort_parameter
    }
    
    if {![llength [find /object_types/root/attributes -attr genrpt_link_target]]} { 
	define_attribute			\
	    -category enhacement		\
	    -data_type string			\
	    -obj_type root			\
	    -default_value "_blank"	        \
	    -skip_in_db				\
	    -help_string "Attribute that are undocumented and need to be enabled for generate_report" \
	    genrpt_link_target
    }
    
    if {![llength [find /object_types/root/attributes -attr genrpt_header_color]]} { 
	define_attribute			\
	    -category enhacement		\
	    -data_type string			\
	    -obj_type root			\
	    -default_value "rgb(255, 204, 51)"	\
	    -skip_in_db				\
	    -help_string "Report header color"	\
	    genrpt_header_color
    }
    
    if {![llength [find /object_types/root/attributes -attr genrpt_field_color]]} { 
	define_attribute			\
	    -category enhacement		\
	    -data_type string			\
	    -obj_type root			\
	    -skip_in_db				\
	    -default_value "rgb(234, 234, 234)"	\
	    -help_string "First column color"	\
	    genrpt_field_color
    }
    
    if {![llength [find /object_types/root/attributes -attr genrpt_minimal_fields]]} { 
	define_attribute			\
	    -category enhacement		\
	    -data_type boolean			\
	    -obj_type root			\
	    -default_value false		\
	    -skip_in_db				\
	    -help_string "when true, do not include additional default report info but\n\tinclude cost group info unless -simple command option specified" \
	    genrpt_minimal_fields
    }
    
    if {![llength [find /object_types/root/attributes -attr genrpt_allow_wrap]]} { 
	define_attribute			\
	    -category enhacement		\
	    -data_type boolean			\
	    -obj_type root			\
	    -default_value false		\
	    -skip_in_db				\
	    -help_string "When set to false, it enable line-wrapping in fields for generated HTML" \
	    genrpt_allow_wrap
    }
    
    hidden_proc GetTotalPower { obj } {
	return [format "%.2f" [expr {[get_attr lp_leakage_power $obj] + [get_attr lp_internal_power $obj] + [get_attr lp_net_power $obj]}]]
    }
    
    hidden_proc GetDynamicPower { obj } {
	return [format "%.2f" [expr {[get_attr lp_internal_power $obj] + [get_attr lp_net_power $obj]}]]
    }
    
    if {![llength [find /object_types/instance -attr lp_total_power]]} {
	define_attribute			\
	    -obj_type "instance"		\
	    -data_type "string"			\
	    -category lp_pa			\
	    -default_value POW_UNITIALIZED	\
	    -skip_in_db				\
	    -compute_function ${::ns(genrpt)}::GetTotalPower	\
	    -help_string "Total(leakage+dynamic) power of an instance" \
	    lp_total_power
    }
    
    if {![llength [find /object_types/design -attr lp_total_power]]} {
	define_attribute			\
	    -obj_type "design"			\
	    -data_type "string"			\
	    -category lp_pa			\
	    -default_value POW_UNITIALIZED	\
	    -skip_in_db				\
	    -compute_function ${::ns(genrpt)}::GetTotalPower \
	    -help_string "Total(leakage+dynamic) power of a design" \
	    lp_total_power
    }

    if {![llength [find /object_types/instance -attr lp_dynamic_power]]} {
	define_attribute			\
	    -obj_type "instance"		\
	    -data_type "string"			\
	    -category lp_pa			\
	    -default_value POW_UNITIALIZED	\
	    -skip_in_db				\
	    -compute_function ${::ns(genrpt)}::GetDynamicPower	\
	    -help_string "Dynamic(net+internal) power of an instance" \
	    lp_dynamic_power
    }
    
    if {![llength [find /object_types/design -attr lp_dynamic_power]]} {
	define_attribute			\
	    -obj_type "design"			\
	    -data_type "string"			\
	    -category lp_pa			\
	    -default_value POW_UNITIALIZED	\
	    -skip_in_db				\
	    -compute_function ${::ns(genrpt)}::GetDynamicPower	\
	    -help_string "Total(leakage+dynamic) power of a design" \
	    lp_dynamic_power
    }
    
    hidden_proc GetSeqCount { obj } {
	return [llength [find $obj -instance instances_seq/*]]
    }
    
    hidden_proc GetComboCount { obj } {
	return [llength [find $obj -instance instances_comb/*]]
    }

    hidden_proc GetLatchCount { obj } {
	return [llength [filter latch true [find $obj -instance instances_comb/*]]]
    }

    hidden_proc GetFFCount { obj } {
	return [llength [filter flop true [find $obj -instance instances_seq/*]]]
    }

    hidden_proc GetBufferCount { obj } {
	return [llength [filter buffer true [find $obj -instance instances_comb/*]]]
    }

    hidden_proc GetInvCount { obj } {
	return [llength [filter inverter true [find $obj -instance instances_comb/*]]]
    }

    hidden_proc GetCGCount { obj } {
	# Need to handle library domains as well as library attribute
	if {[llength [find /libraries -library_domain *]]} { 
	    set libRoot [lindex [find /libraries -library_domain *] 0] 
	} else {
	    set libRoot /libraries
	}
	set cgInfo [join [filter -regexp clock_gating_integrated_cell {\w} [find ${libRoot} -libcell *]] |]
	return [llength [filter -regexp libcell "(${cgInfo})" [find $obj -instance instances_seq/*]]]
    }
    
    if {![llength [find /object_types/instance -attr cell_count_seq]]} {
	define_attribute			\
	    -obj_type "instance"		\
	    -data_type "string"			\
	    -category Enhancement		\
	    -skip_in_db				\
	    -compute_function ${::ns(genrpt)}::GetSeqCount	\
	    -help_string "Sequential instance count" \
	    cell_count_seq
    }

    if {![llength [find /object_types/design -attr cell_count_seq]]} {
	define_attribute			\
	    -obj_type "design"			\
	    -data_type "string"			\
	    -category Enhancement		\
	    -compute_function ${::ns(genrpt)}::GetSeqCount	\
	    -skip_in_db				\
	    -help_string "Sequential instance count" \
	    cell_count_seq
    }

    if {![llength [find /object_types/instance -attr cell_count_comb]]} {
	define_attribute			\
	    -obj_type "instance"		\
	    -data_type "string"			\
	    -category Enhancement		\
	    -compute_function ${::ns(genrpt)}::GetComboCount	\
	    -skip_in_db				\
	    -help_string "Combinationnal instance count" \
	    cell_count_comb
    }
    
    if {![llength [find /object_types/design -attr cell_count_comb]]} {
	define_attribute			\
	    -obj_type "design"			\
	    -data_type "string"			\
	    -category Enhancement		\
	    -compute_function ${::ns(genrpt)}::GetComboCount	\
	    -skip_in_db				\
	    -help_string "Combinationnal instance count" \
	    cell_count_comb
    }

    if {![llength [find /object_types/instance -attr cell_count_ff]]} {
	define_attribute			\
	    -obj_type "instance"		\
	    -data_type "string"			\
	    -category Enhancement		\
	    -compute_function ${::ns(genrpt)}::GetFFCount	\
	    -skip_in_db				\
	    -help_string "Flip-flop instance count" \
	    cell_count_ff
    }
    
    if {![llength [find /object_types/design -attr cell_count_ff]]} {
	define_attribute			\
	    -obj_type "design"			\
	    -data_type "string"			\
	    -category Enhancement		\
	    -compute_function ${::ns(genrpt)}::GetFFCount	\
	    -skip_in_db				\
	    -help_string "Flip-flop instance count" \
	    cell_count_ff
    }

    if {![llength [find /object_types/instance -attr cell_count_buffer]]} {
	define_attribute			\
	    -obj_type "instance"		\
	    -data_type "string"			\
	    -category Enhancement		\
	    -compute_function ${::ns(genrpt)}::GetBufferCount	\
	    -skip_in_db				\
	    -help_string "Flip-flop instance count" \
	    cell_count_buffer
    }
    
    if {![llength [find /object_types/design -attr cell_count_buffer]]} {
	define_attribute			\
	    -obj_type "design"			\
	    -data_type "string"			\
	    -category Enhancement		\
	    -compute_function ${::ns(genrpt)}::GetBufferCount	\
	    -skip_in_db				\
	    -help_string "Flip-flop instance count" \
	    cell_count_buffer
    }

    if {![llength [find /object_types/instance -attr cell_count_inv]]} {
	define_attribute			\
	    -obj_type "instance"		\
	    -data_type "string"			\
	    -category Enhancement		\
	    -compute_function ${::ns(genrpt)}::GetInvCount	\
	    -skip_in_db				\
	    -help_string "Flip-flop instance count" \
	    cell_count_inv
    }
    
    if {![llength [find /object_types/design -attr cell_count_inv]]} {
	define_attribute			\
	    -obj_type "design"			\
	    -data_type "string"			\
	    -category Enhancement		\
	    -compute_function ${::ns(genrpt)}::GetInvCount	\
	    -skip_in_db				\
	    -help_string "Flip-flop instance count" \
	    cell_count_inv
    }

    if {![llength [find /object_types/instance -attr cell_count_latch]]} {
	define_attribute			\
	    -obj_type "instance"		\
	    -data_type "string"			\
	    -category Enhancement		\
	    -compute_function ${::ns(genrpt)}::GetLatchCount	\
	    -skip_in_db				\
	    -help_string "Latch instance count" \
	    cell_count_latch
    }
    
    if {![llength [find /object_types/design -attr cell_count_latch]]} {
	define_attribute			\
	    -obj_type "design"			\
	    -data_type "string"			\
	    -category Enhancement		\
	    -compute_function ${::ns(genrpt)}::GetLatchCount	\
	    -skip_in_db				\
	    -help_string "Latch instance count" \
	    cell_count_latch
    }

    if {![llength [find /object_types/instance -attr cell_count_cgic]]} {
	define_attribute			\
	    -obj_type "instance"		\
	    -data_type "string"			\
	    -category Enhancement		\
	    -compute_function ${::ns(genrpt)}::GetCGCount	\
	    -skip_in_db				\
	    -help_string "Clock-gating integrated cell instance count" \
	    cell_count_cgic
    }
    
    if {![llength [find /object_types/design -attr cell_count_cgic]]} {
	define_attribute			\
	    -obj_type "design"			\
	    -data_type "string"			\
	    -category Enhancement		\
	    -compute_function ${::ns(genrpt)}::GetCGCount	\
	    -skip_in_db				\
	    -help_string "Clock-gating integrated cell instance count" \
	    cell_count_cgic
    }

    proc generate_report { args } {
	variable $::ns(genrpt)::lockExists
	variable notify
	variable runName
	variable modeName
	variable htmlReportTitle
	variable cgState
	variable leakOpto
	variable dynoOpto
        variable tbl

	# Initialize variables
	set design ""
	set customInfo ""
	set startTime [clock seconds]
	
	# infer -name if -remove specified and -name missing
	if { [regexp -- "\-remove" $args] && ![regexp -- {\-name\s+[\{\"\w]} $args] } { set args [concat "-name \{\} " $args] }
	
	# Setup lock file and timeout values for atomic operations
	if {$lockExists} {
	    eval lock lockfile [get_attr genrpt_lock_filename /]
	    eval lock timeout  [get_attr genrpt_lock_timeout /] ;# default set to 20 minutes
	}
	
	regexp {\d+(\.\d+)+} {@Revision: 1.64 @} pkgRev
	# Parse command line switches
	# return an error if incorrect arguments are given
	switch -- [parse_options "[calling_proc] $pkgRev" {} $args					\
		       "-replace bos replace report if it exists" replaceReport				\
		       "-name srs run name" runName							\
		       "-quiet bos do not issue warnings when running" quietMode			\
		       "-notify sos Message subject string on notification" notify			\
		       "-remove sos Column to be removed { 1 2 . . . n }" removeInfo			\
		       "-update nos Column to be updated" updateCol					\
		       "-custom sos custom parameter list {{custom1 value1}...{custom_n value_n}}" customInfo \
		       "-multi_custom sos custom parameter list for multi-row fields {{group_tag {{tag1 val1}...{tag_n val_n}}}...}" customMultiInfo \
		       "-cg_custom sOs custom parameter list for cost group information" customCgInfo	\
		       "-design sos Specify a design name <optional>" designName			\
		       "-mode dOs(mode) Specify the mode to use when reporting multi-mode designs" modeName	\
		       "-compare bos Generate comparison metrics of first and last column" compareCols	\
		       "-only_compare bos Generate comparison metrics of first and last column and DO NOT generate new column" onlyCompare	\
		       "-threshold fos % threshold for comparison to be highlighted" threshold		\
		       "-baseline_column nos Column used as baseline for comparisons(default is first data column)" baseCol \
		       "-simple bos Only create basic fields / useful for customized reports" simpleMode \
		       "-title sos Specify title of HTML Table generated; default is RTL Compiler QoR Report" title	\
		       "-reorder bos Reorder parameters per latest specification" reorder		\
		       "-xml_file sOs name of XML file containing the same information" xmlReport	\
		       "-csv_file sOs name of CSV file containing the same information" csvReport	\
		       "srs HTML report" htmlReport] {
			   -2 { return }
			   0 { return -code error }
	}
	
	time_info -table genrpt -quiet -stamp enter_genrpt

	if {![llength $customCgInfo] && ![get_attr genrpt_minimal_fields /] && !$simpleMode} {
	    set customCgInfo [list]
	    switch -regexp [info nameofexecutable] {
		{/(velocity|encounter)} {
 		    set customCgInfo [linsert ${customCgInfo} end {"WNS \[ps\]%timing.setup.WNS.${cgName}<FIELD(0 1)><SCALE(*1000)>%metric_tcl%"}]
 		    set customCgInfo [linsert ${customCgInfo} end {"TNS \[ps\]%timing.setup.TNS.${cgName}<FIELD(0 1)><SCALE(*1000)>%metric_tcl%"}]
 		    set customCgInfo [linsert ${customCgInfo} end {"# Violators%timing.setup.numViolatingPaths.${cgName}%metric%"}]
 		    set customCgInfo [linsert ${customCgInfo} end {"WNS-Hold \[ps\]%timing.hold.WNS.${cgName}<FIELD(0 1)><SCALE(*1000)>%metric_tcl%"}]
 		    set customCgInfo [linsert ${customCgInfo} end {"TNS-Hold \[ps\]%timing.hold.TNS.${cgName}<FIELD(0 1)><SCALE(*1000)>%metric_tcl%"}]
 		    set customCgInfo [linsert ${customCgInfo} end {"# Violators-Hold%timing.hold.numViolatingPaths.${cgName}%metric%"}]
		}
		default {
		    if {[llength ${modeName}]} {
			set customCgInfo [linsert ${customCgInfo} end [list "WNS \\\[ps\\\]%\\\[lindex \\\[lsearch -regexp -inline \\\[get_attr slack_by_mode \${cgName}\\\] ${modeName}\\\] 1\\\]%"]]
#			set customCgInfo [linsert ${customCgInfo} end {"Target \[ps\]%actual_target%$cgName%"}]
			set customCgInfo [linsert ${customCgInfo} end {"TNS \[ps\]%\[GetCgTNS $cgName\]%"}]
			set customCgInfo [linsert ${customCgInfo} end {"# Violators%\[GetCgViol $cgName\]%"}]
#			set customCgInfo [linsert ${customCgInfo} end {"Crit. Period \[ps\]%\[GetCgCritPeriod $cgName\]%"}]
#			set customCgInfo [linsert ${customCgInfo} end [list Mode [basename ${modeName}]]]
		    } else {
			set customCgInfo [linsert ${customCgInfo} end {"WNS \[ps\]%slack%${cgName}%"}]
			set customCgInfo [linsert ${customCgInfo} end {"Target \[ps\]%actual_target%$cgName%"}]
			set customCgInfo [linsert ${customCgInfo} end {"TNS \[ps\]%tns%$cgName%"}]
			set customCgInfo [linsert ${customCgInfo} end {"# Violators%\[GetCgViol $cgName\]%"}]
			set customCgInfo [linsert ${customCgInfo} end {"Crit. Period \[ps\]%\[GetCgCritPeriod $cgName\]%"}]
			set customCgInfo [linsert ${customCgInfo} end {"Frequency \[MHz\]%\[GetCgCritFreq $cgName\]%"}]
			if {[llength [find / -mode *]]} { set customCgInfo [linsert ${customCgInfo} end {"Mode%\[GetCgCritMode $cgName\]%"}] }
		    }
		}
	    }
	}		  
	
	# Initialize and error-check design variable - no need to validate if removing columns
	if {![llength $removeInfo]} {
	    set designExpr "*"
	    if {[llength $designName]} { set designExpr [basename $designName] }
	    set design [find / -design $designExpr]
	    switch [llength $design] {
		0 { 
		    if {[llength $designName]} { 
			puts "ERROR!!! design \'[basename $designName]\' not found in memory"
		    } else {
			puts "ERROR!!! No designs found in memory " 
		    }
		    return
		}
		1 { 
		    if {![llength $designName] && !${quietMode}} { puts "Info: No design specified, assuming unique design \'[basename $design]\'" }
		}
		default { 
		    puts "ERROR!!! multiple design in memory. An unambiguous design name must be specified with \'-design\' option"
		    return
		}
	    }
	} else {
	    if {[llength ${updateCol}]} { return "ERROR!!! \'-update\' and \'-remove\' cannot be used simultaneously" }
	}
	
	# Set dafault value when not initialized
	if {![llength $threshold]}  { set threshold 0 }
	if {![llength $baseCol]}    { 
	    set baseCol 2 
	} else {
	    incr baseCol 1
	}
	
	# If in replace mode, overwrite existing file
	if { [file exists $htmlReport] && [llength $removeInfo] } { 
	    foreach removeData $removeInfo { 
		if { $removeData < 1 } {
		    puts "ERROR!!! When removing column, index must be greater than 0"
		    return
		}
	    }
	    if {$lockExists} { set lockInfo [eval lock acquire] }
	    eval read_html ${htmlReport} "tbl"
	    foreach col [lsort -decreasing -dictionary -unique ${removeInfo}] { eval DeleteTblCol -col [expr {${col} + 1}] tbl }
	    eval write_html ${htmlReport} "tbl"
	    if {[llength ${csvReport}]} { eval write_csv ${csvReport} "tbl" }
	    if {[llength ${xmlReport}]} { eval write_xml ${xmlReport} "tbl" }
	    if {[get_attr genrpt_allow_multiple_users /]} { file attributes ${htmlReport} -permissions uog+rwx }
	    if {$lockExists} { eval lock release ${lockInfo} }
	    return
	}
	
	# Initialize settings to their default state
	set htmlReportTitle "" 
	if {[llength $title]} { set htmlReportTitle $title }
	
	set fieldInfo [list											\
			   [list [get_attr genrpt_name_field /] ${runName}]					\
			   [list "Version%program_version%"]							\
			   [list "Date: MM/DD/YYYY%\[clock format \[clock seconds\] -format \"%D\"\]%"]		\
			   [list "Date: Time%\[clock format \[clock seconds\] -format \"%I:%M:%S %p\"\]%"]	\
			   [list "Run By%env(USER)%"]								\
			   [list "Hostname%\[lindex \[split \[info hostname\] .\] 0\]%"]			\
			   [list "System Load%\[lindex \[split \[exec uptime\] \",\"\] end-2 2\]%"]		\
			   [list "Runtime%super_thread_runtime<PREC(.0)><SEC>%"]]

	# add mode field if invoking using 'generate_report -mode' option
	# should support for all tools in the future
	if {[llength ${modeName}] && [regexp {/(rc|rc-o|rc-O)$} [info nameofexecutable]]} {
	    set fieldInfo [linsert ${fieldInfo} end [list "Timing Mode" [basename ${modeName}]]]
	}

	set cgInfo {}
	set sortedCg {}
	
	if {[llength $customCgInfo]} {
	    puts "Building Timing Graph..." 

	    foreach cgName [find / -cost_group *] {
		if {[get_attr genrpt_skip_empty_cg /] && [regexp {(no_value|N/A)} [get_attr slack $cgName]] } { continue }
		if {[lsearch -exact [get_attr genrpt_skip_cg /] $cgName] != -1} { continue }
		set groupName "Cost Group:<br><span style=\"font-style: italic;\">[basename $cgName]</span><br style=\"font-style: italic;\">"
		switch [get_attr genrpt_cg_sort_parameter /] {
		    "alpha" { set sortParameter ${cgName} }
		    "viol"  { set sortParameter [eval GetCgViol ${cgName}] }
		    default { set sortParameter [get_attr [get_attr genrpt_cg_sort_parameter /] ${cgName}] }
		}
		if {![string match "alpha" [get_attr genrpt_cg_sort_parameter /]] && [string match no_value [get_attr slack ${cgName}]]} { 
		    set sortParameter 9999999 
		    if {[regexp {(viol|tns)} [get_attr genrpt_cg_sort_parameter /]]} { set sortParameter -999999999 }
		}

		lappend cgInfo [list $groupName [subst $customCgInfo] $sortParameter]
	    }
	    # Sort CGs based on criteria specified
	    switch [get_attr genrpt_cg_sort_parameter /] {
		"alpha" { foreach cgData [lsort -increasing -ascii -index 2 $cgInfo] { lappend sortedCg  [lrange ${cgData} 0 1] } }
		"slack" { foreach cgData [lsort -increasing -real -index 2 $cgInfo]  { lappend sortedCg  [lrange ${cgData} 0 1] } }
		default { foreach cgData [lsort -decreasing -real -index 2 $cgInfo]  { lappend sortedCg  [lrange ${cgData} 0 1] } }
	    }
	}

	if {!$simpleMode && ![get_attr genrpt_minimal_fields /]} {
	    set cellCountInfo [list				\
				   "Leaf%cell_count%"		\
				   "Seq%cell_count_seq%"	\
				   "FF%cell_count_ff%"		\
				   "Latch%cell_count_latch%"	\
				   "CGIC%cell_count_cgic%"	\
				   "Combo%cell_count_comb%"	\
				   "Buffer%cell_count_buffer%"	\
				   "Inverter%cell_count_inv%"]
	    
	    switch -regexp [info nameofexecutable] {
		{/(velocity|encounter)$} {
		    eval UpdateEdiMetrics
		    set cellCountInfo [list							\
					   "Leaf%$::ns(genrpt)::designMetrics(cellCount)%"	\
					   "Seq%$::ns(genrpt)::designMetrics(seqCount)%"	\
					   "Inverter%$::ns(genrpt)::designMetrics(invCount)%"	\
					   "Buffer%$::ns(genrpt)::designMetrics(bufCount)%"	\
					   "Other%$::ns(genrpt)::designMetrics(otherCount)%"]
		    
		    set fieldInfo [concat $fieldInfo [list								\
							  [list "Memory Usage \[MB\]%memory_usage%/%"]			\
							  [list "Cell Area%$::ns(genrpt)::designMetrics(cellArea)%"]	\
							  [list "Utilization%\[lindex \[get_metric design.util -value\] 0\]<PREC(.2)>%"]]]
		    
		    set cellRowInfo [list \
					 "Single Row%\[get_metric design.numSingleRowCell -value\]%"			\
					 "Double Row%\[get_metric design.numDoubleRowCell -value\]%"			\
					 "Multi Row%\[get_metric design.numMultiRowCell -value\]%"]
		}
		{/ctos(gui)?$} {
		    eval UpdateCtosMetrics
		    set cellCountInfo [list							\
					   "Leaf%$::ns(genrpt)::designMetrics(cellCount)%"	\
					   "Seq%$::ns(genrpt)::designMetrics(seqCount)%"	\
					   "Mux%$::ns(genrpt)::designMetrics(muxCount)%"	\
					   "Other%$::ns(genrpt)::designMetrics(otherCount)%"]
		    
		    set fieldInfo [concat $fieldInfo [list								\
							  [list "Memory Usage \[MB\]%memory_usage%/%"]			\
							  [list "Cell Area" [set [set ::ns(genrpt)]::designMetrics(area)]]	\
							  [list "Total Power" [set [set ::ns(genrpt)]::designMetrics(power)]]]]
		}
		{/(LEC|lec)$} {
		    set fieldInfo [concat $fieldInfo [list								\
							  "LEC CPU runtime%\[${::ns(compat)}::SecToTime \[get_attr runtime /\]\]%" \
							  "LEC Memory Usage \[MB\]%memory_usage%/%"			\
							  "Compare Points%\[get_compare_points -count\]%"		\
							  "Equiv. Points%\[get_compare_points -pos_eq -count\]%"	\
							  "NonEq Points%\[get_compare_points -neg_eq -count\]%"		\
							  "Diff Points%\[get_compare_points -diff -count\]%"		\
							  "Abort Points%\[get_compare_points -abort -count\]%"		\
							  "Unknown Points%\[get_compare_points -unknown -count\]%"	\
							  "Black Boxes%\[get_compare_points -BBOX -count\]%"]]
		}
		default {
		    set powerUnit "\[[get_attr lp_power_unit /]\]"
		    if {[regexp {\d+} [get_attr max_leakage_power $design]]} { set leakOpto [get_attr max_leakage_power $design] }
		    if {[regexp "true" [get_attr lp_insert_clock_gating /]]} { set cgState ON }
		    if {[regexp {\d+} [get_attr max_dynamic_power $design]]} { set dynoOpto [get_attr max_dynamic_power $design] }
		    
		    set fieldInfo [concat $fieldInfo [list								\
							  [list "Threads%\[llength \[get_attr super_thread_servers /\]\]%"]	\
							  [list "Leakage Target%leakOpto%"]				\
							  [list "Power Opto Effort%power_optimization_effort%"]	\
							  [list "Leakage Power $powerUnit%lp_leakage_power<PREC(.1)>%"]	\
							  [list "Dynamic Target%dynoOpto%"]				\
							  [list "Internal Power $powerUnit%lp_internal_power<PREC(.1)>%"]\
							  [list "Net Power $powerUnit%lp_net_power<PREC(.1)>%"]		\
							  [list "Switching / Dyn. Power $powerUnit%lp_dynamic_power%"]	\
							  [list "Interconnect Mode%interconnect_mode%"]			\
							  [list "Memory Usage \[MB\]%memory_usage%/%"]			\
							  [list "Clock Gating%cgState%"]				\
							  [list "Utilization%utilization<PREC(.2)><PERCENT>%"]		\
							  [list "Cell Area%cell_area<PREC(.1)>%"]]]
		}
	    }

	    if {![regexp -nocase {/lec$} [info nameofexecutable]]} { set sortedCg [linsert $sortedCg 0 [list "Cell Instance Count" $cellCountInfo]] }
	    if {[info exists cellRowInfo]} { set sortedCg [linsert $sortedCg 0 [list "Cell multi-row Count" $cellRowInfo]] } 
	}

	if {[get_attr genrpt_minimal_fields /]} { set fieldInfo [list [list "[get_attr genrpt_name_field /]" $runName]] }
	
	# If custom fields have been specified, append to default ones
	if { [llength $customInfo] && ![llength ${updateCol}] }      { set fieldInfo [concat $fieldInfo $customInfo] }
	if { [llength $customMultiInfo] && ![llength ${updateCol}] } { set sortedCg [concat $sortedCg $customMultiInfo] }
	if { [llength $customInfo] && [llength ${updateCol}] }       { set fieldInfo $customInfo }
	if { [llength $customMultiInfo] && [llength ${updateCol}] }  { set sortedCg $customMultiInfo }
	# Auto-update fieldInfo where arguments are not provided
	set latestInfo [eval GetFields "fieldInfo" $design]
	if {[llength ${sortedCg}]} { 
	    set multiInfo  [eval GetFields -multi "sortedCg" $design] 
	    if { [llength [lsort -unique -index 0 $multiInfo]] != [llength $multiInfo] } {
		puts "Error: Redundant multifield group in custom fields are not allowed"
		puts "\tplease fix custom multi-field list and try again"
		return -code error
	    }
	}
	if { [llength [lsort -unique -index 0 $latestInfo]] != [llength $latestInfo] } {
	    puts "Error: Redundant fields in custom fields are not allowed"
	    puts "\tplease fix custom list and try again"
	    return -code error
	}
	
	# If in replace mode, overwrite existing file
	# Note that CreatHTML, UpdateHTML, and CompareColumn are all in atomic {}
	# blocks; this is needed to prevent concurrent jobs from cloberring a shared
	# HTML file
	if {$lockExists} { set lockInfo [eval lock acquire] }
	# Catch block is important to ensure that if anything fails
	# the file lock will be properly released
	if { [catch {
	    if { ![file exists $htmlReport] || $replaceReport } { 
		eval CreateHTML "tbl" [list $latestInfo]
	    } else {
		eval read_html $htmlReport "tbl"
	    }
	    
	    ##nagelfar ignore Unknown variable
	    if {![llength ${updateCol}]} { set updateCol $tbl(width) }
	    # Create a backup file, read it and write updated results into original one
	    if {!$onlyCompare} { 
		if {[llength $sortedCg]} { 
		    eval UpdateHTML -update ${updateCol} -field [list $latestInfo] -multi [list $multiInfo] tbl 
		} else {
		    eval UpdateHTML -update ${updateCol} -field [list $latestInfo] tbl 
		}
	    }
	    # Compute and update HTML with comparison metrics
	    if { $compareCols || $onlyCompare } { eval CompareColumn -threshold $threshold -base_col $baseCol tbl }
	    if { $reorder } { 
		if {[llength $sortedCg]} { 
		    eval ReorderHTML  -field [list $latestInfo] -multi [list $multiInfo] "tbl" 
		} else {
		    eval ReorderHTML  -field [list $latestInfo] "tbl" 
		}
	    }
	    eval write_html $htmlReport "tbl"
	    if {[llength ${csvReport}]} { eval write_csv ${csvReport} "tbl" }
	    if {[llength ${xmlReport}]} { eval write_xml ${xmlReport} "tbl" }
	    if {[get_attr genrpt_allow_multiple_users /]} { file attributes ${htmlReport} -permissions uog+rwx }
	} errMsg] } { 
	    if {$lockExists} { eval lock release ${lockInfo} }
	    return -code error $errMsg
	} else {
	    if {$lockExists} { eval lock release ${lockInfo} }
	}
	
	if {!${quietMode}} { puts "generate_report runtime: \'[$::ns(compat)::SecToTime [expr {[clock seconds] - ${startTime}}]]\'\n" }

	if {[llength $notify]} {
	    if {[catch {exec which mutt} appPath]} {
		puts "Warning: Application \"mutt\" not found. Notification will not be sent..."
	    } else {
		puts "Generating notification for [get_attr genrpt_notify_recipients /]"
		##nagelfar ignore
		exec echo | $appPath -a $htmlReport -s $notify [get_attr genrpt_notify_recipients /]
	    }
	}
	time_info -table genrpt -quiet -stamp exit_genrpt
    }
}    

if {![llength [info commands ::generate_report]]} { 
    namespace import $::ns(genrpt)::generate_report
    add_command_help generate_report "Generate HTML version of QoR reports for multiple runs" "Reporting"
}

namespace eval $::ns(genrpt) {
    #------------------------------------------------------
    # 
    # 
    # 
    # 
    # 
    # 
    #------------------------------------------------------
    hidden_proc GetCgCritMode { obj } {
	# since it only gets invoked when multiple modes exist, then no
	# no need to ensure that we are in a multi-mode design

	# return the name of the mode with the worst slack
	return [basename [lindex [lsort -real -index 1 [get_attr slack_by_mode $obj]] 0 0]]
    }
    
    #------------------------------------------------------
    # 
    # 
    # 
    # 
    # 
    # 
    #------------------------------------------------------
    hidden_proc GetCgViol { obj } {
	variable $::ns(genrpt)::modeName

	rename ::report::header ::report::qor::oldheader
	rename ::report::qor::new_header ::report::header
	set pathExists 1
	set timingMode ${modeName}
	if {[llength [find / -mode *]] && ![llength ${modeName}]} { set timingMode [eval GetCgCritMode ${obj}] }
	
	if {[llength [find / -mode *]]} {
	    puts "Computing \'\# of Violations\' for cost_group \'[basename $obj] (mode: [basename $timingMode])\'..."
	    set cgSlack [lindex [lsearch -regexp -inline [get_attr slack_by_mode ${obj}] ${timingMode}] 1] 
	} else {
	    puts "Computing \'\# of Violations\' for cost_group \'[basename $obj]\'..."
	    set cgSlack [get_attr slack $obj]
	}
	if {${cgSlack} eq "no_value"} { set pathExists 0 }
	set numViol 0
	if {${pathExists}} {
	    if {${cgSlack} < 0} {
		if {[llength ${timingMode}]} {
		    redirect -variable endpInfo {report timing -mode ${timingMode} -end -cost_group $obj -slack 0}
		} else {
		    redirect -variable endpInfo {report timing -end -cost_group $obj -slack 0}
		}
		foreach token ${endpInfo} {
		    if {![regexp {^(\-\S+)ps} $token match endpSlack]} { continue }
		    incr numViol
		}
	    }
	} else {
	    set numViol "No Paths"
	}
	### Rename it back as the original proc.
	rename ::report::header ::report::qor::new_header
	rename ::report::qor::oldheader ::report::header
	return $numViol
    }
    
    #------------------------------------------------------
    # 
    # 
    # 
    # 
    # 
    # 
    #------------------------------------------------------
    hidden_proc GetCgTNS { obj } {
	variable $::ns(genrpt)::modeName

	rename ::report::header ::report::qor::oldheader
	rename ::report::qor::new_header ::report::header
	set pathExists 1
	set timingMode ${modeName}
	if {[llength [find / -mode *]] && ![llength ${modeName}]} { set timingMode [eval GetCgCritMode ${obj}] }

	if {[llength [find / -mode *]]} { 
	    puts "Computing \'TNS\' for cost_group \'[basename $obj] (mode: [basename $timingMode])\'..."
	    set cgSlack [lindex [lsearch -regexp -inline [get_attr slack_by_mode ${obj}] ${timingMode}] 1] 
	} else {
	    puts "Computing \'TNS\' for cost_group \'[basename $obj]\'..."
	    set cgSlack [get_attr slack $obj]
	}
	if {${cgSlack} eq "no_value"} { set pathExists 0 }
	set cgTns 0
	if {${pathExists} && [expr {${cgSlack} < 0}]} {
	    if {[llength ${modeName}]} {
		redirect -variable endpInfo {report timing -mode ${timingMode} -end -cost_group $obj -slack 0}
	    } else {
		redirect -variable endpInfo {report timing -end -cost_group $obj -slack 0}
	    }
	    foreach token ${endpInfo} {
		if {![regexp {([\+\-]\S+)ps} $token match endpSlack]} { continue }
		incr cgTns $endpSlack
	    }
	}
	### Rename it back as the original proc.
	rename ::report::header ::report::qor::new_header
	rename ::report::qor::oldheader ::report::header
	return $cgTns
    }
    
    #------------------------------------------------------
    # 
    # 
    # 
    # 
    # 
    # 
    #------------------------------------------------------
    proc userInstArea {inst} {
	set cell [dbInstCell $inst]
	set dim [dbCellDim $cell]
	set x [dbDBUToMicrons [lindex $dim 0]]
	set y [dbDBUToMicrons [lindex $dim 1]]
	set boxArea [expr {$x * $y}]
	return $boxArea
    }

    #------------------------------------------------------
    # 
    # 
    # 
    # 
    # 
    # 
    #------------------------------------------------------
    proc UpdateEdiMetrics {} {
	##nagelfar syntax dbForEachCellInst
	##nagelfar syntax dbHeadTopCell
	##nagelfar syntax dbInstCell
	##nagelfar syntax dbIsInstIo
	##nagelfar syntax dbCellDim
	##nagelfar syntax dbDBUToMicrons
	upvar $::ns(genrpt)::designMetrics designMetrics
	unset -nocomplain designMetrics
	array set designMetrics [list "cellArea" 0 "ioArea" 0 "bbArea" 0 "blockArea" 0 "areaIoArea" 0 "stdcellArea" 0 "seqArea" 0 "otherArea" 0]
	array set designMetrics [list "cellCount" 0 "ioCount" 0 "bbCount" 0 "blockCount" 0 "areaIoCount" 0 "stdcellCount" 0 "seqCount" 0 "otherCount" 0 "invCount" 0 "bufCount" 0]

	dbForEachCellInst [dbHeadTopCell] inst {
	    set cell [dbInstCell $inst]
	    set instArea [userInstArea $inst]
	    set designMetrics(cellArea) [expr {$designMetrics(cellArea) + ${instArea}}]
	    incr designMetrics(cellCount)
	    if {[dbIsInstIo $inst]} {
		set designMetrics(ioArea) [expr {$designMetrics(ioArea) + ${instArea}}]
		incr designMetrics(ioCount)
	    } elseif {[dbIsInstBlock $inst]} {
		if {[dbIsInstBlackBox $inst]} {
		    set designMetrics(bbArea) [expr {$designMetrics(bbArea) + ${instArea}}]
		    incr designMetrics(bbCount)
		} else {
		    set designMetrics(blockArea) [expr {$designMetrics(blockArea) + ${instArea}}]
		    incr designMetrics(blockCount)
		}
	    } elseif {[dbIsInstStdCell $inst]} {
		if {[dbIsInstAreaIo $inst]} {
		    set designMetrics(areaIoArea) [expr {$designMetrics(areaIoArea) + ${instArea}}]
		    incr designMetrics(areaIoCount)
		} else {
		    set designMetrics(stdcellArea) [expr {$designMetrics(stdcellArea) + ${instArea}}]
		    incr designMetrics(stdcellCount)
		    if {[ckIsInstanceBuf $inst] == 2} {
			incr designMetrics(invCount)
		    } elseif {[ckIsInstanceBuf $inst] == 1} {
			incr designMetrics(bufCount)
		    } elseif {[dbIsCellSequential $cell]} {
			set designMetrics(seqArea) [expr {$designMetrics(seqArea) + ${instArea}}]
			incr designMetrics(seqCount)
		    } else {
			set designMetrics(otherArea) [expr {$designMetrics(otherArea) + ${instArea}}]
			incr designMetrics(otherCount)
		    }
		}
	    }
	}
	foreach areaMetric [array names designMetrics *Area] { set designMetrics($areaMetric) [format "%.2f" $designMetrics($areaMetric)] }
	return
    }

    #------------------------------------------------------
    # 
    # 
    # 
    # 
    # 
    # 
    #------------------------------------------------------
    proc UpdateCtosMetrics {} {
	##nagelfar syntax get_design
	upvar ${::ns(genrpt)}::designMetrics designMetrics
	unset -nocomplain designMetrics
	array set designMetrics [list "area" 0 "power" 0 "cellCount" 0 "userCount" 0 "seqCount" 0 "seqArea" 0 "seqPower" 0]
	array set designMetrics [list "muxCount" 0 "muxArea" 0 "muxPower" 0 "otherCount" 0 "otherArea" 0 "otherPower" 0 "userCount" 0]

	set topModule [::get_attr top_module [get_design]]
	set designMetrics(area) [::get_attr area ${topModule}]
	set designMetrics(power) [::get_attr power ${topModule}]
	
	puts "Collecting Design Metrics..."
	foreach instName [::find -inst *] {
	    set instArea [::get_attr area ${instName}]
	    set instPower [::get_attr power ${instName}]
	    set masterName [::get_attr master ${instName}]
	    if {[::get_attr is_user_created ${instName}]} { 
		incr designMetrics(userCount) 
	    } else {
		switch -glob [::get_attr name ${masterName}] {
		    flipflop*	{ 
			incr designMetrics(seqCount) [::get_attr width ${instName}/inst_terms/Q]
			set designMetrics(seqArea) [expr {$designMetrics(seqArea) + ${instArea}}]
			set designMetrics(seqPower) [expr {$designMetrics(seqPower) + ${instPower}}]
		    }
		    mux_* {
			incr designMetrics(muxCount)
			set designMetrics(muxArea) [expr {$designMetrics(muxArea) + ${instArea}}]
			set designMetrics(muxPower) [expr {$designMetrics(muxPower) + ${instPower}}]
		    }
		    default {
			incr designMetrics(otherCount)
			set designMetrics(otherArea) [expr {$designMetrics(otherArea) + ${instArea}}]
			set designMetrics(otherPower) [expr {$designMetrics(otherPower) + ${instPower}}]
		    }
		}
	    }
	}
	set designMetrics(cellCount) [expr {$designMetrics(otherCount) + $designMetrics(muxCount) + $designMetrics(seqCount)}]
	set designMetrics(memUsage) [get_attr memory_usage /]
	return
    }

    #------------------------------------------------------
    # 
    # 
    # 
    # 
    # 
    # 
    #------------------------------------------------------
    hidden_proc GetCgCritPeriod { args } {
	# Parse command line switches
	# return an error if incorrect arguments are given
	switch -- [parse_options [calling_proc] {} $args \
		       "-mode dos(mode) specify which mode to report for when mutli-mode design (default is worst slack mode)" modeName \
		       "srm cost group to provide critical period information for" obj ] {
			   -2 { return }
			   0 { return -code error }
	}
	
	if {[regexp {no_value} [get_attr slack $obj]]} { return "N/A" }
	
	array set endInfo [lindex [get_attr timing_info [get_attr critical_endpoint $obj]] 0]
	if {[string match "unclocked" [lindex $endInfo(capture) 0]]} { return "Unclocked" }
	return [format "%.2f" [expr {[get_attr period [lindex $endInfo(capture) 0]] / [get_attr divide_period [lindex $endInfo(capture) 0]]}]]
    }

    #------------------------------------------------------
    # 
    # 
    # 
    # 
    # 
    # 
    #------------------------------------------------------
    hidden_proc GetCgCritFreq { args } {
	# Parse command line switches
	# return an error if incorrect arguments are given
	switch -- [parse_options [calling_proc] {} $args \
		       "-mode dos(mode) specify which mode to report for when mutli-mode design (default is worst slack mode)" modeName \
		       "srm cost group to provide critical period information for" obj ] {
			   -2 { return }
			   0 { return -code error }
	}
	
	if {[regexp {no_value} [get_attr slack $obj]]} { return "N/A" }
	if {[regexp {Unclocked} [eval GetCgCritPeriod ${obj}]]} { return "Unclocked" }
	
	set cgSlack [get_attr slack $obj]
	return [format "%.1f" [expr {1000000 / ([eval GetCgCritPeriod ${obj}] - ${cgSlack})}]]
    }

    #------------------------------------------------------
    # This procedure updates fields automatically if no
    # value is provided. It will first check for the 
    # existance of an attribute of the specified name and 
    # check for a variable if an attribute does not exist
    # If neither variable nor attribute  exists a null
    # value will be entered
    #------------------------------------------------------
    hidden_proc GetFields { args } {
	# Parse command line switches
	# return an error if incorrect arguments are given
	switch -- [parse_options [calling_proc] {} $args \
		       "-no_init bos Do not override values of fields based on content and variable / attribute names" noInit \
		       "-multi bos Specify that field information is for a multi-line field" isMulti \
		       "srm <field information list> <Design name>" argInfo ] {
			   -2 { return }
			   0 { return -code error }
	}
	
	upvar [lindex $argInfo 0] allInfo
	if {![info exists allInfo]} { 
	    puts "Info: variable \'[lindex $argInfo 0]\' does not exist"
	    return 
	}
	if {![llength $allInfo]} { 
	    puts "Info: variable \'[lindex $argInfo 0]\' is empty"
	    return 
	}
	set design [lindex $argInfo 1]
	set groupCount [llength $allInfo]
	set fieldInfo $allInfo 
	
	# Following condition mimics do-until construct
	for { set groupIndex 0 } { $groupIndex < $groupCount } { incr groupIndex } {
	    set updatedInfo {}
	    if {$isMulti} {
		set groupName [lindex $allInfo $groupIndex 0]
		set fieldInfo [lindex $allInfo $groupIndex 1]
	    } else {
		set groupCount 0 ;# Make loop exit after first iteration for single-line fields
	    }
	    for { set count 0 } { $count < [llength $fieldInfo] } { incr count } {
		# lrange is needed instead of lindex since lindex would result in misshandling of string arguments
		# The following list {a {b c} d} shows the issue when doing
		# lindex {a {b c} d} 1
		# lrange {a {b c} d} 1 1 
		# However, lindex is still needed in most cases since otherwise everything becomes a string
		set field [lindex $fieldInfo $count]
		if {[regexp {%$} $field]} { set field [lrange $fieldInfo $count $count] }
		# Look for expression '<LINK=<file/URL link name>>' 
		# if it exists store and determine if file or URL
		# Example expressions:
		# "WNS [ps]%slack%<LINK=timing_report.rpt>"
		# "WNS [ps]%slack%<LINK=www.cadence.com/my_report.html>"
		unset -nocomplain linkInfo colorInfo precInfo scaleInfo gtInfo ltInfo percent blank isSec indexInfo
		if {[regexp {<FIELD\(((\s|\d|start|end)+)\)>} $field match indexInfo]} { set field [string map [list $match ""] $field] }
		if {[regexp {<SCALE\((\S+?)\)>} $field match scaleInfo]} { set field [string map [list $match ""] $field] }
		if {[regexp {<PREC\((\S+?)\)>} $field match precInfo]} { set field [string map [list $match ""] $field] }
		if {[regexp {<PERCENT>} $field match]} { set field [string map [list $match ""] $field]; set percent 1; }
		if {[regexp {<GT\((\S+?)\)>} $field match gtInfo]} { set field [string map [list $match ""] $field] }
		if {[regexp {<LT\((\S+?)\)>} $field match ltInfo]} { set field [string map [list $match ""] $field] }
		if {[regexp {<COLOR\((\S+?)\)>} $field match colorInfo]} { set field [string map [list $match ""] $field] }
		if {[regexp {<LINK=(\S+?)>} $field match linkInfo]} { set field [string map [list $match ""] $field] }
		if {[regexp {<BLANK>} $field match]} { set field [string map [list $match ""] $field]; set blank 1 }
		if {[regexp {<SEC>} $field match]} { set field [string map [list $match ""] $field]; set isSec 1 }
		# Error case
		if { [llength $field] > 2 } {
		    puts "Error: invalid syntax for parameter \'$field\'"
		    return
		}
		# needed to handle special case where a formatting has been provided on a blank such as
		# [list "PARAM" "<SCALE(*1000)>"]
		if { [expr {[llength $field] == 1}] && 
		     ![regexp {%$} [lindex $field 0]] && 
		     [regexp { $} $field]} {
		    unset -nocomplain linkInfo colorInfo precInfo scaleInfo gtInfo ltInfo percent blank isSec indexInfo
		    lappend field ""
		}
		# Case of <name>%<attr|var|cmd>% 
		if { [llength $field] == 1 } {
		    set attrName [lindex $field 0]
		    set fieldName [lindex $field 0]
		    # Look for the syntax <display name>%<attribute|variable|command block>%
		    # This was provided to support display names that may be
		    # clearer than the attribute name
		    regexp {(.*?)%(\S+|\[.*\])%\s*$} [lindex ${field} 0] match fieldName attrName ;# lindex is needed to deal with {} in some cases
		    # Special case where command is value of the tag
		    # Case of <name>%<cmd>% 
		    if {[regexp {^\[(.*)\]$} $attrName match cmdExpr]} {
			if { [catch {set fieldVal [eval $cmdExpr]} errMsg] } {
			    set fieldVal ""
			    puts "Error in custom/multi_custom expression!\n\t${field}\n\t$errMsg"
			}
			set field [list $fieldName $fieldVal]
		    } else {
			# Case of <name>%<attr|var>% 
			if {[llength [split $attrName %]] > 1} {
			    set objName [lindex [split $attrName %] 1]
			    set attrName [lindex [split $attrName %] 0]
			}
			# Need to use fully qualified namespace path in cases when it is a variable
			# Need to handle array as a special case since namespace which work on the 
			# array but not the elements of it
			if {[regexp {(\S+)(\(\S+\))} $attrName match varRoot varIndex]} {
			    set varName [format "%s%s" [namespace which -variable $varRoot] $varIndex]
			} else {
			    set varName [namespace which -variable $attrName]
			}
			if {[info exists objName]} {
			    if { ![catch {redirect /dev/null { get_attr $attrName $objName }} attrVal] } {
				if {!$noInit} {
				    switch $attrName {
					"tns" { 
					    if {[string match [get_attr slack $objName] no_value]} { 
						set attrVal "No Paths" 
					    } elseif {$attrVal != 0} { 
						set attrVal [expr {-$attrVal}]
					    }
					}
					"slack" { if {[string match $attrVal no_value]} { set attrVal "No Paths" } }
					"actual_target" { if {[string match $attrVal no_value]} { set attrVal "N/A" } }
				    }
				}
				set field [list $fieldName $attrVal] 
			    }
			    unset objName
			} elseif { ![catch {redirect /dev/null {get_attr $attrName $design}} attrVal] } {
			    set field [list $fieldName $attrVal] 
			} elseif { ![catch {redirect /dev/null {get_attr $attrName /}} attrVal] } {
			    set field [list $fieldName [get_attr $attrName /]] 
			} elseif {[info exists [set varName]]} {
			    # Need to make sure variable have only one argument
			    if { [eval llength $$varName] != 1 } {
				puts "Info: Field \'${attrName}\' has more than one argument"
				puts "\tN/A will be assumed."
				set field [list $fieldName "N/A"]
			    } else {
				# Note that attrName needs to be dereferenced
				set varValue [set [set varName]]
				set field [list $fieldName $varValue]
			    }
			} else {
			    puts "Info: Field \'${attrName}\' is not an attribute or :: namespace variable"
			    puts "\tN/A will be assumed."
			    set field [list $fieldName "N/A"]
			}
		    }
		}
		# Process formatting information if such information was provided
		set fieldVal [lindex $field 1]
		set fieldOpt ""
		# Numeric operations need to happen before formatting or else numbers will become strings
		if {[info exists indexInfo]} { set fieldVal [lindex $fieldVal $indexInfo] } 
		if {[string is double $fieldVal] && ($fieldVal ne "")} {
		    ##nagelfar ignore
		    if {[info exists scaleInfo]} { set fieldVal [expr $fieldVal $scaleInfo] } 
		    if {[info exists precInfo] && ![info exists percent]} { set fieldVal [format "%${precInfo}f" ${fieldVal}] }
		    if {[info exists gtInfo] && [expr {$fieldVal > [lindex [split $gtInfo ,] 0]}]}   {
			if {[llength [split $gtInfo ,]] == 1} {
			    append fieldOpt "<<GT:red>>"
			} else {
			    append fieldOpt "<<GT:[lindex [split $gtInfo ,] 1]>>"
			}
		    } elseif {[info exists ltInfo] && [expr {$fieldVal < [lindex [split $ltInfo ,] 0]}]} {
			if {[llength [split $ltInfo ,]] == 1} {
			    append fieldOpt "<<LT:green>>"
			} else {
			    append fieldOpt "<<LT:[lindex [split $ltInfo ,] 1]>>"
			}
		    } 
		    if {[info exists percent]}  { 
			set fieldVal [format "%.2f %%" [expr {${fieldVal}*100.0}]] 
		    } elseif {[info exists isSec]} { 
			set fieldVal [eval ${::ns(compat)}::SecToTime -precise ${fieldVal}] 
		    } 
		    append fieldVal ${fieldOpt}
		}
		if {[info exists colorInfo]} { set fieldVal "${fieldVal}<<COLOR(${colorInfo})>>" } 
		if {[info exists linkInfo]}  { set fieldVal "<a href=\"${linkInfo}\" target=\"[get_attr genrpt_link_target /]\">${fieldVal}</a>" } 
		if {[info exists blank]}     { set fieldVal "" } 
		# Build a new list with updated values where applicable
		set field [lreplace $field 1 1 ${fieldVal}]
		lappend updatedInfo $field
		if {!${isMulti}} { time_info -quiet -table genrpt -stamp "[lindex ${field} 0]" }
	    }
	    if {$isMulti} { 
		lappend updatedMulti [list $groupName $updatedInfo] 
		regsub  -all {</?(br|span|big)[^>]*>} ${groupName} "" groupId
		time_info -quiet -table genrpt -stamp "${groupId}"
	    }
	}
	if {$isMulti} { return $updatedMulti }
	return ${updatedInfo}
    }    
    
    #------------------------------------------------------
    # This procedure creates an HTML template file
    # to be used as a QoR report
    #------------------------------------------------------
    hidden_proc CreateHTML { htmlTbl fieldInfo } {
	upvar ${::ns(genrpt)}::htmlReportTitle htmlReportTitle
	upvar $htmlTbl tbl
	
	if {![llength $htmlReportTitle]} { set htmlReportTitle "RTL Compiler QoR Report" }
	set headerColor [get_attr genrpt_header_color /]
	set wrap "nowrap "
	if {[get_attr genrpt_allow_wrap /]} { set wrap "" }
	
	# Remove table if one already existed
	if {[info exists tbl]} { array unset tbl }

	# Define header information
	set tbl(header) {"<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">" "<html>"}
	lappend tbl(header) "<head>"
	lappend tbl(header) "  <meta http-equiv=\"content-type\" content=\"text/html; charset=ISO-8859-1\">"
	lappend tbl(header) "  <title>$htmlReportTitle</title>"
	lappend tbl(header) "</head>"
	lappend tbl(header) "<body>"
	lappend tbl(header) "<table cellpadding=\"4\" cellspacing=\"0\" border=\"1\" style=\"text-align: left; margin-left: auto; margin-right: auto;\">"
	
	# Define footer information
	set tbl(footer) "</table>"
	lappend tbl(footer) "<br>"
	lappend tbl(footer) "</body>"
	lappend tbl(footer) "</html>"
	
	# Define table title row
	set tbl(format,0) "<tr align=\"center\">"
	set tbl(anchor,0:0) "0:0"
	set tbl(format,0:0) "<td ${wrap}style=\"vertical-align: top; background-color: $headerColor;\" rowspan=\"1\" colspan=\"2\"><big>"
	set tbl(value,0:0) "<span style=\"font-weight: bold;\">$htmlReportTitle</span></big><br>"
	array set tbl [list "anchor,0:1" "0:0" "format,0:1" {} "value,0:1" {}]
	
	# Define table contents
	set row 1
	foreach field $fieldInfo {
	    set fieldName [lindex $field 0]
	    set tbl(format,${row}) "<tr>"
	    set tbl(anchor,${row}:0) "${row}:0"
	    set tbl(format,${row}:0) "<td ${wrap}style=\"vertical-align: top; text-align: left; background-color: [get_attr genrpt_field_color /];\" rowspan=\"1\" colspan=\"2\">"
	    set tbl(value,${row}:0) "$fieldName"
	    array set tbl [list "anchor,${row}:1" "${row}:0" "format,${row}:1" {} "value,${row}:1" {}]
	    incr row
	}

	# Initialize table metrics
	set tbl(width) 2
	set tbl(height) [expr {[llength $fieldInfo] + 1}]
	return
    }
    
    #------------------------------------------------------
    # This procedure update an existing HTML template file
    # with the design's QoR information
    #------------------------------------------------------
    proc UpdateHTML {args} {
	# Parse command line switches
	# return an error if incorrect arguments are given
	switch -- [parse_options [calling_proc] {} $args							\
		       "-fields sos custom parameter list {{custom1 value1}...{custom_n value_n}}" fieldInfo	\
		       "-multi_fields sos custom parameter list for multi-row fields {{group_tag {{tag1 val1}...{tag_n val_n}}}...}" multiFieldInfo \
		       "-update nos column number to be updated(no columns will be inserted)" updateCol		\
		       "srs variable containing table information" htmlTbl] {
			   -2 { return }
			   0 { return -code error }
	}
	upvar $::ns(genrpt)::grpNameW grpNameW
	upvar $::ns(genrpt)::grpFieldW grpFieldW
	upvar $::ns(genrpt)::fieldW fieldW
	upvar $::ns(genrpt)::htmlReportTitle htmlReportTitle
	upvar $htmlTbl tbl
	

	set wrap "nowrap "
	if {[get_attr genrpt_allow_wrap /]} { set wrap "" }
	
	set multiFieldTags {}
	for {set i 0} {$i < [llength $multiFieldInfo]} {incr i} { lappend multiFieldTags [lindex $multiFieldInfo $i 0] }

	set isMulti 0
	variable $::ns(genrpt)::blankColor
	
	set titleLineNumber [lsearch -regexp $tbl(header) {<title>.*</title>}]
	set titleLine [lindex $tbl(header) ${titleLineNumber}]
	regexp "<title>(.+)</title>" $titleLine match currentTitle
	if {[expr {$titleLineNumber != -1}] && [llength $htmlReportTitle]} {
	    regsub $currentTitle $titleLine $htmlReportTitle titleLine 
	    lset tbl(header) $titleLineNumber $titleLine
	    set tbl(value,0:0) "<big><span style=\"font-weight: bold;\">${htmlReportTitle}</span></big>"
	}
	
	
	set addCol 0
	if { ![llength $updateCol] || [expr {${updateCol} >= $tbl(width)}] } {
	    set addCol 1
	    set updateCol $tbl(width)
	    eval InsertTblCol "tbl"

	    # Update header
	    regsub {colspan="\d+"} $tbl(format,0:0) "colspan=\"$tbl(width)\"" tbl(format,0:0)
	    array set tbl [list "anchor,0:${updateCol}" "0:0" "format,0:${updateCol}" {} "value,0:${updateCol}" {}]
	}

	for {set row 1} {${row} < $tbl(height)} {incr row} {
	    # Identify multi-field vs single-field 
	    set isMulti 1
	    if {[string match $tbl(anchor,${row}:0) $tbl(anchor,${row}:1)]} { set isMulti 0 }
	    if {$isMulti} {
		# Extract group and field information if currently on table
		set currGroupName $tbl(value,${row}:0)
		set groupIndex [lsearch -regexp ${multiFieldTags} "${currGroupName}"]
		# Check if the group on the table is on the groups provided
		set groupFields {}
		if { ${groupIndex} != -1 } { set groupFields [lindex ${multiFieldInfo} ${groupIndex} 1] }
		set fieldCount [eval GetCellSpan -row -cell "${row}:0" "tbl"]
		# Build single field list based on table fields and multi-field specification
		for {set i 0} {${i} < ${fieldCount}} {incr i} { 
		    set fieldRow [expr {${row} + ${i}}]
		    # Need to replace [<expr>] strings to avoid TCL processing issues
		    regsub {\s*[\[\(]\w+[\]\)]\s*} $tbl(value,${fieldRow}:1) "" currFieldName
		    set fieldIndex [lsearch -regexp ${groupFields} "${currFieldName}"]
		    if { [expr {${groupIndex} == -1} ] || [expr {${fieldIndex} == -1}] } {
			if {$addCol} { eval InsertReportRow -update ${updateCol} -value [list ""] -row ${fieldRow} "tbl" }
		    } else {
			eval InsertReportRow -update ${updateCol} -value [list [lindex ${groupFields} ${fieldIndex} 1]] -row ${fieldRow} "tbl"
			set groupFields [lreplace ${groupFields} ${fieldIndex} ${fieldIndex}]	;# Remove subfields of multi-field already populated
		    }
		}
		set multiFieldInfo [lreplace ${multiFieldInfo} ${groupIndex} ${groupIndex}]	;# Remove multi-fields already found in table
		set multiFieldTags [lreplace ${multiFieldTags} ${groupIndex} ${groupIndex}]	;# same is necessary for tags so they align
		incr row [expr {${fieldCount} - 1}]
		for {set i 0} {${i} < [llength $groupFields]} {incr i} { 
		    eval InsertReportRow -multi [list ${currGroupName}] -name [list [lindex ${groupFields} ${i} 0]] -value [list [lindex ${groupFields} ${i} 1]] -row ${row} "tbl"
		    incr row
		}
	    } else {
		regsub {\s*[\[\(]\w+[\]\)]\s*} $tbl(value,${row}:0) "" currFieldName
		set fieldIndex [lsearch -regexp ${fieldInfo} "${currFieldName}"]
		# If fieldInfo field already exists fill in info
		# otherwise gray out
		if {[expr {${fieldIndex} == -1}]} {
		    if {${addCol}} { eval InsertReportRow -update ${updateCol} -value [list ""] -row ${row} "tbl" }
		} else {
		    set bgColor ""
		    set fieldVal [lindex ${fieldInfo} ${fieldIndex} 1]
		    if {[regexp {<<GT:(\w+)>>} $fieldVal match gtColor]} { set bgColor " background-color: ${gtColor};" }
		    if {[regexp {<<LT:(\w+)>>} $fieldVal match ltColor]} { set bgColor " background-color: ${ltColor};" }
		    if {[regexp {<<COLOR\((\S+)\)>>} $fieldVal match colorInfo]} { set bgColor " background-color: ${colorInfo};" }
		    if {[llength $bgColor]} { regsub -all {<<(GT|LT|COLOR)[:\(]\w+\)?>>} $fieldVal "" fieldVal }
		    set tbl(format,${row}:${updateCol}) "<td ${wrap}style=\"vertical-align: top; text-align: right;${bgColor}\">"
#		    set tbl(format,${row}:${updateCol}) "<td ${wrap}style=\"vertical-align: top; text-align: right;\">"
		    # Insert blank for empty fields
		    if {![llength $fieldVal]} { set tbl(format,${row}:${updateCol}) "<td ${wrap}style=\"vertical-align: top; text-align: right; background-color: ${blankColor};\">" }

		    set tbl(value,${row}:${updateCol})  "$fieldVal"
		    set fieldInfo [lreplace ${fieldInfo} ${fieldIndex} ${fieldIndex}]	;# delete updated field from single-field list
		}
	    }
	}

 	for { set count 0 } { $count < [llength $fieldInfo] } { incr count } {
	    set field [lindex $fieldInfo $count]
	    set fieldName [lindex $field 0]
	    set fieldVal  [lindex $field 1]
	    # Insert empty row and update appropriate column
	    eval InsertReportRow -name [list ${fieldName}] -value [list ""] "tbl"
	    eval InsertReportRow -row ${row} -update ${updateCol} -name [list ${fieldName}] -value [list ${fieldVal}] "tbl"
	    incr row
	}		       

	foreach multiField $multiFieldInfo {
	    set groupName   [lindex $multiField 0]
	    set groupFields [lindex $multiField 1]
	    set fieldCount  [expr {[llength $groupFields] - 1}]
	    # insert group name header
	    for { set fieldIndex $fieldCount } { ${fieldIndex} >= 0 } { incr fieldIndex -1} {
		set fieldName [lindex ${groupFields} ${fieldIndex} 0]
		set fieldVal [lindex ${groupFields} ${fieldIndex} 1]
		# Insert empty row and update appropriate column
		eval InsertReportRow -row ${row} -multi [list ${groupName}] -name [list ${fieldName}] -value [list ""] "tbl"
		eval InsertReportRow -update ${updateCol} -row ${row} -multi [list ${groupName}] -name [list ${fieldName}] -value [list ${fieldVal}] "tbl"
	    }
	    incr row [llength ${groupFields}]
	}
    }
    
    
    #------------------------------------------------------
    # This procedure compares the last column to the first
    # column and adds % difference on the last column
    #------------------------------------------------------
    hidden_proc CompareColumn { args } {
	set threshold 0
	set baseCol 2
	# Parse command line switches
	# return an error if incorrect arguments are given
	switch -- [parse_options [calling_proc] {} $args \
		       "-threshold nos specify % delta during the comparison to enable highlighting" threshold	\
		       "-base_col nOs column to be used as base line for data comparison(default is first data column)" baseCol \
		       "srs variable containing table information" tblInfo ] {
			   -2 { return }
			   0 { return -code error }
	}
	upvar ${tblInfo} tbl
	
	variable $::ns(genrpt)::gtColor
	variable $::ns(genrpt)::ltColor
	variable $::ns(genrpt)::blankColor
	
	set wrap "nowrap "
	if {[get_attr genrpt_allow_wrap /]} { set wrap "" }
	
	set minMaxMode 0
	if { $threshold < 0 } { set minMaxMode 1 }
	
	set compCol  [expr {$tbl(width) - 1}]
	set deltaCol $tbl(width)

	if { [regexp "[get_attr genrpt_name_field /]" $tbl(value,1:0)]  && !${minMaxMode} } { 
	    eval InsertTblCol "tbl"

	    # Update header
	    regsub {colspan="\d+"} $tbl(format,0:0) "colspan=\"$tbl(width)\"" tbl(format,0:0)
	    array set tbl [list "anchor,0:${deltaCol}" "0:0" "format,0:${deltaCol}" {} "value,0:${deltaCol}" {}]
	    set tbl(value,1:${deltaCol}) "&\#916 (C[expr {${baseCol} - 1}] vs. C[expr {${compCol} - 1}])" 
	}

	for {set row 2} {${row} < $tbl(height)} {incr row} {
	    if {${minMaxMode}} {
		set valCount 0
		if {[info exists minCell]} { unset minCell; unset maxCell; }
		for {set col 2} {${col} < ${deltaCol}} {incr col} {
		    if { [info exists tbl(value,${row}:${col})] &&
			 [regexp {\d+(\.\d+)?} $tbl(value,${row}:${col}) fieldVal] } {
			incr valCount
			# Remove formatting information if minMax mode was already applied
			regsub {\s*background-color:\s+rgb\(\d+,\s*\d+,\s*\d+\);} $tbl(format,${row}:${col}) "" tbl(format,${row}:${col}) 
			if {![info exists minCell]} {
			    set minCell(value) ${fieldVal}
			    set minCell(col)   ${col}
			    set maxCell(value) ${fieldVal}
			    set maxCell(col)   ${col}
			} else {
			    if { ${fieldVal} < $minCell(value) } { 
				set minCell(value) $fieldVal 
				set minCell(col)   $col 
			    }
			    if { ${fieldVal} > $maxCell(value) } { 
				set maxCell(value) $fieldVal 
				set maxCell(col)   $col 
			    }
			}
		    }
		}
		if { ${valCount} >= 2 } {
		    set tbl(format,${row}:$maxCell(col)) "<td ${wrap}style=\"vertical-align: top; text-align: right; background-color: $gtColor;\">"
		    set tbl(format,${row}:$minCell(col)) "<td ${wrap}style=\"vertical-align: top; text-align: right; background-color: $ltColor;\">"
		}
	    } else {
		if { [regexp {^[-+]?\d+(\.\d+)?$} $tbl(value,${row}:${baseCol}) baseVal] &&
		     [regexp {^[-+]?\d+(\.\d+)?$} $tbl(value,${row}:${compCol}) compVal] &&
		     [expr {$baseVal != 0}] } {
		    set deltaVal [format "%.2f" [expr {100 * (1.0  * (${compVal} - ${baseVal})/ ${baseVal})}]]
		    # Need to add '+' sign for positive deltas
		    if { ${deltaVal} > 0 }  { 
			set deltaString "+${deltaVal} %" 
			set tbl(format,${row}:${deltaCol}) "<td ${wrap}style=\"vertical-align: top; text-align: right; background-color: $gtColor;\">"
			if {![expr {abs(${deltaVal}) > $threshold}]} { set tbl(format,${row}:${deltaCol}) "<td ${wrap}style=\"vertical-align: top; text-align: right;\">" }
		    } elseif { $deltaVal < 0 } {
			set deltaString "${deltaVal} %" 
			set tbl(format,${row}:${deltaCol}) "<td ${wrap}style=\"vertical-align: top; text-align: right; background-color: $ltColor;\">"
			if {![expr {abs(${deltaVal}) > $threshold}]} { set tbl(format,${row}:${deltaCol}) "<td ${wrap}style=\"vertical-align: top; text-align: right;\">" }
		    } else {
			set deltaString "${deltaVal} %" 
			set tbl(format,${row}:${deltaCol}) "<td ${wrap}style=\"vertical-align: top; text-align: right;\">"
		    }
		    set tbl(value,${row}:${deltaCol}) ${deltaString}
		} else {
		    set tbl(format,${row}:${deltaCol}) "<td ${wrap}style=\"vertical-align: top; text-align: right; background-color: ${blankColor};\">"
		    set tbl(value,${row}:${deltaCol}) ""
		}
	    }
	}
    }
    

    proc ReorderHTML {args} {
	switch -- [parse_options [calling_proc] {} $args	\
		       "-fields sos custom parameter list {{custom1 value1}...{custom_n value_n}}" fieldInfo	\
		       "-multi_fields sos custom parameter list for multi-row fields {{group_tag {{tag1 val1}...{tag_n val_n}}}...}" multiFieldInfo \
		       "srs variable containing table information" tblData] {
			   -2 { return }
			   0 { return -code error }
	}

	upvar $tblData tbl

	set orderedTbl(header) $tbl(header)
	set orderedTbl(footer) $tbl(footer)
	set orderedTbl(height) $tbl(height)
	set orderedTbl(width)  $tbl(width)

	# Handling is trickier than anticipated since requested order could only have a subset of fields available
	# in the table. The issue is how to handle the fields that are not in order lists
	# Approach will be to preserve precedence of unlisted fields to those listed
	# if a table has {A B C D E}
	# and reorder is {E B D}
	# final result will be {E A B C D} such that A stays before B and C stays before D
	# Confusing indeed but had to come up with some rule
	set orderedTags {}
	for {set i 0} {$i < [llength $fieldInfo]} {incr i} { lappend orderedTags [lindex $fieldInfo $i 0] }
	for {set i 0} {$i < [llength $multiFieldInfo]} {incr i} { lappend orderedTags [lindex $multiFieldInfo $i 0] }

	# build list of reordered field tags/names based on specification and table contents
	# basic ideas is go through tags in table and any fields that are not in reorder
	# specification will get inserted in ordered list in appropriate location
	set unspecifiedTags {}
	set tblTags {{}}		;# Create empty row for header; otherwise reference will be shifter by one row
 	for {set row 1} {${row} < $tbl(height)} {incr row} {
 	    if {![string match $tbl(anchor,${row}:0) "${row}:0"]} { 
		lappend tblTags {}
		continue 
	    }
	    lappend tblTags $tbl(value,${row}:0)
 	    set tagId [lsearch -exact $orderedTags $tbl(value,${row}:0)]
 	    if {$tagId != -1} { 
 		if  {[llength ${unspecifiedTags}]} { 
 		    set orderedTags [eval linsert [list ${orderedTags}] ${tagId} ${unspecifiedTags}] 
 		    set unspecifiedTags {}
 		}
 	    } else {
 		lappend unspecifiedTags $tbl(value,${row}:0)
 	    }
 	}

	# Now that the new order is known, simply copy the contents of the original table
	set row 0
	set orderedTbl(format,${row}) $tbl(format,${row}) 
	foreach rowParameter [array names tbl "*,${row}:*"] { set orderedTbl(${rowParameter}) $tbl(${rowParameter}) }
	incr row
	# iterate through all fields in ordered list, find them in original 
	# list, and create new table with appropriate order
	foreach tagName ${orderedTags} {
	    set tagRow [lsearch -exact $tblTags ${tagName}]
	    set rowSpan [eval GetCellSpan -cell "${tagRow}:0" -row "tbl"]
	    set rowDelta [expr {${row} - ${tagRow}}]
	    for {set i 0} {$i < ${rowSpan}} {incr i} {
		set orderedRow [expr {${row} + ${i}}]
		set tblRow [expr {${tagRow} + ${i}}]
		set orderedTbl(format,${orderedRow}) $tbl(format,${tblRow})
		for {set col 0} {${col} < $tbl(width)} {incr col} { 
		    set orderedTbl(format,${orderedRow}:${col}) $tbl(format,${tblRow}:${col})
		    set orderedTbl(anchor,${orderedRow}:${col}) "[expr {[lindex [split $tbl(anchor,${tblRow}:${col}) :] 0] + ${rowDelta}}]:[lindex [split $tbl(anchor,${tblRow}:${col}) :] 1]"
		    set orderedTbl(value,${orderedRow}:${col})  $tbl(value,${tblRow}:${col})
		}
	    }
	    incr row ${rowSpan}
	}

	# Finally update original table with reordered one
	array unset tbl
	array set tbl [array get orderedTbl]
    }


    # Parse HTML table into a better format to manipulate programmatically
    proc read_html {args} {
	switch -- [parse_options [calling_proc] {} $args \
		       "srs HTML file containing table description" htmlFileName \
		       "sos variable name for parsed HTML table contents" tblName] {
			   -2 { return }
			   0 { return -code error }
	}
	
	if {![llength ${tblName}]} { 
	    set tblName tbl 
	    puts "Info: no table variable name specified; using \'tbl\'..."
	}
	if {[string match $tblName "tblRaw"]} { return -code error "Error: tblRaw is a reserve name" }
	
	upvar $::ns(genrpt)::tblRaw tblRaw
	upvar $tblName tbl
	set tbl(filename) ${htmlFileName}
	set htmlFile [open "$htmlFileName" r]
	
	set strSep "</td>"		;# HTML cell separator
	set charSep "\uFFFE"		;# Special unicode separator to enable 'split' command on strings
	
	set htmlSection "header"
	set lineNumber 0
	array set tblRaw {"header" {} "data" {} "footer" {} }
	
	while {![eof $htmlFile]} {
	    set line [gets $htmlFile]
	    incr lineNumber
	    
	    # Parse HTML table into header, footer, and core/data sections
	    switch $htmlSection {
		{header} {
		    if {[regexp {<tbody} $line]} { 
			set htmlSection "data"
			continue
		    }
		    lappend tblRaw(header) $line
		}
		{data} {
		    regsub {\s+<} $line "<" line
		    if {[regexp {<tr} $line]} { set rowInfo $line }
		    if {[regexp {</tr>} $line]} { 
			if {![regexp {<tr} $line]} { append rowInfo $line }
			# magic split, map, lreplace combination to perform split on string separators
			lappend tblRaw(data) [lreplace [split [string map [list ${strSep} ${charSep}] ${rowInfo}] ${charSep}] end end]
		    }
		    if {[regexp {</tbody>} $line] && ![regexp {</tr>} $line]} { set htmlSection "footer" } 
		    if {![regexp {(<tr|</tr>)} $line]} { append rowInfo $line }
		}
		{footer} {
		    lappend tblRaw(footer) $line
		}
	    }
	}
	# Convert raw HTML table data to a more friendly and conducive table format
	eval AnalyzeTbl "tblRaw" "tbl"
    }
    
    # Write HTML file based on programmatic table generated and edited through ReadHTML 
    # and related commmands
    proc write_html {args} {
	switch -- [parse_options [calling_proc] {} $args	\
		       "srs HTML output file" htmlFileName	\
		       "srs variable containing table information" tblData] {
			   -2 { return }
			   0 { return -code error }
	}
	
	upvar $tblData tbl
	set htmlFile [open "$htmlFileName" w]
	
	foreach line $tbl(header) { puts $htmlFile $line }
	puts $htmlFile "  <tbody>"
	for {set row 0} {${row} < $tbl(height)} {incr row} {
	    if {[llength $tbl(format,${row})]} { 
		puts $htmlFile "    $tbl(format,${row})"
		for {set col 0} {${col} < $tbl(width)} {incr col} {
		    if {[string match $tbl(anchor,${row}:${col}) "${row}:${col}"]} {
			puts -nonewline $htmlFile "      $tbl(format,${row}:${col})"
			puts $htmlFile $tbl(value,${row}:${col})
			puts $htmlFile "      </td>"
		    }
		}
		puts $htmlFile "    </tr>"
	    }
	}
	puts $htmlFile "  </tbody>"
	foreach line $tbl(footer) { puts $htmlFile $line }
	close $htmlFile
	return
    }

    # Write CSV file based on programmatic table generated and edited through ReadHTML 
    # and related commmands
    proc write_csv {args} {
	switch -- [parse_options [calling_proc] {} $args	\
		       "srs CSV output file" csvFileName	\
		       "srs variable containing table information" tblData] {
			   -2 { return }
			   0 { return -code error }
	}
	
	upvar $tblData tbl
	puts "Generating CSV file \'${csvFileName}\'..."
	set csvFile [open "$csvFileName" w]
	
	for {set row 0} {${row} < $tbl(height)} {incr row} {
	    set csvLine ""
	    if {[llength $tbl(format,${row})]} { 
		for {set col 0} {${col} < $tbl(width)} {incr col} {
		    if {[string match $tbl(anchor,${row}:${col}) "${row}:${col}"]} {
			append csvLine "$tbl(value,${row}:${col}),"
		    } else {
			append csvLine ","
		    }
		}
	    } else {
		append csvLine ","
	    }
	    regsub {,* *$} $csvLine "" csvLine
	    regsub  -all {</?(br|span|big)[^>]*>} $csvLine "" csvLine
	    puts $csvFile ${csvLine}
	}
	close $csvFile
	return
    }

    # Write CSV file based on programmatic table generated and edited through ReadHTML 
    # and related commmands
    proc write_xml {args} {
	switch -- [parse_options [calling_proc] {} $args	\
		       "srs XML output file" xmlFileName	\
		       "srs variable containing table information" tblData] {
			   -2 { return }
			   0 { return -code error }
	}
	
	upvar $tblData tbl
	puts "Generating XML file \'${xmlFileName}\'..."
	set xmlFile [open "$xmlFileName" w]
	
	puts ${xmlFile} "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>"
	puts ${xmlFile} "   <report>"
	regsub -all {</?(br|span|big)[^>]*>} $tbl(value,0:0) "" xmlTitle
	puts ${xmlFile} "      <title = \'${xmlTitle}\'>"

	for {set col 2} {${col} < $tbl(width)} {incr col} {
	    puts ${xmlFile} "         <dataset name=\'$tbl(value,1:${col})\'>"
	    for {set row 2} {${row} < $tbl(height)} {incr row} {
		# determine XML field name based on group name and field name in HTML
		# since multi-levels need to be translated into XML too
		# field name will be appended to group name in multi-fields
		if {[llength $tbl(value,${row}:0)]} { set parameterBase $tbl(value,${row}:0)}
		if {[llength $tbl(value,${row}:1)]} {
		    set parameterName [format "%s_%s" ${parameterBase} $tbl(value,${row}:1)]
		} else {
		    set parameterName ${parameterBase}
		}

		# remove HTML constructs from value if applicable
		regsub -all {</?(br|span|big)[^>]*>} $parameterName "" parameterName
		# extract unit name if specified
		if {![regexp {\[(\w+)\]} ${parameterName} match parameterUnit]} { set parameterUnit "int" }
		# remove units from field names if in original name
		regsub -all {\s*\[\w+\]} ${parameterName} "" parameterName
		# replace white-space and special characters
		regsub -all {[\.: /\#]} ${parameterName} "_" parameterName
		# change case to lower case
		set parameterName [string tolower ${parameterName}]

		set xmlLine "            <${parameterName} units=\'${parameterUnit}\'>$tbl(value,${row}:${col})</${parameterName}>"
		
		puts ${xmlFile} ${xmlLine}
	    }
	    puts ${xmlFile} "         </dataset>"
	}

	puts ${xmlFile} "      </title>"
	puts ${xmlFile} "   </report>"

	close $xmlFile
	return
    }
    
    # insert a new full row or update a specific cell in a row
    proc InsertReportRow {args} {
	switch -- [parse_options [calling_proc] {} $args						\
		       "-multi_name sos name of multi-field if create a new multi-field" multiName	\
		       "-name sos name of field" fieldName						\
		       "-value srs value of field" fieldVal						\
		       "-color sos background color of row" rowColor					\
		       "-row nos row number to insert(default is after last)" insRow			\
		       "-update nos column number to be updated(no columns will be inserted)" updateCol	\
		       "srs variable containing table information" tblData] {
			   -2 { return }
			   0 { return -code error }
	}
	upvar $::ns(genrpt)::grpNameW grpNameW
	upvar $::ns(genrpt)::grpFieldW grpFieldW
	upvar $::ns(genrpt)::fieldW fieldW
	
	set wrap "nowrap "
	if {[get_attr genrpt_allow_wrap /]} { set wrap "" }
	
	variable $::ns(genrpt)::blankColor
	
	upvar $tblData tbl

	# Set defaults
	if { ![llength ${insRow}] ||
	     [expr {$insRow > $tbl(height)}] } { 
	    set insRow $tbl(height) 
	}
	
	# Error on illegal values
	if { ${insRow} < 0 } {
	    puts "Error: row \'${insRow}\' must be between \'0\' and \'$tbl(height)\'"
	    return -code error
	}

	# insert group name header
	if {![llength ${updateCol}]} { 
	    eval InsertTblRow -row ${insRow} "tbl"		;# insert rows for multi-field 
	    set updateCol [expr {$tbl(width) - 1}]
	    set startCol 0
	} else {
	    if { ${updateCol} >= $tbl(width) } { return -code error "ERROR!!! Invalid update column specified" }
	    set startCol $updateCol
	}
	set anchorRow [lindex [split $tbl(anchor,${insRow}:0) :] 0]
	set nextRow [expr {${insRow} + 1}]

	# row inserted is multi
	# next row is multi
	# not adding a row at end
	# next row is height = 1
	# next row is same group name as insertion row
	for { set col ${startCol} } { ${col} <= ${updateCol} } { incr col } {
	    set colStatus $col
	    if { [expr {$colStatus == $updateCol}] &&
		 [expr {$colStatus > 1}]} { set colStatus "update" }
	    switch ${colStatus} {
		"0" {
		    if {[llength ${multiName}]} { 
			if { ${insRow} != ${anchorRow} } {
			    # insert in middle/end of multi-field -> change group name
			    set tbl(value,${anchorRow}:${col}) ${multiName}
			} elseif { [expr {${insRow} < [expr {$tbl(height) - 1}]}] &&
				   ![string equal $tbl(anchor,${nextRow}:0) $tbl(anchor,${nextRow}:1)] && 
				   [string equal $tbl(value,${nextRow}:${col}) ${multiName}] } {
			    # insert in anchor row with matching group name -> grow group
			    set rowSpan [expr {[eval GetCellSpan -cell ${nextRow}:${col} -row "tbl"] + 1}]
			    set tbl(format,${insRow}:${col}) "<td ${wrap}style=\"vertical-align: top; background-color: [get_attr genrpt_field_color /]; width: ${grpNameW}px;\" rowspan=\"${rowSpan}\" colspan=\"1\">"
			    set tbl(value,${insRow}:${col}) ${multiName}
			    for {set i 0} {${i} < ${rowSpan}} {incr i} { 
				set tbl(anchor,[expr {${insRow} + ${i}}]:${col}) "${insRow}:${col}" 
			    }
			    set tbl(value,${nextRow}:${col}) {}
			    set tbl(format,${nextRow}:${col}) {}
			} else {
			    # insert in anchor row with non-match group name -> insert new group
			    set tbl(format,${insRow}:${col}) "<td ${wrap}style=\"vertical-align: top; background-color: [get_attr genrpt_field_color /]; width: ${grpNameW}px;\" rowspan=\"1\" colspan=\"1\">"
			    set tbl(value,${anchorRow}:${col}) ${multiName}
			}
		    } else {
			set tbl(format,${insRow}:${col}) "<td ${wrap}style=\"vertical-align: top; text-align: left; background-color: [get_attr genrpt_field_color /];\" rowspan=\"1\" colspan=\"2\">"
			if {[llength $fieldName]} { set tbl(value,${insRow}:${col}) ${fieldName} }
		    }
		}
		"1" {
		    if {[llength ${multiName}]} { 
			set tbl(format,${insRow}:${col}) "<td ${wrap}style=\"vertical-align: top; background-color: [get_attr genrpt_field_color /]; width: ${grpFieldW}px;\">"
			if {[llength $fieldName]} { set tbl(value,${insRow}:${col}) ${fieldName} }
		    } else {
			array set tbl [list "anchor,${insRow}:${col}" "${insRow}:0" "format,,${insRow}:${col}" {} "value,${insRow}:${col}" {}]
		    }
		}
		"update" {
		    # insert field value - 'No Paths' has special handling when in a multi-field
		    if { [regexp {No Paths} ${fieldVal}] && ![string match $tbl(anchor,${anchorRow}:0) $tbl(anchor,${anchorRow}:1)] } {
			set rowSpan [eval GetCellSpan -cell "${anchorRow}:0" -row "tbl"]
			for {set i ${anchorRow}} {${i} < [expr {${anchorRow} + ${rowSpan}}]} {incr i} {
			    array set tbl [list "anchor,${i}:${col}" "${anchorRow}:${col}" "format,${i}:${col}" {} "value,${i}:${col}" {}]
			}
			set tbl(value,${anchorRow}:${col}) ${fieldVal}
			set tbl(format,${anchorRow}:${col}) "<td ${wrap}style=\"vertical-align: middle; width: ${fieldW}px; text-align: right;\" rowspan=\"$rowSpan\">"
		    } else {
			if {[regexp {\w} ${fieldVal}]} {
			    set bgColor ""
			    if {[regexp {<<GT:(\w+)>>} $fieldVal match gtColor]} { set bgColor " background-color: ${gtColor};" }
			    if {[regexp {<<LT:(\w+)>>} $fieldVal match ltColor]} { set bgColor " background-color: ${ltColor};" }
			    if {[regexp {<<COLOR\((\S+)\)>>} $fieldVal match colorInfo]} { set bgColor " background-color: ${colorInfo};" }
			    if {[llength $bgColor]} { regsub -all {<<(GT|LT|COLOR)[:\(]\w+\)?>>} $fieldVal "" fieldVal }
			    set tbl(format,${insRow}:${col}) "<td ${wrap}style=\"vertical-align: top; text-align: right;${bgColor}\">"
			} else {
			    set tbl(format,${insRow}:${col}) "<td ${wrap}style=\"vertical-align: top; text-align: right; background-color: $blankColor;\">"
			}
			set tbl(value,${insRow}:${col}) ${fieldVal}
		    }
		}
		default {
		    set tbl(format,${insRow}:${col}) "<td ${wrap}style=\"vertical-align: top; text-align: right; background-color: $blankColor;\">"
		    set tbl(value,${insRow}:${col})  ""
		}
	    }
	}
    }

    # Analyze table uses raw parse HTML table data and converts it into a more conducive format
    proc GetCellSpan {args} {
	switch -- [parse_options [calling_proc] {} $args					\
		       "-row bos return row(height) span of anchor cell specified" getHeight	\
		       "-col bos return col(width) span of anchor cell specified" getWidth	\
		       "-cell srs coordinate of anchor cell(in form \'<row>:<col>\')" cell	\
		       "srs variable name containing parsed HTML of table" tblIn] {
			   -2 { return }
			   0 { return -code error }
	}
	
	upvar $tblIn   tbl
	
	if { ${getHeight} && ${getWidth} } { return -code error "Error: \'-col\'and \'-row\' cannot be specified simultaneously" }
	if {![regexp {rowspan=\"(\d+)\".*>} $tbl(format,$cell) match rowSpan]} { set rowSpan 1 }
	if {![regexp {colspan=\"(\d+)\".*>} $tbl(format,$cell) match colSpan]} { set colSpan 1 }
	
	if {${getWidth}}  { return ${colSpan} }
	if {${getHeight}} { return ${rowSpan} }
    }
    
    # Analyze table uses raw parse HTML table data and converts it into a more conducive format
    proc AnalyzeTbl {args} {
	switch -- [parse_options [calling_proc] {} $args \
		       "srs variable name containing parsed HTML of table" tblIn \
		       "srs variable name for table map of all contents" tblMap] {
			   -2 { return }
			   0 { return -code error }
	}
	
	upvar $tblIn   tbl
	upvar $tblMap  tblInfo
	
	if {[info exists tblInfo]} { unset tblInfo }
	
	set tblInfo(header) $tbl(header)
	set tblInfo(footer) $tbl(footer)
	
	for {set rawRow 0} {$rawRow < [llength $tbl(data)]} {incr rawRow} {
	    set anchorRow $rawRow
	    set rowInfo [lindex $tbl(data) $rawRow]
	    regexp {(<tr.*?>)} [lindex $rowInfo 0] match formatRow 
	    for {set rawCol 0} {$rawCol < [llength $rowInfo]} {incr rawCol} {
		set anchorCol $rawCol
		# Map rawRow,rawCol to anchorRow,anchorCol
		while { [info exists tblInfo(anchor,${anchorRow}:${anchorCol})] == 1 } { incr anchorCol }
		set cellInfo [lindex $rowInfo $rawCol]
		if {![regexp {rowspan=\"(\d+)\".*>} $cellInfo match rowSpan]} { set rowSpan 1 }
		if {![regexp {colspan=\"(\d+)\".*>} $cellInfo match colSpan]} { set colSpan 1 }
		regexp {(<td.*?>)(.*)$} $cellInfo match formatData valueData
		# Populate table rowspan x colspan range
		for {set row ${anchorRow}} {${row} < [expr {${anchorRow} + ${rowSpan}}]} {incr row} { 
		    set tblInfo(format,${row}) ${formatRow}
		    for {set col ${anchorCol}} {${col} < [expr {${anchorCol} + ${colSpan}}]} {incr col} { 
			# Anchor reference is always same, empty cells get empty format and value
			set tblInfo(anchor,${row}:${col}) "${anchorRow}:${anchorCol}"
			if {[string match "${row}:${col}" "${anchorRow}:${anchorCol}"]} {
			    set tblInfo(format,${row}:${col}) ${formatData}
			    set tblInfo(value,${row}:${col}) ${valueData}
			} else {
			    set tblInfo(format,${row}:${col}) {}
			    set tblInfo(value,${row}:${col}) {}
			}
		    }
		}
	    }
	}
	set tblInfo(width) [llength [array names tblInfo anchor,0:*]]
	set tblInfo(height) [llength [array names tblInfo anchor,*:0]]
	return
    }
    
    proc DisplayTbl {args} {
	set field anchor
	
	switch -- [parse_options [calling_proc] {} $args \
		       "-field sos Table field to display for each cell" field \
		       "srs variable containing table information" tblData] {
			   -2 { return }
			   0 { return -code error }
	}
	
	upvar $tblData tblInfo
	
	if {![info exists tblInfo(height)]} { return -code error "Error: table variable \'${tblData}\' does not exist" }
	
	for {set row 0} {[info exists tblInfo(${field},${row}:0)]} {incr row} {
	    foreach cellIndex [lsort -dictionary [array names tblInfo anchor,${row}:*]] {
		regsub {anchor,} $cellIndex "" cellIndex
		if {![info exists tblInfo(${field},$cellIndex)]} {
		    puts -nonewline [format "%-7s" {}]
		} else {
		    puts -nonewline [format "%-7s" $tblInfo(${field},${cellIndex})]
		}
	    }
	    puts ""
	}
    }
    
    proc DeleteTblCol {args} {
	switch -- [parse_options [calling_proc] {} $args			\
		       "-col nrs column number to deleted" delCol		\
		       "srs variable containing table information" tblData] {
			   -2 { return }
			   0 { return -code error }
	}
	
	upvar $tblData tbl
	
	# Set defaults
	set nextCol [expr {$tbl(width) - 1}]
	
	# Error on illegal values
	if { [expr {${delCol} >= $tbl(width)}] || [expr {${delCol} < 0}] } { 
	    puts "Error: column \'${delCol}\' must be between \'0\' and \'[expr {$tbl(width) - 1}]\'"
	    return -code error
	}
	
	for {set row 0} {${row} < $tbl(height)} {incr row} {
	    # Extract anchor information
	    set anchorRow [lindex [split $tbl(anchor,${row}:${delCol}) :] 0]
	    set anchorCol [lindex [split $tbl(anchor,${row}:${delCol}) :] 1]
	    if { [expr {${anchorCol} <= ${delCol}}] && [expr {${anchorRow} == ${row}}] } {
		set colSpan [eval GetCellSpan -cell "${anchorRow}:${anchorCol}" -col "tbl"]
		regsub "colspan=\"${colSpan}\"" $tbl(format,${anchorRow}:${anchorCol}) "colspan=\"[expr {$colSpan - 1}]\"" tbl(format,${anchorRow}:${anchorCol})
	    }
	    for {set col ${delCol}} {${col} < [expr {$tbl(width) - 1}]} {incr col} {
		set nextCol [expr {${col} + 1}]
		set anchorRow [lindex [split $tbl(anchor,${row}:${nextCol}) :] 0]
		set anchorCol [lindex [split $tbl(anchor,${row}:${nextCol}) :] 1]
		# Move column left if it is anchor or multi-cell with anchor on row above
		if { [string match $tbl(anchor,${row}:${nextCol}) "${row}:${nextCol}"] || [expr {${anchorRow} != ${row}}] } {
		    set tbl(anchor,${row}:${col}) "${anchorRow}:[expr {${anchorCol} - 1}]" 
		    set tbl(format,${row}:${col}) $tbl(format,${row}:${nextCol})
		    set tbl(value,${row}:${col})  $tbl(value,${row}:${nextCol}) 
		} 
	    }
	    # Delete existing fields from last column
	    array unset tbl "*,${row}:${nextCol}"
	}
	incr tbl(width) -1
	return
    }
    
    
    proc InsertTblCol {args} {
	switch -- [parse_options [calling_proc] {} $args					\
		       "-col nos column number to inserted(default is after last)" insCol	\
		       "srs variable containing table information" tblData] {
			   -2 { return }
			   0 { return -code error }
	}
	
	upvar $tblData tbl
	
	# Set defaults
	if { ![llength ${insCol}] ||
	     [expr {$insCol > $tbl(width)}] } { 
	    set insCol $tbl(width) 
	    set anchorCol ${insCol}
	}
	
	# Error on illegal values
	if { ${insCol} < 0 } {
	    puts "Error: column \'${insCol}\' must be between \'0\' and \'$tbl(width)\'"
	    return -code error
	}
	
	for {set row 0} {${row} < $tbl(height)} {incr row} {
	    for {set nextCol $tbl(width)} {${nextCol} > ${insCol}} {incr nextCol -1} {
		set col [expr {${nextCol} - 1}]
		set anchorCol [lindex [split $tbl(anchor,${row}:${col}) :] 1]
		set anchorRow [lindex [split $tbl(anchor,${row}:${col}) :] 0]
		
		# Move cells 1 cell to the right
		set tbl(anchor,${row}:${nextCol}) "${anchorRow}:[expr {${anchorCol} + 1}]"
		set tbl(format,${row}:${nextCol}) $tbl(format,${row}:${col})
		set tbl(value,${row}:${nextCol})  $tbl(value,${row}:${col}) 

		# no need to update anchor information if anchor to left of insertion column
		# simply move but reset anchor to original value
		if { ${anchorCol} < ${insCol} } { set tbl(anchor,${row}:${nextCol}) "${anchorRow}:${anchorCol}" }
	    }
	    # Insert new column. Insert cell if new column is anchor
	    # Adjust colspan of anchor if in the middle of multi-column cell
	    if { ${anchorCol} >= ${insCol} } {
		set tbl(anchor,${row}:${insCol}) "${row}:${insCol}"
		set tbl(format,${row}:${insCol}) "<td>"
		set tbl(value,${row}:${insCol})  {}
	    } else {
		array set tbl [list "anchor,${row}:${insCol}" "${row}:${anchorCol}" "format,${row}:${insCol}" {} "value,${row}:${insCol}" {}]
		set colSpan [eval GetCellSpan -cell "${anchorRow}:${anchorCol}" -col "tbl"]
		regsub "colspan=\"${colSpan}\"" $tbl(format,${anchorRow}:${anchorCol}) "colspan=\"[expr {$colSpan + 1}]\"" tbl(format,${anchorRow}:${anchorCol})
	    }
	}
	
	set tbl(width) [incr tbl(width)]
	return
    }
    
    proc DeleteTblRow {args} {
	switch -- [parse_options [calling_proc] {} $args			\
		       "-row nrs row number to deleted" delRow		\
		       "srs variable containing table information" tblData] {
			   -2 { return }
			   0 { return -code error }
	}
	
	upvar $tblData tbl
	
	# Set defaults
	set nextRow [expr {$tbl(height) - 1}]
	
	# Error on illegal values
	if { [expr {${delRow} >= $tbl(height)}] || [expr {${delRow} < 0}] } { 
	    puts "Error: row \'${delRow}\' must be between \'0\' and \'[expr {$tbl(height) - 1}]\'"
	    return -code error
	}
	
	for {set col 0} {${col} < $tbl(width)} {incr col} {
	    # Extract anchor information
	    set anchorRow [lindex [split $tbl(anchor,${delRow}:${col}) :] 0]
	    set anchorCol [lindex [split $tbl(anchor,${delRow}:${col}) :] 1]
	    # Adjust rowspan if row deleted is anchor or part of multi-cell
	    if { [expr {${anchorRow} <= ${delRow}}] && [expr {${anchorCol} == ${col}}] } {
		set rowSpan [eval GetCellSpan -cell "${anchorRow}:${anchorCol}" -row "tbl"]
		regsub "rowspan=\"${rowSpan}\"" $tbl(format,${anchorRow}:${anchorCol}) "rowspan=\"[expr {$rowSpan - 1}]\"" tbl(format,${anchorRow}:${anchorCol})
	    }
	    for {set row ${delRow}} {${row} < [expr {$tbl(height) - 1}]} {incr row} {
		set nextRow [expr {${row} + 1}]
		set anchorRow [lindex [split $tbl(anchor,${nextRow}:${col}) :] 0]
		set anchorCol [lindex [split $tbl(anchor,${nextRow}:${col}) :] 1]
		# Move up row below if it is anchor or multi-cell with anchor above
		if { [string match $tbl(anchor,${nextRow}:${col}) "${nextRow}:${col}"] || [expr {${anchorCol} != ${col}}] } {
		    set tbl(anchor,${row}:${col}) "[expr {${anchorRow} - 1}]:${col}" 
		    set tbl(format,${row}:${col}) $tbl(format,${nextRow}:${col})
		    set tbl(value,${row}:${col})  $tbl(value,${nextRow}:${col}) 
		}
	    }
	    # Delete existing fields from last row
	    array unset tbl "*,${nextRow}:${col}"
	}
	
	incr tbl(height) -1
	return
    }
    
    proc InsertTblRow {args} {
	switch -- [parse_options [calling_proc] {} $args					\
		       "-row nos row number to inserted(default is after last)" insRow	\
		       "srs variable containing table information" tblData] {
			   -2 { return }
			   0 { return -code error }
	}
	
	upvar $tblData tbl
	
	# Set defaults
	if { ![llength ${insRow}] ||
	     [expr {$insRow >= $tbl(height)}] } { 
	    set insRow $tbl(height) 
	    set anchorRow ${insRow}
	}
	
	# Error on illegal values
	if { ${insRow} < 0 } {
	    puts "Error: row \'${insRow}\' must be between \'0\' and \'$tbl(height)\'"
	    return -code error
	}
	
	for {set col 0} {${col} < $tbl(width)} {incr col} {
	    for {set nextRow $tbl(height)} {${nextRow} > ${insRow}} {incr nextRow -1} {
		set row [expr {${nextRow} - 1}]
		set anchorCol [lindex [split $tbl(anchor,${row}:${col}) :] 1]
		set anchorRow [lindex [split $tbl(anchor,${row}:${col}) :] 0]
		
		# Move cells 1 down
		set tbl(anchor,${nextRow}:${col}) "[expr {${anchorRow} + 1}]:${anchorCol}"
		set tbl(format,${nextRow}:${col}) $tbl(format,${row}:${col})
		set tbl(value,${nextRow}:${col})  $tbl(value,${row}:${col}) 
		set tbl(format,${nextRow})        $tbl(format,${row}) 

		# no need to update anchor information if anchor above of insertion column
		# simply move but reset anchor to original value
		if { ${anchorRow} < ${insRow} } { set tbl(anchor,${nextRow}:${col}) "${anchorRow}:${anchorCol}" }
	    }
	    # Insert new row
	    # Adjust rowspan of anchor if in the middle of multi-row cell
	    if { ${anchorRow} >= ${insRow} } {
		set tbl(anchor,${insRow}:${col}) "${insRow}:${col}"
		set tbl(format,${insRow}:${col}) "<td>"
		set tbl(value,${insRow}:${col})  {}
		set tbl(format,${insRow})        "<tr>"
	    } else {
		array set tbl [list "anchor,${insRow}:${col}" "${anchorRow}:${col}" "format,${insRow}:${col}" {} "value,${insRow}:${col}" {}]
		set rowSpan [eval GetCellSpan -cell "${anchorRow}:${anchorCol}" -row "tbl"]
		regsub "rowspan=\"${rowSpan}\"" $tbl(format,${anchorRow}:${anchorCol}) "rowspan=\"[expr {$rowSpan + 1}]\"" tbl(format,${anchorRow}:${anchorCol})
	    }
	}
	
	set tbl(height) [incr tbl(height)]
	return
    }
    
    
    #include ~/read.tcl;readHTML ~/test.html;DisplayTbl tbl
    #InsertTblCol -col 2324 tblmap
    #DisplayTbl tblmap
    #InsertTblCol -col 1 tblmap
    
    
}    

# pragma protect end

regexp {\d+(\.\d+)+} {@Revision: 1.64 @} pkgRev
package provide ::applet::generate_report $pkgRev

#===========================================================================
#
# Copyright 1997-2012 Cadence Design Systems, Inc.  All rights reserved worldwide. 
#
# The Tcl computer program and related information (collectively "Licensed Material") 
# contained herein are protected by copyright law and international treaties. 
#
# Cadence grants Recipient of the Licensed Material a nonexclusive right
# to use, copy, and modify the Licensed Material.   Should Recipient
# desire to distribute any portion of the Licensed Material, Recipient
# must obtain Cadence's permission.  In no event shall Recipient use the 
# Licensed Material for benchmarking purposes against Cadence's products.   
#
# The Licensed Material is provided to Recipient to use at Recipient's
# own risk. The Licensed Material may not be compatible with current or 
# future versions of Cadence products, and Cadence will not provide any 
# technical support for the Licensed Material, whether modified or not 
# by the Recipient.  THE LICENSED MATERIAL IS PROVIDED "AS IS" AND WITH 
# NO WARRANTIES, INCLUDING WITHOUT LIMITATION ANY EXPRESS WARRANTIES OR 
# IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR USE.
#
# IN NO EVENT SHALL CADENCE BE LIABLE TO RECIPIENT OR ANY THIRD PARTY
# FOR ANY INCIDENTAL, INDIRECT, SPECIAL OR CONSEQUENTIAL DAMAGES, OR ANY 
# OTHER DAMAGES WHATSOEVER (INCLUDING, WITHOUT LIMITATION, DAMAGES FOR
# LOSS OF BUSINESS PROFITS, BUSINESS INTERRUPTION, LOSS OF BUSINESS 
# INFORMATION, OR OTHER PECUNIARY LOSS) ARISING OUT OF THE USE OR
# INABILITY TO USE LICENSED MATERIAL, WHETHER OR NOT THE POSSIBILITY OR 
# CAUSE OF SUCH DAMAGES WAS KNOWN TO CADENCE.
#
# Cadence Design Systems, Inc.
# 2655 Seely Avenue
# San Jose, CA 95134
#
#===========================================================================


# pragma protect
# pragma protect begin

namespace eval $::ns(genrpt) {
    variable debugDir "~"
    variable debug
    
    if {[info exists debug]} { eval RunDebug $debug}

    proc RunDebug {debug} {
	variable $::ns(genrpt)::debugDir

	set cf1 [list [list a 1] [list b 2] [list c 3]]
	set cf2 [list [list aa 1] [list bb 2] [list cc 3]]
	set cf3 [list [list a 1] [list b 2] [list c 3] [list aa 1] [list bb 2] [list cc 3]]
	set cf4 [list [list a 1] [list b 2] [list c 3] [list d 1] [list a 2] [list b 3]]
	set cmf1 [list [list G1 [list runtime program_version]] [list G2 [list memory_usage program_short_name]]]
	set cmf2 [list [list G3 [list [list hostname [info hostname]]]] [list G4 [list runtime memory_usage]]]
	set cmf3 [list [list G1 [list runtime program_version]] [list G2 [list memory_usage program_short_name]] [list G3 [list [list hostname [info hostname]]]]]
	set cmf4 [list [list G1 [list runtime program_version]] [list G2 [list runtime program_version memory_usage program_short_name]]]
	set cmf5 [list [list G4 [list runtime memory_usage]]]
	set cmf6 [list [list G3 [list runtime program_version]] [list G4 [list runtime memory_usage]]]
	set cmf7 [list [list G5 [list [list param1 val1]]]]
	set cmf8 [list [list G1 [list runtime program_version]] [list G2 [list memory_usage<LINK=rc.log> program_short_name<LINK=www.cadence.com>]]]
	set cmf9 [list [list G1 [list program_version runtime ]] [list G2 [list program_short_name memory_usage]]]
	set cmf10 [list [list G1 [list program_version runtime ]]]
	
	# Set library attribute to built-in if nothing present since design creation requires it
	if {![llength [find / -design *]]} {
	    set_attr library tutorial.lbr /
	    edit_netlist new_design -name genrpt_debug
	}
	
	if {[string match "all" $debug]} { for {set i 1} {$i <= 17} {incr i} { lappend debug $i } }
	set debug [lremove $debug "all"]
	foreach testID $debug {
	    set dbgFile [format "%s/dbg%s.html" $debugDir $testID]
	    puts "RUNNNING TESTCASE \#${testID}"
	    switch $testID {
		"1" {
		    #DOES NOT WORK - new multi fields; same groups
		    eval generate_report -replace -simple -multi [list $cmf1] -name F1 ${dbgFile}
		    eval generate_report -simple -multi [list $cmf4] -name F1 ${dbgFile}
		}
		"2" {
		    #WORKS - less multi fields; same groups
		    eval generate_report -replace -simple -multi [list $cmf4] -name F1 ${dbgFile}
		    eval generate_report -simple -multi [list $cmf1] -name F1 ${dbgFile}
		}
		"3" {
		    #WORKS - same multi fields; new groups
		    eval generate_report -replace -simple -multi [list $cmf3] -name F1 ${dbgFile}
		    eval generate_report -simple -multi [list $cmf1] -name F1 ${dbgFile}
		}
		"4" {
		    #WORKS - disjoint groups
		    eval generate_report -replace -simple -multi [list $cmf3] -name F1 ${dbgFile}
		    eval generate_report -simple -multi [list $cmf5] -name F1 ${dbgFile}
		}
		"5" {
		    #DOES NOT WORK - new multi fields; new groups; new fields; new multi fields
		    eval generate_report -replace -simple -multi [list $cmf1] -name F1 ${dbgFile}
		    eval generate_report -simple -multi [list $cmf4] -name F1 ${dbgFile}
		    eval generate_report -simple -multi [list $cmf3] -name F1 ${dbgFile}
		    eval generate_report -name F1 ${dbgFile}
		    eval generate_report -simple -multi [list $cmf2] -name F1 ${dbgFile}
		}
		"6" {
		    #WORKS - new & overlapping groups
		    eval generate_report -replace -simple -multi [list $cmf3] -name F1 ${dbgFile}
		    eval generate_report -simple -multi [list $cmf2] -name F1 ${dbgFile}
		}
		"7" {
		    #WORKS - default + custom groups
		    eval generate_report -replace -multi [list $cmf5] -name F1 ${dbgFile}
		}
		"8" {
		    #WORKS - single field group after multi field groups; additional fields
		    eval generate_report -replace -simple -multi [list $cmf1] -name F1 ${dbgFile}
		    eval generate_report -simple -multi [list $cmf5] -name F1 ${dbgFile}
		    eval generate_report -multi [list $cmf5] -name F1 ${dbgFile}
		}
		"9" {
		    #WORKS - disjoint groups
		    eval generate_report -replace -simple -multi [list $cmf5] -name F1 ${dbgFile}
		    eval generate_report -simple -multi [list $cmf1] -name F1 ${dbgFile}
		}
		"10" {
		    #WORKS - new & disjoint groups
		    eval generate_report -replace -simple -multi [list $cmf1] -name F1 ${dbgFile}
		    eval generate_report -simple -multi [list $cmf3] -name F1 ${dbgFile}
		}
		"11" {
		    #WORKS - disjoint single field group to disjoint multi field group
		    eval generate_report -replace -simple -multi [list $cmf3] -name F1 ${dbgFile}
		    eval generate_report -simple -multi [list $cmf7] -name F1 ${dbgFile}
		    eval generate_report -simple -multi [list $cmf2] -name F1 ${dbgFile}
		}
		"12" {
		    #WORKS - disjoint to overlap
		    eval generate_report -replace -simple -multi [list $cmf2] -name F1 ${dbgFile}
		    eval generate_report -simple -multi [list $cmf1] -name F1 ${dbgFile}
		    eval generate_report -simple -multi [list $cmf5] -name F1 ${dbgFile}
		}
		"13" {
		    #WORKS - default to default
		    eval generate_report -replace -name R1 ${dbgFile}
		    eval generate_report -name R1 ${dbgFile}
		}
		"14" {
		    #DOES NOT WORK - multi field ordering change
		    eval generate_report -replace -simple -multi [list $cmf1] -name R1 ${dbgFile}
		    eval generate_report -simple -multi [list $cmf9] -name R1 ${dbgFile}
		}
		"15" {
		    #WORKS - field name as substring of other field
		    eval generate_report -replace -name R1 ${dbgFile}
		    eval generate_report -custom [list $cf3] -name R1 ${dbgFile}
		}
		"16" {
		    #DOES NOT WORK - malformed HTML due to <tr> of first group; evident in removal
		    eval generate_report -replace -simple -multi [list $cmf9] -name R1 ${dbgFile}
		    eval generate_report -simple -multi [list $cmf9] -name R1 ${dbgFile}
		    eval generate_report -custom [list $cf1] -simple -multi [list $cmf9] -name R1 ${dbgFile}
		    eval generate_report -custom [list $cf3] -simple -multi [list $cmf9] -name R1 ${dbgFile}
		    eval generate_report -custom [list $cf2] -simple -multi [list $cmf9] -name R1 ${dbgFile}
		    file copy -force $dbgFile ${debugDir}/dbg${testID}-orig.html
		    eval generate_report -remove [list {2 3}] ${dbgFile}
		}
		"17" {
		    #DOES NOT WORK - redundant custom fields list; should detect condition and error
		    eval generate_report -replace -custom [list $cf4] -simple -name R1 ${dbgFile}
		}
		"18" {
		    #DOES NOT WORK - group name of form <name>[<number>] does not get identified as multi
		    eval generate_report -replace -custom [list $cmf10] -simple -name R1 ${dbgFile}
		}
	    }
	}
    }
}

# pragma protect end
