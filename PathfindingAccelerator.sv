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

assign LEDR[0] = 1'b1;

endmodule
