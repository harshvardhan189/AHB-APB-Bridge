
/************************************************************************************
/////////////////////////////////////////////////////////////////////////////////////
								AHB	APB BRIDGE TOP  
/////////////////////////////////////////////////////////////////////////////////////
************************************************************************************/

module top;
	
	import uvm_pkg::*;
	import pkg::*;
  	
	bit Hclk;
	always #10 Hclk = !Hclk;

	AHB_if Hif(Hclk);
	APB_if Pif(Hclk);
	


 rtl_top DUT(.Hclk(Hclk),
             .Hresetn(Hif.Hresetn),
             .Htrans(Hif.Htrans),
		   	 .Hsize(Hif.Hsize), 
		   	 .Hreadyin(Hif.Hreadyin),
		   	 .Hwdata(Hif.Hwdata), 
		   	 .Haddr(Hif.Haddr),
		   	 .Hwrite(Hif.Hwrite),
           	 .Prdata(Pif.Prdata),
		     .Hrdata(Hif.Hrdata),
		     .Hresp(Hif.Hresp),
		     .Hreadyout(Hif.Hreadyout),
		     .Pselx(Pif.Pselx),
		     .Pwrite(Pif.Pwrite),
		     .Penable(Pif.Penable), 
		     .Paddr(Pif.Paddr),
		     .Pwdata(Pif.Pwdata));	

	initial
	begin
			`ifdef VCS
         		$fsdbDumpvars(0, top);
				`endif
		uvm_config_db #(virtual AHB_if)::set(null,"*","Hvif",Hif);
		uvm_config_db #(virtual APB_if)::set(null,"*","Pvif",Pif);

		run_test();
	end
endmodule
