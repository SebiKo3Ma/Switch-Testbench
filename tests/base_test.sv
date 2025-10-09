`ifndef base_test
`define base_test

import uvm_pkg::*;
`include "uvm_macros.svh"
import testbench_pkg::*;

`include "../rst_agent/rst_init_sequence.sv"

virtual class base_test extends uvm_test;

    environment env;
    rst_init_sequence rst_seq;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
    super.build_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - BUILD ---"), UVM_DEBUG);
        env = environment::type_id::create("env", this);
        rst_seq = rst_init_sequence::type_id::create("rst_seq");
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - BUILD ---"), UVM_DEBUG);
    endfunction : build_phase
    
    function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - START OF SIMULATION ---"), UVM_DEBUG);
        uvm_top.print_topology();
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - START OF SIMULATION ---"), UVM_DEBUG);
    endfunction : start_of_simulation_phase

    task reset_phase(uvm_phase phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - RESET ---"), UVM_DEBUG);
        phase.raise_objection(this);
            rst_seq.start(env.rst_agt.seqr);
        phase.drop_objection(this);  
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - RESET ---"), UVM_DEBUG);  
    endtask : reset_phase
endclass
`endif