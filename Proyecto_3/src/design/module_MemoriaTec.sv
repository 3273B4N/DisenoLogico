module module_MemoriaTec (input logic clk, rst, listo,
input logic [3:0] col, row,
output logic [3:0] colM, rowM,
output logic listoM);

always_ff@(posedge clk or posedge rst) begin
    listoM<=0;
    if(rst)begin
        colM<=4'b0;
        rowM<=4'b0;
        listoM<=0;
    end else if(listo && col!=4'b1111) begin
        colM<=col;
        rowM<=row;
        listoM<=1;
    end else begin
        colM<=colM;
        rowM<=rowM;
        listoM<=0;
    end

end

endmodule