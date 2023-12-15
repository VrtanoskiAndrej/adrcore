#include "VADR_core.h"
#include <iostream>
#include <stdlib.h>
#include <verilated.h>
#include <verilated_vcd_c.h>

#define MAX_SIM_TIME 20
vluint64_t sim_time = 0;

void dut_reset (Valu *dut, vluint64_t &sim_time) {
    dut->reset = 0;
    if(sim_time >= 3 && sim_time < 6){
        dut->reset = 1;
    }
}

int main(int argc, char **argv, char **env) {
  VADR_core *dut = new VADR_core;

  Verilated::traceEverOn(true);
  VerilatedVcdC *m_trace = new VerilatedVcdC;
  dut->trace(m_trace, 5);
  m_trace->open("waveform.vcd");

  while (sim_time < MAX_SIM_TIME) {
    dut_reset(dut, sim_time);

    dut->clk ^= 1;
    dut->eval();
    m_trace->dump(sim_time);
    sim_time++;
  }

  m_trace->close();
  delete dut;
  exit(EXIT_SUCCESS);
}