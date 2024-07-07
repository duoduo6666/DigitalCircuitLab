VERILATOR = verilator
VERILATOR_CFLAGS += -cc --trace-fst --exe --build -Mdir build -O3 -Wall -j 1 # -MMD --x-assign fast --x-initial fast --noassert

BUILD_DIR = ./build

include $(NVBOARD_HOME)/scripts/nvboard.mk

NVBOARD_FLAGS = $(NVBOARD_ARCHIVE) -$(addprefix -CFLAGS -I, $(NVBOARD_USR_INC)) $(addprefix -LDFLAGS , $(LDFLAGS))

$(shell mkdir -p $(BUILD_DIR))
$(shell mkdir -p $(BUILD_DIR)/nju_labs)

light:
	python3 $(NVBOARD_HOME)/scripts/auto_pin_bind.py constr/light.nxdc $(BUILD_DIR)/light_auto_bind.cpp
	$(VERILATOR) $(VERILATOR_CFLAGS) $(NVBOARD_FLAGS) \
		--top-module light -o light \
	        $(BUILD_DIR)/light_auto_bind.cpp csrc/light.cpp vsrc/light.v
	$(BUILD_DIR)/light 

DoubleControlSwitch:
	python3 $(NVBOARD_HOME)/scripts/auto_pin_bind.py constr/DoubleControlSwitch.nxdc $(BUILD_DIR)/DoubleControlSwitch_auto_bind.cpp
	$(VERILATOR) $(VERILATOR_CFLAGS) $(NVBOARD_FLAGS)\
		--top-module DoubleControlSwitch -o DoubleControlSwitch \
		$(BUILD_DIR)/DoubleControlSwitch_auto_bind.cpp csrc/DoubleControlSwitch.cpp vsrc/DoubleControlSwitch.v
	$(BUILD_DIR)/DoubleControlSwitch

lab1:
	python3 $(NVBOARD_HOME)/scripts/auto_pin_bind.py nju_labs/constr/lab1.nxdc $(BUILD_DIR)/nju_labs/lab1_auto_bind.cpp
	$(VERILATOR) $(VERILATOR_CFLAGS) $(NVBOARD_FLAGS) \
		--top-module lab1 -o nju_labs/lab1 \
	        $(BUILD_DIR)/nju_labs/lab1_auto_bind.cpp nju_labs/csrc/lab1.cpp nju_labs/vsrc/lab1.v
	$(BUILD_DIR)/nju_labs/lab1

lab2:
	python3 $(NVBOARD_HOME)/scripts/auto_pin_bind.py nju_labs/constr/lab2.nxdc $(BUILD_DIR)/nju_labs/lab2_auto_bind.cpp
	$(VERILATOR) $(VERILATOR_CFLAGS) $(NVBOARD_FLAGS) \
		--top-module lab2 -o nju_labs/lab2 \
	        $(BUILD_DIR)/nju_labs/lab2_auto_bind.cpp nju_labs/csrc/lab2.cpp nju_labs/vsrc/lab2.v
	$(BUILD_DIR)/nju_labs/lab2

lab3:
	python3 $(NVBOARD_HOME)/scripts/auto_pin_bind.py nju_labs/constr/lab3.nxdc $(BUILD_DIR)/nju_labs/lab3_auto_bind.cpp
	$(VERILATOR) $(VERILATOR_CFLAGS) $(NVBOARD_FLAGS) \
		--top-module lab3 -o nju_labs/lab3 \
	        $(BUILD_DIR)/nju_labs/lab3_auto_bind.cpp nju_labs/csrc/lab3.cpp nju_labs/vsrc/lab3.v
	$(BUILD_DIR)/nju_labs/lab3
