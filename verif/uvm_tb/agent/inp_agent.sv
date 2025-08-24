class inp_agent extends  uvm_agent;

`uvm_component_utils(inp_agent)

function  new(string name = "inp_agent", uvm_component parent = null);
	super.new(name, parent);
	
endfunction 



inp_monitor    					inp_mntr;
inp_driver	   					inp_drvr;
uvm_sequencer #(input_seq_it)	sqncr;

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);

inp_mntr = inp_monitor::type_id::create("inp_mntr",this);
inp_drvr = inp_driver::type_id::create("inp_drvr",this);

sqncr   = uvm_sequencer#(input_seq_it)::type_id::create("sqncr",this);
	
endfunction


virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);

inp_drvr.seq_item_port.connect(sqncr.seq_item_export);
	
endfunction


	
endclass : inp_agent