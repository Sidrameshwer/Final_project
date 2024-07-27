module mul_8_1(
    input [7:0] a,b,
    output [15:0] pro
    );
    wire [7:0]P1;
    wire [7:0]P2;
    wire [7:0]P3;
    wire [7:0]P4;
    wire [8:1]S;
    wire [18:1]C;
     
    mul_4 m1 (a[3:0],b[3:0],P1);
    mul_4 m2 (a[3:0],b[7:4],P2);
    mul_4 m3 (a[7:4],b[3:0],P3);
    mul_4 m4 (a[7:4],b[7:4],P4);
    
    assign pro[3:0]=P1[3:0];
    fa_df fa1 (P1[4],P2[0],P3[0],pro[4],C[1]);
    fa_df fa2 (P1[5],P2[1],P3[1],S[2],C[2]);
    fa_df fa3 (P1[6],P2[2],P3[2],S[3],C[3]);
    fa_df fa4 (P1[7],P2[3],P3[3],S[4],C[4]);
    fa_df fa5 (P2[4],P3[4],P4[0],S[5],C[5]);
    fa_df fa6 (P2[5],P3[5],P4[1],S[6],C[6]);
    fa_df fa7 (P2[6],P3[6],P4[2],S[7],C[7]);
    fa_df fa8 (P2[7],P3[7],P4[3],S[8],C[8]);
    
    //assign pro[4]=S[1];
    ha_df ha1 (S[2],C[1],pro[5],C[9]);
    fa_df fa9 (S[3],C[2],C[9],pro[6],C[10]);
    fa_df fa10 (S[4],C[3],C[10],pro[7],C[11]);
    fa_df fa11 (S[5],C[4],C[11],pro[8],C[12]);
    fa_df fa12 (S[6],C[5],C[12],pro[9],C[13]);
    fa_df fa13 (S[7],C[6],C[13],pro[10],C[14]);
    fa_df fa14 (S[8],C[7],C[14],pro[11],C[15]);
    fa_df fa15 (P4[4],C[8],C[15],pro[12],C[16]);
    
    ha_df ha2 (P4[5],C[16],pro[13],C[17]);
    ha_df ha3 (P4[6],C[17],pro[14],C[18]);
    //ha_df ha4 (P4[7],C[18],pro[15],C[19]);
    xor (pro[15],C[18],P4[7]);
endmodule
