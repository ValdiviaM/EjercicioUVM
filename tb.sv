`include "uvm_macros.svh"
import uvm_pkg::*;

`include "diseño_ejemplo.sv"
`include "det_if.sv"
`include "sequence_item.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "env.sv"
`include "test.sv"


module tb;
  reg clk;
  
  always #10 clk =~ clk;
  det_if 	_if (clk);
  det_1011 u0 ( 	.clk(clk),
             .rstn(_if.rstn),
             .in(_if.in),
             .out(_if.out));
  test t0;
  
  initial begin
    clk <= 0;
    uvm_config_db#(virtual det_if)::set(null, "uvm_test_top", "det_vif", _if);
    run_test("test");
  end
  
  // System tasks to dump VCD waveform file
  initial begin
    $dumpvars;
    $dumpfile ("dump.vcd");
  end
endmodule
