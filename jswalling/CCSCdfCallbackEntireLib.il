/* 
This SKILL code is not sufficient on its own. You need to also
download CCSinvokeCdfCallbacks.il file before running this code.

load "CCSinvokeCdfCallbacks.il"
load "CCSCdfCallbackEntireLib.il"

CCSCdfCallbackEntireLib("MYLIB")            

where "MYLIB" is the design library. 

The viewName argument can be specified

CCSCdfCallbackEntireLib("MYLIB" ?viewName "mysch")

Also, any of the arguments accepted by CCSinvokeCdfCallbacks can be supplied:

CCSCdfCallbackEntireLib("MYLIB" ?order list("w"))            
 

*/


/***************************************************************
*                                                              *
*           CCSCdfCallbackEntireLib(libName [options])         *
*                                                              *
* Invoke the CDF callbacks for all schematics of given library *
*                                                              *
***************************************************************/

procedure(CCSCdfCallbackEntireLib(library @key (viewName "schematic")
      (check t)
      (save t)
      (debug nil) 
      (order nil)
      (callInitProc nil) (useInstCDF nil) (useCellCDF t)
      (setCdfgForm nil) (addFormFields nil) (filterFunc nil))
  let((libName cv)
    unless(libName=ddGetObj(library) error("Library %s does not exists\n" library))
    foreach(cell libName~>cells
      when(ddGetObj(library cell~>name viewName)
        printf("Processing cell %s\n" cell~>name)
        ;Open schematic
        cv = dbOpenCellViewByType(library cell~>name viewName "" "a")
        when(cv
          CCSinvokeCdfCallbacks(
            cv
            ?debug debug
            ?order order
            ?callInitProc callInitProc
            ?useInstCDF useInstCDF
            ?useCellCDF useCellCDF
            ?setCdfgForm setCdfgForm
            ?addFormFields addFormFields
            ?filterFunc filterFunc
          )
          when(check
            ;Run schematic check and Save
            schCheck(cv)
          )
          when(save
            dbSave(cv)
          )
        )
      )
    )
    t
  )
) 


