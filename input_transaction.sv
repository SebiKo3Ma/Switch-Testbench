class input_transaction extends uvm_sequence_item;
    `uvm_object_utils(input_transaction);

    rand logic [7:0] data_in;
    rand logic       sw_enable_in;
         logic       read_out;

    //constructor
    //copy function
endclass