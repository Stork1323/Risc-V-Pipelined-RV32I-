module cache_table(
   //input
	input logic         clk_i,
	input logic         enable_i,
	//input logic         rd_enable_i,
	input logic         dirty_i,
	input logic [2:0]   index_i,

	input logic [26:0]  tag_i,
	input logic [31:0]  data_i,
	//output 
	output logic [26:0] tag_o,
	output logic [31:0] data_o,
	output logic        dirty_o,
	output logic        valid_o
);
   logic         valid [7:0];
	logic [26:0]  tag   [7:0];
	logic         dirty [7:0];
	logic [31:0]  data  [7:0];
	initial 
	begin
	for(int i=0; i<=7 ; i=i+1)
	  begin
	     valid[i] = 1'b0;
		  tag[i]   = 27'b0;
		  dirty[i] = 1'b0;
		  data[i]  = 32'b0;
	  end
	end
	always @(posedge clk_i)
	begin 
	if(enable_i)
	begin
	    data[index_i]  <= data_i;
		 valid[index_i] <= 1'b1;
		 tag[index_i]   <= tag_i;
		 if(dirty_i)
		 dirty[index_i] <= 1'b1;
	end
	end
		 
	always@(*)
	begin
	//if(rd_enable_i)
	//begin
	   valid_o = valid[index_i];
		tag_o   = tag[index_i];
	   dirty_o = dirty[index_i];
		data_o  = data[index_i];
	//end
	end
endmodule: cache_table
	
   
	
	
	