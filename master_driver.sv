class master_driver #(type TRANS = uvm_sequence_item, type VIF = virtual interface) extends uvm_driver #(TRANS);
    `uvm_object_utils(master_driver #(TRANS, VIF))

    VIF vif;
    TRANS trans;

    function new(string name, uvm_component parent)
        super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - BUILD ---", UVM_DEBUG));
        if(!uvm_config_db#(VIF) :: get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "Virtual interface not set at top level!");
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - BUILD ---", UVM_DEBUG));
    endfunction : build_phase

    virtual task do_reset();
        `uvm_fatal(get_type_name(), "do_reset() not implemented in child driver!");
    endtask : do_reset

    virtual task drive_signals(TRANS trans);
        `uvm_fatal(get_type_name(), "drive_signals() not implemented in child driver!");
    endtask : drive_signals

    task reset_phase(uvm_phase phase);
        super.reset_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - RESET ---", UVM_DEBUG));
        phase.raise_objection(this);
        do_reset();
        phase.drop_objection(this);    
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - RESET ---", UVM_DEBUG));
    endtask : reset_phase

    task main_phase(uvm_phase phase)
        super.main_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - MAIN  ---", UVM_DEBUG));
        forever begin
            seq_item_port.get_next_item(trans);
            `uvm_info(get_name(), $sformatf("Driving input transaction: %s", trans.toString), UVM_HIGH);
            drive_signals(trans);
            seq_item_port.item_done();
        end
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - MAIN  ---", UVM_DEBUG));
    endtask : main_phase  
endclass