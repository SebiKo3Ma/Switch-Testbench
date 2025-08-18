class input_driver extends uvm_driver #(input_transaction);
    `uvm_object_utils(input_driver)

    virtual input_if.drv_mp vif;
    input_transaction trans;

    function new(string name, uvm_component parent)
        super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - BUILD ---", UVM_DEBUG));
        if(!uvm_config_db#(virtual input_if) :: get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "Input interface not set at top level!");
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - BUILD ---", UVM_DEBUG));
    endfunction : build_phase

    task reset_phase(uvm_phase phase);
        super.reset_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - RESET ---", UVM_DEBUG));
        phase.raise_objection(this);

        vif.data_in <= 8'd0;
        vif.sw_enable_in <= 1'b0;

        phase.drop_objection(this);    
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - RESET ---", UVM_DEBUG));

    endtask : reset_phase

    task main_phase(uvm_phase phase)
        super.main_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - MAIN  ---", UVM_DEBUG));
        forever begin
            seq_item_port.get_next_item(trans);
            `uvm_info(get_name(), $sformatf("Driving input transaction: %s", trans.toString), UVM_HIGH);

            vif.drv_cb.data_in <= trans.data_in;
            vif.drv_cb.sw_enable_in <= trans.sw_enable_in;

            seq_item_port.item_done();
        end
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - MAIN  ---", UVM_DEBUG));
    endtask : main_phase  
endclass