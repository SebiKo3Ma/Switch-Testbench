import uvm_pkg::*;
`include "uvm_macros.svh"
import rst_pkg::*;

class rst_sequence extends uvm_sequence #(rst_transaction);
  `uvm_object_utils(rst_sequence)
    
  rst_transaction trans;
        
  function new (string name = "rst_sequence");
    super.new(name);
  endfunction : new

  task body();
    trans = rst_transaction::type_id::create("trans");
    `uvm_info(get_name(), $sformatf("Start the rst sequence"), UVM_LOW);

    for(int i = 0; i < 8; i++) begin
      trans.randomize();
      if(i == 0) trans.rst_n = 1'b0;
      start_item(trans);
      `uvm_info(get_name(), $sformatf("Create item trans: %s", trans.toString), UVM_FULL);
      finish_item(trans);
    end
  endtask : body  
endclass : rst_sequence