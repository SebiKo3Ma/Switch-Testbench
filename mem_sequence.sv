import uvm_pkg::*;
`include "uvm_macros.svh"
import mem_pkg::*;
`include "mem_write_sequence.sv"

class mem_sequence extends uvm_sequence #(mem_transaction);
  `uvm_object_utils(mem_sequence)
    
  mem_write_sequence mem_write;  
  mem_read_item read_trans;
  mem_idle_item idle_trans;
        
  function new (string name = "mem_sequence");
    super.new(name);
  endfunction : new

  task send_item(mem_transaction trans);
    start_item(trans);
    `uvm_info(get_name(), $sformatf("Create item trans: %s", trans.toString), UVM_FULL);
    finish_item(trans);
  endtask : send_item

  task body();
    mem_write = mem_write_sequence::type_id::create("mem_write");
    read_trans = mem_read_item::type_id::create("read_trans");
    idle_trans = mem_idle_item::type_id::create("idle_trans");
    `uvm_info(get_name(), $sformatf("Start the mem sequence"), UVM_LOW);

    // for(int i = 0; i < 5; i = i + 1) begin
    //   read_trans.randomize();
    //   read_trans.mem_addr = i;
    //   send_item(read_trans);
    // end

    repeat(4) begin
      mem_write.randomize();
      mem_write.start(m_sequencer);
    end

    #30;

    for(int i = 0; i < 5; i = i + 1) begin
      read_trans.randomize();
      read_trans.mem_addr = i;
      send_item(read_trans);
    end
      
  endtask : body  
endclass : mem_sequence