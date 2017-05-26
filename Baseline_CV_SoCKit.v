//`define ENABLE_DDR3
//`define ENABLE_HPS
//`define ENABLE_HSMC

module Baseline_CV_SoCKit(
	//keys and switches
	input [3:0] KEY,
	input [3:0] SW,
	//Outputs
	output reg [3:0] HSMC_TX_p,
	output reg [3:0] HSMC_TX_n,
	output [3:0] LED,
	
	//make sure this is an INPUT
	input OSC_50_B8A
);


//REG/WIRE declarations

reg [3:0] data = 4'b0000;
reg [23:0] timer = 24'b0;
reg [1:0] state = 1'b0;

assign LED = HSMC_TX_p;

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
		end
	end
end*/

always @(posedge KEY[0]) begin
	data <= data + 1'b1;
end

always @(state) begin
	HSMC_TX_p = 4'b0000;
	HSMC_TX_n = 4'b0000;
	case (state)
		1'b0: HSMC_TX_p <= data;
		1'b1: HSMC_TX_n <= data;
	endcase
end

always @(posedge OSC_50_B8A) begin
	if (timer == 24'b0) begin
		state <= !state;
		timer <= {SW, 20'b0};
	end else begin
		timer <= timer - 1'b1;
	end
end

endmodule
