
/************************************************************************************
/////////////////////////////////////////////////////////////////////////////////////
								APB	INTERFACE  
/////////////////////////////////////////////////////////////////////////////////////
************************************************************************************/

interface APB_if(input bit Hclk);


           logic [31:0]Pselx;
		   logic Pwrite;
		   logic Penable; 
		   logic [31:0] Paddr;
		   logic [31:0] Pwdata;
	 	   logic [31:0]Prdata;

	clocking APB_DRV_CB @(posedge Hclk);
		default  input #1  output #1;
	
           input Pselx;
		   input Pwrite;
		   input Penable; 
		   input Paddr;
		   input Pwdata;
	 	  
		   output  Prdata;

	endclocking

	
	// AHB MONITOR CLOCKING BLOCK
	clocking APB_MON_CB @(posedge Hclk);
		default  input #1  output #1;
		
		input Pselx;
		input Pwrite;
        input Penable;
        input Paddr;
        input Pwdata;
        
		input Prdata;
			
	endclocking


	modport APB_DRV_MP(clocking APB_DRV_CB);
	modport APB_MON_MP(clocking APB_MON_CB);

endinterface
