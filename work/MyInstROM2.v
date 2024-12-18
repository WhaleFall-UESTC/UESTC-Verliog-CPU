module MyInstROM2(Addr, INST);
    input [31:0] Addr;       // Addr - 指令地址
    output [31:0] INST;      // INST - 指令

    reg [31:0] InstROM [255:0]; // InstROM - 指令存储器

    assign INST = InstROM[Addr[9:2]];

    // 定义操作码和功能码
    parameter [5:0] OP_R_type = 6'b000000;
    parameter [5:0] OP_addiu = 6'b001001;
    parameter [5:0] OP_lw = 6'b100011;
    parameter [5:0] OP_sw = 6'b101011;
    parameter [5:0] OP_beq = 6'b000100;
    parameter [5:0] OP_jump = 6'b000010;
    parameter [4:0] shamt = 5'b00000;
    parameter [5:0] FUNC_add = 6'b100000;
    parameter [5:0] FUNC_sub = 6'b100010;
    parameter [5:0] FUNC_and = 6'b100100;
    parameter [5:0] FUNC_or = 6'b100101;
    parameter [5:0] FUNC_xor = 6'b100110;

    integer i;
    initial begin
        for(i = 0; i < 256; i = i + 1)
            InstROM[i] = 32'h00000000;

        // 指令序列
        // InstROM[8'h01] = {OP_addiu, 5'b00001, 5'b00001, 16'h0004}; // addiu $1,$1, 4   ; PC = 0x04
        InstROM[8'h01] = {OP_lw, 5'b00010, 5'b00001, 16'h0000};    // lw $2, 0($1)      ; PC = 0x08
        // InstROM[8'h02] = {OP_addiu, 5'b00011, 5'b00001, 16'h0004}; // addiu $3,$1, 4   ; PC = 0x0C
        // InstROM[8'h04] = {OP_sw, 5'b00010, 5'b00011, 16'h0000};    // sw $2, 0($3)      ; PC = 0x10
        InstROM[8'h02] = {OP_R_type, 5'b00001, 5'b00010, 5'b00011, shamt, FUNC_add}; // add $1,$2, $3   ; PC = 0x14
        // InstROM[8'h04] = {OP_R_type, 5'b00010, 5'b00001, 5'b00011, shamt, FUNC_sub}; // sub $2,$1, $3   ; PC = 0x18
        // InstROM[8'h05] = {OP_R_type, 5'b00011, 5'b00001, 5'b00001, shamt, FUNC_and}; // and $3,$1, $1   ; PC = 0x1C
    end
endmodule


/*
        InstROM[8'h00] = 32'h20040004; // addiu $1,$1, 4   ; PC = 0x00
        InstROM[8'h01] = 32'h8c100000; // lw $2, 0($1)      ; PC = 0x04
        InstROM[8'h02] = 32'h20050004; // addiu $3,$1, 4   ; PC = 0x08
        InstROM[8'h03] = 32'haC230000; // sw $2, 0($3)      ; PC = 0x0C
        InstROM[8'h04] = 32'h02221820; // add $1,$2, $3    ; PC = 0x10
        InstROM[8'h05] = 32'h02293822; // sub $2,$1, $3    ; PC = 0x14
        InstROM[8'h06] = 32'h02695824; // and $3,$2, $1    ; PC = 0x18
        InstROM[8'h07] = 32'h08000008; // j 0x10            ; PC = 0x1C
*/