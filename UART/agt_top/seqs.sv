class uart_seqs extends uvm_sequence #(trans);
	`uvm_object_utils(uart_seqs)
	extern function new(string name="uart_seqs");
endclass

function uart_seqs::new(string name="uart_seqs");
	super.new(name);
endfunction
//-------------------------FULL DUPLEX--------------
class full_seqs_tx extends uart_seqs;
	`uvm_object_utils(full_seqs_tx)
	extern function new(string name="full_seqs_tx");
	extern task body();
endclass
function full_seqs_tx::new(string name="full_seqs_tx");
	super.new(name);
endfunction

task full_seqs_tx::body();
 	req=trans::type_id::create("req");

       //for selecting the DLR,we are making 8th bit of LCR as 1
			start_item(req);
     			assert(req.randomize() with {wb_addr_i==5'd3;wb_we_i==1'd1;wb_dat_i==8'b10000000;});
			`uvm_info(get_full_name(),$sformatf("printing from LCR sequence \n %s", req.sprint()),UVM_LOW)
     			finish_item(req);
 
    //Selecting the MSB of DLR & assigning it with 0
   			 start_item(req);
     			assert(req.randomize() with {wb_addr_i==5'd1;wb_we_i==1'd1;wb_dat_i==8'b00000000;});
			`uvm_info(get_full_name(),$sformatf("printing from DLR MSB sequence \n %s", req.sprint()),UVM_LOW) 
      			finish_item(req);

    //Selecting the LSB of DLR & assigning it with Baud_rate
			start_item(req);
    			assert(req.randomize() with {wb_addr_i==5'd0;wb_we_i==1'd1;wb_dat_i==54;});
			`uvm_info(get_full_name(),$sformatf("printing from DLR LSB sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);
			      
   //Selecting the Normal registers-Select addr=3 for LCR and assign 8th bit of LCR as 0 & giving no_of_bits
    			  start_item(req);
    			assert(req.randomize() with {wb_addr_i==5'd3;wb_we_i==1'd1;wb_dat_i==8'b00000011;});
			`uvm_info(get_full_name(),$sformatf("printing from LCR BITS ASSIGN sequence \n %s", req.sprint()),UVM_LOW) 	
  			finish_item(req);

	//Selecting the FCR  & giving no_of_bytes to be read by master
    			  start_item(req);
      			assert(req.randomize() with {wb_addr_i==5'd2;wb_we_i==1'd1;wb_dat_i==8'b00000110;});
			`uvm_info(get_full_name(),$sformatf("printing from FCR sequence \n %s", req.sprint()),UVM_LOW) 
   		   	finish_item(req);


    //Selecting the IER-addr=1 & giving signal received data available  
  		        start_item(req);
      			assert(req.randomize() with {wb_addr_i==5'd1;wb_we_i==1'd1;wb_dat_i==8'b00000101;});
			`uvm_info(get_full_name(),$sformatf("printing from IER sequence \n %s", req.sprint()),UVM_LOW) 
      			finish_item(req);

    	//Selecting THR & giving the actual data
    			start_item(req);
      			assert(req.randomize() with {wb_addr_i==5'd0;wb_we_i==1'd1;wb_dat_i==8'd11;});
			`uvm_info(get_full_name(),$sformatf("printing from THR sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);

	//Selecting IIR 
      			start_item(req);
     			assert(req.randomize() with {wb_addr_i==5'd2;wb_we_i==1'd0;});
			`uvm_info(get_full_name(),$sformatf("printing from IIR sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);

	get_response(req);
	
	if(req.iir[3:1]==3'b010)
		begin
				start_item(req);
			assert(req.randomize() with {wb_addr_i==5'd0;wb_we_i==1'd0;});
			`uvm_info(get_full_name(),$sformatf("printing from IIR RECIEVER sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);

		end
	if(req.iir[3:1]==3'b011)
		begin
			start_item(req);
			assert(req.randomize() with {wb_addr_i==5'd5;wb_we_i==1'd0;});
			`uvm_info(get_full_name(),$sformatf("printing from IIR LS  sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);
		end

endtask

class full_seqs_rx extends uart_seqs;
	`uvm_object_utils(full_seqs_rx)
	extern function new(string name="full_seqs_rx");
	extern task body();
endclass
function full_seqs_rx::new(string name="full_seqs_rx");
	super.new(name);
endfunction

task full_seqs_rx::body();
 	req=trans::type_id::create("req");

       //for selecting the DLR,we are making 8th bit of LCR as 1
			start_item(req);
     			assert(req.randomize() with {wb_addr_i==5'd3;wb_we_i==1'd1;wb_dat_i==8'b10000000;});
			`uvm_info(get_full_name(),$sformatf("printing from LCR sequence \n %s", req.sprint()),UVM_LOW)
     			finish_item(req);
 
    //Selecting the MSB of DLR & assigning it with 0
   			 start_item(req);
     			assert(req.randomize() with {wb_addr_i==5'd1;wb_we_i==1'd1;wb_dat_i==8'b00000000;});
			`uvm_info(get_full_name(),$sformatf("printing from DLR MSB sequence \n %s", req.sprint()),UVM_LOW) 
      			finish_item(req);

    //Selecting the LSB of DLR & assigning it with Baud_rate
			start_item(req);
    			assert(req.randomize() with {wb_addr_i==5'd0;wb_we_i==1'd1;wb_dat_i==27;});
			`uvm_info(get_full_name(),$sformatf("printing from DLR LSB sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);
			      
   //Selecting the Normal registers-Select addr=3 for LCR and assign 8th bit of LCR as 0 & giving no_of_bits
    			  start_item(req);
    			assert(req.randomize() with {wb_addr_i==5'd3;wb_we_i==1'd1;wb_dat_i==8'b00000011;});
			`uvm_info(get_full_name(),$sformatf("printing from LCR BITS ASSIGN sequence \n %s", req.sprint()),UVM_LOW) 	
  			finish_item(req);

	//Selecting the FCR  & giving no_of_bytes to be read by master
    			  start_item(req);
      			assert(req.randomize() with {wb_addr_i==5'd2;wb_we_i==1'd1;wb_dat_i==8'b00000110;});
			`uvm_info(get_full_name(),$sformatf("printing from FCR sequence \n %s", req.sprint()),UVM_LOW) 
   		   	finish_item(req);


    //Selecting the IER-addr=1 & giving signal received data available  
  		        start_item(req);
      			assert(req.randomize() with {wb_addr_i==5'd1;wb_we_i==1'd1;wb_dat_i==8'b00000101;});
			`uvm_info(get_full_name(),$sformatf("printing from IER sequence \n %s", req.sprint()),UVM_LOW) 
      			finish_item(req);

    	//Selecting THR & giving the actual data
    			start_item(req);
      			assert(req.randomize() with {wb_addr_i==5'd0;wb_we_i==1'd1;wb_dat_i==8'd11;});
			`uvm_info(get_full_name(),$sformatf("printing from THR sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);

	//Selecting IIR 
      			start_item(req);
     			assert(req.randomize() with {wb_addr_i==5'd2;wb_we_i==1'd0;});
			`uvm_info(get_full_name(),$sformatf("printing from IIR sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);

	get_response(req);
	
	if(req.iir[3:1]==3'b010)
		begin
			start_item(req);
			assert(req.randomize() with {wb_addr_i==5'd0;wb_we_i==1'd0;});
			`uvm_info(get_full_name(),$sformatf("printing from IIR RECIEVER sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);

		end
	if(req.iir[3:1]==3'b011)
		begin
			start_item(req);
			assert(req.randomize() with {wb_addr_i==5'd5;wb_we_i==1'd0;});
			`uvm_info(get_full_name(),$sformatf("printing from IIR LS  sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);
		end

endtask

//----------------------------------------HALF DUPLEX-------------------

class half_seqs_tx extends uart_seqs;
	`uvm_object_utils(half_seqs_tx)
	extern function new(string name="half_seqs_tx");
	extern task body();
endclass
function half_seqs_tx::new(string name="half_seqs_tx");
	super.new(name);
endfunction

task half_seqs_tx::body();
 	req=trans::type_id::create("req");

       //for selecting the DLR,we are making 8th bit of LCR as 1
			start_item(req);
     			assert(req.randomize() with {wb_addr_i==5'd3;wb_we_i==1'd1;wb_dat_i==8'b10000000;});
			`uvm_info(get_full_name(),$sformatf("printing from LCR sequence \n %s", req.sprint()),UVM_LOW)
     			finish_item(req);
 
    //Selecting the MSB of DLR & assigning it with 0
   			 start_item(req);
     			assert(req.randomize() with {wb_addr_i==5'd1;wb_we_i==1'd1;wb_dat_i==8'b00000000;});
			`uvm_info(get_full_name(),$sformatf("printing from DLR MSB sequence \n %s", req.sprint()),UVM_LOW) 
      			finish_item(req);

    //Selecting the LSB of DLR & assigning it with Baud_rate
			start_item(req);
    			assert(req.randomize() with {wb_addr_i==5'd0;wb_we_i==1'd1;wb_dat_i==54;});
			`uvm_info(get_full_name(),$sformatf("printing from DLR LSB sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);
			      
   //Selecting the Normal registers-Select addr=3 for LCR and assign 8th bit of LCR as 0 & giving no_of_bits
    			  start_item(req);
    			assert(req.randomize() with {wb_addr_i==5'd3;wb_we_i==1'd1;wb_dat_i==8'b00000011;});
			`uvm_info(get_full_name(),$sformatf("printing from LCR BITS ASSIGN sequence \n %s", req.sprint()),UVM_LOW) 	
  			finish_item(req);

	//Selecting the FCR  & giving no_of_bytes to be read by master
    			  start_item(req);
      			assert(req.randomize() with {wb_addr_i==5'd2;wb_we_i==1'd1;wb_dat_i==8'b00000110;});
			`uvm_info(get_full_name(),$sformatf("printing from FCR sequence \n %s", req.sprint()),UVM_LOW) 
   		   	finish_item(req);


    //Selecting the IER-addr=1 & giving signal received data available  
  		        start_item(req);
      			assert(req.randomize() with {wb_addr_i==5'd1;wb_we_i==1'd1;wb_dat_i==8'b00000101;});
			`uvm_info(get_full_name(),$sformatf("printing from IER sequence \n %s", req.sprint()),UVM_LOW) 
      			finish_item(req);

    	//Selecting THR & giving the actual data
    			start_item(req);
      			assert(req.randomize() with {wb_addr_i==5'd0;wb_we_i==1'd1;wb_dat_i==8'd11;});
			`uvm_info(get_full_name(),$sformatf("printing from THR sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);

	//Selecting IIR 
      			start_item(req);
     			assert(req.randomize() with {wb_addr_i==5'd2;wb_we_i==1'd0;});
			`uvm_info(get_full_name(),$sformatf("printing from IIR sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);

	/*get_response(req);
	
	if(req.iir[3:1]==3'b010)
		begin
			start_item(req);
			assert(req.randomize() with {wb_addr_i==5'd0;wb_we_i==1'd0;});
			`uvm_info(get_full_name(),$sformatf("printing from IIR RECIEVER sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);

		end
	if(req.iir[3:1]==3'b011)
		begin
			start_item(req);
			assert(req.randomize() with {wb_addr_i==5'd5;wb_we_i==1'd0;});
			`uvm_info(get_full_name(),$sformatf("printing from IIR LS  sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);
		end*/

endtask

class half_seqs_rx extends uart_seqs;
	`uvm_object_utils(half_seqs_rx)
	extern function new(string name="half_seqs_rx");
	extern task body();
endclass
function half_seqs_rx::new(string name="half_seqs_rx");
	super.new(name);
endfunction

task half_seqs_rx::body();
 	req=trans::type_id::create("req");

       //for selecting the DLR,we are making 8th bit of LCR as 1
			start_item(req);
     			assert(req.randomize() with {wb_addr_i==5'd3;wb_we_i==1'd1;wb_dat_i==8'b10000000;});
			`uvm_info(get_full_name(),$sformatf("printing from LCR sequence \n %s", req.sprint()),UVM_LOW)
     			finish_item(req);
 
    //Selecting the MSB of DLR & assigning it with 0
   			 start_item(req);
     			assert(req.randomize() with {wb_addr_i==5'd1;wb_we_i==1'd1;wb_dat_i==8'b00000000;});
			`uvm_info(get_full_name(),$sformatf("printing from DLR MSB sequence \n %s", req.sprint()),UVM_LOW) 
      			finish_item(req);

    //Selecting the LSB of DLR & assigning it with Baud_rate
			start_item(req);
    			assert(req.randomize() with {wb_addr_i==5'd0;wb_we_i==1'd1;wb_dat_i==27;});
			`uvm_info(get_full_name(),$sformatf("printing from DLR LSB sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);
			      
   //Selecting the Normal registers-Select addr=3 for LCR and assign 8th bit of LCR as 0 & giving no_of_bits
    			  start_item(req);
    			assert(req.randomize() with {wb_addr_i==5'd3;wb_we_i==1'd1;wb_dat_i==8'b00000011;});
			`uvm_info(get_full_name(),$sformatf("printing from LCR BITS ASSIGN sequence \n %s", req.sprint()),UVM_LOW) 	
  			finish_item(req);

	//Selecting the FCR  & giving no_of_bytes to be read by master
    			  start_item(req);
      			assert(req.randomize() with {wb_addr_i==5'd2;wb_we_i==1'd1;wb_dat_i==8'b00000110;});
			`uvm_info(get_full_name(),$sformatf("printing from FCR sequence \n %s", req.sprint()),UVM_LOW) 
   		   	finish_item(req);


    //Selecting the IER-addr=1 & giving signal received data available  
  		        start_item(req);
      			assert(req.randomize() with {wb_addr_i==5'd1;wb_we_i==1'd1;wb_dat_i==8'b00000101;});
			`uvm_info(get_full_name(),$sformatf("printing from IER sequence \n %s", req.sprint()),UVM_LOW) 
      			finish_item(req);

    	//Selecting THR & giving the actual data
    			start_item(req);
      			assert(req.randomize() with {wb_addr_i==5'd0;wb_we_i==1'd1;});
			`uvm_info(get_full_name(),$sformatf("printing from THR sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);

	//Selecting IIR 
      			start_item(req);
     			assert(req.randomize() with {wb_addr_i==5'd2;wb_we_i==1'd0;});
			`uvm_info(get_full_name(),$sformatf("printing from IIR sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);

	get_response(req);
	
	if(req.iir[3:1]==3'b010)
		begin
			start_item(req);
			assert(req.randomize() with {wb_addr_i==5'd0;wb_we_i==1'd0;});
			`uvm_info(get_full_name(),$sformatf("printing from IIR RECIEVER sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);

		end
	if(req.iir[3:1]==3'b011)
		begin
			start_item(req);
			assert(req.randomize() with {wb_addr_i==5'd5;wb_we_i==1'd0;});
			`uvm_info(get_full_name(),$sformatf("printing from IIR LS  sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);
		end

endtask

//-----------------------------LOOP BACK-----------------------------------------
class loop_back extends uart_seqs;
	`uvm_object_utils(loop_back)
	extern function new(string name = "loop_back");
	extern task body();
endclass

function loop_back::new(string name = "loop_back");
	super.new(name);
endfunction

task loop_back::body();
	super.body();
	req=trans::type_id::create("req");

       //for selecting the DLR,we are making 8th bit of LCR as 1
			start_item(req);
     			assert(req.randomize() with {wb_addr_i==5'd3;wb_we_i==1'd1;wb_dat_i==8'b10000000;});
			`uvm_info(get_full_name(),$sformatf("printing from LCR sequence \n %s", req.sprint()),UVM_LOW)
     			finish_item(req);
 
    //Selecting the MSB of DLR & assigning it with 0
   			 start_item(req);
     			assert(req.randomize() with {wb_addr_i==5'd1;wb_we_i==1'd1;wb_dat_i==8'b00000000;});
			`uvm_info(get_full_name(),$sformatf("printing from DLR MSB sequence \n %s", req.sprint()),UVM_LOW) 
      			finish_item(req);

    //Selecting the LSB of DLR & assigning it with Baud_rate
			start_item(req);
    			assert(req.randomize() with {wb_addr_i==5'd0;wb_we_i==1'd1;wb_dat_i==27;});
			`uvm_info(get_full_name(),$sformatf("printing from DLR LSB sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);
			      
   //Selecting the Normal registers-Select addr=3 for LCR and assign 8th bit of LCR as 0 & giving no_of_bits
    			  start_item(req);
    			assert(req.randomize() with {wb_addr_i==5'd3;wb_we_i==1'd1;wb_dat_i==8'b00000011;});
			`uvm_info(get_full_name(),$sformatf("printing from LCR BITS ASSIGN sequence \n %s", req.sprint()),UVM_LOW) 	
  			finish_item(req);

	//Selecting the FCR  & giving no_of_bytes to be read by master
    			  start_item(req);
      			assert(req.randomize() with {wb_addr_i==5'd2;wb_we_i==1'd1;wb_dat_i==8'b00000110;});
			`uvm_info(get_full_name(),$sformatf("printing from FCR sequence \n %s", req.sprint()),UVM_LOW) 
   		   	finish_item(req);
	// Selecting the MCR 
 			start_item(req);
      			assert(req.randomize() with {wb_addr_i==5'd4;wb_we_i==1'd1;wb_dat_i==8'b00010000;});
			`uvm_info(get_full_name(),$sformatf("printing from FCR sequence \n %s", req.sprint()),UVM_LOW) 
   		   	finish_item(req);


    //Selecting the IER-addr=1 & giving signal received data available  
  		        start_item(req);
      			assert(req.randomize() with {wb_addr_i==5'd1;wb_we_i==1'd1;wb_dat_i==8'b00000101;});
			`uvm_info(get_full_name(),$sformatf("printing from IER sequence \n %s", req.sprint()),UVM_LOW) 
      			finish_item(req);

    	//Selecting THR & giving the actual data
    			start_item(req);
      			assert(req.randomize() with {wb_addr_i==5'd0;wb_we_i==1'd1;wb_dat_i==8'd11;});
			`uvm_info(get_full_name(),$sformatf("printing from THR sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);

	//Selecting IIR 
      			start_item(req);
     			assert(req.randomize() with {wb_addr_i==5'd2;wb_we_i==1'd0;});
			`uvm_info(get_full_name(),$sformatf("printing from IIR sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);

	get_response(req);
	
	if(req.iir[3:1]==3'b010)
		begin
			start_item(req);
			assert(req.randomize() with {wb_addr_i==5'd0;wb_we_i==1'd0;});
			`uvm_info(get_full_name(),$sformatf("printing from IIR RECIEVER sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);

		end
	if(req.iir[3:1]==3'b011)
		begin
			start_item(req);
			assert(req.randomize() with {wb_addr_i==5'd5;wb_we_i==1'd0;});
			`uvm_info(get_full_name(),$sformatf("printing from IIR LS  sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);
		end

endtask

//---------------------------------PARITY ERROR-------------------------------------------------------------------------------
class parity_seqs_tx extends uart_seqs;
	`uvm_object_utils(parity_seqs_tx)
	extern function new(string name="parity_seqs_tx");
	extern task body();
endclass
function parity_seqs_tx::new(string name="parity_seqs_tx");
	super.new(name);
endfunction

task parity_seqs_tx::body();
 	req=trans::type_id::create("req");

       //for selecting the DLR,we are making 8th bit of LCR as 1
			start_item(req);
     			assert(req.randomize() with {wb_addr_i==5'd3;wb_we_i==1'd1;wb_dat_i==8'b10000000;});
			`uvm_info(get_full_name(),$sformatf("printing from LCR sequence \n %s", req.sprint()),UVM_LOW)
     			finish_item(req);
 
    //Selecting the MSB of DLR & assigning it with 0
   			 start_item(req);
     			assert(req.randomize() with {wb_addr_i==5'd1;wb_we_i==1'd1;wb_dat_i==8'b00000000;});
			`uvm_info(get_full_name(),$sformatf("printing from DLR MSB sequence \n %s", req.sprint()),UVM_LOW) 
      			finish_item(req);

    //Selecting the LSB of DLR & assigning it with Baud_rate
			start_item(req);
    			assert(req.randomize() with {wb_addr_i==5'd0;wb_we_i==1'd1;wb_dat_i==54;});
			`uvm_info(get_full_name(),$sformatf("printing from DLR LSB sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);
			      
   //Selecting the Normal registers-Select addr=3 for LCR and assign 8th bit of LCR as 0 & giving no_of_bits
    			  start_item(req);
    			assert(req.randomize() with {wb_addr_i==5'd3;wb_we_i==1'd1;wb_dat_i==8'b00001011;});
			`uvm_info(get_full_name(),$sformatf("printing from LCR BITS ASSIGN sequence \n %s", req.sprint()),UVM_LOW) 	
  			finish_item(req);

	//Selecting the FCR  & giving no_of_bytes to be read by master
    			  start_item(req);
      			assert(req.randomize() with {wb_addr_i==5'd2;wb_we_i==1'd1;wb_dat_i==8'b00000110;});
			`uvm_info(get_full_name(),$sformatf("printing from FCR sequence \n %s", req.sprint()),UVM_LOW) 
   		   	finish_item(req);


    //Selecting the IER-addr=1 & giving signal received data available  
  		        start_item(req);
      			assert(req.randomize() with {wb_addr_i==5'd1;wb_we_i==1'd1;wb_dat_i==8'b00000100;});
			`uvm_info(get_full_name(),$sformatf("printing from IER sequence \n %s", req.sprint()),UVM_LOW) 
      			finish_item(req);

    	//Selecting THR & giving the actual data
    			start_item(req);
      			assert(req.randomize() with {wb_addr_i==5'd0;wb_we_i==1'd1;wb_dat_i==8'd3;});
			`uvm_info(get_full_name(),$sformatf("printing from THR sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);

	//Selecting IIR 
      			start_item(req);
     			assert(req.randomize() with {wb_addr_i==5'd2;wb_we_i==1'd0;});
			`uvm_info(get_full_name(),$sformatf("printing from IIR sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);

	get_response(req);
	
	if(req.iir[3:1]==3'b010)
		begin
				start_item(req);
			assert(req.randomize() with {wb_addr_i==5'd0;wb_we_i==1'd0;});
			`uvm_info(get_full_name(),$sformatf("printing from IIR RECIEVER sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);

		end
	if(req.iir[3:1]==3'b011)
		begin
			start_item(req);
			assert(req.randomize() with {wb_addr_i==5'd5;wb_we_i==1'd0;});
			`uvm_info(get_full_name(),$sformatf("printing from IIR LS  sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);
		end

endtask

class parity_seqs_rx extends uart_seqs;
	`uvm_object_utils(parity_seqs_rx)
	extern function new(string name="parity_seqs_rx");
	extern task body();
endclass
function parity_seqs_rx::new(string name="parity_seqs_rx");
	super.new(name);
endfunction

task parity_seqs_rx::body();
 	req=trans::type_id::create("req");

       //for selecting the DLR,we are making 8th bit of LCR as 1
			start_item(req);
     			assert(req.randomize() with {wb_addr_i==5'd3;wb_we_i==1'd1;wb_dat_i==8'b10000000;});
			`uvm_info(get_full_name(),$sformatf("printing from LCR sequence \n %s", req.sprint()),UVM_LOW)
     			finish_item(req);
 
    //Selecting the MSB of DLR & assigning it with 0
   			 start_item(req);
     			assert(req.randomize() with {wb_addr_i==5'd1;wb_we_i==1'd1;wb_dat_i==8'b00000000;});
			`uvm_info(get_full_name(),$sformatf("printing from DLR MSB sequence \n %s", req.sprint()),UVM_LOW) 
      			finish_item(req);

    //Selecting the LSB of DLR & assigning it with Baud_rate
			start_item(req);
    			assert(req.randomize() with {wb_addr_i==5'd0;wb_we_i==1'd1;wb_dat_i==27;});
			`uvm_info(get_full_name(),$sformatf("printing from DLR LSB sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);
			      
   //Selecting the Normal registers-Select addr=3 for LCR and assign 8th bit of LCR as 0 & giving no_of_bits
    			  start_item(req);
    			assert(req.randomize() with {wb_addr_i==5'd3;wb_we_i==1'd1;wb_dat_i==8'b00011011;});
			`uvm_info(get_full_name(),$sformatf("printing from LCR BITS ASSIGN sequence \n %s", req.sprint()),UVM_LOW) 	
  			finish_item(req);

	//Selecting the FCR  & giving no_of_bytes to be read by master
    			  start_item(req);
      			assert(req.randomize() with {wb_addr_i==5'd2;wb_we_i==1'd1;wb_dat_i==8'b00000110;});
			`uvm_info(get_full_name(),$sformatf("printing from FCR sequence \n %s", req.sprint()),UVM_LOW) 
   		   	finish_item(req);


    //Selecting the IER-addr=1 & giving signal received data available  
  		        start_item(req);
      			assert(req.randomize() with {wb_addr_i==5'd1;wb_we_i==1'd1;wb_dat_i==8'b00000100;});
			`uvm_info(get_full_name(),$sformatf("printing from IER sequence \n %s", req.sprint()),UVM_LOW) 
      			finish_item(req);

    	//Selecting THR & giving the actual data
    			start_item(req);
      			assert(req.randomize() with {wb_addr_i==5'd0;wb_we_i==1'd1;wb_dat_i==8'd1;});
			`uvm_info(get_full_name(),$sformatf("printing from THR sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);

	//Selecting IIR 
      			start_item(req);
     			assert(req.randomize() with {wb_addr_i==5'd2;wb_we_i==1'd0;});
			`uvm_info(get_full_name(),$sformatf("printing from IIR sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);

	get_response(req);
	
	if(req.iir[3:1]==3'b010)
		begin
				start_item(req);
			assert(req.randomize() with {wb_addr_i==5'd0;wb_we_i==1'd0;});
			`uvm_info(get_full_name(),$sformatf("printing from IIR RECIEVER sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);

		end
	if(req.iir[3:1]==3'b011)
		begin
			start_item(req);
			assert(req.randomize() with {wb_addr_i==5'd5;wb_we_i==1'd0;});
			`uvm_info(get_full_name(),$sformatf("printing from IIR LS  sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);
		end

endtask
//----------------------------------------FRAMING ERROR--------------------------------------------------------------------
class framing_seqs_tx extends uart_seqs;
	`uvm_object_utils(framing_seqs_tx)
	extern function new(string name="framing_seqs_tx");
	extern task body();
endclass
function framing_seqs_tx::new(string name="framing_seqs_tx");
	super.new(name);
endfunction

task framing_seqs_tx::body();
 	req=trans::type_id::create("req");

       //for selecting the DLR,we are making 8th bit of LCR as 1
			start_item(req);
     			assert(req.randomize() with {wb_addr_i==5'd3;wb_we_i==1'd1;wb_dat_i==8'b10000000;});
			`uvm_info(get_full_name(),$sformatf("printing from LCR sequence \n %s", req.sprint()),UVM_LOW)
     			finish_item(req);
 
    //Selecting the MSB of DLR & assigning it with 0
   			 start_item(req);
     			assert(req.randomize() with {wb_addr_i==5'd1;wb_we_i==1'd1;wb_dat_i==8'b00000000;});
			`uvm_info(get_full_name(),$sformatf("printing from DLR MSB sequence \n %s", req.sprint()),UVM_LOW) 
      			finish_item(req);

    //Selecting the LSB of DLR & assigning it with Baud_rate
			start_item(req);
    			assert(req.randomize() with {wb_addr_i==5'd0;wb_we_i==1'd1;wb_dat_i==54;});
			`uvm_info(get_full_name(),$sformatf("printing from DLR LSB sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);
			      
   //Selecting the Normal registers-Select addr=3 for LCR and assign 8th bit of LCR as 0 & giving no_of_bits
    			  start_item(req);
    			assert(req.randomize() with {wb_addr_i==5'd3;wb_we_i==1'd1;wb_dat_i==8'b00000000;});
			`uvm_info(get_full_name(),$sformatf("printing from LCR BITS ASSIGN sequence \n %s", req.sprint()),UVM_LOW) 	
  			finish_item(req);

	//Selecting the FCR  & giving no_of_bytes to be read by master
    			  start_item(req);
      			assert(req.randomize() with {wb_addr_i==5'd2;wb_we_i==1'd1;wb_dat_i==8'b00000110;});
			`uvm_info(get_full_name(),$sformatf("printing from FCR sequence \n %s", req.sprint()),UVM_LOW) 
   		   	finish_item(req);


    //Selecting the IER-addr=1 & giving signal received data available  
  		        start_item(req);
      			assert(req.randomize() with {wb_addr_i==5'd1;wb_we_i==1'd1;wb_dat_i==8'b00000100;});
			`uvm_info(get_full_name(),$sformatf("printing from IER sequence \n %s", req.sprint()),UVM_LOW) 
      			finish_item(req);

    	//Selecting THR & giving the actual data
    			start_item(req);
      			assert(req.randomize() with {wb_addr_i==5'd0;wb_we_i==1'd1;wb_dat_i==8'd10;});
			`uvm_info(get_full_name(),$sformatf("printing from THR sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);

	//Selecting IIR 
      			start_item(req);
     			assert(req.randomize() with {wb_addr_i==5'd2;wb_we_i==1'd0;});
			`uvm_info(get_full_name(),$sformatf("printing from IIR sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);

	get_response(req);
	
	if(req.iir[3:1]==3'b010)
		begin
				start_item(req);
			assert(req.randomize() with {wb_addr_i==5'd0;wb_we_i==1'd0;});
			`uvm_info(get_full_name(),$sformatf("printing from IIR RECIEVER sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);

		end
	if(req.iir[3:1]==3'b011)
		begin
			start_item(req);
			assert(req.randomize() with {wb_addr_i==5'd5;wb_we_i==1'd0;});
			`uvm_info(get_full_name(),$sformatf("printing from IIR LS  sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);
		end

endtask

class framing_seqs_rx extends uart_seqs;
	`uvm_object_utils(framing_seqs_rx)
	extern function new(string name="framing_seqs_rx");
	extern task body();
endclass
function framing_seqs_rx::new(string name="framing_seqs_rx");
	super.new(name);
endfunction

task framing_seqs_rx::body();
 	req=trans::type_id::create("req");

       //for selecting the DLR,we are making 8th bit of LCR as 1
			start_item(req);
     			assert(req.randomize() with {wb_addr_i==5'd3;wb_we_i==1'd1;wb_dat_i==8'b10000000;});
			`uvm_info(get_full_name(),$sformatf("printing from LCR sequence \n %s", req.sprint()),UVM_LOW)
     			finish_item(req);
 
    //Selecting the MSB of DLR & assigning it with 0
   			 start_item(req);
     			assert(req.randomize() with {wb_addr_i==5'd1;wb_we_i==1'd1;wb_dat_i==8'b00000000;});
			`uvm_info(get_full_name(),$sformatf("printing from DLR MSB sequence \n %s", req.sprint()),UVM_LOW) 
      			finish_item(req);

    //Selecting the LSB of DLR & assigning it with Baud_rate
			start_item(req);
    			assert(req.randomize() with {wb_addr_i==5'd0;wb_we_i==1'd1;wb_dat_i==27;});
			`uvm_info(get_full_name(),$sformatf("printing from DLR LSB sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);
			      
   //Selecting the Normal registers-Select addr=3 for LCR and assign 8th bit of LCR as 0 & giving no_of_bits
    			  start_item(req);
    			assert(req.randomize() with {wb_addr_i==5'd3;wb_we_i==1'd1;wb_dat_i==8'b00000011;});
			`uvm_info(get_full_name(),$sformatf("printing from LCR BITS ASSIGN sequence \n %s", req.sprint()),UVM_LOW) 	
  			finish_item(req);

	//Selecting the FCR  & giving no_of_bytes to be read by master
    			  start_item(req);
      			assert(req.randomize() with {wb_addr_i==5'd2;wb_we_i==1'd1;wb_dat_i==8'b00000110;});
			`uvm_info(get_full_name(),$sformatf("printing from FCR sequence \n %s", req.sprint()),UVM_LOW) 
   		   	finish_item(req);


    //Selecting the IER-addr=1 & giving signal received data available  
  		        start_item(req);
      			assert(req.randomize() with {wb_addr_i==5'd1;wb_we_i==1'd1;wb_dat_i==8'b00000101;});
			`uvm_info(get_full_name(),$sformatf("printing from IER sequence \n %s", req.sprint()),UVM_LOW) 
      			finish_item(req);

    	//Selecting THR & giving the actual data
    			start_item(req);
      			assert(req.randomize() with {wb_addr_i==5'd0;wb_we_i==1'd1;wb_dat_i==8'd11;});
			`uvm_info(get_full_name(),$sformatf("printing from THR sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);

	//Selecting IIR 
      			start_item(req);
     			assert(req.randomize() with {wb_addr_i==5'd2;wb_we_i==1'd0;});
			`uvm_info(get_full_name(),$sformatf("printing from IIR sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);

	get_response(req);
	
	if(req.iir[3:1]==3'b010)
		begin
				start_item(req);
			assert(req.randomize() with {wb_addr_i==5'd0;wb_we_i==1'd0;});
			`uvm_info(get_full_name(),$sformatf("printing from IIR RECIEVER sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);

		end
	if(req.iir[3:1]==3'b011)
		begin
			start_item(req);
			assert(req.randomize() with {wb_addr_i==5'd5;wb_we_i==1'd0;});
			`uvm_info(get_full_name(),$sformatf("printing from IIR LS  sequence \n %s", req.sprint()),UVM_LOW) 
			finish_item(req);
		end

endtask
//---------------------------------------OVER RUN----------------------------------------------------------------------------


