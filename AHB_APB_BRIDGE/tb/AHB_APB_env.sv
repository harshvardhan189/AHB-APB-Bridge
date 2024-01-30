
/************************************************************************************
/////////////////////////////////////////////////////////////////////////////////////
								AHB	APB BRIDGE ENV  
/////////////////////////////////////////////////////////////////////////////////////
************************************************************************************/

class AHB_APB_env extends uvm_env;
	
	`uvm_component_utils(AHB_APB_env)
	
	bridge_config cfg;

	APB_agent_top Pagnth;
	AHB_agent_top Hagnth;

	virtual_sequencer vseqrh;
	scoreboard sb;

	function new(string name = "AHB_APB_env", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db #(bridge_config)::get(this,"","bridge_config",cfg))
			`uvm_fatal("CONFIG","can't get config from ENV")

		if(cfg.has_AHB_agent_top == 1)
			Hagnth = AHB_agent_top::type_id::create("Hagnth",this);

		if(cfg.has_APB_agent_top == 1)
			Pagnth = APB_agent_top::type_id::create("Pagnth",this);
			
		if(cfg.has_virtual_sequencer == 1)
			vseqrh = virtual_sequencer::type_id::create("vseqrh",this);

		if(cfg.has_scoreboard == 1)
			sb = scoreboard::type_id::create("sb",this);
		
		super.build_phase(phase);
	endfunction

	
	function void connect_phase(uvm_phase phase);
		
		if(cfg.has_APB_agent_top)
			vseqrh.Pseqrh = Pagnth.agnth.seqrh;
		
		if(cfg.has_AHB_agent_top)
			vseqrh.Hseqrh = Hagnth.agnth.seqrh;


		if(cfg.has_scoreboard)
			begin
				Hagnth.agnth.monh.mport.connect(sb.Hfifo.analysis_export);
				Pagnth.agnth.monh.mport.connect(sb.Pfifo.analysis_export);
			end
	endfunction
endclass
