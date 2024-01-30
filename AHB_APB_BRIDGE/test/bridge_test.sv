
/************************************************************************************
/////////////////////////////////////////////////////////////////////////////////////
								AHB	APB BRIDGE TEST  
/////////////////////////////////////////////////////////////////////////////////////
************************************************************************************/

class bridge_test extends uvm_test;

	`uvm_component_utils(bridge_test);

	function new (string name ="bridge_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	AHB_APB_env envh;
	bridge_config cfg;

	AHB_config Hcfg;
	APB_config Pcfg;

	function void config_bridge();
		
		Hcfg = AHB_config::type_id::create("Hcfg");
		if(!uvm_config_db #(virtual AHB_if)::get(this,"","Hvif",Hcfg.Hvif))
			`uvm_fatal("CONFIG","can't get virtual interface from test ")
		Hcfg.is_active = UVM_ACTIVE;
		cfg.Hcfg = Hcfg;

		Pcfg = APB_config::type_id::create("Pcfg");
		if(!uvm_config_db #(virtual APB_if)::get(this,"","Pvif",Pcfg.Pvif))
			`uvm_fatal("CONFIG","can't get virtual interface from test ")
		
		Pcfg.is_active = UVM_ACTIVE;
		cfg.Pcfg = Pcfg;

	endfunction

	function void build_phase(uvm_phase phase);
		
		cfg = bridge_config::type_id::create("cfg");
		

		uvm_config_db #(bridge_config)::set(this,"*","bridge_config",cfg);
		config_bridge();
		super.build_phase(phase);

		envh = AHB_APB_env::type_id::create("envh",this);

	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology;
	endfunction
endclass


//------------------single_write_seq_test--------------------//

class single_write_seq_test extends bridge_test;

	`uvm_component_utils(single_write_seq_test)

	Vsingle_write_seq Vsingle_write_seq_h; 

	function new(string name = "single_write_seq_test", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		Vsingle_write_seq_h = Vsingle_write_seq::type_id::create("Vsingle_write_seq_h");
		Vsingle_write_seq_h.start(envh.vseqrh);
		phase.drop_objection(this);
	endtask

endclass


//------------------incr_write_seq_test--------------------//

class incr_write_seq_test extends bridge_test;

	`uvm_component_utils(incr_write_seq_test)

	Vincr_write_seq Vincr_write_seq_h; 

	function new(string name = "incr_write_seq_test", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		Vincr_write_seq_h = Vincr_write_seq::type_id::create("Vincr_write_seq_h");
		Vincr_write_seq_h.start(envh.vseqrh);
		phase.drop_objection(this);
	endtask

endclass



//------------------incr4_write_seq_test--------------------//

class incr4_write_seq_test extends bridge_test;

	`uvm_component_utils(incr4_write_seq_test)

	Vincr4_write_seq Vincr4_write_seq_h; 

	function new(string name = "incr4_write_seq_test", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		Vincr4_write_seq_h = Vincr4_write_seq::type_id::create("Vincr4_write_seq_h");
		Vincr4_write_seq_h.start(envh.vseqrh);
		phase.drop_objection(this);
	endtask

endclass


//------------------incr8_write_seq_test--------------------//

class incr8_write_seq_test extends bridge_test;

	`uvm_component_utils(incr8_write_seq_test)

	Vincr8_write_seq Vincr8_write_seq_h; 

	function new(string name = "incr8_write_seq_test", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		Vincr8_write_seq_h = Vincr8_write_seq::type_id::create("Vincr8_write_seq_h");
		Vincr8_write_seq_h.start(envh.vseqrh);
		phase.drop_objection(this);
	endtask

endclass


//------------------incr16_write_seq_test--------------------//
class incr16_write_seq_test extends bridge_test;

	`uvm_component_utils(incr16_write_seq_test)

	Vincr16_write_seq Vincr16_write_seq_h; 

	function new(string name = "incr16_write_seq_test", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		Vincr16_write_seq_h = Vincr16_write_seq::type_id::create("Vincr16_write_seq_h");
		Vincr16_write_seq_h.start(envh.vseqrh);
		phase.drop_objection(this);
	endtask

endclass


//------------------wrap4_write_seq_test--------------------//

class wrap4_write_seq_test extends bridge_test;

	`uvm_component_utils(wrap4_write_seq_test)

	Vwrap4_write_seq Vwrap4_write_seq_h; 

	function new(string name = "wrap4_write_seq_test", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		Vwrap4_write_seq_h = Vwrap4_write_seq::type_id::create("Vwrap4_write_seq_h");
		Vwrap4_write_seq_h.start(envh.vseqrh);
		phase.drop_objection(this);
	endtask

endclass


//------------------wrap8_write_seq_test--------------------//

class wrap8_write_seq_test extends bridge_test;

	`uvm_component_utils(wrap8_write_seq_test)

	Vwrap8_write_seq Vwrap8_write_seq_h; 

	function new(string name = "wrap8_write_seq_test", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		Vwrap8_write_seq_h = Vwrap8_write_seq::type_id::create("Vwrap8_write_seq_h");
		Vwrap8_write_seq_h.start(envh.vseqrh);
		phase.drop_objection(this);
	endtask

endclass


//------------------wrap16_write_seq_test--------------------//

class wrap16_write_seq_test extends bridge_test;

	`uvm_component_utils(wrap16_write_seq_test)

	Vwrap16_write_seq Vwrap16_write_seq_h; 

	function new(string name = "wrap16_write_seq_test", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		Vwrap16_write_seq_h = Vwrap16_write_seq::type_id::create("Vwrap16_write_seq_h");
		Vwrap16_write_seq_h.start(envh.vseqrh);
		phase.drop_objection(this);
	endtask

endclass


//------------------idle_write_seq_test--------------------//

class idle_write_seq_test extends bridge_test;

	`uvm_component_utils(idle_write_seq_test)

	Vidle_write_seq Vidle_write_seq_h; 

	function new(string name = "idle_write_seq_test", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		Vidle_write_seq_h = Vidle_write_seq::type_id::create("Vidle_write_seq_h");
		Vidle_write_seq_h.start(envh.vseqrh);
		phase.drop_objection(this);
	endtask

endclass

