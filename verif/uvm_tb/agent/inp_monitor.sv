class inp_monitor extends  uvm_monitor;
	

`uvm_component_utils(inp_monitor)

function  new(string name = "inp_monitor", uvm_component parent = null);
	super.new(name, parent);

endfunction


uvm_analysis_port#(input_seq_it) mon_analysis_port;

virtual design_in_intf 		des_inf;
input_seq_it		inp_itm;


virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);

if(!uvm_config_db#(virtual design_in_intf)::get(this, "", "design_in_intf", des_inf ))
	`uvm_fatal("inp_monitor","design interface is not found");

///inp_itm = input_seq_it::type_id::create("inp_itm", this);
mon_analysis_port = new("mon_analysis_port",this);
	
endfunction


virtual task main_phase(uvm_phase phase);
super.main_phase(phase);
collect_data();
	
endtask : main_phase

task collect_data;
  forever begin
    // sample only at posedge so we're synchronized with driver
    @(posedge des_inf.clk);

    if (des_inf.valid) begin
      input_seq_it inp_itm_local = input_seq_it::type_id::create("INP monitor pkt", this);
      inp_itm_local.a = des_inf.a;
      inp_itm_local.b = des_inf.b;
      inp_itm_local.c = des_inf.c;
      mon_analysis_port.write(inp_itm_local);
      `uvm_info("INP_MON", $sformatf("Captured input: a=%0h b=%0h c=%0h", inp_itm_local.a, inp_itm_local.b, inp_itm_local.c), UVM_LOW)
    end
    // then loop to next posedge
  end
endtask


endclass //inp_monitor