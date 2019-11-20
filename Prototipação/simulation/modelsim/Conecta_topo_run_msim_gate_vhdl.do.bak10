transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vcom -93 -work work {Conecta_topo.vho}

vcom -93 -work work {C:/Users/andre/Desktop/Trabalho prático de Sistemas Digitais/Prototipação/tb_TOPO.vhd}

vsim -t 1ps +transport_int_delays +transport_path_delays -sdftyp /instancia_topo=Conecta_topo_vhd.sdo -L altera -L cycloneiii -L gate_work -L work -voptargs="+acc"  tb_TOPO

source Conecta_topo_dump_all_vcd_nodes.tcl
add wave *
view structure
view signals
run 1 sec
