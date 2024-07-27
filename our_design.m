clc;
clear all
close all
format long

X=0;
Y=0;
temp=0;
nRED=0.0;
for i=1:255
    for j=1:255
        r=eightxeight(i,j);
        %disp(r);
        if(r>temp)
            temp=r;
        end
        M=i*j;
        if(M~=r)
            X=X+1;
        end
        ED=abs(r-M);
        Y=Y+ED;
        RED=ED/M;
        nRED=nRED+RED;
    end
end

MRED=nRED/65536;
disp(MRED);
MED=Y/65536;
NMED=MED/temp; % (54670 is the max ouput of out app multiplier)
disp(NMED);
disp(X*100/65536); %(ER PERCENTAGE)
disp(temp);

function r=eightxeight(a,b)
        a=de2bi(a,8); 
        b=de2bi(b,8);
        al=a(1:4);
        ah=a(5:8);
        bl=b(1:4);
        bh=b(5:8);
        p1=our_mul(al,bl);
        p2=our_mul(ah,bl);
        p3=mul_4_1(al,bh);
        p4=mul_4_1(ah,bh);
        r(1)=p1(1);
        r(2)=p1(2);
        r(3)=p1(3);
        r(4)=p1(4);
        [r(5),c1]= fa(p1(5),p2(1),p3(1));
        [s1,c2]= fa(p1(6),p2(2),p3(2));
        [s2,c3]= fa(p1(7),p2(3),p3(3));
        [s3,c4]= fa(p1(8),p2(4),p3(4));
        [s4,c5]= fa(p2(5),p3(5),p4(1));
        [s5,c6]= fa(p2(6),p3(6),p4(2));
        [s6,c7]= fa(p2(7),p3(7),p4(3));
        [s7,c8]= fa(p2(8),p3(8),p4(4));

        [r(6),c9]= ha(s1,c1);
        [r(7),c10]= fa(s2,c2,c9);
        [r(8),c11]= fa(s3,c3,c10);
        [r(9),c12]= fa(s4,c4,c11);
        [r(10),c13]= fa(s5,c5,c12);
        [r(11),c14]= fa(s6,c6,c13);
        [r(12),c15]= fa(s7,c7,c14);
        [r(13),c16]= fa(p4(5),c8,c15);
        [r(14),c17]=ha(p4(6),c16);
        [r(15),c18]=ha(p4(7),c17);
        r(16)=bitxor(p4(8),c18);
        r=bi2de(r);
        
end


function [sum,carry]= ha(a,b)
if(a==0&&b==0)
    sum=0;
    carry=0;
elseif(a==0&&b==1)
    sum=1;
    carry=0;
elseif(a==1&&b==0)
    sum=1;
    carry=0;
elseif(a==1&&b==1)
    sum=0;
    carry=1;
end       
end


function [sum,carry]= ha_approx(a,b)
if(a==0&&b==0)
    sum=0;
    carry=0;
elseif(a==0&&b==1)
    sum=1;
    carry=0;
elseif(a==1&&b==0)
    sum=1;
    carry=0;
elseif(a==1&&b==1)
    sum=1;
    carry=1;
end       
end

function [sum,carry]= fa(a,b,c)
if(a==0&&b==0&&c==0)
    sum=0;
    carry=0;
elseif(a==0&&b==0&&c==1)
    sum=1;
    carry=0;
elseif(a==0&&b==1&&c==0)
    sum=1;
    carry=0;
elseif(a==0&&b==1&&c==1)
    sum=0;
    carry=1;
elseif(a==1&&b==0&&c==0)
    sum=1;
    carry=0;
elseif(a==1&&b==0&&c==1)
    sum=0;
    carry=1;
elseif(a==1&&b==1&&c==0)
    sum=0;
    carry=1;
elseif(a==1&&b==1&&c==1)
    sum=1;
    carry=1;
end   
end

function [sum,carry]=app_comp(a,b,c,d)
if(a==0&&b==0&&c==0&&d==0)
    sum=0;
    carry=0;
elseif(a==0&&b==0&&c==0&&d==1)
    sum=1;
    carry=0;
elseif(a==0&&b==0&&c==1&&d==0)
    sum=1;
    carry=0;
