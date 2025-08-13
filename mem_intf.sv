interface mem_intf;
    logic       mem_sel_en;     //enable signal for memory interface
    logic [7:0] mem_addr;       //memory address of the register to be read or configured
    logic [7:0] mem_wr_data;    //address input for port configuration
    logic [7:0] mem_rd_data;    //address output for port reading
    logic       mem_wr_rd_s;    //select between write or read operation
    logic       mem_ack;        //acknowledge signal for port configuration

    modport dut_mp (input   mem_sel_en,
                            mem_addr,
                            mem_wr_data,
                            mem_wr_rd_s,
                    output  mem_rd_data,
                            mem_ack);     // for DUT

    modport drv_mp (output  mem_sel_en,
                            mem_addr,
                            mem_wr_data,
                            mem_wr_rd_s); // for TB driving

    modport mon_mp (input   mem_sel_en,
                            mem_addr,
                            mem_wr_data,
                            mem_wr_rd_s,
                            mem_rd_data,
                            mem_ack);     // for monitors
endinterface