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

#!/grid/common/bin/tclsh

proc Puts args {
}

proc setVar args {
}

proc setBetaFeature args {
}

set vars(script_path) ""
if {[file isdirectory [file dirname [file normalize $argv0]]]} {
   set vars(script_path) [file dirname [file normalize $argv0]]
}

proc ff_gen_css_header {fhw {a 12}} {
 
   global vars  

   puts $fhw "<STYLE TYPE=\"text/css\">"
   puts $fhw "   BODY {"
   puts $fhw "      padding-left: 20px;"
   puts $fhw "      padding-right: 20px;"
   puts $fhw "      background-color: #CCFFCC;"
   puts $fhw "   }"
   puts $fhw "   P.BREAK {"
   puts $fhw "      page-break-before: always"
   puts $fhw "   }"
   puts $fhw "   P {"
#   puts $fhw "      padding-top: 12px;"
#   puts $fhw "      padding-bottom: 12px;"
#   puts $fhw "      BORDER-style: ridge; "
#   puts $fhw "      background-color: white;"
   puts $fhw "      font-family: verdana, sans-serif;"
   puts $fhw "      font-size: 12;"
   puts $fhw "      text-align: center; "
   puts $fhw "   }"
   puts $fhw "   PRE {"
   puts $fhw "      color: black;"
   puts $fhw "      font-family: andele mono, monospace;"
   puts $fhw "      font-size: 12;"
   puts $fhw "      font-weight: bold;"
   puts $fhw "   }"
   puts $fhw "   HW {"
   puts $fhw "      color: black;"
   puts $fhw "      background-color: #FFFFFF;"
   puts $fhw "      font-family: andele mono, monospace;"
   puts $fhw "      font-size: 12;"
   puts $fhw "      font-weight: bold;"
   puts $fhw "   }"
   puts $fhw "   HG {"
   puts $fhw "      color: black;"
   puts $fhw "      background-color: #9999FF;"
   puts $fhw "      font-family: andele mono, monospace;"
   puts $fhw "      font-size: 12;"
   puts $fhw "      font-weight: bold;"
   puts $fhw "   }"
   puts $fhw "   HY {"
   puts $fhw "      color: black;"
   puts $fhw "      background-color: #FFFF33;"
   puts $fhw "      font-family: andele mono, monospace;"
   puts $fhw "      font-size: 12;"
   puts $fhw "      font-weight: bold;"
   puts $fhw "   }"
   puts $fhw "   H1 {"
   puts $fhw "      color: blue;"
   puts $fhw "      background-color: #CCFFCC;"
   puts $fhw "      font-family: andele mono, monospace;"
   puts $fhw "      font-size: 20;"
   puts $fhw "      text-align: center;"
   puts $fhw "   }"
   puts $fhw "   H2 {"
   puts $fhw "      color: black;"
   puts $fhw "      background-color: #CCFFCC;"
   puts $fhw "      font-family: andele mono, monospace;"
   puts $fhw "      font-size: 12;"
   puts $fhw "      text-align: center;"
   puts $fhw "   }"
   puts $fhw "   TH {"
   puts $fhw "      color: black;"
   puts $fhw "      background-color: #FFFFFF;"
   puts $fhw "      font-family: verdana, sans-serif;"
   puts $fhw "      font-size: 14;"
   puts $fhw "      text-align: center;"
   puts $fhw "   }"
   puts $fhw "   TH#S12 {"
   puts $fhw "      color: black;"
   puts $fhw "      background-color: #FFFFFF;"
   puts $fhw "      font-family: verdana, sans-serif;"
   puts $fhw "      font-size: 12;"
   puts $fhw "      text-align: center;"
   puts $fhw "   }"
   puts $fhw "   TD {"
   puts $fhw "      color: blue;"
   puts $fhw "      background-color: #FFFF99;"
   puts $fhw "      font-family: andele mono, monospace;"
   puts $fhw "      font-size: 12;"
   puts $fhw "      text-align: center;"
   puts $fhw "      font-weight: bold;"
   puts $fhw "   }"
   puts $fhw "   TD#BLACK {"
   puts $fhw "      color: black;"
   puts $fhw "      background-color: #FFFF99;"
   puts $fhw "      font-family: andele mono, monospace;"
   puts $fhw "      font-size: 12;"
   puts $fhw "      text-align: center;"
   puts $fhw "      font-weight: bold;"
   puts $fhw "   }"
   puts $fhw "   TD#RIGHT {"
   puts $fhw "      color: black;"
   puts $fhw "      background-color: #FFFF99;"
   puts $fhw "      font-family: andele mono, monospace;"
   puts $fhw "      font-size: 12;"
   puts $fhw "      text-align: right;"
   puts $fhw "      font-weight: bold;"
   puts $fhw "   }"
   puts $fhw "   A {"
   puts $fhw "      color: blue;"
   puts $fhw "      font-family: andele mono, monospace;"
   puts $fhw "      font-size: $a;"
   puts $fhw "      text-align: center;"
   puts $fhw "   }"
   puts $fhw "   A:HOVER {"
   puts $fhw "      color: red;"
   puts $fhw "   }"
   puts $fhw "</STYLE>"
}

