module top (
    input logic clk,
    input logic rst,
    input logic ag, bg, cg, dg, // Entradas en código binario
    input logic suma_btn, // Botón para realizar la suma
    input logic button, // Botón para agregar el dígito
    output logic [6:0] seg_unidades,
    output logic [6:0] seg_decenas,
    output logic [6:0] seg_centenas,
    output logic [6:0] seg_milesimas
);

    // Señales intermedias
    logic [11:0] first_num;
    logic [11:0] second_num;
    logic [12:0] resultado;
    logic [15:0] number_to_divide;
    logic [3:0] unidades_output, decenas_output, centenas_output, millares_output;
    logic listo_divisor;

    // Instancias de los módulos
    module_dipswitch dipswitch (
        .clk(clk),
        .rst(rst),
        .ag(ag),
        .bg(bg),
        .cg(cg),
        .dg(dg),
        .button(button),
        .first_num(first_num),
        .second_num(second_num)
    );

    suma_aritmetica suma (
        .clk(clk),
        .rst(rst),
        .num1(first_num),
        .num2(second_num),
        .suma_btn(suma_btn),
        .resultado(resultado)
    );

    // Asumimos que el resultado se convierte a un número de 16 bits para el divisor
    assign number_to_divide = resultado; // El resultado es el número a dividir

    module_divisor divisor (
        .clk(clk),
        .rst(rst),
        .numero_input(number_to_divide),
        .unidades_output(unidades_output),
        .decenas_output(decenas_output),
        .centenas_output(centenas_output),
        .millares_output(millares_output),
        .listo(listo_divisor)
    );

    module_seg seg (
        .clk(clk),
        .rst(rst),
        .unidades_input(unidades_output),
        .decenas_input(decenas_output),
        .centenas_input(centenas_output),
        .milesimas_input(millares_output),
        .listo(listo_divisor),
        .seg_unidades(seg_unidades),
        .seg_decenas(seg_decenas),
        .seg_centenas(seg_centenas),
        .seg_milesimas(seg_milesimas)
    );

endmodule
