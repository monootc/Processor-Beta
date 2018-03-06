module pc(	input logic clk, reset,
			output logic [31:0] ia);

always_ff @(posedge clk or posedge reset) begin
	if(reset==1)
		ia <= 0;
	else
		ia <= ia + 4;
end

endmodule