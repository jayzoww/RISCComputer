transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {F:/Program Files/Quartus/Projects/Phase 1/my_components.vhd}
vcom -93 -work work {F:/Program Files/Quartus/Projects/Phase 1/bit32_reg.vhd}
vcom -93 -work work {F:/Program Files/Quartus/Projects/Phase 1/mux32.vhd}
vcom -93 -work work {F:/Program Files/Quartus/Projects/Phase 1/Encode32_5.vhd}
vcom -93 -work work {F:/Program Files/Quartus/Projects/Phase 1/MDR_mux.vhd}
vcom -93 -work work {F:/Program Files/Quartus/Projects/Phase 1/Shift.vhd}
vcom -93 -work work {F:/Program Files/Quartus/Projects/Phase 1/Rotate.vhd}
vcom -93 -work work {F:/Program Files/Quartus/Projects/Phase 1/div.vhd}
vcom -93 -work work {F:/Program Files/Quartus/Projects/Phase 1/booth.vhd}
vcom -93 -work work {F:/Program Files/Quartus/Projects/Phase 1/Add_Sub.vhd}
vcom -93 -work work {F:/Program Files/Quartus/Projects/Phase 1/RAM.vhd}
vcom -93 -work work {F:/Program Files/Quartus/Projects/Phase 1/reg0x.vhd}
vcom -93 -work work {F:/Program Files/Quartus/Projects/Phase 1/CON_FF.vhd}
vcom -93 -work work {F:/Program Files/Quartus/Projects/Phase 1/alu.vhd}
vcom -93 -work work {F:/Program Files/Quartus/Projects/Phase 1/datapath.vhd}
vcom -93 -work work {F:/Program Files/Quartus/Projects/Phase 1/sel_encode.vhd}

vcom -93 -work work {F:/Program Files/Quartus/Projects/Phase 1/datapath_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneiii -L rtl_work -L work -voptargs="+acc"  datapath_tb

add wave *
view structure
view signals
run 5000 ns
