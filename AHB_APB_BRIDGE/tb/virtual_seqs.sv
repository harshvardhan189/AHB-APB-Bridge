
/************************************************************************************
/////////////////////////////////////////////////////////////////////////////////////
									VIRTUAL SEQUENCE 
/////////////////////////////////////////////////////////////////////////////////////
************************************************************************************/

class virtual_base_seqs extends uvm_sequence #(uvm_sequence_item);

	`uvm_object_utils(virtual_base_seqs)

	virtual_sequencer vseqrh;
	
	Hsingle_write_seq Hsingle_write_seq_h;
	
	Hincr4_write_seq Hincr4_write_seq_h;
	
	Hincr8_write_seq Hincr8_write_seq_h;
	
	Hincr16_write_seq Hincr16_write_seq_h;
	
	Hwrap4_write_seq Hwrap4_write_seq_h;
	
	Hwrap8_write_seq Hwrap8_write_seq_h;
	
	Hwrap16_write_seq Hwrap16_write_seq_h;

	Hidle_write_seq Hidle_write_seq_h;

	Hincr_write_seq Hincr_write_seq_h;

	AHB_sequencer Hseqrh;
	bridge_config cfg;

	function new (string name = "virtual_base_seqs");
		super.new(name);
	endfunction

	task body();
		if(!uvm_config_db #(bridge_config)::get(null,get_full_name(),"bridge_config",cfg))
			`uvm_fatal("CONFIG","can't get config from virtual sequence")

		assert($cast(vseqrh,m_sequencer))
		
		else
		`uvm_error("CAST","CASTING FAILED")

		Hseqrh = vseqrh.Hseqrh;
	endtask
endclass


//------------------Vsingle_write_seq-----------------//

class Vsingle_write_seq extends virtual_base_seqs;

	`uvm_object_utils(Vsingle_write_seq)

	function new(string name = "Vsingle_write_seq");
		super.new(name);
	endfunction

	task body();
		super.body;
		
		Hsingle_write_seq_h = Hsingle_write_seq::type_id::create("Hsingle_write_seqh");
		Hsingle_write_seq_h.start(Hseqrh);
		#90;
	endtask
endclass


//-----------------Vincr_write_seq------------------//

class Vincr_write_seq extends virtual_base_seqs;

	`uvm_object_utils(Vincr_write_seq)

	function new(string name = "Vincr_write_seq");
		super.new(name);
	endfunction

	task body();
		super.body;
		
		Hincr_write_seq_h = Hincr_write_seq::type_id::create("Hincr_write_seqh");
		Hincr_write_seq_h.start(Hseqrh);
		#100;
	endtask
endclass



//-----------------Vincr4_write_seq------------------//

class Vincr4_write_seq extends virtual_base_seqs;

	`uvm_object_utils(Vincr4_write_seq)

	function new(string name = "Vincr4_write_seq");
		super.new(name);
	endfunction

	task body();
		super.body;
		
		Hincr4_write_seq_h = Hincr4_write_seq::type_id::create("Hincr4_write_seqh");
		Hincr4_write_seq_h.start(Hseqrh);
		#30;
	endtask
endclass

//-----------------Vincr8_write_seq------------------//

class Vincr8_write_seq extends virtual_base_seqs;

	`uvm_object_utils(Vincr8_write_seq)

	function new(string name = "Vincr8_write_seq");
		super.new(name);
	endfunction

	task body();
		super.body;
		
		Hincr8_write_seq_h = Hincr8_write_seq::type_id::create("Hincr8_write_seqh");
		Hincr8_write_seq_h.start(Hseqrh);
		#100;
	endtask
endclass


//-----------------Vincr16_write_seq------------------//

class Vincr16_write_seq extends virtual_base_seqs;

	`uvm_object_utils(Vincr16_write_seq)

	function new(string name = "Vincr16_write_seq");
		super.new(name);
	endfunction

	task body();
		super.body;
		
		Hincr16_write_seq_h = Hincr16_write_seq::type_id::create("Hincr16_write_seqh");
		Hincr16_write_seq_h.start(Hseqrh);
		#100;
	endtask
endclass


//-----------------Vwrap4_write_seq------------------//

class Vwrap4_write_seq extends virtual_base_seqs;

	`uvm_object_utils(Vwrap4_write_seq)

	function new(string name = "Vwrap4_write_seq");
		super.new(name);
	endfunction

	task body();
		super.body;
		
		Hwrap4_write_seq_h = Hwrap4_write_seq::type_id::create("Hwrap4_write_seqh");
		Hwrap4_write_seq_h.start(Hseqrh);
		#100;
	endtask
endclass


//-----------------Vwrap8_write_seq------------------//

class Vwrap8_write_seq extends virtual_base_seqs;

	`uvm_object_utils(Vwrap8_write_seq)

	function new(string name = "Vwrap8_write_seq");
		super.new(name);
	endfunction

	task body();
		super.body;
		
		Hwrap8_write_seq_h = Hwrap8_write_seq::type_id::create("Hwrap8_write_seqh");
		Hwrap8_write_seq_h.start(Hseqrh);
		#100;
	endtask
endclass


//-----------------Vwrap8_write_seq------------------//

class Vwrap16_write_seq extends virtual_base_seqs;

	`uvm_object_utils(Vwrap16_write_seq)

	function new(string name = "Vwrap16_write_seq");
		super.new(name);
	endfunction

	task body();
		super.body;
		
		Hwrap16_write_seq_h = Hwrap16_write_seq::type_id::create("Hwrap16_write_seqh");
		Hwrap16_write_seq_h.start(Hseqrh);
		#100;
	endtask
endclass

//------------------Vidle_write_seq-----------------//

class Vidle_write_seq extends virtual_base_seqs;

	`uvm_object_utils(Vidle_write_seq)

	function new(string name = "Vidle_write_seq");
		super.new(name);
	endfunction

	task body();
		super.body;
		
		Hidle_write_seq_h = Hidle_write_seq::type_id::create("Hidle_write_seqh");
		Hidle_write_seq_h.start(Hseqrh);
		#100;
	endtask
endclass

