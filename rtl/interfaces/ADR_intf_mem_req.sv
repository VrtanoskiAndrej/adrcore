`include "ADR_define.svh"

interface ADR_intf_mem_req;
logic                       clk;
logic [`ADDRESS_LEN:0]     addr;
MEMORY_RW            read_write;
endinterface;