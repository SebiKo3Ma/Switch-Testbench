`include "rst_sequence.sv"
`include "mem_sequence.sv"
`include "base_test.sv"

class mem_test extends base_test;
    `uvm_component_utils(mem_test)
    
    rst_sequence rst_seq;
    mem_sequence mem_seq;

    function new(string name = "mem_test", uvm_component parent);
        super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - BUILD ---"), UVM_DEBUG);
        rst_seq = rst_sequence::type_id::create("rst_seq");
        mem_seq = mem_sequence::type_id::create("mem_seq");
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - BUILD ---"), UVM_DEBUG);
    endfunction : build_phase

    task main_phase(uvm_phase phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - MAIN ---"), UVM_DEBUG);
        phase.phase_done.set_drain_time(this, 20ns);

        phase.raise_objection(this);
            rst_seq.start(env.rst_agt.seqr);
            mem_seq.start(env.mem_agt.seqr);
        phase.drop_objection(this);  
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - MAIN ---"), UVM_DEBUG);  
    endtask : main_phase
endclass
