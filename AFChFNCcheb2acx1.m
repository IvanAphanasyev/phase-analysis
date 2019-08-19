%AFChFNCcheb2acx1(12072019)
clc; clear all; close all;
xmin=0.05; % ws от 0.05
xmax=0.95; % до 0.95
N=100; 
ws=linspace(xmin,xmax,N);
%AChX_FNC
p=2; %порядок фильтра
RP=3.0;
RS=1.0;
Ws=0.5
%CRP=1/sqrt(10^(0.1*RP));
CRS=1/sqrt(10^(0.1*RS));

%
%for i=1:length(ws)
    [apc2,bpc2]=cheby2(p,RS,Ws,'low'); % расчет коэффициентов "а" и "b"
    Kap(7)=apc2(1); %Третий столбик переменной Ka соответствует коэффициенту а1 cheby2
    Kap(8)=apc2(2); %Третий столбик переменной Ka соответствует коэффициенту а2 cheby2
    Kap(9)=apc2(3); %Третий столбик переменной Ka соответствует коэффициенту а3 cheby2
%
    Kbp(7)=bpc2(1); %Третий стобик переменной Кb соответствует коэффициенту b1 cheby2 
    Kbp(8)=bpc2(2); %Третий стобик переменной Кb соответствует коэффициенту b2 cheby2
    Kbp(9)=bpc2(3); %Третий стобик переменной Кb соответствует коэффициенту b3 cheby2
%end
%%ws(37)=0.5, 45=0.6
%ws(13)=0.2;(29)=0.4;(45)=0.6;(61)=0.8
%Ka=1=butt;4=cheb1;7=cheb2;10=ell
%Kb=1=butt;4=cheb1;7=cheb2;10=ell

TF=7;
an=[Kap(TF) Kap(TF+1) Kap(TF+2)];
bn=[Kbp(TF) Kbp(TF+1) Kbp(TF+2)];
[hn,w]=freqz(an,bn,100);
amn=abs(hn);
phan=angle(hn);

for i=1:length(w)
    amnP(i)=1/(sqrt(10^(0.1*RP)));
    amnS(i)=1/(sqrt(10^(0.1*RS)));
end
%
%ACH
for i=1:length(w)
    C1(i)=an(2)+2*an(1)*cos(w(i));
    Z1(i)=(1-bn(3))^2+bn(2)^2;
    Z2(i)=2*bn(2)*(1+bn(3))*cos(w(i));
    Z3(i)=4*bn(3)*(cos(w(i)))^2;
    H2(i)=(C1(i))^2/(Z1(i)+Z2(i)+Z3(i));
    H2Q(i)=sqrt(H2(i));
end
%ACH1
% C1=an(2)+2*an(1+);
% Z1=bn(1)+bn(2)+bn(3);
% C21=(C1/Z1)^2;
% C3=an(2)-2*an(1);C32=C3^2;
% Z3=bn(2)-(bn(1)+bn(3));Z32=Z3^2;
% C23=C32/Z32;
% C2=an(2)+2*an(1)*cos(Ws*pi);
% Z21=(bn(1)-bn(3))^2+bn(2)^2;
% Z22=2*bn(2)*(bn(1)+bn(3))*cos(Ws*pi);
% Z23=4*bn(3)*(cos(Ws*pi))^2;
% C22=C2^2/(Z21+Z22+Z23);
% [C21 C22 C23]

%FCH
for i=1:length(w)
    CF1(i)=(1-bn(3))*sin(w(i));
    CF2(i)=an(2)+2*an(1)*cos(w(i));
    ZF1(i)=an(2)*bn(2);
    ZF2(i)=(2*an(1)*bn(2)+an(2)*(1+bn(3)))*cos(w(i));
    ZF3(i)=(2*an(1)*(1+bn(3)))*(cos(w(i)))^2;
    %TA0(i)=(-(CF1(i)*CF2(i)))/(ZF1(i)+ZF2(i)+ZF3(i));
    F3(i)=atan2((-(CF1(i)*CF2(i))),(ZF1(i)+ZF2(i)+ZF3(i)));
