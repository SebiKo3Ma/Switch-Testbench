import uvm_pkg::*;
`include "uvm_macros.svh"
import mem_pkg::*;

class mem_sequence extends uvm_sequence #(mem_set_valid);
  `uvm_object_utils(mem_sequence)
    
  mem_set_valid trans;
        
  function new (string name = "rst_sequence");
    super.new(name);
  endfunction : new

  task send_item(mem_set_valid trans);
    start_item(trans);
    `uvm_info(get_name(), $sformatf("Create item trans: %s", trans.toString), UVM_FULL);
  finish_item(trans);
endtask : send_item

  task body();
    trans = mem_set_valid::type_id::create("trans");
    `uvm_info(get_name(), $sformatf("Start the mem sequence"), UVM_LOW);

    for(int i = 0; i < 5; i = i + 1) begin
      trans.randomize();
      trans.mem_addr = i;
      trans.mem_wr_data = 8'h12 + i;
      send_item(trans);
    end
      
  endtask : body  
endclass : mem_sequence