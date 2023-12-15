`include "ADR_define.svh"

module ADR_decode (
    input wire clk,
    input wire reset,
    input wire [`INST_LEN-1:0] if_de_inst_i,
    input wire [`PC_LEN-1:0] if_de_pc_i,
    input wire [`XLEN-1:0] regfile_de_data_a_i,
    input wire [`XLEN-1:0] regfile_de_data_b_i,
    output logic [5:0] de_ex_optype_o,
    output logic [`REG_ADDR_LEN-1:0] de_regfile_addr_a_o,
    output logic [`REG_ADDR_LEN-1:0] de_regfile_addr_b_o,
    output logic [`XLEN-1:0] de_ex_data_a_o,
    output logic [`XLEN-1:0] de_ex_data_b_o,
    output logic [`XLEN-1:0] de_ex_data_imm_o,
    output logic [`PC_LEN-1:0] de_ex_pc_o
);

// segment the 32 bit instruction into its corresponding fields
logic [6:0] segment_1 = if_de_inst_i[6:0];
logic [4:0] segment_2 = if_de_inst_i[11:7];
logic [2:0] segment_3 = if_de_inst_i[14:12];
logic [4:0] segment_4 = if_de_inst_i[19:15];
logic [4:0] segment_5 = if_de_inst_i[24:20];
logic [6:0] segment_6 = if_de_inst_i[31:25];

ADR_OPTYPE optype;
logic [6:0] opcode;
logic sign_bit;
logic [`XLEN-1:0] immediate;

assign opcode = segment_1;
assign sign_bit = segment_6[6];

// TODO: finish immediate generation
always_comb begin
  case(opcode)
    `I_ALU_OPCODE: immediate = {{20{sign_bit}}, {segment_5, segment_6}};
    default:   immediate = 32'b0;
  endcase
end

always_ff @( posedge clk ) begin
  if (reset) begin
    de_ex_pc_o <= 0;
  end 
  else begin
    de_ex_pc_o <= if_de_pc_i;
  end
end

endmodule