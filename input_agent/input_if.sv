interface input_if(clk_if clk_if);
    logic [7:0] data_in;        //serial 1-byte data input
    logic       sw_enable_in;   //enable signal for input
    logic       read_out;       //busy signal for output

    //Clocking block for the driver
    clocking drv_cb @(posedge clk_if.clk);
        output data_in, sw_enable_in;
    endclocking

    //Clocking block for the monitor
    clocking mon_cb @(posedge clk_if.clk);
        input data_in, sw_enable_in, read_out;
    endclocking

    modport drv_mp (clocking drv_cb);                              // for TB driving
    modport mon_mp (clocking mon_cb);                              // for monitors
endinterface