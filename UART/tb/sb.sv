class scoreboard extends uvm_scoreboard;

        `uvm_component_utils(scoreboard)

        uvm_tlm_analysis_fifo#(trans) fifo_sh[];

        env_config m_cfg;
        trans t1,t2;

	//trans cov_data;

	int thr1size, thr2size, rbr1size, rbr2size;

        extern function new(string name = "scoreboard",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
        extern function void check_phase(uvm_phase phase);

	/*covergroup uart_signals_cov;
		option.per_instance=1;

		DATA: coverpoint cov_data.dat_i[7:0] { bins data_i = {[0:255]}; }

		ADDRESS: coverpoint cov_data.addr_i[2:0] { bins addr_sign = {[0:7]}; }

		WR_ENB: coverpoint cov_data.we_i { bins rd = {0};
						bins wr = {1}; }  
	endgroup

	covergroup uart_lcr_cov;
                option.per_instance=1;

                CHAR_SIZE: coverpoint cov_data.lcr[1:0] { bins five = {2'b00};
                                                          bins six = {2'b01};
                                                          bins seven = {2'b10};
                                                          bins eight = {2'b11}; }

                STOP_BIT: coverpoint cov_data.lcr[2] { bins one = {1'b0};
                                                        bins more = {1'b1}; }

                PARITY: coverpoint cov_data.lcr[3] { bins no_parity = {1'b0};
                                                        bins parity_en = {1'b1}; }
		
                EV_ODD_PARITY: coverpoint cov_data.lcr[4] { bins odd_parity = {1'b0};
								bins even_parity = {1'b1};}
		
		
                STICK_PARITY: coverpoint cov_data.lcr[5] { bins no_stick_parity = {1'b0};
                                                        bins stick_parity = {1'b1}; }

                BREAK: coverpoint cov_data.lcr[6] { bins low = {1'b0};
                                                        bins high = {1'b1}; }

                DIV_LCH: coverpoint cov_data.lcr[7] { bins low = {1'b0};
                                                        bins high = {1'b1}; }

		LCR_RST: coverpoint cov_data.lcr[7:0] { bins lcr_rst = {8'd3};}

                CHAR_SIZE_X_STOP_BIT_X_EV_ODD_PARITY: cross CHAR_SIZE,STOP_BIT,EV_ODD_PARITY;
        endgroup

        covergroup uart_ier_cov;
                option.per_instance=1;

                RCVD_INT: coverpoint cov_data.ier[0] { bins dis = {1'b0};
                                                        bins en = {1'b1}; }

                THRE_INT: coverpoint cov_data.ier[1] { bins dis = {1'b0};
                                                        bins en = {1'b1}; }

                LSR_INT: coverpoint cov_data.ier[2] { bins dis = {1'b0};
                                                        bins en = {1'b1}; }

		IER_RST: coverpoint cov_data.ier[7:0] { bins ier_rst = {8'd0};}

        endgroup

        covergroup uart_fcr_cov;
                option.per_instance=1;

                RFIFO: coverpoint cov_data.fcr[1] { bins dis = {1'b0};
                                                    bins clr = {1'b1}; }

                TFIFO: coverpoint cov_data.fcr[2] { bins dis = {1'b0};
                                                    bins clr = {1'b1}; }

                TRG_LVL: coverpoint cov_data.fcr[7:6] { bins one = {2'b00};
                                                        bins four = {2'b01};
                                                        bins eight = {2'b10};
                                                        bins fourteen = {2'b11}; }
		
		//FCR_RST: coverpoint cov_data.fcr[7:0] { bins fcr_rst = {8'd192};}

        endgroup

        covergroup uart_mcr_cov;
                option.per_instance=1;

                LB: coverpoint cov_data.mcr[4] {bins dis = {1'b0};
                                                bins en = {1'b1}; }
	
		MCR_RST: coverpoint cov_data.mcr[7:0] { bins lcr_rst = {8'd0};}

        endgroup

        covergroup uart_iir_cov;
                option.per_instance=1;

                IIR: coverpoint cov_data.iir[3:1] {bins lsr = {3'b011};
                                                   bins rdf = {3'b010};
                                                   bins ti_o = {3'b110};
                                                   bins threm = {3'b001}; }
		
	//	IIR_RST: coverpoint cov_data.iir[3:0] { bins iir_rst = {4'h1};}

        endgroup

        covergroup uart_lsr_cov;
                option.per_instance=1;

                DATA_READY: coverpoint cov_data.lsr[0] {bins fifoempty = {1'b0};
                                                        bins datarcvd = {1'b1}; }

                OVER_RUN: coverpoint cov_data.lsr[1] {bins nooverrun = {1'b0};
                                                        bins overrun = {1'b1}; }

                PARITY_ERR: coverpoint cov_data.lsr[2] {bins noparityerr = {1'b0};
                                                        bins parityerr = {1'b1} ;}

                FRAME_ERR: coverpoint cov_data.lsr[3] {bins noframeerr = {1'b0};
                                                        bins frameerr = {1'b1}; }

                BREAK_INT: coverpoint cov_data.lsr[4] {bins nobreakint = {1'b0};
                                                        bins breakint = {1'b1}; }

                THR_EMP: coverpoint cov_data.lsr[5] {bins thrnotemp = {1'b0};
                                                        bins thremo = {1'b1}; }

        endgroup*/
endclass

function scoreboard::new(string name = "scoreboard",uvm_component parent);
        super.new(name,parent);
/*	uart_signals_cov = new();
	uart_lcr_cov = new();
        uart_ier_cov = new();
        uart_fcr_cov = new();
        uart_mcr_cov = new();
        uart_iir_cov = new();
        uart_lsr_cov = new();*/
endfunction

function void scoreboard::build_phase(uvm_phase phase);
        if(!uvm_config_db#(env_config)::get(this,"","env_config",m_cfg))
                `uvm_fatal("Scoreboard","Cannot get configuration object from Env")

        fifo_sh = new[m_cfg.agents];

        foreach(fifo_sh[i]) begin
        fifo_sh[i] = new($sformatf("fifo_sh[%0d]",i),this);
        end
        super.build_phase(phase);
