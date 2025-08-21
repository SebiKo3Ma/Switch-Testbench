class input_transaction extends uvm_sequence_item;
    `uvm_object_utils(input_transaction)

    rand logic [7:0] data_in;
    rand logic       sw_enable_in;
         logic       read_out;

    function new(string name="in_trans");
        super.new(name);
    endfunction : new

    function string toString();
        return $sformatf("%3t - data_in: %8b, sw_enable_in: %1b, read_out: %1b", $time, data_in, sw_enable_in, read_out);
    endfunction : toString
endclass