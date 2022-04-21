
%16-Qam madulation and demadulation and detector

clear all
close all
clc
M=160;
numoferr=0;
l=1;
data=randint(1,M);
for i=1:M/4
    for j=1:4
        data_k(i,j)=data(l);
        l=l+1;
    end
end


symbol=bi2de(data_k,'left-msb');


for i=1:M/4
    
    if (symbol(i)==0)
        r(i)=(-3+3i);
    elseif (symbol(i)==1)
        r(i)=(-1+3i);
    elseif (symbol(i)==2)
        r(i)=(3+3i);
    elseif  (symbol(i)==3)
        r(i)=(1+3i);
    elseif   (symbol(i)==4)
        r(i)=(1+i);
    elseif    (symbol(i)==5)
        r(i)=(-1+i);
    elseif    (symbol(i)==6)
        r(i)=(3+i);
    elseif   (symbol(i)==7)
        r(i)=(-3+i);
    elseif    (symbol(i)==8)
        r(i)=(3-i);
    elseif   (symbol(i)==9)
        r(i)=(-1-3i);
    elseif   (symbol(i)==10)
        r(i)=(1-i);
    elseif   (symbol(i)==11)
        r(i)=(-3-3i);
    elseif    (symbol(i)==12)
        r(i)=(3-3i);
    elseif    (symbol(i)==13)
        r(i)=(1-3i);
    elseif    (symbol(i)==14)
        r(i)=(-1-i);
    elseif     (symbol(i)==15)
        r(i)=(-3-i);
    end


a=real(r(i));
b=imag(r(i));



if a<-2,b>2
    decis(i)=0;
elseif -2<a<0,b>2
    decis(i)=1;
elseif 0<a<2,b>2
    decis(i)=3;
elseif  a>2,b>2
    decis(i)=2;
elseif  a>2,0<b<2
    decis(i)=6;
elseif  0<a<2,0<b<2
    decis(i)=4;
elseif -2<a<0,0<b<2
    decis(i)=5;
elseif  a<-2,0<b<2
    decis(i)=7;
elseif a<-2,-2<b<0
    decis(i)=15;
elseif -2<a<0,-2<b<0
    decis(i)=14;
elseif 0<a<2,-2<b<0
    decis(i)=10;
elseif  a>2,-2<b<0
    decis(i)=8;
elseif  a>2,b<-2
    decis(i)=12;
elseif  0<a<2,b<-2
    decis(i)=13;
elseif  0<a<-2,b<-2
    decis(i)=9;
elseif a<-2,b<-2
    decis(i)=11;
end

end

