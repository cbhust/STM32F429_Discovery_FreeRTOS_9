## 1. QEMU安装
  本例程使用qemu-system-gnuarmeclipse，该qemu分支对stm32f4有更好的支持，主要面向Eclipse开发环境，本文档给出在Ubuntu 16.04命令行环境下单独使用的方式。
- 到网页 https://github.com/gnu-mcu-eclipse/qemu/releases/tag/gae-2.8.0-20161227 下载二进制文件 gnuarmeclipse-qemu-debian64-2.8.0-201612271623-dev.tgz到~/work目录

- 在工作目录解压缩文件，并把路径添加到$PATH变量中
```
#cd ~/work
#tar xvf gnuarmeclipse-qemu-debian64-2.8.0-201612271623-dev.tgz
#chmod -R -w ./qemu
export PATH=~/work/qemu/2.8.0-201612271623-dev/bin/:$PATH
```
- 测试qemu能否正常运行

```
#qemu-system-gnuarmeclipse --version
```
如正常则会显示版本信息为2.8.0。

## 2. 编译本例程

- 在Demo1目录下运行make，生成hello_rtos.elf文件

> 说明：qemu-system-gnuarmeclipse当前版本不支持STM32F4的浮点，相应的，FreeRTOS使用的portable目录没有使用ARM_CM4F而是使用ARM_CM3。


## 3. QEMU仿真

在Demo1目录下提供了一个qemu.sh脚本文件，内容如下：
```
#!/bin/bash

qemu-system-gnuarmeclipse --verbose --verbose --board STM32F429I-Discovery --mcu STM32F429ZI -d unimp,guest_errors  --image hello_rtos.elf --semihosting-config enable
```
在Demo1目录下运行脚本文件：
```
#./qemu.sh
```
则qemu开始执行hello_rtos.elf文件，在弹出的GUI中看到程序执行的效果。

## 4. GDB调试
 
 Ubuntu缺省安装中没有gdb-arm-none-eabi工具，需要先安装
 ```
 #sudo apt-get install gdb-arm-none-eabi
```
在Demo1目录下运行qemu_gdb脚本文件，该文件中添加了--gdb tcp::1234 -S

qemu启动后等待来自gdb的调试指令，打开另外一个终端窗口，运行
```
#arm-none-eabi-gdb
```
在gdb界面内运行：
```
(gdb)target remote localhost:1234
(gdb)continue
```
可以看到qemu开始执行程序，GUI界面上可以看到程序执行效果。

 ## 5. Trace
 
本例程启动了FreeRTOS的trace功能。
- 用STM32 ST-LINK Utility把hello_rtos.hex烧写入STM32F429I Discovery开发板，程序运行时，用STM32 ST-LINK Utility读取0x20000000到0x20030000范围内的地址数据，并保存到一个二进制文件trace_data.bin中。
- 到https://percepio.com/tz/freertostrace/ 下载并安装Tracealyzer for FreeRTOS软件。
- 在Tracealyzer for FreeRTOS软件中打开trace_data.bin，可以看到详细的FreeRTOS的任务和事件信息。
 
 
