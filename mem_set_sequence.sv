import uvm_pkg::*;
`include "uvm_macros.svh"
import mem_pkg::*;

class mem_set_sequence extends uvm_sequence #(mem_transaction);
  `uvm_object_utils(mem_set_sequence)
    
  rand mem_set_item set_trans;
        
  function new (string name = "mem_set_sequence");
    super.new(name);
    set_trans = mem_set_item::type_id::create("set_trans");
  endfunction : new

  task send_item(mem_transaction trans);
    start_item(trans);
    `uvm_info(get_name(), $sformatf("Create item trans: %s", trans.toString), UVM_FULL);
    finish_item(trans);
  endtask : send_item

  task body();
    `uvm_info(get_name(), $sformatf("Start the mem sequence"), UVM_LOW);

    send_item(set_trans);
    
    set_trans.mem_sel_en = 1'b0;
    send_item(set_trans);      
  endtask : body  
endclass : mem_set_sequence