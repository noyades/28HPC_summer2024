################################################################################
#
# Init setup file
# Created by Genus(TM) Synthesis Solution on 05/10/2024 16:54:19
#
################################################################################
if { ![is_common_ui_mode] } { error "ERROR: This script requires common_ui to be active."}
::legacy::set_attribute -quiet init_mmmc_version 2 /

read_mmmc ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/genus2invs.mmmc.tcl

read_physical -lef {/software/RFIC/PDK/globalFoundries/22FDX-EXT/std_cells/v-logic_gf22nsdslogl28edl116a/DesignWare_logic_libs/globalfoundaries22nhsda/28hd/edl/svt/latest/lef/5.8/gf22nsdslogl28edl116a_9M_2Mx_5Cx_1Jx_1Ox_LB.lef /software/RFIC/PDK/globalFoundries/22FDX-EXT/std_cells/v-logic_gf22nsdslogl28edl116a/DesignWare_logic_libs/globalfoundaries22nhsda/28hd/edl/svt/latest/lef/5.8/gf22nsdslogl28edl116a.lef}

read_netlist ./OUTPUT/outputs_21.11-s126_1/invs_tmp_dir/genus2invs.v.gz

init_design -skip_sdc_read
