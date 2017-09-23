#!/bin/bash
qemu-system-gnuarmeclipse --verbose --verbose --board STM32F429I-Discovery --mcu STM32F429ZI -d unimp,guest_errors  --image hello_rtos.elf --semihosting-config enable=on,target=native --semihosting-cmdline hello_rtos 1 2 3
