module WB(
	input logic clk_i,
	input logic rst_ni,
	input logic [31:0] alu_wb_i,
	input logic [31:0] pc4_wb_i,
	input logic [31:0] mem_wb_i,
	input logic [1:0] WBSel_wb_i,
	//input logic RegWEn_wb_i,
	//input logic [4:0] rsW_wb_i,
	output logic [31:0] dataWB_o
	//output logic [4:0] rsW_o,
	//output logic RegWEn_o
	);

//	logic [31:0] dataWB_w;
//	
//	logic [31:0] dataWB_r;
//	logic RegWEn_r;
//	logic [4:0] rsW_r;
	
//	mux3to1_32bit Mux_WB(
//		.a_i(mem_wb_i),
//		.b_i(alu_wb_i),
//		.c_i(pc4_wb_i),
//		.se_i(WBSel_wb_i),
//		.r_o(dataWB_w)
//		);
	mux3to1_32bit Mux_WB(
			.a_i(mem_wb_i),
			.b_i(alu_wb_i),
			.c_i(pc4_wb_i),
			.se_i(WBSel_wb_i),
			.r_o(dataWB_o)
			);
		
//	always_ff @(posedge clk_i, negedge rst_ni) begin
//		if (~rst_ni) begin
//			dataWB_r <= 32'b0;
//			RegWEn_r <= 1'b0;
//			rsW_r <= 5'b0;
//		end
//		else begin
//			dataWB_r <= dataWB_w;
//			RegWEn_r <= RegWEn_wb_i;
//			rsW_r <= rsW_wb_i;
//		end
//	end
//	
//	assign dataWB_o = dataWB_r;
//	assign RegWEn_o = RegWEn_r;
//	assign rsW_o = rsW_r;
	
endmodule
