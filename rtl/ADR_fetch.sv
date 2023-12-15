`include "ADR_define.svh"

module ADR_fetch (
    input wire clk,
    input wire reset,
    output logic [`INST_LEN-1:0] if_de_inst_o,
    output logic [`PC_LEN-1:0] if_de_pc_o
);

/* verilator public */
logic [`PC_LEN-1:0] program_counter;
wire  [`PC_LEN-1:0] next_program_counter;

assign next_program_counter = program_counter + 1;
assign if_de_pc_o = program_counter;

always_ff @( posedge clk ) begin
  if (reset) begin
    program_counter <= 0;
  end 
  else begin
    program_counter <= next_program_counter;
  end
end

endmodule