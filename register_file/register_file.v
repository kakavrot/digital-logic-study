module register_file

(
input logic [2:0] rd_addr_0,
input logic [2:0] rd_addr_1,
input logic [2:0] wr_addr,
input logic [7:0] wr_data,
input logic       clk,
input logic       rst_n,
input logic       write_enable,
output logic [7:0] rd_data_0,
output logic [7:0] rd_data_1,

);

logic [7:0] rf [0:7];


always_ff @(posedge clk or negedge rst_n)
begin
	if(~rst_n)
	begin
	for (int i = 0; i < 8; i++)
		begin
		rf[i] <= 8'd0;
		end
	end 
	else begin
	if (write_enable &&  !(wr_addr == 3'b00))
		begin
		rf[wr_addr] <= wr_data;
		end
	end
end

always_comb
begin
	if(rd_addr_0 == 3'b000)
	begin
	rd_data_0 = 8'd0;
	end else begin
	rd_data_0 = rf[rd_addr_0];
	end

	if(rd_addr_1 == 3'b000)
	begin
	rd_data_1 = 8'd0;
	end else begin
	rd_data_1 = rf[rd_addr_1];
	end
end

endmodule

