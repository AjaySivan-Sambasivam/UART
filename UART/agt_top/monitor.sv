class uart_monitor extends uvm_monitor;
	`uvm_component_utils(uart_monitor)
	agent_config m_cfg;
	virtual uart_if.WB_MON vif;
	trans xtn;
	extern function new(string name="uart_monitor",uvm_component parent);
 	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task collect_data();
endclass
function uart_monitor::new(string name="uart_monitor",uvm_component parent);
	super.new(name,parent);
endfunction

function void uart_monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);
		if(!uvm_config_db #(agent_config)::get(this,"","agent_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
endfunction

function void uart_monitor::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	vif=m_cfg.vif;
endfunction

task uart_monitor::run_phase(uvm_phase phase);
	xtn=trans::type_id::create("xtn");
	forever begin
		collect_data();
		end
endtask 

task uart_monitor::collect_data();
	while(!vif.wb_mon.wb_ack_o)
	@(vif.wb_mon);
	xtn.wb_we_i=vif.wb_mon.wb_we_i;
	xtn.wb_addr_i=vif.wb_mon.wb_addr_i;
	xtn.wb_dat_i=vif.wb_mon.wb_dat_i;
	xtn.wb_dat_o=vif.wb_mon.wb_dat_o;
  
	if(xtn.wb_addr_i==3&&xtn.wb_we_i==1)
		xtn.lcr=vif.wb_mon.wb_dat_i;
	if(xtn.wb_addr_i==0&&xtn.wb_we_i==1&&xtn.lcr[7]==1)
		xtn.dl_lsb=vif.wb_mon.wb_dat_i;
	if(xtn.wb_addr_i==1&&xtn.wb_we_i==1&&xtn.lcr[7]==1)
		xtn.dl_msb=vif.wb_mon.wb_dat_i;
	if(xtn.wb_addr_i==0&&xtn.wb_we_i==1&&xtn.lcr[7]==0)
		xtn.thr.push_front(vif.wb_mon.wb_dat_i);
	if(xtn.wb_addr_i==1&&xtn.wb_we_i==1&&xtn.lcr[7]==0)
		xtn.ie=vif.wb_mon.wb_dat_i;
	if(xtn.wb_addr_i==2&&xtn.wb_we_i==1)
		xtn.fcr=vif.wb_mon.wb_dat_i;
		if(xtn.wb_addr_i==2&&xtn.wb_we_i==0)
		begin
		while(!vif.wb_mon.int_o)
		@(vif.wb_mon);
		xtn.iir=vif.wb_mon.wb_dat_o;
		end
if(xtn.wb_addr_i==5&&xtn.wb_we_i==0&&xtn.lcr[7]==0)
		xtn.ls=vif.wb_mon.wb_dat_o;
if(xtn.wb_addr_i==0&&xtn.wb_we_i==0&&xtn.lcr[7]==0)
		xtn.rb.push_front(vif.wb_mon.wb_dat_o);

	`uvm_info(get_full_name(),xtn.sprint(),UVM_LOW)
	@(vif.wb_mon);
endtask







