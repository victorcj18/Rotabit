module rotabit (
				  output logic [0:9] LEDR,
				  output logic clk_05,
				  input logic CLOCK_50, rst);
	reg [26:0] trimmer;
   int counter=0;
	parameter N=10;
	
	
	always_ff @(negedge rst, negedge CLOCK_50)
	begin 
		if (~rst)
			begin 
				trimmer<=0;
				clk_05<=0;
			end 
			else 
			begin 
				if (trimmer==20000000)
				begin 
					clk_05<=~clk_05;
					trimmer<=0; 
				end 
				else 
				begin
					trimmer<=trimmer+1;
				end
			end
		end

	always_ff @(posedge clk_05, negedge rst)
   begin 
		if (~rst) 
		begin 
			LEDR<=0;
		end 
		else if (counter<N) 
			begin
			LEDR[counter]<=~LEDR[counter];
			counter<=counter+1;
			LEDR[counter-1]<=0;
			end 
		
		else 
		begin
		counter<=1;
		LEDR<=0;
		LEDR[0]<=1;
		end 

			
	end 
	
endmodule
