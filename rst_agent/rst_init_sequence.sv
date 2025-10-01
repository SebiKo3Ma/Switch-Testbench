import uvm_pkg::*;
`include "uvm_macros.svh"
import rst_pkg::*;

class rst_init_sequence extends uvm_sequence #(rst_transaction);
  `uvm_object_utils(rst_init_sequence)
    
  rst_transaction trans;
        
  function new (string name = "rst_init_sequence");
    super.new(name);
  endfunction : new

  task body();
    trans = rst_transaction::type_id::create("trans");
    `uvm_info(get_name(), $sformatf("Start the rst init sequence"), UVM_LOW);

      //activate reset for one clock cycle
      trans.rst_n = 1'b0;
      start_item(trans);
      `uvm_info(get_name(), $sformatf("Create item trans: %s", trans.toString), UVM_FULL);
      finish_item(trans);

      //deactivate reset
      trans.rst_n = 1'b1;
      start_item(trans);
      `uvm_info(get_name(), $sformatf("Create item trans: %s", trans.toString), UVM_FULL);
      finish_item(trans);
  endtask : body  
endclass : rst_init_sequence