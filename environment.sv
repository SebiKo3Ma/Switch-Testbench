class environment extends uvm_env;
    `uvm_component_utils(environment)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    rst_agent rst_agt;
    input_agent in_agt;
    mem_agent mem_agt;
    output_agent out_agt0, out_agt1, out_agt2, out_agt3;

    virtual mem_if mem_vif;
    cov_collector cov;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - BUILD ---"), UVM_DEBUG);
        rst_agt  =    rst_agent::type_id::create("rst_agt", this);
        // in_agt   =  input_agent::type_id::create("in_agt" , this);
        mem_agt  =    mem_agent::type_id::create("mem_agt", this);
        // out_agt0 = output_agent::type_id::create("out_agt0", this);
        // out_agt1 = output_agent::type_id::create("out_agt1", this);
        // out_agt2 = output_agent::type_id::create("out_agt2", this);
        // out_agt3 = output_agent::type_id::create("out_agt3", this);
        cov = cov_collector::type_id::create("cov_collector", this);
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - BUILD ---"), UVM_DEBUG);
    endfunction : build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - CONNECT ---"), UVM_DEBUG);
        
        mem_agt.mon.an_port.connect(cov.analysis_export);

        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - CONNECT ---"), UVM_DEBUG);
    endfunction : connect_phase
endclass