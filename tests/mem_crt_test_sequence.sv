import uvm_pkg::*;
`include "uvm_macros.svh"
import mem_pkg::*;

class mem_crt_test_sequence extends uvm_sequence #(mem_transaction);
  `uvm_object_utils(mem_crt_test_sequence)

  `uvm_declare_p_sequencer(mem_sequencer)
    
  mem_write_item write_trans;  
  mem_read_item read_trans;

  rand int num_of_trans;
  rand bit access_type;

  logic[7:0] data[4], delay_data[4];
  int pass = 0, fail = 0;

  constraint maximum{
    num_of_trans inside {[10:255]};
  }
        
  function new (string name = "mem_crt_test_sequence");
    super.new(name);
    for(int i = 0; i < 4; i++) begin
      data[i] = 8'd0;
      delay_data[i] = 8'd0;
    end
  endfunction : new

    task send_item(mem_transaction trans, logic [7:0] addr = 8'hXX, logic [7:0] wr_data = 8'hXX);

    if(!trans.randomize()) `uvm_error("MEM_TEST_SEQ", "Failed to randomize transaction")

    if(addr !== 8'hXX) trans.mem_addr = addr;

    if(wr_data !== 8'hXX) trans.mem_wr_data = wr_data;

    start_item(trans);
      `uvm_info(get_name(), $sformatf("Create item trans: %s", trans.toString), UVM_FULL);
    finish_item(trans);
endtask


  task body();
    read_trans = mem_read_item::type_id::create("read_trans");
    write_trans = mem_write_item::type_id::create("write_trans");
    `uvm_info(get_name(), $sformatf("Start the mem sequence"), UVM_LOW);

    if(!randomize()) `uvm_error("MEM_TEST_SEQ", "Failed to randomize sequence")

    repeat(num_of_trans) begin
      if(access_type) begin
        send_item(read_trans);

        @p_sequencer.vif.mon_cb
        if(p_sequencer.vif.mem_rd_data >> (8*read_trans.mem_addr) != data[read_trans.mem_addr]) begin
          `uvm_error ("MEM_CRT_TEST_CHECKER", $sformatf("Read data from register %0d is incorrect: %0h instead of %0h\n", read_trans.mem_addr, p_sequencer.vif.mem_rd_data >> (8*read_trans.mem_addr), data[read_trans.mem_addr]))
          fail = fail + 1;
        end else begin
         `uvm_info ("MEM_CRT_TEST_CHECKER", $sformatf("Read data from register %0d is correct: %0h\n", read_trans.mem_addr, data[read_trans.mem_addr]), UVM_LOW) 
         pass = pass + 1;
        end
        data = delay_data;
      end else begin
        send_item(write_trans);
        data = delay_data; 
        delay_data[write_trans.mem_addr] = write_trans.mem_wr_data;
      end

      if(!randomize(access_type)) `uvm_error("MEM_TEST_SEQ", "Failed to randomize access type")
    end

    `uvm_info("MEM_TEST", $sformatf("Checkers passed: %0d, Checkers failed: %0d", pass, fail), UVM_LOW)
    if(fail) `uvm_info("MEM_TEST", "TEST FAILED", UVM_LOW)
    else `uvm_info("MEM_TEST", "TEST PASSED", UVM_LOW)
  endtask : body  
endclass : mem_crt_test_sequence