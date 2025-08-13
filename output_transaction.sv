class output_transaction extends uvm_sequence_item;
    `uvm_object_utils(output_transaction)

         logic [7:0] port_out;
         logic       port_ready;
    rand logic       port_read;

    //constructor
    //copy function
endclass