class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)
  function new(string name="monitor", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  uvm_analysis_port  #(seq_item) mon_analysis_port;
  virtual det_if vif;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual det_if)::get(this, "", "det_vif", vif))
      `uvm_fatal("MON", "Could not get vif")
    mon_analysis_port = new ("mon_analysis_port", this);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    fork
      sample_port("Thread0");
    join
  endtask
  
  virtual task sample_port(string tag="");
    // This task monitors the interface for a complete 
    // transaction and pushes into the mailbox when the 
    // transaction is complete
    forever begin
      @(posedge vif.clk);
      if (vif.rstn) begin
        seq_item item = new;
        for (int i= 0; i<3; i++ ) begin
            item.data[i] = vif.in;
            @(posedge vif.clk);
        end
        `uvm_info("MON", $sformatf("T=%0t [Monitor] %s First part over", 
                                   $time, tag), UVM_LOW)
        //@(posedge vif.clk);
        item.out = vif.out;
        
        mon_analysis_port.write(item);
        `uvm_info("MON", $sformatf("T=%0t [Monitor] %s Second part over, item:", 
                 $time, tag), UVM_LOW)        
        item.print();             
      end
    end
  endtask
endclass