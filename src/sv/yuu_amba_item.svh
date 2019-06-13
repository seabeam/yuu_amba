/////////////////////////////////////////////////////////////////////////////////////
// Copyright 2019 seabeam@yahoo.com - Licensed under the Apache License, Version 2.0
// For more information, see LICENCE in the main folder
/////////////////////////////////////////////////////////////////////////////////////
`ifndef YUU_AMBA_ITEM_SVH
`define YUU_AMBA_ITEM_SVH

class yuu_amba_item extends uvm_sequence_item;
  rand int unsigned           len;
  rand yuu_amba_size_e        burst_size;
  rand yuu_amba_burst_type_e  burst_type;
  rand yuu_amba_addr_t        low_boundary;
  rand yuu_amba_addr_t        high_boundary;
  rand yuu_amba_addr_t        start_address;
       int unsigned           number_bytes;
       int unsigned           burst_length;
       int unsigned           data_bus_bytes;
       int unsigned           aligned_address;
       int unsigned           address[]; 
       yuu_amba_addr_t        wrap_boundary;
       int unsigned           lower_byte_lane[];
       int unsigned           upper_byte_lane[];

       boolean address_aligned_enable = False;

  constraint c_len {
    len < `YUU_AMBA_MAX_LENGTH;
  }

  constraint c_size {
    burst_size <= $clog2(`YUU_AMBA_BUS_DATA_WIDTH/8);
  }

  `uvm_object_utils_begin(yuu_amba_item)
    `uvm_field_int(len, UVM_ALL_ON)
    `uvm_field_int(start_address, UVM_ALL_ON)
    `uvm_field_int(low_boundary,  UVM_ALL_ON)
    `uvm_field_int(high_boundary, UVM_ALL_ON)
    `uvm_field_int(number_bytes, UVM_ALL_ON)
    `uvm_field_int(burst_length, UVM_ALL_ON)
    `uvm_field_int(data_bus_bytes, UVM_ALL_ON)
    `uvm_field_int(aligned_address, UVM_ALL_ON)
    `uvm_field_int(wrap_boundary, UVM_ALL_ON)
    `uvm_field_array_int(address, UVM_ALL_ON)
    `uvm_field_array_int(lower_byte_lane, UVM_ALL_ON)
    `uvm_field_array_int(upper_byte_lane, UVM_ALL_ON)
    `uvm_field_enum(yuu_amba_size_e,       burst_size, UVM_ALL_ON)
    `uvm_field_enum(yuu_amba_burst_type_e, burst_type, UVM_ALL_ON)
    `uvm_field_enum(boolean, address_aligned_enable, UVM_ALL_ON | UVM_NOCOMPARE)
  `uvm_object_utils_end

  extern function      new(string name="yuu_amba_item");
  extern function void post_randomize();
endclass

function yuu_amba_item::new(string name="yuu_amba_item");
  super.new(name);
endfunction

function void yuu_amba_item::post_randomize();
  if (burst_type == FIXED)
    len = 0;
  number_bytes = 1<<int'(burst_size);
  burst_length = len+1;
  aligned_address = (int'(start_address/number_bytes))*number_bytes;
  if (burst_type == WRAP)
    address_aligned_enable = True;
  if (address_aligned_enable) begin
    for (int i=0; i<int'(burst_size); i++) begin
      start_address[i] = 1'b0;
    end
  end
  address = new[burst_length];
  address[0] = start_address;
  if (burst_type == INCR || burst_type == FIXED) begin
    low_boundary  = start_address;
    high_boundary = aligned_address+number_bytes*burst_length;
    for (int n=1; n<burst_length; n++) begin
      address[n] = aligned_address+n*number_bytes;
    end
  end
  else if (burst_type == WRAP) begin
    boolean is_wrapped = False;
    int wrap_idx = 0;

    wrap_boundary = (int'(start_address/(number_bytes*burst_length)))*(number_bytes*burst_length);
    low_boundary  = wrap_boundary;
    high_boundary = low_boundary+number_bytes*burst_length;
    for (int n=1; n<burst_length; n++) begin
      if (!is_wrapped)
        address[n] = aligned_address+n*number_bytes;
      else
        address[n] = low_boundary + (n-wrap_idx)*number_bytes;

      if (address[n] == high_boundary) begin
        address[n] = wrap_boundary;
        wrap_idx = n;
        is_wrapped = True;
      end
    end
  end

  data_bus_bytes = `YUU_AMBA_BUS_DATA_WIDTH/8;
  lower_byte_lane = new[burst_length];
  upper_byte_lane = new[burst_length];
  lower_byte_lane[0] = start_address-(int'(start_address/data_bus_bytes))*data_bus_bytes;
  upper_byte_lane[0] = aligned_address+(number_bytes-1)-(int'(start_address/data_bus_bytes))*data_bus_bytes;
  for (int n=1; n<burst_length; n++) begin
    lower_byte_lane[n] = address[n]-(int'(address[n]/data_bus_bytes))*data_bus_bytes;
    upper_byte_lane[n] = lower_byte_lane[n]+number_bytes-1;
  end
endfunction
`endif