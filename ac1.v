module ac1(
    input x1,x2,x3,x4,
    output s,c
    );
    assign s= (x1|x2)|(x3|x4);
    assign c= (x1&x2)|(x3&x4);
    endmodule
