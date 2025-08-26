class output_driver extends uvm_driver #(output_transaction);
    `uvm_component_utils(output_driver)

    output_transaction trans;
    virtual output_if.drv_mp vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    task reset_signals();
        vif.drv_cb.port_read <= 1'b0;
    endtask : reset_signals

    task drive_signals(output_transaction trans);
        vif.drv_cb.port_read <= trans.port_read;
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