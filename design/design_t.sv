
// x = a+b;
// y = a+b+c;

module design_t (
	input clk,    // Clock
	input  [7-1:0]a,
	input  [7-1:0]b,
	input  [7-1:0]c,
	input 		  in_valid,

	output reg [9-1:0] x,
	output reg [9-1:0] y,
	output reg 		   out_valid
	
);
always @(posedge clk) begin
	

	x <= a+b;
	y <= a+b+c;
	out_valid <= in_valid;



end

endmodule