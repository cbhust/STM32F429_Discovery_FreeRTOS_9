# GNU ARM Embedded Toolchain
CC=arm-none-eabi-gcc
LD=arm-none-eabi-ld
AR=arm-none-eabi-ar
AS=arm-none-eabi-as
CP=arm-none-eabi-objcopy
OD=arm-none-eabi-objdump

# Build Parameters: MCU Flags, Definitions, Includes, 
#                   Compile Flags, Linker Script, Linker Flags
MCFLAGS=-mcpu=cortex-m4 -mthumb -mlittle-endian \
-mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb-interwork
DEFS=-DUSE_STDPERIPH_DRIVER -DSTM32F4XX
INCLUDES=-I. \
-I../../Libraries/CMSIS/Device/ST/STM32F4xx/Include \
-I../../Utilities/STM32F429I-Discovery \
-I../../Libraries/CMSIS/Include \
-I../../Libraries/STM32F4xx_StdPeriph_Driver/inc \
-I../../FreeRTOS/Source/portable/GCC/ARM_CM3 \
-I../../FreeRTOS/Source/include \
-I../../TraceRecorder/include
CFLAGS=-c $(MCFLAGS) $(DEFS) $(INCLUDES)
LDSCRIPT = ./stm32_flash.ld
LDFLAGS=-T $(LDSCRIPT) --specs=nosys.specs $(MCFLAGS)

# Inputs: C Sources, Assembler Sources
SOURCES=main.c stm32f4xx_it.c system_stm32f4xx.c \
../../Utilities/STM32F429I-Discovery/stm32f429i_discovery.c \
../../Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_syscfg.c \
../../Libraries/STM32F4xx_StdPeriph_Driver/src/misc.c \
../../Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_gpio.c \
../../Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_rcc.c \
../../Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_exti.c \
../../Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_i2c.c \
../../Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_dma.c \
../../FreeRTOS/Source/portable/GCC/ARM_CM3/port.c \
../../FreeRTOS/Source/portable/MemMang/heap_2.c \
../../FreeRTOS/Source/croutine.c \
../../FreeRTOS/Source/event_groups.c \
../../FreeRTOS/Source/list.c \
../../FreeRTOS/Source/queue.c \
../../FreeRTOS/Source/tasks.c \
../../FreeRTOS/Source/timers.c \
../../TraceRecorder/trcKernelPort.c \
../../TraceRecorder/trcSnapshotRecorder.c \
../../TraceRecorder/trcStreamingRecorder.c
ASMSOURCES=../../Libraries/CMSIS/Device/ST/STM32F4xx/Source/Templates/gcc_ride7/startup_stm32f429_439xx.s

# Outputs: Object Files, ELF Executable & 
#          Converted ELF Executable to Intel HEX format
OBJECTS=$(SOURCES:%.c=%.o)
OBJECTS+=$(ASMSOURCES:%.s=%.o)
EXECUTABLE=hello_rtos.elf
TARGET=hello_rtos.hex

# Build Rules
.PHONY: release
release: $(TARGET)

.PHONY: all
all: $(TARGET)

.PHONY: debug
debug: CFLAGS+=-g # Add debug flag
debug: LDFLAGS+=-g
debug: $(TARGET) 

$(TARGET): $(EXECUTABLE)
	$(CP) -O ihex $< $@
	@echo "Objcopy from ELF to IHEX complete!\n"

$(EXECUTABLE): $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@
	@echo "Linking complete!\n"

%.o: %.c
	$(CC) $(CFLAGS) $< -o $@
	@echo "Compiled "$<"!\n"

%.o: %.s
	$(CC) $(CFLAGS) $< -o $@
	@echo "Assambled "$<"!\n"

.PHONY: clean
clean:
	rm -f $(OBJECTS) $(EXECUTABLE) $(TARGET)
