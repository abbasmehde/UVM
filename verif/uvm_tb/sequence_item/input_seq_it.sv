class input_seq_it extends  uvm_sequence_item;


function new(string name = "input");
		super.new(name);
	endfunction



rand bit		[7-1:0]a;
rand bit		[7-1:0]b;
rand bit		[7-1:0]c; 

design_config    des_cnfig;


`uvm_object_utils_begin(input_seq_it)
`uvm_field_int(a, UVM_ALL_ON|UVM_NOCOMPARE)
`uvm_field_int(b, UVM_ALL_ON|UVM_NOCOMPARE)
`uvm_field_int(c, UVM_ALL_ON|UVM_NOCOMPARE)
`uvm_object_utils_end


function input_seq_it clone;
	input_seq_it p;
	$cast(p,super.clone());
	return p;

endfunction




















endclass : input_seq_it