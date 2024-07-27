module mul_4(
    input [3:0] a,b,
    output [7:0] pro
    );
    wire [5:1]P;//??,? = ???,? + ???,?
    wire [5:1]G;//??,? = ???,? . ???,?
    wire [7:1]C;
    assign P[1]= (a[2]&b[0])|(a[0]&b[2]);//P(2,0)
    assign G[1]= (a[2]&b[0])&(a[0]&b[2]);//G(2,0)
    assign P[2]= (a[2]&b[1])|(a[1]&b[2]);//P(2,1)
    assign G[2]= (a[2]&b[0])&(a[0]&b[2]);//G(2,1)
    assign P[3]= (a[3]&b[0])|(a[0]&b[3]);//P(3,0)
    assign G[3]= (a[3]&b[0])&(a[0]&b[3]);//G(3,0)
    assign P[4]= (a[3]&b[1])|(a[1]&b[3]);//P(3,1)
    assign G[4]= (a[3]&b[1])&(a[1]&b[3]);//G(3,1)
    
    assign pro[0]= a[0]&b[0];
    ha_df ha1((a[1]&b[0]),(a[0]&b[1]),pro[1],C[1]);
    
    ac1 a1(P[1],G[1],a[1]&b[1],C[1],pro[2],C[2]);
    ac1 a2(P[2],P[3],G[2]|G[3],C[2],pro[3],C[3]);
    ac1 a3(P[4],G[4],a[2]&b[2],C[3],pro[4],C[4]);
    fa_df fa1((a[3]&b[2]),(a[2]&b[3]),C[4],pro[5],C[5]);
    ha_df ha2(a[3]&b[3],C[5],pro[6],pro[7]);
    /*
    assign pro[2]=P[1]|(a[1]&b[1]);
    assign C[2]=G[1]|C[1];
    assign pro[3]=C[2]|P[2]|P[3];
    assign C[3]=C[2]&(G[2]|G[3])|P[2]&P[3];
    assign pro[4]= P[4]|G[4]|(a[2]&b[2]);
    assign C[4]= G[3]|((a[2]&b[2])|C[3]);
*/
endmodule
