//Modulo divisor, esta diseñado para obtener los valores de unidades, decenas, centenas y milesimas; procedientes de un numero en binario de 16 bits.

module module_divisor (

    // Reloj del sistema.
    input logic clk,
    // El boton de reinicio que permite restablecer los valores a 0.
    input logic rst,
    // Valor de entrada en binario.
    input logic [15:0] numero_input,
    // Variables de salida del modulo
    output logic [3:0] unidades_output,
    output logic [3:0] decenas_output,
    output logic [3:0] centenas_output,
    output logic [3:0] milesimas_output

    );

    // Variables internas para el proceso de sincronizacion de la entrada.
    logic [15:0] numero1;
    logic [15:0] numero2;
    logic [15:0] numero;

    // Sincronizacion de las entradas, por tres etapas.
    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            // Restablecer los valores de las variables internas a 0.
            numero1 <= 16'd0;
            numero2 <= 16'd0;
            numero <= 16'd0;

        end else begin

            // Primera etapa.
            numero1 <= numero_input;

            // Segunda etapa.
            numero2 <= numero1;

            // Tercera etapa.
            numero <= numero2;
        
        end

    end

    // Proceso de division del numero de entrada en sus componentes. 
    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            // Restablecer los valores de las variables.
            unidades_output <= 4'b0000;
            decenas_output <= 4'b0000;
            centenas_output <= 4'b0000;
            milesimas_output <= 4'b0000;

        end else begin

            unidades_output <= numero / 10;
            decenas_output <= (numero / 10) % 10;
            centenas_output <= (numero / 100) % 10;
            milesimas_output <= (numero / 1000) % 10;

        end

    end
    
endmodule 