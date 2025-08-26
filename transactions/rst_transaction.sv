class rst_transaction extends uvm_sequence_item;
    `uvm_object_utils(rst_transaction)

    rand logic rst_n;

    function new(string name = "rst_trans");
        super.new(name);
    endfunction : new

    function string toString();
        return $sformatf("%3t - reset: %1b", $time, rst_n);
    endfunction : toString

    constraint mostly_inactive_reset{
        rst_n dist{1:/19, 0:/1};
    }
endclass