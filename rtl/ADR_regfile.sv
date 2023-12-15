`include "ADR_define.svh"

module ADR_regfile (
    input wire clk,
    input wire reset,
    input wire[`REG_ADDR_LEN-1:0] read_addr_a_i,
    input wire[`REG_ADDR_LEN-1:0] read_addr_b_i,
    input wire[`REG_ADDR_LEN-1:0] write_addr_i,
    input wire[`XLEN-1:0] write_data_i,
    output logic[`XLEN-1:0] read_data_a_o,
    output logic[`XLEN-1:0] read_data_b_o
    );

logic [31:0] register_file[0:31];

always_ff @( posedge clk ) begin
  read_data_a_o <= register_file[read_addr_a_i];
  read_data_b_o <= register_file[read_addr_b_i];
  register_file[write_addr_i] <= write_data_i;  
end

endmodule