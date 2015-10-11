onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group DSGEN /MiniProject_DE270_tb/DSGEN_inst/Clock
add wave -noupdate -expand -group DSGEN /MiniProject_DE270_tb/DSGEN_inst/Reset_n
add wave -noupdate -expand -group DSGEN /MiniProject_DE270_tb/DSGEN_inst/Pattern
add wave -noupdate -expand -group DSGEN /MiniProject_DE270_tb/DSGEN_inst/PeriodDelay
add wave -noupdate -expand -group DSGEN /MiniProject_DE270_tb/DSGEN_inst/SignalOut
add wave -noupdate -expand -group DSGEN /MiniProject_DE270_tb/DSGEN_inst/Signal_q
add wave -noupdate -expand -group DSGEN /MiniProject_DE270_tb/DSGEN_inst/Signal_d
add wave -noupdate -expand -group DSGEN /MiniProject_DE270_tb/DSGEN_inst/Pattern_q
add wave -noupdate -expand -group DSGEN /MiniProject_DE270_tb/DSGEN_inst/Pattern_d
add wave -noupdate -expand -group DSGEN /MiniProject_DE270_tb/DSGEN_inst/PeriodDelay_q
add wave -noupdate -expand -group DSGEN /MiniProject_DE270_tb/DSGEN_inst/PeriodDelay_d
add wave -noupdate -expand -group DSGEN /MiniProject_DE270_tb/DSGEN_inst/CC_q
add wave -noupdate -expand -group DSGEN /MiniProject_DE270_tb/DSGEN_inst/CC_d
add wave -noupdate -expand -group DSGEN /MiniProject_DE270_tb/DSGEN_inst/PC_q
add wave -noupdate -expand -group DSGEN /MiniProject_DE270_tb/DSGEN_inst/PC_d
add wave -noupdate -expand -group DSGEN /MiniProject_DE270_tb/DSGEN_inst/State_q
add wave -noupdate -expand -group DSGEN /MiniProject_DE270_tb/DSGEN_inst/State_d
add wave -noupdate -expand -group SCDAQ_CTP /MiniProject_DE270_tb/SCDAQ_inst/SCDAQ_CTP_inst/Reset_n
add wave -noupdate -expand -group SCDAQ_CTP /MiniProject_DE270_tb/SCDAQ_inst/SCDAQ_CTP_inst/DAQ_Clock
add wave -noupdate -expand -group SCDAQ_CTP /MiniProject_DE270_tb/SCDAQ_inst/SCDAQ_CTP_inst/DAQ_D
add wave -noupdate -expand -group SCDAQ_CTP /MiniProject_DE270_tb/SCDAQ_inst/SCDAQ_CTP_inst/DAQ_Q
add wave -noupdate -expand -group SCDAQ_CTP /MiniProject_DE270_tb/SCDAQ_inst/SCDAQ_CTP_inst/DAQ_Trg
add wave -noupdate -expand -group SCDAQ_CTP /MiniProject_DE270_tb/SCDAQ_inst/SCDAQ_CTP_inst/TRG_MODE
add wave -noupdate -expand -group SCDAQ_CTP /MiniProject_DE270_tb/SCDAQ_inst/SCDAQ_CTP_inst/TRG_LVL
add wave -noupdate -expand -group SCDAQ_CTP /MiniProject_DE270_tb/SCDAQ_inst/SCDAQ_CTP_inst/LVL_TRG
add wave -noupdate -expand -group SCDAQ_CTP /MiniProject_DE270_tb/SCDAQ_inst/SCDAQ_CTP_inst/PEDGE_TRG
add wave -noupdate -expand -group SCDAQ_CTP /MiniProject_DE270_tb/SCDAQ_inst/SCDAQ_CTP_inst/NEDGE_TRG
add wave -noupdate -expand -group SCDAQ_CTP /MiniProject_DE270_tb/SCDAQ_inst/SCDAQ_CTP_inst/SR
add wave -noupdate -expand -group SCDAQ_CTP /MiniProject_DE270_tb/SCDAQ_inst/SCDAQ_CTP_inst/isample
add wave -noupdate -expand -group SCDAQ_BUF /MiniProject_DE270_tb/SCDAQ_inst/SCDAQ_BUF_inst/Reset_n
add wave -noupdate -expand -group SCDAQ_BUF /MiniProject_DE270_tb/SCDAQ_inst/SCDAQ_BUF_inst/DAQ_Clock
add wave -noupdate -expand -group SCDAQ_BUF /MiniProject_DE270_tb/SCDAQ_inst/SCDAQ_BUF_inst/DAQ_D
add wave -noupdate -expand -group SCDAQ_BUF /MiniProject_DE270_tb/SCDAQ_inst/SCDAQ_BUF_inst/DAQ_Trg
add wave -noupdate -expand -group SCDAQ_BUF /MiniProject_DE270_tb/SCDAQ_inst/SCDAQ_BUF_inst/RDO_Clock
add wave -noupdate -expand -group SCDAQ_BUF /MiniProject_DE270_tb/SCDAQ_inst/SCDAQ_BUF_inst/RDO_Add
add wave -noupdate -expand -group SCDAQ_BUF /MiniProject_DE270_tb/SCDAQ_inst/SCDAQ_BUF_inst/RDO_Req
add wave -noupdate -expand -group SCDAQ_BUF /MiniProject_DE270_tb/SCDAQ_inst/SCDAQ_BUF_inst/RDO_Ack
add wave -noupdate -expand -group SCDAQ_BUF /MiniProject_DE270_tb/SCDAQ_inst/SCDAQ_BUF_inst/RDO_Q
add wave -noupdate -expand -group SCDAQ_BUF /MiniProject_DE270_tb/SCDAQ_inst/SCDAQ_BUF_inst/RDO_Done
add wave -noupdate -expand -group SCDAQ_BUF /MiniProject_DE270_tb/SCDAQ_inst/SCDAQ_BUF_inst/State_Q
add wave -noupdate -expand -group SCDAQ_BUF /MiniProject_DE270_tb/SCDAQ_inst/SCDAQ_BUF_inst/State_D
add wave -noupdate -expand -group SCDAQ_BUF /MiniProject_DE270_tb/SCDAQ_inst/SCDAQ_BUF_inst/RAM
add wave -noupdate -expand -group SCDAQ_BUF /MiniProject_DE270_tb/SCDAQ_inst/SCDAQ_BUF_inst/DAQ_Add
add wave -noupdate -expand -group SCDAQ_BUF /MiniProject_DE270_tb/SCDAQ_inst/SCDAQ_BUF_inst/DAQ_Start
add wave -noupdate -expand -group SCDAQ_BUF /MiniProject_DE270_tb/SCDAQ_inst/SCDAQ_BUF_inst/DAQ_Fin
add wave -noupdate -expand -group PlotSignal /MiniProject_DE270_tb/PlotSignal_inst/Clock
add wave -noupdate -expand -group PlotSignal /MiniProject_DE270_tb/PlotSignal_inst/Reset_n
add wave -noupdate -expand -group PlotSignal /MiniProject_DE270_tb/PlotSignal_inst/X
add wave -noupdate -expand -group PlotSignal /MiniProject_DE270_tb/PlotSignal_inst/Y
add wave -noupdate -expand -group PlotSignal /MiniProject_DE270_tb/PlotSignal_inst/WR
add wave -noupdate -expand -group PlotSignal /MiniProject_DE270_tb/PlotSignal_inst/RGB
add wave -noupdate -expand -group PlotSignal /MiniProject_DE270_tb/PlotSignal_inst/INPUT_SELECT
add wave -noupdate -expand -group PlotSignal /MiniProject_DE270_tb/PlotSignal_inst/DIG1_RDO_Add
add wave -noupdate -expand -group PlotSignal /MiniProject_DE270_tb/PlotSignal_inst/DIG1_RDO_Req
add wave -noupdate -expand -group PlotSignal /MiniProject_DE270_tb/PlotSignal_inst/DIG1_RDO_Ack
add wave -noupdate -expand -group PlotSignal /MiniProject_DE270_tb/PlotSignal_inst/DIG1_RDO_Q
add wave -noupdate -expand -group PlotSignal /MiniProject_DE270_tb/PlotSignal_inst/DIG1_RDO_Done
add wave -noupdate -expand -group PlotSignal /MiniProject_DE270_tb/PlotSignal_inst/DIG1_TDiv
add wave -noupdate -expand -group PlotSignal /MiniProject_DE270_tb/PlotSignal_inst/DIG1_VShift
add wave -noupdate -expand -group PlotSignal /MiniProject_DE270_tb/PlotSignal_inst/ADC1_Sample
add wave -noupdate -expand -group PlotSignal /MiniProject_DE270_tb/PlotSignal_inst/ADC1_TRG_LVL_Cal
add wave -noupdate -expand -group PlotSignal /MiniProject_DE270_tb/PlotSignal_inst/ADC2_Sample
add wave -noupdate -expand -group PlotSignal /MiniProject_DE270_tb/PlotSignal_inst/ADC2_TRG_LVL_Cal
add wave -noupdate -expand -group PlotSignal /MiniProject_DE270_tb/PlotSignal_inst/ColCounter_q
add wave -noupdate -expand -group PlotSignal /MiniProject_DE270_tb/PlotSignal_inst/RowCounter_q
add wave -noupdate -expand -group PlotSignal /MiniProject_DE270_tb/PlotSignal_inst/ColCounter_d
add wave -noupdate -expand -group PlotSignal /MiniProject_DE270_tb/PlotSignal_inst/RowCounter_d
add wave -noupdate -expand -group PlotSignal /MiniProject_DE270_tb/PlotSignal_inst/State_q
add wave -noupdate -expand -group PlotSignal /MiniProject_DE270_tb/PlotSignal_inst/State_d
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {682884 ps} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {0 ps} {2670938 ps}
