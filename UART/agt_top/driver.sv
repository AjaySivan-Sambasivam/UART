class uart_driver extends uvm_driver#(trans);
	`uvm_component_utils(uart_driver)
	agent_config m_cfg;
	virtual uart_if.WB_DRV vif;
	extern function new(string name="uart_driver",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern task send_to_dut(trans xtn);
endclass
function uart_driver::new(string name="uart_driver",uvm_component parent);
	super.new(name,parent);
endfunction

function void uart_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);
		if(!uvm_config_db #(agent_config)::get(this,"","agent_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
endfunction


function void uart_driver::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	vif=m_cfg.vif;
endfunction

task uart_driver::run_phase(uvm_phase phase);
		//@(vif.wb_drv);
  		//vif.wb_drv.wb_rst_i<=0;
		@(vif.wb_drv);
		vif.wb_drv.wb_rst_i<=1;
                vif.wb_drv.wb_stb_i<=0;
		vif.wb_drv.wb_cyc_i<=0;
		@(vif.wb_drv);
		vif.wb_drv.wb_rst_i<=0;

		forever begin
			seq_item_port.get_next_item(req);
			send_to_dut(req);
			seq_item_port.item_done();
		end
endtask



task uart_driver :: send_to_dut(trans xtn);
  begin
		@(vif.wb_drv);
                vif.wb_drv.wb_we_i<=xtn.wb_we_i;	
		vif.wb_drv.wb_addr_i<=xtn.wb_addr_i;
		vif.wb_drv.wb_dat_i<=xtn.wb_dat_i;
		vif.wb_drv.wb_sel_i<=4'b0001;
		vif.wb_drv.wb_stb_i<=1;
		vif.wb_drv.wb_cyc_i<=1;

		while(!vif.wb_drv.wb_ack_o)
		   @(vif.wb_drv);

		vif.wb_drv.wb_stb_i<=0;
		vif.wb_drv.wb_cyc_i<=0;

		if(xtn.wb_addr_i==2 && xtn.wb_we_i==0)
			begin
	  	wait(vif.wb_drv.int_o)
		   @(vif.wb_drv);
			xtn.iir = vif.wb_drv.wb_dat_o;
			seq_item_port.put_response(xtn);
			end
		//repeat(2)
		//@(vif.wb_drv);
   end
endtask



