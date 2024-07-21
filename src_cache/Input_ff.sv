module Input_ff(
  //input 
  input logic        enable_ni,
  input logic        rst_ni,
  input logic [31:0] address_i,
  input logic [31:0] data_i,
  input logic        data_sel_i,
  //output
  output logic [2:0]  index_o,
  output logic [26:0] tag_o,
  output logic [31:0] data_o,
  output logic        data_sel_o
  
);
  initial begin
     data_o        <= 32'b0;
	  index_o       <= 3'b0;
	  tag_o         <= 27'b0;
	  data_sel_o    <= 1'b0;
   end
	//
	always @(enable_ni or rst_ni) begin
		if(!rst_ni) begin
			data_o        <= 32'b0;
			index_o       <= 3'b0;
			tag_o         <= 27'b0;
			data_sel_o    <= 1'b0;
		end 
		else if (!enable_ni) begin
			data_o        <= data_i;
			index_o       <= address_i[4:2];
			tag_o         <= address_i[31:5];
			data_sel_o    <= data_sel_i;
		end
	end
endmodule 