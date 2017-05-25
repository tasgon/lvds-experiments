//`define ENABLE_DDR3
//`define ENABLE_HPS
//`define ENABLE_HSMC

module Baseline_CV_SoCKit(
	//keys and switches
	input[3:0] KEY,
	//Outputs
	output [3:0] HSMC_TX_p,
	output reg [3:0] LED,
	
	//make sure this is an INPUT
	input OSC_50_B8A
);


//REG/WIRE declarations

reg [3:0] count = 4'b0000;
reg [23:0] timer = 24'b0;
reg [1:0] state = 1'b0;

//Structural coding

/*always @(posedge KEY[0] or posedge KEY[1]) begin
	if (KEY[0]) begin
		if (count != 4'b0000) begin
			count = count - 1'b1;
		end
	end
	else if (KEY[1]) begin
		if (count != 4'b1111) begin
			count = count + 1'b1;
		end6
	end
end*/

/*always @(posedge KEY[0]) begin
	if (count != 4'b1111) begin
		count <= count + 1'b1;
	end
	else begin
		count <= 4'b0000;
	end
end*/

/*always @(state) begin
	case (state)
		1'b0: LED <= 4'b0000;
		1'b1: LED <= 4'b1111;
		default: LED <= 4'b0101;
	endcase
end*/

always @(posedge OSC_50_B8A) begin
	if (timer == 24'b0) begin
		//state <= !state;
		LED <= LED + 1'b1;
		timer <= 24'b111111111111111111111111;
	end else begin
		timer <= timer - 1'b1;
	end
end

endmodule
