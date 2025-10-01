class rst_driver extends uvm_driver #(rst_transaction);
    `uvm_component_utils(rst_driver)

    rst_transaction trans;
    virtual rst_if.drv_mp vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    task reset_signals();
        vif.drv_cb.rst_n <= 1'd1;
    endtask : reset_signals

    task drive_signals(rst_transaction trans);
        vif.drv_cb.rst_n <= trans.rst_n;
    endtask : drive_signals  

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - RUN ---"), UVM_DEBUG);
        reset_signals();
        forever begin
            @vif.drv_cb
            seq_item_port.get_next_item(trans);
            `uvm_info(get_name(), $sformatf("Driving input transaction: %s", trans.toString), UVM_HIGH);
            drive_signals(trans);
            seq_item_port.item_done();
        end
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - RUN ---"), UVM_DEBUG);
    endtask : run_phase  
endclass