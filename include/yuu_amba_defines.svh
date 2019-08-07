/////////////////////////////////////////////////////////////////////////////////////
// Copyright 2019 seabeam@yahoo.com - Licensed under the Apache License, Version 2.0
// For more information, see LICENCE in the main folder
/////////////////////////////////////////////////////////////////////////////////////
`ifndef YUU_AMBA_DEFINE_SVH
`define YUU_AMBA_DEFINE_SVH

  `ifndef YUU_AMBA_BUS_ADDR_WIDTH
  `define YUU_AMBA_BUS_ADDR_WIDTH     32
  `endif
  
  `ifndef YUU_AMBA_BUS_DATA_WIDTH
  `define YUU_AMBA_BUS_DATA_WIDTH     32
  `endif
  
  `ifndef YUU_AMBA_MAX_LENGTH
  `define YUU_AMBA_MAX_LENGTH  32
  `endif

  `define YUU_AMBA_LANE_WIDTH  $clog2(`YUU_AMBA_BUS_DATA_WIDTH/8)

`endif
