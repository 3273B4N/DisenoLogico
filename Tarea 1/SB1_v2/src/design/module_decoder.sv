module decoder (input logic ag, bg, cg, dg, output logic ab, bb, cb, db);
    assign ab = ag;
    assign bb = (ag ^ bg);
    assign cb = ((ag ^ bg) ^ cg);
    assign db = (((ag ^ bg) ^ cg) ^ dg);
endmodule

module integrar_module (
    input logic ag, 
    input logic bg, 
    input logic cg, 
    input logic dg,
    output logic[3:0] led
    );

    
    logic[3:0] binario;

    
    decoder decodificador (
        .ag(ag),
        .bg(bg),
        .cg(cg),
        .dg(dg),
        .ab(binario[0]),
        .bb(binario[1]),
        .cb(binario[2]),
        .db(binario[3])
    );

    
    module_leds Leds (
        .binario(binario),
        .led(led)
    );

endmodule

module union_seg ( 
    input logic ag, bg, cg, dg,
    output logic au, bu, cu, du, eu, fu, gu, ad, bd, cd, dd, ed, fd, gd
    );

    logic A, B, C, D;

    decoder deco_seg (
        .ag(ag),
        .bg(bg),
        .cg(cg),
        .dg(dg),
        .ab(A),
        .bb(B),
        .cb(C),
        .db(D)
    );

    module_seg seg(
        .clk(clk),
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .au(au),
        .bu(bu),
        .cu(cu),
        .du(du),
        .eu(eu),
        .fu(fu),
        .gu(gu),
        .ad(ad),
        .bd(bd),
        .cd(cd),
        .dd(dd),
        .ed(ed),
        .fd(fd),
        .gd(gd)

    );

endmodule


