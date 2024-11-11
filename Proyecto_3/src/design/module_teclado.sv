module module_teclado (
    input logic clk,
    input logic rst,                    
    input logic  [3:0] column,                
    input logic [3:0] row,
    input logic key_out,              
    output logic [7:0] first_num,          
    output logic [7:0] second_num,
    output logic listo_1,
    output logic listo_2,
    output logic listo
);

    typedef enum logic [1:0] {
        IDLE,        
        READ_FIRST,  
        READ_SECOND  
    } statetype;

    statetype state, nextstate;  
    logic [3:0] key_pressed;             
    logic clk_div;                      
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

module_anti_rebote anti_rebote_inst(
    .clk(clk_div),
    .rst(rst),
    .key_out(key_out),
    .row(row),
    .column(column)
);
    // Instancia del módulo de detección de teclas
    module_detector teclado_detector_inst (
        .clk(clk_div),          
        .rst(rst),              
        .row(row),             
        .column(column),           
        .key_pressed(key_pressed) 
    );


    always_ff @(posedge clk_div or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            first_num <= 8'b0;
            second_num <= 8'b0;
            listo <= 0;
            listo_1 <= 0;
            listo_2 <= 0;
            
        end else begin
            state <= nextstate;
            // Si hay una tecla presionada, la almacenamos en last_key
            if (key_pressed != 4'b0000) begin
                case (state)
                    READ_FIRST: begin
                        if (key_pressed != 4'd10)
                            first_num <= {first_num[7:0], key_pressed};
                        else
                           listo_1 <= 1;
                    end
                    READ_SECOND: begin
                       if (key_pressed != 4'd11)
                            second_num <= {second_num[7:0], key_pressed};
                        else
                           listo_2 <= 1;
                    end
                endcase
            end
        end
    end
            
    always_comb begin
        nextstate = state;
            
        case (state)
            IDLE: begin
                
                if (key_pressed !=  4'b0000) begin
                    nextstate = READ_FIRST;
                end
            end
            READ_FIRST: begin
                
                if (key_pressed == 4'd10) begin // Si se presiona "A", pasar a READ_SECOND
                    nextstate = READ_SECOND;
                end
            end
            READ_SECOND: begin
                
                if (key_pressed == 4'd11 ) begin // Si se presiona "A", pasar a READ_SECOND
                    nextstate = IDLE;
                    listo = 1;
                end
            end
            default: nextstate = IDLE;
        endcase
    end

endmodule