%     ZF4(i)=bn(2)+(1+bn(3))*cos(w(i));
%     F4(i)=atan2((-CF1(i)),(ZF4(i)));
%     F4Pi(i)=atan2((-CF1(i)),(ZF4(i)))+pi;
%     CF10(i)=(-(CF1(i)*CF2(i)));
%     ZF10(i)=(ZF1(i)+ZF2(i)+ZF3(i));
%     CF20(i)=-CF1(i);
%     ZF20(i)=ZF4(i);
end
figure(1)
subplot(2,1,1)
plot(w/pi,amn,w/pi,amnP,w/pi,amnS,w/pi,H2Q)
grid  
subplot(2,1,2)
plot(w/pi,phan,w/pi,F3)
%,w/pi,F4,w/pi,F4Pi)
grid 
%
C1=bn(2)*(1-CRS);
C2=(1+bn(3))*(1+CRS);
A0=(C1+C2)/4;
%[an(1) A0]
%
C11=bn(2)*(1+CRS);
C12=(1+bn(3))*(1-CRS);
A1=(C11+C12)/2;
%[an(2) A1]
%
W0=acos(-an(2)/2/an(1))
W0ACX=W0/pi
% W0B=acos(bn(2)/(1+bn(3)))
% W0BACX=W0B/pi
%
CF01=(1-bn(3))*sin(W0);
CF02=an(2)+2*an(1)*cos(W0);
ZF01=an(2)*bn(2);
ZF02=(2*an(1)*bn(2)+an(2)*(1+bn(3)))*cos(W0);
ZF03=2*an(1)*(1+bn(3))*(cos(W0))^2;
CF00=(-CF01*CF02)/(ZF01+ZF02+ZF03)
% F0ACX=atan2((-CF01*CF02),(ZF01+ZF02+ZF03))
% F0=F0ACX*pi
%+
CF01=(1-bn(3))*sin(W0+0.1);
CF02=an(2)+2*an(1)*cos(W0+0.1);
ZF01=an(2)*bn(2);
ZF02=(2*an(1)*bn(2)+an(2)*(1+bn(3)))*cos(W0+0.1);
ZF03=2*an(1)*(1+bn(3))*(cos(W0+0.1))^2;
CF00P=(-CF01*CF02)/(ZF01+ZF02+ZF03)
%
CF01=(1-bn(3))*sin(W0-0.1);
CF02=an(2)+2*an(1)*cos(W0+0.1);
ZF01=an(2)*bn(2);
ZF02=(2*an(1)*bn(2)+an(2)*(1+bn(3)))*cos(W0+0.1);
ZF03=2*an(1)*(1+bn(3))*(cos(W0+0.1))^2;
CF00M=(-CF01*CF02)/(ZF01+ZF02+ZF03)
[W0 CF00 W0+0.1 CF00P W0-0.1 CF00M CF00P-CF00M]
stop
for i=1:40
    ki(i)=i;
    [apc2,bpc2]=cheby2(p,RS,ws(i),'low'); 
    Kapc(1)=apc2(1); 
    Kapc(2)=apc2(2); 
    Kapc(3)=apc2(3); 
    %
    Kbpc(1)=bpc2(1); 
    Kbpc(2)=bpc2(2); 
    Kbpc(3)=bpc2(3); 
    %
    TF=1;
    anc=[Kapc(TF) Kapc(TF+1) Kapc(TF+2)];
    bnc=[Kbpc(TF) Kbpc(TF+1) Kbpc(TF+2)];
    w0(i)=acos(-anc(2)/2/anc(1));
    CF001(i)=(1-bnc(3))*sin(w0(i));
    CF002(i)=anc(2)+2*anc(1)*cos(w0(i));
    ZF001(i)=anc(2)*bnc(2);
    ZF002(i)=(2*anc(1)*bnc(2)+anc(2)*(1+bnc(3)))*cos(w0(i));
    ZF003(i)=2*anc(1)*(1+bnc(3))*(cos(w0(i)))^2;
    CFF(i)=-(CF001(i)*CF002(i));
    ZFF(i)=ZF001(i)+ZF002(i)+ZF003(i);
    AF(i)=CFF(i)/ZFF(i);
    %F00ACX(i)=atan2(-(CF001(i)*CF002(i)),(ZF001(i)+ZF002(i)+ZF003(i)));
    %F00(i)=F00ACX(i)*pi;
%     W0I(i)=acos(-anc(2)/2/anc(1));
%     W0IACX(i)=W0I(i)/pi;
%     KW(i)=W0IACX(i)/w(i);
end
figure(2)
subplot(2,1,1)
plot(w(1:40),w0(1:40),w(1:40),w(1:40))
grid  
subplot(2,1,2)
plot(w(1:40),AF(1:40))
grid 

figure(3)
plot(w(1:40),CFF(1:40),w(1:40),ZFF(1:40))
grid  
% %
% figure(4)
% subplot(2,1,1)
% plot(ki,W0I,ki,w)
% grid  
% subplot(2,1,2)
% plot(ki,KW)
% grid 

