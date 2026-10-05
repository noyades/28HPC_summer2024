#===========================================================================
# File Name	: @Source: /net/splinter/fed/cvs/ae-ware/rc/time_info_api.tcl,v @
# Date Created	: 10/25/2004
# Date Modified	: @Date: 2012/04/12 04:25:29 @
# Version	: @Revision: 1.5 @
# Summary	: API layer to access time_info database internals
# Keywords      : time_info api
#
# Description:
#	This script allows the user to extract specific data from the time_info
#	database (array).
#
# Assumptions:
#	None
#
#===========================================================================
package require ::applet::time_info

if {![info exists ::ns(compat)]}     { set ::ns(compat)    "::aeware" }
if {![info exists ::ns(time_info)]}  { set ::ns(time_info) "$::ns(compat)" }

# time_info APIS
# NOTE: Assume uniq identifiers based on syntax:
#  <tinfo id>:<nth stage>
namespace eval $::ns(time_info) {
    #
    # Convert month text strings to numeric strings (i.e., Nov01 to 11/01)
    #
    proc convMonthStringToNum {monthString} {
	regexp {([A-Za-z]+)(\d+)} $monthString full month day
	switch -exact -- $month {
	    Jan { return "01/$day" }
	    Feb { return "02/$day" }
	    Mar { return "03/$day" }
	    Apr { return "04/$day" }
	    May { return "05/$day" }
	    Jun { return "06/$day" }
	    Jul { return "07/$day" }
	    Aug { return "08/$day" }
	    Sep { return "09/$day" }
	    Oct { return "10/$day" }
	    Nov { return "11/$day" }
	    Dec { return "12/$day" }
	}
    }
    if {![llength [info commands ::convMonthStringToNum]]} { namespace export convMonthStringToNum }

    #
    # Get the stage name for a time_info stage id
    #
    proc get_stage_name {args} {
	variable $::ns(time_info)::allMetrics

	switch -- [parse_options "[calling_proc]" {} $args                      \
		       "-stage_id sos stage ID" stage_id			    \
		       "-id sos metrics table ID (default is \'default\')" id] {
			   -2 { return }
			   0 { return -code error }
        }

	if {![info exists id] || $id eq ""} {
	    set id default
	}
	return $allMetrics(${stage_id},name)
    }
    if {![llength [info commands ::get_stage_name]]} { namespace export get_stage_name }

    #
    # Get a list of all time_info stages for a given time_info stream
    #
    proc get_tinfo_stages {args} {
	variable $::ns(time_info)::allMetrics

	switch -- [parse_options "[calling_proc]" {} $args                      \
		       "-id sos metrics table ID (default is \'default\')" id] {
			   -2 { return }
			   0 { return -code error }
        }
	if {![info exists id] || $id eq ""} {
	    set id default
	}
	foreach stageIDName [lsort -dictionary [array names allMetrics "${id}:*,name"]] {
	    regexp {(\S+),name} $stageIDName full stageID
	    lappend returnList $stageID
	}
	return $returnList
    }
    if {![llength [info commands ::get_tinfo_stages]]} { namespace export get_tinfo_stages }

    #
    # Get a list of all time_info ids (streams)
    #
    proc get_tinfo_ids {} {
	variable $::ns(time_info)::allMetrics

	set StageNameList [array names allMetrics "*:0,name"]
	foreach name $StageNameList {
	    if {[regexp {(\S+):0,name} $name full id]} {
		lappend returnList $id
	    }
	}
	return $returnList 
    }
    if {![llength [info commands ::get_tinfo_ids]]} { namespace export get_tinfo_ids }

    #
    # Get the stage wall (delta) time for a given time_info stage id
    #
    proc get_stage_wall_time {args} {
	variable $::ns(time_info)::allMetrics

	switch -- [parse_options "[calling_proc]" {} $args                      \
		       "-stage_id sos stage ID" stage_id 			    \
		       "-id sos metrics table ID (default is \'default\')" id] {
			   -2 { return }
			   0 { return -code error }
        }
	if {![info exists id] || $id eq ""} {
	    set id default
	}
	regexp {:(\d+)} $stage_id match stageNum
	if {$stageNum == 0} {
	    set prevStage 0
	} else {
	    set prevStage [expr {$stageNum - 1}]
	}
	set delta(wall) [expr {$allMetrics(${id}:$stageNum,wall) - $allMetrics(${id}:$prevStage,wall)}]
	set stage(wall) [eval ${::ns(compat)}::SecToTime $delta(wall)]
	return $stage(wall)
    }
    if {![llength [info commands ::get_stage_wall_time]]} { namespace export get_stage_wall_time }

