

`uvm_analysis_imp_decl(_ingr)
`uvm_analysis_imp_decl(_egrs)


class scoreboard extends  uvm_scoreboard;

`uvm_component_utils(scoreboard)


function new(string name="scoreboard", uvm_component parent = null);
	super.new(name,parent);
endfunction



uvm_analysis_imp_ingr #(input_seq_it, scoreboard) driver_imp_monitor;
uvm_analysis_imp_egrs #(out_seq_it,scoreboard) dut_imp_monitor;


out_seq_it driver_monitor_q[$];

input_seq_it 			inp_seq;
uvm_event 				in_scb_event;
common_config  			com_cnfig;
out_seq_it 				exp_out_seq;


int match, mismatch, inp_glbl_cnt, ap_pp_driver_mntr_cnt;


virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);

driver_imp_monitor = new("driver_imp_monitor",this);
dut_imp_monitor = new("dut_imp_monitor",this);

in_scb_event = uvm_event_pool::get_global("in_scb_event");

uvm_config_db#(common_config)::get(this, "*", "com_cnfg",com_cnfig );

	
endfunction

//write function to push data in queue
//it is calulated outputvalues like golden output

virtual function void write_ingr(input_seq_it inp_item);
out_seq_it out_item = new();

out_item.x = inp_item.a + inp_item.b;
out_item.y = inp_item.a + inp_item.b + inp_item.c;

driver_monitor_q.push_back(out_item);
ap_pp_driver_mntr_cnt++;
//in_scb_event.trigger();
	
endfunction

// jo output hum ny yaha generate ki hy jo kh=eh hmari golden output hy
// os ko pop kiya or then out_seq_it wali output ky sath compare kiya
// match or mismach a jayngy

virtual function void write_egrs(out_seq_it out_item);
if(driver_monitor_q.size() == 0) 
	`uvm_error("SCB", $sformatf("data not present"))
else
	exp_out_seq = driver_monitor_q.pop_front();

if(out_item.compare(exp_out_seq))
	match++;
else begin
	mismatch++;

end
	
endfunction


// 

virtual task main_phase(uvm_phase phase);
	
super.main_phase(phase);
wait(com_cnfig.num_packets == match+mismatch);
in_scb_event.trigger();
endtask 

virtual function void report_phase(uvm_phase phase);
`uvm_info("SCB", $sformatf("Packets matches = %0d, mismatch = %0d",match,mismatch),UVM_MEDIUM)
	
endfunction 


virtual function void display_mismatch_packets(out_seq_it exp_out_seq, out_seq_it out_item );
string msg;

msg = $sformatf("\n================================================================================\n");
msg = {msg, $sformatf("Mismatch packets: Exp x = %0d; Actual x = %0d Exp y = %0d; Actual y = %0d;",exp_out_seq.x, out_item.x, exp_out_seq.y, out_item.y)};
msg = $sformatf("\n================================================================================\n");


`uvm_error("mismatch packets",msg)

	
endfunction




	
endclass : scoreboard