endfunction

task scoreboard::run_phase(uvm_phase phase);
fork
	
        forever
                begin
                        fifo_sh[0].get(t1);
        

			thr1size = t1.thr.size;
			rbr1size = t1.rb.size;
			`uvm_info("SCOREBOARD",$sformatf("priting from scoreboard of UART1 \n %s",t1.sprint()),UVM_LOW)
			//cov_data=uart1;
			/*uart_signals_cov.sample();
	                uart_lcr_cov.sample();
        	        uart_ie_cov.sample();
                	uart_fcr_cov.sample();
	                uart_mcr_cov.sample();
        	        uart_iir_cov.sample();
                  uart_ls_cov.sample();*/
                end

        forever
                begin
                        fifo_sh[1].get(t2);

			thr2size = t2.thr.size;
			rbr2size = t2.rb.size;
			`uvm_info("SCOREBOARD",$sformatf("priting from scoreboard of UART2 \n %s",t2.sprint()),UVM_LOW)
			/*cov_data=uart2;
			uart_signals_cov.sample();
	                uart_lcr_cov.sample();
        	        uart_ie_cov.sample();
                	uart_fcr_cov.sample();
	                uart_mcr_cov.sample();
        	        uart_iir_cov.sample();
                	uart_ls_cov.sample();*/
                end
	
join
endtask

