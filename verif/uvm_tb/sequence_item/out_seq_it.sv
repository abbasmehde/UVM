

class out_seq_it extends  uvm_sequence_item;
	
function new(string name = "out_seq_it");
	super.new(name);
endfunction

bit    					[9-1:0] x;
bit    					[9-1:0] y;
design_config 			des_cnfig;


`uvm_object_utils_begin(out_seq_it)
`uvm_field_int(x, UVM_ALL_ON)
`uvm_field_int(y, UVM_ALL_ON)
`uvm_object_utils_end


function out_seq_it clone;
	out_seq_it p;
	$cast(p,super.clone());
	return p;
endfunction


virtual function void display_design(string name);
string msg;

msg = $sformatf("\n This is beging displayed from %s \n",name);
msg = {msg, $sformatf("=============================================================================\n",)};
msg = {msg, $sformatf("X = %h, Y = %h \n",x,y)};

`uvm_info(name,msg,UVM_MEDIUM)
endfunction

endclass