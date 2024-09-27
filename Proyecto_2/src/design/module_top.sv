module module_top (
    input logic ag, bg, cg, dg,
    input logic clk, 
    input logic rst,
    //input logic btn2,
    output logic [6:0] seg_unidades,
    output logic [6:0] seg_decenas,
    output logic [6:0] seg_centenas,
    output logic [6:0] seg_milesimas
    );

    logic num1 [11:0];
    logic num2 [11:0];
    logic resultado [15:0];
    logic unidades [3:0];
    logic decenas [3:0];
    logic centenas [3:0];
    logic millares [3:0];
    logic listo;

    module_dipswitch u_module_dipswitch (
        .clk(clk),
        .rst(rst)
        .ag(ag), 
        .bg(bg), 
        .cg(cg), 
        .dg(dg), 
        .first_num(num1),
        .second_num(num2) 
    );

    module_sumador u_module_sumador (
        .num1(num1),        
        .num2(num2),
        .clk(clk),
        .rst(rst),
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