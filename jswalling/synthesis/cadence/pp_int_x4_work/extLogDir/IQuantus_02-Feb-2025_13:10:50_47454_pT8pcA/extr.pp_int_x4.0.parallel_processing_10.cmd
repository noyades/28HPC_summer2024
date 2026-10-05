#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Sun Feb  2 13:20:24 2025                
#                                                     
#######################################################

#@(#)CDS: Innovus v22.10-p001_1 (64bit) 09/29/2022 11:03 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: NanoRoute 22.10-p001_1 NR220915-0329/22_10-UB (database version 18.20.590) {superthreading v2.19}
#@(#)CDS: AAE 22.10-p002 (64bit) 09/29/2022 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: CTE 22.10-p004_1 () Sep  7 2022 21:57:29 ( )
#@(#)CDS: SYNTECH 22.10-p001_1 () Aug  8 2022 11:26:34 ( )
#@(#)CDS: CPE v22.10-p005
#@(#)CDS: IQuantus/TQuantus 21.2.0-s201 (64bit) Wed Jul 6 19:14:09 PDT 2022 (Linux 3.10.0-693.el7.x86_64)

#@ source /home/micsTapeouts/projects/28HPC_summer2024/jswalling/synthesis/cadence/pp_int_x4_work/.47454_soce_slave_10
#@ Begin verbose source (pre): source /home/micsTapeouts/projects/28HPC_summer2024/jswalling/synthesis/cadence/pp_int_x4_work/.47454_soce_slave_10
eval_legacy {unlogCommand eval_legacy}
eval_legacy {
catch {set ::env(ADS_LICENSE_FILE) "27003@license.ece.vt.edu"}
catch {set ::env(AGILEESOFD_LICENSE_FILE) "27003@license.ece.vt.edu"}
catch {set ::env(ALLEGRO) "/software/RFIC/cadtools/cadence/allegro/SPB_22.10.000_lnx86"}
catch {set ::env(ALTAIR_HOME) "/software/RFIC/cadtools/altair"}
catch {set ::env(ALTAIR_LICENSE_PATH) "6200@beam-lvm.beam.vt.edu"}
catch {set ::env(AMBIT_BDF_PATH) "/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/etc/innovus/syntechEtc/bdfc:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/etc/innovus/cteng/bdfc"}
catch {set ::env(ASSURAHOME) "/software/RFIC/cadtools/cadence/assura/ASSURA41"}
catch {set ::env(BLT_LIBRARY) "/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/share/tcltools/icd8.6.4/lib/blt2.4"}
catch {set ::env(CC) "/software/RFIC/cadtools/cadence/../synopsys/customcompiler/U-2023.03-5"}
catch {set ::env(CDS) "/software/RFIC/cadtools/cadence/cadence/ICADVM_20.10.000_lnx86"}
catch {set ::env(CDSHOME) "/software/RFIC/cadtools/cadence/cadence/ICADVM_20.10.000_lnx86"}
catch {set ::env(CDS_AUTO_64BIT) "EXCLUDE:si:PIPO:ultrasim"}
catch {set ::env(CDS_BIND_TMP_DD) "both"}
catch {set ::env(CDS_DEFAULT_BROWSER) "firefox"}
catch {set ::env(CDS_INST_DIR) "/software/RFIC/cadtools/cadence/cadence/ICADVM_20.10.000_lnx86"}
catch {set ::env(CDS_LANG) "C"}
catch {set ::env(CDS_LIC_FILE) "27002@license.ece.vt.edu"}
catch {set ::env(CDS_LIC_TIMEOUT) "30"}
catch {set ::env(CDS_LOAD_ENV) "CSF"}
catch {set ::env(CDS_LOG_PATH) "."}
catch {set ::env(CDS_Netlisting_Mode) "Analog"}
catch {set ::env(CDS_ROOT_DIR) "/software/RFIC/cadtools/cadence/cadence/ICADVM_20.10.000_lnx86"}
catch {set ::env(CDS_SET_LOCALE) "C"}
catch {set ::env(CDS_W3264_LIBPATH) "/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/share/oa/lib/linux_rhel60_64/opt:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/tcltools/icd8.6.4/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/innovus/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/Qt/v5//64bit/lib:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/pvs/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/mesalib/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/inca/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/mdl/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/mkl/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/tcltk-8.6.8/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/fmc/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/vxe/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/tensorflow/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/mlpack/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/liberate/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/TPtools/boost/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/TPtools/tbb/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/TPtools/libevent/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/zmq/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/capnproto-0.8.0/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/nng/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/python/64bit/lib:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/OrbitIO/jre/lib/server:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/lib:/lib64"}
catch {set ::env(CI) "/software/RFIC/cadtools/cadence/../synopsys/custominfrastructure/U-2023.03"}
catch {set ::env(CLS_CDSD_COMPATIBILITY_LOCKING) "NO"}
catch {set ::env(COLORTERM) "truecolor"}
catch {set ::env(CONDA_DEFAULT_ENV) "base"}
catch {set ::env(CONDA_EXE) "/home/jswalling/anaconda3/bin/conda"}
catch {set ::env(CONDA_PREFIX) "/home/jswalling/anaconda3"}
catch {set ::env(CONDA_PYTHON_EXE) "/home/jswalling/anaconda3/bin/python"}
catch {set ::env(CONDA_SHLVL) "1"}
catch {set ::env(DBUS_SESSION_BUS_ADDRESS) "unix:abstract=/tmp/dbus-qEor05UWsf,guid=359080dc86714e4bcbf3346c6745ef80"}
catch {set ::env(DC) "/software/RFIC/cadtools/cadence/../synopsys/syn/T-2022.03-SP5-2"}
catch {set ::env(DDI) "/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86"}
catch {set ::env(DISPLAY) "cluster15:22.0"}
catch {set ::env(EMX) "/software/RFIC/cadtools/cadence/integrand/.current"}
catch {set ::env(EMX_interface_path) "/software/RFIC/cadtools/cadence/integrand/.current/share/emx/virtuoso_ui/emxinterface"}
catch {set ::env(ENCOUNTER) "/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/innovus"}
catch {set ::env(EXT) "/software/RFIC/cadtools/cadence/quantus/QUANTUS211-ISR1_21.11.000_lnx86"}
catch {set ::env(FEKO_HOME) "/software/RFIC/cadtools/altair/feko"}
catch {set ::env(GDL_PATH) "+/usr/share/gnudatalanguage"}
catch {set ::env(GENUS) "/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/GENUS221"}
catch {set ::env(GNOME_DESKTOP_SESSION_ID) "this-is-deprecated"}
catch {set ::env(GNOME_SHELL_SESSION_MODE) "classic"}
catch {set ::env(GNOME_TERMINAL_SCREEN) "/org/gnome/Terminal/screen/f6bce60f_e16d_44ca_a9b3_aaf42a3f01c3"}
catch {set ::env(GNOME_TERMINAL_SERVICE) ":1.144"}
catch {set ::env(GOLDENGATE_LICENSE_FILE) "27003@license.ece.vt.edu"}
catch {set ::env(HISTCONTROL) "ignoredups"}
catch {set ::env(HISTSIZE) "1000"}
catch {set ::env(HOME) "/home/jswalling"}
catch {set ::env(HPEESOF_DIR) "/software/ADS/ADS2020_update2"}
catch {set ::env(IC) "/software/RFIC/cadtools/cadence/cadence/ICADVM_20.10.000_lnx86"}
catch {set ::env(ICC) "/software/RFIC/cadtools/cadence/../synopsys/icc/U-2022.12-SP5"}
catch {set ::env(ICC2) "/software/RFIC/cadtools/cadence/../synopsys/icc2/T-2022.03-SP5"}
catch {set ::env(IMSETTINGS_INTEGRATE_DESKTOP) "yes"}
catch {set ::env(IMSETTINGS_MODULE) "none"}
catch {set ::env(INNOVUS) "/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/innovus"}
catch {set ::env(IUS) "/software/RFIC/cadtools/cadence/incisive/INCISIVE152"}
catch {set ::env(JAVA_HOME) "/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/OrbitIO/jre"}
catch {set ::env(KRB5CCNAME) "KEYRING:persistent:4142"}
catch {set ::env(LANG) "C"}
catch {set ::env(LC_ALL) "C"}
catch {set ::env(LD_LIBRARY_PATH) "/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/share/oa/lib/linux_rhel60_64/opt:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/tcltools/icd8.6.4/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/innovus/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/Qt/v5//64bit/lib:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/pvs/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/mesalib/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/inca/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/mdl/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/mkl/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/tcltk-8.6.8/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/fmc/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/vxe/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/tensorflow/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/mlpack/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/liberate/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/TPtools/boost/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/TPtools/tbb/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/TPtools/libevent/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/zmq/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/capnproto-0.8.0/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/nng/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/python/64bit/lib:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/OrbitIO/jre/lib/server:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/lib/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/lib:/lib64"}
catch {set ::env(LM_LICENSE_FILE) "27002@license.ece.vt.edu"}
catch {set ::env(LOADEDMODULES) ""}
catch {set ::env(LOGNAME) "jswalling"}
catch {set ::env(MAIL) "/var/spool/mail/jswalling"}
catch {set ::env(MANPATH) "/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/share/innovus/stylus/man:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/share/tcltools/man:/software/RFIC/cadtools/cadence/cadence/ICADVM_20.10.000_lnx86/tools/man:/software/RFIC/cadtools/cadence/cadence/ICADVM_20.10.000_lnx86/share/man"}
catch {set ::env(MGC_HOME) "/software/RFIC/cadtools/mentor/release"}
catch {set ::env(MGLS_LICENSE_FILE) "27005@license.ece.vt.edu"}
catch {set ::env(MMSIM) "/software/RFIC/cadtools/cadence/spectre/SPECTRE_23.10.063_lnx86"}
catch {set ::env(MODULEPATH) "/usr/share/Modules/modulefiles:/etc/modulefiles"}
catch {set ::env(MODULESHOME) "/usr/share/Modules"}
catch {set ::env(NCVLOG_ROOT_DIR) "/software/RFIC/cadtools/cadence/incisive/INCISIVE152"}
catch {set ::env(OA_BIT) "64"}
catch {set ::env(OLDPWD) "/home/micsTapeouts/projects/28HPC_summer2024/jswalling/synthesis/cadence/pp_fir_u_7_work"}
catch {set ::env(ORBIT_HOME) "/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/OrbitIO"}
catch {set ::env(PATH) "/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/bin:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/bin/64bit:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/bin:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/share/oa/bin:/software/RFIC/cadtools/altair/feko/bin:/software/RFIC/cadtools/cadence/../synopsys/customcompiler/U-2023.03-5/bin:/software/RFIC/cadtools/cadence/../synopsys/primesim/U-2023.03/bin:/software/RFIC/cadtools/cadence/../synopsys/primewavereliability/U-2023.03/bin:/software/RFIC/cadtools/cadence/../synopsys/primewave/U-2023.03/bin:/software/RFIC/cadtools/cadence/../synopsys/custominfrastructure/U-2023.03/bin:/software/RFIC/cadtools/cadence/../synopsys/icc/U-2022.12-SP5/bin:/software/RFIC/cadtools/cadence/../synopsys/prime/T-2022.03-SP5/bin:/software/RFIC/cadtools/cadence/../synopsys/syn/T-2022.03-SP5-2/bin:/software/RFIC/cadtools/cadence/../synopsys/icc2/T-2022.03-SP5/bin:/software/RFIC/cadtools/cadence/allegro/SPB_22.10.000_lnx86/tools/bin:/software/RFIC/cadtools/cadence/allegro/SPB_22.10.000_lnx86/tools/dfII/bin:/software/RFIC/cadtools/cadence/sigrity/SIG_21.10.400_lnx86/tools/bin:/software/RFIC/cadtools/cadence/sigrity/SIG_21.10.400_lnx86/tools/dfII/bin:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/GENUS221/tools.lnx86/bin:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/dfII/bin:/software/RFIC/cadtools/cadence/quantus/QUANTUS211-ISR1_21.11.000_lnx86/tools/bin:/software/RFIC/cadtools/cadence/quantus/QUANTUS211-ISR1_21.11.000_lnx86/tools/dfII/bin:/software/RFIC/cadtools/cadence/assura/ASSURA41/tools/assura/bin:/software/RFIC/cadtools/cadence/assura/ASSURA41/tools/bin:/software/ADS/ADS2020_update2/bin:/software/RFIC/cadtools/mentor/release/bin:/software/RFIC/cadtools/cadence/incisive/INCISIVE152/tools/bin:/software/RFIC/cadtools/cadence/spectre/SPECTRE_23.10.063_lnx86/tools/bin:/software/RFIC/cadtools/cadence/spectre/SPECTRE_23.10.063_lnx86/tools/dfII/bin:/software/RFIC/cadtools/cadence/integrand/.current/bin:/software/RFIC/cadtools/cadence/cadence/ICADVM_20.10.000_lnx86/tools/bin:/software/RFIC/cadtools/cadence/cadence/ICADVM_20.10.000_lnx86/tools/dfII/bin:/home/jswalling/anaconda3/bin:/home/jswalling/anaconda3/condabin:/software/bin:/software/bin:/software/bin:/usr/lib64/qt-3.3/bin:/software/bin:/sbin:/bin:/usr/bin:/usr/local/bin:/usr/local/sbin:/usr/sbin:/home/jswalling/.local/bin:/home/jswalling/bin:/home/jswalling/.local/bin:/home/jswalling/bin:/home/jswalling/.local/bin:/home/jswalling/bin"}
catch {set ::env(PROD_NAME) "innovus"}
catch {set ::env(PS) "/software/RFIC/cadtools/cadence/../synopsys/primesim/U-2023.03"}
catch {set ::env(PT) "/software/RFIC/cadtools/cadence/../synopsys/prime/T-2022.03-SP5"}
catch {set ::env(PULSE_SCRIPT) "/etc/xrdp/pulse/default.pa"}
catch {set ::env(PW) "/software/RFIC/cadtools/cadence/../synopsys/primewave/U-2023.03"}
catch {set ::env(PWD) "/home/micsTapeouts/projects/28HPC_summer2024/jswalling/synthesis/cadence/pp_int_x4_work"}
catch {set ::env(PWR) "/software/RFIC/cadtools/cadence/../synopsys/primewavereliability/U-2023.03"}
catch {set ::env(QRC_HOME) "/software/RFIC/cadtools/cadence/quantus/QUANTUS211-ISR1_21.11.000_lnx86"}
catch {set ::env(QTDIR) "/usr/lib64/qt-3.3"}
catch {set ::env(QTINC) "/usr/lib64/qt-3.3/include"}
catch {set ::env(QTLIB) "/usr/lib64/qt-3.3/lib"}
catch {set ::env(QT_GRAPHICSSYSTEM_CHECKED) "1"}
catch {set ::env(QT_IM_MODULE) "ibus"}
catch {set ::env(SHELL) "/bin/bash"}
catch {set ::env(SHLVL) "4"}
catch {set ::env(SIGRITY) "/software/RFIC/cadtools/cadence/sigrity/SIG_21.10.400_lnx86"}
catch {set ::env(SNPSLMD_LICENSE_FILE) "27000@license.ece.vt.edu"}
catch {set ::env(SSH_AGENT_PID) "22340"}
catch {set ::env(SSH_AUTH_SOCK) "/run/user/4142/keyring/ssh"}
catch {set ::env(SYNOPSYS_FLOW_BASED_GUI) "1"}
catch {set ::env(SynopsysInstall) "/software/RFIC/cadtools/cadence/../synopsys"}
catch {set ::env(TCLLIBPATH) "/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/share/lib/tcllib/1.18 "}
catch {set ::env(TCLLIB_LIBRARY) "/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/share/lib/tcllib/1.18"}
catch {set ::env(TCLTK_ROOT) "/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/share/tcltools/icd8.6.4/lib"}
catch {set ::env(TCL_LIBRARY) "/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/share/tcltools/icd8.6.4/lib/tcl8.6"}
catch {set ::env(TERM) "xterm-256color"}
catch {set ::env(TIX_LIBRARY) "/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/share/tcltools/icd8.6.4/lib/Tix8.4.3/library"}
catch {set ::env(TK_LIBRARY) "/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/share/tcltools/icd8.6.4/lib/tk8.6"}
catch {set ::env(TOOL_TCL_LIBPATH) "/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/tcltools/icd8.6.4/lib/64bit"}
catch {set ::env(UID) "4142"}
catch {set ::env(USER) "jswalling"}
catch {set ::env(VIRTUALENVWRAPPER_SCRIPT) "/bin/virtualenvwrapper.sh"}
catch {set ::env(VTE_VERSION) "5204"}
catch {set ::env(W3264_ENV) "/home/jswalling/.kshrc"}
catch {set ::env(W3264_STORED_HOSTNAME) "cluster15"}
catch {set ::env(W3264_USER_LIBPATH) ""}
catch {set ::env(W3264_USER_PATH) "/software/RFIC/cadtools/altair/feko/bin:/software/RFIC/cadtools/cadence/../synopsys/customcompiler/U-2023.03-5/bin:/software/RFIC/cadtools/cadence/../synopsys/primesim/U-2023.03/bin:/software/RFIC/cadtools/cadence/../synopsys/primewavereliability/U-2023.03/bin:/software/RFIC/cadtools/cadence/../synopsys/primewave/U-2023.03/bin:/software/RFIC/cadtools/cadence/../synopsys/custominfrastructure/U-2023.03/bin:/software/RFIC/cadtools/cadence/../synopsys/icc/U-2022.12-SP5/bin:/software/RFIC/cadtools/cadence/../synopsys/prime/T-2022.03-SP5/bin:/software/RFIC/cadtools/cadence/../synopsys/syn/T-2022.03-SP5-2/bin:/software/RFIC/cadtools/cadence/../synopsys/icc2/T-2022.03-SP5/bin:/software/RFIC/cadtools/cadence/allegro/SPB_22.10.000_lnx86/tools/bin:/software/RFIC/cadtools/cadence/allegro/SPB_22.10.000_lnx86/tools/dfII/bin:/software/RFIC/cadtools/cadence/sigrity/SIG_21.10.400_lnx86/tools/bin:/software/RFIC/cadtools/cadence/sigrity/SIG_21.10.400_lnx86/tools/dfII/bin:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/GENUS221/tools.lnx86/bin:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/bin:/software/RFIC/cadtools/cadence/ddi/DDI_22.10.000_lnx86/INNOVUS221/tools.lnx86/dfII/bin:/software/RFIC/cadtools/cadence/quantus/QUANTUS211-ISR1_21.11.000_lnx86/tools/bin:/software/RFIC/cadtools/cadence/quantus/QUANTUS211-ISR1_21.11.000_lnx86/tools/dfII/bin:/software/RFIC/cadtools/cadence/assura/ASSURA41/tools/assura/bin:/software/RFIC/cadtools/cadence/assura/ASSURA41/tools/bin:/software/ADS/ADS2020_update2/bin:/software/RFIC/cadtools/mentor/release/bin:/software/RFIC/cadtools/cadence/incisive/INCISIVE152/tools/bin:/software/RFIC/cadtools/cadence/spectre/SPECTRE_23.10.063_lnx86/tools/bin:/software/RFIC/cadtools/cadence/spectre/SPECTRE_23.10.063_lnx86/tools/dfII/bin:/software/RFIC/cadtools/cadence/integrand/.current/bin:/software/RFIC/cadtools/cadence/cadence/ICADVM_20.10.000_lnx86/tools/bin:/software/RFIC/cadtools/cadence/cadence/ICADVM_20.10.000_lnx86/tools/dfII/bin:/home/jswalling/anaconda3/bin:/home/jswalling/anaconda3/condabin:/software/bin:/software/bin:/software/bin:/usr/lib64/qt-3.3/bin:/software/bin:/sbin:/bin:/usr/bin:/usr/local/bin:/usr/local/sbin:/usr/sbin:/home/jswalling/.local/bin:/home/jswalling/bin:/home/jswalling/.local/bin:/home/jswalling/bin:/home/jswalling/.local/bin:/home/jswalling/bin"}
catch {set ::env(XCELIUM) "/software/RFIC/cadtools/cadence/xcelium/XCELIUM_22.09.001_lnx86"}
catch {set ::env(XDG_CURRENT_DESKTOP) "GNOME"}
catch {set ::env(XDG_DATA_DIRS) "/home/jswalling/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share"}
catch {set ::env(XDG_MENU_PREFIX) "gnome-"}
catch {set ::env(XDG_RUNTIME_DIR) "/run/user/4142"}
catch {set ::env(XDG_SESSION_ID) "c23"}
catch {set ::env(XMODIFIERS) "@im=ibus"}
catch {set ::env(XPEDION) "/software/RFIC/cadtools/cadence/../ads/GoldenGate-2020"}
catch {set ::env(XPEDION_CADENCE_VERSION) "618"}
catch {set ::env(XRDP_PULSE_SINK_SOCKET) "xrdp_chansrv_audio_out_socket_22"}
catch {set ::env(XRDP_PULSE_SOURCE_SOCKET) "xrdp_chansrv_audio_in_socket_22"}
catch {set ::env(XRDP_SESSION) "1"}
catch {set ::env(XRDP_SOCKET_PATH) "/run/xrdp"}
catch {set ::env(_CE_CONDA) ""}
catch {set ::env(_CE_M) ""}
catch {set ::env(_VIRTUALENVWRAPPER_API) " mkvirtualenv rmvirtualenv lsvirtualenv showvirtualenv workon add2virtualenv cdsitepackages cdvirtualenv lssitepackages toggleglobalsitepackages cpvirtualenv setvirtualenvproject mkproject cdproject mktmpenv wipeenv allvirtualenv mkvirtualenv rmvirtualenv lsvirtualenv showvirtualenv workon add2virtualenv cdsitepackages cdvirtualenv lssitepackages toggleglobalsitepackages cpvirtualenv setvirtualenvproject mkproject cdproject mktmpenv wipeenv allvirtualenv mkvirtualenv rmvirtualenv lsvirtualenv showvirtualenv workon add2virtualenv cdsitepackages cdvirtualenv lssitepackages toggleglobalsitepackages cpvirtualenv setvirtualenvproject mkproject cdproject mktmpenv wipeenv allvirtualenv mkvirtualenv rmvirtualenv lsvirtualenv showvirtualenv workon add2virtualenv cdsitepackages cdvirtualenv lssitepackages toggleglobalsitepackages cpvirtualenv setvirtualenvproject mkproject cdproject mktmpenv wipeenv allvirtualenv"}
catch {set ::env(base_dir) "/software/RFIC/cadtools/cadence"}
catch {set ::env(ps3264_osid) "CentOS"}
catch {set ::env(w3264_osver) "7"}
catch {set ::env(PROCINFO_HOST) "cluster15:59376"}
catch {set ::env(TK_TABLE_LIBRARY_FILE) "tkTable.tcl"}
catch {set ::env(TK_TABLE_LIBRARY) "EMBEDDED_RUNTIME"}
catch {set ::env(DD_NO_TMPDIR_WARN) "true"}
catch {set ::env(EDP_C_CODE) "1"}
catch {set ::env(ENABLE_MMMC2_VIEW_DEFINITION_GENERATION_IN_TEMPUS_CUI) "1"}
catch {set ::env(usefulSkewCCOpt) "1"}
catch {set ::env(_enable_mmmc_by_default_flow) "1"}
catch {set ::env(FE_MASTER_USER_ORIGINAL_TMPDIR) "/home/micsTapeouts/projects/28HPC_summer2024/jswalling/synthesis/cadence/pp_int_x4_work"}
catch {set ::env(__QUANTUS_FIX_SLOW_NFS_MINIMAL__) "YES"}
catch {set ::env(CDS_WORKAREA) "/home/micsTapeouts/projects/28HPC_summer2024/jswalling/synthesis/cadence/pp_int_x4_work"}
catch {set ::env(EDP_MODE) "local"}
catch {set ::env(__HPY_MODELING_SMALL_SEG__) "false"}
catch {set ::env(TEMPDIR) "/home/micsTapeouts/projects/28HPC_summer2024/jswalling/synthesis/cadence/pp_int_x4_work/innovus_temp_47454_cluster15_jswalling_XoH8s4/iqrc_tmp_47454_IxUiW2/.qrctemp/.xrctemp_0"}
catch {if {[isLimitedAccessFeatureEnabled ccopt_native -silent] != 1} {setLimitedAccessFeature ccopt_native 1}}
catch {if {[isLimitedAccessFeatureEnabled ccopt_native_cts -silent] != 1} {setLimitedAccessFeature ccopt_native_cts 1}}
catch {if {[isLimitedAccessFeatureEnabled ccopt_flexible_htree -silent] != 1} {setLimitedAccessFeature ccopt_flexible_htree 1}}
catch {if {[isLimitedAccessFeatureEnabled ccopt_multithreading -silent] != 1} {setLimitedAccessFeature ccopt_multithreading 1}}
catch {if {[isLimitedAccessFeatureEnabled ccopt_opt_multithreading -silent] != 1} {setLimitedAccessFeature ccopt_opt_multithreading 1}}
catch {if {[isLimitedAccessFeatureEnabled cts_halo_mode_sum -silent] != 1} {setLimitedAccessFeature cts_halo_mode_sum 1}}
catch {if {[isLimitedAccessFeatureEnabled invsHierModuleModel -silent] != 1} {setLimitedAccessFeature invsHierModuleModel 1}}
catch {edp::setNodeId 9d2facb1-16b6-44a0-b2df-8074469082a5_10/16}
startEdpSlave 10 cluster15 55228 53125 0 10
}