function void scoreboard::check_phase(uvm_phase phase);
	$display("size of thr 1 = %p \n",thr1size);
	$display("size of thr 2 = %p \n",thr2size);
	$display("size of rbr 1 = %p \n",rbr1size);
	$display("size of rbr 2 = %p \n",rbr2size);
	$display("values sent by UART1 = %p \n",t1.thr);
	$display("values sent by UART2 = %p \n",t2.thr);
	$display("values received by UART1 = %p \n",t1.rb);
	$display("values received by UART2 = %p \n",t2.rb);	
	
	//THR_EMPTY_CONDITION
	if(t1.ie[1]==1 && t1.iir[3:1]==3'b001 && t1.ls[5]==1) 
  $display("THR EMPTY IN UART1 \n");
	if(t2.ie[1]==1 && t2.iir[3:1]==3'b001 && t2.ls[5]==1) 
  $display("THR EMPTY IN UART2 \n");

	//BREAK_INTERRUPT
	if(t1.lcr[6]==1 && t1.ie[2]==1 && t1.iir[3:1]==3'b011 && t1.ls[4]==1) 
  $display("BREAK INTERRUPT IN UART1 \n");
	if(t2.lcr[6]==1 && t2.ie[2]==1 && t2.iir[3:1]==3'b011 && t2.ls[4]==1) 
  $display("BREAK INTERRUPT IN UART2 \n");

	//FRAMING_ERROR
	if(t1.ie[2]==1 && t1.iir[3:1]==3 && t1.ls[3]==1) 
  $display("FRAMING ERROR IN UART1 \n");
	if(t2.ie[2]==1 && t2.iir[3:1]==3 && t2.ls[3]==1) 
  $display("FRAMING ERROR IN UART2 \n");

	//TIMEOUT_CONDITION
	if(t1.fcr[7:6]!=t2.fcr[7:6])
	begin
		if(t1.iir[3:1]==6) 
    $display("TIMEOUT OCCURED AT UART1 \n");
		if(t2.iir[3:1]==6) 
    $display("TIMEOUT OCCURED AT UART2 \n");
	end

	//PARITY_ERROR
	if(t1.lcr[3]==1 && t1.ie[2]==1 && t1.iir[3:1]==3 && t1.ls[2]==1) 
  $display("PARITY ERROR IN UART1 \n");
	if(t2.lcr[3]==1 && t2.ie[2]==1 && t2.iir[3:1]==3 && t2.ls[2]==1) 
  $display("PARITY ERROR IN UART2 \n");

	//OVERRUN_ERROR
	if(t1.ie[2]==1 && t1.iir[3:1]==3 && t1.ls[1]==1) 
  $display("OVERRUN ERROR IN UART1 \n");
	if(t2.ie[2]==1 && t2.iir[3:1]==3 && t2.ls[1]==1) 
  $display("OVERRUN ERROR IN UART2 \n");
	
	if(t1.mcr[4]==1)
	begin
		if(thr1size!=0)
		begin
			if(t1.thr==t1.rb) 
      $display("LOOPBACK IN UART1 SUCCESSFUL \n");
			else 
      $display("LOOPBACK IN UART1 FAILED \n");
		end
	end

	if(t2.mcr[4]==1)
	begin
		if(thr2size!=0)
		begin
			if(t2.thr==t2.rb) 
      $display("LOOPBACK IN UART2 SUCCESSFUL \n");
			else 
      $display("LOOPBACK IN UART2 FAILED \n");
		end
	end

		if((thr1size!=0)&&(thr2size!=0)&&(t1.thr==t2.rb)&&(t2.thr==t1.rb)) 
    $display("FULL DUPLEX SUCCESSFUL \n");
		else 
    $display("FULL DUPLEX FAILED \n");

		if((thr1size!=0)&&(thr2size==0))
		begin
			if(t1.thr==t2.rb)
      $display("HALF DUPLEX FROM UART1 TO UART2 IS SUCCESSFUL \n");
			else 
      $display("HALF DUPLEX FAILED \n");
		end

		if((thr2size!=0)&&(thr1size==0))
		begin
			if(t2.thr==t1.rb) 
      $display("HALF DUPLEX FROM UART2 TO UART1 IS SUCCESSFUL \n");
			else 
      $display("HALF DUPLEX FAILED \n");
		end

		if((thr1size==0)&&(thr2size==0)) 
    $display("NO DATA IN THR1 AND THR2. SOMETHING WENT WRONG. \n");
	

endfunction



