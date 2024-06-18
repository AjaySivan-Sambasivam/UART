class uart_test extends uvm_test;
	`uvm_component_utils(uart_test)
	uart_env envh;
	env_config m_cfg;
	agent_config a_cfg[];
	int agents = 2;
	//bit has_agent = 1;
	extern function new(string name = "uart_test", uvm_component parent);
	extern function void build_phase (uvm_phase phase);
	extern function void config_uart();

endclass
function uart_test::new(string name = "uart_test", uvm_component parent);
	super.new(name,parent);
endfunction

function void uart_test::build_phase (uvm_phase phase);
	super.build_phase(phase);
	m_cfg=env_config::type_id::create("m_cfg");
	envh = uart_env::type_id::create("envh",this);
	m_cfg.agent_cfg=new[agents];
	config_uart();
	uvm_config_db#(env_config)::set(this,"*","env_config",m_cfg);
endfunction
function void uart_test::config_uart();
	//if(has_agent)
		a_cfg=new[agents];
		//m_cfg.agent_cfg=new[agents];
		foreach(a_cfg[i])
		begin
		a_cfg[i]=agent_config::type_id::create($sformatf("a_cfg[%0d]",i));
		if(!uvm_config_db #(virtual uart_if)::get(this,"",$sformatf("vif_%0d",i),a_cfg[i].vif))
		`uvm_fatal("VIF CONFIG","cannot get()interface vif from uvm_config_db. Have you set() it?") 
		m_cfg.agent_cfg[i]=a_cfg[i];
		end

	m_cfg.agents=agents;
	//m_cfg.has_agent=has_agent;
endfunction
//--------------------------------SEQS------------------------------------
//---------------------------FULL SEQ-------------------------------------

class fullseqs extends uart_test;
	`uvm_component_utils(fullseqs)
	full_duplex f_d;
	extern function new(string name="fullseqs",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

function fullseqs::new(string name="fullseqs",uvm_component parent);
	super.new(name,parent);
endfunction

function void fullseqs::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task fullseqs::run_phase(uvm_phase phase);
	phase.raise_objection(this);
	f_d=full_duplex::type_id::create("f_d");
	f_d.start(envh.v_sequencer);
	phase.drop_objection(this);	 
endtask
//-----------------------HALF SEQ----------------------------------------
class halfseqs extends uart_test;
	`uvm_component_utils(halfseqs)
	half_duplex h_d;
	extern function new(string name="halfseqs",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

function halfseqs::new(string name="halfseqs",uvm_component parent);
	super.new(name,parent);
endfunction

function void halfseqs::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task halfseqs::run_phase(uvm_phase phase);
	phase.raise_objection(this);
	h_d=half_duplex::type_id::create("h_d");
	h_d.start(envh.v_sequencer);
	phase.drop_objection(this);	 
endtask
//-----------------------LOOP SEQ----------------------------------------
class loopseqs extends uart_test;
	`uvm_component_utils(loopseqs)
	loopback l_d;
	extern function new(string name="loopseqs",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

function loopseqs::new(string name="loopseqs",uvm_component parent);
	super.new(name,parent);
endfunction

function void loopseqs::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task loopseqs::run_phase(uvm_phase phase);
	phase.raise_objection(this);
	l_d=loopback::type_id::create("l_d");
	l_d.start(envh.v_sequencer);
	phase.drop_objection(this);	 
endtask
//----------------------PARITY ERROR-------------------------
class parityseqs extends uart_test;
	`uvm_component_utils(parityseqs)
	parity p_d;
	extern function new(string name="parityseqs",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

function parityseqs::new(string name="parityseqs",uvm_component parent);
	super.new(name,parent);
endfunction

function void parityseqs::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task parityseqs::run_phase(uvm_phase phase);
	phase.raise_objection(this);
	p_d=parity::type_id::create("p_d");
	p_d.start(envh.v_sequencer);
	phase.drop_objection(this);	 
endtask
//-------------------FRAMING ERROR---------------------------
class framingseqs extends uart_test;
	`uvm_component_utils(framingseqs)
	framing fa_d;
	extern function new(string name="framingseqs",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

function framingseqs::new(string name="framingseqs",uvm_component parent);
	super.new(name,parent);
endfunction

function void framingseqs::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task framingseqs::run_phase(uvm_phase phase);
	phase.raise_objection(this);
	fa_d=framing::type_id::create("fa_d");
	fa_d.start(envh.v_sequencer);
	phase.drop_objection(this);	 
endtask
//------------------OVERRUN--------------------------------
class overrunseqs extends uart_test;
	`uvm_component_utils(overrunseqs)
	overrun o_d;
	extern function new(string name="overrunseqs",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

function overrunseqs::new(string name="overrunseqs",uvm_component parent);
	super.new(name,parent);
endfunction

function void overrunseqs::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task overrunseqs::run_phase(uvm_phase phase);
	phase.raise_objection(this);
	o_d=overrun::type_id::create("o_d");
	o_d.start(envh.v_sequencer);
	phase.drop_objection(this);	 
endtask

//--------------BREAK INTERRUPT----------------------------
class breakseqs extends uart_test;
	`uvm_component_utils(breakseqs)
	breakI b_d;
	extern function new(string name="breakseqs",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

function breakseqs::new(string name="breakseqs",uvm_component parent);
	super.new(name,parent);
endfunction

function void breakseqs::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task breakseqs::run_phase(uvm_phase phase);
	phase.raise_objection(this);
	b_d=breakI::type_id::create("b_d");
	b_d.start(envh.v_sequencer);
	phase.drop_objection(this);	 
endtask

//---------------TIME OUT---------------------------------


