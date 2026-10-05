/* CCSinvokeCdfCallbacks.il

Date       Jul 11, 1995 
Modified   Nov 01, 2022 

Invoke all the CDF callbacks for instances

The main entry point is (CCSinvokeCdfCallbacks cellView)
which invokes all the CDF callbacks for every instance in
a cellView. This has some keyword arguments which allow debug
messages to be displayed, to invoke the formInitProc if needed,
and to invoke using the instance CDF directly, rather than try
to create something that looks more like the effective CDF that
is found when the callbacks are normally invoked from the forms.

You can use the variable CCScallbackPatternsToIgnore so
that some callbacks can be omitted.

Extended in version 1.16 to allow ?filterFunc to be passed.
This is a function that gets the cdf, the param name (nil
for the initProc) and callback string.
The function should return t if the callback should be called, 
and nil otherwise. For example:

procedure(MYfilterFunc(cdf paramName callback)
    destructuringBind(
        (lib @optional cell) CCSgetLibCellFromCDF(cdf)
        ; t if any other parameter than w for gpdk090/nmos1v
        !(lib=="gpdk090" && cell=="nmos1v" && param=="w")
    )
)

Another example of a filter function is to exclude button callbacks:

procedure(MYexcludeButtons(cdf paramName callback)
    cdfFindParamByName(cdf paramName)->paramType!="button"
)

CCSinvokeCdfCallbacks(geGetEditCellView() ?filterFunc 'MYfilterFunc)

Version 1.17 allows you to retrieve the results of the display or
editable callbacks for an instance:

displayParams=setof(param 
    CCSinvokeInstCdfCallbacks(instId ?callbackType 'display ?returnResults t)
    cadr(param))

Version 1.19 uses the cell CDF by default (rather than using the
effective lookalike CDF approach). This means that most PDKs should work
and no messing around with being unsure about using the instance or
effective lookalike CDF is needed.

Version 1.20 provides a way of calling the callbacks without needing an 
actual instance. The typical use model would be:

unwindProtect(
  ; protected form
  let((cdf)
    ; see the function comments for available options
    cdf=CCSgetCdfForCell("gpdk090" "nmos2v")
    cdf->fw->value="200n"
    cdf->fingers->value="5"
    CCSinvokeObjCdfCallbacks(
      cdf 
      ?callInitProc t 
      ?setCdfgForm CCSgetCachedCdfgForm() 
      ?order list("fw" "fingers")
    )
    ; now can retrieve cdf->w->value and see the result
  )
  ; cleanup - always restore the cell CDF
  CCSrestoreCellCdf()
)

General Approach
----------------

The strategy for calling callbacks has evolved over time, and there are
three main ways of handling the CDF:

1. Using instance CDF.
   This was the original approach, and generally worked OK except when
   the callbacks use cdfgData->id->name to determine the cell name. With
   instance CDF this expression returns the instance name, so may misbehave.
2. Using a "lookalike" effective cell CDF.
   Strictly speaking, callbacks are invoked with the effective cell CDF, so
   this was to emulate the effective CDF with a similar data structure. The
   reason for emulating it was that I didn't want to disturb the values in
   the actual effective cell CDF, so wrapped the parameters from the instance
   CDF in a data structure that looks similar to the cell CDF. The problem with
   this approach is that some PDKs (particularly those created using PAS)
   perform type checking on their arguments and this fails because the data
   structure is not actually CDF. You could workaround this by using instance
   CDF for PAS-based PDKs because they didn't use the cdfgData->id->name
   construct.
3. Using the actual effective cell CDF.
   This is now the default method. After 25 years or so, I released that
   the edit properties forms in Virtuoso already are rather cavalier about
   messing with the parameter values in the effective CDF, so using this 
   approach makes sense. The code does attempt to preserve the existing
   CDF parameter values and restore them afterwards to avoid disturbing 
   other code. A lot of the complexity in the code is as a result of
   continuing to support the older methods, but usually ?useCellCDF t (the
   default) is the best approach.

For historical reasons, the CDF formInitProc is not called by default (it
probably should be, but I didn't want to change this), so it's probably
good practice to use ?callInitProc t.

The code also has provision for emulating cdfgForm; this is supposed to
be the form structure itself, but this is mostly handled by using the
lookalike effective structure so that additional properties can be added
to make it look more like the form. The ?addFormFields argument adds some
additional parameters to the emulated form for rarer cases that need it.

One thing to be aware of when calling callbacks is that there can be an
order dependency on the parameters in many cases. For example, if you have
parameters w (Total Width), fw (Finger Width) and fingers, then if you 
interactively set w, it will divide that by fingers to get fw; if you 
interactively set fw, then it will multiply that by fingers to get w. 
When you interact with the form, the callback order is determined by the
order that you make the edits in, whereas calling all the callbacks in 
batch mode has no concept of order. The ?order argument allows you to 
override the default parameter order (top to bottom), and also allows you
to pick a subset of the parameters to call (for many PDKs, calling just one
of the callbacks is sufficient and it can be slow to call every single 
callback).

Description of common keyword arguments 
----------------------------------------

These are used in various functions throughout this code

?debug           : print information about which callbacks are being invoked
?order           : specify a list of the parameter names to call callbacks for 
                   in the order you want them to be called in
?callInitProc    : call the formInitProc defined in the CDF
?useInstCDF      : use the instance CDF instead of the cell CDF (only if 
                   ?useCellCDF is nil)
?useCellCDF      : use the actual Cell CDF. If this and ?useInstCDF are nil, use
                   an "effective lookalike CDF" which avoids messing with the 
                   parameters in the real CDF, but this does not work with all 
                   callbacks as some (such as those in PAS PDKs) do 
                   type-checking on their arguments.
?setCdfgForm     : Set the cdfgForm variable too (as well as cdfgData)
?addFormFields   : Adds some additional form fields to the emulated cdfgForm
                   so that callbacks that need this will work
?filterFunc      : a function to determine whether a callback should be 
                   called (see info above)
?callbackType    : type of callback to be called - one of 'callback, 
                   'display or 'editable
?returnResults   : return an assoc list of parameter name and result of 
                   calling the callback (tends to be useful for display and 
                   editable callbacks)
?resetToDefaults : reset values back to the defValue


***************************************************

SCCS Info: @(#) CCSinvokeCdfCallbacks.il 11/01/22.10:52:57 1.20

*/
/*******************************************************************************
*  DISCLAIMER: The following code is provided for Cadence customers to use at  *
*   their own risk. The code may require modification to satisfy the           *
*   requirements of any user. The code and any modifications to the code may   *
*   not be compatible with current or future versions of Cadence products.     *
*   THE CODE IS PROVIDED "AS IS" AND WITH NO WARRANTIES, INCLUDING WITHOUT     *
*   LIMITATION ANY EXPRESS WARRANTIES OR IMPLIED WARRANTIES OF MERCHANTABILITY *
*   OR FITNESS FOR A PARTICULAR USE.                                           *
*******************************************************************************/

