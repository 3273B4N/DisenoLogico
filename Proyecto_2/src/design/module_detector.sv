// Este modulo recibe una señal externa y la decodifica de codigo gray a binario
module decoder (
    // valores de entrada provenientes de un switch en codigo de gray
    input logic ag, bg, cg, dg, 
    // Valores de salida en codigo binario
    output logic ab, bb, cb, db);
    assign ab = ag;
    assign bb = (ag ^ bg);
    assign cb = ((ag ^ bg) ^ cg);
    assign db = (((ag ^ bg) ^ cg) ^ dg);
endmodule