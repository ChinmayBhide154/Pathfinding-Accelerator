module Mem_Interface_Decoder (
    input logic [2:0] mem_id,

    input logic [7:0] address,		
	input logic clock,		
	input logic [7:0] data,	
	input logic wren,		

    output logic [7:0] address_mem_id0,		
	output logic clock_mem_id0,		
	output logic [7:0] data_mem_id0,	
	output logic wren_mem_id0,

    output logic [7:0] address_mem_id1,		
	output logic clock_mem_id1,		
	output logic [7:0] data_mem_id1,	
	output logic wren_mem_id1

	/*
    output logic [7:0] address_mem_id2,		
	output logic clock_mem_id2,		
	output logic [7:0] data_mem_id2,	
	output logic wren_mem_id2,

    output logic [7:0] address_mem_id3,		
	output logic clock_mem_id3,		
	output logic [7:0] data_mem_id3,	
	output logic wren_mem_id3,

    output logic [7:0] address_mem_id4,		
	output logic clock_mem_id4,		
	output logic [7:0] data_mem_id4,	
	output logic wren_mem_id4,

    output logic [7:0] address_mem_id5,		
	output logic clock_mem_id5,		
	output logic [7:0] data_mem_id5,	
	output logic wren_mem_id5
	*/
);

parameter XMEM = 3'b000;
parameter YMEM = 3'b001;

logic [19:0] bus_id0;
logic [19:0] bus_id1;

assign bus_id0 = {address_mem_id0, clock_mem_id0, data_mem_id0, wren_mem_id0};
assign bus_id1 = {address_mem_id1, clock_mem_id1, data_mem_id1, wren_mem_id1};

always_comb begin
	case(mem_id) 
		XMEM: begin
			bus_id0 = {address, clock, data, wren};
			bus_id1 = 19'b0;
		end

		YMEM: begin
			bus_id0 = 19'b0;
			bus_id1 = {address, clock, data, wren};
		end

		default: begin
			bus_id0 = {address, clock, data, wren};
			bus_id1 = 19'b0;
		end
	endcase
end
    
endmodule