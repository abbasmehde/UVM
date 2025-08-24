

class design_config extends  uvm_component;
	
	uvm_cmdline_processor clp = uvm_cmdline_processor::get_inst();
	
	function new(string name= "design_config", uvm_component parent= null);
		super.new(name,parent);
	endfunction
	
	
	int 	config_1								;
	int 	config_2								;
	int 	min_a								;
	int 	max_a								;
	int 	min_b								;
	int 	max_b								;
	int 	min_c								;
	int 	max_c								;
	
	function void build_phase(uvm_phase phase);
	
		string arg_val;
		
		if(clp.get_arg_value("+min_a=",arg_val)) min_a = arg_val.atoi();
		if(clp.get_arg_value("+max_a=",arg_val)) max_a = arg_val.atoi();
		if(clp.get_arg_value("+min_b=",arg_val)) min_b = arg_val.atoi();
		if(clp.get_arg_value("+max_b=",arg_val)) max_b = arg_val.atoi();
		if(clp.get_arg_value("+min_c=",arg_val)) min_c = arg_val.atoi();
		if(clp.get_arg_value("+max_c=",arg_val)) max_c = arg_val.atoi();
	
	
		
	endfunction 
	
	
	`uvm_component_utils_begin(design_config)
	`uvm_field_int(config_1,UVM_DEC)
	`uvm_field_int(config_2,UVM_DEC)
	`uvm_component_utils_end
	
	function void post_randomize();
	
		string arg_val;
		super.post_randomize();
		
		if(clp.get_arg_value("+config_1=",arg_val)) config_1 = arg_val.atoi();
		if(clp.get_arg_value("+config_2=",arg_val)) config_2 = arg_val.atoi();	
	
	endfunction 

endclass // design_config