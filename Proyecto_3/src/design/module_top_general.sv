// Modulo Top de la tarea 3, se realiza la interconexion de los modulos principales del proyecto.

module module_top_general (

    // Reloj del sistema.
    input logic clk,
    // El boton de reinicio que permite restablecer los valores a 0.
    input logic rst,
    // Entrada de datos del teclado al modulo principal del teclado.
    input logic [3:0] column,
    input logic [3:0] row,
    // Salida de datos de los 7 segmentos y sus respectivos transistores.
    output logic [6:0] seg,
    output logic [3:0] transis

    );

    // Variables internas de conexion entre modulos.
    // Modulo de teclado a multiplicador y prioridad.
    logic [7:0] first_num;
    logic [7:0] second_num;
    logic listo_1_tec;
    logic listo_2_tec;
    logic listo_tec;
    // Modulo de multiplicador a prioridad.
    logic [15:0] resultado_mult;
    // Modulo de prioridad a BCD.
    logic [15:0] resultado_prio;
    // Modulo de BCD a segmentos.
    logic [3:0] unidades;
    logic [3:0] decenas;
    logic [3:0] centenas;
    logic [3:0] millares;
    logic listo_BCD;

    // Instancias del modulo general de teclado.
    module_teclado teclado (

        .clk(clk),
        .rst(rst),
        .column(column),
        .row(row),
        .first_num(first_num),
        .second_num(second_num),
        .listo_1(listo_1_tec),
        .listo_2(listo_2_tec),
        .listo(listo_tec)

    );

    // Instancias del modulo general del multiplicador.
    MultiplicadorBooth multiplicador (

        .clk(clk),
        .rst(rst),
        .valid(listo_tec),
        .multiplicando(first_num),
        .multiplicador(second_num),
        .resultado(resultado_mult)

    );

    // Instancias del modulo de prioridad.
    module_prio prioridad (

        .clk(clk),
        .rst(rst),
        .num_1(first_num),
        .num_2(second_num),
        .listo_1(listo_1_tec),
        .listo_2(listo_2_tec),
        .listo(listo_tec),
        .num_mul(resultado_mult),
        .numero_output(resultado_prio)

    );

    // Instancias del modulo de BCD.
    module_BCD BCD (

        .clk(clk),
        .rst(rst),
        .numero_input(resultado_prio),
        .unidades_output(unidades),
        .decenas_output(decenas),
        .centenas_output(centenas),
        .millares_output(millares),
        .listo(listo_BCD)

    );

    // Instancias del modulo de 7 segmentos.
    module_seg segmentos (

        .clk(clk),
        .rst(rst),
        .unidades_input(unidades),
        .decenas_input(decenas),
        .centenas_input(centenas),
        .millares_input(millares),
        .listo(listo_BCD),
        .seg(seg),
        .transis(transis)

    );

endmodule