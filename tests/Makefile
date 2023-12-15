CC = riscv64-unknown-elf-gcc
CFLAGS = -nostdlib -march=rv64imd
OBJDUMP = riscv64-unknown-elf-objdump

INSTRUCTION_DIR = instruction
SIMPLE_DIR      = simple

SRC    = $(shell find instruction -name '*.S')
ELF    = $(SRC:.S=.elf)
MEM    = $(SRC:.S=.mem)
DISASM = $(SRC:.S=.disasm)

all: $(DISASM) $(ELF)

%.disasm: %.elf
	$(OBJDUMP) -d $< > $@

%.elf: %.S
	@echo "$@ <- $<"
	$(CC) $(CFLAGS) $< -o $@

.PHONY: clean
clean:
	@echo "cleaning"
	rm -f $(ELF) $(MEM) $(DISASM)