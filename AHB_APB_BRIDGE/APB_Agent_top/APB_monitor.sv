/************************************************************************************
/////////////////////////////////////////////////////////////////////////////////////
									APB MONITOR 
/////////////////////////////////////////////////////////////////////////////////////
************************************************************************************/

class APB_monitor extends uvm_monitor;
	
	`uvm_component_utils (APB_monitor)

	virtual APB_if.APB_MON_MP Pvif;
	APB_config Pcfg;

	uvm_analysis_port #(APB_xtn)mport;

	function new(string name = "APB_monitor", uvm_component parent);
		super.new(name,parent);
		mport = new("mport",this); 
	endfunction

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db #(APB_config)::get(this,"","APB_config",Pcfg))
			`uvm_fatal("CONFIG","Can't get config from APB Monitor")
		super.build_phase(phase);
	endfunction

	function void connect_phase(uvm_phase phase);
		Pvif=Pcfg.Pvif;
	endfunction

	task run_phase(uvm_phase phase);
		
		forever 
			collect_data();
	endtask

	task collect_data();
		
		APB_xtn xtn;
		xtn = APB_xtn::type_id::create("xtn");

		while(Pvif.APB_MON_CB.Penable !== 1)
			@(Pvif.APB_MON_CB);

		xtn.Paddr = Pvif.APB_MON_CB.Paddr;
		xtn.Pwrite = Pvif.APB_MON_CB.Pwrite;
		xtn.Pselx = Pvif.APB_MON_CB.Pselx;
			//@(Pvif.APB_MON_CB);

		if(xtn.Pwrite == 1)
			xtn.Pwdata = Pvif.APB_MON_CB.Pwdata;

		else
			xtn.Prdata = Pvif.APB_MON_CB.Prdata;
			
			@(Pvif.APB_MON_CB);
			
		`uvm_info("APB_MONITOR",$sformatf("data from apb monitor \n %s",xtn.sprint()),UVM_LOW)
		
		mport.write(xtn);
		
		endtask


endclass
