interface mem_intf;
    logic       mem_sel_en;     //enable signal for memory interface
    logic [7:0] mem_addr;       //memory address of the register to be read or configured
    logic [7:0] mem_wr_data;    //address input for port configuration
    logic [7:0] mem_rd_data;    //address output for port reading
    logic       mem_wr_rd_s;    //select between write or read operation
    logic       mem_ack;        //acknowledge signal for port configuration

    //get signals
    //send signals
endinterface