class output_driver extends uvm_driver #(output_transaction);
    `uvm_object_utils(output_driver)

    virtual output_if.drv_mp vif;
    output_transaction trans;

    function new(string name, uvm_component parent)
        super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - BUILD ---", UVM_DEBUG));
        if(!uvm_config_db#(virtual output_if) :: get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "Output interface not set at top level!");
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - BUILD ---", UVM_DEBUG));
    endfunction : build_phase

    task reset_phase(uvm_phase phase);
        super.reset_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - RESET ---", UVM_DEBUG));
        phase.raise_objection(this);

        vif.port_read <= 1'b0;

        phase.drop_objection(this);    
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - RESET ---", UVM_DEBUG));

    endtask : reset_phase

    task main_phase(uvm_phase phase)
        super.main_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - MAIN  ---", UVM_DEBUG));
        forever begin
            seq_item_port.get_next_item(trans);
            `uvm_info(get_name(), $sformatf("Driving output transaction: %s", trans.toString), UVM_HIGH);

            vif.drv_cb.port_read <= trans.port_read;

            seq_item_port.item_done();
        end
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - MAIN  ---", UVM_DEBUG));
    endtask : main_phase  
endclass