/************************************************************************************
/////////////////////////////////////////////////////////////////////////////////////
								AHB	APB BRIDGE VIRTUAL SEQUENCER  
/////////////////////////////////////////////////////////////////////////////////////
************************************************************************************/

class virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);
	
		`uvm_component_utils(virtual_sequencer)

		AHB_sequencer Hseqrh;
		APB_sequencer Pseqrh;

		//bridge_config cfg;

		function new(string name = "virtual_sequencer",uvm_component parent);
			super.new(name, parent);
		endfunction

endclass
