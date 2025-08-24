

class design_sequence extends  uvm_sequence #(input_seq_it);
	
function new(string name = "design_sequence");
	super.new(name);
endfunction

`uvm_object_utils(design_sequence)

input_seq_it 			input_seq 			;
design_config 			des_cnfig 		;

int 					inp_packets		;
int 					i 				;


virtual task pre_start();
	if(!uvm_config_db#(design_config)::get( get_sequencer(),"", "des_cnfg",des_cnfig ))
		`uvm_fatal("design_sequence","Did not get design_sequence..")


endtask : pre_start

virtual task body();

input_seq = input_seq_it::type_id::create("input");

`uvm_info("Design Sequence", $sformatf("Generating packets = %0d",inp_packets),UVM_MEDIUM)

for(i=0; i<inp_packets; i++) begin
	
	start_item(input_seq);
	input_seq.a = $urandom_range(des_cnfig.min_a,des_cnfig.max_a);
	input_seq.b = $urandom_range(des_cnfig.min_b,des_cnfig.max_b);
	input_seq.c = $urandom_range(des_cnfig.min_c,des_cnfig.max_c);

	finish_item(input_seq);

end

`uvm_info("design_sequence", $sformatf("Done generated of %0d packet items",i),UVM_MEDIUM)

	
endtask : body















endclass : design_sequence