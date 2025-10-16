class driver extends uvm_driver #(seq_item);
    `uvm_component_utils(driver)
    function new();
        super.new(name, parent);
    endfunction //new()
    virtual det_if vif;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!config_db#(virtual det_if)::get(this, "","det_if",vif)) begin
            `uvm_fatal("DRV","Could not get vif")  
        end
        
    endfunction

    virtual task run_phase (uvm_phase phase);
    super.run_phase(phase);
    forever begin
        seq_item n_item;
        `uvm_info("DRV",$sformatf("Wait for item from sequencer"), UVM_LOW)
        seq_item_port.get_next_item(n_item);
        drive_item(n_item);
        seq_item_port.item_done();
    end
        
    endtask //

    virtual task  drive_item(seq_item n_item);
        for (int i= 0; i<3; i++ ) begin
            vif.in <= n_item.data[i];
            @(posedge vif.clk);
        end
    endtask //
endclass //driver extends uvm_driver