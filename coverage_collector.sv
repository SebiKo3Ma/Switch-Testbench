class cov_collector extends uvm_subscriber #(uvm_sequence_item);
  `uvm_component_utils(cov_collector)

  coverage cov;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    cov = new();
  endfunction

  virtual function void write(uvm_sequence_item t);
    mem_transaction mt;
    if($cast(mt, t)) begin
        cov.sample_mem(mt);
    end
  endfunction

  function void report_phase(uvm_phase phase);
    cov.report();
  endfunction
endclass
