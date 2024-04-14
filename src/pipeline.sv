module pipeline(
	input logic clk_i,
	input logic rst_ni,
	input logic [31:0] io_sw_i,
	//output logic [31:0] pc_debug_o,
	output logic [31:0] io_lcd_o,
	output logic [31:0] io_ledg_o,
	output logic [31:0] io_ledr_o,
	output logic [31:0] io_hex0_o,
	output logic [31:0] io_hex1_o,
	output logic [31:0] io_hex2_o,
	output logic [31:0] io_hex3_o,
	output logic [31:0] io_hex4_o,
	output logic [31:0] io_hex5_o,
	output logic [31:0] io_hex6_o,
	output logic [31:0] io_hex7_o
	);
	
	logic BrEq_w, BrLt_w, RegWEn_w;
	logic [4:0] rsW_w;
	logic [31:0] alu_mem_w, pc_d_w, inst_d_w, pc4_d_w, data_wb_w;
	logic [31:0] rs1_ex_w, rs2_ex_w, imm_ex_w, pc_ex_w, pc4_ex_w;
	logic [3:0] AluSel_ex_w;
	logic BSel_ex_w, ASel_ex_w, MemRW_ex_w, BrUn_ex_w, RegWEn_ex_w;
	logic [4:0] rsW_ex_w;
	logic [1:0] WBSel_ex_w;
	logic [31:0] rs2_mem_w, pc4_mem_w;
	logic MemRW_mem_w, RegWEn_mem_w;
	logic [1:0] WBSel_mem_w;
	logic [4:0] rsW_mem_w;
	logic [31:0] alu_wb_w, pc4_wb_w, mem_wb_w;
	logic RegWEn_wb_w;
	logic [1:0] WBSel_wb_w;
	logic [4:0] rsW_wb_w;
	
	logic [31:0] inst_ex_w, inst_mem_w, inst_wb_w;
	logic [1:0] Asel_haz_w, Bsel_haz_w;
	logic [31:0] alu_w;
	logic PCSel_w;
	logic [31:0] pc_alu_w;
	logic check_jump_w;
	
	IF IF(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.PC_sel_i(PCSel_w),
		.PC_alu_i(pc_alu_w),
		.pc_d_o(pc_d_w),
		.inst_d_o(inst_d_w),
		.pc4_d_o(pc4_d_w)
		);
		
	ID ID(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.data_wb_i(data_wb_w),
		.inst_d_i(inst_d_w),
		.pc_d_i(pc_d_w),
		.pc4_d_i(pc4_d_w),
		.RegWEn_i(RegWEn_wb_w),
		.rsW_i(rsW_wb_w),
		.rs1_ex_o(rs1_ex_w),
		.rs2_ex_o(rs2_ex_w),
		.imm_ex_o(imm_ex_w),
		.pc_ex_o(pc_ex_w),
		.pc4_ex_o(pc4_ex_w),
		.AluSel_ex_o(AluSel_ex_w),
		.BSel_ex_o(BSel_ex_w),
		.ASel_ex_o(ASel_ex_w),
		.MemRW_ex_o(MemRW_ex_w),
		.WBSel_ex_o(WBSel_ex_w),
		.BrUn_ex_o(BrUn_ex_w),
		.RegWEn_ex_o(RegWEn_ex_w),
		.rsW_ex_o(rsW_ex_w),
		.inst_ex_o(inst_ex_w)
		);
		
	EX EX(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.rs1_ex_i(rs1_ex_w),
		.rs2_ex_i(rs2_ex_w),
		.imm_ex_i(imm_ex_w),
		.pc_ex_i(pc_ex_w),
		.pc4_ex_i(pc4_ex_w),
		.AluSel_ex_i(AluSel_ex_w),
		.BSel_ex_i(BSel_ex_w),
		.ASel_ex_i(ASel_ex_w),
		.MemRW_ex_i(MemRW_ex_w),
		.WBSel_ex_i(WBSel_ex_w),
		.BrUn_ex_i(BrUn_ex_w),
		.RegWEn_ex_i(RegWEn_ex_w),
		.rsW_ex_i(rsW_ex_w),
		.Asel_haz_i(Asel_haz_w),
		.Bsel_haz_i(Bsel_haz_w),
		.inst_ex_i(inst_ex_w),
		.alu_wb_i(alu_wb_w),
		.alu_mem_o(alu_mem_w),
		.rs2_mem_o(rs2_mem_w),
		.pc4_mem_o(pc4_mem_w),
		.MemRW_mem_o(MemRW_mem_w),
		.WBSel_mem_o(WBSel_mem_w),
		.BrEq_o(BrEq_w),
		.BrLt_o(BrLt_w),
		.RegWEn_mem_o(RegWEn_mem_w),
		.rsW_mem_o(rsW_mem_w),
		.inst_mem_o(inst_mem_w),
		.alu_o(alu_w)
		);
		
	MEM MEM(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.alu_mem_i(alu_mem_w),
		.rs2_mem_i(rs2_mem_w),
		.pc4_mem_i(pc4_mem_w),
		.MemRW_mem_i(MemRW_mem_w),
		.WBSel_mem_i(WBSel_mem_w),
		.RegWEn_mem_i(RegWEn_mem_w),
		.rsW_mem_i(rsW_mem_w),
		.io_sw_i(io_sw_i),
		.inst_mem_i(inst_mem_w),
		.alu_wb_o(alu_wb_w),
		.pc4_wb_o(pc4_wb_w),
		.mem_wb_o(mem_wb_w),
		.WBSel_wb_o(WBSel_wb_w),
		.RegWEn_wb_o(RegWEn_wb_w),
		.rsW_wb_o(rsW_wb_w),
		.io_lcd_o(io_lcd_o),
		.io_ledg_o(io_ledg_o),
		.io_ledr_o(io_ledr_o),
		.io_hex0_o(io_hex0_o),
		.io_hex1_o(io_hex1_o),
		.io_hex2_o(io_hex2_o),
		.io_hex3_o(io_hex3_o),
		.io_hex4_o(io_hex4_o),
		.io_hex5_o(io_hex5_o),
		.io_hex6_o(io_hex6_o),
		.io_hex7_o(io_hex7_o),
		.inst_wb_o(inst_wb_w)
		);
		
	WB WB(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.alu_wb_i(alu_wb_w),
		.pc4_wb_i(pc4_wb_w),
		.mem_wb_i(mem_wb_w),
		.WBSel_wb_i(WBSel_wb_w),
		//.RegWEn_wb_i(RegWEn_wb_w),
		//.rsW_wb_i(rsW_wb_w),
		.dataWB_o(data_wb_w)
		//.RegWEn_o(RegWEn_w),
		//.rsW_o(rsW_w)
		);
		
	Forwarding_ctrl_unit FCU(
		.rst_ni(rst_ni),
		.RegWEn_mem_i(RegWEn_mem_w),
		.RegWEn_wb_i(RegWEn_wb_w),
		.inst_ex_i(inst_ex_w),
		.inst_mem_i(inst_mem_w),
		.inst_wb_i(inst_wb_w),
		.check_jump_i(check_jump_w),
		.Bsel_o(Bsel_haz_w),
		.Asel_o(Asel_haz_w)
		);
		
	Branch_prediction BP(
		.rst_ni(rst_ni),
		.BrEq_i(BrEq_w),
		.BrLt_i(BrLt_w),
		.inst_ex_i(inst_ex_w),
		.alu_i(alu_w),
		.PCsel_o(PCSel_w),
		.check_jump_o(check_jump_w),
		.pc_alu_o(pc_alu_w)
		);
	
endmodule








