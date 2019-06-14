/////////////////////////////////////////////////////////////////////////////////////
// Copyright 2019 seabeam@yahoo.com - Licensed under the Apache License, Version 2.0
// For more information, see LICENCE in the main folder
/////////////////////////////////////////////////////////////////////////////////////
`ifndef YUU_AMBA_PKG_SV
`define YUU_AMBA_PKG_SV

  package yuu_amba_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import yuu_common_pkg::*;

    `include "yuu_amba_type.svh"
    `include "yuu_amba_item.svh"
    `include "yuu_amba_addr_map.sv"

  endpackage

`endif
