# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir {C:/Users/Leonardo/Documents/Arquivos Leonardo/UnB/9 Semestre/Projeto de Circuitos Reconfiguraveis/PCR/Listas_de_Exercicios/PCR2019_Ping_Pong/PCR2019_Ping_Pong.cache/wt} [current_project]
set_property parent.project_path {C:/Users/Leonardo/Documents/Arquivos Leonardo/UnB/9 Semestre/Projeto de Circuitos Reconfiguraveis/PCR/Listas_de_Exercicios/PCR2019_Ping_Pong/PCR2019_Ping_Pong.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property ip_output_repo {c:/Users/Leonardo/Documents/Arquivos Leonardo/UnB/9 Semestre/Projeto de Circuitos Reconfiguraveis/PCR/Listas_de_Exercicios/PCR2019_Ping_Pong/PCR2019_Ping_Pong.cache/ip} [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  {C:/Users/Leonardo/Documents/Arquivos Leonardo/UnB/9 Semestre/Projeto de Circuitos Reconfiguraveis/PCR/Listas_de_Exercicios/PCR2019_Ping_Pong/PCR2019_Ping_Pong.srcs/sources_1/new/comp_score_eq_10.vhd}
  {C:/Users/Leonardo/Documents/Arquivos Leonardo/UnB/9 Semestre/Projeto de Circuitos Reconfiguraveis/PCR/Listas_de_Exercicios/PCR2019_Ping_Pong/PCR2019_Ping_Pong.srcs/sources_1/new/comparator_led_eq_1.vhd}
  {C:/Users/Leonardo/Documents/Arquivos Leonardo/UnB/9 Semestre/Projeto de Circuitos Reconfiguraveis/PCR/Listas_de_Exercicios/PCR2019_Ping_Pong/PCR2019_Ping_Pong.srcs/sources_1/new/comparator_led_eq_256.vhd}
  {C:/Users/Leonardo/Documents/Arquivos Leonardo/UnB/9 Semestre/Projeto de Circuitos Reconfiguraveis/PCR/Listas_de_Exercicios/PCR2019_Ping_Pong/PCR2019_Ping_Pong.srcs/sources_1/new/dec.vhd}
  {C:/Users/Leonardo/Documents/Arquivos Leonardo/UnB/9 Semestre/Projeto de Circuitos Reconfiguraveis/PCR/Listas_de_Exercicios/PCR2019_Ping_Pong/PCR2019_Ping_Pong.srcs/sources_1/new/fsm.vhd}
  {C:/Users/Leonardo/Documents/Arquivos Leonardo/UnB/9 Semestre/Projeto de Circuitos Reconfiguraveis/PCR/Listas_de_Exercicios/PCR2019_Ping_Pong/PCR2019_Ping_Pong.srcs/sources_1/new/inc.vhd}
  {C:/Users/Leonardo/Documents/Arquivos Leonardo/UnB/9 Semestre/Projeto de Circuitos Reconfiguraveis/PCR/Listas_de_Exercicios/PCR2019_Ping_Pong/PCR2019_Ping_Pong.srcs/sources_1/new/left_shift.vhd}
  {C:/Users/Leonardo/Documents/Arquivos Leonardo/UnB/9 Semestre/Projeto de Circuitos Reconfiguraveis/PCR/Listas_de_Exercicios/PCR2019_Ping_Pong/PCR2019_Ping_Pong.srcs/sources_1/new/mux_2x1_4bits.vhd}
  {C:/Users/Leonardo/Documents/Arquivos Leonardo/UnB/9 Semestre/Projeto de Circuitos Reconfiguraveis/PCR/Listas_de_Exercicios/PCR2019_Ping_Pong/PCR2019_Ping_Pong.srcs/sources_1/new/mux_2x1_8bits.vhd}
  {C:/Users/Leonardo/Documents/Arquivos Leonardo/UnB/9 Semestre/Projeto de Circuitos Reconfiguraveis/PCR/Listas_de_Exercicios/PCR2019_Ping_Pong/PCR2019_Ping_Pong.srcs/sources_1/new/op_block.vhd}
  {C:/Users/Leonardo/Documents/Arquivos Leonardo/UnB/9 Semestre/Projeto de Circuitos Reconfiguraveis/PCR/Listas_de_Exercicios/PCR2019_Ping_Pong/PCR2019_Ping_Pong.srcs/sources_1/new/reg_leds.vhd}
  {C:/Users/Leonardo/Documents/Arquivos Leonardo/UnB/9 Semestre/Projeto de Circuitos Reconfiguraveis/PCR/Listas_de_Exercicios/PCR2019_Ping_Pong/PCR2019_Ping_Pong.srcs/sources_1/new/reg_score_p1.vhd}
  {C:/Users/Leonardo/Documents/Arquivos Leonardo/UnB/9 Semestre/Projeto de Circuitos Reconfiguraveis/PCR/Listas_de_Exercicios/PCR2019_Ping_Pong/PCR2019_Ping_Pong.srcs/sources_1/new/reg_score_p2.vhd}
  {C:/Users/Leonardo/Documents/Arquivos Leonardo/UnB/9 Semestre/Projeto de Circuitos Reconfiguraveis/PCR/Listas_de_Exercicios/PCR2019_Ping_Pong/PCR2019_Ping_Pong.srcs/sources_1/new/shift_right.vhd}
  {C:/Users/Leonardo/Documents/Arquivos Leonardo/UnB/9 Semestre/Projeto de Circuitos Reconfiguraveis/PCR/Listas_de_Exercicios/PCR2019_Ping_Pong/PCR2019_Ping_Pong.srcs/sources_1/new/top_level_ping_pong.vhd}
  {C:/Users/Leonardo/Documents/Arquivos Leonardo/UnB/9 Semestre/Projeto de Circuitos Reconfiguraveis/PCR/Listas_de_Exercicios/PCR2019_Ping_Pong/PCR2019_Ping_Pong.srcs/sources_1/new/deco.vhd}
  {C:/Users/Leonardo/Documents/Arquivos Leonardo/UnB/9 Semestre/Projeto de Circuitos Reconfiguraveis/PCR/Listas_de_Exercicios/PCR2019_Ping_Pong/PCR2019_Ping_Pong.srcs/sources_1/new/mux_disp.vhd}
  {C:/Users/Leonardo/Documents/Arquivos Leonardo/UnB/9 Semestre/Projeto de Circuitos Reconfiguraveis/PCR/Listas_de_Exercicios/PCR2019_Ping_Pong/PCR2019_Ping_Pong.srcs/sources_1/new/cnt_deco.vhd}
  {C:/Users/Leonardo/Documents/Arquivos Leonardo/UnB/9 Semestre/Projeto de Circuitos Reconfiguraveis/PCR/Listas_de_Exercicios/PCR2019_Ping_Pong/PCR2019_Ping_Pong.srcs/sources_1/new/clk_div.vhd}
  {C:/Users/Leonardo/Documents/Arquivos Leonardo/UnB/9 Semestre/Projeto de Circuitos Reconfiguraveis/PCR/Listas_de_Exercicios/PCR2019_Ping_Pong/PCR2019_Ping_Pong.srcs/sources_1/new/display_decoder.vhd}
  {C:/Users/Leonardo/Documents/Arquivos Leonardo/UnB/9 Semestre/Projeto de Circuitos Reconfiguraveis/PCR/Listas_de_Exercicios/PCR2019_Ping_Pong/PCR2019_Ping_Pong.srcs/sources_1/new/top_ping_pong.vhd}
  {C:/Users/Leonardo/Documents/Arquivos Leonardo/UnB/9 Semestre/Projeto de Circuitos Reconfiguraveis/PCR/Listas_de_Exercicios/PCR2019_Ping_Pong/PCR2019_Ping_Pong.srcs/sources_1/new/10_hz_clk.vhd}
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc {{C:/Users/Leonardo/Documents/Arquivos Leonardo/UnB/9 Semestre/Projeto de Circuitos Reconfiguraveis/basys3_master/Basys3_Master.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/Leonardo/Documents/Arquivos Leonardo/UnB/9 Semestre/Projeto de Circuitos Reconfiguraveis/basys3_master/Basys3_Master.xdc}}]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top top_ping_pong -part xc7a35tcpg236-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef top_ping_pong.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file top_ping_pong_utilization_synth.rpt -pb top_ping_pong_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]