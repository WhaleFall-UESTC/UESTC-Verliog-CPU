run:
	iverilog -o $(file)_tb.vvp $(file)_tb.v $(file).v
	vvp -n $(file)_tb.vvp
	gtkwave $(file)_tb.vcd
