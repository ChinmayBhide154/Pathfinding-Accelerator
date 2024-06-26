module CoordinateCollector_tb;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in time units
    
    // Inputs
    reg reset, clk;
    reg [7:0] x_in, y_in;
    reg write_en, enterNewCoord, finishInit;

    // Outputs
    wire [7:0] x_out, y_out;
    wire update_x_mem, update_y_mem;
    wire [3:0] hex0, hex1, hex2, hex3, hex4, hex5;
    wire [7:0] address;
    wire mem_wren, done;

    // Instantiate the module under test
    CoordinateCollector DUT (
        .reset(reset),
        .clk(clk),
        .x_in(x_in),
        .y_in(y_in),
        .write_en(write_en),
        .enterNewCoord(enterNewCoord),
        .finishInit(finishInit),
        .x_out(x_out),
        .y_out(y_out),
        .update_x_mem(update_x_mem),
        .update_y_mem(update_y_mem),
        .hex0(hex0),
        .hex1(hex1),
        .hex2(hex2),
        .hex3(hex3),
        .hex4(hex4),
        .hex5(hex5),
        .address(address),
        .mem_wren(mem_wren),
        .done(done)
    );

    // Clock generation
    initial clk = 0;
    
    always #((CLK_PERIOD)/2) clk = ~clk;

    // Stimulus generation
    initial begin
        repeat(100) begin
            reset = 0;
            write_en = 1;
            enterNewCoord = $urandom_range(1);
            finishInit = 0;
            x_in = 0;
            y_in = 0;
            // Randomize inputs
            write_en = $urandom_range(2);
            enterNewCoord = $urandom_range(2);
            finishInit = $urandom_range(2);
            x_in = $urandom_range(256);
            y_in = $urandom_range(256);
        end
    end

endmodule