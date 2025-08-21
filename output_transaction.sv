class output_transaction extends uvm_sequence_item;
    `uvm_object_utils(output_transaction)

         logic [7:0] port_out;
         logic       port_ready;
    rand logic       port_read;

    function new(string name = "out_trans");
        super.new(name);
    endfunction : new

    function string toString();
        return $sformatf("%3t - port_out: %8b, port_ready: %1b, port_read: %1b", $time, port_out, port_ready, port_read);
    endfunction : toString
endclass