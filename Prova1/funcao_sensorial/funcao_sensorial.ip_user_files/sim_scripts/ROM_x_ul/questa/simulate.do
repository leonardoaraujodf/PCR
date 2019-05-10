onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ROM_x_ul_opt

do {wave.do}

view wave
view structure
view signals

do {ROM_x_ul.udo}

run -all

quit -force
