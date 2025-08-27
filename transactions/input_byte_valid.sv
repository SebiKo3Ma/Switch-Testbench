class input_byte_valid extends input_transaction;
    `uvm_object_utils(input_byte_valid)

    function new(string name="in_trans");
        super.new(name);
    endfunction : new

    constraint no_reserved_values{
        data_in != 8'hFF;
        data_in != 8'h55;
    }

    constraint enabled{
        sw_enable_in == 1'b1;
    }
endclass