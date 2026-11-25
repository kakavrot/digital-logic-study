module reg_file
(
    input logic clk,
    input logic rst_n,
    input logic write_enable,
    input logic [4:0] read_addr_0,
    input logic [4:0] read_addr_1,
    input logic [4:0] write_addr,
    input logic [31:0] inp_data,
    output logic [31:0] read_data_0,
    output logic [31:0] read_data_1
);

logic [31:0] regs [31:0];
logic [31:0] valid_data;

always_ff @(posedge clk or negedge rst_n)
begin
    if(~rst_n)
    begin
        valid_data <= 32'd0;
    end else begin
        if(write_enable && write_addr != 5'd0)
        begin
            regs[write_addr] <= inp_data;
            valid_data[write_addr] <= 1'b1;
    
        end
    end
end

always_comb
begin
    if(((read_addr_0) != 5'd0) && (valid_data[read_addr_0]))
    begin read_data_0 = regs[read_addr_0]; end 
    else begin read_data_0 = 32'd0; end

    if(((read_addr_1) != 5'd0) && (valid_data[read_addr_1]))
    begin read_data_1 = regs[read_addr_1]; end 
    else begin read_data_1 = 32'd0; end

end
endmodule 