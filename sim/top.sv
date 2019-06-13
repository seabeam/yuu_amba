import uvm_pkg::*;
import yuu_common_pkg::*;
import yuu_amba_pkg::*;

module top;
  yuu_amba_item item;

  initial begin
    item = new("item");
    item.address_aligned_enable = True;
    item.randomize() with {len<8;};
    item.print();
  end
endmodule
