import uvm_pkg::*;
`include "uvm_macros.svh"
import mem_pkg::*;

class mem_test_sequence extends uvm_sequence #(mem_transaction);
  `uvm_object_utils(mem_test_sequence)

  `uvm_declare_p_sequencer(mem_sequencer)
    
  mem_write_item write_trans;  
  mem_read_item read_trans;

  logic[7:0] data[4], reg_data;
  int pass = 0, fail = 0;
        
  function new (string name = "mem_test_sequence");
    super.new(name);
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

    //read and check register default data
    for(int i = 0; i <= 4; i = i + 1) begin
      send_item(read_trans, i);

      if(i) begin
        if(p_sequencer.vif.mem_rd_data != 8'd0) begin
          `uvm_error ("MEM_TEST_CHECKER", $sformatf("Default data from register %0d is incorrect", i))
          fail = fail + 1;
        end else begin
         `uvm_info ("MEM_TEST_CHECKER", $sformatf("Default data from register %0d is correct", i), UVM_LOW)
         pass = pass + 2;
        end
      end
    end

    #30

    for(int i = 0; i < 4; i++) begin
      send_item(write_trans, i);
      data[i] = write_trans.mem_wr_data;
    end

    #30;

    for(int i = 1; i <= 4 ; i++) begin
      if (! uvm_hdl_read($sformatf("testbench.DUT.genblk1[%0d].DUT_REG.CONF_PORT_REG_DUT.reg_data", i), reg_data))
			  `uvm_error ("MEM_TEST", $sformatf("Read from reg_data[%0d] failed", i))
      if(reg_data != data[i-1]) begin
        `uvm_error ("MEM_TEST_CHECKER", $sformatf("Data from register %0d incorrectly set", i))
        fail = fail + 1;
      end else begin 
        `uvm_info ("MEM_TEST_CHECKER", $sformatf("Data from register %0d correctly set", i), UVM_LOW) 
        pass = pass + 1;
      end
    end
     
    #30;
    for(int i = 1; i <= 4 ; i++) begin
      if (! uvm_hdl_force($sformatf("testbench.DUT.genblk1[%0d].DUT_REG.CONF_PORT_REG_DUT.reg_data", i), i))
			  `uvm_error ("MEM_TEST", $sformatf("Force on reg_data[%0d] failed", i))
      else data[i-1] = i;
    end

    for(int i = 0; i <= 4; i = i + 1) begin
      send_item(read_trans, i);
      if(i < 4) begin
        @p_sequencer.vif.mon_cb
        if(p_sequencer.vif.mem_rd_data >> (8*i) != data[i]) begin
          `uvm_error ("MEM_TEST_CHECKER", $sformatf("Read data from register %0d is incorrect: %0d instead of %0d", i, p_sequencer.vif.mem_rd_data >> (8*i), data[i]))
          fail = fail + 1;
        end else begin
         `uvm_info ("MEM_TEST_CHECKER", $sformatf("Read data from register %0d is correct", i), UVM_LOW) 
         pass = pass + 1;
        end
      end
    end

    `uvm_info("MEM_TEST", $sformatf("Checkers passed: %0d, Checkers failed: %0d", pass, fail), UVM_LOW)
    if(fail) `uvm_info("MEM_TEST", "TEST FAILED", UVM_LOW)
    else `uvm_info("MEM_TEST", "TEST PASSED", UVM_LOW)
      
  endtask : body  
endclass : mem_test_sequence