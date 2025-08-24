class inp_sequence extends  uvm_sequence #(input_seq_it);

function new(string name = "inp_sequence");
	super.new();
endfunction : new


`uvm_object_utils(inp_sequence)

design_sequence des_sequence;
common_config   com_cnfig;   


//get common config

virtual task pre_start();
if(!uvm_config_db#(common_config)::get(get_sequencer(),"","com_cnfg", com_cnfig))
	`uvm_fatal("inp_sequence","Did not get common_config")
endtask


virtual task body();

`uvm_info("inp_sequence", $sformatf("Starting design_seq for %0d packets..",com_cnfig.num_packets),UVM_MEDIUM)

des_sequence = design_sequence::type_id::create("des_sequence");
des_sequence.inp_packets = com_cnfig.num_packets;
des_sequence.start(get_sequencer());
`uvm_info("inp_sequence", $sformatf("des_sequence done.."),UVM_MEDIUM)

	
endtask : body


	
endclass : inp_sequence