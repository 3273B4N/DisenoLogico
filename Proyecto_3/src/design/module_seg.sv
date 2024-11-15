// Subsistema 4 de la tarea 3, correccion y mejora del modulo 3 de la tarea 1 y 2.

module module_seg (

    // Reloj para que cuando los valores del binario se actualicen se ven reflejados de forma automatica en los 7 segmentos.
    input logic clk,
    // El boton de reinicio que permite restablecer los valores de los 7 segmentos a 0.
    input logic rst,
    // Variables de entrada del modulo BCD.
    input logic [3:0] unidades_input,
    input logic [3:0] decenas_input,
    input logic [3:0] centenas_input,
    input logic [3:0] millares_input,
    input logic listo,
    // Variable de salida para los 7 segmentos.
    output logic [6:0] seg,
    // Variable de salida para activar los transistores de unidades, decenas, centenas y millares; codificacion one_hot.
    output logic [3:0] transis

    );
    
    // Variables internas para el proceso de entrada.
    logic [3:0] unidades;
    logic [3:0] decenas;
    logic [3:0] centenas;
    logic [3:0] millares;

    // Restablecer los valores de las variables internas a 0.
    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            unidades <= 4'd0;
            decenas <= 4'd0;
            centenas <= 4'd0;
            millares <= 4'd0;

        end 

    end

    // Asignacion de las entradas cuando el proceso de BCD este listo.
    always_comb begin

        if (listo) begin

            unidades = unidades_input;
            decenas = decenas_input;
            centenas = centenas_input;
            millares = millares_input;

        end else begin

            unidades = 4'd0;
            decenas = 4'd0;
            centenas = 4'd0;
            millares = 4'd0;

        end

    end

    // Numero que se estaria proyectando en los 7 segmentos, el cual es asignado en la maquina de estados.
    logic [3:0] numero;

    // Asignacion por logica combinacional de los 7 segmentos.
    always_comb begin

        case (numero)
            
            4'd0: seg = 7'b0000001;
            4'd1: seg = 7'b1001111;
            4'd2: seg = 7'b0010010;
            4'd3: seg = 7'b0000110;
            4'd4: seg = 7'b1001100;
            4'd5: seg = 7'b0100100;
            4'd6: seg = 7'b0100000;
            4'd7: seg = 7'b0001111;
            4'd8: seg = 7'b0000000;
            4'd9: seg = 7'b0000100;
            default: seg = 7'b0110110;

        endcase

    end

    // Contador que selecciona cual de los estados se esta presentando.
    logic [1:0] selec = 2'd0;
    
    // Asignacion de cual estado se esta presentando, este cambia en cada flanco de reloj.
    always_ff @(posedge clk) begin

        if (rst) begin

            selec <= 2'd0;

        end else begin

            selec <= (selec + 1) % 4;

        end

    end

    // Estados posibles de la maquina.
    localparam UNI = 4'd0;
    localparam DEC = 4'd1;
    localparam CEN = 4'd2;
    localparam MIL = 4'd3;

    // Maquina de estados
    // Comendar los estados que no se esten revisando para realizar las pruebas.
    always_comb begin 

        case (selec)

            UNI:begin
                numero = unidades;
                transis = 4'b0001;
            end

            DEC:begin
                numero = decenas;
                transis = 4'b0010;
            end

            CEN:begin
                numero = centenas;
                transis = 4'b0100;
            end

            MIL:begin
                numero = millares;
                transis = 4'b1000;
            end

            default: begin
                numero = 4'd0;
                transis = 4'b0000;
            end

        endcase
        
    end

endmodule