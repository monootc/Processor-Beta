module shift(	input logic [1:0] ALUOp, 
				input logic [31:0] A, B,
				output logic [31:0] shiftout);

int A_int;

assign A_int = A;

always_comb begin
	case(ALUOp)
		2'b00:		shiftout <= A << B;
		2'b01:		shiftout <= A >> B;
		2'b11:		shiftout <= A_int >>> B;
		default:	shiftout <= 0;
	endcase
end
endmodule