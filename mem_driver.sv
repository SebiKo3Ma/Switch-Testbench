class mem_driver extends uvm_driver #(mem_transaction);
    `uvm_component_utils(mem_driver)

    mem_transaction trans;
    virtual mem_if.drv_mp vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    // function void build_phase(uvm_phase phase);
    //     super.build_phase(phase);
    //     `uvm_info(get_name(), $sformatf("--- ENTER PHASE - BUILD ---"), UVM_DEBUG);
    //     if(!uvm_config_db#(virtual mem_if.drv_mp) :: get(this, "", "vif", vif))
    //         `uvm_fatal(get_type_name(), "Virtual interface not set at top level!");
    //     `uvm_info(get_name(), $sformatf("---  EXIT PHASE - BUILD ---"), UVM_DEBUG);
    // endfunction : build_phase

    task do_reset();
        vif.drv_cb.mem_sel_en  <= 1'b0;
        vif.drv_cb.mem_addr    <= 8'd0;
        vif.drv_cb.mem_wr_data <= 8'd0;
        vif.drv_cb.mem_wr_rd_s <= 1'b0;
    endtask : do_reset

    task drive_signals(mem_transaction trans);
        vif.drv_cb.mem_sel_en  <= trans.mem_sel_en;
        vif.drv_cb.mem_addr    <= trans.mem_addr;
        vif.drv_cb.mem_wr_data <= trans.mem_wr_data;
        vif.drv_cb.mem_wr_rd_s <= trans.mem_wr_rd_s;
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