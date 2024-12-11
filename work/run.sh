function run() {
    echo $1
    iverilog -o $1_tb.vvp $1_tb.v $1.v
    vvp -n $1_tb.vvp
    gtkwave $1_tb.vcd
}