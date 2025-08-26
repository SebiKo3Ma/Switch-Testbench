interface mem_if(clk_if clk_if);
    logic       mem_sel_en;     //enable signal for memory interface
    logic [7:0] mem_addr;       //memory address of the register to be read or configured
    logic [7:0] mem_wr_data;    //address input for port configuration
    logic [7:0] mem_rd_data;    //address output for port reading
    logic       mem_wr_rd_s;    //select between write or read operation
    logic       mem_ack;        //acknowledge signal for port configuration

    //Clocking block for the driver
    clocking drv_cb @(posedge clk_if.clk);
        output mem_sel_en, mem_addr, mem_wr_data, mem_wr_rd_s;
    endclocking

    //Clocking block for the monitor
    clocking mon_cb @(posedge clk_if.clk);
        input mem_sel_en, mem_addr, mem_wr_data, mem_wr_rd_s, mem_rd_data, mem_ack;
    endclocking

    modport drv_mp (clocking drv_cb); // for TB driving
    modport mon_mp (clocking mon_cb);     // for monitors
endinterface