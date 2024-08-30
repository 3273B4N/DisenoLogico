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