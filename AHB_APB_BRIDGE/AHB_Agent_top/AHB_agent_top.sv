/************************************************************************************
/////////////////////////////////////////////////////////////////////////////////////
									AHB AGENT TOP 
/////////////////////////////////////////////////////////////////////////////////////
************************************************************************************/

class AHB_agent_top extends uvm_env;

	`uvm_component_utils(AHB_agent_top)
	
	AHB_agent agnth;
	AHB_config Hcfg;
	bridge_config cfg;

	function new(string name = "AHB_agent_top",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db #(bridge_config)::get(this,"","bridge_config",cfg))
			`uvm_fatal("CONFIG","can't get config form AHB agent top")

		
		super.build_phase(phase);
		agnth = AHB_agent::type_id::create("agnth",this);
		uvm_config_db #(AHB_config)::set(this,"*","AHB_config",cfg.Hcfg);
	endfunction


endclass
