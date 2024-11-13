// Módulo Principal modificado
module MultiplicadorBooth(
    input clk,                          
    input rst,                       
    input valid,                         
    input signed [7:0] multiplicando,     
    input signed [7:0] multiplicador,     
    output signed [15:0] resultado,       
    output done                         
);
    // Declaración de señales internas
    wire [1:0] temp, sig_temp;
    wire [2:0] contador, sig_contador;
    wire sig_done, sig_estado, estado_actual;
    wire signed [15:0] sig_resultado;
    wire clear_output;

    // Instanciación de la Unidad de Control
    UnidadControl control(
        .clk(clk),
        .rst(rst),
        .valid(valid),
        .contador(contador),
        .estado_actual(estado_actual),
        .sig_estado(sig_estado),
        .sig_contador(sig_contador),
        .sig_done(sig_done),
        .clear_output(clear_output)
    );

    // Instanciación de la Ruta de Datos
    ALUMult ruta_datos(
        .clk(clk),
        .rst(rst),
        .valid(valid),
        .multiplicando(multiplicando),
        .multiplicador(multiplicador),
        .temp(temp),
        .contador(contador),
        .estado_actual(estado_actual),
        .resultado(resultado),
        .sig_temp(sig_temp),
        .sig_resultado(sig_resultado)
    );

    // Instanciación del Banco de Registros
    ShiftReg registros(
        .clk(clk),
        .rst(rst),
        .sig_resultado(sig_resultado),
        .sig_done(sig_done),
        .sig_estado(sig_estado),
        .sig_temp(sig_temp),
        .sig_contador(sig_contador),
        .clear_output(clear_output),
        .valid(valid),              // Nueva conexión
        .resultado(resultado),
        .done(done),
        .estado_actual(estado_actual),
        .temp(temp),
        .contador(contador)
    );

endmodule