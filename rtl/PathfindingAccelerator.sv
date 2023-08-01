module PathfindingAccelerator (
    input logic CLOCK_50,
    input logic [3:0] KEY,
    input logic [9:0] SW,            
    output logic [9:0] LEDR,
    output logic [6:0] HEX0,
    output logic [6:0] HEX1,
    output logic [6:0] HEX2,
    output logic [6:0] HEX3,
    output logic [6:0] HEX4,
    output logic [6:0] HEX5
);

logic [7:0] Seven_Seg_Val[5:0];
logic [3:0] Seven_Seg_Data[5:0];

//XMEM interface signals
logic [7:0] XMEM_data;
logic [7:0] XMEM_address;
logic [7:0] XMEM_wren;
logic [7:0] XMEM_q;

//YMEM interface signals
logic [7:0] YMEM_data;
logic [7:0] YMEM_address;
logic [7:0] YMEM_wren;
logic [7:0] YMEM_q; 

// Mem_Interface_Decoder signals
logic [7:0] XMEM_data_mid_out;
logic [7:0] XMEM_address_mid_out;
logic [7:0] XMEM_wren_mid_out;
logic [7:0] XMEM_q_mid_out;

logic [7:0] YMEM_data_mid_out;
logic [7:0] YMEM_address_mid_out;
logic [7:0] YMEM_wren_mid_out;
logic [7:0] YMEM_q_mid_out; 

logic [2:0] mem_id_master;
logic [7:0] address_master;				
logic [7:0] data_master;	
logic wren_master;

Mem_Interface_Decoder (
    .mem_id(mem_id_master),
    
    .address(address_master),			
	.data(data_master),	
	.wren(wren_master),		

    .address_mem_id0(XMEM_address_mid_out),				
	.data_mem_id0(XMEM_data_mid_out),	
	.wren_mem_id0(XMEM_wren_mid_out),

    .address_mem_id1(YMEM_address_mid_out),				
	.data_mem_id1(YMEM_data_mid_out),	
	.wren_mem_id1(YMEM_wren_mid_out)
);

assign XMEM_address = XMEM_address_mid_out;
assign XMEM_data = XMEM_data_mid_out;
assign XMEM_wren = XMEM_wren_mid_out;

assign YMEM_address = YMEM_address_mid_out;
assign YMEM_data = YMEM_address_mid_out;
assign YMEM_wren = YMEM_wren_mid_out;


logic data_collection_finished;

//Generate sseg decoders for hex output
genvar i;

generate
    for (i = 0; i < 6; i++) begin : generate_sseg_decoders
        SevenSegmentDisplayDecoder SevenSegmentDisplayDecoder_inst(
            .ssOut(Seven_Seg_Val[i]), 
            .nIn(Seven_Seg_Data[i])
        );
    end
endgenerate

assign HEX0 = Seven_Seg_Val[0];
assign HEX1 = Seven_Seg_Val[1];
assign HEX2 = Seven_Seg_Val[2];
assign HEX3 = Seven_Seg_Val[3];
assign HEX4 = Seven_Seg_Val[4];
assign HEX5 = Seven_Seg_Val[5];

/*
CoordinateCollector data_collector(
    .reset(1'b0),
    .clk(CLOCK_50),
    .x_in(8'b0),
    .y_in(8'b0),
    .write_en(1'b1),
    .enterNewCoord(~KEY[1]),
    .finishInit(~KEY[0]),
    .x_out(x_data_in),
    .y_out(y_data_in),
    .hex0(Seven_Seg_Data[0]),
    .hex1(Seven_Seg_Data[1]),
    .hex2(Seven_Seg_Data[2]),
    .hex3(Seven_Seg_Data[3]),
    .hex4(Seven_Seg_Data[4]),
    .hex5(Seven_Seg_Data[5]),
    .mem_wren(XMEM_wren),
    .done(data_collection_finished)
);
*/


pathfinding_mem XMEM(
    .address(XMEM_address),		
	.clock(CLOCK_50),		
	.data(XMEM_data),	
	.wren(XMEM_wren),		
	.q(XMEM_q)	
);

pathfinding_mem YMEM(
    .address(YMEM_address),		
	.clock(CLOCK_50),		
	.data(YMEM_data),	
	.wren(YMEM_wren),		
	.q(YMEM_q)	
);



endmodule
