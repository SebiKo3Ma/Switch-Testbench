class mem_read_item extends mem_transaction;
    `uvm_object_utils(mem_read_item)

    function new(string name="mem_trans");
        super.new(name);
    endfunction : new

    constraint read{
        mem_wr_rd_s == 1'b0;
    }

    constraint valid_address{
        mem_addr >= 'd0;
        mem_addr <= 'd3;
    }

    constraint enabled{
        mem_sel_en == 1'b1;
    }

    constraint no_data{
        mem_wr_data == 8'd0;
    }
endclass