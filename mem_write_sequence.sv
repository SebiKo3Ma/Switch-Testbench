import uvm_pkg::*;
`include "uvm_macros.svh"
import mem_pkg::*;

class mem_write_sequence extends uvm_sequence #(mem_transaction);
  `uvm_object_utils(mem_write_sequence)
    
  rand mem_write_item write_trans;
        
  function new (string name = "mem_write_sequence");
    super.new(name);
    write_trans = mem_write_item::type_id::create("write_trans");
  endfunction : new

  task send_item(mem_transaction trans);
    start_item(trans);
    `uvm_info(get_name(), $sformatf("Create item trans: %s", trans.toString), UVM_FULL);
    finish_item(trans);
  endtask : send_item

  task body();
    `uvm_info(get_name(), $sformatf("Start the mem sequence"), UVM_LOW);
    send_item(write_trans);  
  endtask : body  
endclass : mem_write_sequence