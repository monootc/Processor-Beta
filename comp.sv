module comp(input logic op1, op2,
	    input logic z, v, n,
	    output logic [31:0] compout);

//comp xcomp(ALUOp[3], ALUOp[1], z,v,n,compout);
always_comb begin
	if(op1 && !op2) begin
		if(!n && !z && v)	compout <= 1;
		else if((n || z) && !v)	compout <= 1;
		else				compout <= 0;
	end
	else if(!op1 && !op2) begin
		if(!n && z)			compout <= 1;
		else				compout <= 0;
	end
	else if(!op1 && op2) begin
		if(!z && n && !v)	compout <= 1;
		else if(!z && !n && v)	compout <= 1;
		else					compout <= 0;
	end
	else
		compout <= 0;
end
endmodule
