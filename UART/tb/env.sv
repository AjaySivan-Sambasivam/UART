class uart_env extends uvm_env;
	`uvm_component_utils(uart_env)
	agt_top top;
	env_config m_cfg;
//scoreboard sbh;
virtual_sequencer v_sequencer;
	extern function new(string name = "uart_env",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);

endclass
function uart_env::new(string name = "uart_env",uvm_component parent);
	super.new(name,parent);
endfunction

function void uart_env::build_phase(uvm_phase phase);
	super.build_phase(phase);
	 if(!uvm_config_db #(env_config)::get(this,"","env_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
	//if(m_cfg.has_agent) begin
          		top=agt_top::type_id::create("top",this);
      // end
//	if(m_cfg.has_scoreborad)
//	sbh=scoreboard::type_id::create("sbh",this);
	//if(m_cfg.has_virtual_sequencer)	
	v_sequencer=virtual_sequencer::type_id::create("v_seqh",this);
  
endfunction

function void uart_env::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
//if(m_cfg.has_virtual_sequencer)
			// begin
                        //if(m_cfg.has_agent)
				//foreach(top.agnth[i])
				for(int i=0;i<m_cfg.agents;i++)
				begin
				v_sequencer.seqrh[i] = top.agnth[i].seqrh;
				end
			//end
	/*	if(m_cfg.has_scoreboard)
		begin
			 if(m_cfg.has_sagent)
			foreach(sagent_top.agnth[i])
			begin
				sagent_top.agnth[i].monh.monitor_port.connect(sbh.fifo_sh[i].analysis_export);
			end*/


endfunction




