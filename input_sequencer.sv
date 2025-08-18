class input_sequencer extends uvm_sequencer #(input_transaction);
    `uvm_component_utils(input_sequencer)

    function new(string name, uvm_object parent)
        super.new(name, parent);
    endfunction : new
endclass