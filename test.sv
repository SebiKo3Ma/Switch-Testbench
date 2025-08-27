import uvm_pkg::*;
`include "uvm_macros.svh"
import testbench_pkg::*;
`include "seq_packet_send_valid.sv"
`include "rst_sequence.sv"

class test extends uvm_test;
    `uvm_component_utils(test)

    environment env;
    seq_packet_send_valid in_seq;
    rst_sequence rst_seq;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
    super.build_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - BUILD ---"), UVM_DEBUG);
        env = environment::type_id::create("env", this); 
        in_seq = seq_packet_send_valid::type_id::create("in_seq");
        rst_seq = rst_sequence::type_id::create("rst_seq");

        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - BUILD ---"), UVM_DEBUG);
    endfunction : build_phase
    
    function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - START OF SIMULATION ---"), UVM_DEBUG);
        uvm_top.print_topology();
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - START OF SIMULATION ---"), UVM_DEBUG);
    endfunction : start_of_simulation_phase
  
    task main_phase(uvm_phase phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - MAIN ---"), UVM_DEBUG);
        phase.phase_done.set_drain_time(this, 20ns);

        phase.raise_objection(this);
        fork
            rst_seq.start(env.rst_agt.seqr);
            in_seq.start(env.in_agt.seqr);
        join
        phase.drop_objection(this);  
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - MAIN ---"), UVM_DEBUG);  
    endtask : main_phase
endclass