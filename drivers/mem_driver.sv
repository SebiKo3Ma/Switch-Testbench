class mem_driver extends uvm_driver #(mem_transaction);
    `uvm_component_utils(mem_driver)

    mem_transaction trans;
    virtual mem_if.drv_mp vif;
    logic [7:0] buffer;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        buffer = 8'd0;
    endfunction : new

    task reset_signals();
        vif.drv_cb.mem_sel_en  <= 1'b0;
        vif.drv_cb.mem_addr    <= 8'd0;
        vif.drv_cb.mem_wr_data <= 8'd0;
        vif.drv_cb.mem_wr_rd_s <= 1'b0;
    endtask : reset_signals

    task drive_signals(mem_transaction trans, logic[7:0] buffer, logic enable);
        vif.drv_cb.mem_sel_en  <= enable;
        vif.drv_cb.mem_addr    <= trans.mem_addr;
        vif.drv_cb.mem_wr_data <= buffer;
        vif.drv_cb.mem_wr_rd_s <= trans.mem_wr_rd_s;
    endtask : drive_signals

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_name(), $sformatf("--- ENTER PHASE - RUN ---"), UVM_DEBUG);
        reset_signals();
        forever begin
            @vif.drv_cb
            seq_item_port.get_next_item(trans);
            if(!trans.protocol_invalid) begin
                `uvm_info(get_name(), $sformatf("Driving input transaction: %s", trans.toString), UVM_HIGH);
                drive_signals(trans, buffer, 1'b1);
            end
            buffer <= trans.mem_wr_data;
            seq_item_port.item_done();
        end
        `uvm_info(get_name(), $sformatf("---  EXIT PHASE - RUN ---"), UVM_DEBUG);
    endtask : run_phase   
endclass 