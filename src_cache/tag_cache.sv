module tag_cache(
   //input 
	input logic [26:0] read_tag_i,
	input logic [26:0] current_tag,
	//output
	output logic equal_o
);
   assign equal_o = (read_tag_i == current_tag);
endmodule 	
   