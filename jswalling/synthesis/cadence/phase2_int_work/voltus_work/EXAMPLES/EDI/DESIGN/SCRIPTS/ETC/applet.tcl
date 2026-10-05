#===========================================================================
# File Name	: Source: /grid/tfo/vol112/pctvault/cvs/infrastructure/applets/applet.tcl,v 
# Date Created	: 10/22/2010
# Date Modified	: Date: 2012/06/28 13:22:57 
# Version	: Revision: 1.73 
# Summary	: install/manage/update applets script-ware 
# Keywords      : applet app script ae-ware aeware sync update download repository plugin extension
#
# Description:
#          The applet command p rovide the necessary capabilities to manage script-ware applets
#          It provides several subcommand to perform load, installation, and update of 
#          applets as well as additional subcommands to query the server as well as 
#          the installation on what is currently available.
#          A 'whatis' command is also provided to enable the user to access summary
#          and detailed descriptions of the applets.
#          
#	
# Assumptions:
#	applets and applet server comply with the applet specification and requirements
#	
#===========================================================================

# pragma protect
# pragma protect begin

set _appletDir [file dirname [info script]]

# if running in RC, simply define attribute 'program_major_version'
# for other tools, need to source Cadence Compatibility Layer (CCL)
if {[expr {[llength [info commands set_remove_assign_options]] && 
	   [llength [info commands get_attribute]] && 
	   [string equal [get_attribute "program_short_name" /] "rc"]}]} {
    regexp {(\d+\.\d)} [get_attribute program_version /] ver
    if {![attribute_exists -type root program_major_version]} {
	define_attribute			\
	    -category applet			\
	    -data_type string			\
	    -obj_type root			\
	    -default_value ${ver}		\
	    -help_string "Major version of the software (i.e 11.1, 11.2, etc.)." \
	    program_major_version
    }
} else {
    if {[catch {package require compatibility} errMsg]} {
	if {[info exists ::env(INFRA)]} { 
	    source "$::env(INFRA)/compatibility.tcl" 
	} elseif {[file exists ${_appletDir}/compatibility.tcl]} { 
	    source "${_appletDir}/compatibility.tcl" 
	} else {
	    puts "Error: compatibility.tcl not found! \'compatibility.tcl\' is searched as follows:" 
	    puts "\t1) based on existence and contents of pkgIndex.tcl"
	    puts "\t2) based on existence and contents of INFRA environment variable"
	    puts "\t3) In the same directory as applet.tcl"
	    return -code error 
	}
    }
}

if {![info exists ::ns(compat)]}  { set ::ns(compat) "::aeware" }
if {![info exists ::ns(applet)]}  { set ::ns(applet) "${::ns(compat)}::applet" }

# This is needed due to CCL-friendly code pointing to ns(compat) 'redirect'. Issue is that
# EDI implements redirect but accidentally swapped the attribute
if {[namespace exists $::ns(compat)] &&
    [llength [info commands $::ns(compat)::get_attribute]] &&
    [string equal [${::ns(compat)}::get_attribute "program_short_name" /] "rc"]} { alias $::ns(compat)::redirect ::redirect }

unset -nocomplain _appletDir

namespace eval $::ns(applet) {
    variable quietMode 0
    variable baseDir [join [lrange [split [info nameofexecutable] /] 0 [expr {[llength [split [info nameofexecutable] /]] - 6}]] /]
    variable serverInstall $::env(HOME)/.localApps/server

    # depending on the tool and available connectivity, setup the following:
    # applet search path to be used
    # remote or local mode of server connectivity
    # server infromation
    switch -regexp [info nameofexecutable] {
	{/(tclsh|wish)[\d\.]*$}     { 
	    variable localServer /dev/null 
	    variable remoteServer splinter:/applets/default/devel
	    variable localInstall $::env(HOME)/.localApps/default/[get_attribute program_major_version /]
	}
	{/(velocity|encounter)$} { 
	    variable localServer /dev/null 
	    variable remoteServer splinter:/applets/edi/devel
	    variable localInstall $::env(HOME)/.localApps/edi/[get_attribute program_major_version /]
	}
	{/ctos(gui)?$}           { 
	    variable localServer /dev/null 
	    variable remoteServer splinter:/applets/ctos/devel
	    variable localInstall $::env(HOME)/.localApps/ctos/[get_attribute program_major_version /]
	}
	{/(lec|LEC|verify)$}     { 
	    variable localServer /dev/null 
	    variable remoteServer splinter:/applets/lec/devel
	    variable localInstall $::env(HOME)/.localApps/lec/[get_attribute program_major_version /]
	}
	{/(ccd|CCD)$}            {
	    variable localServer /dev/null 
	    variable remoteServer splinter:/applets/ccd/devel
	    variable localInstall $::env(HOME)/.localApps/ccd/[get_attribute program_major_version /]
	}
	{/(simvision\.exe)$}     { 
	    variable localServer /dev/null 
	    variable remoteServer splinter:/applets/ies/devel
	    variable localInstall $::env(HOME)/.localApps/ies/[get_attribute program_major_version /]
	}
	default                  { 
	    # need to make sure environment variable is declared and indeed running RC
	    if {[string equal [get_attribute "program_short_name" /] "rc"] && [info exists ::env(CDN_SYNTH_ROOT)]} {
		if {![file exists "${::env(CDN_SYNTH_ROOT)}/lib/applets"]} { 
		    variable localServer "[file dirname $::env(CDN_SYNTH_ROOT)]/etc/synth/applets" 
		} else {
		    variable localServer  ${::env(CDN_SYNTH_ROOT)}/lib/applets 
		}
		variable remoteServer [format "%s/%s" "splinter:/applets/rc" [get_attribute program_major_version /]]
		variable localInstall $::env(HOME)/.localApps/rc/[get_attribute program_major_version /]
	    } else {
		variable localServer /dev/null 
		variable remoteServer splinter:/applets/default/devel
		variable localInstall $::env(HOME)/.localApps/default/[get_attribute program_major_version /]
	    }
	}
    }
    if {[info exists localServer] && ![string equal "/dev/null" ${localServer}]} { lappend localInstall ${localServer} }

    # default to remote server if network connectivity is available
    ##nagelfar ignore
    if {![catch {set ftpSock [socket splinter.cadence.com 21]} errMsg]} {
	close $ftpSock
	variable defaultMode   remote 
	variable defaultServer [set [set ::ns(applet)]::remoteServer]
    } else {
	variable defaultMode local
	variable defaultServer [set [set ::ns(applet)]::localServer]
    }

    # Given a list of directories, warn of any such directories that are
    # not valid applet directories. Error out if no directories are valid
    # applet directories
    hidden_proc UpdateSearchPath {args} {
	set validDirs 0
	foreach searchDir ${args} { 
	    if {![file isdirectory ${searchDir}]} { 
		puts "Warning: Invalid \'applet_search_path\'..."
		puts "\t\'${searchDir}\' is not a directory"
	    } elseif {![file exists "${searchDir}/.servInfo"]}  {
		puts "Warning: Invalid \'applet_search_path\'..."
		puts "\t\'${searchDir}\' is not a valid applet directory"
	    } else {
		incr validDirs
	    }
	}
	if {${validDirs} == 0} { 
	    if {[namespace exists $::ns(compat)] &&
		[llength [info commands $::ns(compat)::get_attribute]] &&
		![string equal [${::ns(compat)}::get_attribute "program_short_name" /] "rc"]} { 
		puts "Warning: no paths in \'applet_search_path\' is a valid applet directory."
		return 
	    } else {
		puts "Error: at least one of the paths in \'applet_search_path\' must"
		puts "\tbe a valid applet directory."
		return -code error
	    }
	}
	return ${args}
    }

