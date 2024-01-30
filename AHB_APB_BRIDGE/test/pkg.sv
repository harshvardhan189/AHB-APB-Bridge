
/************************************************************************************
/////////////////////////////////////////////////////////////////////////////////////
								AHB	APB BRIDGE PKG  
/////////////////////////////////////////////////////////////////////////////////////
************************************************************************************/

package pkg;

//import uvm_pkg.sv
	import uvm_pkg::*;
//include uvm_macros.sv
	`include "uvm_macros.svh"
`include "AHB_xtn.sv"
`include "APB_config.sv"
`include "AHB_config.sv"
`include "bridge_config.sv"
`include "AHB_driver.sv"
`include "AHB_monitor.sv"
`include "AHB_sequencer.sv"
`include "AHB_agent.sv"
`include "AHB_agent_top.sv"
`include "AHB_sequence.sv"

`include "APB_xtn.sv"
`include "APB_monitor.sv"
`include "APB_sequencer.sv"
//`include "APB_sequence.sv"
`include "APB_driver.sv"
`include "APB_agent.sv"
`include "APB_agent_top.sv"

`include "virtual_sequencer.sv"
`include "virtual_seqs.sv"
`include "scoreboard.sv"

`include "AHB_APB_env.sv"


`include "bridge_test.sv"

	
endpackage
