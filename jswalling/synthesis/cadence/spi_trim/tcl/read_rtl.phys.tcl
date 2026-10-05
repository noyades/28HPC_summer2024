set rtlList "\
${rtlDir}/topPLLDigital.v \
${rtlDir}/spi_slave_pll.v \
${rtlDir}/fifo_pll.v \
${rtlDir}/fifo_miso.v \
${rtlDir}/register_bank_pll.v \
${rtlDir}/clkDiv.v \
${rtlDir}/two_bit_counter.v \
${rtlDir}/mash111.v \
${rtlDir}/Memory43b.v \
"

set_db hdl_preserve_unused_registers true

read_hdl $rtlList
