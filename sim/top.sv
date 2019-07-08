import uvm_pkg::*;
import yuu_common_pkg::*;
import yuu_amba_pkg::*;

module top;
  yuu_amba_item item;

  initial begin
    item = new("item");
    item.address_aligned_enable = True;
    item.randomize() with {len<8; burst_type == INCR; address_aligned_enable == True;};
    item.print();
  end
endmodule
