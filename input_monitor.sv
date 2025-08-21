class input_monitor extends uvm_monitor;
    `uvm_component_utils(input_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual input_if.mon_mp vif;
    uvm_analysis_port #(input_transaction) an_port;
    input_transaction trans;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - BUILD ---"), UVM_DEBUG);
        trans = new("trans", this);
        an_port = new("an_port", this);
        if(!uvm_config_db#(virtual input_if.mon_mp) :: get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "Virtual interface not set at top level!");
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - BUILD ---"), UVM_DEBUG);
    endfunction : build_phase

    task get_signals(input_transaction trans);
        trans.data_in      <= vif.mon_cb.data_in;
        trans.sw_enable_in <= vif.mon_cb.sw_enable_in;
        trans.read_out     <= vif.mon_cb.read_out;
    endtask : get_signals

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE -  RUN  ---"), UVM_DEBUG);
        forever begin
            vif.get_signals(trans);
            `uvm_info(get_name(), $sformatf("Monitoring input transaction: %s", trans.toString()), UVM_FULL);
            an_port.write(trans);
        end
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE -  RUN  ---"), UVM_DEBUG);
    endtask : run_phase
endclass