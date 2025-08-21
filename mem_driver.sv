class mem_driver extends master_driver #(mem_transaction, virtual mem_if.drv_mp);
    `uvm_object_utils(mem_driver)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual task do_reset();
        vif.drv_cb.mem_sel_en  <= 1'b0;
        vif.drv_cb.mem_addr    <= 8'd0;
        vif.drv_cb.mem_wr_data <= 8'd0;
        vif.drv_cb.mem_wr_rd_s <= 1'b0;
    endtask : do_reset

    virtual task drive_signals(input_transaction trans);
        vif.drv_cb.mem_sel_en  <= trans.mem_sel_en;
        vif.drv_cb.mem_addr    <= trans.mem_addr;
        vif.drv_cb.mem_wr_data <= trans.mem_wr_data;
        vif.drv_cb.mem_wr_rd_s <= trans.mem_wr_rd_s;
    endtask : drive_signals 
endclass 