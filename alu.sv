module alu(input logic [31:0] A, B,
	   input logic [4:0] ALUOp,
	   output logic [31:0] Y,
	   output logic z, v, n);

logic [31:0] boolout, shiftout, arithout, compout;

bool xbool(ALUOp[3:0], A, B, boolout);
arith xarith(ALUOp[1:0],A,B,arithout,z,v,n);
comp xcomp(ALUOp[3], ALUOp[1], z,v,n,compout);
shift xshift(ALUOp[1:0],A,B,shiftout);

always_comb begin
	if(ALUOp >= 5'b10000)			Y <= boolout;
	else if(ALUOp[3:2] == 2'b10)	Y <= shiftout;
	else if(ALUOp[2] == 1'b1 && ALUOp[0] == 1'b1)	Y <= compout;
	else if(ALUOp == 5'b0 || ALUOp == 5'b1)			Y <= arithout;
	else										Y <= 32'b0;
end

endmodule