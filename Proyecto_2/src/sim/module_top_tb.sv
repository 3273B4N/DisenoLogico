module module_top_tb (
    ports
);



    // Sistema de guardado de los resultados del testbench.
    initial begin

        $dumpfile("module_top_tb.vcd");
        $dumpvars(0,module_top_tb);

    end   
endmodule