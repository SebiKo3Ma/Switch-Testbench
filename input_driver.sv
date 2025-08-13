class input_driver extends uvm_driver #(input_transaction);
    `uvm_object_utils(input_driver)

    virtual interface input_intf vif;

    function new(string name, uvm_component parent)
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    function connect_phase(uvm_phase phase)

    endfunction

    task run_phase(uvm_phase phase)
        fork
            reset();
            get_and_drive();
        join
    endtask

    
endclass