stop
% %
% % A0=CRP*((1+bn(3))-bn(2))/4;
% % [an(1) A0]
% % stop
% %
% CF1=-(1-bn(3))*sin(Ws*pi);
% ZF1=bn(2)+(1+bn(3))*cos(Ws*pi);
% TA1=CF1/ZF1;
% TT=atan2(CF1,ZF1);
% %
% % CF10=(1-bn(3))*sin(Ws*pi);
% % CF20=an(2)+2*an(1)*cos(Ws*pi);
% % ZF10=an(2)*bn(2);
% % ZF20=(2*an(1)*bn(2)+an(2)*(1+bn(3)))*cos(Ws*pi);
% % ZF30=(2*an(1)*(1+bn(3)))*(cos(Ws*pi))^2;
% % TA0=-(CF10*CF20)/(ZF10+ZF20+ZF30);
% % TT30=atan2((-(CF10*CF20)),(ZF10+ZF20+ZF30));
% TG=tan(TT);
% %
% %[TA0 TT30 TA1 TT TG]
% [TA1 TT TG]
% %
% for i=1:100
%     RPC(i)=i/10;
%     [apc1,bpc1]=cheby1(p,RPC(i),Ws,'high'); % расчет коэффициентов "а" и "b"
%     Kap(7)=apc2(1); 
%     Kap(8)=apc2(2); 
%     Kap(9)=apc2(3); 
% %
%     Kbp(7)=bpc2(1);  
%     Kbp(8)=bpc2(2); 
%     Kbp(9)=bpc2(3); 
%     
%     %
%     TF=1;
%     anc=[Kapc(TF) Kapc(TF+1) Kapc(TF+2)];
%     bnc=[Kbpc(TF) Kbpc(TF+1) Kbpc(TF+2)];
%     CFC=-(1-bnc(3))*sin(Ws*pi);
%     ZFC=bnc(2)+(1+bnc(3))*cos(Ws*pi);
%     TAC(i)=CFC/ZFC;
%     TTC(i)=atan2(CFC,ZFC);
%     TTCPi1(i)=atan2(CFC,ZFC)+pi;
%     TACPi1(i)=tan(TTCPi1(i));
%     TTCpiM(i)=-pi/2;
%     TTCpiP(i)=pi/2;
% end
% figure(2)
% subplot(2,1,1)
% plot(RPC,TTC,RPC,TTCpiM)
% grid  
% subplot(2,1,2)
% plot(RPC,TAC)
% grid 
% %
% figure(3)
% plot(RPC(16:100),TAC(16:100))
% grid  
% %
% figure(4)
% plot(RPC(16:100),TTC(16:100),RPC(16:100),TTCpiM(16:100))
% grid  
% 
% %stop
% 
% % C1=(1+bn(3))*(1-(cos(Ws*pi/2))^2);
% % C2=2*cos(Ws*pi/2);
% % C3=4*bn(3)*(cos(Ws*pi/2))^2;
% % C4=(1-bn(3))^2;
% % Z1=(1+(cos(Ws*pi/2))^2);
% % %B11=(C1+C2*sqrt(C3-C4))/Z1;
% % B12=(C1-C2*sqrt(C3-C4))/Z1;
% % 
% % [bn(3) bn(2) B12]
% %
% %phi=-1.99602989766829;
% C1=(1+bn(3))*cos(Ws*pi);
% C2=(1-bn(3))*sin(Ws*pi)/TG;
% B10=-(C1+C2);
% 
% [bn(3) bn(2) B10]
% %
% %FF=tan(TT);
% CA1=CRP/4;
% CA2=(1+bn(3))*(1+cos(Ws*pi));
% CA3=(1-bn(3))*sin(Ws*pi)/TG;
% A0=CA1*(CA2+CA3);
% 
% [an(1) an(2) A0 -2*A0]
% 
% %
% % CAA1=4*A0^2*(1-cos(Ws*pi))^2;
% % ZAA1=(1-bn(3))^2+(bn(2))^2;
% % ZAA2=2*bn(2)*(1+bn(3))*cos(Ws*pi);
% % ZAA3=4*bn(3)*(cos(Ws*pi))^2;
% % CRPR2=CAA1/(ZAA1+ZAA2+ZAA3);
% % [CRP^2 CRPR2]
% %
% CB1=TG*sin(Ws*pi);
% CB2=1-cos(Ws*pi);
% CB3=2*sqrt(1+TG^2);
% B2M=(CB2+CB3+CB1)/(CB2+CB3-CB1);
% %B2P=(CB2+CB3-CB1)/(CB2+CB3+CB1);
% 
% [bn(3) B2M]
%     %B2P]
% %
% figure(5)
% subplot(2,1,1)
% plot(w/pi,CF10,w/pi,CF20)
% grid  
% subplot(2,1,2)
% plot(w/pi,ZF10,w/pi,ZF20)
% grid 
% %
% figure(6)
% plot(w/pi,F4,w/pi,F4Pi)
% grid  
% %
% TGF3=tan(F3);
% TGF4=tan(F4);
% TGF4Pi=tan(F4Pi);
% 
% figure(7)
% subplot(2,1,1)
% plot(w/pi,F3,w/pi,F4,w/pi,F4Pi)
% grid  
% subplot(2,1,2)
% plot(w/pi,TGF3,w/pi,TGF4,w/pi,TGF4Pi)
% grid 
% 
% figure(8)
% subplot(2,1,1)
% plot(RPC,TTC,RPC,TTCpiM,RPC,TTCPi1,RPC,TTCpiP)
% %,RPC,TTCpi)
% grid  
% subplot(2,1,2)
% plot(RPC,TAC,RPC,TACPi1)
% grid 
% 
% figure(9)
% plot(RPC(16:100),TAC(16:100),RPC(16:100),TACPi1(16:100))
% grid  
% %
% figure(10)
% plot(RPC(16:100),TTC(16:100),RPC(16:100),TTCPi1(16:100),RPC(16:100),TTCpiP(16:100),RPC(16:100),TTCpiM(16:100))
% grid  
% 
% figure(11)
% plot(RPC(16:100),TTCPi1(16:100),RPC(16:100),TTCpiP(16:100))
% grid  
% 
% 
