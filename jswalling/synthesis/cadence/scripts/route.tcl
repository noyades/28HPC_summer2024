set_multi_cpu_usage -local_cpu 16

enable_metric -on
push_snapshot_stack

set_db delaycal_enable_si true

set_db route_design_detail_use_multi_cut_via_effort high
set_db route_detail fix_antenna true
set_db route_design_antenna_diode_insertion true
set_db route_design_antenna_cell_name ANTENNA

set_db add_fillers_cells {{} {FILLSGCAP128_A9PP140ZTL_C30 \
FILLSGCAP16_A9PP140ZTL_C30 FILLSGCAP2_A9PP140ZTL_C30 \
FILLSGCAP32_A9PP140ZTL_C30 FILLSGCAP3_A9PP140ZTL_C30 \
FILLSGCAP4_A9PP140ZTL_C30 FILLSGCAP64_A9PP140ZTL_C30 \
FILLSGCAP8_A9PP140ZTL_C30} \
{FILL8_A9PP140ZTL_C30 FILL64_A9PP140ZTL_C30 \
FILL4_A9PP140ZTL_C30 FILL3_A9PP140ZTL_C30 \
FILL32_A9PP140ZTL_C30 FILL2_A9PP140ZTL_C30 \
FILL1_A9PP140ZTL_C30 FILL16_A9PP140ZTL_C30 \
FILL128_A9PP140ZTL_C30}} 
set_db add_fillers_prefix FILL
add_fillers

set_route_attributes -nets * -bottom_preferred_routing_layer 1
set_route_attributes -nets * -top_preferred_routing_layer 6
set_db route_design_bottom_routing_layer 1
set_db route_design_top_routing_layer 6

set_db route_design_detail_post_route_spread_wire false

set_db delaycal_equivalent_waveform_model propagation
set_db delaycal_ewm_type simulation
route_design

set_db extract_rc_engine post_route
set_db extract_rc_effort_level high

pop_snapshot_stack
enable_metric
create_snapshot -name route -categories "power check design flow hold route clock setup"

write_db DBS/route.dat
write_netlist DBS/LEC/route.v.gz
report_threshold_instance_count -area

set top_cell [get_db designs .name]
report_metric -format vivid -out_file RPT/${top_cell}_metric.html
write_metric -format json -out_file RPT/${top_cell}_metric.json
