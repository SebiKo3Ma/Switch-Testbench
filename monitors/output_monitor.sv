class output_monitor extends uvm_monitor;
    `uvm_component_utils(output_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual output_if.mon_mp vif;
    uvm_analysis_port #(output_transaction) an_port;
    output_transaction trans;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - BUILD ---"), UVM_DEBUG);
        trans = new("trans");
        an_port = new("an_port", this);
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - BUILD ---"), UVM_DEBUG);
    endfunction : build_phase

    task get_signals(output_transaction trans);
        trans.port_out     <= vif.mon_cb.port_out;
        trans.port_ready   <= vif.mon_cb.port_ready;
        trans.port_read    <= vif.mon_cb.port_read;
    endtask : get_signals

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE -  RUN  ---"), UVM_DEBUG);
        forever begin
            @vif.mon_cb
            get_signals(trans);
            `uvm_info(get_name(), $sformatf("Monitoring output transaction: %s", trans.toString()), UVM_FULL);
            an_port.write(trans);
        end
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE -  RUN  ---"), UVM_DEBUG);
    endtask : run_phase
endclass