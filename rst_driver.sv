class rst_driver extends uvm_driver #(rst_transaction);
    `uvm_component_utils(rst_driver)

    rst_transaction trans;
    virtual clk_rst_if.drv_mp vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - BUILD ---"), UVM_DEBUG);
        if(!uvm_config_db#(virtual clk_rst_if.drv_mp) :: get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "Virtual interface not set at top level!");
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - BUILD ---"), UVM_DEBUG);
    endfunction : build_phase

    task do_reset();
        vif.drv_cb.rst_n <= 1'd1;
    endtask : do_reset

    task drive_signals(rst_transaction trans);
        vif.drv_cb.rst_n <= trans.rst_n;
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
            seq_item_port.get_next_item(trans);
            `uvm_info(get_name(), $sformatf("Driving input transaction: %s", trans.toString), UVM_HIGH);
            drive_signals(trans);
            seq_item_port.item_done();
        end
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - MAIN  ---"), UVM_DEBUG);
    endtask : run_phase  
endclass