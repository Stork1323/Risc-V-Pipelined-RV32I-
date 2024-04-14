
module Forwarding_ctrl_unit(
	input logic rst_ni,
	input logic RegWEn_mem_i,
	input logic RegWEn_wb_i,
	input logic [31:0] inst_ex_i,
	input logic [31:0] inst_mem_i,
	input logic [31:0] inst_wb_i,
	input logic check_jump_i,
	output logic [1:0] Bsel_o,
	output logic [1:0] Asel_o
	);
	
	

	assign Asel_o = (~rst_ni) ? 2'b00 :
						 ((check_jump_i == 1'b0) & (RegWEn_wb_i) & (inst_ex_i[19:15] == inst_wb_i[11:7])) ? 2'b10 : 
						 ((check_jump_i == 1'b0) & (RegWEn_mem_i) & (inst_ex_i[19:15] == inst_mem_i[11:7])) ? 2'b01 : 2'b00;
	assign Bsel_o = (~rst_ni) ? 2'b00 : 
						 ((check_jump_i == 1'b0) & (RegWEn_wb_i) & (inst_ex_i[24:20] == inst_wb_i[11:7])) ? 2'b10 :
						 ((check_jump_i == 1'b0) & (RegWEn_mem_i) & (inst_ex_i[24:20] == inst_mem_i[11:7])) ? 2'b01 : 2'b00;
	
endmodule

