class mem_sequencer extends uvm_sequencer;
    `uvm_component_utils(mem_sequencer)

    function new(string name, uvm_object parent)
        super.new(name, parent);
    endfunction
endclass