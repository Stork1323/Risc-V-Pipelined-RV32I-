module MEM(
	input logic clk_i,
	input logic rst_ni,
	input logic [31:0] alu_mem_i,
	input logic [31:0] rs2_mem_i,
	input logic [31:0] pc4_mem_i,
	input logic MemRW_mem_i,
	input logic [1:0] WBSel_mem_i,
	input logic RegWEn_mem_i,
	input logic [31:0] io_sw_i,
	input logic [4:0] rsW_mem_i,
	input logic [31:0] inst_mem_i,
	input logic enable_i,
	input logic reset_i,
	input logic rd_request_i,
	input logic MemRW_ex_i,
	output logic [31:0] alu_wb_o,
	output logic [31:0] pc4_wb_o,
	output logic [31:0] mem_wb_o,
	output logic [1:0] WBSel_wb_o,
	output logic RegWEn_wb_o,
	output logic [4:0] rsW_wb_o,
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
	output logic [31:0] io_hex7_o,
	output logic [31:0] inst_wb_o,
	output logic stall_processor_o
	);
	
	logic [31:0] mem_w;
	
	logic [31:0] alu_r, pc4_r, mem_r;
	logic [1:0] WBSel_r;
	logic RegWEn_r;
	logic [4:0] rsW_r;
	logic [31:0] inst_r;
	logic stall_processor_w;
	logic wren_lsu_w;
	
	logic mem_ready_w;
	logic [31:0] data_load_w;
	logic [31:0] data_wb_mem_w;
	logic [31:0] address_lsu_w;
	
	
	lsu LSU_MEM(
		.addr_i(address_lsu_w),
		.dataW_i(data_wb_mem_w),
		.MemRW_i(wren_lsu_w),
		.clk_i(clk_i),
		.dataR_o(data_load_w),
		.rst_ni(rst_ni),
		.io_sw_i(io_sw_i),
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
		.mem_ready(mem_ready_w)
		);
		
	cache CACHE(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.address_i(alu_mem_i),
		.data_i(rs2_mem_i),
		.data_mem(data_load_w),
		.data_sel(MemRW_mem_i),
		.rd_request(rd_request_i),
		.wr_request(MemRW_ex_i),
		.mem_ready(mem_ready_w),
		.stall_processor(stall_processor_w),
		.wren_lsu(wren_lsu_w),
		.data_wb_mem(data_wb_mem_w),
		.data_o(mem_w),
		.address_lsu_o(address_lsu_w)
);

		
	always_ff @(posedge clk_i, negedge rst_ni) begin
		if (~rst_ni) begin
			alu_r <= 32'b0;
			pc4_r <= 32'b0;
			mem_r <= 32'b0;
			WBSel_r <= 2'b0;
			RegWEn_r <= 1'b0;
			rsW_r <= 5'b0;
			inst_r <= 32'b0;
		end
		else if (enable_i) begin
			if (reset_i) begin
				alu_r <= 32'b0;
				pc4_r <= 32'b0;
				mem_r <= 32'b0;
				WBSel_r <= 2'b0;
				RegWEn_r <= 1'b0;
				rsW_r <= 5'b0;
				inst_r <= 32'b0;
			end
			else begin
				alu_r <= alu_mem_i;
				pc4_r <= pc4_mem_i;
				mem_r <= mem_w;
				WBSel_r <= WBSel_mem_i;
				RegWEn_r <= RegWEn_mem_i;
				rsW_r <= rsW_mem_i;
				inst_r <= inst_mem_i;
			end
		end
	end
	
	assign alu_wb_o = alu_r;
	assign pc4_wb_o = pc4_r;
	assign mem_wb_o = mem_r;
	assign WBSel_wb_o = WBSel_r;
	assign RegWEn_wb_o = RegWEn_r;
	assign rsW_wb_o = rsW_r;
	assign inst_wb_o = inst_r;
	assign stall_processor_o = stall_processor_w;
	
endmodule
