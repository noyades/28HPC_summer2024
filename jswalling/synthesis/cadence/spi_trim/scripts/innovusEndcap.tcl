
globalNetConnect VDD -type pgpin -pin VDD -inst * -verbose
globalNetConnect VSS -type pgpin -pin VSS -inst * -verbose
globalNetConnect VDD -type net -net VDD -verbose
globalNetConnect VSS -type net -net VSS -verbose
globalNetConnect VPW_P -type net -net VDD -verbose
globalNetConnect VNW_N -type net -net VSS -verbose

setEndCapMode -reset
set CELL_PREFIX UDBSLT28
setEndCapMode -rightEdge ${CELL_PREFIX}_CAPR9_1 -leftEdge ${CELL_PREFIX}_CAPL9_1 -topEdge ${CELL_PREFIX}_CAPT_1 -bottomEdge ${CELL_PREFIX}_CAPB_1 -rightTopCorner ${CELL_PREFIX}_CAPTOUCR9_1 -rightBottomCorner ${CELL_PREFIX}_CAPBOUCR9_1 -leftTopCorner ${CELL_PREFIX}_CAPTOUCL9_1 -leftBottomCorner ${CELL_PREFIX}_CAPBOUCL9_1
addEndCap -prefix ENDCAP

addWellTap -cell ${CELL_PREFIX}_TAPPN_DN -cellInterval 23 -inRowOffset 18 -prefix WELLTAP
