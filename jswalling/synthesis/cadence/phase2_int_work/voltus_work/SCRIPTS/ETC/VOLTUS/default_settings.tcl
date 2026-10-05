###############################################################################
#                       CADENCE COPYRIGHT NOTICE
#         � 2008-2013 Cadence Design Systems, Inc. All rights reserved.
#------------------------------------------------------------------------------
#
# This Foundation Flow is provided as an example of how to perform specialized
# tasks within Voltus IC Power Integrity Solution.
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
# This script sets the default options for EPS Foundation Flow.
# However user set variables through eps_config.tcl has hieghest proprity
################################################################################
global vars

################################################################################
# Supported flows -> default or mmmc
################################################################################
set vars(flow)       "default"

################################################################################
# Settings for Static Power Analysis
################################################################################
if {![info exists vars(static_power,method)]} {
   set vars(static_power,method) "static"
}

################################################################################
# EPS Common Settings
################################################################################
if {![info exists vars(threshold_percent)]} {
   set vars(threshold_percent) "5.00"
}
if {![info exists vars(supply_tolerance_percent)]} {
   set vars(supply_tolerance_percent) "30.00"
}

################################################################################
# Settings for Static Rail Analysis
################################################################################
if {![info exists vars(static_rail,accuracy)]} {
   set vars(static_rail,accuracy) "hd"
}
if {![info exists vars(static_rail,analyze_type)]} {
   set vars(static_rail,analyze_type) "domain"
}

################################################################################
#      Settings for Dynamic Power Analysis
################################################################################
if {![info exists vars(dynamic_power,method)]} {
   set vars(dynamic_power,method) "dynamic_vectorless"
}

################################################################################
# Settings for Dynamic Rail Analysis
################################################################################
if {![info exists vars(dynamic_rail,accuracy)]} {
   set vars(dynamic_rail,accuracy) "hd"
}
if {![info exists vars(dynamic_rail,analyze_type)]} {
   set vars(dynamic_rail,analyze_type) "domain"
}

################################################################################
#                Settings for EPS tool Control
################################################################################
if {![info exists vars(distribute)]} {
   set vars(distribute)   "local"
}
if {![info exists vars(local_cpus)]} {
   set vars(local_cpus)   2
}
