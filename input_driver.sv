class input_driver extends uvm_driver #(input_transaction);
    `uvm_object_utils(input_driver)

    virtual interface input_if vif;

    function new(string name, uvm_component parent)
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual input_if) :: get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "Input interface not set at top level!");
    endfunction

    function connect_phase(uvm_phase phase)

    endfunction

    task run_phase(uvm_phase phase)
        super.run_phase(phase)
        fork
            reset();
            get_and_drive();
        join
    endtask

    
endclass