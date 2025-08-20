class environment extends uvm_env;
    `uvm_component_utils(environment)

    function new(string name, uvm_component parent)
        super.new(name, parent);
    endfunction : new

    rst_agent rst_agt;
    input_agent in_agt;
    mem_agent mem_agt;
    output_agent out_agt;

    function build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - BUILD ---", UVM_DEBUG));
        rst_agt = rst_agent::type_id::create("rst_agt", this);
        in_agt  =  in_agent::type_id::create("in_agt" , this);
        mem_agt = mem_agent::type_id::create("mem_agt", this);
        out_agt = out_agent::type_id::create("out_agt", this);
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - BUILD ---", UVM_DEBUG));
    endfunction : build_phase
endclass