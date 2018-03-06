module beta(    input logic clk, reset,
                input logic [31:0] id, memReadData,
                output logic [31:0] ia, memAddr, memWriteData,
                output logic MemRead, MemWrite);

logic RegDst, ALUSrc, RegWrite, MemToReg, z, v, n;
logic [4:0] ALUOp;
logic [31:0] radata, ext_data , alu_2nd_src, rbdata, wdata;
//logic [5:0] opCode;

assign opCode = id[31:26];

pc pc_module(clk, reset, ia);
ctl ctl_module(reset, id[31:26], id[5:0], RegDst, ALUSrc, RegWrite, MemWrite, MemRead, MemToReg, ALUOp );
regfile regfile_module(clk, RegWrite, RegDst, id[25:21], id[20:16], id[15:11], wdata, radata, rbdata);
alu alu_module(radata, alu_2nd_src, ALUOp, memAddr, z, v, n);


always_comb begin
    if(ALUOp[4] == 1'b1) // all 0 pads
        ext_data <= {{16'b0}, id[15:0]};
    else if(ALUOp == 5'b01000 || ALUOp == 5'b01001 || ALUOp == 5'b01011) // extending shamt
        ext_data <= {{27'b0}, id[10:6]}; // left shift
    
    else if(ALUOp == 5'b0 || ALUOp == 5'b1 || ALUOp == 5'b00111 || ALUOp == 5'b00101 || ALUOp == 5'b01101  ) 
        ext_data <= {{16{id[15]}}, id[15:0]}; // signed extend
    else
        ext_data <= 32'b0; 
    
end

always_comb begin
    case(ALUSrc)
        1'b1:       alu_2nd_src <= ext_data;
        1'b0:       alu_2nd_src <= rbdata;
     default:       alu_2nd_src <= 32'b0;
    endcase
end


always_comb begin
    case (MemToReg)
        1'b1:   wdata <= memReadData;
        1'b0:   wdata <= memAddr;
     default:   wdata <= 32'b0;
    endcase
end

assign memWriteData = rbdata;
 

endmodule