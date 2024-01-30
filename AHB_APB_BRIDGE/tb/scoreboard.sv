/************************************************************************************
/////////////////////////////////////////////////////////////////////////////////////
								AHB	APB BRIDGE SCOREBOARD  
/////////////////////////////////////////////////////////////////////////////////////
************************************************************************************/

class scoreboard extends uvm_scoreboard;

	`uvm_component_utils(scoreboard)

	uvm_tlm_analysis_fifo #(AHB_xtn) Hfifo;
	uvm_tlm_analysis_fifo #(APB_xtn) Pfifo;

	AHB_xtn Hxtn;
	APB_xtn Pxtn;

	function new(string name = "scoreboard", uvm_component parent);
		super.new(name,parent);
		Hfifo = new("Hfifo",this); 
		Pfifo = new("Pfifo",this); 
		coverage = new;
	endfunction

//	function void build_phase(string name = "scoreboard", uvm_component parent);
//		super.build_phase(phase);
//	endfunction

	covergroup coverage;
			
		HADDR:   coverpoint Hxtn.Haddr[31:0]{bins ADDR = {[32'h8000_0000 : 32'h8000_03ff],
					 			   						 	[32'h8400_0000 : 32'h8400_03ff],
								   						 	[32'h8800_0000 : 32'h8800_03ff],
								   						 	[32'h8c00_0000 : 32'h8c00_03ff]};}

		HTRANS:    coverpoint Hxtn.Htrans[1:0]{bins T1 = {2'b10,2'b11} ; ignore_bins T2 = {2'b00,2'b01};}

		HSIZE:    coverpoint Hxtn.Hsize[2:0]{bins S1 = {0,1,2}; 
											 ignore_bins illegal_S = {3,4,5,6,7};}

		PSELX: 	   coverpoint Pxtn.Pselx[3:0]{bins P1 = {1,2,4,8}; 
										      ignore_bins illegal = {0,3,5,6,7,9,10,11,12,13,14,15};}

		PADDR:    coverpoint Pxtn.Paddr[31:0]{bins A1 = {[32'h8000_0000 : 32'h8000_03ff],
					 			   						 [32'h8400_0000 : 32'h8400_03ff],
								   						 [32'h8800_0000 : 32'h8800_03ff],
								   						 [32'h8c00_0000 : 32'h8c00_03ff]};}

		PWRITE:  coverpoint Pxtn.Pwrite;
		
		HWRITE:  coverpoint Hxtn.Hwrite;

		HWDATA:  coverpoint Hxtn.Hwdata{option.auto_bin_max  = 4;}

		PWDATA:  coverpoint Pxtn.Pwdata{option.auto_bin_max  = 4;}

		CROSS:   cross HTRANS,HSIZE,HWRITE;
		
		
	endgroup

	
	task run_phase(uvm_phase phase);
	forever
		begin
		Hfifo.get(Hxtn);
	//	`uvm_info("SCOREBOARD",$sformatf(" AHB XTN GET \n%s",Hxtn.sprint()),UVM_LOW)
		Pfifo.get(Pxtn);
	//	`uvm_info("SCOREBOARD",$sformatf(" APB XTN GET \n%s",Pxtn.sprint()),UVM_LOW)

		sb_compare();
		
		coverage.sample();
		end
	endtask

	task sb_compare();

