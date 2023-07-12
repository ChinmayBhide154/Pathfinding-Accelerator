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

assign LEDR[0] = 1'b1;

endmodule
