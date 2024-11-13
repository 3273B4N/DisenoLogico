module module_clkdiv ( 
    input logic clk,
    input logic rst,
    output logic clk_div
);
logic [13:0] counter; 
        // Contador para dividir el reloj de 27 MHz a 1 MHz
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 14'b0; 
            clk_div <= 1'b0;   
        end else begin
            if (counter == 13'd13) begin 
                clk_div <= ~clk_div; 
                counter <= 14'b0;
            end else begin
                counter <= counter + 1'b1;
            end
        end
    end

endmodule