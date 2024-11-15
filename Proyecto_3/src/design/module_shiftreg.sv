module module_shiftreg  (
    input logic rst, clk,
    output logic [3:0] row
);

always_ff @( posedge clk or posedge rst ) begin 

    if (rst) begin
        row<=4'b1110; // con pull-up
    end else begin
        row <= {row[2:0], row[3]};
    end
    
end
    
endmodule
