class input_agent extends uvm_agent;
    `uvm_component_utils(input_agent);

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    input_driver drv;
    input_monitor mon;
    input_sequencer seqr;
    virtual input_if vif;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - BUILD ---"), UVM_DEBUG);

        if(!uvm_config_db(virtual input_if) :: get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "Virtual interface not set at top level!");

        seqr = input_sequencer::type_id::create("in_seqr", this);

        drv = input_driver::type_id::create("in_drv", this);
        drv.vif = vif.drv_mp;

        mon = input_monitor::type_id::create("in_drv", this);
        mon.vif = vif.mon_mp;

        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - BUILD ---"), UVM_DEBUG);
    endfunction : build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - CONNECT ---"), UVM_DEBUG);
            drv.seq_item_port.connect(seqr.seq_item_export);
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - CONNECT ---"), UVM_DEBUG);
    endfunction : connect_phase
endclass