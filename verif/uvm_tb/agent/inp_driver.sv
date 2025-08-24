class inp_driver extends  uvm_driver#(input_seq_it);
	
`uvm_component_utils(inp_driver)

function  new(string name = "inp_driver", uvm_component parent = null);
	super.new(name, parent);
endfunction


virtual design_in_intf 		in_intfc;
input_seq_it		inp_itm;


virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);

inp_itm = input_seq_it::type_id::create("inp_itm",this);
if(!uvm_config_db#(virtual design_in_intf)::get(this, "", "design_in_intf", in_intfc ))
`uvm_fatal("inp_driver","inputer interface not found")

endfunction 


virtual task main_phase(uvm_phase phase);
super.main_phase(phase);

forever begin
	seq_item_port.get_next_item(inp_itm);
	drive_item(inp_itm);
	seq_item_port.item_done();
end
	
endtask : main_phase



virtual task drive_item(input_seq_it drve_inpt);
  // Wait for rising edge, then assert valid and drive data (hold for one cycle)
  @(posedge in_intfc.clk);
  in_intfc.valid <= 1;
  in_intfc.a     <= drve_inpt.a;
  in_intfc.b     <= drve_inpt.b;
  in_intfc.c     <= drve_inpt.c;

  // hold for one clock so monitor (which samples at posedge) can see it
  @(posedge in_intfc.clk);
  in_intfc.valid <= '0;
  in_intfc.a     <= '0;
  in_intfc.b     <= '0;
  in_intfc.c     <= '0;
endtask



endclass 