module program_counter
(
    input logic clk,
    input logic rst_n,
    input logic load_flag,
    input logic [31:0] counter_from_alu,
    output logic [31:0] counter_plus_4,
    output logic [31:0] counter_command
);

logic [31:0] counter;

always_ff @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
    begin
        counter <= 32'd0;
    end else begin
        if (!load_flag)
        begin counter <= counter + 32'd4; end
        else begin counter <= counter_from_alu; end
    end
end

assign counter_plus_4 = counter + 32'd4;
assign counter_command = counter;





endmodule