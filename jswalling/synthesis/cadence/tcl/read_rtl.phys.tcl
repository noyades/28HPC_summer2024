
set rtlList "\
${rtlDir}/Discrete_FIR_Filter_1.v \
"
#set rtlList "\
#${rtlDir}/FIR_Filter_M.v \
#${rtlDir}/Discrete_FIR_Filter_1.v \
#${rtlDir}/Discrete_FIR_Filter_2.v \
#${rtlDir}/Discrete_FIR_Filter_3.v \
#${rtlDir}/Discrete_FIR_Filter_4.v \
#${rtlDir}/Discrete_FIR_Filter_5.v \
#${rtlDir}/Discrete_FIR_Filter_6.v \
#${rtlDir}/Discrete_FIR_Filter_7.v \
#${rtlDir}/Discrete_FIR_Filter_8.v \
#"

set_db hdl_preserve_unused_registers true

read_hdl $rtlList
