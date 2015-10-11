onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {SCDAQ CTP}
add wave -noupdate -radix binary /SCDAQ_tb/SCDAQ_inst/SCDAQ_CTP_inst/Reset_n
add wave -noupdate -radix binary /SCDAQ_tb/SCDAQ_inst/SCDAQ_CTP_inst/DAQ_Clock
add wave -noupdate -radix unsigned /SCDAQ_tb/SCDAQ_inst/SCDAQ_CTP_inst/DAQ_D
add wave -noupdate -radix unsigned /SCDAQ_tb/SCDAQ_inst/SCDAQ_CTP_inst/DAQ_Q
add wave -noupdate -radix binary /SCDAQ_tb/SCDAQ_inst/SCDAQ_CTP_inst/DAQ_Trg
add wave -noupdate -radix binary /SCDAQ_tb/SCDAQ_inst/SCDAQ_CTP_inst/CFG_Clock
add wave -noupdate -radix binary /SCDAQ_tb/SCDAQ_inst/SCDAQ_CTP_inst/CFG_Req
add wave -noupdate -radix binary /SCDAQ_tb/SCDAQ_inst/SCDAQ_CTP_inst/CFG_Ack
add wave -noupdate -radix unsigned /SCDAQ_tb/SCDAQ_inst/SCDAQ_CTP_inst/CFG_Add
add wave -noupdate -radix hexadecimal /SCDAQ_tb/SCDAQ_inst/SCDAQ_CTP_inst/CFG_D
add wave -noupdate -radix hexadecimal /SCDAQ_tb/SCDAQ_inst/SCDAQ_CTP_inst/CFG_Q
add wave -noupdate -radix binary /SCDAQ_tb/SCDAQ_inst/SCDAQ_CTP_inst/CFG_WREn
add wave -noupdate -radix binary /SCDAQ_tb/SCDAQ_inst/SCDAQ_CTP_inst/CFG_Done
add wave -noupdate -radix binary /SCDAQ_tb/SCDAQ_inst/SCDAQ_CTP_inst/State_Q
add wave -noupdate -radix binary /SCDAQ_tb/SCDAQ_inst/SCDAQ_CTP_inst/State_D
add wave -noupdate -radix binary /SCDAQ_tb/SCDAQ_inst/SCDAQ_CTP_inst/MODE
add wave -noupdate -radix binary /SCDAQ_tb/SCDAQ_inst/SCDAQ_CTP_inst/LVL
add wave -noupdate -radix unsigned /SCDAQ_tb/SCDAQ_inst/SCDAQ_CTP_inst/SR
add wave -noupdate -radix hexadecimal /SCDAQ_tb/SCDAQ_inst/SCDAQ_CTP_inst/MSK
add wave -noupdate -radix hexadecimal /SCDAQ_tb/SCDAQ_inst/SCDAQ_CTP_inst/PAT
add wave -noupdate -radix binary /SCDAQ_tb/SCDAQ_inst/SCDAQ_CTP_inst/MTCH_n
add wave -noupdate -radix binary /SCDAQ_tb/SCDAQ_inst/SCDAQ_CTP_inst/MTCH_TRG
add wave -noupdate -radix binary /SCDAQ_tb/SCDAQ_inst/SCDAQ_CTP_inst/LVL_TRG
add wave -noupdate -radix binary /SCDAQ_tb/SCDAQ_inst/SCDAQ_CTP_inst/PEDGE_TRG
add wave -noupdate -radix binary /SCDAQ_tb/SCDAQ_inst/SCDAQ_CTP_inst/NEDGE_TRG
add wave -noupdate -radix unsigned /SCDAQ_tb/SCDAQ_inst/SCDAQ_CTP_inst/isample
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -divider {SCDAQ BUF}
add wave -noupdate -radix binary /SCDAQ_tb/SCDAQ_inst/SCDAQ_BUF_inst/Reset_n
add wave -noupdate -radix binary /SCDAQ_tb/SCDAQ_inst/SCDAQ_BUF_inst/DAQ_Clock
add wave -noupdate -radix unsigned /SCDAQ_tb/SCDAQ_inst/SCDAQ_BUF_inst/DAQ_D
add wave -noupdate -radix binary /SCDAQ_tb/SCDAQ_inst/SCDAQ_BUF_inst/DAQ_Trg
add wave -noupdate -radix binary /SCDAQ_tb/SCDAQ_inst/SCDAQ_BUF_inst/RDO_Clock
add wave -noupdate -radix unsigned /SCDAQ_tb/SCDAQ_inst/SCDAQ_BUF_inst/RDO_Add
add wave -noupdate -radix binary /SCDAQ_tb/SCDAQ_inst/SCDAQ_BUF_inst/RDO_Req
add wave -noupdate -radix binary /SCDAQ_tb/SCDAQ_inst/SCDAQ_BUF_inst/RDO_Ack
add wave -noupdate -radix unsigned /SCDAQ_tb/SCDAQ_inst/SCDAQ_BUF_inst/RDO_Q
add wave -noupdate -radix binary /SCDAQ_tb/SCDAQ_inst/SCDAQ_BUF_inst/RDO_Done
add wave -noupdate -radix binary /SCDAQ_tb/SCDAQ_inst/SCDAQ_BUF_inst/State_Q
add wave -noupdate -radix binary /SCDAQ_tb/SCDAQ_inst/SCDAQ_BUF_inst/State_D
add wave -noupdate -radix unsigned /SCDAQ_tb/SCDAQ_inst/SCDAQ_BUF_inst/RAM
add wave -noupdate -radix unsigned /SCDAQ_tb/SCDAQ_inst/SCDAQ_BUF_inst/DAQ_Add
add wave -noupdate -radix binary /SCDAQ_tb/SCDAQ_inst/SCDAQ_BUF_inst/DAQ_Fin
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {4441500 ps}
