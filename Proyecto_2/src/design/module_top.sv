module module_top (
    input logic ag, bg, cg, dg,
    input logic clk, 
    input logic rst,
    input logic suma_btn,
    output logic [6:0] seg_unidades,
    output logic [6:0] seg_decenas,
    output logic [6:0] seg_centenas,
    output logic [6:0] seg_milesimas
    );

    logic [11:0] num1;
    logic [11:0] num2;
    logic [15:0] resultado;
    logic [3:0] unidades;
    logic [3:0] decenas;
    logic [3:0] centenas;
    logic [3:0] millares;
    logic listo;

    module_dipswitch u_module_dipswitch (
        .clk(clk),
        .rst(rst),
        .ag(ag), 
        .bg(bg), 
        .cg(cg), 
        .dg(dg), 
        .first_num(num1),
        .second_num(num2) 
    );

    suma_aritmetica u_module_sumador (
        .num1(num1),        
        .num2(num2),
        .clk(clk),
        .rst(rst),
        .suma_btn(suma_btn),
        .resultado(resultado)
    );

    module_divisor u_module_divisor(
        .clk(clk),
        .rst(rst),
        .numero_input(resultado),
        .unidades_output(unidades),
        .decenas_output(decenas),
        .centenas_output(centenas),
        .millares_output(millares),
        .listo(listo)
    );

    module_seg u_module_seg (
        .clk(clk),
        .rst(rst),
        .unidades_input(unidades),
        .decenas_input(decenas),
        .centenas_input(centenas),
        .milesimas_input(millares),
        .listo(listo),
        .seg_unidades(seg_unidades),
        .seg_decenas(seg_decenas),
        .seg_centenas(seg_centenas),
        .seg_milesimas(seg_milesimas)
    );

endmodule