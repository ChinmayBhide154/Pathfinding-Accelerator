module CoordinateCollector (
    input logic reset,
    input logic clk,
    input logic [7:0] x_in,
    input logic [7:0] y_in,
    //input logic transition,
    input logic write_en,
    input logic enterNewCoord,
    input logic finishInit,

    output logic x_out,
    output logic y_out,

    output logic [6:0] hex0,
    output logic [6:0] hex1,
    output logic [6:0] hex2,
    output logic [6:0] hex3,
    output logic [6:0] hex4,
    output logic [6:0] hex5,

    output logic mem_wren,
    output logic done
);


typedef enum logic [1:0] {
    INIT  = 3'b000,
    GET_X = 3'b001,
    UPDATE_X_MEM = 3'b010,
    GET_Y = 3'b011,
    UPDATE_Y_MEM = 3'b100,
    OPTION = 3'b101,
    FINISH = 3'b110
} stateType;

stateType state = GET_X;

logic [1:0] next;

logic [7:0] address;

always_ff @(posedge clk or posedge reset) begin
    if(reset) state <= GET_X;
    else state <= next;
end

always_comb begin
    case(state)
        INIT: next = GET_X;

        GET_X: begin
            if(write_en) next = UPDATE_X_MEM;
            else next = GET_X;
        end

        UPDATE_X_MEM: next = GET_Y;

        GET_Y: begin
            if(write_en) next = UPDATE_Y_MEM;
            else next = GET_Y;
        end

        UPDATE_Y_MEM: next = OPTION;

        OPTION: begin
            if(enterNewCoord) next = GET_X;
            else if(finishInit) next = FINISH;
            else next = OPTION;
        end

        FINISH: next = FINISH;
    endcase
end

always_ff @(posedge clk or posedge reset) begin
    case(state)
        INIT: begin
            x_out <= 8'b0;
            y_out <= 8'b0;
            hex0 <= 7'b0;
            hex1 <= 7'b0;
            hex2 <= 7'b0;
            hex3 <= 7'b0;
            hex4 <= 7'b0;
            hex5 <= 7'b0;
            done <= 1'b0;

            address <= 8'b0;
            mem_wren <= 1'b0;
        end

        GET_X: begin
            x_out <= x_in;
            mem_wren <= 1'b1;
        end

        GET_Y: y_out <= y_in;

        OPTION: begin
            mem_wren <= 1'b0;
            address = address + 8'b00000001;
        end

        FINISH: done <= 1'b1;
    endcase
end

endmodule
