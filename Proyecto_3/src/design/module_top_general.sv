// Modulo Top de la tarea 3, se realiza la interconexion de los modulos principales del proyecto.

module module_top_general (
    input wire clk,
    input wire rst,
    input wire [3:0] row,
    input wire [3:0] column,
    output wire [6:0] seg,
    output wire [3:0] transis
);

    // Señales internas
    wire [7:0] first_num, second_num;
    wire listo_1, listo_2, listo_teclado;
    reg valid;
    wire done;
    wire [15:0] resultado_mult;
    wire [15:0] numero_bcd;
    wire [3:0] unidades, decenas, centenas, millares;
    wire listo_bcd;
    wire key_out;
    wire listoBCDBin;
    wire [7:0] num1O, num2O;
    wire listo_num1, listo_num2;

   // module_clkdiv u_divisor(
        //.clk(clk),
      //  .rst(rst),
    //    .clk_div(clk_div)
    //);

    // Módulo de teclado
    module_teclado u_teclado (
        .clk(clk),
        .rst(rst),
        .row(row),
        .column(column),
        .key_out(key_out),
        .first_num(first_num),
        .second_num(second_num),
        .listo_1(listo_1),
        .listo_2(listo_2),
        .listo(listo_teclado)
    );

     module_BCDBin decoBCDBin (
        .clk(clk),
        .rst(rst),
        .listo1(listo_1),
        .listo2(listo_2),
        .num1(first_num),
        .num2(second_num),
        .num1O(num1O),
        .num2O(num2O),
        .listo0(listoBCDBin),
        .error(error)
    );

    // Multiplicador Booth
    MultiplicadorBooth u_mult (
        .clk(clk),
        .rst(rst),
        .valid(listoBCDBin),
        .multiplicando(num1O),
        .multiplicador(num2O),
        .resultado(resultado_mult),
        .done(done)
    );

    // Módulo de prioridad
    module_prio u_prio (
        .clk(clk),
        .rst(rst),
        .num_1(num1O),
        .num_2(num2O),
        .num_mul(resultado_mult),
        .listo_1(listo_1),
        .listo_2(listo_2),
        .listo(done),
        .numero_output(numero_bcd)
    );

    // Conversor BCD
    module_BCD u_bcd (
        .clk(clk),
        .rst(rst),
        .numero_input(numero_bcd),
        .unidades_output(unidades),
        .decenas_output(decenas),
        .centenas_output(centenas),
        .millares_output(millares),
        .listo(listo_bcd)
    );

    // Display de 7 segmentos
    module_seg u_display (
        .clk(clk),
        .rst(rst),
        .unidades_input(unidades),
        .decenas_input(decenas),
        .centenas_input(centenas),
        .millares_input(millares),
        .listo(listo_bcd),
        .seg(seg),
        .transis(transis)
    );


endmodule