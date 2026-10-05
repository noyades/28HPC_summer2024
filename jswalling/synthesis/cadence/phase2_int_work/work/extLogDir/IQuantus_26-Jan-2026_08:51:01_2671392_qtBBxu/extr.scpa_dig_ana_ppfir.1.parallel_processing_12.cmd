#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Mon Jan 26 09:11:35 2026                
#                                                     
#######################################################

#@(#)CDS: Innovus v23.14-s088_1 (64bit) 02/28/2025 12:25 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: NanoRoute 23.14-s088_1 NR250219-0822/23_14-UB (database version 18.20.661) {superthreading v2.20}
#@(#)CDS: AAE 23.14-s018 (64bit) 02/28/2025 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: CTE 23.14-s036_1 () Feb 22 2025 01:17:26 ( )
#@(#)CDS: SYNTECH 23.14-s010_1 () Feb 19 2025 23:56:49 ( )
#@(#)CDS: CPE v23.14-s082
#@(#)CDS: IQuantus/TQuantus 23.1.1-s336 (64bit) Mon Jan 20 22:11:00 PST 2025 (Linux 3.10.0-693.el7.x86_64)

#@ source /data/projects/28HPC_summer2024/jswalling/synthesis/cadence/phase2_int_work/work/.2671392_aff55483-ef8f-42b7-8b76-2a38dee451cb_soce_slave_12
#@ Begin verbose source (pre): source /data/projects/28HPC_summer2024/jswalling/synthesis/cadence/phase2_int_work/work/.2671392_aff55483-ef8f-42b7-8b76-2a38dee451cb_soce_slave_12
eval_legacy {unlogCommand eval_legacy}
eval_legacy {
catch {set ::env(ADS_LICENSE_FILE) "27003@license.ece.vt.edu"}
catch {set ::env(AGILEESOFD_LICENSE_FILE) "27003@license.ece.vt.edu"}
catch {set ::env(ALTAIR_HOME) "/var/RFIC/cadtools/altair"}
catch {set ::env(ALTAIR_LICENSE_PATH) "6200@beam-lvm.beam.vt.edu"}
catch {set ::env(AMBIT_BDF_PATH) "/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/etc/innovus/syntechEtc/bdfc:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/etc/innovus/cteng/bdfc"}
catch {set ::env(AMS) "/var/RFIC/cadtools/cppsim/AMSD/Design"}
catch {set ::env(AMSHOME) "/var/RFIC/cadtools/cadence/xcelium/release"}
catch {set ::env(ASSURAHOME) "/var/RFIC/cadtools/cadence/assura/ASSURA41"}
catch {set ::env(BLT_LIBRARY) "/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/share/tcltools/icd8.6.4/lib/blt2.4"}
catch {set ::env(CALIBRE_HOME) "/var/RFIC/cadtools/cadence/../mentor/release"}
catch {set ::env(CC) "/var/RFIC/cadtools/cadence/../synopsys/customcompiler/U-2023.03-5"}
catch {set ::env(CDN_SYNTH_ROOT) "/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86"}
catch {set ::env(CDS) "/var/RFIC/cadtools/cadence/cadence/IC_23.10.140_lnx86"}
catch {set ::env(CDSHOME) "/var/RFIC/cadtools/cadence/cadence/IC_23.10.140_lnx86"}
catch {set ::env(CDS_AUTO_64BIT) "EXCLUDE:si:PIPO:ultrasim"}
catch {set ::env(CDS_BIND_TMP_DD) "both"}
catch {set ::env(CDS_DEFAULT_BROWSER) "firefox"}
catch {set ::env(CDS_INST_DIR) "/var/RFIC/cadtools/cadence/cadence/IC_23.10.140_lnx86"}
catch {set ::env(CDS_LANG) "en_US.UTF-8"}
catch {set ::env(CDS_LIC_FILE) "27002@license.ece.vt.edu"}
catch {set ::env(CDS_LIC_TIMEOUT) "30"}
catch {set ::env(CDS_LOAD_ENV) "CSF"}
catch {set ::env(CDS_LOG_PATH) "."}
catch {set ::env(CDS_Netlisting_Mode) "Analog"}
catch {set ::env(CDS_ROOT_DIR) "/var/RFIC/cadtools/cadence/cadence/IC_23.10.140_lnx86"}
catch {set ::env(CDS_SET_LOCALE) "C"}
catch {set ::env(CDS_SKIP_OS_CHECK_ON_STARTUP) "1"}
catch {set ::env(CDS_W3264_LIBPATH) "/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/TPtools/libstdc++6/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/share/oa/lib/lnx86/opt:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/tcltools/icd8.6.4/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/innovus/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/Qt/v5//64bit/lib:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/pvs/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/mesalib/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/inca/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/mdl/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/mkl/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/tcltk-8.6.8/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/fmc/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/vxe/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/tensorflow/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/mlpack/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/liberate/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/TPtools/boost/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/TPtools/tbb/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/TPtools/libevent/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/TPtools/yaml-cpp/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/leveldb/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/zmq/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/extraction/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/capnproto-0.8.0/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/nng/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/python/64bit/lib:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/mmsim/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/torchscatter/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/torchsparse/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/libtorch/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/cdsgcc/gcc/9.3/install/lib64:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/IntegrityPlanner/jre/lib/server:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/imagemagick/lib:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/imagemagick/lib/ImageMagick-6.6.1/modules-Q16/coders:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/lib:/lib64:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/lib/64bit/RHEL/RHEL9"}
catch {set ::env(CI) "/var/RFIC/cadtools/cadence/../synopsys/custominfrastructure/U-2023.03"}
catch {set ::env(CLS_CDSD_COMPATIBILITY_LOCKING) "NO"}
catch {set ::env(COLORTERM) "truecolor"}
catch {set ::env(CONDA_DEFAULT_ENV) "base"}
catch {set ::env(CONDA_EXE) "/var/RFIC/conda/miniconda3/bin/conda"}
catch {set ::env(CONDA_PREFIX) "/var/RFIC/conda/miniconda3"}
catch {set ::env(CONDA_PYTHON_EXE) "/var/RFIC/conda/miniconda3/bin/python"}
catch {set ::env(CONDA_SHLVL) "1"}
catch {set ::env(CPPSIMHOME) "/data/projects/28HPC_Apr2025_Muse/CppSim"}
catch {set ::env(CPPSIMSHAREDHOME) "/var/RFIC/cadtools/cppsim/CppSim_Dist/CppSimShared"}
catch {set ::env(DBUS_SESSION_BUS_ADDRESS) "unix:path=/run/user/8413330/bus"}
catch {set ::env(DC) "/var/RFIC/cadtools/cadence/../synopsys/syn/T-2022.03-SP5-2"}
catch {set ::env(DDI) "/var/RFIC/cadtools/cadence/ddi/release"}
catch {set ::env(DEBUGINFOD_IMA_CERT_PATH) "/etc/keys/ima:"}
catch {set ::env(DESKTOP_SESSION) "gnome"}
catch {set ::env(DISPLAY) ":1"}
catch {set ::env(EDITOR) "/usr/bin/gedit"}
catch {set ::env(EMX) "/var/RFIC/cadtools/cadence/integrand/.current"}
catch {set ::env(ENCOUNTER) "/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/innovus"}
catch {set ::env(EXT) "/var/RFIC/cadtools/cadence/quantus/release"}
catch {set ::env(FEKO_HOME) "/var/RFIC/cadtools/altair/feko"}
catch {set ::env(GDMSESSION) "gnome"}
catch {set ::env(GENUS) "/var/RFIC/cadtools/cadence/ddi/release/GENUS231"}
catch {set ::env(GNOME_TERMINAL_SCREEN) "/org/gnome/Terminal/screen/c564fa04_ec09_47b6_8e1f_1a405f2ef1a9"}
catch {set ::env(GNOME_TERMINAL_SERVICE) ":1.81"}
catch {set ::env(GOLDENGATE_LICENSE_FILE) "27003@license.ece.vt.edu"}
catch {set ::env(HISTCONTROL) "ignoredups"}
catch {set ::env(HISTSIZE) "1000"}
catch {set ::env(HOME) "/home/jswalling"}
catch {set ::env(HPEESOF_DIR) "/var/RFIC/cadtools/cadence/../ads/ADS2025_Update1"}
catch {set ::env(IC) "/var/RFIC/cadtools/cadence/cadence/IC_23.10.140_lnx86"}
catch {set ::env(ICC) "/var/RFIC/cadtools/cadence/../synopsys/icc/U-2022.12-SP5"}
catch {set ::env(ICC2) "/var/RFIC/cadtools/cadence/../synopsys/icc2/T-2022.03-SP5"}
catch {set ::env(INNOVUS) "/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/innovus"}
catch {set ::env(IUS) ""}
catch {set ::env(JAVA_HOME) "/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/IntegrityPlanner/jre"}
catch {set ::env(LANG) "C"}
catch {set ::env(LC_ALL) "C"}
catch {set ::env(LD_LIBRARY_PATH) "/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/TPtools/libstdc++6/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/share/oa/lib/lnx86/opt:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/tcltools/icd8.6.4/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/innovus/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/Qt/v5//64bit/lib:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/pvs/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/mesalib/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/inca/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/mdl/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/mkl/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/tcltk-8.6.8/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/fmc/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/vxe/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/tensorflow/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/mlpack/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/liberate/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/TPtools/boost/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/TPtools/tbb/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/TPtools/libevent/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/TPtools/yaml-cpp/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/leveldb/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/zmq/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/extraction/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/capnproto-0.8.0/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/nng/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/python/64bit/lib:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/mmsim/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/torchscatter/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/torchsparse/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/libtorch/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/cdsgcc/gcc/9.3/install/lib64:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/IntegrityPlanner/jre/lib/server:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/imagemagick/lib:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/imagemagick/lib/ImageMagick-6.6.1/modules-Q16/coders:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/lib/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/lib:/lib64:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/lib/64bit/RHEL/RHEL9"}
catch {set ::env(LM_LICENSE_FILE) "27002@license.ece.vt.edu"}
catch {set ::env(LOGNAME) "jswalling"}
catch {set ::env(MAGICK_CODER_MODULE_PATH) "/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/imagemagick/lib/ImageMagick-6.6.1/modules-Q16/coders"}
catch {set ::env(MAIL) "/var/spool/mail/jswalling"}
catch {set ::env(MANPATH) "/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/share/innovus/stylus/man:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/share/tcltools/man:/var/RFIC/cadtools/cadence/cadence/IC_23.10.140_lnx86/tools/man:/var/RFIC/cadtools/cadence/cadence/IC_23.10.140_lnx86/share/man:/var/RFIC/cadtools/cadence/cadence/IC_23.10.140_lnx86/tools/man:/var/RFIC/cadtools/cadence/cadence/IC_23.10.140_lnx86/share/man"}
catch {set ::env(MATLAB_SHELL) "/bin/sh"}
catch {set ::env(MGC_HOME) "/var/RFIC/cadtools/cadence/../mentor/release"}
catch {set ::env(MGLS_LICENSE_FILE) "27005@license.ece.vt.edu"}
catch {set ::env(MentorInstall) "/var/RFIC/cadtools/cadence/../mentor"}
catch {set ::env(NCVLOG_ROOT_DIR) "/var/RFIC/cadtools/cadence/incisive/INCISIVE152"}
catch {set ::env(OLDPWD) "/data/projects/28HPC_summer2024/jswalling/synthesis/cadence/phase2_int_work"}
catch {set ::env(ORBIT_HOME) "/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/IntegrityPlanner"}
catch {set ::env(PATH) "/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/bin:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/bin/64bit:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/bin:/var/RFIC/cadtools/cadence/../ads/GoldenGate-2024/bin:/var/RFIC/cadtools/cadence/../ads/ADS2025_Update1/bin:/var/RFIC/cadtools/altair/feko/bin:/var/RFIC/cadtools/cadence/../synopsys/customcompiler/U-2023.03-5/bin:/var/RFIC/cadtools/cadence/../synopsys/primesim/U-2023.03/bin:/var/RFIC/cadtools/cadence/../synopsys/primewavereliability/U-2023.03/bin:/var/RFIC/cadtools/cadence/../synopsys/primewave/U-2023.03/bin:/var/RFIC/cadtools/cadence/../synopsys/custominfrastructure/U-2023.03/bin:/var/RFIC/cadtools/cadence/../synopsys/icc/U-2022.12-SP5/bin:/var/RFIC/cadtools/cadence/../synopsys/prime/T-2022.03-SP5/bin:/var/RFIC/cadtools/cadence/../synopsys/syn/T-2022.03-SP5-2/bin:/var/RFIC/cadtools/cadence/../synopsys/icc2/T-2022.03-SP5/bin:/var/RFIC/cadtools/cadence/quantus/release/tools/bin:/var/RFIC/cadtools/cadence/quantus/release/tools/dfII/bin:/var/RFIC/cadtools/cadence/ddi/release/GENUS231/tools.lnx86/bin:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/dfII/bin:/var/RFIC/cadtools/cadence/pegasus/release/tools/bin:/var/RFIC/cadtools/cadence/pegasus/release/toos/dfII/bin:/var/RFIC/cadtools/cadence/assura/ASSURA41/tools/assura/bin:/var/RFIC/cadtools/cadence/assura/ASSURA41/tools/bin:/var/RFIC/cadtools/cadence/../ads/ADS2025_Update1/bin:/var/RFIC/cadtools/cadence/../mentor/release/bin:/var/RFIC/cadtools/cadence/ssv/SSV_22.10.000_lnx86/tools/bin:/var/RFIC/cadtools/cadence/ssv/SSV_22.10.000_lnx86/tools/dfII/bin:/var/RFIC/cadtools/cadence/xcelium/release/tools/bin/64bit:/var/RFIC/cadtools/cadence/xcelium/release/tools/dfII/bin/64bit:/var/RFIC/cadtools/cadence/spectre/SPECTRE_23.10.063_lnx86/tools/bin:/var/RFIC/cadtools/cadence/spectre/SPECTRE_23.10.063_lnx86/tools/dfII/bin:/var/RFIC/cadtools/cadence/cadence/IC_23.10.140_lnx86/tools/bin:/var/RFIC/cadtools/cadence/cadence/IC_23.10.140_lnx86/tools/dfII/bin:/var/RFIC/cadtools/cadence/integrand/.current/bin:/var/RFIC/cadtools/cadence/../ads/GoldenGate-2024/bin:/var/RFIC/cadtools/cadence/../ads/ADS2025_Update1/bin:/var/RFIC/cadtools/altair/feko/bin:/var/RFIC/cadtools/cadence/../synopsys/customcompiler/U-2023.03-5/bin:/var/RFIC/cadtools/cadence/../synopsys/primesim/U-2023.03/bin:/var/RFIC/cadtools/cadence/../synopsys/primewavereliability/U-2023.03/bin:/var/RFIC/cadtools/cadence/../synopsys/primewave/U-2023.03/bin:/var/RFIC/cadtools/cadence/../synopsys/custominfrastructure/U-2023.03/bin:/var/RFIC/cadtools/cadence/../synopsys/icc/U-2022.12-SP5/bin:/var/RFIC/cadtools/cadence/../synopsys/prime/T-2022.03-SP5/bin:/var/RFIC/cadtools/cadence/../synopsys/syn/T-2022.03-SP5-2/bin:/var/RFIC/cadtools/cadence/../synopsys/icc2/T-2022.03-SP5/bin:/var/RFIC/cadtools/cadence/quantus/release/tools/bin:/var/RFIC/cadtools/cadence/quantus/release/tools/dfII/bin:/var/RFIC/cadtools/cadence/ddi/release/GENUS231/tools.lnx86/bin:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/dfII/bin:/var/RFIC/cadtools/cadence/pegasus/release/tools/bin:/var/RFIC/cadtools/cadence/pegasus/release/toos/dfII/bin:/var/RFIC/cadtools/cadence/assura/ASSURA41/tools/assura/bin:/var/RFIC/cadtools/cadence/assura/ASSURA41/tools/bin:/var/RFIC/cadtools/cadence/../ads/ADS2025_Update1/bin:/var/RFIC/cadtools/cadence/../mentor/release/bin:/var/RFIC/cadtools/cadence/ssv/SSV_22.10.000_lnx86/tools/bin:/var/RFIC/cadtools/cadence/ssv/SSV_22.10.000_lnx86/tools/dfII/bin:/var/RFIC/cadtools/cadence/xcelium/release/tools/bin/64bit:/var/RFIC/cadtools/cadence/xcelium/release/tools/dfII/bin/64bit:/var/RFIC/cadtools/cadence/spectre/SPECTRE_23.10.063_lnx86/tools/bin:/var/RFIC/cadtools/cadence/spectre/SPECTRE_23.10.063_lnx86/tools/dfII/bin:/var/RFIC/cadtools/cadence/cadence/IC_23.10.140_lnx86/tools/bin:/var/RFIC/cadtools/cadence/cadence/IC_23.10.140_lnx86/tools/dfII/bin:/var/RFIC/cadtools/cadence/integrand/.current/bin:/var/RFIC/conda/miniconda3/bin:/var/RFIC/conda/miniconda3/condabin:/home/jswalling/.local/bin:/home/jswalling/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/bin"}
catch {set ::env(PROD_NAME) "innovus"}
catch {set ::env(PS) "/var/RFIC/cadtools/cadence/../synopsys/primesim/U-2023.03"}
catch {set ::env(PT) "/var/RFIC/cadtools/cadence/../synopsys/prime/T-2022.03-SP5"}
catch {set ::env(PVS) "/var/RFIC/cadtools/cadence/pegasus/release"}
catch {set ::env(PW) "/var/RFIC/cadtools/cadence/../synopsys/primewave/U-2023.03"}
catch {set ::env(PWD) "/data/projects/28HPC_summer2024/jswalling/synthesis/cadence/phase2_int_work/work"}
catch {set ::env(PWR) "/var/RFIC/cadtools/cadence/../synopsys/primewavereliability/U-2023.03"}
catch {set ::env(QRC_HOME) "/var/RFIC/cadtools/cadence/quantus/release"}
catch {set ::env(QT_IM_MODULE) "ibus"}
catch {set ::env(SHELL) "/bin/bash"}
catch {set ::env(SHLVL) "1"}
catch {set ::env(SNPSLMD_LICENSE_FILE) "27000@license.ece.vt.edu"}
catch {set ::env(SPECTREHOME) "/var/RFIC/cadtools/cadence/spectre/SPECTRE_23.10.063_lnx86"}
catch {set ::env(SSH_AUTH_SOCK) "/run/user/8413330/keyring/ssh"}
catch {set ::env(SSV) "/var/RFIC/cadtools/cadence/ssv/SSV_22.10.000_lnx86"}
catch {set ::env(SYNOPSYS_FLOW_BASED_GUI) "1"}
catch {set ::env(SYSTEMD_EXEC_PID) "5949"}
catch {set ::env(SynopsysInstall) "/var/RFIC/cadtools/cadence/../synopsys"}
catch {set ::env(TCLLIBPATH) "/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/share/lib/tcllib/1.18 "}
catch {set ::env(TCLLIB_LIBRARY) "/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/share/lib/tcllib/1.18"}
catch {set ::env(TCLTK_ROOT) "/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/share/tcltools/icd8.6.4/lib"}
catch {set ::env(TCL_LIBRARY) "/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/share/tcltools/icd8.6.4/lib/tcl8.6"}
catch {set ::env(TERM) "xterm-256color"}
catch {set ::env(TIX_LIBRARY) "/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/share/tcltools/icd8.6.4/lib/Tix8.4.3/library"}
catch {set ::env(TK_LIBRARY) "/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/share/tcltools/icd8.6.4/lib/tk8.6"}
catch {set ::env(TOOL_TCL_LIBPATH) "/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/tcltools/icd8.6.4/lib/64bit"}
catch {set ::env(TSMC_PDK_HOME) "/data/PDK/tsmc/28nm/release"}
catch {set ::env(TSMC_ROOT) "/data/PDK/tsmc"}
catch {set ::env(USER) "jswalling"}
catch {set ::env(USERNAME) "jswalling"}
catch {set ::env(VTE_VERSION) "6402"}
catch {set ::env(W3264_ENV) "/home/jswalling/.kshrc"}
catch {set ::env(W3264_PS_COMPAT_LIBDIR) "/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/lib/64bit/RHEL/RHEL9"}
catch {set ::env(W3264_STORED_HOSTID) "52c60dfb"}
catch {set ::env(W3264_USER_LIBPATH) ""}
catch {set ::env(W3264_USER_PATH) "/var/RFIC/cadtools/cadence/../ads/GoldenGate-2024/bin:/var/RFIC/cadtools/cadence/../ads/ADS2025_Update1/bin:/var/RFIC/cadtools/altair/feko/bin:/var/RFIC/cadtools/cadence/../synopsys/customcompiler/U-2023.03-5/bin:/var/RFIC/cadtools/cadence/../synopsys/primesim/U-2023.03/bin:/var/RFIC/cadtools/cadence/../synopsys/primewavereliability/U-2023.03/bin:/var/RFIC/cadtools/cadence/../synopsys/primewave/U-2023.03/bin:/var/RFIC/cadtools/cadence/../synopsys/custominfrastructure/U-2023.03/bin:/var/RFIC/cadtools/cadence/../synopsys/icc/U-2022.12-SP5/bin:/var/RFIC/cadtools/cadence/../synopsys/prime/T-2022.03-SP5/bin:/var/RFIC/cadtools/cadence/../synopsys/syn/T-2022.03-SP5-2/bin:/var/RFIC/cadtools/cadence/../synopsys/icc2/T-2022.03-SP5/bin:/var/RFIC/cadtools/cadence/quantus/release/tools/bin:/var/RFIC/cadtools/cadence/quantus/release/tools/dfII/bin:/var/RFIC/cadtools/cadence/ddi/release/GENUS231/tools.lnx86/bin:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/bin:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/dfII/bin:/var/RFIC/cadtools/cadence/pegasus/release/tools/bin:/var/RFIC/cadtools/cadence/pegasus/release/toos/dfII/bin:/var/RFIC/cadtools/cadence/assura/ASSURA41/tools/assura/bin:/var/RFIC/cadtools/cadence/assura/ASSURA41/tools/bin:/var/RFIC/cadtools/cadence/../ads/ADS2025_Update1/bin:/var/RFIC/cadtools/cadence/../mentor/release/bin:/var/RFIC/cadtools/cadence/ssv/SSV_22.10.000_lnx86/tools/bin:/var/RFIC/cadtools/cadence/ssv/SSV_22.10.000_lnx86/tools/dfII/bin:/var/RFIC/cadtools/cadence/xcelium/release/tools/bin/64bit:/var/RFIC/cadtools/cadence/xcelium/release/tools/dfII/bin/64bit:/var/RFIC/cadtools/cadence/spectre/SPECTRE_23.10.063_lnx86/tools/bin:/var/RFIC/cadtools/cadence/spectre/SPECTRE_23.10.063_lnx86/tools/dfII/bin:/var/RFIC/cadtools/cadence/cadence/IC_23.10.140_lnx86/tools/bin:/var/RFIC/cadtools/cadence/cadence/IC_23.10.140_lnx86/tools/dfII/bin:/var/RFIC/cadtools/cadence/integrand/.current/bin:/var/RFIC/cadtools/cadence/../ads/GoldenGate-2024/bin:/var/RFIC/cadtools/cadence/../ads/ADS2025_Update1/bin:/var/RFIC/cadtools/altair/feko/bin:/var/RFIC/cadtools/cadence/../synopsys/customcompiler/U-2023.03-5/bin:/var/RFIC/cadtools/cadence/../synopsys/primesim/U-2023.03/bin:/var/RFIC/cadtools/cadence/../synopsys/primewavereliability/U-2023.03/bin:/var/RFIC/cadtools/cadence/../synopsys/primewave/U-2023.03/bin:/var/RFIC/cadtools/cadence/../synopsys/custominfrastructure/U-2023.03/bin:/var/RFIC/cadtools/cadence/../synopsys/icc/U-2022.12-SP5/bin:/var/RFIC/cadtools/cadence/../synopsys/prime/T-2022.03-SP5/bin:/var/RFIC/cadtools/cadence/../synopsys/syn/T-2022.03-SP5-2/bin:/var/RFIC/cadtools/cadence/../synopsys/icc2/T-2022.03-SP5/bin:/var/RFIC/cadtools/cadence/quantus/release/tools/bin:/var/RFIC/cadtools/cadence/quantus/release/tools/dfII/bin:/var/RFIC/cadtools/cadence/ddi/release/GENUS231/tools.lnx86/bin:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/bin:/var/RFIC/cadtools/cadence/ddi/release/INNOVUS231/tools.lnx86/dfII/bin:/var/RFIC/cadtools/cadence/pegasus/release/tools/bin:/var/RFIC/cadtools/cadence/pegasus/release/toos/dfII/bin:/var/RFIC/cadtools/cadence/assura/ASSURA41/tools/assura/bin:/var/RFIC/cadtools/cadence/assura/ASSURA41/tools/bin:/var/RFIC/cadtools/cadence/../ads/ADS2025_Update1/bin:/var/RFIC/cadtools/cadence/../mentor/release/bin:/var/RFIC/cadtools/cadence/ssv/SSV_22.10.000_lnx86/tools/bin:/var/RFIC/cadtools/cadence/ssv/SSV_22.10.000_lnx86/tools/dfII/bin:/var/RFIC/cadtools/cadence/xcelium/release/tools/bin/64bit:/var/RFIC/cadtools/cadence/xcelium/release/tools/dfII/bin/64bit:/var/RFIC/cadtools/cadence/spectre/SPECTRE_23.10.063_lnx86/tools/bin:/var/RFIC/cadtools/cadence/spectre/SPECTRE_23.10.063_lnx86/tools/dfII/bin:/var/RFIC/cadtools/cadence/cadence/IC_23.10.140_lnx86/tools/bin:/var/RFIC/cadtools/cadence/cadence/IC_23.10.140_lnx86/tools/dfII/bin:/var/RFIC/cadtools/cadence/integrand/.current/bin:/var/RFIC/conda/miniconda3/bin:/var/RFIC/conda/miniconda3/condabin:/home/jswalling/.local/bin:/home/jswalling/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin"}
catch {set ::env(XAUTHORITY) "/home/jswalling/.Xauthority"}
catch {set ::env(XDG_CURRENT_DESKTOP) "GNOME"}
catch {set ::env(XDG_DATA_DIRS) "/home/jswalling/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share"}
catch {set ::env(XDG_MENU_PREFIX) "gnome-"}
catch {set ::env(XDG_RUNTIME_DIR) "/run/user/8413330"}
catch {set ::env(XDG_SESSION_CLASS) "user"}
catch {set ::env(XDG_SESSION_DESKTOP) "gnome"}
catch {set ::env(XDG_SESSION_TYPE) "x11"}
catch {set ::env(XMODIFIERS) "@im=ibus"}
catch {set ::env(XPEDION) "/var/RFIC/cadtools/cadence/../ads/GoldenGate-2024"}
catch {set ::env(XPEDION_CADENCE_VERSION) "231"}
catch {set ::env(base_dir) "/var/RFIC/cadtools/cadence"}
catch {set ::env(project_dir) "/data/projects/28HPC_Apr2025_Muse"}
catch {set ::env(ps3264_osid) "ol"}
catch {set ::env(w3264_COMPAT_OSVER) "9"}
catch {set ::env(w3264_osver) "9"}
catch {set ::env(which_declare) "declare -f"}
catch {set ::env(PROCINFO_HOST) "lnx-prd-05.ece.vt.edu:42201"}
catch {set ::env(TK_TABLE_LIBRARY_FILE) "tkTable.tcl"}
catch {set ::env(TK_TABLE_LIBRARY) "EMBEDDED_RUNTIME"}
catch {set ::env(CDS_ARCH) "lnx86"}
catch {set ::env(EDP_C_CODE) "1"}
catch {set ::env(ENABLE_MMMC2_VIEW_DEFINITION_GENERATION_IN_TEMPUS_CUI) "1"}
catch {set ::env(usefulSkewCCOpt) "1"}
catch {set ::env(_enable_mmmc_by_default_flow) "1"}
catch {set ::env(set_eso_pid_uuid) "0"}
catch {set ::env(FE_MASTER_USER_ORIGINAL_TMPDIR) "/data/projects/28HPC_summer2024/jswalling/synthesis/cadence/phase2_int_work/work"}
catch {set ::env(PEGASUS_INV_START_DIR) "/data/projects/28HPC_summer2024/jswalling/synthesis/cadence/phase2_int_work/work"}
catch {set ::env(__QUANTUS_FIX_SLOW_NFS_MINIMAL__) "YES"}
catch {set ::env(TEMPDIR) "/data/projects/28HPC_summer2024/jswalling/synthesis/cadence/phase2_int_work/work/innovus_temp_2671392_907025ae-5a50-4adb-8e3a-d85ce58eac74_lnx-prd-05.ece.vt.edu_jswalling_WGxx1l/iqrc_tmp_2671392_ZTSZ9i/.qrctemp/.xrctemp_0"}
catch {set ::env(EDP_MODE) "local"}
catch {set ::env(__HPY_MODELING_SMALL_SEG__) "false"}
catch {set ::env(__QRC_DBG_DISABLE_TEST_STRUCTURE_MODE__) "true"}
catch {if {[isLimitedAccessFeatureEnabled invsEnableAI -silent] != 1} {setLimitedAccessFeature invsEnableAI 1}}
catch {if {[isLimitedAccessFeatureEnabled ccopt_native -silent] != 1} {setLimitedAccessFeature ccopt_native 1}}
catch {if {[isLimitedAccessFeatureEnabled ccopt_native_cts -silent] != 1} {setLimitedAccessFeature ccopt_native_cts 1}}
catch {if {[isLimitedAccessFeatureEnabled ccopt_flexible_htree -silent] != 1} {setLimitedAccessFeature ccopt_flexible_htree 1}}
catch {if {[isLimitedAccessFeatureEnabled ccopt_multithreading -silent] != 1} {setLimitedAccessFeature ccopt_multithreading 1}}
catch {if {[isLimitedAccessFeatureEnabled ccopt_opt_multithreading -silent] != 1} {setLimitedAccessFeature ccopt_opt_multithreading 1}}
catch {if {[isLimitedAccessFeatureEnabled cts_halo_mode_sum -silent] != 1} {setLimitedAccessFeature cts_halo_mode_sum 1}}
catch {if {[isLimitedAccessFeatureEnabled invsHierModuleModel -silent] != 1} {setLimitedAccessFeature invsHierModuleModel 1}}
catch {::edp::setNodeId aff55483-ef8f-42b7-8b76-2a38dee451cb_12/16}
startEdpSlave 12 lnx-prd-05.ece.vt.edu 36841 39379 0 10
}
