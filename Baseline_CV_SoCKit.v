//`define ENABLE_DDR3
//`define ENABLE_HPS
//`define ENABLE_HSMC

`define CYCLE 30000000

module Baseline_CV_SoCKit(
	//keys and switches
	input [3:0] KEY,
	input [3:0] SW,
	//Outputs
	output reg [3:0] HSMC_TX_p,
	output reg [3:0] HSMC_TX_n,
	output reg [3:0] LED,
	
	//make sure this is an INPUT
	input OSC_50_B8A
);


//REG/WIRE declarations

reg [3:0] data = 4'b1111;
reg [25:0] timer = 26'b0;
reg [25:0] p_duty = `CYCLE / 2;
reg state = 1'b1;

always @(SW) begin
	p_duty <= `CYCLE * SW / 16;
end

/*always @(state) begin
	case (state)
		1'b0: begin
			HSMC_TX_p <= 4'b0000;
			HSMC_TX_n <= data;
		end
		1'b1: begin
			HSMC_TX_n <= 4'b0000;
			HSMC_TX_p <= data;
		end
	endcase
end*/

always @(posedge OSC_50_B8A) begin
	timer <= timer + 1'b1;
	if (timer == p_duty) begin
		//state <= 1'b0;
		HSMC_TX_p <= 4'b0000;
		HSMC_TX_n <= 4'b0001;
		LED <= 4'b0010;
	end else if (timer == `CYCLE) begin
		//state <= 1'b1;
		HSMC_TX_n <= 4'b0000;
		HSMC_TX_p <= 4'b0001;
		LED <= 4'b0001;
		timer <= 26'b0;
	end
end

endmodule
