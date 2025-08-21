class output_driver extends master_driver #(output_transaction, virtual output_if.drv_mp);
    `uvm_component_utils(output_driver)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual task do_reset();
        vif.drv_cb.port_read <= 1'b0;
    endtask : do_reset

    virtual task drive_signals(input_transaction trans);
        vif.drv_cb.port_read <= trans.port_read;
    endtask : drive_signals  
endclass