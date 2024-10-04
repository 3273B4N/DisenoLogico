// Subsistema 3 de la tarea 2, correccion y mejora del modulo 3 de la tarea 1.

module module_seg (

    // Reloj para que cuando los valores del binario se actualicen se ven reflejados de forma automatica en los 7 segmentos.
    input logic clk,
    // El boton de reinicio que permite restablecer los valores de los 7 segmentos a 0.
    input logic rst,
    // Variables de entrada del modulo de divisor.
    input logic [3:0] unidades_input,
    input logic [3:0] decenas_input,
    input logic [3:0] centenas_input,
    input logic [3:0] milesimas_input,
    input logic listo,
    // Estas variables de salida para los 7 segmentos de: unidades, decenas, centenas y milesimas.
    output logic [6:0] seg_unidades,
    output logic [6:0] seg_decenas,
    output logic [6:0] seg_centenas,
    output logic [6:0] seg_milesimas

    );
    
    // Variables internas para el proceso de sincronizacion de la entrada.
    logic [3:0] u1;
    logic [3:0] u2;
    logic [3:0] unidades;
    logic [3:0] de1;
    logic [3:0] de2;
    logic [3:0] decenas;
    logic [3:0] c1;
    logic [3:0] c2;
    logic [3:0] centenas;
    logic [3:0] m1;
    logic [3:0] m2;
    logic [3:0] milesimas;

    // Sincronizacion de las entradas, por tres etapas.
    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            // Restablecer los valores de las variables internas a 0.
            u1 <= 4'd0;
            u2 <= 4'd0;
            unidades <= 4'd0;
            de1 <= 4'd0;
            de2 <= 4'd0;
            decenas <= 4'd0;
            c1 <= 4'd0;
            c2 <= 4'd0;
            centenas <= 4'd0;
            m1 <= 4'd0;
            m2 <= 4'd0;
            milesimas <= 4'd0;

        end else begin

            // Introduce el dato unicamente cuando listo este activo.

            if (listo) begin

                // Primera etapa.
                u1 <= unidades_input;
                de1 <= decenas_input;
                c1 <= centenas_input;
                m1 <= milesimas_input;

                // Segunda etapa.
                u2 <= u1;
                de2 <= de1;    
                c2 <= c1;
                m2 <= m1;

                // Tercera etapa.
                unidades <= u2;
                decenas <= de2;
                centenas <= c2;
                milesimas <= m2;

            end

        end

    end

    // Proceso de asginacion a los 7 segmentos.
    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            // Restablece los valores de: unidades, decenas, centenas y milesimas; a un valor de 0.
           seg_unidades <= 7'b111_1110; 
           seg_decenas <= 7'b111_1110; 
           seg_centenas <= 7'b111_1110; 
           seg_milesimas <= 7'b111_1110; 

        end else begin

            // Asignacion del 7 segmentos de unidades.
            case (unidades)
                4'd0: seg_unidades <= 7'b111_1110;
                4'd1: seg_unidades <= 7'b011_0000;
                4'd2: seg_unidades <= 7'b110_1101;
                4'd3: seg_unidades <= 7'b111_1001;
                4'd4: seg_unidades <= 7'b011_0011;
                4'd5: seg_unidades <= 7'b101_1011;
                4'd6: seg_unidades <= 7'b101_1111;
                4'd7: seg_unidades <= 7'b111_0000;
                4'd8: seg_unidades <= 7'b111_1111;
                4'd9: seg_unidades <= 7'b111_1011;
                default:  seg_unidades <= 7'b000_0000;
            endcase

            // Asignacion del 7 segmentos de decenas.
            case (decenas)
                4'd0: seg_decenas <= 7'b111_1110;
                4'd1: seg_decenas <= 7'b011_0000;
                4'd2: seg_decenas <= 7'b110_1101;
                4'd3: seg_decenas <= 7'b111_1001;
                4'd4: seg_decenas <= 7'b011_0011;
                4'd5: seg_decenas <= 7'b101_1011;
                4'd6: seg_decenas <= 7'b101_1111;
                4'd7: seg_decenas <= 7'b111_0000;
                4'd8: seg_decenas <= 7'b111_1111;
                4'd9: seg_decenas <= 7'b111_1011;
                default: seg_decenas <= 7'b000_0000;
            endcase

            // Asignacion del 7 segmentos de centenas.
            case (centenas)
                4'd0: seg_centenas <= 7'b111_1110;
                4'd1: seg_centenas <= 7'b011_0000;
                4'd2: seg_centenas <= 7'b110_1101;
                4'd3: seg_centenas <= 7'b111_1001;
                4'd4: seg_centenas <= 7'b011_0011;
                4'd5: seg_centenas <= 7'b101_1011;
                4'd6: seg_centenas <= 7'b101_1111;
                4'd7: seg_centenas <= 7'b111_0000;
                4'd8: seg_centenas <= 7'b111_1111;
                4'd9: seg_centenas <= 7'b111_1011;
                default: seg_centenas <= 7'b000_0000;
            endcase

            // Asignacion del 7 segmentos de milesimas.
            case (milesimas)
                4'd0: seg_milesimas <= 7'b111_1110;
                4'd1: seg_milesimas <= 7'b011_0000;
                4'd2: seg_milesimas <= 7'b110_1101;
                4'd3: seg_milesimas <= 7'b111_1001;
                4'd4: seg_milesimas <= 7'b011_0011;
                4'd5: seg_milesimas <= 7'b101_1011;
                4'd6: seg_milesimas <= 7'b101_1111;
                4'd7: seg_milesimas <= 7'b111_0000;
                4'd8: seg_milesimas <= 7'b111_1111;
                4'd9: seg_milesimas <= 7'b111_1011;
                default: seg_milesimas <= 7'b000_0000;
            endcase

        end

    end 

endmodule