;------------------------------------------------------------------------
; this is here in case using in an old version such as IC5141 which
; didn't have unwindProtect
;------------------------------------------------------------------------
(unless (isCallable 'unwindProtect)
  (defmacro unwindProtect (protected cleanup)
    `(prog1
       (car (errset ,protected t))
       ,cleanup)))

/***************************************************************
*                                                              *
*    The variable CCScallbackPatternsToIgnore is set to be     *
*      a list of patterns against which the callbacks are      *
*      checked. If any of these patterns are matched then      *
*                 the callback is not invoked.                 *
*                                                              *
***************************************************************/

(unless (boundp 'CCScallbackPatternsToIgnore)
  (setq CCScallbackPatternsToIgnore
        '("^MYPDKNot_Allowed.*")))

/***************************************************************
*                                                              *
*  (CCSshouldCallbackBeExecuted callback filterFunc cdf param) *
*                                                              *
*  This checks the callback against all the patterns defined   *
*    in the list CCScallbackPatternsToIgnore to determine      *
*       whether the callback should be executed or not.        *
*    If filterFunc is passed, call with cdf, param name and    *
*            callback - this should return t or nil            *
*                                                              *
***************************************************************/

(procedure (CCSshouldCallbackBeExecuted callback filterFunc cdf param)
  (and
    (forall pattern CCScallbackPatternsToIgnore
            (null (rexMatchp pattern callback)))
    (if filterFunc
      (funcall filterFunc cdf param callback)
      t
      )
    )
  )

/***************************************************************
*                                                              *
*                 (CCSgetLibCellFromCDF cdf)                   *
*                                                              *
*   Utility function to retrieve a list of lib and cell name   *
*  from the CDF, regardless of whether it is an inst, cell or  *
* lib CDF. For lib CDF it only returns a list of the lib name  *
*                                                              *
***************************************************************/

(procedure (CCSgetLibCellFromCDF cdf)
  (let (id)
    (setq id (getq cdf id))
    (case (type id)
      (dbobject
        (list (getq id libName) (getq id cellName))
        )
      (ddCellType
        (list (getq (getq id lib) name) (getq id name))
        )
      (ddLibType
        (list (getq id name))
        )
      )
    )
  )

/*********************************************************************
*                                                                    *
*       (CCScreateEffectiveCDFLookalike cdf [lookalikeParams]        *
*                       [resetLookalikeParams])                      *
*                                                                    *
*     Create a structure which looks (sort of) like an effective     *
*  CDF. The reason for creating this is to allow the "id" parameter  *
*  to be correctly set to the cell, rather than the instance, which  *
* is what happens if we use the cdfGetInstCDF() function to simulate *
* cdfgData. The lookalikeParams optional parameter allows creation   *
* of the parameters to be "lookalike" as well, so that callbacks can *
* be called even if there is no actual instance. By default, the     *
* parameters will be reset with using lookalikeParams, unless you    *
*                   pass nil as the third argument.                  *
*                                                                    *
*********************************************************************/

(procedure (CCScreateEffectiveCDFLookalike cdf @optional lookalikeParams
                                          (resetLookalikeParams t))
  (let (new cdfFields newParam)
       (unless (getd 'make_CCSeffCDF)
               ;---------------------------------------------------------
               ; Because some slots appear twice in cdf->? have
               ; to make the list unique
               ;---------------------------------------------------------
               (setq cdfFields (makeTable 'cdfFields))
               (foreach field (getq cdf ?)
                        (setarray cdfFields  field t)
                        )
               (eval `(defstruct CCSeffCDF ,@(getq cdfFields ?))))
       (setq new (make_CCSeffCDF))
       (when (and lookalikeParams (null (getd 'make_CCSeffCDFparam)))
         (setq cdfFields (makeTable 'cdfFields))
         (foreach field (getq (car (getq cdf parameters)) ?)
                  (setarray cdfFields field t))
         (eval `(defstruct CCSeffCDFparam ,@(getq cdfFields ?))))
       ;-----------------------------------------------------------------
       ; populate the effective cdf with the top level cdf attributes
       ;-----------------------------------------------------------------
       (foreach param (getq cdf ?)
                (putprop new (get cdf param) param))
       ;-----------------------------------------------------------------
       ; Set the id and type attributes appropriately
       ;-----------------------------------------------------------------
       (when (equal (getq new type) "instData")
         (putpropq new (dbGetq (dbGetq (getq cdf id) master) cell) id)
         (putpropq new "cellData" type)
         )
       ;-----------------------------------------------------------------
       ; If we want the parameters to be lookalike too, create those
       ;-----------------------------------------------------------------
       (when lookalikeParams
         (putpropq new 
                   (foreach mapcar param (getq cdf parameters)
                            (setq newParam (make_CCSeffCDFparam))
                            (foreach slot (getq param ?)
                                     (putprop newParam (get param slot) slot))
                            (when resetLookalikeParams
                              ; reset the value to defValue for safety
                              (putpropq newParam (getq newParam defValue) value)
                              )
                            newParam
                            )
                   parameters)
         ) ; when
       ;-----------------------------------------------------------------
       ; Add the parameters as properties in the effective cdf
       ;-----------------------------------------------------------------
       (foreach param (getq new parameters)
                (putprop new param (getq param name))
                )
       new
       )
  )

/*******************************************************************
*                                                                  *
*       (CCSaddFormFieldsToEffectiveCDFLookalike cdf inst)         *
*                                                                  *
* Populate four extra fields - libraryName, cellName, viewName and *
*  instanceName to emulate the forms on the forms - i.e. so that   *
*  cdfgForm gets these slots. This is for callbacks which (badly)  *
*   use cdfgForm to find out libraryName, cellName and viewName.   *
*                                                                  *
*******************************************************************/

(procedure (CCSaddFormFieldsToEffectiveCDFLookalike cdf inst)
  (let (fieldData value)
    (unless (getd 'make_CCSeffCDFFormFields)
      (defstruct CCSeffCDFFormFields value defValue lastValue 
        editable enabled invisible)
      )
    (foreach (field attr) '(libraryName cellName viewName instanceName) 
             '(libName cellName viewName name)
             (setq value (dbGet inst attr))
             (setq fieldData
                   (make_CCSeffCDFFormFields
                     ?value value
                     ?defValue value
                     ?lastValue value
                     ?editable t
                     ?enabled t
                     ?invisible nil
                     ))
             (putprop cdf fieldData field)
             )
    cdf
    )
  )

/*******************************************************************
*                                                                  *
*      (CCSinvokeObjCdfCallbacks cdf @key (debug nil) order        *
*       (callInitProc nil) (setCdfgForm t) (filterFunc nil)        *
*          (callbackType 'callback) (returnResults nil))           *
*                                                                  *
*      Underlying function which does all the real work. This      *
* is separated from the original function CCSinvokeInstCdfCallbacks*
*    so that this can be called with a completely virtual CDF.     *
*      See CCSinvokeInstCdfCallbacks for a description of the      *
*  arguments - note that there is the ability to control whether   *
*                     cdfgForm is set or not.                      *
*   Can specify which callback to call - default is the standard   *
*     callback, but can be 'display or 'editable. Usually will     *
* return nil if any callback failed with a SKILL error, t otherwise*
*    but if ?returnResults t is passed, returns an assoc list of   *
*         parameter name and result from each expression           *
*                                                                  *
*******************************************************************/

(procedure (CCSinvokeObjCdfCallbacks cdf @key (debug nil) order
                                     (callInitProc nil) (setCdfgForm t)
                                     filterFunc (callbackType 'callback)
                                     returnResults
                                     )
  ;----------------------------------------------------------------------
  ; Make cdfgData and cdfgForm dynamically scoped, to avoid
  ; interfering with any global usage of these variables
  ;----------------------------------------------------------------------
  (let (callback parameters cdfgData cdfgForm (success t) result results)
       ;-----------------------------------------------------------------
       ; Set the cdfgData to be the instance CDF
       ;-----------------------------------------------------------------
       (setq cdfgData cdf)
       (setq cdfgForm nil)
       (when setCdfgForm 
         ;---------------------------------------------------------------
         ; some callbacks use cdfgForm instead
         ;---------------------------------------------------------------
         (if (equal setCdfgForm t)
           (setq cdfgForm cdfgData)
           (setq cdfgForm setCdfgForm)
           )
         )
       ;-----------------------------------------------------------------
       ; Call the formInitProc if there is one.
       ;-----------------------------------------------------------------
       (when callInitProc
             (setq callback (getq cdfgData formInitProc))
             (when (and callback 
                        (nequal callback "")
                        (CCSshouldCallbackBeExecuted callback filterFunc 
                                                    cdfgData nil))
                   (when debug
                         (printf "  Invoking formInitProc: '%s'\n" callback))
                   ;-----------------------------------------------------
                   ; Evaluate the callback
                   ;-----------------------------------------------------
                   (unless
                    (errset (evalstring 
                             (strcat callback "(cdfgData)")) t)
                    (setq success nil)
                    )
                   )
             )
       ;-----------------------------------------------------------------
       ; Control order of parameter evaluation. If order specified,
       ; just do those, otherwise do all in arbitrary order
       ;-----------------------------------------------------------------
       (if order
           (setq parameters (foreach mapcar param order
                                     (get cdfgData param)))
           (setq parameters (getq cdfgData parameters))
           )
       ;-----------------------------------------------------------------
       ; loop through all parameters
       ;-----------------------------------------------------------------
       (setq results
             (foreach 
               mapcar param parameters
               (setq callback 
                     (case callbackType
                       (callback (getq param callback))
                       (display (getq param display))
                       (editable (getq param editable))
                       (t (getq param callback))
                       ))
               (setq result t)
               (when (and callback 
                          (nequal callback "")
                          (CCSshouldCallbackBeExecuted callback filterFunc
                                                      cdfgData
                                                      (getq param name)))
                 (when debug
                   (printf "  Invoking callback for '%s': '%s'\n"
                           (getq param name) callback))
                 ;--------------------------------------------------
                 ; evaluate the callback
                 ;--------------------------------------------------
                 (unless (errset (setq result (evalstring callback)) t)
                   (setq success nil)
                   )
                 )
               (list (getq param name) result))
             )
       ;-----------------------------------------------------------------
       ; Either return overall success (by default) or the list of
       ; return values from the callback for each parameter
       ;-----------------------------------------------------------------
       (if returnResults results success)
       ))

/*****************************************************************
*                                                                *
*       (CCSinvokeInstCdfCallbacks instance [?debug debug]       *
*  [?order order] [?callInitProc callInitProc] [?useInstCDF nil] *
*     [?useCellCDF t] [?addFormFields nil] [?filterFunc  nil]    *
*          [?setCdfgForm nil] [?callbackType 'callback]          *
*                      [?returnResults nil])                     *
*                                                                *
* Invoke all the parameter callbacks in the CDF for an instance. *
*       This won't do anything if it doesn't have any CDF.       *
* debug is a flag to turn on debug messages. order allows just   *
*    selected parameters to be called, in the specified order.   *
* callInitProc allows the formInitProc to be called. useCellCDF  *
*    uses the genuine cell CDF populated with instance values,   *
*     and if nil, reverts to the older behaviour of using an     *
*   effective lookalike CDF. useInstCDF tells the formInitProc   *
*     to be called with the instCDF rather than the effective    *
*       lookalike CDF. addFormFields tells it to add the         *
*      libraryName/cellName/viewName slots to emulate the        *
*   fields on the cdfgForm, which are used by some bad callback  *
*      code - note this is only done if useInstCDF is nil.       *
*    callbackType allows the display or editable callbacks to    *
*   be invoked rather than the usual callback, and returnResults *
*     allows you to collect all the callback return value        *
*                                                                *
*****************************************************************/

(procedure (CCSinvokeInstCdfCallbacks instance @key (debug nil) order
                                     (callInitProc nil) (useInstCDF nil)
                                     (useCellCDF t)
                                     (addFormFields nil) (filterFunc nil)
                                     (setCdfgForm nil) (callbackType 'callback)
                                     returnResults)
  ;----------------------------------------------------------------------
  ; Make cdfgData and cdfgForm dynamically scoped, to avoid
  ; interfering with any global usage of these variables
  ;----------------------------------------------------------------------
  (let (cdf savedCDF instCDF)
       (when debug
             (printf " Invoking callbacks for instance '%s'\n"
                     (dbGetq instance name)))
       ;-----------------------------------------------------------------
       ; Set the cdf to be the instance CDF
       ;-----------------------------------------------------------------
       (setq cdf (cdfGetInstCDF instance))
       (if useCellCDF
         (progn
           (setq instCDF cdf)
           ;-------------------------------------------------------------
           ; Still create effective lookalike to emulate cdfgForm
           ;-------------------------------------------------------------
           (when setCdfgForm
             (setq setCdfgForm (CCScreateEffectiveCDFLookalike cdf))
             (when addFormFields
               (CCSaddFormFieldsToEffectiveCDFLookalike setCdfgForm instance)
               )
             )
           ;-------------------------------------------------------------
           ; Get cell  CDF, store values in a table for later restoration
           ; and then update the values from instance CDF 
           ;-------------------------------------------------------------
           (setq cdf (cdfGetCellCDF 
                       (ddGetObj 
                         (getq instance libName)
                         (getq instance cellName))))
           (setq savedCDF (makeTable 'savedCDF nil))
           (foreach param (getq cdf parameters)
                    (setarray savedCDF (getq param name) (getq param value))
                    )
           (foreach param (getq cdf parameters)
                    (putpropq 
                      param
                      (getq (get instCDF (getq param name)) value)
                      value))
           )
         (unless useInstCDF
           (setq cdf (CCScreateEffectiveCDFLookalike cdf))
           (when addFormFields
             (CCSaddFormFieldsToEffectiveCDFLookalike cdf instance)
             )
           ))
       ;-----------------------------------------------------------------
       ; Return value will be nil if any callbacks had errors
       ; Keep the setCdfgForm set based on whether useInstCDF is set
       ; but can force it on if instCDF is used and ?setCdfgForm t is passed
       ;-----------------------------------------------------------------
       (unwindProtect
         (CCSinvokeObjCdfCallbacks
           cdf 
           ?debug debug ?order order ?callInitProc callInitProc
           ?setCdfgForm (or setCdfgForm (null useInstCDF)) 
           ?filterFunc filterFunc ?callbackType callbackType 
           ?returnResults returnResults
           )
         ;---------------------------------------------------------------
         ; Restore everything back
         ;---------------------------------------------------------------
         (when useCellCDF
           (cdfUpdateInstParam instance)
           (foreach param (getq cdf parameters)
                    (putpropq 
                      param
                      (arrayref savedCDF (getq param name))
                      value))
           )
         )
  ))

;------------------------------------------------------------------------
; A structure to manage the cached parameters. The idea
; is that you can get the cell CDF and store away all the current values
; so that you can mess with the values and then restore them later
;------------------------------------------------------------------------
(defstruct CCScellCdfCache cdf savedCDF cdfgForm)

/*********************************************************************
*                                                                    *
*                   (CCSgetCdfForCell lib cell @key                  *
*                           (useCellCDF t)                           *
*                         (setCdfgForm nil)                          *
*                        (resetToDefaults t)                         *
*                                 )                                  *
*                                                                    *
* Return the CDF for the lib/cell combo. Can be either the effective *
* CDF or the lookalike effective CDF. Caches the original values so  *
*   that they can be restored by calling CCSrestoreCellCdf() later.  *
*  This allows the effective CDF to be manipulated and callbacks to  *
*  be called (with CCSinvokeObjCdfCallbacks - see the example at the *
*                 top) without needing an instance.                  *
*                                                                    *
*********************************************************************/

(procedure (CCSgetCdfForCell lib cell @key 
                                     (useCellCDF t)
                                     (setCdfgForm nil) 
                                     (resetToDefaults t)
                                     )
  ;----------------------------------------------------------------------
  ; Make cdfgData and cdfgForm dynamically scoped, to avoid
  ; interfering with any global usage of these variables
  ;----------------------------------------------------------------------
  (let (cdf savedCDF)
    (CCSrestoreCellCdf)
    (setq cdf (cdfGetCellCDF (ddGetObj lib cell)))
    (if useCellCDF
      (progn
        ;-------------------------------------------------------------
        ; Still create effective lookalike to emulate cdfgForm
        ;-------------------------------------------------------------
        (when setCdfgForm
          (setq setCdfgForm (CCScreateEffectiveCDFLookalike cdf))
          )
        ;-------------------------------------------------------------
        ; Store values in a table for later restoration
        ;-------------------------------------------------------------
        (setq savedCDF (makeTable 'savedCDF nil))
        (foreach param (getq cdf parameters)
                 (setarray savedCDF (getq param name) (getq param value))
                 )
        )
      ;------------------------------------------------------------------
      ; Otherwise use effective lookalike CDF
      ;------------------------------------------------------------------
      (progn
        (setq cdf (CCScreateEffectiveCDFLookalike cdf))
        ))
    ;--------------------------------------------------------------------
    ; Reset the values back to the defaults
    ;--------------------------------------------------------------------
    (when resetToDefaults
      (foreach param (getq cdf parameters)
               (putpropq param (getq param defValue) value)))
    ;--------------------------------------------------------------------
    ; Store the cache information
    ;--------------------------------------------------------------------
    (putpropqq CCSgetCdfForCell 
               (make_CCScellCdfCache ?cdf cdf ?savedCDF savedCDF
                                    ?cdfgForm setCdfgForm)
               cache)
    cdf
    ))

/****************************************************************
*                                                               *
*                    (CCSgetCachedCdfgForm)                     *
*                                                               *
* If ?setCdfgForm t was passed to CCSgetCdfForCell then retrieve*
*       the effective lookalike cdfgForm from the cache         *
*                                                               *
****************************************************************/

(procedure (CCSgetCachedCdfgForm)
  (let ((cache (getqq CCSgetCdfForCell cache)))
    (getq cache cdfgForm)))

/****************************************************************
*                                                               *
*                      (CCSrestoreCellCdf)                      *
*                                                               *
*  Clean up the effective cell CDF and restore values back to   *
* what they were before you messed with it. Doesn't do anything *
*       if the effective lookalike CDF was used instead.        *
*                                                               *
****************************************************************/

(procedure (CCSrestoreCellCdf)
   (letseq (
            (cache (getqq CCSgetCdfForCell cache))
            (cdf (getq cache cdf))
            (savedCDF (getq cache savedCDF))
            )
     (when savedCDF
       ;---------------------------------------------------------------
       ; Restore everything back
       ;---------------------------------------------------------------
       (foreach param (getq cdf parameters)
                (putpropq 
                  param
                  (arrayref savedCDF (getq param name))
                  value))
       )
     (putpropqq CCSgetCdfForCell nil cache)
     cdf
     ))

/***************************************************************
*                                                              *
*              (CCSconvertCdfToPcellParams cdf)                *
*                                                              *
* Take modified parameters in the CDF, and return this as the  *
*      list of parameter names, types, and values that is      *
*       needed to create a pcell with dbCreateParamInst.       *
*                                                              *
***************************************************************/

(procedure (CCSconvertCdfToPcellParams cdf)
  (foreach mapcar param
           (setof par (getq cdf parameters) 
                  (nequal (getq par value) (getq par defValue)))
           (list
             (getq param name)
             ; need to map this to pcell parameter types...
             (case (getq param paramType)
               (("int" "boolean" "float" "string") (getq param paramType))
               (t "string")
               )
             (getq param value)
             )
           )
  )

/***************************************************************
*                                                              *
*       (CCSinvokeCdfCallbacks cellView @key (debug nil)       *
*      (callInitProc nil) (useInstCDF nil) (useCellCDF t)      *
*    (addFormFields nil)) (setCdfgForm nil) (filterFunc nil)   *
*                                                              *
*  Invoke the CDF callbacks for all instances in the cellView. *
*  Returns nil if any callback had a SKILL error, otherwise t  *
*                                                              *
***************************************************************/

(procedure (CCSinvokeCdfCallbacks cellView @key (debug nil) 
                                 (order nil)
                                 (callInitProc nil) (useInstCDF nil)
                                 (useCellCDF t) (setCdfgForm nil) 
                                 (addFormFields nil)
                                 (filterFunc nil))
  (let ((success t))
       (when debug
             (printf "Invoking callbacks for all instances in cell '%s'\n"
                     (dbGetq cellView cellName)))
       (foreach instance (dbGetq cellView instances)
                (unless
                 (CCSinvokeInstCdfCallbacks instance 
                                           ?debug debug
                                           ?order order
                                           ?callInitProc callInitProc
                                           ?useInstCDF useInstCDF
                                           ?useCellCDF useCellCDF
                                           ?setCdfgForm setCdfgForm
                                           ?addFormFields addFormFields
                                           ?filterFunc filterFunc
                                           )
                 (setq success nil)
                 )
                ) ; foreach
       success
       )
  ) ; procedure