    # check network connectivty. If server available configure attributes accodingly
    # else configure to the local server
    hidden_proc SetServer {obj val} {
	variable $::ns(applet)::localServer
	variable $::ns(applet)::remoteServer

	if {[string match "remote" ${val}]} { 
	    if {![catch {set ftpSock [socket splinter.cadence.com 21]} errMsg]} {
		close ${ftpSock}
		if {[string match ${localServer}  [get_attr applet_server /]] || 
		    [string match ${remoteServer} [get_attr applet_server /]]} {
		    set_attr -quiet applet_server_pass ""  /
		    set_attr -quiet applet_server_user anonymous /
		    set_attr -quiet applet_server ${remoteServer} /
		} 
	    } 
	} else {
	    set_attr -quiet applet_server ${localServer} /
	}
	return 1
    }

    # This attribute allows the user to change the default installation location of the applet directory
    if {![attribute_exists -type root applet_exec_init]} {
	define_attribute			\
	    -category applet			\
	    -data_type boolean			\
	    -obj_type root			\
	    -default_value true			\
	    -hidden				\
	    -help_string "When true, applet load will display the applet banner if one exists." \
	    applet_exec_init
    }

    # This attribute allows the user to change the default installation location of the applet directory
    if {![attribute_exists -type root applet_search_path]} {
	define_attribute			\
	    -category applet			\
	    -data_type string			\
	    -obj_type root			\
	    -default_value 	${localInstall}	\
	    -hidden				\
	    -help_string "Search path for applet directories." \
	    applet_search_path
    }


    # This attribute specifies whether to use the applet data shipped with the tool or access 
    # the latest image over the network
    if {![attribute_exists -type root applet_mode]} {
	define_attribute				\
	    -category applet				\
	    -data_type string				\
	    -obj_type root				\
	    -default_value [set [set ::ns(applet)]::defaultMode] \
	    -hidden					\
	    -check_function $::ns(applet)::SetServer	\
	    -help_string "Applet update mode (local|remote)." \
	    applet_mode
    }

    # This attribute specifies whether to use the applet data shipped with the tool or access 
    # the latest image over the network
    if {![attribute_exists -type root applet_server]} {
	define_attribute				\
	    -category applet				\
	    -data_type string				\
	    -obj_type root				\
	    -default_value 	[set [set ::ns(applet)]::defaultServer]	\
	    -hidden					\
	    -help_string "Applet server used for dynamic updates." \
	    applet_server
    }

    # This attribute specifies the user name to be used when contacting applet server
    if {![attribute_exists -type root applet_server_user]} {
	define_attribute				\
	    -category applet				\
	    -data_type string				\
	    -obj_type root				\
	    -default_value 	"anonymous"		\
	    -hidden					\
	    -help_string "Applet server user name." \
	    applet_server_user
    }

    # This attribute specifies the user password to be used when contacting applet server
    if {![attribute_exists -type root applet_server_pass]} {
	define_attribute				\
	    -category applet				\
	    -data_type string				\
	    -obj_type root				\
	    -default_value 	""			\
	    -hidden					\
	    -help_string "Applet server user password." \
	    applet_server_pass
    }
}


namespace eval $::ns(applet) {
    variable appInfo 
    variable firstCmd {list unload dependancies create convert index submit_bug version update}

    namespace export applet
    
    # the load procedure will manage the auto_path TCL variable as well as invocation
    # of the package require command. The auto_path variable will always
    # be restored to its original value after loading
    hidden_proc loadApplet args {
	variable $::ns(applet)::quietMode 
	variable appInfo
	variable $::ns(applet)::serverInstall

	set appDirs [eval UpdateSearchPath [get_attribute applet_search_path /]]	;# Default update locations

 	switch -- [parse_options [calling_proc] {} $args \
		       "-location sos specifies location of applet directory (default is \'applet_search_path\')" appDirs \
		       "-version sos specifies version requirements if only one applet is specified (10.0, 10+, etc.)" versionReq \
		       "-server bos load applet from server (default is applet_search_path installation)" useServer \
		       "-no_init bos disable init routing irrespective of attribute settings" noInit \
		       "-debug bOs enable debug message output" debug \
		       "sos list of applets and associated collateral to load (default is ALL)" apps] {
			   -2 { return }
			   0 { return -code error }
	}

	if {[llength ${versionReq}]} {
	    if {[expr {[llength $apps] != 1}]} { 
		puts "Error: -version can only be used when a single applet name is provided as argument"
		return -code error
	    }
	    regsub -all "\s*" ${versionReq} "" versionReq
	    # look for '+' at end of string for non-exact match
	    unset -nocomplain pkgArg
	    if {[string index ${versionReq} end] ne "+"} { set pkgArg "-exact " }
	    set versionReq [string trimright ${versionReq} "+"]
	    set versionMsg ${versionReq}
	    if {![info exists pkgArg]} { append versionMsg " or greater" }
	    # ensure that after removing optional '+' the string is indeed a valid number
	    if {![string is double ${versionReq}]} {
		puts "Error: -version string is not a numeric. Valid arguments are 1, 1.1, 1.1+, etc."
		return -code error
	    }
	} 

	# save contents of TCL auto_path variable
	set _auto_path $::auto_path
	if {${useServer}} { 
	    set quietMode 1
	    set ::auto_path [concat $::auto_path ${serverInstall}]
	} else {
	    set quietMode 0
	    set ::auto_path [concat $::auto_path $appDirs]
	}

	array set appInfo {} ;# Need since Nagelfar does not understand tcl_source is loading the values
	if {${useServer}} { eval get_server_info }
	if {[string is false ${apps}]} {
	    if {!${useServer}} {
		foreach appLoc $appDirs {
		    if {![file isfile [format "%s/%s" $appLoc ".servInfo"]]} { continue }
		    tcl_source [format "%s/%s" $appLoc ".servInfo"]; # get specific installation's information
		}
	    }
	    regsub -all ",version" [array names appInfo *,version] "" apps
	    # remove hidden applets from automatic installation
	    # hidden applets can only be installed explicitly
	    regsub -all ",private" [array names "appInfo" *,private] "" hiddenApps 
	    foreach hiddenApp ${hiddenApps} {
		set hiddenIndex [lsearch ${apps} ${hiddenApp}]
		set apps [lreplace ${apps} ${hiddenIndex} ${hiddenIndex}]
	    }
	} 
	# install applet temporarily if loading from server
	# need to also install all dependencies
	if {${useServer}} { 
	    set requiredApps {}
	    foreach appName ${apps} { 
		if {![info exists appInfo(::applet::${appName},requires)]} {
		    puts "'${appName}\' not found on server. Please check spelling"
		    return -code error "\tor run \'applet avail\' to verify available \'applets\'"
		}
		set requiredApps [concat ${requiredApps} [eval get_required_apps ${appName} appInfo]]
	    }
	    set serverApps [lsort -unique ${requiredApps}]
	    eval install -force -location ${serverInstall} [list ${serverApps}] 
	}

	array unset appInfo
	
	foreach appName $apps { 
	    if {![regsub "::applet::" $appName "" shortName]} {
		set shortName ${appName}
		set appName "::applet::${appName}"
	    }
	    if {[llength ${versionReq}]} {
		append pkgArg "${appName} ${versionReq}"
	    } else {
		set pkgArg ${appName}
	    }
	    package forget ${appName}
	    if {[catch { eval package require $pkgArg } errMsg]} {
		puts "Error: unable to load applet \'$shortName\'"
		if {[llength ${versionReq}]} { puts "\tversion ${versionMsg} not found" }
		puts "\tPlease check proper spelling and setup"
		if {$debug} { puts "$errMsg" }
		set ::auto_path $_auto_path
		if {$debug} { 
		    puts [format "%s DEBUG:\n" [string repeat "#" 60]]
		    puts "$errMsg" 
		}
		return -code error
	    } else {
		puts "Loading applet \'$shortName\'..."
	    }
	}
	# remove temporary applets if loading from server
	if {${useServer} && !${debug}} { file delete -force ${serverInstall} }
	# restore auto_path to its original value
	set ::auto_path $_auto_path
	set bannerProc "$::ns(applet)::applet_init_${shortName}"
	if {[get_attr applet_exec_init / ] && ([llength [info commands ${bannerProc}]] == 1) && !${noInit}} { ${bannerProc} }
	return
    }


