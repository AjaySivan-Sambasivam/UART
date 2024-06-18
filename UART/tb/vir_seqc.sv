class virtual_seq extends uvm_sequence#(uvm_sequence_item);
	`uvm_object_utils(virtual_seq)
	env_config m_cfg;
	uart_sequencer seqrh[];
	//full_seqs_tx f_seq;
	//full_seqs_rx f_seq1;
	virtual_sequencer vseqrh;

	extern function new(string name="virtual_seq");
	extern task body();
endclass

function virtual_seq::new(string name="virtual_seq");
	super.new(name);
endfunction

task virtual_seq::body();
	if(!uvm_config_db#(env_config)::get(null,get_full_name(),"env_config",m_cfg))
	`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set it?")
	seqrh=new[m_cfg.agents];
	if(!$cast(vseqrh,m_sequencer))
		`uvm_fatal("CONFIG","cannot get() casting failed. Have you set it?")
	else	
	foreach(seqrh[i])begin
		seqrh[i]=vseqrh.seqrh[i];
	end
endtask
//--------------------- FULL DUPLEX----------------
class full_duplex extends virtual_seq;
	`uvm_object_utils(full_duplex)
	full_seqs_tx f_seq;
	full_seqs_rx f_seq1;

	extern function new(string name="full_duplex");
	extern task body();
endclass

function full_duplex::new(string name="full_duplex");
	super.new(name);
endfunction

task full_duplex::body();
	super.body();
	f_seq=full_seqs_tx::type_id::create("f_seq");
	f_seq1=full_seqs_rx::type_id::create("f_seq1");
	fork
	f_seq.start(seqrh[0]);
	f_seq1.start(seqrh[1]);
	join

endtask
//---------------------HALF DUPLEX--------------------

class half_duplex extends virtual_seq;
	`uvm_object_utils(half_duplex)
	half_seqs_tx h_seq;
	half_seqs_rx h_seq1;

	extern function new(string name="half_duplex");
	extern task body();
endclass

function half_duplex::new(string name="half_duplex");
	super.new(name);
endfunction

task half_duplex::body();
	super.body();
	h_seq=half_seqs_tx::type_id::create("h_seq");
	h_seq1=half_seqs_rx::type_id::create("h_seq1");
	fork
	h_seq.start(seqrh[0]);
	h_seq1.start(seqrh[1]);
	join

endtask
//------------------------LOOP BACK---------------------
class loopback extends virtual_seq;
	`uvm_object_utils(loopback)
	loop_back l_seq;
	

	extern function new(string name="loopback");
	extern task body();
endclass

function loopback::new(string name="loopback");
	super.new(name);
endfunction

task loopback::body();
	super.body();
	l_seq=loop_back::type_id::create("l_seq");
	fork
	l_seq.start(seqrh[0]);
	join

endtask
//---------------PARITY ERROR-------------------------
class parity extends virtual_seq;
	`uvm_object_utils(parity)
	parity_seqs_tx p_seq;
	parity_seqs_rx p_seq1;

	extern function new(string name="parity");
	extern task body();
endclass

function parity::new(string name="parity");
	super.new(name);
endfunction

task parity::body();
	super.body();
	p_seq=parity_seqs_tx::type_id::create("p_seq");
	p_seq1=parity_seqs_rx::type_id::create("p_seq1");
	fork
	p_seq.start(seqrh[0]);
	p_seq1.start(seqrh[1]);
	join

endtask
//-------------FRAMING ERROR------------------------
class framing extends virtual_seq;
	`uvm_object_utils(framing)
	framing_seqs_tx fa_seq;
	framing_seqs_rx fa_seq1;

	extern function new(string name="framing");
	extern task body();
endclass

function framing::new(string name="framing");
	super.new(name);
endfunction

task framing::body();
	super.body();
	fa_seq=framing_seqs_tx::type_id::create("fa_seq");
	fa_seq1=framing_seqs_rx::type_id::create("fa_seq1");
	fork
	fa_seq.start(seqrh[0]);
	fa_seq1.start(seqrh[1]);
	join

endtask
//-------------OVER RUN---------------------------
class overrun extends virtual_seq;
	`uvm_object_utils(overrun)
	overrun_seqs_tx o_seq;
	overrun_seqs_rx o_seq1;

	extern function new(string name="overrun");
	extern task body();
endclass

function overrun::new(string name="overrun");
	super.new(name);
endfunction

task overrun::body();
	super.body();
	o_seq=overrun_seqs_tx::type_id::create("o_seq");
	o_seq1=overrun_seqs_rx::type_id::create("o_seq1");
	fork
	o_seq.start(seqrh[0]);
	o_seq1.start(seqrh[1]);
	join

endtask
//--------------BREAK INTERRUPT-----------------------
class breakI extends virtual_seq;
	`uvm_object_utils(breakI)
	break_seqs_tx b_seq;
	break_seqs_rx b_seq1;

	extern function new(string name="breakI");
	extern task body();
endclass

function breakI::new(string name="breakI");
	super.new(name);
endfunction

task breakI::body();
	super.body();
	b_seq=break_seqs_tx::type_id::create("b_seq");
	b_seq1=break_seqs_rx::type_id::create("b_seq1");
	fork
	b_seq.start(seqrh[0]);
	b_seq1.start(seqrh[1]);
	join

endtask
//----------------TIME OUT---------------------------


