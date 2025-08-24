class design_env extends  uvm_env;
	
`uvm_component_utils(design_env)


function new(string name = "design_env", uvm_component parent = null);
	super.new(name,parent);
	
endfunction


inp_agent 		inp_agnt;
out_agent		out_agnt;
scoreboard		scrbd;
time 			wd_timer;
common_config 	com_cnfg;
uvm_event		in_scb_event;



virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);

inp_agnt = inp_agent::type_id::create("inp_agnt",this);
out_agnt = out_agent::type_id::create("out_agnt",this);
scrbd    = scoreboard::type_id::create("scrbd",this);
in_scb_event = uvm_event_pool::get_global("in_scb_event");

uvm_config_db#(common_config)::get(this, "*", "com_cnfg", com_cnfg );
uvm_config_db#(uvm_object_wrapper)::set(this, "inp_agnt.sqncr.main_phase", "default_sequence", inp_sequence::type_id::get());


endfunction


//connection phase

virtual function void connect_phase(uvm_phase phase);

super.connect_phase(phase);

inp_agnt.inp_mntr.mon_analysis_port.connect(scrbd.driver_imp_monitor);
out_agnt.out_mntr.mon_analysis_port.connect(scrbd.dut_imp_monitor);

endfunction


virtual task main_phase(uvm_phase phase);

phase.raise_objection(this);
`uvm_info("design_env", "Start main phase.....", UVM_MEDIUM)
super.main_phase(phase);
wd_timer = com_cnfg.watchdog_timer;
`uvm_info("CHECK", $sformatf("Final watchdog_timer = %0d", wd_timer), UVM_LOW)


fork
	begin
		#wd_timer;
		`uvm_error("design_env", $sformatf("wd_time Time out"))

	end
	begin
		in_scb_event.wait_trigger();
		#500
		`uvm_info("design_env","scoreboard verification complete....",UVM_MEDIUM)

	end
join_any
`uvm_info("design_env", "main phase done....",UVM_MEDIUM)
phase.drop_objection(this);
	
endtask //main_phase


endclass 