interface clk_rst_if(input clk);
    logic rst_n;
    
    modport dut_mp (input clk, rst_n);        // for DUT
    modport drv_mp (input clk, output rst_n); // for TB driving
    modport mon_mp (input clk, rst_n);        // for monitors
endinterface