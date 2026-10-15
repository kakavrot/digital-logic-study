module timer_analyzer

(
input logic clk,
input logic pulse_in,
input logic mode_select,
input logic rst_n,
output logic [7:0] increment_now,
output logic carry_increment,
output logic [7:0] div_result,
output logic carry_add
);

logic [7:0] increment_reg;
logic [7:0] last_int_1;
logic [7:0] last_int_2;

always_ff @(posedge clk or negedge rst_n)
	begin
	if (~rst_n)
		begin
		increment_reg <= 8'd0;
		carry_increment <= 1'b0;
		last_int_1 <= 8'd0;
		last_int_2 <= 8'd0;
		div_result <= 8'd0;
		carry_add <= 1'b0;
		end 
	else begin
	if (pulse_in)
		begin
		increment_reg <= 8'd0;
		carry_increment <= 1'b0;
		end else
	case (mode_select)
		1'b0 : {carry_increment, increment_reg} <= {1'b0, increment_reg} + 1'b1;
		1'b1 : {carry_increment, increment_reg} <= {1'b0, increment_reg} + 2'b10;
	endcase

	if(pulse_in)
		begin
		last_int_1 <= increment_reg;
		last_int_2 <= last_int_1;
		end

	{carry_add, div_result} <= (({1'b0, last_int_1}) + ({1'b0, last_int_2})) / 2; 
	end
	increment_now <= increment_reg;
	end
endmodule
