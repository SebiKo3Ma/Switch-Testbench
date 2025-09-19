import uvm_pkg::*;
`include "uvm_macros.svh"
import testbench_pkg::*;

virtual class base_test extends uvm_test;

    environment env;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
    super.build_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - BUILD ---"), UVM_DEBUG);
        env = environment::type_id::create("env", this); 
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - BUILD ---"), UVM_DEBUG);
    endfunction : build_phase
    
    function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - START OF SIMULATION ---"), UVM_DEBUG);
        uvm_top.print_topology();
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - START OF SIMULATION ---"), UVM_DEBUG);
    endfunction : start_of_simulation_phase
endclass