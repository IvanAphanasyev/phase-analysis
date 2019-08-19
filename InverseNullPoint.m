%% Analys null point of inverse filter second order
global N; N = 91; %Counts of Fc for low or high filts
global points; points = 100; %Counts calulated points for filters any type
global wc; wc = linspace(0.05,0.95,N)';

string = "low";
rs = 5; 
for i = 24%: length(wc)
    [a, b] = cheby2(2,rs,wc(i),string);
    [h,w]=freqz(a,b,points);
%function abs from hn
    amn=abs(h);
%function angle grom hn (atan2(imag(h), real(h))
    phan=angle(h);
    
    indexWo = GetPoints(amn, min(amn));
    wo = w(indexWo)/pi;
    right = wo * 1.01;
    left = wo * 0.99;
    range = linspace(left,right,10000);
    w = range*pi;

    for j=1:length(w)
        ampNum(j)=a(2)+2*a(1)*cos(w(j));
        ampDenum1(j)=(1-b(3))^2+b(2)^2;
        ampDenum2(j)=2*b(2)*(1+b(3))*cos(w(j));
        ampDenum3(j)=4*b(3)*(cos(w(j)))^2;
        amp2(j)=(ampNum(j))^2/(ampDenum1(j)+ampDenum2(j)+ampDenum3(j));
        amp_wc(j)=sqrt(amp2(j));
        clear ampNum; clear ampDenum1; clear ampDenum2; clear ampDenum3; clear amp2;
    end
    for j=1:length(w)
        phaseNum1(j)=(1-b(3))*sin(w(j));
        phaseNum2(j)=a(2)+2*a(1)*cos(w(j));
        phaseDenum1(j)=a(2)*b(2);
        phaseDenum2(j)=(2*a(1)*b(2)+a(2)*(1+b(3)))*cos(w(j));
        phaseDenum3(j)=(2*a(1)*(1+b(3)))*(cos(w(j)))^2;
        phase_wc(j)=atan2((-(phaseNum1(j)*phaseNum2(j))),(phaseDenum1(j)+phaseDenum2(j)+phaseDenum3(j)));
        clear phaseNum1; clear phaseNum2; clear phaseDenum1; clear phaseDenum2; clear phaseDenum3;
    end

    figure;
    subplot(2,1,1);
    plot(w/pi,amp_wc);
    grid;
    subplot(2,1,2);
    plot(w/pi,phase_wc);
    grid;

    indexWo = GetPoints(amp_wc,  min(amp_wc));
    wo = w(indexWo)/pi;
    mins(i) =  min(amp_wc);
    point(i) = phase_wc(indexWo);

end
% % 
% figure;
% subplot(2,1,1);
% grid;
% plot(wc,point);
% subplot(2,1,2);
% plot(wc,mins);
% grid;




