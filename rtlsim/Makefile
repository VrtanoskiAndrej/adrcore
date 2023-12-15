# check that verilator exists
# ...

VERILATOR_DIR = .
RTL_DIR = ../rtl
BUILD_DIR = ./build

MODULE = ADR_core

VERILOG_FILES = $(shell find $(RTL_DIR) -name '*.sv' -or -name '*.svh')
VERILATOR_FILE = adr_tb.cpp

VERILATOR_FLAGS = --trace

.PHONY:sim
sim:
	@echo "Building ADR CORE verilator ..."
	verilator $(VERILATOR_FLAGS) --cc $(MODULE).sv -I$(RTL_DIR) -Mdir $(BUILD_DIR) --exe $(VERILATOR_FILE)
	make -C $(BUILD_DIR) -f V$(MODULE).mk

.PHONY:run
run: $(BUILD_DIR)/V$(MODULE)
	@$(BUILD_DIR)/V$(MODULE)

.PHONY:lint
lint: $(RTL_DIR)/$(MODULE).sv
	verilator --lint-only $(RTL_DIR)/$(MODULE).sv -I$(RTL_DIR)

.PHONY:clean
clean:
	rm -rf $(BUILD_DIR)