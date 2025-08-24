class out_agent extends  uvm_agent;

	`uvm_component_utils(out_agent)

function  new(string name = "out_agent", uvm_component parent = null);
	super.new(name, parent);

endfunction 


out_monitor   out_mntr;


virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);

out_mntr = out_monitor::type_id::create("out_mntr",this);
	
endfunction 
virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction

	
endclass 