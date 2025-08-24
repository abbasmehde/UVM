

class common_config extends  uvm_component;

	uvm_cmdline_processor clp = uvm_cmdline_processor::get_inst();

	function new(string name = "common_config", uvm_component parent = null);
		super.new(name,parent);
		
	endfunction
	
	int 	num_packets					;
	time 	watchdog_timer  			;
	
	
	
	function void build_phase(uvm_phase phase);
		string arg_val;
	
		if(clp.get_arg_value("+num_packets=",arg_val)) num_packets = arg_val.atoi();
		if(clp.get_arg_value("+watchdog_timer=",arg_val)) watchdog_timer = arg_val.atoi()*100000;
	
	
	endfunction

	`uvm_component_utils_begin(common_config)
	`uvm_field_int(num_packets,UVM_DEC)
	`uvm_field_int(watchdog_timer,UVM_DEC)
	`uvm_component_utils_end
	
endclass //common_config