    #
    # Get the stage start time for a given stage ID
    #
    proc get_stage_start_time {args} {
	variable $::ns(time_info)::allMetrics

	#
	# Record the start stage month persistently. This is used to flag if there is a year to year roll-over
	# from the start date to the end date
	#
	variable StartStageMonth
	switch -- [parse_options "[calling_proc]" {} $args                      \
		       "-stage_id sos stage ID" stage_id 			    \
		       "-ampm bos Use AM/PM instead of 24-hour clock" ampm	\
		       "-id sos metrics table ID (default is \'default\')" id] {
			   -2 { return }
			   0 { return -code error }
        }

	if {![info exists id] || $id eq ""} {
	    set id default
	}
	regexp {:(\d+)} $stage_id match stageNum
	if {$stageNum == 0} {
	    set prevStage 0
	} else {
	    set prevStage [expr {$stageNum - 1}]
	}
	#
	# Compute full date format
	#
	# Assume the year is always constant within any time_info database
	# NOTE THIS IS A FAULTY ASSUMPTION AND WILL CAUSE CORRUPT DATA AROUND THE TURN OF THE YEAR
	#
	set stageYear [clock format [clock scan $allMetrics(${id}:$prevStage,date)] -format "%Y"]
	set stageMonth [${::ns(time_info)}::convMonthStringToNum $allMetrics(${id}:$prevStage,date)]
	if {$stageNum == 0} {
	    set StartStageMonth $stageMonth
	}
	set stageDate "$stageMonth/$stageYear"
	set baseDate [clock scan $stageDate]
	set returnDateSecs [clock scan $allMetrics(${id}:$prevStage,date) -base $baseDate]

	if {[info exists ampm] && $ampm} {
	    return [clock format $returnDateSecs -format "%m/%d/%y %I:%M:%S %p"]
	} else {
	    return [clock format $returnDateSecs -format "%m/%d/%y %H:%M:%S"]
	}
    }
    if {![llength [info commands ::get_stage_start_time]]} { namespace export get_stage_start_time }

    #
    # Get the stage end time for a given stage ID
    #
    proc get_stage_end_time {args} {
	variable $::ns(time_info)::allMetrics

	switch -- [parse_options "[calling_proc]" {} $args                      \
		       "-stage_id sos stage ID" stage_id 			    \
		       "-ampm bos Use AM/PM instead of 24-hour clock" ampm	\
		       "-id sos metrics table ID (default is \'default\')" id] {
			   -2 { return }
			   0 { return -code error }
        }
	if {![info exists id] || $id eq ""} {
	    set id default
	}
	regexp {:(\d+)} $stage_id match stageNum
	#
	# Compute full date format
	#
	set stageYear [clock format [clock scan $allMetrics(${id}:$stageNum,date)] -format "%Y"]
	set stageMonth [${::ns(time_info)}::convMonthStringToNum $allMetrics(${id}:$stageNum,date)]
	if {[info exists StartStageMonth] && $stageMonth < $StartStageMonth} {
	    # if the end month is less than the start month, a year roll-over occurred. Need to adjust start year
	    # For now, generate Error message
	    puts "get_stage_end_time() ERROR: Year roll-over occurred. Time info cannot effectively account for this. Your data is likely corrupt."
	}
	set stageDate "$stageMonth/$stageYear"
	set baseDate [clock scan $stageDate]
	set returnDateSecs [clock scan $allMetrics(${id}:$stageNum,date) -base $baseDate]
	if {[info exists ampm] && $ampm} {
	    return [clock format $returnDateSecs -format "%m/%d/%y %I:%M:%S %p"]
	} else {
	    return [clock format $returnDateSecs -format "%m/%d/%y %H:%M:%S"]
	}
    }
    if {![llength [info commands ::get_stage_end_time]]} { namespace export get_stage_end_time }

    #
    # Get the first stage ID for a stream
    #
    proc get_first_stage {args} {
	switch -- [parse_options "[calling_proc]" {} $args                      \
		       "-id sos metrics table ID (default is \'default\')" id] {
			   -2 { return }
			   0 { return -code error }
        }
	if {![info exists id] || $id eq ""} {
	    set id default
	}
	return "${id}:0"
    }
    if {![llength [info commands ::get_first_stage]]} { namespace export get_first_stage }

