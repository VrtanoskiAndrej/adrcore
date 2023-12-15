`ifndef ADR_DEFINE
`define ADR_DEFINE

`define XLEN           32
`define NUM_REGS       32
`define REG_ADDR_LEN   $clog2(`NUM_REGS)
`define INST_LEN       32
`define ADDRESS_LEN    32
`define PC_LEN         32

`define R_ALU_OPCODE    7'b0110011
`define I_ALU_OPCODE    7'b0010011
`define I_LD_OPCODE     7'b0000011
`define S_ST_OPCODE     7'b0100011
`define B_BR_OPCODE     7'b1100011
`define J_JAL_OPCODE    7'b1101111
`define I_JALR_OPCODE   7'b1100111
`define U_LUI_OPCODE    7'b0110111
`define U_AUIPC_OPCODE  7'b0010111

`define I_ECALL_OPCODE   7'b1110011
`define I_EBREAK_OPCODE  7'b1110011

`define ADD_FUNC_3  3'b000
`define SUB_FUNC_3  3'b000
`define XOR_FUNC_3  3'b100
`define OR_FUNC_3   3'b110
`define AND_FUNC_3  3'b111
`define SLL_FUNC_3  3'b001
`define SRL_FUNC_3  3'b101
`define SRA_FUNC_3  3'b101
`define SLT_FUNC_3  3'b010
`define SLTU_FUNC_3 3'b011

//TODO: Finish FUNC3 bits for all other ops

`define SUB_FUNC_7  7'b0100000
`define SRA_FUNC_7  7'b0100000

typedef enum logic[5:0] {
 ADD, SUB, XOR, OR, AND, SLL, SRL, SRA, SLT, SLTU, 
 ADDI, XORI, ORI, ANDI, SLLI, SRLI, SRAI, SLIT, SLTUI,
 LB, LH, LW, LBU, LHU,
 SB, SH, SW,
 BEQ, BNE, BLT, BGE, BLTU, BGEU,
 JAL, JALR, 
 LUI, AUIPC,
 ECALL, EBREAK
} ADR_OPTYPE;

`endif