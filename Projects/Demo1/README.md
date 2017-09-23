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

 ## 5. Trace
 
 
