class output_agent extends uvm_agent;
    `uvm_component_utils(output_agent);

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    output_driver drv;
    output_monitor mon;
    output_sequencer seqr;
    virtual output_if vif;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - BUILD ---"), UVM_DEBUG);

        if(!uvm_config_db(virtual output_if) :: get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "Virtual interface not set at top level!");

        seqr = output_sequencer::type_id::create("out_seqr", this);

        drv = output_driver::type_id::create("out_drv", this);
        drv.vif = vif.drv_mp;

        mon = output_monitor::type_id::create("out_drv", this);
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