    #
    # Get the last stage ID for a stream
    #
    proc get_last_stage {args} {
	variable $::ns(time_info)::allMetrics

	switch -- [parse_options "[calling_proc]" {} $args                      \
		       "-id sos metrics table ID (default is \'default\')" id] {
			   -2 { return }
			   0 { return -code error }
        }
	if {![info exists id] || $id eq ""} {
	    set id default
	}
	set lastID [expr { [llength [array names allMetrics "${id}:*,name"]] - 1}]
	return "${id}:${lastID}"
    }
    if {![llength [info commands ::get_last_stage]]} { namespace export get_last_stage }

    #
    # Get previous stage for a given stage ID
    #
    proc get_prev_stage {args} {
	switch -- [parse_options "[calling_proc]" {} $args                      \
		       "-stage_id sos stage ID" stage_id 			    \
		       "-id sos metrics table ID (default is \'default\')" id] {
			   -2 { return }
			   0 { return -code error }
        }
	if {![info exists id] || $id eq ""} {
	    set id default
	}

	regexp {:(\d+)} $stage_id match stageNum
	if {$stageNum == 0} {
	    set prevStageID 0
	} else {
	    set prevStageID [expr {$stageNum - 1}]
	}
	return "${id}:${prevStageID}"
    }
    if {![llength [info commands ::get_prev_stage]]} { namespace export get_prev_stage }

    #
    # Get next stage for a given stage ID
    #
    proc get_next_stage {args} {
	switch -- [parse_options "[calling_proc]" {} $args                      \
		       "-stage_id sos stage ID" stage_id 			    \
		       "-id sos metrics table ID (default is \'default\')" id] {
			   -2 { return }
			   0 { return -code error }
        }
	if {![info exists id] || $id eq ""} {
	    set id default
	}
	set lastStageID [eval get_last_stage -id $id]

	if {$lastStageID eq $stage_id} {
	    return $lastStageID 
	} else {
	    regexp {:(\d+)} $stage_id match StageNum
	    puts "id: ${id}"
	    return "${id}:[expr {$StageNum + 1}]"
	}
    }
    if {![llength [info commands ::get_next_stage]]} { namespace export get_next_stage }


}

#
# Exports to global namespace
# 

if {![llength [info commands ::convMonthStringToNum]]} {
    namespace import $::ns(time_info)::convMonthStringToNum
    add_command_help convMonthStringToNum "Convert a month date text string to numeric format" "Reporting"
}
if {![llength [info commands ::get_stage_name]]} {
    namespace import $::ns(time_info)::get_stage_name
    add_command_help get_stage_name "Get the stage name for a stage ID" "Reporting"
}
if {![llength [info commands ::get_tinfo_stages]]} {
    namespace import $::ns(time_info)::get_tinfo_stages
    add_command_help get_tinfo_stages "Get all time_info (stage) ids" "Reporting"
}
if {![llength [info commands ::get_tinfo_ids]]} {
    namespace import $::ns(time_info)::get_tinfo_ids
    add_command_help get_tinfo_ids "Get all time_info (stream) ids" "Reporting"
}
if {![llength [info commands ::get_stage_wall_time]]} {
    namespace import $::ns(time_info)::get_stage_wall_time
    add_command_help get_stage_wall_time "Get stage wall (delta) time" "Reporting"
}
if {![llength [info commands ::get_stage_start_time]]} {
    namespace import $::ns(time_info)::get_stage_start_time
    add_command_help get_stage_wall_time "Get stage start time" "Reporting"
}
if {![llength [info commands ::get_stage_end_time]]} {
    namespace import $::ns(time_info)::get_stage_end_time
    add_command_help get_stage_end_time "Get stage start time" "Reporting"
}
if {![llength [info commands ::get_first_stage]]} {
    namespace import $::ns(time_info)::get_first_stage
    add_command_help get_first_stage "Get first stage" "Reporting"
}
if {![llength [info commands ::get_last_stage]]} {
    namespace import $::ns(time_info)::get_last_stage
    add_command_help get_last_stage "Get last stage" "Reporting"
}
if {![llength [info commands ::get_next_stage]]} {
    namespace import $::ns(time_info)::get_next_stage
    add_command_help get_next_stage "Get next stage" "Reporting"
}
if {![llength [info commands ::get_prev_stage]]} {
    namespace import $::ns(time_info)::get_prev_stage
    add_command_help get_prev_stage "Get previous stage" "Reporting"
}

regexp {\d+(\.\d+)+} {@Revision: 1.5 @} pkgRev
package provide ::applet::time_info_api $pkgRev
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


