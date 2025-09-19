class rst_monitor extends uvm_monitor;
    `uvm_component_utils(rst_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual rst_if.mon_mp vif;
    uvm_analysis_port #(rst_transaction) an_port;
    rst_transaction trans;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - BUILD ---"), UVM_DEBUG);
        trans = new("trans");
        an_port = new("an_port", this);
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - BUILD ---"), UVM_DEBUG);
    endfunction : build_phase

    task get_signals(rst_transaction trans);
        trans.rst_n <= vif.mon_cb.rst_n;
    endtask : get_signals

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE -  RUN  ---"), UVM_DEBUG);
        forever begin
            @vif.mon_cb
            get_signals(trans);
            `uvm_info(get_name(), $sformatf("Monitoring reset transaction: %s", trans.toString()), UVM_FULL);
            an_port.write(trans);
        end
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE -  RUN  ---"), UVM_DEBUG);
    endtask : run_phase
endclass