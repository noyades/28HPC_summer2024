#===========================================================================
# File Name	: @Source: /net/splinter/fed/cvs/ae-ware/rc/set_cost_groups.tcl,v @
# Date Created	: 10/25/2010
# Date Modified	: @Date: 2012/03/22 04:55:35 @
# Version	: @Revision: 1.10 @
# Summary	: Ease setup of common cost-group strategies for single and multi mode
# Keywords      : multi mode cost group cost_group path_group 
#
# Description:
#	This script enables used to setup cost groups with minimal effort when using
#	some common cost group strategies. It also allows setup of cost groups
#	compatible with EDI's default for easier flow analysis. The script
#	supports cost group setup for traditional as well as multi-mode designs
#	The strategies supported are:
#	  - edi
#	      same as EDI's default(in2reg, reg2reg, reg2out, in2out)
#	  - location
#	      same as EDI's default, different nomenclature(C2C, I2C, C2O, I2O)
#	  - clock
#	      based on clocks in the design
#	  - clock_location
#	      a combination of the 2 such that for a clock clk, there would be
#             cost groups clk_C2C, clk_C2O, clk_I2C, and clk_I2O
#	  - none
#	      only single default cost group is defined
#	One of the main uses of the script is intended to allow for cases where
#	users have to frequently change the cost-group setup for reporting 
#	purposes 
#
# Assumptions:
#	None
#
#===========================================================================
if {![info exists ::ns(compat)]}  { set ::ns(compat) "::aeware" }
if {![info exists ::ns(set_cost_groups)]} { set ::ns(set_cost_groups) "$::ns(compat)" }

namespace eval $::ns(set_cost_groups) {
    
    namespace export set_cost_groups

