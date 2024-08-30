module top_module_2 (
    input logic clk,
    input logic ag, bg, cg, dg, 
    output logic [3:0] led,
    output logic au, bu, cu, du, eu, fu, gu, 
    output logic ad, bd, cd, dd, ed, fd, gd  
);

    logic ab, bb, cb, db;
    logic [3:0] binario;

    decoder u_decoder (
        .ag(ag),
        .bg(bg),
        .cg(cg),
        .dg(dg),
        .ab(ab),
        .bb(bb),
        .cb(cb),
        .db(db)
    );

    assign binario = {ab, bb, cb, db};

    module_leds u_module_leds (
        .binario(binario),
        .led(led)
    );

    module_seg u_module_seg (
        .clk(clk),
        .A(ab),
        .B(bb),
        .C(cb),
        .D(db),
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