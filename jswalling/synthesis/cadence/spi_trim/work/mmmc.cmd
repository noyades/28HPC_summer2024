# Cadence Genus(TM) Synthesis Solution, Version 21.11-s126_1, built Dec 20 2021 12:52:46

# Date: Tue May 07 12:34:17 2024
# Host: cluster12 (x86_64 w/Linux 3.10.0-1160.102.1.el7.x86_64) (6cores*24cpus*2physical cpus*Intel(R) Xeon(R) CPU E5-2620 0 @ 2.00GHz 15360KB)
# OS:   CentOS Linux release 7.9.2009 (Core)

source ../scripts/run.tcl
# entering suspend mode
resume
# resuming normal operation
check_timing_intent
set myClk clk
set useUltra 1
set virtual 0
optimize registers
define_name_rules LC_ONLY -allowed "a-z 0-9"
link
uniquify
set_load 1 [all_outputs]
set_fix_hold clk
exit
