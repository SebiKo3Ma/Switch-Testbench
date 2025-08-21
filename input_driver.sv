class input_driver extends master_driver #(input_transaction, virtual input_if.drv_mp);
    `uvm_component_utils(input_driver)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual task do_reset();
        vif.drv_cb.data_in <= 8'd0;
        vif.drv_cb.sw_enable_in <= 1'b0;
    endtask : do_reset

    virtual task drive_signals(input_transaction trans);
        vif.drv_cb.data_in <= trans.data_in;
        vif.drv_cb.sw_enable_in <= trans.sw_enable_in;
    endtask : drive_signals  
endclass