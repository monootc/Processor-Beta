module ctl(	input logic reset, 
			input logic [5:0] opCode, funct,
			output logic RegDst, ALUSrc, RegWrite,
			output logic MemWrite, MemRead, MemToReg,
			output logic [4:0] ALUOp);
		
always_comb begin
	if(reset == 1) begin
		RegDst <= 0;
		ALUSrc <= 0;
		RegWrite <= 0;
		MemWrite <= 0;
		MemRead <= 0;
		MemToReg <= 0;
		ALUOp <= 0;
	end
	else begin

		// All R type instructions
		if(opCode == 6'b0) begin

			if(funct == 6'b100000) begin 		// add
				set_R_control_signals();
				ALUOp <= 5'b0;
			end
			
			else if(funct == 6'b100010)	begin
				set_R_control_signals();
				ALUOp <= 5'b1;			// sub
			end
			
			else if(funct == 6'b100100)	begin
				set_R_control_signals();
				ALUOp <= 5'b11000;  // AND
			end

			else if(funct == 6'b100111)	begin
				set_R_control_signals();
				ALUOp <= 5'b10001;
			end   // NOR

			else if(funct == 6'b100101) begin
				set_R_control_signals();
				ALUOp <= 5'b11110;  // OR
			end

			else if(funct == 6'b100110)	begin
				set_R_control_signals();
				ALUOp <= 5'b10110;  // XOR
			end

			else if(funct == 6'b101010) begin
				set_R_control_signals();
				ALUOp <= 5'b00111;
			end

			else if(funct == 6'b0) begin // sll
				RegDst <= 0;
				ALUSrc <= 1;
				RegWrite <= 1;
				MemWrite <= 0;
				MemRead <= 0;
				MemToReg <= 0;
				ALUOp <= 5'b01000;
			end

			else if(funct == 6'b000010) begin // srl
				RegDst <= 0;
				ALUSrc <= 1;
				RegWrite <= 1;
				MemWrite <= 0;
				MemRead <= 0;
				MemToReg <= 0;
				ALUOp <= 5'b01001;
			end

			else if(funct == 6'b000011) begin // sra
				RegDst <= 0;
				ALUSrc <= 1;
				RegWrite <= 1;
				MemWrite <= 0;
				MemRead <= 0;
				MemToReg <= 0;
				ALUOp <= 5'b01011;
			end
			else begin
				RegDst <= 0;
				ALUSrc <= 0;
				RegWrite <= 0;
				MemWrite <= 0;
				MemRead <= 0;
				MemToReg <= 0;
				ALUOp <= 0;
			end
		end
		// end of R type instructions
		
		else if(opCode == 6'b001000) begin // addi
			set_I_control_signals();
			ALUOp <= 5'b0;
		end
		
		else if(opCode == 6'b001100) begin // andi
			set_I_control_signals();
			ALUOp <= 5'b11000;
		end

		else if(opCode == 6'b001101) begin // ori
			set_I_control_signals();
			ALUOp <= 5'b11110;
		end

		else if(opCode == 6'b001110) begin // xori
			set_I_control_signals();
			ALUOp <= 5'b10110;
		end

		else if(opCode == 6'b100011) begin //lw
			RegDst <= 1;
			ALUSrc <= 1;
			RegWrite <= 1;
			MemWrite <= 0;
			MemRead <= 1;
			MemToReg <= 1;
			ALUOp <= 5'b0;
		end

		else if(opCode == 6'b101011) begin // sw
			RegDst <= 0;
			ALUSrc <= 1;
			RegWrite <= 0;
			MemWrite <= 1;
			MemRead <= 0;
			MemToReg <= 0;
			ALUOp <= 5'b0;
		end

		else begin
			RegDst <= 0;
			ALUSrc <= 0;
			RegWrite <= 0;
			MemWrite <= 0;
			MemRead <= 0;
			MemToReg <= 0;
			ALUOp <= 0;
		end
	
	end
end

function void set_R_control_signals;
	RegDst <= 0;
	RegWrite <= 1;
	ALUSrc <= 0;
	MemWrite <= 0;
	MemRead <= 0;
	MemToReg = 0;
endfunction

function void set_I_control_signals;
	RegDst <= 1;
	ALUSrc <= 1;
	RegWrite <= 1;
	MemWrite <= 0;
	MemRead <= 0;
	MemToReg <= 0;
endfunction

endmodule