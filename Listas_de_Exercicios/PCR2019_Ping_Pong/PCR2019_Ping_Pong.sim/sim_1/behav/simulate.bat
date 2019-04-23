@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xsim comparator_led_eq_1_behav -key {Behavioral:sim_1:Functional:comparator_led_eq_1} -tclbatch comparator_led_eq_1.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
