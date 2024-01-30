
/************************************************************************************
/////////////////////////////////////////////////////////////////////////////////////
				 AHB INTERFACE  
/////////////////////////////////////////////////////////////////////////////////////
************************************************************************************/

interface AHB_if(input bit Hclk);
	
	logic 		Hresetn;
    logic [1:0] Htrans;
	logic [2:0] Hsize; 
	logic 		Hreadyin;
	logic [31:0]Hwdata; 
	logic [31:0]Haddr;
	logic 		Hwrite;
    logic [31:0]Hrdata;
	logic [1:0] Hresp;
	logic 		Hreadyout;

	// AHB DRIVER CLOCKING BLOCK
	clocking AHB_DRV_CB @(posedge Hclk);
		default  input #1  output #1;
		
		output Hresetn;
    	output Htrans;
		output Hsize; 
		output Hreadyin;
		output Hwdata; 
		output Haddr;
		output Hwrite;
		
		input Hrdata;
		input Hresp;
		input Hreadyout;


	endclocking

	
	// AHB MONITOR CLOCKING BLOCK
	clocking AHB_MON_CB @(posedge Hclk);
		default  input #1  output #1;
		
		
		input Hresetn;
    	input Htrans;
		input Hsize; 
		input Hreadyin;
		input Hwdata; 
		input Haddr;
		input Hwrite;
		
		input Hrdata;
		input Hresp;
		input Hreadyout;	
		
	endclocking

	modport AHB_DRV_MP(clocking AHB_DRV_CB);
	modport AHB_MON_MP(clocking AHB_MON_CB);

endinterface
