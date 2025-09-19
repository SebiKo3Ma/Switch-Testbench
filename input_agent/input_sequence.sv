import uvm_pkg::*;
`include "uvm_macros.svh"
import input_pkg::*;

class input_sequence extends uvm_sequence #(input_transaction);
  `uvm_object_utils(input_sequence)
    
  input_transaction trans;
        
  function new (string name = "input_sequence");
    super.new(name);
  endfunction : new

  task body();
    trans = input_transaction::type_id::create("trans");
    `uvm_info(get_name(), $sformatf("Start the input sequence"), UVM_LOW);

    for(int i = 0; i < 8; i++) begin
      trans.randomize();
      start_item(trans);
      `uvm_info(get_name(), $sformatf("Create item trans: %s", trans.toString), UVM_FULL);
      finish_item(trans);
    end
  endtask : body  
endclass : input_sequence