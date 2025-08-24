

class short_test extends design_base_test ;
	
`uvm_component_utils(short_test)



function new(string name= "short_test", uvm_component parent = null);
super.new(name, parent);
endfunction



function void build_phase(uvm_phase phase);
super.build_phase(phase);

`uvm_info("short_test","starting of short test..", UVM_MEDIUM)
endfunction

endclass 