# Cadence Genus(TM) Synthesis Solution, Version 23.10-p004_1, built Feb  1 2024 13:43:46

# Date: Sat Jan 25 14:36:59 2025
# Host: tinkercliffs1 (x86_64 w/Linux 5.14.0-362.8.1.el9_3.x86_64) (64cores*128cpus*2physical cpus*AMD EPYC 7702 64-Core Processor 512KB)
# OS:   Rocky Linux release 9.5 (Blue Onyx)

source ../scripts/run.tcl
echo $TSMC_PDK_HOME/
echo $TSMC_PDK_HOME
ls ${TSMC_PDK_HOME}/../stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_lvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_base_lvt_c30_ssg_cworstt_max_0p81v_125c.lib
ls -al ${TSMC_PDK_HOME}/../stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_lvt_c30/r0p0/lib/sc9mcpp140z_cln28ht_base_lvt_c30_ssg_cworstt_max_0p81v_125c.lib
ls -al ${TSMC_PDK_HOME}/../stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_lvt_c30/r0p0/lib/
source ../scripts/run.tcl
nano ../scripts/run.tcl
read_physical -lefs { \
          ${TSMC_PDK_HOME}/../stdcells/arm/tsmc/cln28ht/arm_tech/r1p0/lef/1p9m_6x2z_utalrdl/sc9mcpp140z_tech.lef \
          ${TSMC_PDK_HOME}/../stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_lvt_c30/r0p0/lef/sc9mcpp140z_cln28ht_base_lvt_c30.lef \
          ${TSMC_PDK_HOME}/../stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_lvt_c30/r0p0/lef/sc9mcpp140z_cln28ht_hpk_lvt_c30.lef
          ${TSMC_PDK_HOME}/../stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_svt_c30/r0p0/lef/sc9mcpp140z_cln28ht_base_svt_c30.lef \
          ${TSMC_PDK_HOME}/../stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_svt_c30/r0p0/lef/sc9mcpp140z_cln28ht_hpk_svt_c30.lef
          ${TSMC_PDK_HOME}/../stdcells/arm/tsmc/cln28ht/sc9mcpp140z_base_ulvt_c30/r0p0/lef/sc9mcpp140z_cln28ht_base_ulvt_c30.lef \
          ${TSMC_PDK_HOME}/../stdcells/arm/tsmc/cln28ht/sc9mcpp140z_hpk_ulvt_c30/r0p0/lef/sc9mcpp140z_cln28ht_hpk_ulvt_c30.lef
        }
nano ../scripts/run.tcl
nano ../scripts/mmmc.tcl
source ../scripts/run.tcl
nano ../scripts/run.tcl
source ../scripts/run.tcl
exit
