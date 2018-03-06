module arith(input logic [1:0] op,
             input logic [31:0] A, B,
	     output logic [31:0] arithout,
	     output logic z, v, n);

logic [31:0] two_B;
		 
always_comb begin
	if(op == 2'b0) begin
		two_B <= B;
	end
	else begin
		two_B <= ~B + 1;
	end
end

assign arithout = A + two_B;


always_comb begin
	if((~A[31] & ~two_B[31] & arithout[31]) || (A[31] & two_B[31] & ~arithout[31]))
		v <= 1;
	else
		v <= 0;
end

assign z = (arithout == 0);
 
assign n = (arithout[31] == 1);

endmodule