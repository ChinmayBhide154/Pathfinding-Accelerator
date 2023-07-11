module Pathfinding (
    input logic clk,

    // inputs to prev_vertex_discard_mem
    input logic [15:0] prev_vertex_discard_mem_addr,
    input logic [15:0] prev_vertex_discard_mem_data,
    input logic [15:0] prev_vertex_discard_mem_wren,
    input logic [15:0] prev_vertex_discard_mem_out,

    // inputs to vertex_discard_mem_addr
    input logic [15:0] vertex_discard_mem_addr,
    input logic [15:0] vertex_discard_mem_data,
    input logic [15:0] vertex_discard_mem_wren,
    input logic [15:0] vertex_discard_mem_out,

    // inputs to dist_from_prev_discard_mem
    input logic [15:0] dist_from_prev_discard_mem_addr,
    input logic [15:0] dist_from_prev_discard_mem_data,
    input logic [15:0] dist_from_prev_discard_mem_wren,
    input logic [15:0] dist_from_prev_discard_mem_out,

    // inputs to vertex_queue_mem
    input logic [15:0] vertex_queue_mem_addr,
    input logic [15:0] vertex_queue_mem_data,
    input logic [15:0] vertex_queue_mem_wren,
    input logic [15:0] vertex_queue_mem_out,

    //inputs to vertex_prev_queue_mem
    input logic [15:0] vertex_prev_queue_mem_addr,
    input logic [15:0] vertex_prev_queue_mem_data,
    input logic [15:0] vertex_prev_queue_mem_wren,
    input logic [15:0] vertex_prev_queue_mem_out,

    //inputs to prev_vertex_dist_queue_mem
    input logic [15:0] prev_vertex_dist_queue_mem_addr,
    input logic [15:0] prev_vertex_dist_queue_mem_data,
    input logic [15:0] prev_vertex_dist_queue_mem_wren,
    input logic [15:0] prev_vertex_dist_queue_mem_out,


    output logic path
);

// Memories
pathfinding_mem prev_vertex_discard_mem(
    .address(),		
	.clock(),		
	.data(),	
	.wren(),		
	.q()	
);

pathfinding_mem vertex_discard_mem(
    .address(),		
	.clock(),		
	.data(),	
	.wren(),		
	.q()	
);

pathfinding_mem dist_from_prev_discard_mem(
    .address(),		
	.clock(),		
	.data(),	
	.wren(),		
	.q()	
);

pathfinding_mem vertex_queue_mem(
    .address(),		
	.clock(),		
	.data(),	
	.wren(),		
	.q()	
);

pathfinding_mem vertex_prev_queue_mem(
    .address(),		
	.clock(),		
	.data(),	
	.wren(),		
	.q()	
);

pathfinding_mem prev_vertex_dist_queue_mem(
    .address(),		
	.clock(),		
	.data(),	
	.wren(),		
	.q()	
);



endmodule  