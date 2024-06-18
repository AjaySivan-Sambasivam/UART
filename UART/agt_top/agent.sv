class uart_agent extends uvm_agent;
	`uvm_component_utils(uart_agent)
	uart_driver drvh;
	uart_monitor monh;
	uart_sequencer seqrh;
	agent_config m_cfg;
	extern function new(string name = "uart_agent",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);

endclass
function uart_agent::new(string name = "uart_agent",uvm_component parent);
	super.new(name,parent);
endfunction

function void uart_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(agent_config)::get(this,"","agent_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
	monh = uart_monitor::type_id::create("monh",this);
	drvh = uart_driver::type_id::create("drvh",this);
	seqrh = uart_sequencer::type_id::create("seqrh",this);
endfunction

function void uart_agent::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	drvh.seq_item_port.connect(seqrh.seq_item_export);
endfunction




