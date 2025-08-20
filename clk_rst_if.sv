interface clk_rst_if(input clk);
    logic rst_n;
    
    //Clocking block for the driver
    clocking drv_cb @(posedge clk);
        output rst_n;
    endclocking

    //Clocking block for the monitor
    clocking mon_cb @(posedge clk);
        input rst_n;
    endclocking

    modport drv_mp (clocking drv_cb);   // for TB driving
    modport mon_mp (clocking mon_cb);   // for monitors
endinterface