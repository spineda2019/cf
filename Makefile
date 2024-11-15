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
	@echo \################################################################################
	@echo Creating build directory: $(BUILD_DIR)
	@mkdir -p $@
	@echo

$(FINAL_OUTPUT): $(OBJECTS)
	@echo \################################################################################
	@echo "Linking objects to create $@"
	@echo "Command:"
	$(LINKER) $(OBJECTS) -o $@
	@echo

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.asm
	@echo \################################################################################
	@echo "Compiling object file: $<"
	@echo "Command:"
	$(ASSEMBLER) $(ASSEMBLER_FLAGS) $< -o $@
	@echo

clean:
	@echo Cleaning build directory: $(BUILD_DIR)
	@rm -rf $(BUILD_DIR)
