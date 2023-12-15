#include "define.h"

enum Type {ALU, LD, ST};

class Instruction {
    public:
        Opcode op;
        Type type;
        PC pc;

        Data rs1;
        Data rs2;
};