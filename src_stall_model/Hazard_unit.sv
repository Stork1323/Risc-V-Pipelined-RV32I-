// Opcode of all types in RISC-V
`define OP_Rtype 		 7'b0110011
`define OP_Itype 		 7'b0010011
`define OP_Itype_load 7'b0000011
`define OP_Stype 		 7'b0100011
`define OP_Btype 		 7'b1100011
`define OP_JAL 		 7'b1101111
`define OP_LUI 		 7'b0110111
`define OP_AUIPC 		 7'b0010111
`define OP_JALR 		 7'b1100111

module Hazard_unit(
	input logic rst_ni,
	input logic RegWEn_ex_i,
	input logic RegWEn_mem_i,
	input logic RegWEn_wb_i,
	input logic [31:0] inst_d_i,
	input logic [31:0] inst_ex_i,
	input logic [31:0] inst_mem_i,
	input logic [31:0] inst_wb_i,
	input logic PC_taken_i,
	output logic Stall_IF,
	output logic Stall_ID,
	output logic Flush_ID,
	output logic Stall_EX,
	output logic Flush_EX,
	output logic Stall_MEM,
	output logic Flush_MEM,
	output logic Stall_WB,
	output logic Flush_WB
	);
	
						 
	logic nop1, nop2, nop3, nop4;
	logic is_rs1, is_rs2, is_rd_ex, is_rd_mem, is_rd_wb; // except cases not contain rs1 or rs2 or rd
	
	assign is_rs1 = ((inst_d_i[6:0] == `OP_Rtype) | (inst_d_i[6:0] == `OP_Itype) | (inst_d_i[6:0] == `OP_Stype) |
						 (inst_d_i[6:0] == `OP_Btype) | (inst_d_i[6:0] == `OP_Itype_load) |
						 (inst_d_i[6:0] == `OP_JALR)) ? 1'b1 : 1'b0;
	
	assign is_rs2 = ((inst_d_i[6:0] == `OP_Rtype) | (inst_d_i[6:0] == `OP_Stype) |
						 (inst_d_i[6:0] == `OP_Btype)) ? 1'b1 : 1'b0;
	
	assign is_rd_ex = ((inst_ex_i[6:0] == `OP_Rtype) | (inst_ex_i[6:0] == `OP_Itype) | 
							(inst_ex_i[6:0] == `OP_Itype_load) | (inst_ex_i[6:0] == `OP_LUI) |
							(inst_ex_i[6:0] == `OP_AUIPC) | (inst_ex_i[6:0] == `OP_JAL) |
							(inst_ex_i[6:0] == `OP_JALR)) ? 1'b1 : 1'b0;
	
	assign is_rd_mem = ((inst_mem_i[6:0] == `OP_Rtype) | (inst_mem_i[6:0] == `OP_Itype) | 
							(inst_mem_i[6:0] == `OP_Itype_load) | (inst_mem_i[6:0] == `OP_LUI) |
							(inst_mem_i[6:0] == `OP_AUIPC) | (inst_mem_i[6:0] == `OP_JAL) |
							(inst_mem_i[6:0] == `OP_JALR)) ? 1'b1 : 1'b0;
							
	assign is_rd_wb = ((inst_wb_i[6:0] == `OP_Rtype) | (inst_wb_i[6:0] == `OP_Itype) | 
							(inst_wb_i[6:0] == `OP_Itype_load) | (inst_wb_i[6:0] == `OP_LUI) |
							(inst_wb_i[6:0] == `OP_AUIPC) | (inst_wb_i[6:0] == `OP_JAL) |
							(inst_wb_i[6:0] == `OP_JALR)) ? 1'b1 : 1'b0;
						 
	assign nop1 = ((RegWEn_ex_i) & (inst_ex_i[11:7] != 5'b0) & 
					  (((inst_d_i[19:15] == inst_ex_i[11:7]) & (is_rs1) & (is_rd_ex)) |
					  ((inst_d_i[24:20] == inst_ex_i[11:7]) & (is_rs2) & (is_rd_ex)))) ? 1'b1 : 1'b0;
						  
	assign nop2 = ((RegWEn_mem_i) & (inst_mem_i[11:7] != 5'b0) & 
					  (((inst_d_i[19:15] == inst_mem_i[11:7]) & (is_rs1) & (is_rd_mem)) | 
					  ((inst_d_i[24:20] == inst_mem_i[11:7]) & (is_rs2) & (is_rd_mem)))) ? 1'b1 : 1'b0;
	
	assign nop3 = ((RegWEn_mem_i) & (inst_wb_i[11:7] != 5'b0) & 
					  (((inst_d_i[19:15] == inst_wb_i[11:7]) & (is_rs1) & (is_rd_wb)) | 
					  ((inst_d_i[24:20] == inst_wb_i[11:7]) & (is_rs2) & (is_rd_wb)))) ? 1'b1 : 1'b0;
					  
	assign nop4 = PC_taken_i;
	
	assign Stall_IF = nop1 | nop2 | nop3;
	assign Stall_ID = nop1 | nop2 | nop3;
	assign Stall_EX = 1'b0;
	assign Stall_MEM = 1'b0;
	assign Stall_WB = 1'b0;
	assign Flush_ID = nop4;
	assign Flush_EX = nop1 | nop2 | nop3 | nop4;
//	assign Flush_MEM = nop2 | nop3;
//	assign Flush_WB = nop3;
	assign Flush_MEM = 1'b0;
	assign Flush_WB = 1'b0;
	
endmodule