module module_leds (

    input logic[3:0] binario,
    output reg[3:0] led

    );

    assign led[0] = ~((binario == 4'b0001)| (binario == 4'b0011)| (binario == 4'b0101) | (binario == 4'b0111) | (binario == 4'b1001)| (binario == 4'b1011) | (binario == 4'b1101) | (binario == 4'b1111)) ; 

    assign led[1] =  ~((binario == 4'b0010) | (binario == 4'b0011) | (binario == 4'b0110) | (binario == 4'b0111) | (binario == 4'b1010) | (binario == 4'b1011) | (binario == 4'b1110) | (binario == 4'b1111)) ;

    assign led[2] = ~((binario== 4'b0100)| (binario == 4'b0101) | (binario == 4'b0111) | (binario == 4'b0110)| (binario == 4'b1100)| (binario == 4'b1101) | (binario == 4'b1111) | (binario == 4'b1110)) ;

    assign led[3] = ~((binario== 4'b1000)| (binario == 4'b1101) | (binario == 4'b1001) | (binario == 4'b1010)| (binario == 4'b1011)| (binario == 4'b1100) | (binario == 4'b1101) | (binario == 4'b1110) | (binario == 4'b1111));
 
endmodule

// Subsistema 3 de la tarea 1, este modulo tiene la funcionalidad de recibir los datos del subsistema 1 y desplegarlos en los dispositivos de 7 segmentos.

module module_seg (

    // Reloj para que cuando los valores del binario se actualicen se ven reflejados de forma automatica en los 7 segmentos.
    input logic clk,
    // Variables de entrada las cuales vienen del subsistema 1 ya en tipo binario.
    input logic A, B, C, D,
    // Estas variables de salida representan a cada uno de los segmentos que se encontraran conectados a uno de los pines de la FPGA, ademas de que sera el 7 segmentos que representa las unidades.
    output logic au, bu, cu, du, eu, fu, gu,
    // Estas variables de salida representan a cada uno de los segmentos que se encontraran conectados a uno de los pines de la FPGA, ademas de que sera el 7 segmentos que representa las decimas.
    output logic ad, bd, cd, dd, ed, fd, gd 
    );

    always @(posedge clk) begin

        // Asignacion del 7 segmentos de unidades
        au <= (~A & ~B & ~C & ~D) | (~A & ~B & C & ~D) | (~A & ~B & C & D) | (~A & B & ~C & D) | (~A & B & C & ~D) | (~A & B & C & D) | (A & ~B & ~C & ~D) | (A & ~B & ~C & D) | (A & ~B & C & ~D) | (A & B & ~C & ~D) | (A & B & ~C & D) | (A & B & C & D);
        bu <= (~A & ~B & ~C & ~D) | (~A & ~B & ~C & D) | (~A & ~B & C & ~D) | (~A & ~B & C & D) | (~A & B & ~C & ~D) | (~A & B & C & D) | (A & ~B & ~C & ~D) | (A & ~B & ~C & D) | (A & ~B & C & ~D) | (A & ~B & C & D) | (A & B & ~C & ~D) | (A & B & ~C & D) | (A & B & C & ~D);
        cu <= (~A & ~B & ~C & ~D) | (~A & ~B & ~C & D) | (~A & ~B & C & D) | (~A & B & ~C & ~D) | (~A & B & ~C & D) | (~A & B & C & ~D) | (~A & B & C & D) | (A & ~B & ~C & ~D) | (A & ~B & ~C & D) | (A & ~B & C & ~D) | (A & ~B & C & D) | (A & B & ~C & D) | (A & B & C & ~D) | (A & B & C & D);
        du <= (~A & ~B & ~C & ~D) | (~A & ~B & C & ~D) | (~A & ~B & C & D) | (~A & B & ~C & D) | (~A & B & C & ~D) | (A & ~B & ~C & ~D) | (A & ~B & ~C & D) | (A & ~B & C & ~D) | (A & B & ~C & ~D) | (A & B & ~C & D) | (A & B & C & D);
        eu <= (~A & ~B & ~C & ~D) | (~A & ~B & C & ~D) | (~A & B & C & ~D) | (A & ~B & ~C & ~D) | (A & ~B & C & ~D) | (A & B & ~C & ~D);
        fu <= (~A & ~B & ~C & ~D) | (~A & B & ~C & ~D) | (~A & B & ~C & D) | (~A & B & C & ~D) | (A & ~B & ~C & ~D) | (A & ~B & ~C & D) | (A & ~B & C & ~D) | (A & B & C & ~D) | (A & B & C & D);
        gu <= (~A & ~B & C & ~D) | (~A & ~B & C & D) | (~A & B & ~C & ~D) | (~A & B & ~C & D) | (~A & B & C & ~D) | (A & ~B & ~C & ~D) | (A & ~B & ~C & D) | (A & B & ~C & ~D) | (A & B & ~C & D) | (A & B & C & ~D) | (A & B & C & D);

        // Asignacion del 7 segmentos de decimas
        ad <= (~A & ~B & ~C & ~D) | (~A & ~B & ~C & D) | (~A & ~B & C & ~D) | (~A & ~B & C & D) | (~A & B & ~C & ~D) | (~A & B & ~C & D) | (~A & B & C & ~D) | (~A & B & C & D) | (A & ~B & ~C & ~D) | (A & ~B & ~C & D);
        bd <= 1; // El segmento b del 7 segmentos de decimas en este proyecto siempre esta encendido.
        cd <= 1; // El segmento c del 7 segmentos de decimas en este proyecto siempre esta encendido.
        dd <= (~A & ~B & ~C & ~D) | (~A & ~B & ~C & D) | (~A & ~B & C & ~D) | (~A & ~B & C & D) | (~A & B & ~C & ~D) | (~A & B & ~C & D) | (~A & B & C & ~D) | (~A & B & C & D) | (A & ~B & ~C & ~D) | (A & ~B & ~C & D);
        ed <= (~A & ~B & ~C & ~D) | (~A & ~B & ~C & D) | (~A & ~B & C & ~D) | (~A & ~B & C & D) | (~A & B & ~C & ~D) | (~A & B & ~C & D) | (~A & B & C & ~D) | (~A & B & C & D) | (A & ~B & ~C & ~D) | (A & ~B & ~C & D);
        fd <= (~A & ~B & ~C & ~D) | (~A & ~B & ~C & D) | (~A & ~B & C & ~D) | (~A & ~B & C & D) | (~A & B & ~C & ~D) | (~A & B & ~C & D) | (~A & B & C & ~D) | (~A & B & C & D) | (A & ~B & ~C & ~D) | (A & ~B & ~C & D);
        gd <= 0; // El segmento g del 7 segmentos de decimas en este proyecto siempre esta apagado.

    end 

endmodule