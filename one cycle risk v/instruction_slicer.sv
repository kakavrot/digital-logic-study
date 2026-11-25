module instruction_slicer
(
    input logic [31:0] instruction,
    output logic [4:0] read_add_0,
    output logic [4:0] read_add_1,
    output logic [4:0] write_add,
    output logic [31:0] imm,
    output logic [2:0] funct3 
);

localparam logic [6:0] B_type = 7'b1100011;
localparam logic [6:0] I_type_ALU = 7'b0010011;
localparam logic [6:0] I_type_LOAD = 7'b0000011;
localparam logic [6:0] I_type_JALR = 7'b1100111;
localparam logic [6:0] J_type = 7'b1101111;
localparam logic [6:0] R_type = 7'b0110011;
localparam logic [6:0] S_type = 7'b0100011;
localparam logic [6:0] U_type_upper = 7'b0110111;
localparam logic [6:0] U_type_pc = 7'b0010111;




logic [6:0] slice;

assign slice = instruction[6:0];
always_comb
begin
    read_add_0 = 0;
    read_add_1 = 0;
    write_add = 0;
    imm = 0;
    funct3 = 0;

   unique case (slice)
    
    B_type : begin
        read_add_0 = instruction[19:15];
        read_add_1 = instruction[24:20];
        imm = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};
        funct3 = instruction[14:12];
    end

    I_type_ALU, I_type_JALR, I_type_LOAD : begin
        write_add = instruction[11:7];
        funct3 = instruction[14:12];
        read_add_0 = instruction[19:15];
        imm = {{20{instruction[31]}} ,instruction[31:20]};
    end

    J_type : begin
        write_add = instruction[11:7];
        imm = {{12{instruction[31]}} ,instruction[19:12] ,instruction[20] ,instruction[30:21] ,1'b0};
    end

    R_type : begin
        write_add = instruction[11:7];
        funct3 = instruction[14:12];
        read_add_0 = instruction[19:15];
        read_add_1 = instruction[24:20];
    end

    S_type : begin
        funct3 = instruction[14:12];
        read_add_0 = instruction[19:15];
        read_add_1 = instruction[24:20];
        imm = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
    end

    U_type_pc, U_type_upper : begin
        write_add = instruction[11:7];
        imm = {instruction[31:12], 12'b0};
    end



    endcase
end



endmodule 