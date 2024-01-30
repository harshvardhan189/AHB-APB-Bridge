
/************************************************************************************
/////////////////////////////////////////////////////////////////////////////////////
									AHB XTN 
/////////////////////////////////////////////////////////////////////////////////////
************************************************************************************/

class AHB_xtn extends uvm_sequence_item;
	
	`uvm_object_utils(AHB_xtn)

	rand bit [31:0] Hwdata;
	rand bit [31:0] Haddr;
	rand bit [1:0]  Htrans;
	rand bit [2:0]  Hsize;
	rand bit [2:0]  Hburst;
	rand bit 	    Hwrite;
	rand bit [4:0]  burst_len;

		 bit [31:0] Hrdata;
		 bit [1:0]  Hresp;
	
	function new(string name = "AHB_xtn");
		super.new(name);
	endfunction

//---------------- CONSTRAINTS -------------------//
	constraint SIZE {Hsize inside {0,1,2};}
	
	constraint ADDR {if(Hsize == 1) Haddr[0] == 0;
					 if(Hsize == 2) Haddr[1:0] == 2'b00;
					 Haddr inside {[32'h8000_0000 : 32'h8000_03ff],
					 			   [32'h8400_0000 : 32'h8400_03ff],
								   [32'h8800_0000 : 32'h8800_03ff],
								   [32'h8c00_0000 : 32'h8c00_03ff]};}
	
	constraint BURST_LEN{(Hburst == 0) -> (burst_len == 1);
						 (Hburst == 2) || (Hburst == 3) -> (burst_len == 4);
						 (Hburst == 4) || (Hburst == 5) -> (burst_len == 8);
						 (Hburst == 6) || (Hburst == 7) -> (burst_len == 16);}

	constraint INCR_BURST{(Haddr%1024)+ (burst_len*2**Hsize) <= 1024;}


//---------------- DO PRINT ------------------//

	function void do_print(uvm_printer printer); 
		
		super.do_print(printer);
		
		printer.print_field("Haddr"  	 , this.Haddr     	  , 32 , UVM_HEX);
		printer.print_field("Hwdata" 	 , this.Hwdata    	  , 32 , UVM_HEX);
		printer.print_field("Hrdata" 	 , this.Hrdata    	  , 32 , UVM_HEX);
		printer.print_field("Hsize"  	 , this.Hsize     	  , 3  , UVM_HEX);
		printer.print_field("Htrans" 	 , this.Htrans    	  , 2  , UVM_HEX);
		printer.print_field("Hburst" 	 , this.Hburst    	  , 3  , UVM_HEX);
		printer.print_field("Hwrite" 	 , this.Hwrite    	  , 1  , UVM_HEX);
		printer.print_field("Hresp"  	 , this.Hresp     	  , 2  , UVM_HEX);
		printer.print_field("burst_len"  , this.burst_len     , 5  , UVM_HEX);
	
	endfunction

endclass


/*
SPLIT and RETRY responses are used by AMBA 2 AHB slaves which require a large number of cycles to complete a transfer. These responses allow a   data phase transfer to appear completed to avoid stalling the bus, but at the same time indicate that the transfer should be re-attempted when   the master is next granted the bus.

The difference between them is that a SPLIT response tells the AHB Arbiter to give priority to all other masters until the SPLIT transfer can be completed (effectively ignoring all further requests from this master until the SPLIT slave indicates it can complete the SPLIT transfer),       whereas the RETRY response only tells the AHB Arbiter to give priority to higher priority masters.

A SPLIT response is more complicated to implement than a RETRY, but has the advantage that it allows the maximum efficiency to be made of the bus bandwidth.

The master behaviour is identical to both SPLIT and RETRY responses, the master has to cancel the next access and re-attempt the current failed  access.

SPLIT and RETRY responses are not supported in AMBA 3 AHB-lite or AMBA 5 AHB based designs as these only support one master.

*/
