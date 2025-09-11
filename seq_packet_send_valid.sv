import uvm_pkg::*;
`include "uvm_macros.svh"
import input_pkg::*;

class seq_packet_send_valid extends uvm_sequence #(input_byte_valid);
  `uvm_object_utils(seq_packet_send_valid)
    
  input_byte_valid trans;
  rand logic [7:0] DL;
       logic [7:0] parity;

  constraint data_length{
    DL inside {[0:254]};
  }

  function new (string name = "seq_packet_send_valid");
    super.new(name);
  endfunction : new

  task send_item(input_byte_valid trans);
    start_item(trans);
      `uvm_info(get_name(), $sformatf("Create item trans: %s", trans.toString), UVM_FULL);
    finish_item(trans);
  endtask : send_item

  task body();
    trans = input_byte_valid::type_id::create("trans");
    assert(randomize()); //randomize DL
    `uvm_info(get_name(), $sformatf("Start sending a valid packet"), UVM_LOW);

    //random byte with sw_enable_in set to 0
    // trans.randomize();
    // trans.sw_enable_in = 8'h0;
    // send_item(trans);

    // //random byte before start with sw_enable_in set to 1
    // trans.randomize();
    // send_item(trans);

    //send SOF
    trans.randomize();
    trans.data_in = 8'hFF;
    send_item(trans);

    //send DA
    trans.data_in = 8'h12;
    send_item(trans);

    // //send SA
    // trans.data_in = 8'h0;
    // send_item(trans);

    //send DL
    trans.data_in = DL;
    send_item(trans);

    //send payload
    for(int i = 0; i < DL; i++) begin
      trans.randomize();
      parity = parity || trans.data_in;
      send_item(trans);
    end

    //send parity
    trans.data_in = parity;
    trans.sw_enable_in = 8'h0;
    send_item(trans);

    //send EOF
    trans.data_in = 8'h55;
    send_item(trans);

  endtask : body  
endclass : seq_packet_send_valid