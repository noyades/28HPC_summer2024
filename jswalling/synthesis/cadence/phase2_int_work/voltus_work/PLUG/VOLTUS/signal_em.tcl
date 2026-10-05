# signal EM recommend to use Voltus or Innovus DB, \
# it constains lef, def, qrc techfile \
#---------------------------------------------------------------------
#set_max_tran_per_freq \
[-force] \
-freq { freq1 freq2 ...} \
[-lib libName ] \
-pins { cell pin } \
-tran { tran1 tran2 ...}

#set_max_cap_per_freq \
-cap { cap1 cap2 ¡­} \
[-force] \
-freq { freq1 freq2 ¡­} \
[-lib libName ] \
-pins { cell pin }

#verify_AC_limit \
[-help] \
[-Ipeak_Td_method {effective_width_from_integration effective_half_peak_width max_equivalent_dc_peak sum_half_peak_width}] \
[-avgRecovery em_recover ] \
[-default_freq_for_unconstrained_nets freq_in_Hz ] \
iideltaTemp value ] \
[-em_res_width {drawn silicon}] \
[-error value ] \
[-hour value ] \
[-method {rms peak avg}] \
[-minPeakDutyRatio value ] \
[-minPeakFreq value ] \
[-ruleFile filename ] \
[-temp tempInC ] \
[-toggle value ] \
[-useQrcTech] \
[-use_db_freq] \
[-view viewName ] \
[-net netNames | -selected ] \
[-report filename [-detailed]] \
[-reportFixWidth] \
[-scaleIrmsLimit value [-layerForScaleIrmsLimit string ]] \
[-layerForScaleIpeakLimit string ] \
[-scaleCurrent scale_factor | -scaleIrms value ] \
[-set_current_file filename ] \
[-ict_em_models file ] \
[-current_scale_factor {{avg value } {rms value } {peak value }}] \
[-em_limit_scale_factor {{avg value } {rms value } {peak value }}] \
[-em_threshold < value >] \
[-current_scale_table current_scale_table_file ] \
[-em_limit_scale_table em_limit_scale_table_file ]

#---------------------------------------------------------------------

