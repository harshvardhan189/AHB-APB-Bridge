/************************************************************************************
/////////////////////////////////////////////////////////////////////////////////////
									APB CONFIG 
/////////////////////////////////////////////////////////////////////////////////////
************************************************************************************/

class APB_config extends uvm_object;

	`uvm_object_utils(APB_config)

	function new(string name = "APB_config");
	super.new(name);
	endfunction

	virtual APB_if  Pvif;

	uvm_active_passive_enum is_active = UVM_ACTIVE;

	static int drv_sent_xtn_cnt = 0;
	static int mon_rcvd_xtn_cnt = 0;

endclass
