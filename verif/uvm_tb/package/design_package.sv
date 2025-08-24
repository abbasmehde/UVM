package design_package;
	
`include "uvm_macros.svh"
import uvm_pkg::*;



//config

`include "common_config.sv";
`include "design_config.sv";


//sequence items

`include "input_seq_it.sv";
`include "out_seq_it.sv";

//driver
`include "inp_driver.sv"

//monitor
`include "inp_monitor.sv";
`include "out_monitor.sv";


//agent

`include "inp_agent.sv";
`include "out_agent.sv";




//scoreboard

`include "scoreboard.sv";

//sequence

`include "design_sequence.sv";
`include "inp_sequence.sv";


//env

`include "design_env.sv";


//test

`include "design_base_test.sv"
`include "../short_test/test.sv"


endpackage