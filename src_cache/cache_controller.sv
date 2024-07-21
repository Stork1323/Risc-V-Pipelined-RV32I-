module cache_controller(
   //input 
	input logic clk_i,
	input logic rst_ni,
	input logic dirty_i,
	input logic hit_i,
	input logic rd_i,
	input logic wr_i,
	input logic mem_ready,
	//input logic mem_ready,
	//output
	output logic stall_signal,
	output logic check_en,
	output logic write_cache_en,
	output logic write_lsu_en
	);
	
	typedef enum logic [1:0] {idle ,check, write_dirty, write_clean} state;
	state current_state, next_state;
	
	//state register
	always_ff @(posedge clk_i)
	begin
	   if(!rst_ni)
		current_state <= idle;
		else
		current_state <= next_state;
		
	end
	//logic rd_cache_en;
	logic wr_cache_en;
	logic wr_lsu_en;
	logic stall; 
	
	initial begin
	   wr_cache_en  <= 1'b0;
		wr_lsu_en    <= 1'b0;
		stall        <= 1'b0;
		check_en     <= 1'b1; 
	end

	//controller
	always@(*) begin
	case(current_state)
	   idle: begin
		      //rd_cache_en  = 1'b0;
			
				wr_cache_en  = 1'b0;
		      wr_lsu_en    = 1'b0;
				stall        = 1'b0;
				check_en     = 1'b1; 

				if(!rd_i && !wr_i) 
				begin 
				   next_state = idle;
				end
				else if(rd_i || wr_i) begin 
			    	next_state = check;
				end
				end
		check:
		      begin
			   wr_cache_en  = 1'b1;
		      wr_lsu_en    = 1'b0;
				stall        = 1'b1;
				check_en     = 1'b0; 	
				if(hit_i) begin
				   next_state = idle;
				end
				else begin
				   if(dirty_i) begin
						next_state = write_dirty;
					end
					else begin
					   next_state = write_clean;
				   end
				end
		      end
		write_dirty:
		      begin
		
		      wr_cache_en   = 1'b1;
		      wr_lsu_en     = 1'b1;
				stall         = 1'b1;
				check_en      = 1'b1; 
		
				if(mem_ready) begin
				   next_state = idle;
				end
				else begin

			    	next_state = write_dirty;
				end
				end
		write_clean:
		      begin
			    //rd_cache_en   = 1'b0;
		      wr_cache_en   = 1'b1;
				wr_lsu_en     = 1'b0;
				stall         = 1'b1;
				check_en      = 1'b1;
				next_state    = idle;
				end 

	endcase 
	end
   assign stall_signal     = stall;
	assign write_cache_en   = wr_cache_en;
	assign write_lsu_en     = wr_lsu_en;
endmodule: cache_controller
		      
		       
				 
				
	   
	