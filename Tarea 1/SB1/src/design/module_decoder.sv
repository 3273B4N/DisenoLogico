module decoder (input logic ag, bg, cg, dg, output logic ab, bb, cb, db);
    assign ab = ag;
    assign bb = (ag ^ bg);
    assign cb = ((ag ^ bg) ^ cg);
    assign db = (((ag ^ bg) ^ cg) ^ dg);
endmodule

