module regfile(	input logic clk, RegWrite, RegDst,
				input logic [4:0] ra, rb, rc,
				input logic [31:0] wdata,
				output logic [31:0] radata, rbdata);

logic [31:0] memory [31:0];

initial begin
	for(int i = 0; i < 32; i++)
		memory[i] <=0;
end

assign radata = (ra == 5'b0) ? 32'b0 : memory[ra];
assign rbdata = (rb == 5'b0) ? 32'b0 : memory[rb];

always_ff @(posedge clk) begin
	if(RegWrite) begin
		if(!RegDst) memory[rc] <= wdata;
		else 		memory[rb] <= wdata;
	end
end
	
endmodule