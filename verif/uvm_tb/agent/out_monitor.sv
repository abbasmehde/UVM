class out_monitor extends  uvm_monitor;
	
`uvm_component_utils(out_monitor)

function  new(string name = "out_monitor", uvm_component parent = null);
	super.new(name, parent);

endfunction //new


uvm_analysis_port#(out_seq_it) mon_analysis_port;

virtual design_out_intf des_intf;
out_seq_it              out_itm;


virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);

if(!uvm_config_db#(virtual design_out_intf)::get(this, "", "design_out_intf", des_intf))
	`uvm_fatal("out_monitor","design output interface not found");
//out_itm = out_seq_it::type_id::create("out_itm",this);

mon_analysis_port = new("mon_analysis_port",this);

	
endfunction

virtual task main_phase(uvm_phase phase);
super.main_phase(phase);
fork 
	collect_data();
join_none
	
endtask //main_phase


task collect_data;
  forever begin
    @(posedge des_intf.clk);

    if (des_intf.valid) begin
      // create a new object per packet
      out_seq_it out_itm_local = out_seq_it::type_id::create("OUTPUT monitor Pkt", this);
      out_itm_local.x = des_intf.x;
      out_itm_local.y = des_intf.y;
      mon_analysis_port.write(out_itm_local);
      `uvm_info("OUT_MON", $sformatf("Captured output: x=%0h y=%0h", out_itm_local.x, out_itm_local.y), UVM_LOW)
    end
  end
endtask


endclass 