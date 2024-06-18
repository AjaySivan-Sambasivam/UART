class agt_top extends uvm_env;
	`uvm_component_utils(agt_top)
	uart_agent agnth[];
	env_config m_cfg;
	extern function new(string name = "agt_top",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass
function agt_top::new(string name = "agt_top",uvm_component parent);
	super.new(name,parent);
endfunction

function void agt_top::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(env_config)::get(this,"","env_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")

	if(m_cfg.has_agent)
	agnth=new[m_cfg.agents];
	foreach(agnth[i])
	begin
	uvm_config_db#(agent_config)::set(this,$sformatf("agnth[%0d]*",i),"agent_config",m_cfg.agent_cfg[i]);
	agnth[i]= uart_agent::type_id::create($sformatf("agnth[%0d]",i),this);
	end
endfunction
function void agt_top::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
endfunction

task agt_top::run_phase(uvm_phase phase);
	uvm_top.print_topology();
endtask




