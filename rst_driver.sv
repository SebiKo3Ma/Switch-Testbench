class rst_driver extends master_driver #(rst_transaction, virtual clk_rst_if.drv_mp);
    `uvm_object_utils(rst_driver)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual task do_reset();
        vif.drv_cb.rst_n <= 1'd1;
    endtask : do_reset

    virtual task drive_signals(input_transaction trans);
        vif.drv_cb.rst_n <= trans.rst_n;
    endtask : drive_signals  
endclass