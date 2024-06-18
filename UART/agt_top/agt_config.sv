class agent_config extends uvm_object;
	
	`uvm_object_utils(agent_config)
	virtual uart_if vif;

	uvm_active_passive_enum is_active = UVM_ACTIVE;
	extern function new(string name = "agent_config");
endclass
function agent_config::new(string name = "agent_config");
	super.new(name);
endfunction



