from logic import *
from isa import *


class RISCVInstruction():
    bits = None
    name = ''
    format = ''
    src1 = 0
    src2 = 0
    dest = 0
    imm = 0
    label = ''
    opcode = 0
    funct3 = 0
    funct7 = 0

    def __init__(self, data=0):
        data = int(data, 0)
        self.bits = BitLogic(32)
        self.bits.set(data)
        print('init inst')

    def __str__(self):
        inst_str = ''

        if self.format == 'R':
            inst_str = f'{self.name} dest x{self.dest}, src1 x{self.src1}, src2 x{self.src2}'
        elif self.format == 'I':
            inst_str = f'{self.name} dest x{self.dest}, src1 x{self.src1}, imm {self.imm}'
        elif self.format == 'S':
            inst_str = f'{self.name} src1 x{self.src1}, src2 x{self.src2}, offset {self.imm}'
        elif self.format == 'SB':
            inst_str = f'{self.name} src1 x{self.src1}, src2 x{self.src2}, offset {self.imm}'
        elif self.format == 'U':
            inst_str = f'{self.name} dest x{self.dest}, imm {self.imm}'
        elif self.format == 'UJ':
            inst_str = f'{self.name} dest x{self.dest}, imm {self.imm}'

        return inst_str

    def decode(self):
        # slice [inclusive, exclusive]
        self.opcode = self.bits[0:7]
        self.dest = self.bits[7:12]
        self.funct3 = self.bits[12:15]
        self.src1 = self.bits[15:20]
        self.src2 = self.bits[20:25]
        self.funct7 = self.bits[25:32]

        print(self.opcode, self.funct3, self.funct7)

        inst_name = rv32.get_name((self.opcode, self.funct3, self.funct7))

        if inst_name == 'invalid':
            print(f'Instruction {self.bits} does not exist')
            exit(1)

        inst_fields = rv32.get_field(inst_name)
        inst_format = inst_fields['format']
        inst_imm = 0

        # construct imm value
        if inst_format == 'R':
            inst_imm = 0
        elif inst_format == 'I':
            inst_imm = self.bits[20:32]
        elif inst_format == 'S':
            inst_imm = self.bits[7:12] + (self.bits[25:32] >> 5)
        elif inst_format == 'SB':
            inst_imm = (self.bits[8:12] >> 1) + (self.bits[25:31] >> 5)
            + (self.bits[7] >> 11) + (self.bits[31] >> 12)
        elif inst_format == 'U':
            inst_imm = self.bits[12:32] >> 12
        elif inst_format == 'UJ':
            inst_imm = (self.bits[20:31] >> 1) + (self.bits[19] >> 11)
            + (self.bits[12:20] >> 12) + (self.bits[31] >> 20)

        self.name = inst_name
        self.format = inst_format
        self.imm = inst_imm


if __name__ == "__main__":
    rv32.display()

    add_hex = '0x00400113'

    inst = RISCVInstruction(add_hex)
    print(inst.bits)

    inst.decode()
    print(inst)
