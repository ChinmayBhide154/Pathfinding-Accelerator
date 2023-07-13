module CoordinateCollector (
    input logic reset,
    input logic clk,
    input logic [255:0] xCoord,
    input logic [255:0] yCoord,
    input logic transition,
    input logic enterNewCoord,
    input logic finishInit,

    output logic [6:0] hex0,
    output logic [6:0] hex1,
    output logic [6:0] hex2,
    output logic [6:0] hex3,
    output logic [6:0] hex4,
    output logic [6:0] hex5,

    output logic done
);


typedef enum logic [1:0] {  
    GET_X = 43'b0110111_0000000_0000000_0000000_0000000_0000000_0,
    GET_Y = 43'b1111011_0000000_0000000_0000000_0000000_0000000_0,
    UPDATE_MEM = 43'b0,
    FINISH = 43'b0111101_0011101_0010101_1101111_0000000_0000000_1
} stateType;

stateType state = GET_X;

logic [1:0] next;

always_ff @(posedge clk or posedge reset) begin
    if(reset) state <= GET_X;
    else state <= next;
end

always_comb begin
    case(state)
        GET_X: if(transition) next = GET_Y;
                else next = GET_X;

        GET_Y: if(transition) next = UPDATE_MEM;
                else next = GET_Y;

        UPDATE_MEM: if(enterNewCoord) next = GET_X;
                    else if(finishInit) next = FINISH;
                    else next = UPDATE_MEM;

        FINISH: next = FINISH;
    endcase
end

assign hex0 = state[42:36];
assign hex1 = state[35:29];
assign hex2 = state[28:22];
assign hex3 = state[21:15];
assign hex4 = state[14:8];
assign hex5 = state[7:1];
assign done = state[0];


endmodule
