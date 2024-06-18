class env_config extends uvm_object;

	`uvm_object_utils(env_config)
	bit has_agent = 1;
	agent_config agent_cfg[];
	int agents = 2;
	bit has_scoreborad = 1;
	bit has_virtual_sequencer=1;

	extern function new(string name = "env_config");
endclass

function env_config::new(string name = "env_config");
	super.new(name);
endfunction


