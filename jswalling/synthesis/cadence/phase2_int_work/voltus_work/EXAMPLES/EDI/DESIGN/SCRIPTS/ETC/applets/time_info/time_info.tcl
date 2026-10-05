#===========================================================================
# File Name	: @Source: /net/splinter/fed/cvs/ae-ware/rc/time_info.tcl,v @
# Date Created	: 10/25/2004
# Date Modified	: @Date: 2012/03/22 04:57:42 @
# Version	: @Revision: 1.40 @
# Summary	: Create time stamp and keep track of runtime metrics
# Keywords      : runtime timestamp performance
#
# Description:
#	This script allows the user to create time stamps such that 
#	at any time the user can generate a report of the runtime
#	allocation throughout a run
#
# Assumptions:
#	None
#
#===========================================================================
if {![info exists ::ns(compat)]}     { set ::ns(compat)    "::aeware" }
if {![info exists ::ns(time_info)]}  { set ::ns(time_info) "$::ns(compat)" }
if {![info exists ::ns(utils)]}      { set ::ns(utils)     "$::ns(compat)::utils" }
if {![info exists ::ns(applet)]}     { set ::ns(applet) "${::ns(compat)}::applet" }

alias timestat time_info

namespace eval $::ns(utils) {
    hidden_proc ProcPresent {args} {
	switch -- [parse_options "[calling_proc]" {} $args				\
		       "srs object Name" procName \
		       "srs procedure name(including namespace if applicable)" procInfo] {
			   -2 { return }
			   0 { return -code error }
	}

	set invalidProc 0
	foreach procName ${procInfo} { 
	    if {![llength [info commands [lindex ${procName} 0]]]} { 
		puts "Info: procedure \'${procName}\' not found"
		set invalidProc 1
	    }
	}
	if {!${invalidProc}} { return 1 }
    }
}

namespace eval $::ns(time_info) {
    variable allMetrics
    if {![info exists [set ::ns(time_info)]::offset]} {
	variable offset
	set offset(wall)   0
	set offset(thread) 0
	set offset(parent) 0 
	set offset(all)    0
    }

    if {![llength [info commands ::time_info]]} { namespace export time_info }

    # This attribute specifies proc to automatically execute after time_info
    # every time it is executed
    catch {
	$::ns(compat)::redirect /dev/null {
	    define_attribute				\
		-category enhancement			\
		-data_type string			\
		-obj_type root				\
		-default_value ""			\
		-check_function $::ns(utils)::ProcPresent \
		-skip_in_db				\
		-help_string "list of procedure and arguments to be executed after \'time_info\' is run" \
		trigger_post_time_info
	}

	$::ns(compat)::redirect /dev/null {
	    define_attribute				\
		-category enhancement			\
		-data_type string			\
		-obj_type root				\
		-default_value ".rs.tstamp"		\
		-skip_in_db				\
		-help_string "name of \'.tstamp\' file to save runtime metrics to. \'-save\' takes precedence over it." \
		tinfo_tstamp_file
	}
    }

