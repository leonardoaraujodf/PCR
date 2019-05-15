@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto 0295853778f14b02a500862f9cc5327c -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot comparator_led_eq_1_behav xil_defaultlib.comparator_led_eq_1 -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
