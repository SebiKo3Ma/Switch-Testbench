class output_sequencer extends uvm_sequencer #(output_transaction);
    `uvm_component_utils(output_sequencer)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new
endclass