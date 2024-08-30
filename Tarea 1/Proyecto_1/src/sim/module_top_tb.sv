module top_module_tb;

    logic clk;
    logic ag, bg, cg, dg;
    logic [3:0] led;
    logic au, bu, cu, du, eu, fu, gu;
    logic ad, bd, cd, dd, ed, fd, gd;

    top_module_2 dut (
        .clk(clk),
        .ag(ag),
        .bg(bg),
        .cg(cg),
        .dg(dg),
        .led(led),
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

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        ag = 0;
        bg = 0;
        cg = 0;
        dg = 0;
        #20;
        
        ag = 1; bg = 0; cg = 0; dg = 0;
        #5;
        ag = 0; bg = 1; cg = 0; dg = 0;
        #5;
        ag = 0; bg = 0; cg = 1; dg = 0;
        #5;
        ag = 0; bg = 0; cg = 0; dg = 1;
        #5;
        
        ag = 1; bg = 1; cg = 0; dg = 0;
        #5;
        ag = 1; bg = 1; cg = 1; dg = 0;
        #5;
        ag = 1; bg = 1; cg = 1; dg = 1;
        #5;
        ag = 0; bg = 0; cg = 0; dg = 0; 
        #5;

        $finish;
    end

    initial begin
        $monitor("Time = %0t | led = %b | au = %b, bu = %b, cu = %b, du = %b, eu = %b, fu = %b, gu = %b",
        $time, led, au, bu, cu, du, eu, fu, gu);


    end

endmodule