    # the unload procedure will remove an applet that has already been loaded
    # note that unloading an applet can produce unexpected behavior if the
    # applet was a dependancy of another applet not unloaded
    hidden_proc unloadApplet args {
 	switch -- [parse_options [calling_proc] {} $args \
		       "-debug bOs enable debug message output" debug \
		       "srs list of applets and associated collateral to unload" apps] {
			   -2 { return }
			   0 { return -code error }
	}

	foreach appName ${apps} {
	    regexp {\w+$} ${appName} shortName
	    set appName "::applet::${shortName}"
	    if {[catch {package present ${appName}}] || ![llength [info commands ${shortName}]]} { 
		puts "Error: applet and/or command \'${shortName}\' not present and cannot be unloaded"
		puts "\tApplets currently present are:"
		foreach loadedApp [$::ns(applet)::listApplet -tcl] { puts "\t  - ${loadedApp}" }
		return
	    } else {
		puts "Unloading applet \'${shortName}\'..."
		rename ${shortName} ""
		package forget ${appName}
	    }
	}
	return
    }


    # The list procedure is meant to provide the user an easy way to check which applets 
    # and require applet dependencies have been already loaded
    hidden_proc dependencies args {
	variable appInfo

	set appDirs [eval UpdateSearchPath [get_attribute applet_search_path /]]	;# Default update locations

 	switch -- [parse_options [calling_proc] {} $args \
		       "-used_by bos return list of applets that \'require\' the specified applet" listUsedBy	\
		       "-requires bos return list of applets that the specified applet \'requires\'" listRequires	\
		       "-server bos query information from server (default is applet_search_path installation)" useServer \
		       "-tcl bos return loaded applets as TCL list" tclList	\
		       "srs applet to provide dependency information for" appName] {
			   -2 { return }
			   0 { return -code error }
	}

	if {![regsub "::applet::" $appName "" shortName]} {
	    set shortName ${appName}
	    set appName "::applet::${appName}"
	}

	# Default should be to display applets 'required' as well as those 'used'
	if {!${listUsedBy} && !${listRequires}} {
	    set listUsedBy 1
	    set listRequires 1
	    if {${tclList}} { set listUsedBy 0 }
	}
	
	# Load information for all applets per \'applet_search_path\'
	array unset appInfo ;# Need since Nagelfar does not understand tcl_source is loading the values
	if {${useServer}} { 
	    eval get_server_info 
	} else {
	    foreach appLoc $appDirs {
		# skip applet directories that are not valid
		if {![file isfile [format "%s/%s" $appLoc ".servInfo"]]} { continue }
		tcl_source [format "%s/%s" $appLoc ".servInfo"]; # get specific installation's information
	    }
	}
	
	# ensure applet name provided is a valid applet indeed
	regsub -all ",version" [array names appInfo *,version] "" apps
	
	if {[lsearch -regexp ${apps} ${appName}] == -1} {
	    puts "Error: applet \'${appName}\' not found. Check the spelling of the applet as well as your \'applet_search_path\'"
	    return
	}

	# Return values per command-line options
	if {${tclList}} {
	    if {${listUsedBy} && ${listRequires}} {
		return "[concat $appInfo(${appName},requires) $appInfo(${appName},used_by)]"
	    } elseif {${listUsedBy}} {
		return "$appInfo(${appName},used_by)"
	    } else {
	        return "$appInfo(${appName},requires)"
	    }
	} else {
	    if {${listRequires}} {
		puts "The applet \'${appName}\' requires the following applets:"
		foreach requiredName $appInfo(${appName},requires) { puts "\t${requiredName}" }
	    }
	    if {${listUsedBy}} {
		puts "The applet \'${appName}\' is used by the following applets:"
		foreach usedByName $appInfo(${appName},used_by) { puts "\t${usedByName}" }
	    }
	    puts "\n"
	}
	return
    }


    # The list procedure is meant to provide the user an easy way to check which applets 
    # and require applet dependencies have been already loaded
    hidden_proc listApplet args {
 	switch -- [parse_options [calling_proc] {} $args \
		       "-tcl bos return loaded applets as TCL list" tclList] {
			   -2 { return }
			   0 { return -code error }
	}

	set appsAvail [lsort [lsearch -all -regexp -inline [package names] ::applet::]]
	set appsLoaded {}
	set saveErrInfo ${::errorInfo}
	foreach appName ${appsAvail} { 
	    regsub "::applet::" $appName "" appTail
	    if {![catch {package present ${appName}}]} { lappend appsLoaded "${appTail}" }
	}
	set ::errorInfo ${saveErrInfo}
	
	if {${tclList}} {
	    return "${appsLoaded}"
	} else {
	    puts "The following applets have been loaded:"
	    foreach appName ${appsLoaded} { puts [format "\t%-27s %5s" ${appName} [package present ::applet::${appName}]] }
	    puts "\n"
	}
	return
    }
    
