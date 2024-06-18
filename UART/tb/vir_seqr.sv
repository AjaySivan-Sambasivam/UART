class virtual_sequencer extends uvm_sequencer#(uvm_sequence_item);
`uvm_component_utils(virtual_sequencer)
	uart_sequencer seqrh[];
	env_config m_cfg;
	extern function new(string name="virtual_sequencer",uvm_component parent);
endclass
function virtual_sequencer::new(string name="virtual_sequencer",uvm_component parent);
super.new(name,parent);
 if(!uvm_config_db #(env_config)::get(this,"","env_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
	seqrh=new[m_cfg.agents];

endfunction


