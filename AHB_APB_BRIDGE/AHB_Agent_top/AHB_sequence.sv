
/************************************************************************************
/////////////////////////////////////////////////////////////////////////////////////
									AHB SEQUENCE 
/////////////////////////////////////////////////////////////////////////////////////
************************************************************************************/

class AHB_base_sequence extends uvm_sequence #(AHB_xtn);

	`uvm_object_utils(AHB_base_sequence)

	function new(string name = "AHB_sequence");
		super.new(name);
	endfunction

endclass


//--------------Hsingle_write_seq----------------//

class Hsingle_write_seq extends AHB_base_sequence;

	`uvm_object_utils(Hsingle_write_seq)

	function new(string name = "Hsingle_write_seq");
		super.new(name);
	endfunction

	task body();
		req = AHB_xtn::type_id::create("req");
		begin
		start_item(req);
		assert(req.randomize() with {Htrans == 2; Hburst == 0 ;})
		finish_item(req);
		end
	endtask

endclass


//--------------Hincr4_write_seq----------------//

class Hincr4_write_seq extends AHB_base_sequence;

	`uvm_object_utils(Hincr4_write_seq)

	int sz;
	int wr;
	int addr;

	function new(string name = "Hincr4_write_seq");
		super.new(name);
	endfunction

	task body();
		req = AHB_xtn::type_id::create("req");
		
		start_item(req);
		assert(req.randomize() with {Htrans == 2; Hburst == 3;})
		finish_item(req);

		sz = req.Hsize;
		wr = req.Hwrite;
		addr = req.Haddr;

		for(int i=0 ; i<3 ; i++)
		begin
			start_item(req);
			assert(req.randomize() with {Htrans == 3; Hburst == 3 ; Hsize == sz; Haddr == (addr + 2**sz); Hwrite == wr;})	
			addr = req.Haddr;
			finish_item(req);
		end
		
		start_item(req);
		assert(req.randomize() with {Htrans == 0;})
		finish_item(req);


	endtask

endclass

//--------------Hincr8_write_seq----------------//

class Hincr8_write_seq extends AHB_base_sequence;

	`uvm_object_utils(Hincr8_write_seq)

	int sz;
	int wr;
	int addr;

	function new(string name = "Hincr8_write_seq");
		super.new(name);
	endfunction

	task body();
		req = AHB_xtn::type_id::create("req");
		
		start_item(req);
		assert(req.randomize() with {Htrans == 2; Hburst == 5;})
		finish_item(req);

		sz = req.Hsize;
		wr = req.Hwrite;
		addr = req.Haddr;

		for(int i=0 ; i<7 ; i++)
		begin
			start_item(req);
			assert(req.randomize() with {Htrans == 3; Hburst == 5 ; Hsize == sz; Haddr == (addr + 2**sz); Hwrite == wr;})	
			addr = req.Haddr;
			finish_item(req);
		end
		
		start_item(req);
		assert(req.randomize() with {Htrans == 0;})
		finish_item(req);
	endtask

endclass


//--------------Hincr16_write_seq----------------//

