module module_topTeclado (input logic clk,rst,
input logic [3:0] col,
output logic [3:0] row,
output logic [7:0] num1,
output logic [7:0] num2,
output logic listo1, listo2);

logic [3:0] colO;
logic  listoAR;
logic [3:0] rowM;
logic [3:0] colM;
logic  listoM;
logic [3:0] key_pressed;
logic listoDec;

    module_antirebote antirebote(
        .clk(clk),
        .rst(rst),
        .colin(col),
        .colo(colO),
        .listoAR(listoAR)
    );

        module_shiftreg RegDespl (
        .clk(clk),
        .rst(rst),
        .row(row)
    );

        module_MemoriaTec MemoritaTec (
        .clk(clk),
        .rst(rst),
        .listo(listoAR),
        .col(colO),
        .row(row),
        .colM(colM),
        .rowM(rowM),
        .listoM(listoM)
    );

        module_DecoTeclado DecoTec (
        .clk(clk),
        .rst(rst),
        .listo(listoM),
        .row(rowM),
        .column(colM),
        .listoDecTec(listoDec),
        .key_pressed(key_pressed)
    );

        module_FSMnum FSMnum (
        .clk(clk),
        .rst(rst),
        .listo(listoDec),
        .key_pressed(key_pressed),
        .first_num(num1),
        .second_num(num2),
        .listo_1(listo1),
        .listo_2(listo2)
    );
    



endmodule