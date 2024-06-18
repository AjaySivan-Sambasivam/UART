`timescale 1ns/1ps
module top;

	import uvm_pkg::*;

	import test_pkg::*;
	wire w1,w2;
	bit clock,clock1;
	always #5 clock = ~clock;
	always #10 clock1 = ~clock1;
	uart_if D1(clock);
	uart_if D2(clock1);
uart_top DUV1(.wb_clk_i(clock), .wb_rst_i(D1.wb_rst_i), .wb_adr_i(D1.wb_addr_i), .wb_dat_i(D1.wb_dat_i), .wb_dat_o(D1.wb_dat_o), .wb_we_i(D1.wb_we_i), .wb_stb_i(D1.wb_stb_i), .wb_cyc_i(D1.wb_cyc_i), .wb_ack_o(D1.wb_ack_o), .wb_sel_i(D1.wb_sel_i), .int_o(D1.int_o), .stx_pad_o(w1), .srx_pad_i(w2)); 
uart_top DUV2(.wb_clk_i(clock1), .wb_rst_i(D2.wb_rst_i), .wb_adr_i(D2.wb_addr_i), .wb_dat_i(D2.wb_dat_i), .wb_dat_o(D2.wb_dat_o), .wb_we_i(D2.wb_we_i), .wb_stb_i(D2.wb_stb_i), .wb_cyc_i(D2.wb_cyc_i), .wb_ack_o(D2.wb_ack_o), .wb_sel_i(D2.wb_sel_i), .int_o(D2.int_o), .stx_pad_o(w2), .srx_pad_i(w1)); 

	initial
		begin
			`ifdef VCS
         		$fsdbDumpvars(0, top);
        		`endif

			uvm_config_db#(virtual uart_if)::set(null,"*","vif_0",D1);
			uvm_config_db#(virtual uart_if)::set(null,"*","vif_1",D2);

			run_test();
			
		end
endmodule



