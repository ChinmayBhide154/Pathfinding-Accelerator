module CoordinateCollector (
    input logic reset,
    input logic [255:0] xCoord,
    input logic [255:0] yCoord,
    input logic transition,
    input logic enterNewCoord,
    input logic finishInit,

    output logic done
);

typedef enum logic {  
    GET_X = 2'b00,
    GET_Y = 2'b01,
    UPDATE_MEM = 2'b10,
    FINISH = 2'b11
} state;

always_ff @(posedge clk or posedge reset) begin
    if(reset) state <= INIT;
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
    endcase
end 
endmodule