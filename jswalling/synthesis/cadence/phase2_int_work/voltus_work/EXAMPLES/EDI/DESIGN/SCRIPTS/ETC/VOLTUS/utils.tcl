proc eps_ff_load_design {} {

   global vars

   if {[info exists vars(def_files)] && ([llength $vars(def_files)] >= 1)} {
      set vars(design_placed) [dbIsHeadDesignPlaced [dbgHead]]
      if {$vars(design_placed) == 0} {
         if {[info exists vars(def_files)]} {
            Puts "<FF> Loading def file(s) for layout view"
            read_def $vars(def_files)
         } else { 
            Puts "<FF> WARNING: Design is not placed and vars(def_files) was not defined"
            read_def $vars(def_files)
         }
      }
   }
}
