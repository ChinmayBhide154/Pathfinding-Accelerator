module CoordinateCollector (
    input logic reset,
    input logic clk,
    input logic [7:0] x_in,
    input logic [7:0] y_in,
    input logic write_en,
    input logic enterNewCoord,
    input logic finishInit,

    output logic [7:0] x_out,
    output logic [7:0] y_out,

    output logic update_x_mem,
    output logic update_y_mem,

    output logic [3:0] hex0,
    output logic [3:0] hex1,
    output logic [3:0] hex2,
    output logic [3:0] hex3,
    output logic [3:0] hex4,
    output logic [3:0] hex5,

    output logic [7:0] address,
    output logic mem_wren,
    output logic done
);

//States
parameter INIT = 3'b000;
parameter GET_X = 3'b001;
parameter UPDATE_X_MEM = 3'b010;
parameter GET_Y = 3'b011;
parameter UPDATE_Y_MEM = 3'b100;
parameter OPTION = 3'b101;
parameter FINISH = 3'b110;

logic [2:0] state, next;

always_ff @(posedge clk or posedge reset) begin
    if(reset) state <= INIT;
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

        default: next = INIT;
    endcase
end

always_ff @(posedge clk) begin
    case(state) 
        INIT: begin
            x_out <= 8'h00;
            y_out <= 8'h00;

            hex0 <= 4'h0;
            hex1 <= 4'h0;
            hex2 <= 4'h0;
            hex3 <= 4'h0;
            hex4 <= 4'h0;
            hex5 <= 4'h0;

            mem_wren <= 1'b0;
            done <= 1'b0;

            address <= 8'h00;

            update_x_mem = 1'b0;
            update_y_mem = 1'b0;
        end

        GET_X: begin
            x_out <= x_in;
            mem_wren <= 1'b1;
            update_x_mem = 1'b1;
            update_y_mem = 1'b0;
        end

        GET_Y: begin
            y_out <= y_in;
            update_x_mem = 1'b0;
            update_y_mem = 1'b1;
        end

        OPTION: begin
            mem_wren <= 1'b0;
            address = address + 8'b00000001;

            update_x_mem = 1'b0;
            update_y_mem = 1'b0;
        end

        FINISH: begin
            x_out <= 8'h00;
            y_out <= 8'h00;

            hex0 <= 4'h0;
            hex1 <= 4'h0;
            hex2 <= 4'h0;
            hex3 <= 4'h0;
            hex4 <= 4'h0;
            hex5 <= 4'h0;

            mem_wren <= 1'b0;
            done <= 1'b1;

            address <= 8'h00;

            update_x_mem = 1'b0;
            update_y_mem = 1'b0;
        end
    endcase
end
endmodule
