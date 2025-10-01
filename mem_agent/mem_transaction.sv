class mem_transaction extends uvm_sequence_item;
    `uvm_object_utils(mem_transaction)

    bit protocol_invalid;  
    randc logic [7:0] mem_addr;
    rand logic  [7:0] mem_wr_data;
         logic  [31:0] mem_rd_data;
    rand logic        mem_wr_rd_s;
         logic        mem_ack;

    function new(string name = "mem_trans");
        super.new(name);
        protocol_invalid = 0;
    endfunction : new

    function string toString();
        return $sformatf("%3t - mem_addr: %8b, mem_wr_data: %8b, mem_wr_rd_s: %1b, mem_rd_data: %8b, mem_ack: %1b", 
               $time, mem_addr, mem_wr_data, mem_wr_rd_s, mem_rd_data, mem_ack);
    endfunction : toString

    function void doCopy(mem_transaction trans);
        this.mem_addr = trans.mem_addr;
        this.mem_wr_data = trans.mem_wr_data;
        this.mem_rd_data = trans.mem_rd_data;
        this.mem_wr_rd_s = trans.mem_wr_rd_s;
        this.mem_ack = trans.mem_ack;
    endfunction
endclass