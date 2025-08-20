package output_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    `include "output_transaction.sv"
    `include "output_if.sv"
    `include "output_sequencer.sv"
    `include "output_driver.sv"
    `include "output_monitor.sv"
    `include "output agent.sv"

endpackage : output_pkg