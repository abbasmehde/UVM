class design_base_test extends  uvm_test;
	
`uvm_component_utils(design_base_test)


function new(string name= "design_base_test", uvm_component parent = null);
	super.new(name, parent);
	
endfunction 


design_env 			env;
common_config 		com_cnfg;
design_config 		des_cnfg;
virtual design_in_intf      inp_intf;


virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
	
	com_cnfg = common_config::type_id::create("com_cnfg", this);
	des_cnfg = design_config::type_id::create("des_cnfg", this);

	uvm_config_db#(common_config)::set(null, "*", "com_cnfg",com_cnfg );
	uvm_config_db#(design_config)::set(null, "*", "des_cnfg", des_cnfg );

	env = design_env::type_id::create("env", this);

if(!uvm_config_db#(virtual design_in_intf)::get(this, "", "design_in_intf", inp_intf))
	`uvm_fatal("TEST", "Input interferance is not founded")


endfunction 


virtual task reset_phase(uvm_phase phase);
phase.raise_objection(this);
`uvm_info("design_base_test", $sformatf("Started reset phase..."),UVM_MEDIUM)
super.reset_phase(phase);
vif_init_zero();
repeat (100) @(posedge inp_intf.clk);
phase.drop_objection(this);
	
endtask //reset_phase

task vif_init_zero();
inp_intf.a     <=0 ; 
inp_intf.b     <=0 ;
inp_intf.c     <=0 ;
inp_intf.valid <=0 ;	

endtask

endclass 