elseif(a==0&&b==0&&c==1&&d==1)
    sum=1;
    carry=1;
elseif(a==0&&b==1&&c==0&&d==0)
    sum=1;
    carry=0;
elseif(a==0&&b==1&&c==0&&d==1)
    sum=1;
    carry=0;
elseif(a==0&&b==1&&c==1&&d==0)
    sum=1;
    carry=0;
elseif(a==0&&b==1&&c==1&&d==1)
    sum=1;
    carry=1;
elseif(a==1&&b==0&&c==0&&d==0)
    sum=1;
    carry=0;
elseif(a==1&&b==0&&c==0&&d==1)
    sum=1;
    carry=0;
elseif(a==1&&b==0&&c==1&&d==0)
    sum=1;
    carry=0;
elseif(a==1&&b==0&&c==1&&d==1)
    sum=1;
    carry=1;
elseif(a==1&&b==1&&c==0&&d==0)
    sum=1;
    carry=1;
elseif(a==1&&b==1&&c==0&&d==1)
    sum=1;
    carry=1;
elseif(a==1&&b==1&&c==1&&d==0)
    sum=1;
    carry=1;
elseif(a==1&&b==1&&c==1&&d==1)
    sum=1;
    carry=1;    
end

end
function [sum,carry]= fa_approx(a,b,cin)
   carry = (a&b)|(b&cin)|(cin&a);
   sum=~carry;
end
function p=mul_4_1(a,b)
     p(1)=a(1)& b(1);
     [p(2),c1]=ha(bitand(a(1),b(2)),bitand(a(2),b(1)));
     pp20=bitand(a(3),b(1));
     pp02=bitand(a(1),b(3));
     P20=bitor(pp20,pp02);
     G20=bitand(pp20,pp02);
     [p(3),c2]= app_comp(P20,G20,bitand(a(2),b(2)),c1);
     pp21=bitand(a(3),b(2));
     pp12=bitand(a(2),b(3));
     P21=bitor(pp21,pp12);
     G21=bitand(pp21,pp12);
     pp30=bitand(a(4),b(1));
     pp03=bitand(a(1),b(4));
     P30=bitor(pp30,pp03);
     G30=bitand(pp30,pp03);
     [p(4),c3]=app_comp(P21,P30,bitor(G21,G30),c2);
     pp31=bitand(a(4),b(2));
     pp13=bitand(a(2),b(4));
     P31=bitor(pp31,pp13);
     G31=bitand(pp31,pp13);
     [p(5),c4]=app_comp(P31,G31,bitand(a(3),b(3)),c3);
     pp23=bitand(a(3),b(4));
     pp32=bitand(a(4),b(3));
     [p(6),c5]=fa(pp23,pp32,c4);
     pp33=bitand(a(4),b(4));
     [p(7),p(8)]=ha(pp33,c5);
end
function p=our_mul(a,b)
     p(1)=a(1)& b(1);
     [p(2),c1]=ha_approx(bitand(a(1),b(2)),bitand(a(2),b(1)));
     pp20=bitand(a(3),b(1));
     pp02=bitand(a(1),b(3));
     %P20=bitor(pp20,pp02);
     %G20=bitand(pp20,pp02);
     [p(3),c2]= fa_approx(pp20,pp02,bitand(a(2),b(2)));
     pp21=bitand(a(3),b(2));
     pp12=bitand(a(2),b(3));
     P21=bitor(pp21,pp12);
     G21=bitand(pp21,pp12);
     pp30=bitand(a(4),b(1));
     pp03=bitand(a(1),b(4));
     P30=bitor(pp30,pp03);
     G30=bitand(pp30,pp03);
     [p(4),c3]=app_comp(P21,P30,bitor(G21,G30),c2);
     pp31=bitand(a(4),b(2));
     pp13=bitand(a(2),b(4));
     P31=bitor(pp31,pp13);
     G31=bitand(pp31,pp13);
     [p(5),c4]=app_comp(P31,G31,bitand(a(3),b(3)),c3);
     pp23=bitand(a(3),b(4));
     pp32=bitand(a(4),b(3));
     [p(6),c5]=fa(pp23,pp32,c4);
     pp33=bitand(a(4),b(4));
     [p(7),p(8)]=ha(pp33,c5);
end




