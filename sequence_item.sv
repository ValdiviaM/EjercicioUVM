`include "uvm_macros.svh"
import uvm_pkg::*;
class seq_item extends uvm_sequence_item;
    rand bit [3:0] data;

    bit out; 

    `uvm_object_utils_begin(seq_item)
        `uvm_field_int (data, UVM_DEFAULT)  
        `uvm_field_int (out, UVM_DEFAULT)  
    `uvm_object_utils_end
endclass