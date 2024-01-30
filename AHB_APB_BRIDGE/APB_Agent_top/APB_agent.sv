/************************************************************************************
/////////////////////////////////////////////////////////////////////////////////////
									APB AGENT 
/////////////////////////////////////////////////////////////////////////////////////
************************************************************************************/
class APB_agent extends uvm_agent;

	`uvm_component_utils(APB_agent)
	
	APB_driver drvh;
	APB_sequencer seqrh;
	APB_monitor monh;

	APB_config Pcfg;

	function new(string name = "APB_agent", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db #(APB_config)::get(this,"","APB_config",Pcfg))
			`uvm_fatal("CONFIG","Can't get config from APB AGENT")
		super.build_phase(phase);

		monh = APB_monitor::type_id::create("monh",this);

		if(Pcfg.is_active == UVM_ACTIVE)
			begin
			drvh = APB_driver::type_id::create("drvh",this);
			seqrh = APB_sequencer::type_id::create("seqrh",this);
			end
	endfunction

	function void connect_phase(uvm_phase phase);
		if(Pcfg.is_active == UVM_ACTIVE)
			drvh.seq_item_port.connect(seqrh.seq_item_export);
	endfunction
endclass
