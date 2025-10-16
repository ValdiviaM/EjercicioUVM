`include "uvm_sequence"
class sequence extends uvm_sequence;
    `uvm_object_utils(sequence);
    function new();
        Super.new(name);
    endfunction //new()

    rand int num_items

    virtual task body();
        for (int = i; i<num_items ; i++ ) begin
            seq_item n_item=seq_item::type_id::create("n_item");
            start_item(n_item);
            n_item.randomize();
            `uvm_info("SEQ",$sformatf("Generate new item: "), UVM_LOW);
            n_item.print();
            finish_item(n_item);
        end
        `uvm_info("SEQ",$sformatf("Done generation of %d items: ", num_items), UVM_LOW);
    endtask //

endclass //sequence extends uvm_sequence