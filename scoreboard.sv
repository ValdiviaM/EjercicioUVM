class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  function new(string name="scoreboard", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  uvm_analysis_imp #(seq_item, scoreboard) m_analysis_imp;
    
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_analysis_imp = new("m_analysis_imp", this);
  endfunction
  
  virtual function write(seq_item item);      
    if (item.data==4'b1011 && item.out!=1)
        `uvm_error("SCBD", $sformatf("ERROR! Mismatch data=0x%0h out=%0b",  item.data, item.out))
    else
        `uvm_info("SCBD", $sformatf("PASS! Match data=0x%0h out=%0b", item.data, item.out), UVM_LOW)
      
  endfunction
endclass
