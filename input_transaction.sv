class input_transaction extends uvm_sequence_item;
    `uvm_object_utils(input_transaction)

    rand logic [7:0] data_in;
    rand logic       sw_enable_in;
         logic       read_out;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    function toString();
        return $sformatf("%3t - data_in: %8b, sw_enable_in: %1b, read_out: %1b", data_in, sw_enable_in, read_out);
    endfunction
endclass