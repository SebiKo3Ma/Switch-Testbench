import uvm_pkg::*;
`include "uvm_macros.svh"

`include "tests/mem_test.sv"
`include "tests/mem_crt_test.sv"
`include "clk_if.sv"
`include "input_agent/input_if.sv"
`include "mem_agent/mem_if.sv"
`include "output_agent/output_if.sv"
`include "rst_agent/rst_if.sv"

module testbench;
    bit clk_tb;

    clk_if clk_vif(clk_tb);
    input_if in_vif(clk_vif);
    mem_if mem_vif(clk_vif);
    output_if out_vif0(clk_vif);
    output_if out_vif1(clk_vif);
    output_if out_vif2(clk_vif);
    output_if out_vif3(clk_vif);
    rst_if rst_vif(clk_vif);

    wire  [3:0] port_ready_wire, port_read_wire;
    wire [31:0] port_out_wire;

    assign out_vif0.port_ready = port_ready_wire[0];
    assign out_vif0.port_read  =  port_read_wire[0];
    assign out_vif0.port_out   = port_out_wire[7:0];

    assign out_vif1.port_ready = port_ready_wire[1];
    assign out_vif1.port_read  =  port_read_wire[1];
    assign out_vif1.port_out   = port_out_wire[15:8];

    assign out_vif2.port_ready = port_ready_wire[2];
    assign out_vif2.port_read  =  port_read_wire[2];
    assign out_vif2.port_out   = port_out_wire[23:16];

    assign out_vif3.port_ready = port_ready_wire[3];
    assign out_vif3.port_read  =  port_read_wire[3];
    assign out_vif3.port_out   = port_out_wire[31:24];

    switch_top DUT(
        .clk            (clk_vif.clk),
        .rst_n          (rst_vif.rst_n),
        .data_in        (in_vif.data_in),
        .sw_enable_in   (in_vif.sw_enable_in),
        .port_read      (port_read_wire),
        .mem_sel_en     (mem_vif.mem_sel_en),
        .mem_wr_rd_s    (mem_vif.mem_wr_rd_s),
        .mem_addr       (mem_vif.mem_addr),
        .mem_wr_data    (mem_vif.mem_wr_data),
        .read_out       (in_vif.read_out),
        .port_out       (port_out_wire),
        .port_ready     (port_ready_wire),
        .mem_rd_data    (mem_vif.mem_rd_data),
        .mem_ack        (mem_vif.mem_ack)
    );

    initial begin
        clk_tb = 1'b0;
        forever #5 clk_tb = ~clk_tb;
    end

    initial begin
        uvm_config_db#(virtual rst_if)::set(null, "uvm_test_top.env.rst_agt*", "vif", rst_vif);
        uvm_config_db#(virtual input_if)::set(null, "uvm_test_top.env.in_agt*", "vif", in_vif);
        uvm_config_db#(virtual mem_if)::set(null, "uvm_test_top.env.mem_agt*", "vif", mem_vif);
        uvm_config_db#(virtual output_if)::set(null, "uvm_test_top.env.out_agt0*", "vif", out_vif0);
        uvm_config_db#(virtual output_if)::set(null, "uvm_test_top.env.out_agt1*", "vif", out_vif1);
        uvm_config_db#(virtual output_if)::set(null, "uvm_test_top.env.out_agt2*", "vif", out_vif2);
        uvm_config_db#(virtual output_if)::set(null, "uvm_test_top.env.out_agt3*", "vif", out_vif3);
        uvm_config_db#(virtual mem_if)::set(null, "uvm_test_top.env", "vif", mem_vif);
    end

    initial begin
        run_test("mem_crt_test");
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end
endmodule