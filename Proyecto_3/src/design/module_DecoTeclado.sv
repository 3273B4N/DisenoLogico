module module_DecoTeclado (
    input logic clk,
    input logic rst,
    input logic listo,
    input logic [3:0] row,           
    input logic [3:0] column,  
    output logic listoDecTec,     
    output logic [3:0] key_pressed      
);

    // Control de detección de teclas
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            key_pressed <= 4'b0000;
            listoDecTec <= 1'b0;
        end else begin
            listoDecTec <= 1'b0;
            if (listo) begin 
                case (row)
                    4'b1110: begin 
                        case (column)
                            4'b1110: begin
                                key_pressed <= 4'd1;  
                                listoDecTec <= 1'b1;
                            end
                            4'b1101: begin
                                key_pressed <= 4'd2;  
                                listoDecTec <= 1'b1;
                            end
                            4'b1011: begin
                                key_pressed <= 4'd3;  
                                listoDecTec <= 1'b1;
                            end
                            4'b0111: begin
                                key_pressed <= 4'd10; 
                                listoDecTec <= 1'b1;
                            end
                            default: key_pressed <= 4'b0000;
                        endcase
                    end
                    4'b1101: begin 
                        case (column)
                            4'b1110: begin
                                key_pressed <= 4'd4;  
                                listoDecTec <= 1'b1;
                            end
                            4'b1101: begin
                                key_pressed <= 4'd5;  
                                listoDecTec <= 1'b1;
                            end
                            4'b1011: begin
                                key_pressed <= 4'd6;  
                                listoDecTec <= 1'b1;
                            end
                            4'b0111: begin
                                key_pressed <= 4'd11; 
                                listoDecTec <= 1'b1;
                            end
                            default: key_pressed <= 4'b0000;
                        endcase
                    end
                    4'b1011: begin 
                        case (column)
                            4'b1110: begin
                                key_pressed <= 4'd7;  
                                listoDecTec <= 1'b1;
                            end
                            4'b1101: begin
                                key_pressed <= 4'd8;  
                                listoDecTec <= 1'b1;
                            end
                            4'b1011: begin
                                key_pressed <= 4'd9;  
                                listoDecTec <= 1'b1;
                            end
                            4'b0111: begin
                                key_pressed <= 4'd12; 
                                listoDecTec <= 1'b1;
                            end
                            default: key_pressed <= 4'b0000;
                        endcase
                    end
                    4'b0111: begin 
                        case (column)
                            4'b1110: begin
                                key_pressed <= 4'd14; 
                                listoDecTec <= 1'b1;
                            end
                            4'b1101: begin
                                key_pressed <= 4'd0;  
                                listoDecTec <= 1'b1;
                            end
                            4'b1011: begin
                                key_pressed <= 4'd15; 
                                listoDecTec <= 1'b1;
                            end
                            4'b0111: begin
                                key_pressed <= 4'd13; 
                                listoDecTec <= 1'b1;
                            end
                            default: key_pressed <= 4'b0000;
                        endcase
                    end
                    default: key_pressed <= 4'b0000; 
                endcase
            end 
        end
    end

endmodule

