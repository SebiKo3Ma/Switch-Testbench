import uvm_pkg::*;
`include "uvm_macros.svh"
import testbench_pkg::*;
`include "input_if.sv"
`include "mem_if.sv"
`include "output_if.sv"
`include "clk_rst_if.sv"

module testbench;
    bit clk_tb;

    clk_rst_if clk_vif(clk_tb);
    input_if in_vif(clk_vif);
    mem_if mem_vif(clk_vif);
    output_if out_vif(clk_vif);

    switch_top DUT(
        .clk            (clk_vif.clk),
        .rst_n          (clk_vif.rst_n),
        .data_in        (in_vif.data_in),
        .sw_enable_in   (in_vif.sw_enable_in),
        .port_read      (out_vif.port_read),
        .mem_sel_en     (mem_vif.mem_sel_en),
        .mem_wr_rd_s    (mem_vif.mem_wr_rd_s),
        .mem_addr       (mem_vif.mem_addr),
        .mem_wr_data    (mem_vif.mem_wr_data),
        .read_out       (in_vif.read_out),
        .port_out       (out_vif.port_out),
        .port_ready     (out_vif.port_ready),
        .mem_rd_data    (mem_vif.mem_rd_data),
        .mem_ack        (mem_vif.mem_ack)
    );

    initial begin
        clk_tb = 1'b0;
        forever #5 clk_tb = ~clk_tb;
    end

    initial begin
        uvm_config_db#(virtual clk_rst_if)::set(null, "uvm_test_top.env.rst_agt", "vif", vif);
        uvm_config_db#(virtual input_if)::set(null, "uvm_test_top.env.in_agt", "vif", vif);
        uvm_config_db#(virtual mem_if)::set(null, "uvm_test_top.env.mem_agt", "vif", vif);
        uvm_config_db#(virtual output_if)::set(null, "uvm_test_top.env.out_agt", "vif", vif);
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end
endmodule