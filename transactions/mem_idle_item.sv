class mem_idle_item extends mem_transaction;
    `uvm_object_utils(mem_idle_item)

    function new(string name="mem_trans");
        super.new(name);
    endfunction : new

    constraint idle{
        mem_sel_en == 1'b0;
        mem_addr == 8'd0;
        mem_wr_data == 8'd0;
        mem_wr_rd_s == 1'b0;
    }
endclass