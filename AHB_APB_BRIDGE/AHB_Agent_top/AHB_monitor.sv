/************************************************************************************
/////////////////////////////////////////////////////////////////////////////////////
									AHB MONITOR 
/////////////////////////////////////////////////////////////////////////////////////
************************************************************************************/

class AHB_monitor extends uvm_monitor;
	
	`uvm_component_utils (AHB_monitor)

	virtual AHB_if.AHB_MON_MP Hvif;
	AHB_config Hcfg;

	uvm_analysis_port #(AHB_xtn)mport;

	function new(string name = "AHB_monitor", uvm_component parent);
		super.new(name,parent);
		mport = new("mport",this); 
	endfunction

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db #(AHB_config)::get(this,"","AHB_config",Hcfg))
			`uvm_fatal("CONFIG","Can't get config from AHB Monitor")
		super.build_phase(phase);
	endfunction

	function void connect_phase(uvm_phase phase);
		Hvif=Hcfg.Hvif;
	endfunction

	task run_phase(uvm_phase phase);
	
	while(Hvif.AHB_MON_CB.Hreadyout !==1)
			@(Hvif.AHB_MON_CB);

		//`uvm_info("AHB_MONITOR","out of while 1",UVM_LOW)
		forever 
			collect_data();
	endtask

	task collect_data();
		AHB_xtn xtn;
		xtn = AHB_xtn::type_id::create("xtn");
		
		while(Hvif.AHB_MON_CB.Htrans !==2 && Hvif.AHB_MON_CB.Htrans !==3 && Hvif.AHB_MON_CB.Htrans !==0)
			@(Hvif.AHB_MON_CB);
		//`uvm_info("AHB_MONITOR","out of while 2",UVM_LOW)

		xtn.Hwrite = Hvif.AHB_MON_CB.Hwrite;
		xtn.Haddr = Hvif.AHB_MON_CB.Haddr;
		xtn.Hsize = Hvif.AHB_MON_CB.Hsize;
		xtn.Htrans = Hvif.AHB_MON_CB.Htrans;

		@(Hvif.AHB_MON_CB);

		while(Hvif.AHB_MON_CB.Hreadyout !==1)
			@(Hvif.AHB_MON_CB);
		//`uvm_info("AHB_MONITOR","out of while 3",UVM_LOW)

		if(xtn.Hwrite == 1)
			xtn.Hwdata = Hvif.AHB_MON_CB.Hwdata;

		else
			xtn.Hrdata = Hvif.AHB_MON_CB.Hrdata;
			
		`uvm_info("AHB_MONITOR",$sformatf("data from ahb monitor \n %s",xtn.sprint()),UVM_LOW)

		mport.write(xtn);

	endtask


endclass
