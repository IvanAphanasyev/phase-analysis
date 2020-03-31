
clc; clear all; close all;
xmin=0.05; 
xmax=0.95;
N=73; 
ws=linspace(xmin,xmax,N);
p=2; 
RP=10.0;
RS=10.0;
Ws=0.7;
CRP=1/sqrt(10^(0.1*RP));
%CRS1/sqrt(10^(0.1*RS));
%
%for i=1:length(ws)
    [apc1,bpc1]=cheby1(p,RP,Ws,'low'); 
    Kap(4)=apc1(1); 
    Kap(5)=apc1(2);
    Kap(6)=apc1(3); 
%
    Kbp(4)=bpc1(1);
    Kbp(5)=bpc1(2); 
    Kbp(6)=bpc1(3); 
%end
%%ws(37)=0.5, 45=0.6
%ws(13)=0.2;(29)=0.4;(45)=0.6;(61)=0.8
%Ka=1=butt;4=cheb1;7=cheb2;10=ell
%Kb=1=butt;4=cheb1;7=cheb2;10=ell

% TF=4;
% an=[Kap(TF) Kap(TF+1) Kap(TF+2)];
% bn=[Kbp(TF) Kbp(TF+1) Kbp(TF+2)];
% [hn,w]=freqz(an,bn,100);
% amn=abs(hn);
% phan=angle(hn);
% 
% for i=1:length(w)
%     amnP(i)=1/(sqrt(10^(0.1*RP)));
%     amnS(i)=1/(sqrt(10^(0.1*RS)));
% end
% %
% %ACH
% for i=1:length(w)
%     C1(i)=an(2)+2*an(1)*cos(w(i));
%     Z1(i)=(1-bn(3))^2+bn(2)^2;
%     Z2(i)=2*bn(2)*(1+bn(3))*cos(w(i));
%     Z3(i)=4*bn(3)*(cos(w(i)))^2;
%     H2(i)=(C1(i))^2/(Z1(i)+Z2(i)+Z3(i));
%     H2Q(i)=sqrt(H2(i));
% end
% %FCH
% for i=1:length(w)
%     CF1(i)=(1-bn(3))*sin(w(i));
%     CF2(i)=an(2)+2*an(1)*cos(w(i));
%     ZF1(i)=an(2)*bn(2);
%     ZF2(i)=(2*an(1)*bn(2)+an(2)*(1+bn(3)))*cos(w(i));
%     ZF3(i)=(2*an(1)*(1+bn(3)))*(cos(w(i)))^2;
%     %TA0(i)=(-(CF1(i)*CF2(i)))/(ZF1(i)+ZF2(i)+ZF3(i));
%     F3(i)=atan2((-(CF1(i)*CF2(i))),(ZF1(i)+ZF2(i)+ZF3(i)));
% end
% figure(1)
% subplot(2,1,1)
% plot(w/pi,amn,w/pi,amnP,w/pi,amnS,w/pi,H2Q)
% grid  
% subplot(2,1,2)
% plot(w/pi,phan,w/pi,F3)
% grid 
% %
% damn=diff(amn);damn(100)=damn(99);
% figure(2)
% plot(w/pi,amn,w/pi,amnP,w/pi,damn)
% %amnS,w/pi,H2Q)
% grid
% ch1=1-bn(3);
% ch2=1+bn(3);
% ch3=ch1^2+(bn(2))^2-bn(2)*ch2;
% zn=4*bn(3)-bn(2)*ch2;
% wp=acos(ch3/zn)/pi
for i=1:length(ws)
    [apc1,bpc1]=cheby1(p,RP,ws(i),'low'); % расчет коэффициентов "а" и "b"
    Kap(4)=apc1(1); %Первый столбик переменной Ka соответствует коэффициенту а1 cheby1
    Kap(5)=apc1(2); %Первый столбик переменной Ka соответствует коэффициенту а2 cheby1
    Kap(6)=apc1(3); %Первый столбик переменной Ka соответствует коэффициенту а2 cheby1

    Kbp(4)=bpc1(1); %Второй столбик переменной Kb соответствует коэффициенту b1 cheby1
    Kbp(5)=bpc1(2); %Второй столбик переменной Kb соответствует коэффициенту b2 cheby1
    Kbp(6)=bpc1(3); %Второй столбик переменной Kb соответствует коэффициенту b3 cheby1
    an=[Kap(4) Kap(5) Kap(6)];
    bn=[Kbp(4) Kbp(5) Kbp(6)];
    ch1=1-bn(3);
    ch2=1+bn(3);
    ch3=ch1^2+(bn(2))^2-bn(2)*ch2;
    zn=4*bn(3)-bn(2)*ch2;
    wp(i)=acos(ch3/zn)/pi;
    dwsp(i)=ws(i)-wp(i);
    ddwsp(i)=ws(i)/wp(i);
end
figure(3)
plot(ws,wp)
grid
figure(4)
plot(ws,dwsp)
grid
figure(5)
plot(ws,ddwsp)
grid

% wp model from excel... 0.4548x2 + 0.5223x + 0.0179
modelWp = 0.4548.*ws.*ws + 0.5223 .* ws + 0.0179;
modelWpError=sum((wp - modelWp).*(wp - modelWp))/length(ws)
figure(6);
hold on;
grid on;
plot(ws, [wp; modelWp]);
title(strcat('truth wp and model wp: 0.4548x2 + 0.5223x + 0.0179, error for that model: ', num2str(modelWpError)))
legend({'original','model'},'FontSize',12)
xlabel('ws','FontSize',12);

% dwsp model from excel... -0.4548x2 + 0.4777x - 0.0179
modelDwsp = -0.4548.*ws.*ws + 0.4777.*ws - 0.0179;
modelDwspError = sum((dwsp - modelDwsp).*(dwsp - modelDwsp))/length(ws)
figure(7);
hold on;
grid on;
plot(ws, [dwsp; modelDwsp]);
title(strcat('model dwsp: -0.4548x2 + 0.4777x - 0.0179, error: ', num2str(modelDwspError)))
legend({'truth','model'},'FontSize',12)
xlabel('ws','FontSize',12);

% second try for dwsp with: -0.2361x3 - 0.1007x2 + 0.3301x - 0.0031

secondModelDwsp = -0.2361.*ws.*ws.*ws - 0.1007.*ws.*ws + 0.3301.*ws - 0.0031;
secondModelDwspError = sum((dwsp - secondModelDwsp).*(dwsp - secondModelDwsp))/length(ws)

figure(8);
hold on;
grid on;
plot(ws, [dwsp; secondModelDwsp])
title(strcat('model from: -0.2361x3 - 0.1007x2 + 0.3301x - 0.0031, error: ', num2str(secondModelDwspError)));
legend({'truth','model'},'FontSize',12)
xlabel('ws', 'FontSize', 12);





