interface output_if(clk_rst_if clk_if);
    logic [7:0] port_out;   //serial 1-byte data output
    logic       port_ready; //ready signal for data output
    logic       port_read;  //read input signal for output port

    //Clocking block for the driver
    clocking drv_cb @(posedge clk_if.clk);
        input port_read;
    endclocking

    //Clocking block for the monitor
    clocking mon_cb @(posedge clk_if.clk);
        output port_out, port_ready, port_read;
    endclocking

    modport dut_mp (output port_out, port_ready, input port_read); // for DUT
    modport drv_mp (clocking drv_cb);                              // for TB driving
    modport mon_mp (clocking mon_cb);                              // for monitors
endinterface