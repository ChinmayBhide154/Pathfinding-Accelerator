/*

module Dist2Node (
    input logic [7:0] node1_addr,
    input logic [7:0] node2_addr,
    input logic clk,
    input logic reset,
    input logic start,

    output logic [7:0] distance,
    output logic finish
);

parameter IDLE = 4'b0000;
parameter GET_X1 = 4'b0001;
parameter GET_X2 = 4'b0010;
parameter GET_Y1 = 4'b0011;
parameter GET_Y2 = 4'b0100;
parameter MUL1 = 4'b0101;
parameter MUL2 = 4'b0110;
parameter SQRT = 4'b0111;
parameter FINISH = 4'b1000;

logic [2:0] state, next;

always_ff @(posedge clk or posedge reset) begin
    if(reset) state <= INIT;
    else state <= next;
end

always_comb begin
    case(state)
        IDLE: begin
            if(start) next = GET_X1;
            else next = IDLE
        end

        GET_X1: next = GET_X2;

        GET_X2: next = GET_Y1;

        GET_Y1: next = GET_Y2;

        MUL1: next = MUL2;

        MUL2: next = SQRT;

        SQRT: begin
            if(sqrt_done) next = FINISH;
            else next = SQRT;
        end

        FINISH: next = IDLE;
    endcase
end

always_ff @(posedge clk or posedge reset) begin
    case(state)
        IDLE: begin
            distance = 8'b0;
            finish = 1'b0;
        end
        
    endcase
end


endmodule

*/