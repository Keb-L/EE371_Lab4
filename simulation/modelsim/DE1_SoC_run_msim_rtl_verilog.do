transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/natha/EE371_Lab4 {C:/Users/natha/EE371_Lab4/ram32x8_1p.v}
vlog -sv -work work +incdir+C:/Users/natha/EE371_Lab4 {C:/Users/natha/EE371_Lab4/binarysearch_datapath.sv}

