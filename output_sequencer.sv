class output_sequencer extends uvm_sequencer;
    `uvm_component_utils(output_sequencer)

    function new(string name, uvm_object parent)
        super.new(name, parent);
    endfunction
endclass