class mem_transaction extends uvm_sequence_item;
    `uvm_object_utils(mem_transaction)

    rand logic       mem_sel_en;
    rand logic [7:0] mem_addr;
    rand logic [7:0] mem_wr_data;
         logic [7:0] mem_rd_data;
    rand logic       mem_wr_rd_s;
         logic       mem_ack;

    function new(string name = "mem_trans");
        super.new(name);
    endfunction : new

    function string toString();
        return $sformatf("%3t - mem_sel_en: %1b, mem_addr: %8b, mem_wr_data: %8b, mem_wr_rd_s: %1b, mem_rd_data: %8b, mem_ack: %1b", 
               $time, mem_sel_en, mem_addr, mem_wr_data, mem_wr_rd_s, mem_rd_data, mem_ack);
    endfunction : toString
endclass