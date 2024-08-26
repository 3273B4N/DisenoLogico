
`timescale 1ns / 1ps

module decoder_tb;

    // Inputs
    reg ag;
    reg bg;
    reg cg;
    reg dg;

    // Outputs
    wire ab;
    wire bb;
    wire cb;
    wire db;

    
    decoder dut (
        .ag(ag),
        .bg(bg),
        .cg(cg),
        .dg(dg),
        .ab(ab),
        .bb(bb),
        .cb(cb),
        .db(db)
    );



   
    initial begin
       
        ag = 0; bg = 0; cg = 0; dg = 0;

        // casos

		#10; ag = 0; bg = 0; cg = 0; dg = 0; // salida esperada: ab=0, bb=0, cb=0, db=0
        #10; ag = 1; bg = 0; cg = 0; dg = 0; // salida esperada: ab=1, bb=1, cb=1, db=1
        #10; ag = 0; bg = 1; cg = 0; dg = 0; // salida esperada: ab=0, bb=1, cb=1, db=1
        #10; ag = 1; bg = 1; cg = 0; dg = 0; // salida esperada: ab=1, bb=0, cb=1, db=1
        #10; ag = 0; bg = 0; cg = 1; dg = 0; // salida esperada: ab=0, bb=0, cb=1, db=1
        #10; ag = 1; bg = 0; cg = 1; dg = 0; // salida esperada: ab=1, bb=1, cb=0, db=1
        #10; ag = 0; bg = 1; cg = 1; dg = 0; // salida esperada: ab=0, bb=1, cb=0, db=1
        #10; ag = 1; bg = 1; cg = 1; dg = 0; // salida esperada: ab=1, bb=0, cb=1, db=1
        #10; ag = 0; bg = 0; cg = 0; dg = 1; // salida esperada: ab=0, bb=0, cb=0, db=1 
        #10; ag = 1; bg = 0; cg = 0; dg = 1; // salida esperada: ab=1, bb=1, cb=1, db=0
        #10; ag = 0; bg = 1; cg = 0; dg = 1; // salida esperada: ab=0, bb=1, cb=1, db=0
        #10; ag = 1; bg = 1; cg = 0; dg = 1; // salida esperada: ab=1, bb=0, cb=1, db=0
        #10; ag = 0; bg = 0; cg = 1; dg = 1; // salida esperada: ab=0, bb=0, cb=1, db=0 
        #10; ag = 1; bg = 0; cg = 1; dg = 1; // salida esperada: ab=1, bb=1, cb=0, db=0
        #10; ag = 0; bg = 1; cg = 1; dg = 1; // salida esperada: ab=0, bb=1, cb=0, db=0
        #10; ag = 1; bg = 1; cg = 1; dg = 1; // salida esperada: ab=1, bb=0, cb=1, db=0


        
        $finish;
    end
	
    initial begin
    $dumpfile("decoder_tb.vcd");
    $dumpvars(0,decoder_tb);
    end

endmodule

module module_leds_tb;

    logic [3:0] binario;
    logic [3:0] led;

    module_leds uut (
        .binario(binario),
        .led(led)
    );

    initial begin

        binario = 4'b0000;
        #10;
        $display(led[3], led[2], led[1], led[0]);
        binario = 4'b0001;
       #10;  
       $display(led[3], led[2], led[1], led[0]);
        binario = 4'b0010;
        #10;  
        $display(led[3], led[2], led[1], led[0]);
        binario = 4'b0011;
        #10;  
        $display(led[3], led[2], led[1], led[0]);
        binario = 4'b0100;
        #10;  
        $display(led[3], led[2], led[1], led[0]);
        binario = 4'b0101;
        #10;  
        $display(led[3], led[2], led[1], led[0]);
        binario = 4'b0110;
        #10;  
        $display(led[3], led[2], led[1], led[0]);
        binario = 4'b0111;
        #10;  
        $display(led[3], led[2], led[1], led[0]);
        binario = 4'b1000;
        #10;  
        $display(led[3], led[2], led[1], led[0]);
        binario = 4'b1001;
        #10;  
        $display(led[3], led[2], led[1], led[0]);
        binario = 4'b1010;
        #10;  
        $display(led[3], led[2], led[1], led[0]);
        binario = 4'b1011;
        #10;  
        $display(led[3], led[2], led[1], led[0]);
        binario = 4'b1100;
        #10;  
        $display(led[3], led[2], led[1], led[0]);
        binario = 4'b1101;
        #10;  
        $display(led[3], led[2], led[1], led[0]);
        binario = 4'b1110;
        #10;  
        $display(led[3], led[2], led[1], led[0]);
        binario = 4'b1111;
        #10;  
        $display(led[3], led[2], led[1], led[0]);
        

        $finish;
    end


    initial begin
        $dumpfile("module_leds_tb.vcd");
        $dumpvars(0, module_leds_tb);
    end


endmodule

module module_seg_tb;

    // Declaracion de las señales para el testbench.
    logic clk;
    logic rst;
    logic A, B, C, D;
    logic au, bu, cu, du, eu, fu, gu;
    logic ad, bd, cd, dd, ed, fd, gd;

    // Declaracion de las instancias para el testbench, unidad bajo prueba "uut".
    module_seg uut (
        .clk(clk),
        .rst(rst),
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

    // Establecer el sistema del reloj, cada periodo es igual a 10 unidades de tiempo.
    always begin

        clk = 1; 
        #5;
        clk = 0;
        #5;

    end

    // Inicio de la prueba del modulo.
    initial begin

        // Valores iniciales de la prueba.
        rst = 1;
        A = 0;
        B = 0;
        C = 0;
        D = 0;

        // Cambio en el valor de rst, tras 10 unidades de tiempo.
        #10;
        rst = 0;

        // Cambio en los valores de entrada iniciales, cada 10 unidades de tiempo.
        // Primer cambio 
        #10;
        A = 0;
        B = 1;
        C = 1;
        D = 0;

        // Segundo cambio
        #10;
        A = 1;
        B = 0;
        C = 1;
        D = 0;

        // Tercer cambio
        #10;
        A = 1;
        B = 1;
        C = 0;
        D = 0;

        // Finalizacion de la prueba
        #10;
        $finish;
        
    end

    // Sistema de guardado de los resultados del testbench.
    initial begin

        $dumpfile("module_seg_tb.vcd");
        $dumpvars(0,module_seg_tb);

    end 

endmodule