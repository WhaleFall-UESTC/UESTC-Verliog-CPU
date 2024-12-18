module MyInstROM3(Addr, INST);
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

        // InstROM[8'h01] = {OP_addiu, 5'b00001, 5'b00001, 16'h0001}; // addiu $1,$1, 1   ; PC = 0x04
        // InstROM[8'h02] = {OP_R_type, 5'b00001, 5'b00001, 5'b00001, shamt, FUNC_and};
        // InstROM[8'h03] = {OP_R_type, 5'b00001, 5'b00001, 5'b00001, shamt, FUNC_or};
        // InstROM[8'h04] = {OP_R_type, 5'b00011, 5'b00011, 5'b00011, shamt, FUNC_and};

        // InstROM[8'h01] = {OP_beq, 5'b00001, 5'b00010, 16'h0001};
        // InstROM[8'h02] = {OP_R_type, 5'b00001, 5'b00001, 5'b00001, shamt, FUNC_add};
        // InstROM[8'h03] = {OP_R_type, 5'b00001, 5'b00001, 5'b00001, shamt, FUNC_or};
        // InstROM[8'h04] = {OP_R_type, 5'b00001, 5'b00001, 5'b00001, shamt, FUNC_and};
        InstROM[8'h01] = {OP_beq, 5'b00001, 5'b00010, 16'h0001};
        InstROM[8'h02] = {OP_R_type, 5'b00001, 5'b00001, 5'b00001, shamt, FUNC_add};
        InstROM[8'h03] = {OP_R_type, 5'b00001, 5'b00001, 5'b00001, shamt, FUNC_or};
        InstROM[8'h04] = {OP_R_type, 5'b00001, 5'b00001, 5'b00001, shamt, FUNC_and};
        // InstROM[8'h05] = {OP_R_type, 5'b00001, 5'b00001, 5'b00001, shamt, FUNC_or};
        // InstROM[8'h06] = {OP_R_type, 5'b00001, 5'b00001, 5'b00001, shamt, FUNC_and};
        // InstROM[8'h07] = {OP_R_type, 5'b00001, 5'b00001, 5'b00001, shamt, FUNC_or};
        // InstROM[8'h08] = {OP_R_type, 5'b00001, 5'b00001, 5'b00001, shamt, FUNC_and};
    end
endmodule
