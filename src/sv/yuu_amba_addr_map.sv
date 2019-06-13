/////////////////////////////////////////////////////////////////////////////////////
// Copyright 2019 seabeam@yahoo.com - Licensed under the Apache License, Version 2.0
// For more information, see LICENCE in the main folder
/////////////////////////////////////////////////////////////////////////////////////
`ifndef YUU_AMBA_ADDR_MAP_SV
`define YUU_AMBA_ADDR_MAP_SV

class yuu_amba_addr_map extends uvm_object;
  protected yuu_amba_addr_t high;
  protected yuu_amba_addr_t low;

  `uvm_object_utils_begin(yuu_amba_addr_map)
    `uvm_field_int(high, UVM_DEFAULT)
    `uvm_field_int(low, UVM_DEFAULT)
  `uvm_object_utils_end

  function new(string name="yuu_amba_addr_map");
    super.new(name);
  endfunction

  function void set_map(yuu_amba_addr_t low, yuu_amba_addr_t high);
    this.high = high;
    this.low  = low;
  endfunction

  function yuu_amba_addr_t get_low();
    return this.low;
  endfunction

  function yuu_amba_addr_t get_high();
    return this.high;
  endfunction

  function boolean is_contain(yuu_amba_addr_t addr);
    if (addr inside {[low:high]})
      return True;
    else
      return False;
  endfunction

endclass

`endif
