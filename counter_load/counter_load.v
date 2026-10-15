module counter_load

(
input logic clk,
input logic rst_n,
input logic load,
input logic [3:0] external_data,
output logic [3:0] out
);


logic [3:0] comb_end;
always_comb 
begin
comb_end = 4'd0;
if (load)
begin
comb_end = external_data;
end else begin
comb_end = out + 1'b1;
end
end

always_ff (posedge clk or negedge rst_n)
begin
if (~rst_n)
begin
out <= 4'd0;
end else begin
out <= comb_end;
end
end

endmodule