    proc time_info { args } {
	regexp {\d+(\.\d+)+} {@Revision: 1.40 @} pkgRev

	variable allMetrics
	variable offset

	# set default values
	set stampName "undefined"
	set id        "default" 
	
	# Parse command line switches
	# return an error if incorrect arguments are given
	switch -- [parse_options "[calling_proc] $pkgRev" {} $args			\
		       "-report bos report all stages up to this point" reportAll	\
		       "-current bos report current stage" reportCur			\
		       "-quiet bOs report current stage" quietMode			\
		       "-id sOs metrics table ID (default is \'default\')" id	\
		       "-table sos metrics table ID to support multiple tables (default is \'default\')" tableId \
		       "-stamp bos create a time stamp" createStamp			\
		       "-precise bOs enable fractions of a second" precise		\
		       "-save sos name of \'.tstamp\' file to save runtime metrics to" saveDB	\
		       "-load sos name of \'.tstamp\' file to load runtime metrics from" loadDB	\
		       "-clear bOs clear existing DB information" clearDB	\
		       "sos stage name" stampName] {
			   -2 { 
			       puts "\nNote that time_info also provides a shortcut syntax where"
			       puts "\'-report\' and \'-stamp\' are implied. When using such syntax"
			       puts "\n> time_info STAGE_6\n"
			       puts "is equivalent to"
			       puts "\n> time_info -stamp STAGE_6 -report\n"
			       puts "Also note that time_info aliases timestat to time_info"
			       return 
			   }
			   0 { return -code error }
	}
	
	# Need this to support -id (legacy) and -table
	if {![string match "default" ${id}] } { puts "WARNING: THIS OPTION WILL BE REMOVED IN AN UPCOMING RELEASE. PLEASE USE  \'-table\' INSTEAD" }
	if {[llength ${tableId}]} { set id ${tableId} }

	if {${clearDB}} { 
	    puts "Clearing all runtime DB metrics !!!"
	    unset -nocomplain allMetrics
	    return
	}

	set secOpts ""
	if {$precise} { set secOpts "-precise" }
	# Make the default -report -stamp <name> 
	# This is needed to support timestathrs
	if {!$reportAll && !$reportCur && !$createStamp && [string is false $loadDB] && [string is false $saveDB]} { 
	    set reportAll 1 
	    set createStamp 1
	} 
	
	if {![string is false $loadDB]} { 
	    unset -nocomplain allMetrics 
	    source $loadDB 
	    if {[llength [array names allMetrics "*,date"]]} {
		# determine the last timestamp across all stages of all table IDs
		foreach dbId [array names allMetrics *:0,date] {
		    regsub ":0,date" ${dbId} "" idName
		    set lastName [lindex [lsort -dictionary [array names allMetrics "${idName}:*,date"]] end]
		    set lastTimeDate $allMetrics($lastName)
		    set lastDate [string range ${lastTimeDate} end-5 end-1]
		    set lastSec [clock scan ${lastTimeDate} -base [clock scan ${lastDate}]]
		    if {![info exists latestDate] || [expr {${latestDate} < ${lastSec}}]} { 
			set latestDate ${lastSec} 
			set latestID [format "%s:%s" ${idName} [expr {[llength [array names allMetrics "${idName}:*,date"]] - 1}]]
		    }
		} 
		# need to account for time elapsed on current run
		set offset(thread) [expr {$allMetrics(${latestID},thread) - [get_attr super_thread_runtime /]}]
		set offset(parent) [expr {$allMetrics(${latestID},parent) - [get_attr runtime /]}]
		set offset(all)    [expr {$allMetrics(${latestID},all) - [get_attr super_thread_total_runtime /]}]
		set offset(wall)   [expr {[clock seconds] - ${latestDate}}]
		#set offset(wall)   [expr {[clock seconds] - [clock scan "$allMetrics(${id}:${lastStage},date)" -format "%I:%M:%S %p(%b%d)"]}]
		# Need to traverse all IDs and update reload flags approprately
		# Extract highest stage status. Basically, even 'tables' that did not run in a stage will
		# get incremented to the latest stage 
		set reloadInfo [lsearch -all -inline -regexp [array get allMetrics *,status] {\*\d+\*}]  ;# get all status flags that are non-empty
		# get latest stage run thus far and updated reload numbers 
		set lastStage 0
		if {[regexp {\d+} [lindex [lsort -dictionary ${reloadInfo}] end] lastStage]} { incr lastStage }
		# update status flags that previously where not reloaded data
		foreach updateInfo [lsearch -all -exact [array get allMetrics *,status] ""] {
		    set updateStage [lindex [array get allMetrics *,status] [expr {${updateInfo} - 1}]]
		    set allMetrics(${updateStage}) " (*${lastStage}*)" 
		}
	    } else {
		puts "Warning: \'${loadDB}\' does not contain any time stamps..."
	    }
	} 	    

	# time variables track CPU runtime whereas wall variables track Wall clock runtimes
	# This is particularly useful when trying to look at superthreading runtimes
	if {![info exists allMetrics]} {
	    set allMetrics(-1,wall) [clock seconds]
	} 
	
	
	set rtime(wall)   [expr {[clock seconds] - $allMetrics(-1,wall) - $offset(wall)}]
	set rtime(thread) [expr {[get_attr super_thread_runtime /] + $offset(thread)}] 
	set rtime(parent) [expr {[get_attr runtime /] + $offset(parent)}] 
	set rtime(all)    [expr {[get_attr super_thread_total_runtime /] + $offset(all)}] 
	
	set curMem      [get_attr memory_usage /]
	set curTime     [clock format [clock seconds] -format "%I:%M:%S %p(%b%d)"]
	# Save timestamp information
	if {$createStamp} {
	    if {!${quietMode}} { puts "stamp \'$stampName\' being created for table \'${id}\'" }
	    set order [llength [array names allMetrics "${id}:*,name"]] 
	    set allMetrics(${id}:${order},name)   $stampName
	    set allMetrics(${id}:${order},thread) $rtime(thread)
	    set allMetrics(${id}:${order},parent) $rtime(parent)
	    set allMetrics(${id}:${order},all)    $rtime(all)
	    set allMetrics(${id}:${order},wall)   $rtime(wall)
	    if {[llength [get_attr super_thread_servers /]]} {
		set allMetrics(${id}:${order},tcount) [llength [get_attr super_thread_servers /]]
	    } elseif {[get_attr auto_super_thread /] && [expr {[get_attr print_count [find / -message ST-121]] != 0}]} {
		set allMetrics(${id}:${order},tcount) 2
	    } else {
		set allMetrics(${id}:${order},tcount) 0
	    }
	    set allMetrics(${id}:${order},status) ""
	    if {$curMem >= 1000} { 
		set allMetrics(${id}:${order},mem) "[format "%.2f GB" [expr {$curMem / 1000.0}]]"
	    } else {
		set allMetrics(${id}:${order},mem) "$curMem MB"
	    }		      
	    set allMetrics(${id}:${order},date)  $curTime
	}
	
	# Generate report based on all the timestamps saved
	if {$reportAll} {
	    if { [array size allMetrics] == 1 } {
		puts stderr "Warning: Tried to create a time_info report but"
		puts stderr "         no time stamps where created"
		return -code error 
	    }
	    if { ![info exists allMetrics(${id}:0,name)] } {
		puts stderr "Error: id \'${id}\' does not exists. Please check the spelling and try again"
		return -code error
	    }
	    set last(thread) [expr {$allMetrics(${id}:[expr {[llength [array names allMetrics "${id}:*,name"]] - 1}],thread) - $allMetrics(${id}:0,thread)}]
	    set last(all)    [expr {$allMetrics(${id}:[expr {[llength [array names allMetrics "${id}:*,name"]] - 1}],all) - $allMetrics(${id}:0,all)}]
	    set last(parent) [expr {$allMetrics(${id}:[expr {[llength [array names allMetrics "${id}:*,name"]] - 1}],parent) - $allMetrics(${id}:0,parent)}]
	    set last(wall)   [expr {$allMetrics(${id}:[expr {[llength [array names allMetrics "${id}:*,name"]] - 1}],wall) - $allMetrics(${id}:0,wall)}]
	    puts "
  Total Time (Wall) |  Stage Time (Wall)  |   % (Wall)   |    Date - Time     |  Memory   | Stage
--------------------+---------------------+--------------+--------------------+-----------+----------------------"
	    foreach stageOrder [lsort -dictionary [array names allMetrics "${id}:*,name"]] {
		regexp {:(\d+),name} $stageOrder match stageOrder
		if {$stageOrder == 0} {
		    set prevStage 0
		} else {
		    set prevStage [expr {$stageOrder - 1}]
		}
		set stageMem	$allMetrics(${id}:$stageOrder,mem)
		set stageName	[format "%s%s" $allMetrics(${id}:$stageOrder,name) $allMetrics(${id}:$stageOrder,status)]
		set stageDate	$allMetrics(${id}:$stageOrder,date)
		foreach rtimeType [list "wall" "parent" "thread" "all"] {
		    set total(${rtimeType}) [eval $::ns(compat)::SecToTime $secOpts $allMetrics(${id}:$stageOrder,$rtimeType)]
		    set delta(${rtimeType}) [expr {$allMetrics(${id}:$stageOrder,$rtimeType) - $allMetrics(${id}:$prevStage,$rtimeType)}]
		    set stage(${rtimeType}) [eval ${::ns(compat)}::SecToTime $secOpts $delta($rtimeType)]
		    if {$last($rtimeType)} {
			set slice($rtimeType) [expr {$delta($rtimeType) * 100.0 / $last($rtimeType)}]
		    } else {
			set slice($rtimeType) 0
		    }
		    if {$last(wall)} {
			set slice(wall)       [format "%5.1f" [expr {$delta(wall) * 100.0 / $last(wall)}]]
			if {$slice(wall) == 100} { set slice(wall) "100.0" }
		    } else {
			set slice(wall)	    "  0.0"
		    }
		}
		if {[expr {$delta(thread) == 0}] || 
		    [expr {$delta(thread) == $delta(parent)}] || 
		    [expr {$allMetrics(${id}:$stageOrder,tcount) == 0}]} {
		    set threadEff  ""
		    set threadUtil ""
		} else {
		    set threadEff  [expr {($delta(all) - $delta(parent)) / (($delta(thread) - $delta(parent)) * $allMetrics(${id}:$stageOrder,tcount))}]
		    set threadUtil [expr {1.0 - $delta(parent) / $delta(thread)}]
		}
		set lazyTime ""
		if {$delta(wall) != 0} { set lazyTime [expr {1.0 - $delta(thread) / $delta(wall)}] }

		puts [format "%19s | %19s | %5.1f(%s) | %18s | %9s | %s"   \
			  "$total(thread)($total(wall))" "$stage(thread)($stage(wall))" $slice(thread) $slice(wall) $stageDate $stageMem $stageName]
		puts "--------------------+---------------------+--------------+--------------------+-----------+----------------------"
		set allMetrics(${id}:$stageOrder,fieldInfo)     [list [list "Memory" "${stageMem}"]]
		lappend allMetrics(${id}:$stageOrder,fieldInfo) [list "Date" "${stageDate}"]
		lappend allMetrics(${id}:$stageOrder,fieldInfo) [list "Thread Count" $allMetrics(${id}:$stageOrder,tcount)]
		
		# annotate total runtime metrics
		set multiInfo [list [list "clock" $total(wall)]]
		lappend multiInfo [list "lthread" $total(thread)]
	        set allMetrics(${id}:$stageOrder,multiInfo) [list [list "Total Time" $multiInfo]]
		lappend multiInfo [list "threads" $total(all)]
		lappend multiInfo [list "non-thread" $total(parent)]
		set allMetrics(${id}:$stageOrder,multiInfoDetail) [list [list "Total Time" $multiInfo]]
		# annotate stage time metrics
		set multiInfo [list [list "clock" $stage(wall)]]
		lappend multiInfo [list "lthread" $stage(thread)]
		set allMetrics(${id}:$stageOrder,multiInfo) [linsert $allMetrics(${id}:$stageOrder,multiInfo) end [list "Stage Time" $multiInfo]]
		lappend multiInfo [list "threads" $stage(all)]
		lappend multiInfo [list "non-thread" $stage(parent)]
		set allMetrics(${id}:$stageOrder,multiInfoDetail) [linsert $allMetrics(${id}:$stageOrder,multiInfoDetail) end [list "Stage Time" $multiInfo]]
		# annotate percent runtime metrics
		set multiInfo [list [list "clock" $slice(wall)]]
		lappend multiInfo [list "lthread" "$slice(thread)<PREC(5.1)>"]
		set allMetrics(${id}:$stageOrder,multiInfo) [linsert $allMetrics(${id}:$stageOrder,multiInfo) end [list "% Time" $multiInfo]]
		lappend multiInfo [list "threads" "$slice(all)<PREC(5.1)>"]
		lappend multiInfo [list "non-thread" "$slice(parent)<PREC(5.1)>"]
		set allMetrics(${id}:$stageOrder,multiInfoDetail) [linsert $allMetrics(${id}:$stageOrder,multiInfoDetail) end [list "% Time" $multiInfo]]
		# annotate threading metrics
		set multiInfo [list [list "Efficiency" "$threadEff<PERCENT>"]]
		lappend multiInfo [list "Utilization" "$threadUtil<PERCENT>"]
		lappend multiInfo [list "Lazy Time" "${lazyTime}<PERCENT>"]
		set allMetrics(${id}:$stageOrder,multiInfoDetail) [linsert $allMetrics(${id}:$stageOrder,multiInfoDetail) end [list "ST Metrics" $multiInfo]]
	    }
	    puts "Number of threads: [llength [get_attr super_thread_servers /]]      (id: ${id}, time_info v${pkgRev})"
	    puts "Info: (*N*) indicates data that was populated from previously saved time_info database"
	    # Warn user about use of wall-clock time in super-threading mode
	    if {[llength [get_attr super_thread_servers /]]} { puts "Info: CPU time includes time of parent + longest thread" } 
	} elseif {$reportCur} {
	    puts "======================================================="
	    puts [format "CPU Runtime:       %s" [eval ${::ns(compat)}::SecToTime $secOpts $rtime(thread)]]
	    puts [format "Wall Runtime:      %s" [eval ${::ns(compat)}::SecToTime $secOpts $rtime(wall)]]
	    puts [format "Memory Usage:      %s MBytes" $curMem]
	    puts [format "Current Time:      %s" $curTime]
	    puts "======================================================="
	}

	if {[llength $saveDB]} { 
	    if {![file writable ${saveDB}] && ![file writable .]} {
		puts "Warning: Could not open file \'[file normalize $saveDB]\' for writing"
		puts "\ta .tstamp file will not be generated/updated"
	    } else {
		set saveDBFile [open ${saveDB} w]
		puts $saveDBFile "array set allMetrics [list [array get allMetrics -1,*]]"
		foreach dbId [array names allMetrics *:0,name] {
		    regsub ":0,name" ${dbId} "" idName
		    puts $saveDBFile "\narray set allMetrics [list [array get allMetrics ${idName}:*]]"
		}
		close $saveDBFile
	    }
	}

	# save a default DB every time a timestamp is created
	# this is done such that the metrics are always persistent even if user did not save DB explicitly
	# this functionality can be disabled by setting tinfo_tstamp_file to <NULL>
	# this step is skipped if tinfo_... and -save arguments are the same since would be 
	# redundant with previous lines
	if {$createStamp && [llength [get_attr tinfo_tstamp_file /]] && ![string match [get_attr tinfo_tstamp_file /] ${saveDB}]} {
	    if {![file writable [get_attr tinfo_tstamp_file /]] && ![file writable .]} {
		puts "Warning: Could not open file \'[file normalize [get_attr tinfo_tstamp_file /]]\' for writing"
		puts "\ta .tstamp file will not be generated/updated"
	    } else {
		set saveDBFile [open [get_attr tinfo_tstamp_file /] w]
		puts $saveDBFile "array set allMetrics [list [array get allMetrics -1,*]]"
		foreach dbId [array names allMetrics *:0,name] {
		    regsub ":0,name" ${dbId} "" idName
		    puts $saveDBFile "\narray set allMetrics [list [array get allMetrics ${idName}:*]]"
		}
		close $saveDBFile
	    }
	}

	# no check needed since attribute framework already providing checks
	foreach postProc [get_attr trigger_post_time_info /] { 
	    puts "\nInfo: executing trigger \'${postProc}\'...\n"
	    uplevel \#0 ${postProc}; 
	}
    }
}

