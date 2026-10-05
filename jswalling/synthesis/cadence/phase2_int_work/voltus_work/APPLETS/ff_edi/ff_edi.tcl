#===========================================================================
# File Name    : @Source: /socesrc/cvsroot/FF/src/APPLETS/ff_edi.tcl,v @
# Date Created    : 06/10/2012
# Date Modified    : @Date: 2012/06/13 19:05:31 @
# Version    : @Revision: 1.3 @
# Summary    : 
# Keywords      : 
#
# Description:
#    
#    
#    
#       
#
# Assumptions:
#    
#
#===========================================================================
# pragma protect
# pragma protect begin

if {![info exists ::ns(compat)]}  { set ::ns(compat)  "::aeware" }
if {![info exists ::ns(ff_edi)]} { set ::ns(ff_edi) "${::ns(compat)}::ff_edi" }

#package require ...

namespace eval $::ns(applet) {
    variable pkgDir [file dirname [info script]]

    proc applet_init_ff_edi {} { 

        global vars

        if {![info exists vars(script_path)]} {
            set vars(script_path) [file dirname [info nameofexecutable]]/../../../../share/FoundationFlows/SCRIPTS
        }

        if {[file isdirectory $vars(script_path)]}  {
            Puts "<FF> Loading the EDI Foundation Flow utilities from $vars(script_path) ..."
            uplevel #0 source $vars(script_path)/EDI/procs.tcl
            uplevel #0 source $vars(script_path)/ETC/utils.tcl
        }

    }
}

# pragma protect end

regexp {\d+(\.\d+)+} {@Revision: 1.3 @} pkgRev
package provide ::applet::ff_edi $pkgRev

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


