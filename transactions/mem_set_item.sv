class mem_set_item extends mem_transaction;
    `uvm_object_utils(mem_set_item)

    function new(string name="mem_trans");
        super.new(name);
    endfunction : new

    constraint write{
        mem_wr_rd_s == 1'b1;
    }

    constraint valid_address{
        mem_addr inside {[8'd0:8'd3]};
    }

    constraint enabled{
        mem_sel_en == 1'b1;
    }
endclass