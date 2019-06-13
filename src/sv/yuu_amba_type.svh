/////////////////////////////////////////////////////////////////////////////////////
// Copyright 2019 seabeam@yahoo.com - Licensed under the Apache License, Version 2.0
// For more information, see LICENCE in the main folder
/////////////////////////////////////////////////////////////////////////////////////
`ifndef YUU_AMBA_TYPE_SVH
`define YUU_AMBA_TYPE_SVH
  
  typedef bit [`YUU_AMBA_BUS_ADDR_WIDTH-1:0]    yuu_amba_addr_t;
  typedef bit [`YUU_AMBA_BUS_DATA_WIDTH-1:0]    yuu_amba_data_t;

  typedef enum int {
    YUU_AMBA_BYTE_1,
    YUU_AMBA_BYTE_2,
    YUU_AMBA_BYTE_4,
    YUU_AMBA_BYTE_8,
    YUU_AMBA_BYTE_16,
    YUU_AMBA_BYTE_32,
    YUU_AMBA_BYTE_64,
    YUU_AMBA_BYTE_128
  }  yuu_amba_size_e;
  
  typedef enum int {
    READ,
    WRITE
  }  yuu_amba_direction_e;
  
  typedef enum int {
    FIXED,
    INCR,
    WRAP
  }  yuu_amba_burst_type_e;
  
  function string yuu_amba_size_to_string(yuu_amba_size_e yuu_amba_size);
    case (yuu_amba_size)
      YUU_AMBA_BYTE_1:  yuu_amba_size_to_string = "YUU_AMBA_BYTE_1";
      YUU_AMBA_BYTE_2:  yuu_amba_size_to_string = "YUU_AMBA_BYTE_2";
      YUU_AMBA_BYTE_4:  yuu_amba_size_to_string = "YUU_AMBA_BYTE_4";
      YUU_AMBA_BYTE_8:  yuu_amba_size_to_string = "YUU_AMBA_BYTE_8";
      YUU_AMBA_BYTE_16: yuu_amba_size_to_string = "YUU_AMBA_BYTE_16";
      YUU_AMBA_BYTE_32: yuu_amba_size_to_string = "YUU_AMBA_BYTE_32";
      YUU_AMBA_BYTE_64: yuu_amba_size_to_string = "YUU_AMBA_BYTE_64";
      YUU_AMBA_BYTE_128:yuu_amba_size_to_string = "YUU_AMBA_BYTE_128";
      default:`uvm_error("Invalid argument", "Invalid yuu_amba size")
    endcase
  endfunction
  
`endif
