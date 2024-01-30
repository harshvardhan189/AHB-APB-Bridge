/************************************************************************************
/////////////////////////////////////////////////////////////////////////////////////
									APB AGENT TOP 
/////////////////////////////////////////////////////////////////////////////////////
************************************************************************************/

class APB_agent_top extends uvm_env;

	`uvm_component_utils(APB_agent_top)
	
	APB_agent agnth;
	APB_config Pcfg;
	bridge_config cfg;

	function new(string name = "APB_agent_top",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db #(bridge_config)::get(this,"","bridge_config",cfg))
			`uvm_fatal("CONFIG","can't get config form AHB agent top")
	
		super.build_phase(phase);
		agnth = APB_agent::type_id::create("agnth",this);

		uvm_config_db #(APB_config)::set(this,"*","APB_config",cfg.Pcfg);
		
	
	endfunction


endclass
