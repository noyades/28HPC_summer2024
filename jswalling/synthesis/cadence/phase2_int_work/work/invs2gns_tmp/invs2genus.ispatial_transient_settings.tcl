eval_legacy {
Puts "WARNING: Applying these settings makes Innovus 'Genus like' and is the state used within iSpatial."
Puts "WARNING: They should not be left in place for further processing."
set_global timing_constraint_enable_set_units true
setPlaceMode -placeIoPins true
setPlaceMode -reorderScan false
setOptMode -simplifyNetlist false
set_global timing_apply_default_primary_input_assertion false
setAnalysisMode -asyncChecks async
setPlaceMode -reorderScan false
}
