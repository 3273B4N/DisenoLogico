`timescale 1ns/1ps
module module_top_tb; 
    logic ag, bg, cg, dg;
    logic clk;
    logic rst;
    //logic btn2;
    logic [6:0] seg_unidades;
    logic [6:0] seg_decenas;
    logic [6:0] seg_centenas;
    logic [6:0] seg_milesimas;


    module_top uut(
        .ag(ag), 
        .bg(bg),
        .cg(cg),
        .dg(dg),
        .clk(clk),
        .rst(rst),
        //.btn2(btn2);
        .seg_unidades(seg_unidades),
        .seg_decenas(seg_decenas),
        .seg_centenas(seg_centenas),
        .seg_milesimas(seg_milesimas)
    );

    always begin
        clk=~clk;
        #18.518;
    end

    initial begin
        clk=0;
        rst=0;

        rst = 1; // Aplicar reset
        ag = 0; bg = 0; cg = 0; dg = 0;
        #10;
        rst = 0; // Quitar reset

        // Probar el primer número (3 dígitos)
        #10; {ag, bg, cg, dg} = 4'b0000; // 0 en Gray
        #10; {ag, bg, cg, dg} = 4'b0001; // 1 en Gray
        #10; {ag, bg, cg, dg} = 4'b0011; // 2 en Gray
        #10; {ag, bg, cg, dg} = 4'b0010; // 3 en Gray
        #10; {ag, bg, cg, dg} = 4'b0100; // 4 en Gray

        // Cambiar a segundo número después de completar el primer número
        #10; {ag, bg, cg, dg} = 4'b0101; // 5 en Gray
        #10; {ag, bg, cg, dg} = 4'b0111; // 6 en Gray
        #10; {ag, bg, cg, dg} = 4'b0110; // 7 en Gray
        


    end
    initial begin

        $dumpfile("module_top_tb.vcd");
        $dumpvars(0,module_top_tb);

    end   
endmodule