/////////////////// WRITING //////////////////////
		if(Hxtn.Hwrite)
		begin
		`uvm_info("SCOREBOARD","---------- WRITING -----------",UVM_LOW)
		
			if(Hxtn.Haddr == Pxtn.Paddr)
			begin
			`uvm_info("SCOREBOARD","WRITE ADDRESS compared successfully",UVM_LOW)
				
				if(Hxtn.Hsize == 0)
				begin
				`uvm_info("SCOREBOARD","Hsize is 0 ",UVM_LOW)
					case(Hxtn.Haddr[1:0])
					2'b00 : if(Hxtn.Hwdata[7:0] == Pxtn.Pwdata[7:0])
							`uvm_info("SCOREBOARD","WRITE DATA compared successfully",UVM_LOW)
							else
							`uvm_error("SCOREBOARD","WRITE DATA DID'T MATCH")
					2'b01 : if(Hxtn.Hwdata[15:8] == Pxtn.Pwdata[7:0])
							`uvm_info("SCOREBOARD","WRITE DATA compared successfully",UVM_LOW)
							else
							`uvm_error("SCOREBOARD","WRITE DATA DID'T MATCH")
					2'b10 : if(Hxtn.Hwdata[23:16] == Pxtn.Pwdata[7:0])
							`uvm_info("SCOREBOARD","WRITE DATA compared successfully",UVM_LOW)
							else
							`uvm_error("SCOREBOARD","WRITE DATA DID'T MATCH")
					2'b11 : if(Hxtn.Hwdata[31:24] == Pxtn.Pwdata[7:0])
							`uvm_info("SCOREBOARD","WRITE DATA compared successfully",UVM_LOW)
							else
							`uvm_error("SCOREBOARD","WRITE DATA DID'T MATCH")
					endcase
				end

					

				else if(Hxtn.Hsize == 1)
				begin
				`uvm_info("SCOREBOARD","Hsize is 1 ",UVM_LOW)
					case(Hxtn.Haddr[1:0])
					2'b00 : if(Hxtn.Hwdata[15:0] == Pxtn.Pwdata[15:0])
							`uvm_info("SCOREBOARD","WRITE DATA compared successfully",UVM_LOW)
							else
							`uvm_error("SCOREBOARD","WRITE DATA DID'T MATCH")
					2'b10 : if(Hxtn.Hwdata[31:16] == Pxtn.Pwdata[15:0])
							`uvm_info("SCOREBOARD","WRITE DATA compared successfully",UVM_LOW)
							else
							`uvm_error("SCOREBOARD","WRITE DATA DID'T MATCH")
					endcase
				end

				else if(Hxtn.Hsize == 2)
				begin
				`uvm_info("SCOREBOARD","Hsize is 2 ",UVM_LOW)
					case(Hxtn.Haddr[1:0])
					2'b00 : if(Hxtn.Hwdata[31:0] == Pxtn.Pwdata[31:0])
							`uvm_info("SCOREBOARD","WRITE DATA compared successfully",UVM_LOW)
							else
							`uvm_error("SCOREBOARD","WRITE DATA DID'T MATCH")
					endcase
				end
				
				else
					`uvm_error("SCOREBOARD","HSIZE IS OUT OF BOUND VALUE")	
			end
		end
		
////////////////////// READING /////////////////////////////
		
		else
		begin
			`uvm_info("SCOREBOARD","------------- READING -----------",UVM_LOW)
		
			if(Hxtn.Haddr == Pxtn.Paddr)
			begin
			`uvm_info("SCOREBOARD","READ ADDRESS compared successfully",UVM_LOW)
				
				if(Hxtn.Hsize == 0)
				begin
				`uvm_info("SCOREBOARD","Hsize is 0 ",UVM_LOW)
					case(Hxtn.Haddr[1:0])
					2'b00 : if(Hxtn.Hrdata[7:0] == Pxtn.Prdata[7:0])
							`uvm_info("SCOREBOARD","READ DATA compared successfully",UVM_LOW)
							else
							`uvm_error("SCOREBOARD","READ DATA DID'T MATCH")
					2'b01 : if(Hxtn.Hrdata[7:0] == Pxtn.Prdata[15:8])
							`uvm_info("SCOREBOARD","READ DATA compared successfully",UVM_LOW)
							else
							`uvm_error("SCOREBOARD","READ DATA DID'T MATCH")
					2'b10 : if(Hxtn.Hrdata[7:0] == Pxtn.Prdata[23:16])
							`uvm_info("SCOREBOARD","READ DATA compared successfully",UVM_LOW)
							else
							`uvm_error("SCOREBOARD","READ DATA DID'T MATCH")
					2'b11 : if(Hxtn.Hrdata[7:0] == Pxtn.Prdata[31:24])
							`uvm_info("SCOREBOARD","READ DATA compared successfully",UVM_LOW)
							else
							`uvm_error("SCOREBOARD","READ DATA DID'T MATCH")
					endcase
				end

					

				else if(Hxtn.Hsize == 1)
				begin
				`uvm_info("SCOREBOARD","Hsize is 1 ",UVM_LOW)
					case(Hxtn.Haddr[1:0])
					2'b00 : if(Hxtn.Hrdata[15:0] == Pxtn.Prdata[15:0])
							`uvm_info("SCOREBOARD","READ DATA compared successfully",UVM_LOW)
							else
							`uvm_error("SCOREBOARD","READ DATA DID'T MATCH")
					2'b10 : if(Hxtn.Hrdata[15:0] == Pxtn.Prdata[31:16])
							`uvm_info("SCOREBOARD","READ DATA compared successfully",UVM_LOW)
							else
							`uvm_error("SCOREBOARD","READ DATA DID'T MATCH")
					endcase
				end

				else if(Hxtn.Hsize == 2)
				begin
				`uvm_info("SCOREBOARD","Hsize is 2 ",UVM_LOW)
					case(Hxtn.Haddr[1:0])
					2'b00 : if(Hxtn.Hrdata[31:0] == Pxtn.Prdata[31:0])
							`uvm_info("SCOREBOARD","READ DATA compared successfully",UVM_LOW)
							else
							`uvm_error("SCOREBOARD","READ DATA DID'T MATCH")
					endcase
				end
				
				else
					`uvm_error("SCOREBOARD","HSIZE IS OUT OF BOUND VALUE")	
			end
		end
	
		
	endtask

endclass
