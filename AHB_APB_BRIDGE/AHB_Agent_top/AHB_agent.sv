/************************************************************************************
/////////////////////////////////////////////////////////////////////////////////////
									AHB AGENT 
/////////////////////////////////////////////////////////////////////////////////////
************************************************************************************/
class AHB_agent extends uvm_agent;

	`uvm_component_utils(AHB_agent)
	
	AHB_driver drvh;
	AHB_sequencer seqrh;
	AHB_monitor monh;

	AHB_config Hcfg;

	function new(string name = "AHB_agent", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db #(AHB_config)::get(this,"","AHB_config",Hcfg))
			`uvm_fatal("CONFIG","Can't get config from AHB AGENT")
		super.build_phase(phase);

		monh = AHB_monitor::type_id::create("monh",this);

		if(Hcfg.is_active == UVM_ACTIVE)
			begin
			drvh = AHB_driver::type_id::create("drvh",this);
			seqrh = AHB_sequencer::type_id::create("seqrh",this);
			end
	endfunction

	function void connect_phase(uvm_phase phase);
		if(Hcfg.is_active == UVM_ACTIVE)
			drvh.seq_item_port.connect(seqrh.seq_item_export);
	endfunction
endclass
