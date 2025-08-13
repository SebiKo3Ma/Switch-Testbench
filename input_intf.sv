interface input_intf(clk_rst_intf clk_if);
    logic [7:0] data_in;        //serial 1-byte data input
    logic       sw_enable_in;   //enable signal for input
    logic       read_out;       //busy signal for output

    modport dut_mp (input data_in, sw_enable_in, output read_out); // for DUT
    modport drv_mp (output data_in, sw_enable_in);                 // for TB driving
    modport mon_mp (input data_in, sw_enable_in, read_out);        // for monitors
endinterface