proc ff_text2html {infile outfile} {

   global vars
   global cpu
   global wns
   global tns
   global vp
   global power
   global stats
   global density
   global rise_delay
   global fall_delay
   global rise_skew
   global fall_skew
   global sinks
   global buffers
   global levels
   global clock_list

#puts "<DEBUG> ff_text2html : $infile $outfile"

   set op [open $outfile w] 
   set ip [open $infile r]

   ff_gen_css_header $op

   puts $op "<PRE>"

#      set td 0
#      set tv 0
   set sc ?
   set scp ?
   set mc ?
   set mcp ?
#      set wl 0
   while {[gets $ip line]>=0} {
      if {!([regexp "<FF>" $line]) && !([regexp "<CMD>" $line])} {
         regsub -all "<" $line "\[" line
         regsub -all ">" $line "\]" line
      }
      if {[regexp "#Total number of DRC violations =" $line]} {
         set td [lindex $line 6]
      }
      if {[regexp "^wire length =" $line]} {
         set wl [lindex $line 4]
      } else {
         if {[regexp "#Total wire length =" $line]} {
            set wl [lindex $line 4]
         }
      }
      if {[regexp "#Total number of vias =" $line]} {
         set tv [lindex $line 5]
      }
      if {[regexp "#Total number of single cut vias =" $line]} {
         regsub "\\)" $line "" line
         set sc [lindex $line 7]
         set scp [lindex $line 9]
      }
      if {[regexp "#Total number of multi-cut vias =" $line]} {
         regsub "\\)" $line "" line
         set mc [lindex $line 6]
         set mcp [lindex $line 8]
      }
      if {([regexp "COMPLETED STEP :" $line]) & ([info exists td])} { 
         set stats([lindex $line 4]) [list $td $wl $tv $sc $scp $mc $mcp]
      }

      if {[regexp " Clock.*Timing Analysis" $line]} {
        set clock [lindex $line 2] 
        if {[info exists clock_list]} {
           if {[lsearch $clock_list $clock] == -1} {
              lappend clock_list $clock 
           }
        } else {
           set clock_list [list $clock]
        }
      }
      if {[regexp "Rise Phase Delay " $line]} {
        set rise_delay($clock) [lindex $line 4]
      }
      if {[regexp "Fall Phase Delay " $line]} {
        set fall_delay($clock) [lindex $line 4]
      }
      if {[regexp "Rise Skew" $line]} {
        set rise_skew($clock) [lindex $line 3]
      }
      if {[regexp "Fall Skew" $line]} {
        set fall_skew($clock) [lindex $line 3]
      }
      if {[regexp "Nr. of Sink" $line]} {
        set sinks($clock) [lindex $line 4]
      }
      if {[regexp "Nr. of Buffer" $line]} {
        set buffers($clock) [lindex $line 4]
      }
      if {[regexp "Nr. of Level" $line]} {
        set levels($clock) [lindex $line 6]
      }
      if {[regexp ".summary" $infile]} {
         set step [lindex [split [file tail $infile] "."] 0]
         if {[regexp "Setup mode" $line]} { 
           set rpt_dir $vars(orig_rpt_dir)
           if {[info exists vars($step,rpt_dir)]} {
             set rpt_dir $vars($step,rpt_dir)
            }
            regsub "Setup mode" $line "  SETUP   " line
            set split_line [split $line "|"]
            set i 0 
            set path_groups [list]
            foreach split $split_line {
               regsub -all " " $split "" split
               set index($split) $i
               if {[file exists $rpt_dir/${step}_${split}.tarpt]} {
                 lappend path_groups $split
               }
               incr i 
            }
            set vars($step,path_groups) $path_groups
            puts "<FF> Found path groups $path_groups ..."
         }
         set split_line [split $line "|"]
         if {[regexp WNS $line]} { 
            foreach group $path_groups {
               set wns($vars(step),$group) [lindex $split_line $index($group)]
            }
         }
         if {[regexp TNS $line]} { 
            foreach group $path_groups {
               set tns($vars(step),$group) [lindex $split_line $index($group)]
            }
         }
         if {[regexp "Violating Paths" $line]} { 
            foreach group $path_groups {
               set vp($vars(step),$group) [lindex $split_line $index($group)]
            }
         }
#         if {[regexp WNS $line]} { 
#            set split_line [split $line "|"]
#            set wns($vars(step),reg2out) [lindex $split_line $index(reg2out)]
#            set wns($vars(step),in2reg) [lindex $split_line $index(in2reg)]
#            set wns($vars(step),reg2reg) [lindex $split_line $index(reg2reg)]
#            set wns($vars(step),all) [lindex $split_line $index(all)]
#         }
#         if {[regexp TNS $line]} { 
#            set split_line [split $line "|"]
#            set tns($vars(step),reg2out) [lindex $split_line $index(reg2out)]
#            set tns($vars(step),in2reg) [lindex $split_line $index(in2reg)]
#            set tns($vars(step),reg2reg) [lindex $split_line $index(reg2reg)]
#            set tns($vars(step),all) [lindex $split_line $index(all)]
#         }
#         if {[regexp "Violating Paths" $line]} { 
#            set split_line [split $line "|"]
#            set vp($vars(step),reg2out) [lindex $split_line $index(reg2out)]
#            set vp($vars(step),in2reg) [lindex $split_line $index(in2reg)]
#            set vp($vars(step),reg2reg) [lindex $split_line $index(reg2reg)]
#            set vp($vars(step),all) [lindex $split_line $index(all)]
#         }
         if {[regexp Density $line]} { 
            set density($vars(step)) [lindex $line 1] 
         }
         if {[info exists path_groups]} {
            foreach group $path_groups {
               if {[regexp $group $line] != 0} {
                  regsub $group $line "<A HREF=file:[file normalize $vars(html_dir)/RPT/$vars(step)_$group.tarpt]>$group</A>" line
               }
             }
          }
#         foreach group "in2reg reg2out reg2reg in2out clkgate all" {
#            if {[regexp $group $line] != 0} {
#               regsub $group $line "<A HREF=file:[file normalize $vars(html_dir)/RPT/$vars(step)_$group.tarpt]>$group</A>" line
#            }
#         }
         foreach group "tran cap fanout" {
            if {[regexp max_$group $line] != 0} {
               regsub max_$group $line "<A HREF=file:[file normalize $vars(html_dir)/RPT/$vars(step).$group]>max_$group</A>" line
            }
         }
      }
      if {[regexp "RUNNING STEP" $line] != 0} {
         puts $op "<A NAME=[lindex $line 3]></A>"
      }
   
      if {([regexp "= Slack Time" $line]) || \
          ([regexp "RUNNING STEP" $line]) || \
          ([regexp "Total Power:" $line]) || \
          ([regexp "<FF>" $line]) ||  \
          ([regexp "<CMD>" $line])} {
         set style HY 
         if {[regexp "<FF>" $line]} {
            regsub "<FF>" $line "FF:" line
         }
         if {[regexp "<CMD>" $line]} {
            regsub "<CMD>" $line "CMD:" line
            set style HG 
         }
         if {[regexp "RUNNING STEP" $line]} {
            set style HW 
         }
         if {[regexp "= Slack Time" $line]} {
            set step [lindex [split [file tail $infile] \".\"] 0]
            if {![info exists wns($step)]} {
               set wns($step) [lindex $line 3]
            }
         }
         if {[regexp "Total Power:" $line]} {
            set step [lindex [split [file tail $infile] \".\"] 0]
            if {![info exists power($step)]} {
               set power($step) [lindex $line 2]
            }
         }
         puts $op "</PRE>"
         puts $op "<$style>"
         puts $op $line 
         puts $op "</$style>"
         puts $op "<PRE>"
      } else {
         puts $op $line 
      }
      if {[regexp "Total Leakage Power:" $line]} {
         set step [lindex [split [file tail $infile] \".\"] 0]
         if {![info exists power($step,leakage)]} {
            set power($step,leakage) [lindex $line 3]
         }
      }
      if {[regexp "Total Internal Power:" $line]} {
         set step [lindex [split [file tail $infile] \".\"] 0]
         if {![info exists power($step,internal)]} {
            set power($step,internal) [lindex $line 3]
         }
      }
      if {[regexp "Total Switching Power:" $line]} {
         set step [lindex [split [file tail $infile] \".\"] 0]
         if {![info exists power($step,switching)]} {
            set power($step,switching) [lindex $line 3]
         }
      }
   }
   puts $op "</PRE>"
   close $ip
   close $op

#      puts "$cpu(h), $cpu(m), $cpu(s)"
#   if {[info exists clock_list]} {
#      foreach clock $clock_list {
#         puts "$clock, $rise_delay($clock), $fall_delay($clock), $rise_skew($clock), $fall_skew($clock)"
#      }
#   }
}

proc ff_gen_html_summary {step pstep} {

   global vars
   global wns
   global tns
   global vp
   global power
   global stats
   global density
   global rise_delay
   global fall_delay
   global rise_skew
   global fall_skew
   global sinks
   global buffers
   global levels
   global clock_list

#      puts "<FF> Generating step summary for $step ..."

   set op [open $vars(html_dir)/$step.html w]

   ff_gen_css_header $op

   if {[info exists wns($step,all)]} {
      set pwall $wns($step,all)
   } else {
      set pwall ??
   }
   if {[info exists wns($step,reg2reg)]} {
      set pwr2r $wns($step,reg2reg)
   } else {
      set pwr2r ??
   }
   if {[info exists wns($step,reg2out)]} {
      set pwr2o $wns($step,reg2out)
   } else {
      set pwr2o ??
   }
   if {[info exists wns($step,in2reg)]} {
      set pwi2r $wns($step,in2reg)
   } else {
      set pwi2r ??
   }
   if {[info exists tns($step,all)]} {
      set ptall $tns($step,all)
   } else {
      set ptall ??
   }
   if {[info exists tns($step,reg2reg)]} {
      set ptr2r $tns($step,reg2reg)
   } else {
      set ptr2r ??
   }
   if {[info exists tns($step,reg2out)]} {
      set ptr2o $tns($step,reg2out)
   } else {
      set ptr2o ??
   }
   if {[info exists tns($step,in2reg)]} {
      set pti2r $tns($step,in2reg)
   } else {
      set pti2r ??
   }
   if {[info exists vp($step,all)]} {
      set pvall $vp($step,all)
   } else {
      set pvall ??
   }
   if {[info exists vp($step,reg2reg)]} {
      set pvr2r $vp($step,reg2reg)
   } else {
      set pvr2r ??
   }
   if {[info exists vp($step,reg2out)]} {
      set pvr2o $vp($step,reg2out)
   } else {
      set pvr2o ??
   }
   if {[info exists vp($step,in2reg)]} {
      set pvi2r $vp($step,in2reg)
   } else {
      set pvi2r ??
   }
   if {[info exists power($step)]} {
      set ppower $power($step)
   }
   if {[info exists power($step,leakage)]} {
      set lpower $power($step,leakage)
   }
   if {[info exists power($step,internal)]} {
      set ipower $power($step,internal)
   }
   if {[info exists power($step,switching)]} {
      set spower $power($step,switching)
   }
   if {[info exists density($step)]} {
      set putil $density($step)
   }
   if {[info exists stats($step)]} {
      set drcs [lindex $stats($step) 0]
      set wl [lindex $stats($step) 1]
      set vias [lindex $stats($step) 2]
      set sc [lindex $stats($step) 3]
      set scp [lindex $stats($step) 4]
      set mc [lindex $stats($step) 5]
      set mcp [lindex $stats($step) 6]
   } else {
      if {[info exist stats($pstep)]} {
         set drcs [lindex $stats($pstep) 0]
         set wl [lindex $stats($pstep) 1]
         set vias [lindex $stats($pstep) 2]
         set sc [lindex $stats($pstep) 3]
         set scp [lindex $stats($pstep) 4]
         set mc [lindex $stats($pstep) 5]
         set mcp [lindex $stats($pstep) 6]
      }
   }
#   if {[info exists pwr2r]} {
#      puts $op "<BR>"
#      puts $op "<BR>"
#      puts $op "<TABLE WIDTH=600 BORDER=2 CELLSPACING=2 CELLPADDING=2 ALIGN=CENTER>"
#      puts $op "   <TR>"
#      puts $op "       <TH COLSPAN=5 WIDTH=600 ALIGN=CENTER>"
#      puts $op "          <IMG HEIGHT=30 SRC=\"speed.png\" ALT=\"Timing\">"
#      puts $op "      </TH>"
#      puts $op "   </TR>"
#      puts $op "   <TR HEIGHT=30>"
#      puts $op "      <TD ID=RIGHT WIDTH=200>"
#      puts $op "         Path Group"
#      puts $op "      </TD>"
#      puts $op "      <TD ID=BLACK WIDTH=100>"
#      puts $op "           ALL"
#      puts $op "      </TD>"
#      puts $op "      <TD ID=BLACK WIDTH=100>"
#      puts $op "           R2R"
#      puts $op "      </TD>"
#      puts $op "      <TD ID=BLACK WIDTH=100>"
#      puts $op "           R2O"
#      puts $op "      </TD>"
#      puts $op "      <TD ID=BLACK WIDTH=100>"
#      puts $op "           I2R"
#      puts $op "      </TD>"
#      puts $op "   </TR>"
#
#      puts $op "   <TR HEIGHT=30>"
#      puts $op "      <TD ID=RIGHT WIDTH=200>"
#      puts $op "         WNS"
#      puts $op "      </TD>"
#      puts $op "      <TD WIDTH=100>"
#      puts $op "           $pwall"
#      puts $op "      </TD>"
#      puts $op "      <TD WIDTH=100>"
#      puts $op "           $pwr2r"
#      puts $op "      </TD>"
#      puts $op "      <TD WIDTH=100>"
#      puts $op "           $pwr2o "
#      puts $op "      </TD>"
#      puts $op "      <TD WIDTH=100>"
#      puts $op "           $pwi2r "
#      puts $op "      </TD>"
#      puts $op "   </TR>"
#   }
#   if {[info exists ptr2r]} {
#      puts $op "   <TR HEIGHT=30>"
#      puts $op "      <TD ID=RIGHT WIDTH=200>"
#      puts $op "         TNS"
#      puts $op "      </TD>"
#      puts $op "      <TD WIDTH=100>"
#      puts $op "           $ptall"
#      puts $op "      </TD>"
#      puts $op "      <TD WIDTH=100>"
#      puts $op "           $ptr2r"
#      puts $op "      </TD>"
#      puts $op "      <TD WIDTH=100>"
#      puts $op "           $ptr2o "
#      puts $op "      </TD>"
#      puts $op "      <TD WIDTH=100>"
#      puts $op "           $pti2r "
#      puts $op "      </TD>"
#      puts $op "   </TR>"
#   }
#   if {[info exists pvr2r]} {
#      puts $op "   <TR HEIGHT=30>"
#      puts $op "      <TD ID=RIGHT WIDTH=200>"
#      puts $op "         VIOLATING PATHS"
#      puts $op "      </TD>"
#      puts $op "      <TD WIDTH=100>"
#      puts $op "           $pvall"
#      puts $op "      </TD>"
#      puts $op "      <TD WIDTH=100>"
#      puts $op "           $pvr2r"
#      puts $op "      </TD>"
#      puts $op "      <TD WIDTH=100>"
#      puts $op "           $pvr2o "
#      puts $op "      </TD>"
#      puts $op "      <TD WIDTH=100>"
#      puts $op "           $pvi2r "
#      puts $op "      </TD>"
#      puts $op "   </TR>"
#   }
   if {[info exists vars($step,path_groups)]} {
   puts $op "</TABLE>"
   puts $op "<BR>"
      puts $op "<BR>"
      puts $op "<BR>"
      puts $op "<TABLE WIDTH=600 BORDER=2 CELLSPACING=2 CELLPADDING=2 ALIGN=CENTER>"
      puts $op "   <TR>"
      puts $op "       <TH COLSPAN=[expr [llength $vars($step,path_groups)]+1] WIDTH=600 ALIGN=CENTER>"
      puts $op "          <IMG HEIGHT=30 SRC=\"speed.png\" ALT=\"Timing\">"
      puts $op "      </TH>"
      puts $op "   </TR>"
      puts $op "   <TR HEIGHT=30>"
      puts $op "      <TD ID=RIGHT WIDTH=200>"
      puts $op "         Path Group"
      puts $op "      </TD>"
      foreach group $vars($step,path_groups) {
         puts $op "      <TD ID=BLACK WIDTH=100>"
         puts $op "           [string toupper $group]"
         puts $op "      </TD>"
      } 
      puts $op "   </TR>"
      puts $op "   <TR HEIGHT=30>"
      puts $op "      <TD ID=RIGHT WIDTH=200>"
      puts $op "         WNS"
      puts $op "      </TD>"
      foreach group $vars($step,path_groups) {
         puts $op "      <TD WIDTH=100>"
         puts $op "           $wns($step,$group)"
         puts $op "      </TD>"
      }
      puts $op "   </TR>"
      puts $op "   <TR HEIGHT=30>"
      puts $op "      <TD ID=RIGHT WIDTH=200>"
      puts $op "         TNS"
      puts $op "      </TD>"
      foreach group $vars($step,path_groups) {
         puts $op "      <TD WIDTH=100>"
         puts $op "           $tns($step,$group)"
         puts $op "      </TD>"
      }
      puts $op "   </TR>"
      puts $op "   <TR HEIGHT=30>"
      puts $op "      <TD ID=RIGHT WIDTH=200>"
      puts $op "         VIOLATING PATHS"
      puts $op "      </TD>"
      foreach group $vars($step,path_groups) {
         puts $op "      <TD WIDTH=100>"
         puts $op "           $vp($step,$group)"
         puts $op "      </TD>"
      }
      puts $op "   </TR>"
      puts $op "</TABLE>"
      puts $op "<BR>"
   }
   if {[info exists clock_list]} {
      puts $op "<TABLE WIDTH=\"1000\" BORDER=2 CELLSPACING=2 CELLPADDING=2 ALIGN=CENTER>"
      puts $op "   <TR>"
      puts $op "       <TH COLSPAN=8 WIDTH=500 ALIGN=CENTER>"
      puts $op "          <IMG HEIGHT=30 SRC=\"clocks.png\" ALT=\"Clock\">"
      puts $op "      </TH>"
      puts $op "   </TR>"
      puts $op "   <TR HEIGHT=30>"
      puts $op "      <TD ID=BLACK WIDTH=100>"
      puts $op "           CLOCK"
      puts $op "      </TD>"
      puts $op "      <TD ID=BLACK WIDTH=150>"
      puts $op "           RISE DELAY"
      puts $op "      </TD>"
      puts $op "      <TD ID=BLACK WIDTH=150>"
      puts $op "           FALL DELAY"
      puts $op "      </TD>"
      puts $op "      <TD ID=BLACK WIDTH=150>"
      puts $op "           RISE SKEW"
      puts $op "      </TD>"
      puts $op "      <TD ID=BLACK WIDTH=150>"
      puts $op "           FALL SKEW"
      puts $op "      </TD>"
      puts $op "      <TD ID=BLACK WIDTH=100>"
      puts $op "           LEVELS"
      puts $op "      </TD>"
      puts $op "      <TD ID=BLACK WIDTH=100>"
      puts $op "           BUFFERS"
      puts $op "      </TD>"
      puts $op "      <TD ID=BLACK WIDTH=100>"
      puts $op "           SINKS"
      puts $op "      </TD>"
      puts $op "   </TR>"
      foreach clock $clock_list {
         puts $op "   <TR HEIGHT=30>"
         puts $op "      <TD WIDTH=100>"
         puts $op "         $clock" 
         puts $op "      </TD>"
         puts $op "      <TD WIDTH=150>"
         puts $op "         $rise_delay($clock)" 
         puts $op "      </TD>"
         puts $op "      <TD WIDTH=150>"
         puts $op "         $fall_delay($clock)" 
         puts $op "      </TD>"
         puts $op "      <TD WIDTH=150>"
         puts $op "         $rise_skew($clock)" 
         puts $op "      </TD>"
         puts $op "      <TD WIDTH=150>"
         puts $op "         $fall_skew($clock)" 
         puts $op "      </TD>"
         puts $op "      <TD WIDTH=150>"
         puts $op "         $levels($clock)" 
         puts $op "      </TD>"
         puts $op "      <TD WIDTH=150>"
         puts $op "         $buffers($clock)" 
         puts $op "      </TD>"
         puts $op "      <TD WIDTH=150>"
         puts $op "         $sinks($clock)" 
         puts $op "      </TD>"
         puts $op "   </TR>"
      }
      puts $op "</TABLE>"
      puts $op "<BR>"
   }
   if {[info exists ppower]} {
      puts $op "<TABLE WIDTH=\"600\" BORDER=2 CELLSPACING=2 CELLPADDING=2 ALIGN=CENTER>"
      puts $op "   <TR>"
      puts $op "       <TH COLSPAN=4 WIDTH=600 ALIGN=CENTER>"
      puts $op "          <IMG HEIGHT=30 SRC=\"power.png\" ALT=\"Timing\">"
      puts $op "      </TH>"
      puts $op "   </TR>"
      puts $op "   <TR HEIGHT=30>"
      puts $op "      <TD ID=BLACK WIDTH=100>"
      puts $op "           TOTAL"
      puts $op "      </TD>"
      puts $op "      <TD ID=BLACK WIDTH=100>"
      puts $op "           SWITCHING"
      puts $op "      </TD>"
      puts $op "       <TD ID=BLACK WIDTH=100>"
      puts $op "           LEAKAGE"
      puts $op "      </TD>"
      puts $op "       <TD ID=BLACK WIDTH=100>"
      puts $op "           INTERNAL"
      puts $op "      </TD>"
      puts $op "   </TR>"
      puts $op "   <TR HEIGHT=30>"
      puts $op "      <TD WIDTH=100>"
      puts $op "           $ppower"
      puts $op "      </TD>"
      puts $op "      <TD WIDTH=100>"
      puts $op "           $spower"
      puts $op "      </TD>"
      puts $op "      <TD WIDTH=100>"
      puts $op "           $lpower"
      puts $op "      </TD>"
      puts $op "      <TD WIDTH=100>"
      puts $op "           $ipower"
      puts $op "      </TD>"
      puts $op "   </TR>"
      puts $op "</TABLE>"
      puts $op "<BR>"
   } 
   puts $op "<TABLE WIDTH=\"600\" BORDER=2 CELLSPACING=2 CELLPADDING=2 ALIGN=CENTER>"
      puts $op "   <TR HEIGHT=30>"
      puts $op "      <TH COLSPAN=2 WIDTH=200>"
      puts $op "         <IMG HEIGHT=30 SRC=calc.png ALT=\"Setting\">"
      puts $op "      </TH>"
      puts $op "   </TR>"
   if {[info exists putil]} {
      puts $op "   <TR HEIGHT=30>"
      puts $op "      <TD WIDTH=100>"
      puts $op "           Utilization"
      puts $op "      </TD>"
      puts $op "      <TD WIDTH=100>"
      puts $op "           $putil"
      puts $op "      </TD>"
      puts $op "   </TR>"
   }
   if {[info exists drcs]} {
      puts $op "   <TR HEIGHT=30>"
      puts $op "      <TD WIDTH=100>"
      puts $op "           Total DRCs"
      puts $op "      </TD>"
      puts $op "      <TD WIDTH=100>"
      puts $op "           $drcs"
      puts $op "      </TD>"
      puts $op "   </TR>"
   }
   if {[info exists wl]} {
      puts $op "   <TR HEIGHT=30>"
      puts $op "      <TD WIDTH=200>"
      puts $op "           Total Wirelength"
      puts $op "      </TD>"
      puts $op "      <TD WIDTH=100>"
      puts $op "           $wl"
      puts $op "      </TD>"
      puts $op "   </TR>"
   }
   if {[info exists vias]} {
      puts $op "   <TR HEIGHT=30>"
      puts $op "      <TD WIDTH=200>"
      puts $op "           Total Vias"
      puts $op "      </TD>"
      puts $op "      <TD WIDTH=100>"
      puts $op "           $vias"
      puts $op "      </TD>"
      puts $op "   </TR>"
   }
   if {[info exists sc]} {
      puts $op "   <TR HEIGHT=30>"
      puts $op "      <TD WIDTH=200>"
      puts $op "           Via Coverage (S/M)"
      puts $op "      </TD>"
      puts $op "      <TD WIDTH=200>"
      puts $op "           $scp / $mcp"
      puts $op "      </TD>"
      puts $op "   </TR>"
   }
   puts $op "</TABLE>"
   puts $op "<BR>"
   puts $op "<BR>"
}

#if {[info exists env(FF_SETUP_PATH)]} {
#   if {[file exists $env(FF_SETUP_PATH)]} {
#      Puts "<FF> LOADING $env(FF_SETUP_PATH)/setup.tcl ..."
#      if {[catch {source $env(FF_SETUP_PATH)/setup.tcl} setup_error]} {
#         set setup_tcl $env(FF_SETUP_PATH)/setup.tcl 
#         puts $setup_error
#         exit  
#      }
#
#   } else {
#      Puts "<FF> ERROR: $env(FF_SETUP_PATH)/setup.tcl does not exist"
#      exit
#   }
#} else {
#   if {[file exists setup.tcl]} {
#      puts "<FF> LOADING setup.tcl"
#      if {[catch {source setup.tcl} setup_error]} {
#         puts $setup_error
#         exit  
#      }
#      set setup_tcl setup.tcl 
#   } else {
#      Puts "<FF> ERROR: setup.tcl does not exist"
#      exit
#   }
#}

#if {[file exists edi_config.tcl]} {
#   puts "<FF> LOADING edi_config.tcl FILE"
#   source edi_config.tcl
#}

#source $vars(script_path)/ETC/utils.tcl
#FF::seed_variables
source $vars(script_path)/../vars.tcl

set dir [lindex $argv 0]
puts "<FF> HTML files will be generated in '$vars(html_dir)' ..."
if {[file isdirectory $vars(html_dir)]} {
   exec /bin/rm -fr $vars(html_dir)
   exec /bin/rm -f index.html
}
catch {exec /bin/mkdir -p $vars(html_dir)}
catch {exec /bin/mkdir -p $vars(html_dir)/RPT}
catch {exec /bin/mkdir -p $vars(html_dir)/LOG}

foreach image "step density logo log speed power time calc summary header blank viol clocks" {
   if {[file exists $vars(script_path)/GIF/$image.gif]} {
      file copy $vars(script_path)/GIF/$image.gif $vars(html_dir)
   }
   if {[file exists $vars(script_path)/GIF/$image.png]} {
      file copy $vars(script_path)/GIF/$image.png $vars(html_dir)
   }
}

#set step_list "init place prects cts postcts postcts_hold route postroute \
#               postroute_hold postroute_si_hold postroute_si signoff"

source $env(FFVARS)

set step_list $vars(steps)

set fhw [open "$vars(html_dir)/index.html" w]
#catch {exec ln -s $vars(html_dir)/index.html}

puts "<FF> Generating HTML files ..."

set files [list]
catch {set files [glob $vars(log_dir)/*.log*]}
puts "<FF>    Logfiles ..."
foreach step $step_list {
   set vars(step) $step
   set mtime 0
   foreach file $files {
      set ip [open $file r]
      while {[gets $ip line]>=0} {
         if {[regexp -line "COMPLETED STEP : $step\$" $line]} {
#            puts "$file,$mtime,[file mtime $file]"
            if {[file mtime $file]> $mtime} {
               set log($step) $file
               set mtime [file mtime $file]
               gets $ip line
               set days [lindex $line 4]
               set time [lindex $line 6]
               set cpu($step) [format "%s:%s" $days $time]

               ff_text2html $log($step) $vars(html_dir)/LOG/[file tail $log($step)]
#                  puts "<FF>       FOUND $step -> $log($step)"
                set log($step) $vars(html_dir)/LOG/[file tail $log($step)]
            }
         }
      }
      close $ip
   }
   if {[info exists log($step)]} {
      puts "<FF>       $step -> $log($step)"
  } else {
      puts "<FF>       $step -> NOT FOUND"
  }
}
set cpu(d) 0
set cpu(h) 0
set cpu(m) 0
set cpu(s) 0

foreach step $step_list {
#   puts "$step, $cpu($step)"
   if {[info exists cpu($step)]} {
      set split_time [split $cpu($step) ":"]
      set d [lindex $split_time 0]
      if {$d != "??:??"} {
         set cpu(d) [expr $cpu(d) + $d]
      }
      set h [lindex $split_time 1]
      regsub "^0" $h "" h
      if {$h != "??:??"} {
         set cpu(h) [expr $cpu(h) + $h]
      }
      set m [lindex $split_time 2]
      regsub "^0" $m "" m
      if {$m != "??:??"} {
         set cpu(m) [expr $cpu(m) + $m]
      }
      set s [lindex $split_time 3]
      regsub "^0" $s "" s
      if {$s != "??:??"} {
         set cpu(s) [expr $cpu(s) + $s]
      }
   } else {
      puts "<FF> No runtime data found for step $step ..."
   }
}

set files [list]
#catch {set files [glob $vars(rpt_dir)/*.summary]}
foreach step $step_list {
   set rpt_dir $vars(orig_rpt_dir)
   if {[info exists vars($step,rpt_dir)]} {
      set rpt_dir $vars($step,rpt_dir)
   }
   if {[file isfile $rpt_dir/$step.summary]} {
      set tsr($step) $rpt_dir/$step.summary
   }
   if {[file isfile $rpt_dir/$step.power.rpt]} {
      set pwr($step) $rpt_dir/$step.power.rpt
   }
}
#if {[file isdirectory $vars(rpt_dir)/HTML]} { 
#  exec rm -r $vars(rpt_dir)/HTML
#}
#foreach file $files {
#   set tsr([lindex [split [file tail $file] "."] 0]) $file
#}
puts "<FF>    Timing Reports ..."
foreach step $step_list {
   set vars(step) $step
   if {[info exists tsr($step)]} {
      set rpt_dir [file dirname $tsr($step)]
      puts "<FF>       FOUND $step -> $tsr($step)"
      ff_text2html $tsr($step) $vars(html_dir)/RPT/$step.summary
      set tsr($step) $vars(html_dir)/RPT/$step.summary
      if {[regexp _hold $step] == 0} {
         foreach group $vars($step,path_groups) {
            ff_text2html $rpt_dir/${step}_$group.tarpt $vars(html_dir)/RPT/${step}_$group.tarpt
         }
         foreach group "tran cap fanout" {
            ff_text2html $rpt_dir/${step}.$group $vars(html_dir)/RPT/${step}.$group
         }
      }
      puts "<FF>       $step -> $tsr($step)"
   } else {  
#      puts "<FF>   NOT FOUND $step"
   }
}

#set files [list]
#catch {set files [glob $vars(rpt_dir)/*.power.rpt]}
#foreach file $files {
#   set pwr([lindex [split [file tail $file] "."] 0]) $file
#}
puts "<FF>    Power Reports ..."
foreach step $step_list {
   set vars(step) $step
   if {[info exists pwr($step)]} {
#      puts "<FF>       FOUND $step -> $pwr($step)"
      ff_text2html $pwr($step) $vars(html_dir)/RPT/$step.power.rpt
      set pwr($step) $vars(html_dir)/RPT/$step.power.rpt
      puts "<FF>       $step -> $pwr($step)"
   } else {  
#      puts "<FF>   NOT FOUND $step"
   }
}

if {[info exists cpu(d)]} {
#   puts "$cpu(d), $cpu(h), $cpu(m), $cpu(s)"
   set m [lindex [split [ expr ($cpu(s)*1.0)/60 ] "."] 0]
   set s [lindex [split [ expr ($cpu(s)*1.0)/60 ] "."] 1]
   if {$m>0} {
      set cpu(m) [expr $cpu(m) + $m] 
   }
   set cpu(s) [expr 0.$s * 60]
#   puts "$cpu(h), $cpu(m), $cpu(s)"
   set h [lindex [split [ expr ($cpu(m)*1.0)/60 ] "."] 0]
   set m [lindex [split [ expr ($cpu(m)*1.0)/60 ] "."] 1]
   if {$h>0} {
      set cpu(h) [expr $cpu(h) + $h] 
   }
   set cpu(m) [expr 0.$m * 60]
   set d [lindex [split [ expr ($cpu(h)*1.0)/24 ] "."] 0]
   set h [lindex [split [ expr ($cpu(h)*1.0)/24 ] "."] 1]
   if {$d>0} {
      set cpu(d) [expr $cpu(d) + $d] 
   }

   set d [lindex [split $cpu(d) "."] 0]
   set h [lindex [split $cpu(h) "."] 0]
   set m [lindex [split $cpu(m) "."] 0]
   set s [lindex [split $cpu(s) "."] 0]

   set cpu(d) $d
   set cpu(h) $h
   set cpu(m) $m
   set cpu(s) $s
#   puts "$cpu(h), $cpu(m), $cpu(s)"
}

#ff_text2html $setup_tcl $vars(html_dir)/setup.tcl.html

foreach tool "edi ets lp rcp eps" {
   if {[file exists ${tool}_config.tcl]} {
      ff_text2html ${tool}_config.tcl $vars(html_dir)/${tool}_config.tcl.html
   }
}

ff_gen_css_header $fhw 12

puts $fhw "<BR>"
puts $fhw "<IMG SRC=logo.gif>"
puts $fhw "<BR>"
puts $fhw "<BR>"
puts $fhw "<BR>"
puts $fhw "<BR>"
#puts $fhw "<P>"
puts $fhw "<TABLE WIDTH=600 BORDER=4 CELLSPACING=2 CELLPADDING=2 ALIGN=CENTER>"
puts $fhw "   <TR>"
puts $fhw "       <TH COLSPAN=3 WIDTH=600 HEIGHT=40 ALIGN=CENTER>"
puts $fhw "           <IMG HEIGHT=60 SRC=header.png>"
puts $fhw "      </TH>"
puts $fhw "   </TR>"
puts $fhw "</TABLE>"
#puts $fhw "</P>"
puts $fhw "<BR>"
puts $fhw "<BR>"
puts $fhw "<TABLE WIDTH=600 BORDER=2 CELLSPACING=2 CELLPADDING=2 ALIGN=CENTER>"
puts $fhw "   <TR>"
puts $fhw "       <TH COLSPAN=3 WIDTH=600 HEIGHT=40 ALIGN=CENTER>"
puts $fhw "          <IMG HEIGHT=40 SRC=summary.png>"
puts $fhw "      </TH>"
puts $fhw "   </TR>"
#puts $fhw "   <TR>"
#puts $fhw "      <TH WIDTH=100>"
#puts $fhw "         <IMG HEIGHT=30 SRC=log.gif ALT=\"Setting\">"
#puts $fhw "      </TH>"
#puts $fhw "      <TD COLSPAN=2 WIDTH=500>"
#puts $fhw "      <A HREF=\"file:[file normalize $vars(html_dir)/setup.tcl.html]\">"
#puts $fhw "           Setup File "
#puts $fhw "      </A>"
#puts $fhw "      </TD>"
#puts $fhw "   </TR>"
#foreach tool "edi ets lp rcp eps" {
#   if {[file exists $vars(html_dir)/${tool}_config.tcl.html]} {
#      puts $fhw "   <TR>"
#      puts $fhw "      <TH WIDTH=100>"
#      puts $fhw "         <IMG HEIGHT=30 SRC=log.gif ALT=\"Setting\">"
#      puts $fhw "      </TH>"
#      puts $fhw "      <TD COLSPAN=2 WIDTH=500>"
#      puts $fhw "      <A HREF=\"file:[file normalize $vars(html_dir)/${tool}_config.tcl.html]\">"
#      puts $fhw "           [string toupper $tool] Config File"
#      puts $fhw "      </A>"
#      puts $fhw "      </TD>"
#      puts $fhw "   </TR>"
#   }
#}
set drcs "?"
set wl "?"
set vias "?"
set sc "?"
set scp "?"
set mc "?"
set mcp "?"

set fh [open ff_summary.txt w]
puts $fh [format "%20s %10s %10s %10s %10s %10s %10s %10s %10s %10s %10s %10s" \
                  STEP WR2R WALL TR2R TALL VR2R VALL UTIL POWER DRC WL VIAS\
         ]
puts $fh [string repeat "-" 143]
foreach step $step_list {
   if {[info exists wns($step,all)]} {
      set pwall $wns($step,all)
   } else {
      if {![info exists pwall]} {
         set pwall "?"
      }
   }
   set pstats($step,pwall) [string trim $pwall]
   if {[info exists wns($step,reg2reg)]} {
      set pwr2r $wns($step,reg2reg)
   } else {
      if {![info exists pwr2r]} {
         set pwr2r "?"
      }
   }
   set pstats($step,pwr2r) [string trim $pwr2r]
   if {[info exists wns($step,in2reg)]} {
      set pwi2r $wns($step,in2reg)
   } else {
      if {![info exists pwi2r]} {
         set pwi2r "?"
      }
   }
   set pstats($step,pwi2r) [string trim $pwi2r]
   if {[info exists wns($step,reg2out)]} {
      set pwr2o $wns($step,reg2out)
   } else {
      if {![info exists pwr2o]} {
         set pwr2o "?"
      }
   }
   set pstats($step,pwr2o) [string trim $pwr2o]

   if {[info exists tns($step,all)]} {
      set ptall $tns($step,all)
   } else {
      if {![info exists ptall]} {
         set ptall "?"
      }
   }
   set pstats($step,ptall) [string trim $ptall]
   if {[info exists tns($step,reg2reg)]} {
      set ptr2r $tns($step,reg2reg)
   } else {
      if {![info exists ptr2r]} {
         set ptr2r "?"
      }
   }
   set pstats($step,ptr2r) [string trim $ptr2r]
   if {[info exists tns($step,in2reg)]} {
      set pti2r $tns($step,in2reg)
   } else {
      if {![info exists pti2r]} {
         set pti2r "?"
      }
   }
   set pstats($step,pti2r) [string trim $pti2r]
   if {[info exists tns($step,reg2out)]} {
      set ptr2o $tns($step,reg2out)
   } else {
      if {![info exists ptr2o]} {
         set ptr2o "?"
      }
   }
   set pstats($step,ptr2o) [string trim $ptr2o]

   if {[info exists vp($step,all)]} {
      set pvall $vp($step,all)
   } else {
      if {![info exists pvall]} {
         set pvall "?"
      }
   }
   set pstats($step,pvall) [string trim $pvall]
   if {[info exists vp($step,reg2reg)]} {
      set pvr2r $vp($step,reg2reg)
   } else {
      if {![info exists pvr2r]} {
         set pvr2r "?"
      }
   }
   set pstats($step,pvr2r) [string trim $pvr2r]
   if {[info exists vp($step,in2reg)]} {
      set pvi2r $vp($step,in2reg)
   } else {
      if {![info exists pvi2r]} {
         set pvi2r "?"
      }
   }
   set pstats($step,pvi2r) [string trim $pvi2r]
   if {[info exists vp($step,reg2out)]} {
      set pvr2o $vp($step,reg2out)
   } else {
      if {![info exists pvr2o]} {
         set pvr2o "?"
      }
   }
   set pstats($step,pvr2o) [string trim $pvr2o]

   if {[info exists density($step)]} {
      set putil $density($step)
      regsub "%" $density($step) "" util
      set putil [format %3.2f $util] 
   } else {
      if {![info exists putil]} {
         set putil "?"
      }
   }
   set pstats($step,putil) [string trim $putil]
   if {[info exists power($step)]} {
      set ppower $power($step)
   } else {
      if {![info exists ppower]} {
         set ppower "?"
      }
   }
   set pstats($step,ppower) [string trim $ppower]

   if {[info exists stats($step)]} {
      set drcs [lindex $stats($step) 0]
      set wl [lindex $stats($step) 1]
      set vias [lindex $stats($step) 2]
      set sc [lindex $stats($step) 3]
      set scp [lindex $stats($step) 4]
      set mc [lindex $stats($step) 5]
      set mcp [lindex $stats($step) 6]
   } else {
      if {[info exists pstep]} {
         if {[info exists stats($pstep)]} {
            set drcs [lindex $stats($pstep) 0]
            set wl [lindex $stats($pstep) 1]
            set vias [lindex $stats($pstep) 2]
            set sc [lindex $stats($pstep) 3]
            set scp [lindex $stats($pstep) 4]
            set mc [lindex $stats($pstep) 5]
            set mcp [lindex $stats($pstep) 6]
         }
      }
   }
   set pstats($step,drcs) [string trim $drcs]
   set pstats($step,wl) [string trim $wl]
   set pstats($step,vias) [string trim $vias]
   set pstats($step,sc) [string trim $sc]
   set pstats($step,scp) [string trim $scp]
   set pstats($step,mc) [string trim $mc]
   set pstats($step,mcp) [string trim $mcp]
   puts $fh [format "%20s %10s %10s %10s %10s %10s %10s %10s %10s %10s %10s %10s" \
                     $step $pwr2r $pwall $ptr2r $ptall $pvr2r $pvall $putil $ppower $drcs $wl $vias \
            ]
   set pstep $step
}
close $fh
if {[info exists pwr2r]} {
   puts $fhw "   <TR>"
   puts $fhw "      <TH WIDTH=100>"
   puts $fhw "         <IMG HEIGHT=30 SRC=speed.gif ALT=\"Setting\">"
   puts $fhw "      </TH>"
   puts $fhw "      <TD WIDTH=\"300\">"
   puts $fhw "           WNS (ALL/R2R)"
   puts $fhw "      </TD>"
   puts $fhw "      <TD WIDTH=200>"
   puts $fhw "           $pwall / $pwr2r"
   puts $fhw "      </TD>"
   puts $fhw "   </TR>"
}
if {[info exists ptr2r]} {
   puts $fhw "   <TR>"
   puts $fhw "      <TH WIDTH=100>"
   puts $fhw "         <IMG HEIGHT=30 SRC=speed.gif ALT=\"Setting\">"
   puts $fhw "      </TH>"
   puts $fhw "      <TD WIDTH=\"300\">"
   puts $fhw "           TNS (ALL/R2R)"
   puts $fhw "      </TD>"
   puts $fhw "      <TD WIDTH=200>"
   puts $fhw "           $ptall / $ptr2r"
   puts $fhw "      </TD>"
   puts $fhw "   </TR>"
}
if {[info exists pvr2r]} {
   puts $fhw "   <TR>"
   puts $fhw "      <TH WIDTH=100>"
   puts $fhw "         <IMG HEIGHT=30 SRC=viol.gif ALT=\"Setting\">"
   puts $fhw "      </TH>"
   puts $fhw "      <TD WIDTH=\"300\">"
   puts $fhw "           VIOLATING PATHS (ALL/R2R)"
   puts $fhw "      </TD>"
   puts $fhw "      <TD WIDTH=200>"
   puts $fhw "           $pvall / $pvr2r"
   puts $fhw "      </TD>"
   puts $fhw "   </TR>"
}
if {[info exists ppower]} {
   puts $fhw "   <TR>"
   puts $fhw "      <TH WIDTH=100>"
   puts $fhw "         <IMG HEIGHT=30 SRC=power.gif ALT=\"Setting\">"
   puts $fhw "      </TH>"
   puts $fhw "      <TD WIDTH=\"300\">"
   puts $fhw "           Total Power"
   puts $fhw "      </TD>"
   puts $fhw "      <TD WIDTH=200>"
   puts $fhw "           $ppower"
   puts $fhw "      </TD>"
   puts $fhw "   </TR>"
}
if {[info exists putil]} {
   puts $fhw "   <TR>"
   puts $fhw "      <TH WIDTH=100>"
   puts $fhw "         <IMG HEIGHT=30 SRC=calc.gif ALT=\"Setting\">"
   puts $fhw "      </TH>"
   puts $fhw "      <TD WIDTH=\"300\">"
   puts $fhw "           Utilization"
   puts $fhw "      </TD>"
   puts $fhw "      <TD WIDTH=200>"
   puts $fhw "           $putil"
   puts $fhw "      </TD>"
   puts $fhw "   </TR>"
}
if {[info exists drcs]} {
   puts $fhw "   <TR>"
   puts $fhw "      <TH WIDTH=100>"
   puts $fhw "         <IMG HEIGHT=30 SRC=calc.gif ALT=\"Setting\">"
   puts $fhw "      </TH>"
   puts $fhw "      <TD WIDTH=\"300\">"
   puts $fhw "           Total DRCs"
   puts $fhw "      </TD>"
   puts $fhw "      <TD WIDTH=200>"
   puts $fhw "           $drcs"
   puts $fhw "      </TD>"
   puts $fhw "   </TR>"
}
if {[info exists wl]} {
   puts $fhw "   <TR>"
   puts $fhw "      <TH WIDTH=100>"
   puts $fhw "         <IMG HEIGHT=30 SRC=calc.gif ALT=\"Setting\">"
   puts $fhw "      </TH>"
   puts $fhw "      <TD WIDTH=\"300\">"
   puts $fhw "           Total Wirelength"
   puts $fhw "      </TD>"
   puts $fhw "      <TD WIDTH=200>"
   puts $fhw "           $wl"
   puts $fhw "      </TD>"
   puts $fhw "   </TR>"
}
if {[info exists vias]} {
   puts $fhw "   <TR>"
   puts $fhw "      <TH WIDTH=100>"
   puts $fhw "         <IMG HEIGHT=30 SRC=calc.gif ALT=\"Setting\">"
   puts $fhw "      </TH>"
   puts $fhw "      <TD WIDTH=\"300\">"
   puts $fhw "           Total Vias"
   puts $fhw "      </TD>"
   puts $fhw "      <TD WIDTH=200>"
   puts $fhw "           $vias"
   puts $fhw "      </TD>"
   puts $fhw "   </TR>"
}
if {[info exists sc]} {
   puts $fhw "   <TR>"
   puts $fhw "      <TH WIDTH=100>"
   puts $fhw "         <IMG HEIGHT=30 SRC=calc.gif ALT=\"Setting\">"
   puts $fhw "      </TH>"
   puts $fhw "      <TD WIDTH=\"300\">"
   puts $fhw "           Via Coverage (S/M)"
   puts $fhw "      </TD>"
   puts $fhw "      <TD WIDTH=200>"
   puts $fhw "           $scp / $mcp"
   puts $fhw "      </TD>"
   puts $fhw "   </TR>"
}
puts $fhw "   <TR>"
puts $fhw "      <TH WIDTH=100>"
puts $fhw "         <IMG HEIGHT=30 SRC=time.gif ALT=\"Runtime\">"
puts $fhw "      </TH>"
puts $fhw "      <TD WIDTH=\"300\">"
puts $fhw "           Total Runtime"
puts $fhw "      </TD>"
puts $fhw "      <TD WIDTH=200>"
puts $fhw "         [format "%d:%d:%d:%d" $cpu(d) $cpu(h) $cpu(m) $cpu(s)]"
puts $fhw "      </TD>"
puts $fhw "   </TR>"
puts $fhw "</TABLE>"
puts $fhw "<BR>"
puts $fhw "<BR>"
puts $fhw "<P CLASS=BREAK>"
puts $fhw "</P>"

set pstep init
foreach step $step_list {
   if {[info exists log($step)]} {
      ff_gen_html_summary $step $pstep
   }
   set pstep $step
}

puts $fhw "<TABLE WIDTH=1300 BORDER=2 CELLSPACING=2 CELLPADDING=2 ALIGN=CENTER>"
puts $fhw "   <TR>"
puts $fhw "       <TH COLSPAN=1 WIDTH=200 HEIGHT=\"40\">"
puts $fhw "         <IMG HEIGHT=30 SRC=step.png ALT=\"Step\">"
puts $fhw "      </TH>"
puts $fhw "       <TH COLSPAN=3 WIDTH=100>"
puts $fhw "         <IMG HEIGHT=30 SRC=speed.png ALT=\"Timing\">"
puts $fhw "      </TH>"
puts $fhw "       <TH COLSPAN=1 WIDTH=200>"
puts $fhw "         <IMG HEIGHT=30 SRC=power.png ALT=\"Power\">"
puts $fhw "      </TH>"
puts $fhw "       <TH COLSPAN=1 WIDTH=200>"
puts $fhw "         <IMG HEIGHT=30 SRC=density.png ALT=\"Density\">"
puts $fhw "      </TH>"
puts $fhw "       <TH COLSPAN=1 WIDTH=200>"
puts $fhw "         <IMG HEIGHT=30 SRC=log.png ALT=\"Logfile\">"
puts $fhw "      </TH>"
puts $fhw "       <TH COLSPAN=1 WIDTH=200>"
puts $fhw "         <IMG HEIGHT=30 SRC=time.png ALT=\"Runtime\">"
puts $fhw "      </TH>"
puts $fhw "   </TR>"
foreach step $step_list {
   puts $fhw "<TR> "
#   puts $fhw "   <TH WIDTH=200>"
#   puts $fhw "      <H1> $step </H1>"
#   puts $fhw "   </TH>"
   puts $fhw "   <TD WIDTH=200>"
   if {[file exists $vars(html_dir)/$step.html]} {
      puts $fhw "      <A HREF=\"file:[file normalize $vars(html_dir)]/$step.html\">"
      puts $fhw "         [string toupper $step]"
      puts $fhw "      </A>"
   } else {
      puts $fhw "      <FONT COLOR=\"red\">"
      puts $fhw "         [string toupper $step]"
      puts $fhw "      </FONT>"
   }
   puts $fhw "   </TD>"
   if {$step == "init"} {
      puts $fhw "   <TH ID=S12 WIDTH=100>"
      puts $fhw "     <FONT COLOR=\"black\">"
      puts $fhw "     WNS (ALL/R2R)"
      puts $fhw "     </FONT>"
      puts $fhw "   </TH>"
#      puts $fhw "   <TH ID=S12 WIDTH=100>"
#      puts $fhw "     <FONT COLOR=\"black\">"
#      puts $fhw "     WNS R2R"
#      puts $fhw "     </FONT>"
      puts $fhw "   </TH>"
      puts $fhw "   <TH ID=S12 WIDTH=100>"
      puts $fhw "     <FONT COLOR=\"black\">"
      puts $fhw "     (TNS ALL/R2R)"
      puts $fhw "     </FONT>"
      puts $fhw "   </TH>"
#      puts $fhw "   <TH ID=S12 WIDTH=100>"
#      puts $fhw "     <FONT COLOR=\"black\">"
#      puts $fhw "     TNS R2R"
#      puts $fhw "     </FONT>"
#      puts $fhw "   </TH>"
      puts $fhw "   <TH ID=S12 WIDTH=100>"
      puts $fhw "     <FONT COLOR=\"black\">"
      puts $fhw "     PATHS (ALL/R2R)"
      puts $fhw "     </FONT>"
      puts $fhw "   </TH>"
#      puts $fhw "   <TH ID=S12 WIDTH=100>"
#      puts $fhw "     <FONT COLOR=\"black\">"
#      puts $fhw "     VPS R2R"
#      puts $fhw "     </FONT>"
#      puts $fhw "   </TH>"
   } else {
      puts $fhw "   <TD WIDTH=200>"
      if {[info exists tsr($step)]} {
         puts $fhw "      <A HREF=\"file:[file normalize $tsr($step)]\">$pstats($step,pwall)</A>"
         puts $fhw "      <A> / </A>"
         puts $fhw "      <A HREF=\"file:[file normalize $tsr($step)]\">$pstats($step,pwr2r)</A>"
      } else {
         puts $fhw "      <FONT COLOR=\"red\">"
         puts $fhw "         --"
         puts $fhw "      </FONT>"
      }
      puts $fhw "   </TD>"
#      puts $fhw "   <TD WIDTH=100>"
#      if {[info exists tsr($step)]} {
#         puts $fhw "      <A HREF=\"file:[file normalize $tsr($step)]\">"
#         puts $fhw "         $pstats($step,pwr2r)"
#         puts $fhw "      </A>"
#      } else {
#         puts $fhw "      <FONT COLOR=\"red\">"
#         puts $fhw "         --"
#         puts $fhw "      </FONT>"
#      }
#      puts $fhw "   </TD>"
      puts $fhw "   <TD WIDTH=200>"
      if {[info exists tsr($step)]} {
         puts $fhw "      <A HREF=\"file:[file normalize $tsr($step)]\">$pstats($step,ptall)</A>"
         puts $fhw "      <A> / </A>"
         puts $fhw "      <A HREF=\"file:[file normalize $tsr($step)]\">$pstats($step,ptr2r)</A>"
      } else {
         puts $fhw "      <FONT COLOR=\"red\">"
         puts $fhw "         --"
         puts $fhw "      </FONT>"
      }
      puts $fhw "   </TD>"
#      puts $fhw "   <TD WIDTH=100>"
#      if {[info exists tsr($step)]} {
#         puts $fhw "      <A HREF=\"file:[file normalize $tsr($step)]\">"
#         puts $fhw "         $pstats($step,ptr2r)"
#         puts $fhw "      </A>"
#      } else {
#         puts $fhw "      <FONT COLOR=\"red\">"
#         puts $fhw "         --"
#         puts $fhw "      </FONT>"
#      }
#      puts $fhw "   </TD>"
      puts $fhw "   <TD WIDTH=200>"
      if {[info exists tsr($step)]} {
         puts $fhw "      <A HREF=\"file:[file normalize $tsr($step)]\">$pstats($step,pvall)</A>"
         puts $fhw "      <A> / </A>"
         puts $fhw "      <A HREF=\"file:[file normalize $tsr($step)]\">$pstats($step,pvr2r)</A>"
      } else {
         puts $fhw "      <FONT COLOR=\"red\">"
         puts $fhw "         --"
         puts $fhw "      </FONT>"
      }
      puts $fhw "   </TD>"
#      puts $fhw "   <TD WIDTH=100>"
#      if {[info exists tsr($step)]} {
#         puts $fhw "      <A HREF=\"file:[file normalize $tsr($step)]\">"
#         puts $fhw "         $pstats($step,pvr2r)"
#         puts $fhw "      </A>"
#      } else {
#         puts $fhw "      <FONT COLOR=\"red\">"
#         puts $fhw "         --"
#         puts $fhw "      </FONT>"
#      }
#      puts $fhw "   </TD>"
   }
   puts $fhw "   <TD WIDTH=100>"
   if {[info exists pwr($step)]} {
      puts $fhw "      <A HREF=\"file:[file normalize $pwr($step)]\">"
      puts $fhw "         [format %3.2f $pstats($step,ppower)]"
      puts $fhw "      </A>"
   } else {
      puts $fhw "      <FONT COLOR=\"red\">"
      puts $fhw "         --"
      puts $fhw "      </FONT>"
   }
   puts $fhw "   </TD>"
   puts $fhw "   <TD WIDTH=100>"
      if {[info exists log($step)]} {
         if {[info exists pstats($step,putil)]} {
         if { $pstats($step,putil) == "?"} {
            puts $fhw "      <FONT COLOR=\"red\">"
            puts $fhw "         --"
            puts $fhw "      </FONT>"
         } else {
            regsub "%" $pstats($step,putil) "" util
            set putil [format %3.2f $util] 
            puts $fhw "   ${putil}%"
         }
      }
   } else {
      puts $fhw "      <FONT COLOR=\"red\">"
      puts $fhw "         --"
      puts $fhw "      </FONT>"
   }
   puts $fhw "   </TD>"
   puts $fhw "   <TD WIDTH=200>"
   if {[info exists log($step)]} {
      puts $fhw "      <A HREF=\"file:[file normalize $log($step)]#$step\">"
      puts $fhw "         [file tail $log($step)]"
      puts $fhw "      </A>"
   } else {
      puts $fhw "      <FONT COLOR=\"red\">"
      puts $fhw "         $step"
      puts $fhw "      </FONT>"
   }
   puts $fhw "   </TD>"
   puts $fhw "   <TD WIDTH=100>"
   if {[info exists cpu($step)]} {
      puts $fhw "         $cpu($step)"
   } else {
      puts $fhw "      <FONT COLOR=\"red\">"
      puts $fhw "         ??:??:??"
      puts $fhw "      </FONT>"
   }
   puts $fhw "   </TD>"
   puts $fhw "</TR>"
}
puts $fhw "</TABLE>"
close $fhw

puts "<FF> HTML generation complete" 
puts "<FF> Generated design summary (ff_summary.txt)"

#puts "$setup_error"
