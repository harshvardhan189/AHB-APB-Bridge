
/************************************************************************************
/////////////////////////////////////////////////////////////////////////////////////
								AHB	APB BRIDGE CONFIG  
/////////////////////////////////////////////////////////////////////////////////////
************************************************************************************/

class bridge_config extends uvm_object;

	`uvm_object_utils(bridge_config)

	function new(string name = "bridge_config");
		super.new(name);
	endfunction

	bit has_virtual_sequencer = 1;
	bit has_scoreboard = 1;
	bit has_APB_agent_top = 1;
	bit has_AHB_agent_top = 1;

	AHB_config Hcfg;
	APB_config Pcfg;

endclass
