class mem_monitor extends uvm_monitor;
    `uvm_component_utils(mem_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual mem_if.mon_mp vif;
    uvm_analysis_port #(mem_transaction) an_port;
    mem_transaction trans;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - BUILD ---"), UVM_DEBUG);
        trans = new("trans");
        an_port = new("an_port", this);
        if(!uvm_config_db(virtual mem_if.mon_mp) :: get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "Virtual interface not set at top level!");
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - BUILD ---"), UVM_DEBUG);
    endfunction : build_phase

    task get_signals(mem_transaction trans);
        trans.mem_sel_en  <= vif.mon_cb.mem_sel_en;    
        trans.mem_addr    <= vif.mon_cb.mem_addr;
        trans.mem_wr_data <= vif.mon_cb.mem_wr_data;
        trans.mem_wr_rd_s <= vif.mon_cb.mem_wr_rd_s;
        trans.mem_rd_data <= vif.mon_cb.mem_rd_data;
        trans.mem_ack     <= vif.mon_cb.mem_ack;
    endtask : get_signals

    function void run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE -  RUN  ---"), UVM_DEBUG);
        forever begin
            vif.get_signals(trans);
            `uvm_info(get_name(), $sformatf("Monitoring memory transaction: %s", trans.toString()), UVM_FULL);
            an_port.write(trans);
        end
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE -  RUN  ---"), UVM_DEBUG);
    endfunction : run_phase
endclass