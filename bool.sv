module bool(input logic [3:0] ALUOp,
            input logic [31:0] A, B,
	    output logic [31:0] boolout);

always_comb begin
	case(ALUOp)
		4'b1010:	boolout <= A;
		4'b1000:	boolout <= A & B;
		4'b0001:	boolout <= ~(A | B);
		4'b1110:	boolout <= A | B;
		4'b1001:	boolout <= ~(A ^ B);
		4'b0110:	boolout <= (A ^ B);
		default:	boolout <= 32'd0;
	endcase
end

endmodule
	    