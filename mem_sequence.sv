import uvm_pkg::*;
`include "uvm_macros.svh"
import mem_pkg::*;
`include "mem_set_sequence.sv"

class mem_sequence extends uvm_sequence #(mem_transaction);
  `uvm_object_utils(mem_sequence)
    
  mem_set_sequence mem_set;  
  mem_read_item read_trans;
        
  function new (string name = "mem_sequence");
    super.new(name);
  endfunction : new

  task send_item(mem_transaction trans);
    start_item(trans);
    `uvm_info(get_name(), $sformatf("Create item trans: %s", trans.toString), UVM_FULL);
    finish_item(trans);
  endtask : send_item

  task body();
    mem_set = mem_set_sequence::type_id::create("mem_set");
    read_trans = mem_read_item::type_id::create("read_trans");
    `uvm_info(get_name(), $sformatf("Start the mem sequence"), UVM_LOW);

    // for(int i = 0; i < 5; i = i + 1) begin
    //   read_trans.randomize();
    //   read_trans.mem_addr = i;
    //   send_item(read_trans);
    // end

    repeat(5) begin
      mem_set.randomize();
      mem_set.start(m_sequencer);
    end

    // for(int i = 0; i < 5; i = i + 1) begin
    //   read_trans.randomize();
    //   read_trans.mem_addr = i;
    //   send_item(read_trans);
    // end
      
  endtask : body  
endclass : mem_sequence