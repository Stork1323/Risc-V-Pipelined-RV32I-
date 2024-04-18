`define OP_Btype 		 7'b1100011
`define OP_JAL 		 7'b1101111
`define OP_JALR 		 7'b1100111

// Control signal (funct3) for Branch Comparator
`define BEQ  3'b000
`define BNE  3'b001
`define BLT  3'b100
`define BGE  3'b101
`define BLTU 3'b110
`define BGEU 3'b111

module Branch_prediction(
	input logic rst_ni,
	input logic BrEq_i,
	input logic BrLt_i,
	input logic [31:0] inst_ex_i,
	input logic [31:0] alu_i,
	output logic PCsel_o,
	output logic [31:0] pc_alu_o
	);
	
	logic [6:0] opcode_r;
	logic [2:0] funct3;
	
	assign opcode_r = inst_ex_i[6:0];
	assign funct3 = inst_ex_i[14:12];
	
								 
	assign PCsel_o = ((opcode_r == `OP_Btype) & ((funct3 == `BEQ) & (BrEq_i))  | 
						  ((opcode_r == `OP_Btype) & (funct3 == `BNE) & (~BrEq_i))  | 
						  ((opcode_r == `OP_Btype) & (funct3 == `BLT) & (BrLt_i))   | 
						  ((opcode_r == `OP_Btype) & (funct3 == `BGE) & (~BrLt_i))  |
						  ((opcode_r == `OP_Btype) & (funct3 == `BLTU) & (BrLt_i))  |
						  ((opcode_r == `OP_Btype) & (funct3 == `BGEU) & (~BrLt_i)) |
						  ((opcode_r == `OP_JAL) | (opcode_r == `OP_JALR))) ? 1'b1 : 1'b0;
	assign pc_alu_o = (~rst_ni) ? 32'b0 : alu_i;
	
endmodule
