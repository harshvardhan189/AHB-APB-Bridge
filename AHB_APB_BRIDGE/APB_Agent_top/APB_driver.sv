/************************************************************************************
/////////////////////////////////////////////////////////////////////////////////////
									APB DRIVER 
/////////////////////////////////////////////////////////////////////////////////////
************************************************************************************/

class APB_driver extends uvm_driver #(APB_xtn);

	`uvm_component_utils(APB_driver)
	
	virtual APB_if.APB_DRV_MP Pvif;
	APB_config Pcfg;
	//bit [31:0] temp;

	function new(string name = "APB_driver", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db #(APB_config)::get(this,"","APB_config",Pcfg))
			`uvm_fatal("CONFIG","Can't get config from APB Driver")
		super.build_phase(phase);
	endfunction

	function void connect_phase(uvm_phase phase);
		Pvif=Pcfg.Pvif;
	endfunction
	
	task run_phase(uvm_phase phase);
		forever 
			drive();
	endtask

	task drive();
	//	APB_xtn req;
	//	req = APB_xtn::type_id::create("req");
	//	std::randomize(temp);
	//	req.Prdata = temp;

		while(Pvif.APB_DRV_CB.Pselx == 0)
			@(Pvif.APB_DRV_CB);

		if(Pvif.APB_DRV_CB.Pwrite == 0)
			Pvif.APB_DRV_CB.Prdata <= $random; //temp

		else
			Pvif.APB_DRV_CB.Prdata <= 'bx;

		repeat(2)
			@(Pvif.APB_DRV_CB);
			
//		`uvm_info("APB_DRIVER",$sformatf("data from apb driver \n %s",req.sprint()),UVM_LOW)

	endtask

endclass