if {![llength [info commands ::time_info]]} { 
    namespace import $::ns(time_info)::time_info
    add_command_help time_info "report and track runtime and memory performance" "Reporting"
}

regexp {\d+(\.\d+)+} {@Revision: 1.40 @} pkgRev
package provide ::applet::time_info $pkgRev

#------------------------------------------------------
# This procedure return a string of the form
# <hours>:<minutes>:<seconds>
# given an integer number of seconds as input
#------------------------------------------------------
namespace eval $::ns(compat) {
    hidden_proc SecToTime { args } {
	# Parse command line switches
	# return an error if incorrect arguments are given
	switch -- [parse_options [calling_proc] {} $args			\
		       "-precise bos enable fractions of a second" precise	\
		       "srs time in seconds" secCount] {
			   -2 { return }
			   0 { return -code error }
	}
	scan $secCount "%d.%d" secCount secFraction
	set minCount [expr {$secCount / 60}]
	set hrCount  [expr {$minCount / 60}]
	set minCount [expr {$minCount % 60}]
	set secCount [expr {$secCount % 60}]
	if { [info exists secFraction] && $precise } { return [format "%.2d:%.2d:%.2d.%d" $hrCount $minCount $secCount $secFraction] }
	return [format "%.2d:%.2d:%.2d" $hrCount $minCount $secCount]
    }
}

namespace eval $::ns(applet) {
    proc applet_init_time_info {} { $::ns(time_info)::time_info -quiet -stamp init }
}

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


