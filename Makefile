BUILD_DIR ?= build
SRC_DIR ?= src

OBJECTS = ${BUILD_DIR}/cf.o
FINAL_OUTPUT := $(BUILD_DIR)/cf

LINKER := ld
ASSEMBLER := nasm
ASSEMBLER_FLAGS := -f elf64

.PHONY: clean

all: $(BUILD_DIR) $(FINAL_OUTPUT)

$(BUILD_DIR):
	@echo Build directory is $(BUILD_DIR)
	mkdir -p $@

$(FINAL_OUTPUT): $(OBJECTS)
	$(LINKER) $(OBJECTS) -o $@

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.asm
	$(ASSEMBLER) $(ASSEMBLER_FLAGS) $< -o $@

clean:
	@echo Cleaning build directory: $(BUILD_DIR)
	@rm -rf $(BUILD_DIR)