    hidden_proc CreateBody args {
 	switch -- [parse_options [calling_proc] {} $args \
		       "-cmd srs command name for which body needs to be generated" cmdName	\
		       "sos name of the file where the command is implemented (default is \'<cmd>.tcl\'" cmdFileName] {
			   -2 { return }
			   0 { return -code error }
        }
	redirect ${cmdFileName} { puts "
if \{!\[info exists ::ns\(compat\)\]\}  \{ set ::ns\(compat\) \"::aeware\" \}
if \{!\[info exists ::ns\(<applet name>\)\]\} \{ set ::ns\(<applet name>\) \"\$\{::ns\(compat\)\}::${cmdName}\" \}

namespace eval \$::ns\(<applet name>\) \{
    if \{!\[llength \[info commands ::${cmdName}\]\]\} \{ namespace export ${cmdName} \}

    proc ${cmdName} \{ args \} \{
	regexp \{\\d+\(\\.\\d+\)+\} \{\@Revision: 1.0 \@\} pkgRev
				  
        switch -- \[parse_options \"\[calling_proc\] \$pkgRev\" \{\} \$args \
	       \. \. \.
               \. \. \.] \{
		   -2 \{ return \}
		   0 \{ return -code error \}
	\}

        <Main Body of Script>
    \}
\}

if \{!\[llength \[info commands ::<${cmdName}>\]\]\} \{ 
    namespace import \$::ns\(<applet name>\)::${cmdName}
    add_command_help ${cmdName} \"<Help message>\" \"<Help Category>\"
\}


regexp \{\\d+\(\\.\\d+\)+\} \{\@Revision: 1.0 \@\} pkgRev
package provide ::applet::<applet name> \$pkgRev
" }
	return
    }
    
    hidden_proc InsertHeader args {
 	switch -- [parse_options [calling_proc] {} $args \
		       "-cmd srs command name for which body needs to be generated" cmdName	\
		       "sos name of the file where the command is implemented (default is \'<cmd>.tcl\'" cmdFileName] {
			   -2 { return }
			   0 { return -code error }
        }
	set cmdFile [open ${cmdFileName} r]
	set cmdInfo [read ${cmdFile}]
	close ${cmdFile}
	redirect ${cmdFileName} { puts "#===========================================================================
# File Name	: \$Source\$
# Date Created	: <mm/dd/yyyy>
# Date Modified	: \$Date\$
# Version	: \@Revision: 1.0 \@
# Summary	: <One line summary>
# Keywords      : <List of keywords>
#
# Description:
#	<Description of main purpose and features of this script>
#
# Assumptions:
#	<Special considerations>
#
#===========================================================================

" }
	redirect -append ${cmdFileName} { puts "${cmdInfo}" }
	return
    }
    
    hidden_proc InsertFooter args {
 	switch -- [parse_options [calling_proc] {} $args \
		       "-cmd srs command name for which body needs to be generated" cmdName	\
		       "sos name of the file where the command is implemented (default is \'<cmd>.tcl\'" cmdFileName] {
			   -2 { return }
			   0 { return -code error }
        }

	redirect -append ${cmdFileName} { puts "

#===========================================================================
#
# Copyright 1997-2013 Cadence Design Systems, Inc.  All rights reserved worldwide. 
#
# The Tcl computer program and related information \(collectively \"Licensed Material\"\) 
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
# by the Recipient.  THE LICENSED MATERIAL IS PROVIDED \"AS IS\" AND WITH 
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

" }
	return
    }
    
    # The create procedure is meant to provide the user an easy way to generate a
    # template for an applet as well as submission instructions
    hidden_proc create args {
 	switch -- [parse_options [calling_proc] {} $args \
		       "-cmd srs command name for which body needs to be generated" cmdName	\
		       "sos name of the file where the command is implemented (default is \'<cmd>.tcl\'" cmdFileName] {
			   -2 { return }
			   0 { return -code error }
	}
#	if {[llength $args] || [regexp {^(h|he|hel|help)} $args]} { return -code error "\nUsage: [calling_proc]\n" }
	if {![llength ${cmdFileName}]} { set cmdFileName [format "%s.tcl" ${cmdName}] }

	eval CreateBody   -cmd ${cmdName} ${cmdFileName}
	eval InsertHeader -cmd ${cmdName} ${cmdFileName}
	eval InsertFooter -cmd ${cmdName} ${cmdFileName}
	return
    }

    # The convert procedure is meant to provide the user an easy way to migrate
    # existing ae-ware script to meet applet requirements as well as generate
    # submission instructions
    hidden_proc convert args {
 	switch -- [parse_options [calling_proc] {} $args] {
			   -2 { return }
			   0 { return -code error }
	}
#	if {[llength $args] || [regexp {^(h|he|hel|help)} $args]} { return -code error "\nUsage: [calling_proc]\n" }

    }

    hidden_proc install args {
	variable $::ns(applet)::quietMode
	variable appInfo
	variable $::ns(applet)::localInstall

	# default installation directory under /.localApps
	set appDir [lindex ${localInstall} 0]

 	switch -- [parse_options [calling_proc] {} $args \
		       "-location sos specifies location where to install applet directory" appDir	\
		       "-debug bOs enable debug message output" debug \
		       "-force bos force installation of applet even if it already exists" force	\
		       "sos list of applets and associated collateral to install (default is ALL)" apps] {
			   -2 { return }
			   0 { return -code error }
	}
	array set appInfo {} ;# Need since Nagelfar does not understand tcl_source is loading the values
 	eval get_server_info
	# If applets where not specified, install ALL
	if {[string is false $apps]} { 
	    regsub -all ",version" [array names "appInfo" *,version] "" installApps 
	    # remove hidden applets from automatic installation
	    # hidden applets can only be installed explicitly
	    regsub -all ",private" [array names "appInfo" *,private] "" hiddenApps 
	    foreach hiddenApp ${hiddenApps} {
		set hiddenIndex [lsearch ${installApps} ${hiddenApp}]
		set installApps [lreplace ${installApps} ${hiddenIndex} ${hiddenIndex}]
	    }
	} else {
	    set installApps $apps
	    foreach appName $installApps {
		if {![regsub "::applet::" $appName "" shortName]} {
		    set shortName ${appName}
		    set appName "::applet::${appName}"
		}
		if {![info exists appInfo($appName,version)]} {
		    return -code error "Error: No applet \'$shortName\' found on master location"
		}
	    }
	}

	foreach appName $installApps {
	    if {![regsub "::applet::" $appName "" shortName]} {
		set shortName ${appName}
		set appName "::applet::${appName}"
	    }
	    if {!${quietMode}} { puts "Installing applet \'$shortName\'..." }
	    set installPath [format "%s/%s" $appDir $appInfo($appName,path)]
	    if {[file exists $installPath]} {
		if {$force} {
		    file delete -force $installPath
		    # only delete applet directory if empty
		    if {[llength [glob -nocomplain -directory [file dirname $installPath] *]] == 0} { 
			file delete -force [file dirname $installPath] 
		    }
		} else {
		    puts "Error: applet \'$shortName\' is already installed. Please use"
		    puts "\t\'update\' command instead or \'-force\' switch"
		    return -code error 
		}
	    }

	    file mkdir [file dirname $installPath]
	    
	    if {[string match "local" [get_attribute applet_mode /]]} {
		set masterPath [format "%s/%s" [get_attribute applet_server /] $appInfo($appName,path)]
		file copy $masterPath $installPath
	    } else {
		set saveErrInfo ${::errorInfo}
		if {[catch {exec lftp -u [get_attr applet_server_user /],[get_attr applet_server_pass /] -e "lcd [file dirname $installPath];get $appInfo($appName,path);exit;" [get_attribute applet_server /]} errMsg]} {
		    if {$debug} { 
			puts [format "%s DEBUG:\n" [string repeat "#" 60]]
			puts "$errMsg" 
		    }
		    if {[regexp -nocase {failed} $errMsg]} {
			puts "Error: cannot find applet \'$shortName\' on server. Please check connection and server contents"
			return -code error 
		    }
		}
		set ::errorInfo ${saveErrInfo}
	    }
	}
	if {!${quietMode}} { puts "Updating applet catalog information..." }
	eval create_info $appDir
	return
    }
    
    hidden_proc whatis args {
	variable appInfo

	set appDirs [eval UpdateSearchPath [get_attribute applet_search_path /]]	;# Default update locations

 	switch -- [parse_options [calling_proc] {} $args \
		       "-detail bos reports detailed description of applet (default is short description)" detail \
		       "srs list of applets to report information for" appList] {
			   -2 { return }
			   0 { return -code error }
	}
	# Get latest applet information from server / tool install
	array set appInfo {} ;# Need since Nagelfar does not understand tcl_source is loading the values
	eval get_server_info
	array set masterInfo [array get appInfo]
	array unset appInfo
	foreach appName $appList {
	    if {![regsub "::applet::" $appName "" shortName]} {
		set shortName ${appName}
		set appName "::applet::${appName}"
	    }
	    foreach appLoc $appDirs {
		# skip applet directories that are not valid
		if {![file isfile [format "%s/%s" $appLoc ".servInfo"]]} { continue }
		tcl_source [format "%s/%s" $appLoc ".servInfo"]; # get specific installation's information
		if {[info exists appInfo($appName,summary)]} {
		    puts "Applet: $shortName"
		    puts "\tLocation: [file normalize $appLoc]"
		    puts "\tVersion:  $appInfo($appName,version)"
		    puts "\tSummary:  $appInfo($appName,summary)\n"
		    if {$detail} {
			puts "\tFull Description:"
			set foundDesc 0
			set appFile [open [format "%s/%s" $appLoc $appInfo($appName,path)] r]
			# open applet file and extract full description information
			while {[gets $appFile appLine] != -1}  {
			    if {[regexp -nocase {^\s*\#\s*description\s*:} $appLine]} { set foundDesc 1;continue; }
			    if {[regexp -nocase {^\s*\#\s*assumptions\s*:} $appLine]} { set foundDesc 0;break; }
			    if {$foundDesc} {
				regsub {^\s*\#} $appLine "" line
				puts "\t$line"
			    } else {
				continue
			    }
			}
			close $appFile
		    }
		} elseif {[info exists masterInfo($appName,summary)]} {
		    puts "Applet: ${shortName} (currently not installed)"
		    puts "\tLocation: Server"
		    puts "\tVersion:  $masterInfo($appName,version)"
		    puts "\tSummary:  $masterInfo($appName,summary)\n"
		    if {$detail} {
			puts "Info: \'-detail\' not available for server applets. Please install locally"
		    }
		} else {
		    array unset appInfo
		    return -code error "Error: applet \'$shortName\' not found. Please check the applet_search_path attribute and the applet names"
		}
	    }
	}
	array unset appInfo
	return
    }
    
    hidden_proc avail args {
	variable appInfo
	
	set appDirs [eval UpdateSearchPath [get_attribute applet_search_path /]]	;# Default update locations

 	switch -- [parse_options [calling_proc] {} $args \
		       "-location sos specifies location of applet directory (default is \'applet_search_path\')" appDirs \
		       "-debug bOs enable debug message output" debug \
		       "-detail bos reports each installation one at at time(default is consolidated view" detail \
		       "-outdated bos only reports scripts that are installed and out of date (default is current as well as outdated)" outdated \
		       "-local bos report installed and server versions of installed applets only (default is ALL applets)" local] {
			   -2 { return }
			   0 { return -code error }
	}

	if {$debug} { 
	    puts [format "%s DEBUG:\n" [string repeat "#" 60]]
	    puts "appDir ="
	    foreach dirName ${appDirs} { puts "\t${dirName}" }
	}

	# Get latest applet information from server / tool install
	if {![llength $appDirs] && ${local}} {
	    puts "Warning: no \'applet\' installation specified"
	    puts "\tPlease specify a local installation using the \'applet_search_path\' attribute"
	    puts "\tor the \'-location\' switch of \'applet avail\'"
	    puts "\tAlternatively, you can remove the \'-local\' switch to view what is available on the \'applet\' server"
	    return
	}
	if {![llength $appDirs] && !$local} { set appDirs "N/A" }
	array set appInfo {} ;# Need since Nagelfar does not understand tcl_source is loading the values
	eval get_server_info
	array set masterInfo [array get appInfo]
	array unset appInfo
	# Compare master against each local applet installation
	puts [format "%s\n" [string repeat "#" 80]]
	puts "Applets Local/Server information: "
	set installHeader "  Local Install"
	set validAppDirs 0
	for {set i 0} {${i} < [llength ${appDirs}]} {incr i} {
	    set appLoc [lindex ${appDirs} ${i}]
	    if {[file exists [format "%s/%s" $appLoc ".servInfo"]]} {
		puts "${installHeader} \#${i} (${appLoc})"
		tcl_source [format "%s/%s" $appLoc ".servInfo"]; # get specific installation's information
		regsub -all ",version" [array names appInfo *,version] "" availApps
		incr validAppDirs
	    } else {
		if {![info exists availApps]} { set availApps {} }
		puts "${installHeader} \#${i} (${appLoc})  *** NOT VALID APPLET DIRECTORY ***"
	    }
	    set installHeader "               "
	    foreach appName ${availApps} {
		if {[info exists appSource(${appName},dir)]} { 
		    if {[package vcompare $appSource(${appName},version) $appInfo(${appName},version)] == -1} {
			set appSource(${appName},dir) ${i} 
			set appSource(${appName},version) $appInfo(${appName},version)
		    }
		} else {
		    set appSource(${appName},dir) ${i} 
		    set appSource(${appName},version) $appInfo(${appName},version)
		}
	    } 
	}

	if {[string match "remote" [get_attribute applet_mode /]]} { 
	    puts "  Remote Server ([get_attribute applet_server /])"
	} else {
	    puts "  Local Server  ([get_attribute applet_server /])"
	}
	
	puts ""

	set appDirCount [llength ${appDirs}]
	if {!${detail}} { set appDirCount 1 }

	for {set i 0} {${i} < ${appDirCount}} {incr i} {
	    set appLoc [lindex ${appDirs} ${i}]
	    puts [format "%s\n" [string repeat "#" 80]]
	    if {${detail}} {
		array unset appInfo
		if {[file exists [format "%s/%s" $appLoc ".servInfo"]]} {
		    puts "Installation: ${appLoc}\n"
		    tcl_source [format "%s/%s" $appLoc ".servInfo"]; # get specific installation's information
		    regsub -all ",version" [array names appInfo *,version] "" availApps
		} else {
		    set availApps {} 
		}
	    }

	    # collect name only of all master applets
	    regsub -all ",version" [array names masterInfo *,version] "" masterApps
	    # only include full list of install/uninstalled when -local is not used
	    if {!$local} { set availApps [lsort -unique [concat $masterApps $availApps]] }
	    # generate header
	    if {${detail} || (${validAppDirs} == 1)} {
		puts "          Name          | Installed | Server Ver | Summary Description"
		puts "------------------------+-----------+------------+----------------------------------------------------------"
	    } else {
		puts "          Name          | Installed | I# | Server Ver | Summary Description"
		puts "------------------------+-----------+----+------------+----------------------------------------------------------"
	    }
	    # generate information for all applets specifiec by switches
	    foreach appName [lsort $availApps] {
		# Need to handle case where master no longer supports applet
		set masterVer "N/A"
		if {[info exists masterInfo($appName,version)]} { 
		    if {[info exists masterInfo($appName,private)]} {
			set masterVer "*N/A"
		    } else {
			set masterVer $masterInfo($appName,version) 
		    }
		}
		# Need to handle case where applet was not installed
		set appVer "N/A"
		if {[info exists appInfo($appName,version)]} { 
		    if {[info exists appInfo($appName,private)]} { 
			set appVer "*N/A"
		    } else {
			set appVer $appInfo($appName,version) 
		    }
		}
		
		if {[string match "*N/A" ${masterVer}] && [string match "*N/A" ${appVer}]} { continue }

		# skip up-to-date ones when using -outdated switch
		if {$outdated && ![string match "N/A" $appVer]} {
		    if {[string match "N/A" $masterVer]} { continue }
		    if {[package vcompare $masterVer $appVer] != 1} { continue }
		}
		# Extract summary information from master. If N/A extract from local.
		if {![string match "N/A" $masterVer]} { 
		    set summary $masterInfo($appName,summary)
		} else {
		    set summary $appInfo($appName,summary)
		}
		# Output information
		regsub "::applet::" $appName "" appName
		if {${detail} || (${validAppDirs} == 1)} {
		    puts [format "%23s |%10s |%11s | %s" ${appName} $appVer $masterVer $summary]
		} else {
		    set installID "-"
		    if {![regexp {N/A} ${appVer}]} { set installID "$appSource(::applet::${appName},dir)" }
		    puts [format "%23s |%10s | %2s | %11s | %s" ${appName} $appVer ${installID} $masterVer $summary]
		}
	    }
	    puts "\n"
	}
	puts "NOTE: To install an applet, use \'applet install -location <applets directory> \<applet name\>\'"
	array unset appInfo
	return
    }
    
    hidden_proc update args {
	variable appInfo
	
	set appDirs [eval UpdateSearchPath [get_attribute applet_search_path /]]	;# Default update locations
	
 	switch -- [parse_options [calling_proc] {} $args \
		       "-location sos specifies location of applet directory (default is \'applet_search_path\')" appDirs \
		       "sos list of applets to update (default is ALL installed)" appList] {
			   -2 { return }
			   0 { return -code error }
	}
	array set appInfo {} ;# Need since Nagelfar does not understand tcl_source is loading the values
	eval get_server_info
	array set masterInfo [array get appInfo]
	array unset appInfo
	foreach appLoc $appDirs {
	    puts "Info: Updating applet installation $appLoc..."
	    # skip applet directories that are not valid
	    if {![file isfile [format "%s/%s" $appLoc ".servInfo"]]} { continue }
	    tcl_source [format "%s/%s" $appLoc ".servInfo"]
	    # if no applets are specified default to all installed
	    if {![llength $appList]} { regsub -all ",version" [array names appInfo *,version] "" appList }
	    foreach appName $appList {
		if {![regsub "::applet::" $appName "" shortName]} {
		    set shortName ${appName}
		    set appName "::applet::${appName}"
		}
		# Need to handle case where master no longer supports applet
		set masterVer 0
		if {[info exists masterInfo($appName,version)]} { set masterVer $masterInfo($appName,version) }
		# Need to handle case where applet was not installed
		set appVer 0
		if {[info exists appInfo($appName,version)]} { set appVer $appInfo($appName,version) }
		if {[package vcompare $masterVer $appVer] == 1} { 
		    # Delete existing applet if it needs to be updated
		    if { $appVer == 0  } { set appVer "N/A" }
		    puts "Updating applet \'$shortName\' ($appVer -> $masterVer)..."
		    set installPath [format "%s/%s" $appLoc [file dirname $masterInfo($appName,path)]]
		    file delete -force $installPath
		    # Obtain applet from appropriate server
		    if {[string match "remote" [get_attribute applet_mode /]]} {
			set serverName [lindex [split [get_attribute applet_server /] :] 0]
			puts "Info: Connecting to server...."
			if {[catch {exec ping -c 1 $serverName} errMsg]} { return -code error  "Error: Applet server not accessible. Please check your connection" }
			puts "Info: Downloading applet update..."
			if {[catch {file mkdir ${installPath}} errMsg]} { return -code error "Error: No write access to create local applet installation in\n\t\'$installPath\'" }
			if {[catch {exec lftp -u [get_attr applet_server_user /],[get_attr applet_server_pass /] -e "lcd $installPath;get $appInfo($appName,path);exit;" [get_attribute applet_server /]} errMsg]} {
			    if {[regexp -nocase {failed} $errMsg]} {
				puts "Error: cannot find applet \'$shortName\' on server. Please check connection and server contents"
				return -code error 
			    }
			}
		    } else {
			file copy -force [format "%s/%s" [get_attribute applet_server /] [file dirname $masterInfo($appName,path)]] $installPath
		    }
		}
	    }
	    eval create_info $appLoc
	}
	array unset appInfo
	return
    }


    hidden_proc submit_bug args {
	if {[llength $args] || [regexp {^(h|he|hel|help)} $args]} { return -code error "\nUsage: [calling_proc]\n" }

	if {[catch {exec which mutt} appPath]} {
	    puts "Warning: \'mutt\' mail client not available on user path. Messages cannot be sent"
	    puts "         Please generate and email with the description of the problem and"
	    puts "         send your message with subject \'BUG: <applet name>\'"
	    return
	}
	
	# Collect information
	set userAlias $::env(USER)
	set execName [info nameofexecutable]
	set execAlias [file tail $execName]
	set hostName [info hostname]

	unset -nocomplain msg

	puts -nonewline "User Name: "
	flush stdout
	set userName [gets stdin]
	append msg "User: ${userName}(${userAlias})\n"
	append msg "Host: $hostName\n"
	append msg "Executable: $execName\n"
	
	puts -nonewline "Applet name: "
	flush stdout
	set appName [gets stdin]
	append msg "Applet: $appName\n"

	# Prompt user for full description
	puts "Please enter issue description \[:q\] to exit:"
	append msg "Bug description:\n"
	while 1 {
	    puts -nonewline "\[:q to exit\] > "
	    flush stdout
	    set line [gets stdin]
	    if {[regexp {^\s*:q\s*$} $line]} { break }
	    append msg "\t$line\n"
	}
	# Send the message and related information
	puts "Info: Generating and mailing bug report"
	##nagelfar ignore
	exec echo $msg | $appPath -s "BUG: $appName" diegoh@cadence.com ${userAlias}@cadence.com
	return
    }
    
    hidden_proc disclaim {args} {
	variable baseDir
	variable $::ns(applet)::localServer

	if {[llength $args] || [regexp {^(h|he|hel|help)} $args]} { return -code error "\nUsage: [calling_proc]\n" }
	set disclaimFileName  "${localServer}/DISCLAIMER_short.txt"
	if {[file exists ${disclaimFileName}]} {
	    set disclaimFile [open ${disclaimFileName} r]
	    while {[gets $disclaimFile line] != -1}  { puts $line }
	    close $disclaimFile
	} else {
	puts "
===========================================================================

 IMPORTANT DISCLAIMER REGARDING APPLETS:

 Copyright 1997-2013 Cadence Design Systems, Inc.  All rights reserved worldwide. 

 The Tcl computer program and related information \(collectively \"Licensed Material\"\) 
 contained herein are protected by copyright law and international treaties. 

 Cadence grants Recipient of the Licensed Material a nonexclusive right
 to use, copy, and modify the Licensed Material.   Should Recipient
 desire to distribute any portion of the Licensed Material, Recipient
 must obtain Cadence's permission.  In no event shall Recipient use the 
 Licensed Material for benchmarking purposes against Cadence's products.   

 The Licensed Material is provided to Recipient to use at Recipient's
 own risk. The Licensed Material may not be compatible with current or 
 future versions of Cadence products, and Cadence will not provide any 
 technical support for the Licensed Material, whether modified or not 
 by the Recipient.  THE LICENSED MATERIAL IS PROVIDED \"AS IS\" AND WITH 
 NO WARRANTIES, INCLUDING WITHOUT LIMITATION ANY EXPRESS WARRANTIES OR 
 IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR USE.

 IN NO EVENT SHALL CADENCE BE LIABLE TO RECIPIENT OR ANY THIRD PARTY
 FOR ANY INCIDENTAL, INDIRECT, SPECIAL OR CONSEQUENTIAL DAMAGES, OR ANY 
 OTHER DAMAGES WHATSOEVER \(INCLUDING, WITHOUT LIMITATION, DAMAGES FOR
 LOSS OF BUSINESS PROFITS, BUSINESS INTERRUPTION, LOSS OF BUSINESS 
 INFORMATION, OR OTHER PECUNIARY LOSS\) ARISING OUT OF THE USE OR
 INABILITY TO USE LICENSED MATERIAL, WHETHER OR NOT THE POSSIBILITY OR 
 CAUSE OF SUCH DAMAGES WAS KNOWN TO CADENCE.


 Cadence Design Systems, Inc.
 2655 Seely Avenue
 San Jose, CA 95134


===========================================================================

"
	}
	return
    }
	
    # given an array formatted as appInfo in .servInfo files
    # determine all required packages for a given applet
    hidden_proc get_required_apps {args} {
 	switch -- [parse_options [calling_proc] {} $args \
		       "srs name of applet to determine requirements for" appName \
		       "srs .servInfo array to mine required apps recursively" _appInfo] {
			   -2 { return }
			   0 { return -code error }
	}
	upvar ${_appInfo} appInfo
	
	if {![regsub "::applet::" $appName "" shortName]} {
	    set shortName ${appName}
	    set appName "::applet::${appName}"
	}

	if {![info exists appInfo(${appName},requires)]} { 
	    return -code error "Error: applet \'${appName}\' not found. Please check spelling"
	} else {
	    # remove any packages that are implied from list
	    set appInfo(${appName},requires) [lsearch -inline -not -all $appInfo(${appName},requires) "Tcl"]
	    if {$appInfo(${appName},requires) eq ""} { 
		return ${appName}
	    } else {
		foreach required $appInfo(${appName},requires) { 
		    return [lsort -unique [concat [eval get_required_apps ${required} "appInfo"] ${appName}]]
		}
	    }
	}
    }

    # regenerate package index and .servInfo file containing latest
    # server hash for use by other procedures
    hidden_proc create_info {args} {
	variable appInfo
	array unset appInfo

 	switch -- [parse_options "applet index" {} $args \
		       "-verbose bos provide additional detail when generating index files" verbose \
		       "srs applet installation to create information files for" appDir] {
			   -2 { return }
			   0 { return -code error }
	}
	# Before creating a .servInfo file we must always ensure package index is up to dateg
	set autoFiles [glob -nocomplain "${appDir}/*.tcl~" "${appDir}/\#*.tcl\#"]
	if {[llength ${autoFiles}]} { file delete -force ${autoFiles} }
	set cmd pkg_mkIndex
	if {${verbose}} { append cmd " -verbose" }
	set pkgInfo [lsearch -all -inline -not -regexp [glob -tails -types {f} -directory ${appDir} */*] .*(~|\.log|\.cmd)$]
	set saveErrInfo ${::errorInfo}
	set ::errorInfo ""
	if {[catch {eval ${cmd} ${appDir} ${pkgInfo}} errMsg]} {
	    return -code error "Error: failed to generate package Index for location $appDir"
	} 
	if {${::errorInfo} ne ""} {
	    if {${verbose}} { 
		puts "$::errorInfo" 
	    } else {
		puts "Error: unexpected message while generating package Index for location $appDir"
		return -code error "\trun \'applet index -verbose ${appDir}\' for additional information"
	    }
	}
	set ::errorInfo ${saveErrInfo}
	
	# Examine TCL generated package index and populate appInfo hash
	file rename -force "${appDir}/pkgIndex.tcl" "${appDir}/pkgIndex-auto.tcl"
	set autoPkgFile [open [format "%s/%s" $appDir "pkgIndex-auto.tcl"] r]
	while {[gets $autoPkgFile pkgLine] != -1}  {
	    if {![regexp {^package.*} $pkgLine]} { continue }; # only lines that define a package are of interest
	    # Extract version and file location information from package 
	    # and summary information from file itself
	    set pkgName [lindex $pkgLine 2]
	    set appInfo(${pkgName},version) [lindex $pkgLine 3]
	    # Empty dependancy information created for consistency to make code easier for other functions
	    if {![info exists appInfo(${pkgName},summary)]}  { set appInfo(${pkgName},summary) "None provided" }
	    if {![info exists appInfo(${pkgName},requires)]} { set appInfo(${pkgName},requires) {} }
	    if {![info exists appInfo(${pkgName},used_by)]}  { set appInfo(${pkgName},used_by) {} }
	    set appLoc [string range [lindex $pkgLine 9] 0 end-2]
	    set appFile [open [format "%s/%s" $appDir $appLoc] r]
	    set appInfo(${pkgName},path) $appLoc
	    # open applet file and extract summary information
	    while {[gets $appFile appLine] != -1}  {
		if {[regexp -nocase {^\s*\#\s*summary\s*:\s*(.*)} $appLine match summary]} { 
		    set appInfo(${pkgName},summary) $summary
		} elseif {[regexp -nocase {^\s*package\s+require\s+(\S+)} $appLine match reqPkg]} { 
		    lappend appInfo(${pkgName},requires) $reqPkg
		    lappend appInfo(${reqPkg},used_by) $pkgName
		} elseif {[regexp -nocase {^\s*\#\s*applet\s+hide\s*$} $appLine match]} { 
		    set appInfo(${pkgName},private) 1
		} else {
		    continue
		}
	    }
	    close $appFile
	}
	close $autoPkgFile
	file delete [format "%s/%s" $appDir "pkgIndex-auto.tcl"]
	# Generate pkgIndex.tcl to be compatible with encrypted and non-encrypted files
	set pkgFile [open [format "%s/%s" $appDir "pkgIndex.tcl"] w]
	puts $pkgFile "\# Tcl package index file, version 1.1
\# This file is generated by the \"pkg_mkIndex\" command
\# in combination with the \"applet\" infrastructure
\# and sourced either when an application starts up or
\# by a \"package unknown\" script.  It invokes the
\# \"package ifneeded\" command to set up package-related
\# information so that packages will be loaded automatically
\# in response to \"package require\" commands.  When this
\# script is sourced, the variable \$dir must contain the
\# full path name of this file's directory.
"
	foreach pkgName [lsort [array names appInfo *,version]] {
	    regsub ",version" $pkgName "" pkgName
	    puts $pkgFile "set location(${pkgName}) \[list source \[file join \$dir $appInfo(${pkgName},path)\]\]"
	}
#	    puts $pkgFile "if {![file exists $location(::applet::foundationflow)]} { set location(::applet::foundationflow) [list source [file join \$dir foundationflow/foundationflow.etf]] }"
	puts $pkgFile "
foreach pkgName \[array names location\] \{
    if \{!\[file exists \[lindex \$location(\${pkgName}) end\]\]\} \{ regsub \"\\\\.tcl\" \$location(\${pkgName}) \".etf\" location(\${pkgName}) \} 
\}
"
	foreach pkgName [lsort [array names appInfo *,version]] {
	    regsub ",version" $pkgName "" pkgName
#	    puts $pkgFile "package ifneeded $pkgName $appInfo($pkgName,version) \[list source \[file join \$dir $appInfo($pkgName,path)\]\]"
	    puts $pkgFile "package ifneeded $pkgName $appInfo($pkgName,version) \$location(${pkgName})"
	}
	close $pkgFile
	# write information into server file
	set serverFile [open [format "%s/%s" $appDir ".servInfo"] w]
	foreach notApplet [lsearch -inline -all -regexp -not [array names appInfo *,*] ::applet::] { unset appInfo(${notApplet}) }
	puts $serverFile "array set appInfo [list [array get appInfo]]"
	puts $serverFile "
set appInfo(location) \[file dirname \[file normalize \[info script\]\]\]

if \{\[string match \"local\" \[get_attribute applet_mode \/\]\]\} \{
    foreach pkgPath \[array names appInfo *,path\] \{
	regsub \",path\" \$pkgPath \"\" pkgName
	if \{!\[file exists \"\$appInfo(location)/\$appInfo(\${pkgPath})\"\]\} \{ 
	    regsub \"\\\\.tcl\" \$appInfo(\${pkgPath}) \".etf\" appInfo(\${pkgPath}) 
	    if \{!\[file exists \"\$appInfo(location)/\$appInfo(\${pkgPath})\"\]\} \{ 
		return -code error \"Error: package \'\${pkgName}\' not found with TCL or ETF extension\" 
	    \}
	\}
    \}
\}
"
	close $serverFile
	return
    }


    # Running this will create a hash 'appInfo' with all summary, version, and path
    # informatio for the chosen server
    hidden_proc get_server_info {args} {
	variable $::ns(applet)::quietMode
	variable appInfo
	array unset appInfo

	foreach xferDir [glob -nocomplain "$::env(HOME)/.cadence_app_*"] { file delete -force ${xferDir} }
	set xferDir "$::env(HOME)/.cadence_app_[pid]"

	if {[llength $args] || [regexp {^(h|he|hel|help)} $args]} { return -code error "\nUsage: [calling_proc]\n" }

	# Make sure applet exited cleanly or a .app directory is not in use by user
	if {[file exists "${xferDir}"]} {
	    puts "Error: Either the \'applet\' application exited unexpectedly on a previous session"
	    puts "\tor a directory \'${xferDir}\' already existed. Please remove such directory"
	    return -code error
	} 

	if {[string match "remote" [get_attribute applet_mode /]]} {
	    # Directory is necessary to ensure user files are not overwritten	    
	    if {[catch {file mkdir ${xferDir}} errMsg]} { return -code error "Error: Current directory must have write access when in \'remote\' mode" }
	    
	    set serverName [lindex [split [get_attribute applet_server /] :] 0]
	    if {!${quietMode}} { puts "Info: Connecting to server...." }
	    if {[catch {exec ping -c 1 $serverName} errMsg]} { return -code error  "Error: Applet server not accessible. Please check your connection" }
	    if {!${quietMode}} { puts "Info: Collecting applet server information..." }
#	    file mkdir ${xferDir}
	    set saveErrInfo ${::errorInfo}
	    if {[catch {exec lftp -u [get_attr applet_server_user /],[get_attr applet_server_pass /] -e "lcd ${xferDir};get .servInfo pkgIndex.tcl;exit;" [get_attr applet_server /]} errMsg]} {
		if {[regexp -nocase {failed} $errMsg]} {
		    puts "Error: remote server \'applet\' information not available or not complete. Please check"
		    puts "\tthe server location or your server installation may be corrupted"
		    file delete -force ${xferDir}
		    puts "$errMsg"
		    return -code error
		} 
	    }
	    set ::errorInfo ${saveErrInfo}
	    set serverInfo [file join ${xferDir} ".servInfo"]
	    set serverIndex [file join ${xferDir} "pkgIndex.tcl"]
	} else {
	    set serverInfo [file join [get_attribute applet_server /] ".servInfo"]
	    set serverIndex [file join [get_attribute applet_server /] "pkgIndex.tcl"]
	    if {![file exists $serverInfo] || ![file exists $serverIndex]} { 
		puts "Error: local server \'applet\' information not available or not complete. Please check"
		puts "\tthe server location or your server installation may be corrupted"
		return -code error 
	    }
	    if {!${quietMode}} { puts "Info: Collecting applet server information..." }
	}
	# Ensure that package index was not manually updated making .servInfo stale
	# .servInfo should always be modified within 10 seconds of pkgIndex.tcl
#	if { ![expr {abs([file mtime ${serverInfo}] - [file mtime ${serverIndex}]) < 10}] } {
#	    return -code error "Error: master \'applet\' information is corrupted. Please regenerate"
#	}
	tcl_source ${serverInfo}
	file delete -force ${xferDir}
    }

    # procedure to output version information
    hidden_proc version {args} {
	if {[llength $args] || [regexp {^(h|he|hel|help)} $args]} { 
	    puts "\nUsage: [calling_proc]\n" 
	} else {
	    regexp {\d+(\.\d+)*} {@Revision: 1.8 @} pkgRev
	    puts "applet command Version: ${pkgRev}"
	}
	return
    }

    # procedure to reset applet_search_path,applet_server attributes and related
    # to their default values
    hidden_proc setDefaultAppletPaths {args} {
	variable $::ns(applet)::remoteServer 
	variable $::ns(applet)::localServer 
	variable $::ns(applet)::localInstall

	if {[llength $args] || [regexp {^(h|he|hel|help)} $args]} { 
	    puts "\nUsage: applet set_defaults\n" 
	} else {
	    switch [get_attr applet_mode] {
		"remote" { set_attr applet_server ${remoteServer} / }
		"local"  { set_attr applet_server ${localServer} / }
	    }
	    set_attr applet_search_path ${localInstall} /
	    set_attr -quiet applet_server_pass ""  /
	    set_attr -quiet applet_server_user anonymous /
	}
	return
    }

    # Top level procedure invoking all the subtasks
    hidden_proc applet {args} {
	# record source_verbose status for restoring later
	set srcVerbose [get_attr source_verbose /]
	set_attr -quiet source_verbose false /

        variable $::ns(applet)::firstCmd 

	# Issue disclaimer on first execution of any applet command
	if {[lsearch $firstCmd [lindex $args 0]] == -1} { 
	    eval disclaim
	    if {![string match "avail" [lindex $args 0]]} { lappend firstCmd [lindex $args 0] }
	}


	set subcmdInfo {}
	lappend subcmdInfo [list "whatis"  "visible" "$::ns(applet)::whatis"     "display information about an applet"]
	lappend subcmdInfo [list "load"    "visible" "$::ns(applet)::loadApplet" "load an applet and related collateral"]
	lappend subcmdInfo [list "list"    "visible" "$::ns(applet)::listApplet" "list all applets already loaded"]
	lappend subcmdInfo [list "install" "visible" "$::ns(applet)::install"    "install applet tree in specified location"]
	lappend subcmdInfo [list "avail"   "visible" "$::ns(applet)::avail"      "list all applets installed"]
	lappend subcmdInfo [list "update"  "visible" "$::ns(applet)::update"     "update installed applets"]
	lappend subcmdInfo [list "version" "visible" "$::ns(applet)::version" "return version information"]
	lappend subcmdInfo [list "set_defaults" "visible" "$::ns(applet)::setDefaultAppletPaths"    "set server and search_path attributes to default"]
	lappend subcmdInfo [list "unload"  "hidden"  "$::ns(applet)::unloadApplet"  "unload applet"]
	lappend subcmdInfo [list "submit_bug" "hidden" "$::ns(applet)::submit_bug"  "generate bug reports"]
	lappend subcmdInfo [list "create"  "hidden"  "$::ns(applet)::create"     "create applet template script and instructions for submission"]
	lappend subcmdInfo [list "convert" "hidden"  "$::ns(applet)::convert"    "update an existing script to satisfy \'applet\' requirements and generate instructions for submission"]
	lappend subcmdInfo [list "index"   "hidden"  "$::ns(applet)::create_info" "generate index files for setting up an applet server"]
	lappend subcmdInfo [list "depend"  "hidden"  "$::ns(applet)::dependencies" "List all applets that use a specific applet and all applets a specifc applet uses"]
	set returnVal [dispatch_subcommand applet $args $subcmdInfo "manage applet infrastructure" ]

	set_attr -quiet source_verbose ${srcVerbose} /
	return ${returnVal}
    }
}

if {![llength [info commands ::applet]]} { 
    namespace import $::ns(applet)::applet 
    add_command_help applet "main command to install/manage/update \'applets\'" "Applets"
}

regexp {\d+(\.\d+)*} {@Revision: 1.8 @} pkgRev
package provide applet $pkgRev 

# pragma protect end

#===========================================================================
#
# Copyright 1997-2013 Cadence Design Systems, Inc.  All rights reserved worldwide. 
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

