class coverage;
    mem_transaction mem_trans;

    covergroup mem_cg;
        mem_addr: coverpoint mem_trans.mem_addr{
            bins default_values[] = {[0:3]};
            bins invalid_values[2] = {[4:255]};
        }

        operation: coverpoint mem_trans.mem_wr_rd_s;

        addr_x_op: cross mem_addr, operation;

        ack: coverpoint mem_trans.mem_ack{
            bins valid_values[] = {4'b0000, 4'b0001, 4'b0010, 4'b0100, 4'b1000};
        }

        wr_data: coverpoint mem_trans.mem_wr_data{
            bins data[2] = {[0:255]};
        }

        ack_x_wr_data: cross ack, wr_data;

        rd_data: coverpoint mem_trans.mem_rd_data{
            bins default_value[] = {8'b00000000};
            bins other_values[2] = {[1:4294967295]};
        }

        ack_x_rd_data: cross ack, rd_data{
            ignore_bins no_ack_data = binsof(ack) intersect {4'b0000} &&
                                      binsof(rd_data) intersect {[1:255]};
        }
    endgroup : mem_cg

    function new();
        mem_cg = new();
    endfunction : new

    function void sample_mem(mem_transaction t);
        this.mem_trans = t;
        mem_cg.sample();
    endfunction

    function void report();
        $display("=== COVERAGE ===");
        $display("Mem Coverage: %0.2f%%\n", mem_cg.get_inst_coverage());
        $display("Coverage: %0.2f%%\n", $get_coverage());
    endfunction
endclass