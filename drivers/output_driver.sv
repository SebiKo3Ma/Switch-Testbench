class output_driver extends uvm_driver #(output_transaction);
    `uvm_component_utils(output_driver)

    output_transaction trans;
    virtual output_if.drv_mp vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    // function void build_phase(uvm_phase phase);
    //     super.build_phase(phase);
    //     `uvm_info(get_name(), $sformatf("--- ENTER PHASE - BUILD ---"), UVM_DEBUG);
    //     if(!uvm_config_db#(virtual output_if.drv_mp) :: get(this, "", "vif", vif))
    //         `uvm_fatal(get_type_name(), "Virtual interface not set at top level!");
    //     `uvm_info(get_name(), $sformatf("---  EXIT PHASE - BUILD ---"), UVM_DEBUG);
    // endfunction : build_phase

    task do_reset();
        vif.drv_cb.port_read <= 1'b0;
    endtask : do_reset

    task drive_signals(output_transaction trans);
        vif.drv_cb.port_read <= trans.port_read;
    endtask : drive_signals

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - RESET ---"), UVM_DEBUG);
        phase.raise_objection(this);
        do_reset();
        phase.drop_objection(this);    
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - RESET ---"), UVM_DEBUG);

        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - MAIN  ---"), UVM_DEBUG);
        forever begin
            @vif.drv_cb
            seq_item_port.get_next_item(trans);
            `uvm_info(get_name(), $sformatf("Driving input transaction: %s", trans.toString), UVM_HIGH);
            drive_signals(trans);
            seq_item_port.item_done();
        end
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - MAIN  ---"), UVM_DEBUG);
    endtask : run_phase    
endclass