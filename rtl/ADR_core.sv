`include "ADR_define.svh"

module ADR_core (
    input wire clk,
    input wire reset
);

// REGFILE WIRES
logic[`XLEN-1:0] read_data_a, read_data_b, write_data;
logic[`REG_ADDR_LEN-1:0] read_addr_a, read_addr_b, write_addr;

// FETCH WIRES
logic [`INST_LEN-1:0] if_de_inst;
logic [`PC_LEN-1:0]   if_de_pc;

// DECODE WIRES
logic [5:0]          de_ex_optype;
logic [`XLEN-1:0]    de_ex_data_a, de_ex_data_b, de_ex_data_imm;
logic [`PC_LEN-1:0]  de_ex_pc;

ADR_regfile register_file
(
  .clk (clk),
  .reset (reset),
  .read_addr_a_i(read_addr_a),
  .read_addr_b_i(read_addr_b),
  .read_data_a_o(read_data_a),
  .read_data_b_o(read_data_b),
  .write_addr_i(write_addr),
  .write_data_i(write_data)
);

ADR_fetch fetch(
  .clk (clk),
  .reset (reset),
  .if_de_inst_o(if_de_inst),
  .if_de_pc_o(if_de_pc)
);

ADR_decode decode(
  .clk (clk),
  .reset (reset),
  .if_de_inst_i(if_de_inst),
  .if_de_pc_i(if_de_pc),
  .regfile_de_data_a_i(read_data_a),
  .regfile_de_data_b_i(read_data_b),
  .de_regfile_addr_a_o(read_addr_a),
  .de_regfile_addr_b_o(read_addr_b),
  .de_ex_data_a_o(de_ex_data_a),
  .de_ex_data_b_o(de_ex_data_b),
  .de_ex_data_imm_o(de_ex_data_imm),
  .de_ex_pc_o(de_ex_pc),
  .de_ex_optype_o(de_ex_optype)
);



endmodule