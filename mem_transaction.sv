class mem_transaction extends uvm_sequence_item;
    `uvm_object_utils(mem_transaction)

    rand logic       mem_sel_en;
    rand logic [7:0] mem_addr;
    rand logic [7:0] mem_wr_data;
         logic [7:0] mem_rd_data;
    rand logic       mem_wr_rd_s;
         logic       mem_ack;

    //constructor
    //copy function
endclass