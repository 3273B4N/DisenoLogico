// Este modulo permite establecer cuales son los valores que se mostrarian en los 7 segmentos.

module module_prio (

     // Reloj para que cuando los valores del binario se actualicen se ven reflejados de forma automatica en los 7 segmentos.
    input logic clk,
    // El boton de reinicio que permite restablecer los valores de los 7 segmentos a 0.
    input logic rst,
    // Valores de entrada del modulo teclado.
    input logic [7:0] num_1,
    input logic sig_1,
    input logic [7:0] num_2,
    input logic sig_2,
    input logic listo_1,
    input logic listo_2,
    input logic listo,
    // Valores de entrada del modulo multiplicador.
    input logic [15:0] num_mul,
    input logic sig_mul,
    // Valores de salida del modulo a modulo BCD y a el 7 segmentos de signo.
    output logic [15:0] numero_output,
    output logic signo_output

    );

    // Variable interna para establecer prioridad
    logic [1:0] prioridad;

    // Estados posibles de la maquina.
    localparam prio_num_1 = 2'd0;
    localparam prio_num_2 = 2'd1;
    localparam prio_num_mul = 2'd2;

    // Asignacion de la prioridad en base a las señales de control del modulo teclado.
    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            prioridad <= 2'd0;

        end else begin
            
            if (listo) begin

                prioridad <= 2'd2;

            end else begin

                if (listo_2) begin

                    prioridad <= 2'd1; 

                end else begin

                    if (listo_1) begin

                        prioridad <= 2'd0;

                    end

                end

            end

        end
        
    end

    // Asignacion a las salidas en base a la prioridad
    always_comb begin

        case (prioridad)

            prio_num_1:begin
                numero_output = num_1;
                signo_output = sig_1;
            end 

            prio_num_2:begin
                numero_output = num_2;
                signo_output = sig_2;
            end

            prio_num_mul:begin
                numero_output = num_mul;
                signo_output = sig_mul;
            end

            default: begin
                numero_output = 16'd0;
                signo_output = 1'b0;
            end

        endcase
        
    end
    
endmodule