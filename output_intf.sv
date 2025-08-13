interface output_intf;
    logic [7:0] port_out;   //serial 1-byte data output
    logic       port_ready; //ready signal for data output
    logic       port_read;  //read input signal for output port

    modport dut_mp (output port_out, port_ready, input port_read); // for DUT
    modport drv_mp (output port_read);                             // for TB driving
    modport mon_mp (input port_out, port_ready, port_read);        // for monitors
endinterface