module priority_queue (
    input logic [15:0] in_vertex,
    input logic [15:0] in_prev_vertex,
    input logic [15:0] dist_from_prev,
    input logic clk,
    input logic reset,

    // push (1) or pop (0)
    input logic opcode,
    input logic op_en,

    output logic [15:0] queue_length,

    output logic [15:0] discard_vertex,
    output logic [15:0] discard_prev_vertex,
    output logic [15:0] discard_dist_from_prev,

    //Queues which hold the values for each of the parameters - 
    output logic [15:0] vertex_queue,
    output logic [15:0] prev_vertex_queue,
    output logic [15:0] prev_vertex_dist_queue
);

typedef enum logic {  
    INIT = 2'b00,
    OP_SELECT = 2'b01,
    POP = 2'b10,
    PUSH = 2'b11
} state;

logic [15:0] insertion_index;

always_ff @(posedge clk or posedge reset) begin
    if(reset) state <= INIT;
    else state <= next;
end

always_comb begin
    case(state)
        INIT: next = OP_SELECT;

        OP_SELECT: begin 
            if(opcode && op_en) next = PUSH;
            else if(!opcode && op_en) next = POP;
            else next = OP_SELECT;
        end

        POP: next = OP_SELECT;

        PUSH: next = OP_SELECT;
    endcase    
end

always_ff @(posedge clk or posedge reset) begin
    case(state)
        INIT: begin 
            queue_length <= 16'b0;
            insertion_index <= 16'b0;
        end

        POP: begin
            discard_vertex <= vertex_queue[0];
            discard_prev_vertex <= prev_vertex_queue[0];
            discard_dist_from_prev <= dist_from_prev[0]

            //shifting the current_queue after popping from the queue.
            for (int i = 0; i < queue_length; i++) begin
                vertex_queue[i] <= vertex_queue[i + 1]
                prev_vertex_queue[i] <= prev_vertex_queue[i + 1];
                prev_vertex_dist_queue[i] <= prev_vertex_dist_queue[i + 1];
            end
        end

        PUSH: begin
            vertex_queue[queue_length] <= in_vertex;
            discard_prev_vertex[queue_length] <= in_prev_vertex;
            prev_vertex_dist_queue[queue_length] <= 

            for(int i = queue_length; i >= 0; i--) begin
                if(dist_from_prev[i] < dist_from_prev[i - 1]) begin
                    insertion_index = insertion_index + 1'b1;
                end

                else begin
                    for(int i = queue_length; i > insertion_index; i--) begin
                        current_queue[queue_length + 1] = current_queue[queue_length] 
                    end

                    current_queue[insertion_index] = in_vertex;
                    
                end
            end
        end
    endcase
end
    
endmodule