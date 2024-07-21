module output_ff(
   //input
   input logic        enable_ni,
   input logic        rst_ni,
	input logic        hit_i,
   input logic [31:0] address_i,
   input logic [31:0] data_i,
  //output
   output logic        hit_o,
   output logic [31:0] address_o,
   output logic [31:0] data_o
  
);
  initial begin
     data_o        <= 32'b0;
	  address_o     <= 32'b0;
	  hit_o         <= 1'b0;
   end
	//
	always @(enable_ni or rst_ni)
	begin
	if(!rst_ni) begin
	   data_o        <= 32'b0;
	   address_o     <= 32'b0;
		hit_o         <= 1'b0;


	end 
	else if (!enable_ni) begin
	   hit_o         <= hit_i;
	   data_o        <= data_i;
	   address_o     <= address_i;
	end
	end
endmodule 