class Hincr16_write_seq extends AHB_base_sequence;

	`uvm_object_utils(Hincr16_write_seq)

	int sz;
	int wr;
	int addr;

	function new(string name = "Hincr16_write_seq");
		super.new(name);
	endfunction

	task body();
		req = AHB_xtn::type_id::create("req");
		
		start_item(req);
		assert(req.randomize() with {Htrans == 2; Hburst == 7;})
		finish_item(req);

		sz = req.Hsize;
		wr = req.Hwrite;
		addr = req.Haddr;

		for(int i=0 ; i<15 ; i++)
		begin
			start_item(req);
			assert(req.randomize() with {Htrans == 3; Hburst == 7 ; Hsize == sz; Haddr == (addr + 2**sz); Hwrite == wr;})	
			addr = req.Haddr;
			finish_item(req);
		end
		
		start_item(req);
		assert(req.randomize() with {Htrans == 0;})
		finish_item(req);
	endtask

endclass


//--------------Hwrap4_write_seq----------------//

class Hwrap4_write_seq extends AHB_base_sequence;
	
	`uvm_object_utils(Hwrap4_write_seq)

	function new(string name = "Hwrap4_write_seq");
		super.new(name);
	endfunction

	int addr;
	int sz;

	task body();
		req = AHB_xtn::type_id::create("req");

	start_item(req);
		assert(req.randomize() with {Htrans == 2; Hburst == 2;})
	finish_item(req);
	
		addr = req.Haddr;
		sz = req.Hsize;
	for(int i=0; i<3; i++)
		begin
			if(req.Hsize == 0)
			begin
			start_item(req);
				assert(req.randomize() with{Htrans == 3; Hburst == 2; Hsize == sz;Haddr == {addr[31:2], addr[1:0]+1'b1};})
				addr = req.Haddr;
				sz = req.Hsize;
			finish_item(req);
			end
		
			if(req.Hsize == 1)
			begin
			start_item(req);
				assert(req.randomize() with{Htrans == 3; Hburst == 2;Hsize == sz; Haddr == {addr[31:3], addr[2:1]+1'b1, addr[0]};})
				addr = req.Haddr;
				sz = req.Hsize;
			finish_item(req);
			end
			
			if(req.Hsize == 2)
			begin
			start_item(req);
				assert(req.randomize() with{Htrans == 3; Hburst == 2;Hsize == sz; Haddr == {addr[31:4], addr[3:2]+1'b1, addr[1:0]};})
				addr = req.Haddr;
				sz = req.Hsize;
			finish_item(req);
			end

		end
		
		start_item(req);
		assert(req.randomize() with {Htrans == 0;})
		finish_item(req);
	endtask


endclass


//--------------Hwrap8_write_seq----------------//

class Hwrap8_write_seq extends AHB_base_sequence;
	
	`uvm_object_utils(Hwrap8_write_seq)

	function new(string name = "Hwrap8_write_seq");
		super.new(name);
	endfunction

	int addr;
	int sz;

	task body();
		req = AHB_xtn::type_id::create("req");

	start_item(req);
		assert(req.randomize() with {Htrans == 2; Hburst == 4;})
	finish_item(req);
	
		addr = req.Haddr;
		sz = req.Hsize;
	for(int i=0; i<7; i++)
		begin
			if(req.Hsize == 0)
			begin
			start_item(req);
				assert(req.randomize() with{Htrans == 3; Hburst == 4; Hsize == sz;Haddr == {addr[31:3], addr[2:0]+1'b1};})
				addr = req.Haddr;
				sz = req.Hsize;
			finish_item(req);
			end
		
			if(req.Hsize == 1)
			begin
			start_item(req);
				assert(req.randomize() with{Htrans == 3; Hburst == 4; Hsize == sz; Haddr == {addr[31:4], addr[3:1]+1'b1, addr[0]};})
				addr = req.Haddr;
				sz = req.Hsize;
			finish_item(req);
			end
			
			if(req.Hsize == 2)
			begin
			start_item(req);
				assert(req.randomize() with{Htrans == 3; Hburst == 4; Hsize == sz; Haddr == {addr[31:5], addr[4:2]+1'b1, addr[1:0]};})
				addr = req.Haddr;
				sz = req.Hsize;
			finish_item(req);
			end

		end
		
		start_item(req);
		assert(req.randomize() with {Htrans == 0;})
		finish_item(req);
	endtask


endclass

//--------------Hwrap16_write_seq----------------//

class Hwrap16_write_seq extends AHB_base_sequence;
	
	`uvm_object_utils(Hwrap16_write_seq)

	function new(string name = "Hwrap16_write_seq");
		super.new(name);
	endfunction

	int addr;
	int sz;
	int wr;

	task body();
		req = AHB_xtn::type_id::create("req");

	start_item(req);
		assert(req.randomize() with {Htrans == 2; Hburst == 6;})
	finish_item(req);
	
		addr = req.Haddr;
		sz = req.Hsize;
		wr = req.Hwrite;

	for(int i=0; i<15; i++)
		begin
			if(req.Hsize == 0)
			begin
			start_item(req);
				assert(req.randomize() with{Htrans == 3; Hburst == 6; Hwrite==wr; Hsize == sz; Haddr == {addr[31:4], addr[3:0]+1'b1};})
				addr = req.Haddr;
				sz = req.Hsize;
			finish_item(req);
			end
		
			if(req.Hsize == 1)
			begin
			start_item(req);
				assert(req.randomize() with{Htrans == 3; Hburst == 6; Hwrite==wr;Hsize == sz; Haddr == {addr[31:5], addr[4:1]+1'b1, addr[0]};})
				addr = req.Haddr;
				sz = req.Hsize;
			finish_item(req);
			end
			
			if(req.Hsize == 2)
			begin
			start_item(req);
				assert(req.randomize() with{Htrans == 3; Hburst == 6; Hwrite==wr;Hsize == sz; Haddr == {addr[31:6], addr[5:2]+1'b1, addr[1:0]};})
				addr = req.Haddr;
				sz = req.Hsize;
			finish_item(req);
			end

		end
			
	//	start_item(req);
	//	assert(req.randomize() with {Htrans == 0;})
	//	finish_item(req);
	endtask


endclass

//--------------Hidle_write_seq----------------//

class Hidle_write_seq extends AHB_base_sequence;

	`uvm_object_utils(Hidle_write_seq)

	function new(string name = "Hidle_write_seq");
		super.new(name);
	endfunction

	task body();
		req = AHB_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {Htrans == 0;})
		finish_item(req);
	endtask

endclass


//--------------Hincr__write_seq----------------//

class Hincr_write_seq extends AHB_base_sequence;

	`uvm_object_utils(Hincr_write_seq)

	int sz;
	int wr;
	int addr;
	int len;

	function new(string name = "Hincr8_write_seq");
		super.new(name);
	endfunction

	task body();
		req = AHB_xtn::type_id::create("req");
		
		start_item(req);
		assert(req.randomize() with {Htrans == 2; Hburst == 1;})
		finish_item(req);

		sz = req.Hsize;
		wr = req.Hwrite;
		addr = req.Haddr;
		len = req.burst_len;

		repeat(req.burst_len -1)
		begin
			start_item(req);
			assert(req.randomize() with {Htrans == 3; Hburst == 1 ; Hsize == sz; Haddr == (addr + 2**sz); Hwrite == wr; burst_len == len;})	
			addr = req.Haddr;
		len = req.burst_len;
			finish_item(req);
		end
	endtask

endclass


