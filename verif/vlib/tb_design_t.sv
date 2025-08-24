module tb_design_t;
	
	import uvm_pkg ::*;
	import design_package::*;
	
	
	
	bit clk = 0;
	
	
	
	design_in_intf   inp_intf(.clk(clk));
	design_out_intf	 out_intf(.clk(clk));
	
	
	
	
	design_t design_inst(
	
		.clk(clk),
		.a  (inp_intf.a),
		.b  (inp_intf.b),
		.c  (inp_intf.c),
		.in_valid (inp_intf.valid),
		.x  (out_intf.x),
		.y  (out_intf.y),
		.out_valid(out_intf.valid)
	
	
	
	
		);
	
	
	
	
	initial begin
	    // Pass virtual interfaces to the driver & monitor
	    uvm_config_db#(virtual design_in_intf)::set(null, "uvm_test_top.env.inp_agnt.inp_drvr", "design_in_intf", inp_intf);
	    uvm_config_db#(virtual design_in_intf)::set(null, "uvm_test_top.env.inp_agnt.inp_mntr", "design_in_intf", inp_intf);
	    uvm_config_db#(virtual design_out_intf)::set(null, "uvm_test_top.env.out_agnt.out_mntr", "design_out_intf", out_intf);
	
	    // Optional: Pass global interface to top test (if needed)
	    uvm_config_db#(virtual design_in_intf)::set(null, "uvm_test_top", "design_in_intf", inp_intf);
	
	    run_test();
	end
	
	
always begin
		#5 clk = ~clk;
	end
		

endmodule 