    proc set_cost_groups { args } {
	set setupMode "location"

	switch -- [parse_options [calling_proc] {} $args						 \
		       "-mode sos Cost Group strategy(edi|clock|clock_location|clock_location_single_io|location|none)" setupMode \
		       "-add bos add to existing cost groups(default is overwrite)" add] {
			   -2 { return }
			   0 { return -code error }
	}
	
	set designName [basename [find_unique_design]]

	set modeInfo {}
	foreach timingMode [find / -mode *] { lappend modeInfo "-mode [basename $timingMode]" }
	if {![llength $modeInfo]} { lappend modeInfo {} }
	
	if {[expr {!$add && ([llength [find / -cost_group *]] > 1)}]} { rm -quiet [ldelete [find / -cost_group *] [find / -cost_group default]] }
	
	switch $setupMode {
	    "edi" {
		if {[llength [all des seqs]] > 0} {
		    define_cost_group -name in2reg -design $designName
		    define_cost_group -name reg2out -design $designName
		    define_cost_group -name reg2reg -design $designName
		    
		    foreach timingMode $modeInfo {
			eval path_group $timingMode -from [all des seqs] -to [all des seqs] -group reg2reg -name reg2reg
			eval path_group $timingMode -from [all des seqs] -to [all des outs] -group reg2out -name reg2out
			eval path_group $timingMode -from [all des inps] -to [all des seqs] -group in2reg -name in2reg
		    }
		}
		
		define_cost_group -name in2out -design $designName
		foreach timingMode $modeInfo {
		    eval path_group $timingMode -from [all des inps]  -to [all des outs] -group in2out -name in2out
		}

		set cgExpr [join [filter -regexp clock_gating_integrated_cell {\w} [find /libraries -libcell *]] "|"]
		if {[llength ${cgExpr}]} {
		    set cgCells [filter -regexp libcell "(${cgExpr})" [find /designs -inst *]]
		    if {[llength ${cgCells}]} {
			define_cost_group -name clkgate -design $designName
			eval path_group $timingMode -to ${cgCells} -name clkgate -group clkgate
		    }
		}
	    }
	    "clock" {
		foreach clockLong [find / -clock *] {
		    set clock [basename $clockLong]
		    define_cost_group -name $clock -design $designName
		    foreach timingMode $modeInfo {
			set rootPath [lindex $timingMode end]
			if {![llength $rootPath]} { set rootPath "/" }
			eval path_group $timingMode -to [find ${rootPath} -clock $clock] -group $clock -name $clock
		    }
		}
	    }
	    "location" {
		if {[llength [all des seqs]] > 0} {
		    define_cost_group -name I2C -design $designName
		    define_cost_group -name C2O -design $designName
		    define_cost_group -name C2C -design $designName
		    
		    foreach timingMode $modeInfo {
			eval path_group $timingMode -from [all des seqs] -to [all des seqs] -group C2C -name C2C
			eval path_group $timingMode -from [all des seqs] -to [all des outs] -group C2O -name C2O
			eval path_group $timingMode -from [all des inps] -to [all des seqs] -group I2C -name I2C
		    }
		}
		
		define_cost_group -name I2O -design $designName
		foreach timingMode $modeInfo {
		    eval path_group $timingMode -from [all des inps]  -to [all des outs] -group I2O -name I2O
		}
	    }
	    "clock_location" {
		foreach clockLong [find / -clock *] {
		    set clock [basename $clockLong]
		    set c2cName [format "%s_C2C" $clock]
		    set c2oName [format "%s_C2O" $clock]
		    set i2cName [format "%s_I2C" $clock]
		    set i2oName [format "%s_I2O" $clock]
		    
		    if {[llength [all des seqs]] > 0} {
			if {[llength [all des seqs -clock $clock]] > 0} {
			    define_cost_group -name ${c2cName} -design $designName
			    define_cost_group -name ${i2cName} -design $designName
			    foreach timingMode $modeInfo { 
				eval path_group $timingMode -from [all des seqs] -to [all des seqs -clock ${clock}] -group ${c2cName} -name ${c2cName} 
				eval path_group $timingMode -from [all des inps] -to [all des seqs -clock ${clock}] -group ${i2cName} -name ${i2cName} 
			    }
			}
			if {[llength [all des outs -clock $clock]] > 0} {
			    define_cost_group -name ${c2oName} -design $designName
			    foreach timingMode $modeInfo { eval path_group $timingMode -from [all des seqs] -to [all des outs -clock ${clock}] -group ${c2oName} -name ${c2oName} }
			}
		    }
		    
		    if {[llength [all des outs -clock $clock]] > 0} {
			define_cost_group -name ${i2oName} -design $designName
			foreach timingMode $modeInfo { eval path_group $timingMode -from [all des inps]  -to [all des outs] -group ${i2oName} -name ${i2oName} }
		    }
		}
	    }
	    "clock_location_single_io" {
		if {[llength [all des seqs]] > 0} {
		    define_cost_group -name I2C -design $designName
		    define_cost_group -name C2O -design $designName
		    
		    foreach timingMode $modeInfo {
			eval path_group $timingMode -from [all des seqs] -to [all des outs] -group C2O -name C2O
			eval path_group $timingMode -from [all des inps] -to [all des seqs] -group I2C -name I2C
		    }
		}
		
		define_cost_group -name I2O -design $designName
		foreach timingMode $modeInfo {
		    eval path_group $timingMode -from [all des inps]  -to [all des outs] -group I2O -name I2O
		}

		foreach clockLong [find / -clock *] {
		    set clock [basename $clockLong]
		    set c2cName [format "%s_C2C" $clock]
		    
		    if {[llength [all des seqs]] > 0} {
			if {[llength [all des seqs -clock $clock]] > 0} {
			    define_cost_group -name ${c2cName} -design $designName
			    foreach timingMode $modeInfo { 
				eval path_group $timingMode -from [all des seqs] -to [all des seqs -clock ${clock}] -group ${c2cName} -name ${c2cName} 
			    }
			}
		    }
		}
	    }
	    "none" {
	    }
	    default {
		return -code error "Unrecognize -mode option specified"
	    }
	}
	foreach cgName [find / -cost_group *] { puts "Created cost group [basename $cgName]..." }
    }
}

namespace import ${::ns(set_cost_groups)}::set_cost_groups
add_command_help set_cost_groups "Automate the setup of all cost groups per standard strategies used" "Setup"

regexp {\d+(\.\d+)+} {@Revision: 1.10 @} pkgRev
package provide ::applet::set_cost_groups $pkgRev
    
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


