/************************************************************************************
/////////////////////////////////////////////////////////////////////////////////////
									AHB DRIVER 
/////////////////////////////////////////////////////////////////////////////////////
************************************************************************************/

class AHB_driver extends uvm_driver #(AHB_xtn);

	`uvm_component_utils(AHB_driver)
	
	virtual AHB_if.AHB_DRV_MP Hvif;
	AHB_config Hcfg;

	function new(string name = "AHB_driver", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db #(AHB_config)::get(this,"","AHB_config",Hcfg))
			`uvm_fatal("CONFIG","Can't get config from AHB Driver")
		super.build_phase(phase);
	endfunction

	function void connect_phase(uvm_phase phase);
		Hvif=Hcfg.Hvif;
	endfunction

	task run_phase(uvm_phase phase);
	
	@(Hvif.AHB_DRV_CB);
	Hvif.AHB_DRV_CB.Hresetn <= 0;
	@(Hvif.AHB_DRV_CB);
	@(Hvif.AHB_DRV_CB);
	Hvif.AHB_DRV_CB.Hresetn <= 1;

	while(Hvif.AHB_DRV_CB.Hreadyout !==1)
		@(Hvif.AHB_DRV_CB);

	forever
		begin
			seq_item_port.get_next_item(req);
			drive(req);
			seq_item_port.item_done();
		end

	endtask

	task drive(AHB_xtn xtn);
		
		//`uvm_info("AHB_DRIVER",$sformatf("data from ahb driver \n %s",req.sprint()),UVM_LOW)
		
		Hvif.AHB_DRV_CB.Haddr <= xtn.Haddr;
		Hvif.AHB_DRV_CB.Htrans <= xtn.Htrans;
		Hvif.AHB_DRV_CB.Hsize <= xtn.Hsize;
		Hvif.AHB_DRV_CB.Hreadyin <= 1'b1;
		Hvif.AHB_DRV_CB.Hwrite <= xtn.Hwrite;
		@(Hvif.AHB_DRV_CB);

		while(Hvif.AHB_DRV_CB.Hreadyout !==1)
		@(Hvif.AHB_DRV_CB);

		Hvif.AHB_DRV_CB.Hwdata <= xtn.Hwdata;
		
	endtask


		

endclass
