module IF(
	input logic clk_i,
	input logic rst_ni,
	input logic PC_sel_i,
	input logic [31:0] PC_alu_i,
	output logic [31:0] pc_d_o,
	output logic [31:0] inst_d_o,
	output logic [31:0] pc4_d_o
	);

	logic [31:0] PC_mux_w;
	logic [31:0] PC_w, inst_w, PC_add4_w;
	logic [31:0] PC_r, inst_r, PC_add4_r;
	logic overf_PC_w;
	
	mux2to1_32bit MUX_IF(
		.a_i(PC_add4_w), 
		.b_i(PC_alu_i),
		.se_i(PC_sel_i),
		.c_o(PC_mux_w)
		);
	
	pc PC_IF(
		.data_i(PC_mux_w),
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.data_o(PC_w)
		);
	
	adder_32bit ADD4_IF(
		.a_i(32'h04), 
		.b_i(PC_w),
		.re_o(PC_add4_w),
		.c_o(overf_PC_w)
		);
		
	imem IMEM_IF(
		.addr_i(PC_w),
		.rst_ni(rst_ni),
		.inst_o(inst_w)
		);
		
	always_ff @(posedge clk_i, negedge rst_ni) begin
		if (~rst_ni) begin
			PC_r <= 32'b0;
			inst_r <= 32'b0;
			PC_add4_r <= 32'b0;
		end
		else begin
			PC_r <= PC_w;
			inst_r <= inst_w;
			PC_add4_r <= PC_add4_w;
		end
	end
	
	assign pc_d_o = PC_r;
	assign inst_d_o = inst_r;
	assign pc4_d_o = PC_add4_r;
	
endmodule

