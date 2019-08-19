%% chebeshev2
close all;
global N; N = 91; %Counts of Fc for low or high filts
global points; points = 100; %Counts calulated points for filters any type
global wc; wc = linspace(0.05,0.95,N)';

string = "low";

%% Check const rs, variable wc => phi(wc, rs) = const
rs = 5;
for i = 1:length(wc)
    [a, b] = cheby2(2,rs,wc(i),string);
    [h,w]=freqz(a,b,points);
    %function abs from hn
    amn=abs(h);
    %function angle grom hn (atan2(imag(h), real(h))
    phan=angle(h);
    
    calculatedAmp_wc(:,i) = amn;
    calculatedPhase_wc(:,i) = phan;
    clear amn; clear phan;
    %Equation amlifier friquency char
    for j=1:length(w)
        ampNum(j)=a(2)+2*a(1)*cos(w(j));
        ampDenum1(j)=(1-b(3))^2+b(2)^2;
        ampDenum2(j)=2*b(2)*(1+b(3))*cos(w(j));
        ampDenum3(j)=4*b(3)*(cos(w(j)))^2;
        amp2(j)=(ampNum(j))^2/(ampDenum1(j)+ampDenum2(j)+ampDenum3(j));
        amp_wc(j,i)=sqrt(amp2(j));
        clear ampNum; clear ampDenum1; clear ampDenum2; clear ampDenum3; clear amp2;
    end
    
    %Equation phase friquency char
    for j=1:length(w)
        phaseNum1(j)=(1-b(3))*sin(w(j));
        phaseNum2(j)=a(2)+2*a(1)*cos(w(j));
        phaseDenum1(j)=a(2)*b(2);
        phaseDenum2(j)=(2*a(1)*b(2)+a(2)*(1+b(3)))*cos(w(j));
        phaseDenum3(j)=(2*a(1)*(1+b(3)))*(cos(w(j)))^2;
        phase_wc(j,i)=atan2((-(phaseNum1(j)*phaseNum2(j))),(phaseDenum1(j)+phaseDenum2(j)+phaseDenum3(j)));
        clear phaseNum1; clear phaseNum2; clear phaseDenum1; clear phaseDenum2; clear phaseDenum3;
    end
end
clear i; clear j;
numberGraphShow = GetStrip(0.28,'lh');% What a graph will shown;
drawAmpAmpPhase(calculatedAmp_wc(:,numberGraphShow),amp_wc(:,numberGraphShow),phase_wc(:,numberGraphShow),wc(numberGraphShow,:),[1,rs],3,'low');%%%%%
stop
for i = 1: size(amp_wc,2)
    index = GetPoints(amp_wc(:,i), 1/(sqrt(10^(0.1*rs))));%%%%%
    PhaseFc(i) = phase_wc(index,i);
end
DrawPhs(PhaseFc, 'wc',rs);
% Check wc and wo
for i = 1 : size(amp_wc,2)
    indexWc = GetPoints(amp_wc(:,i), 1/(sqrt(10^(0.1*rs))));%%%%%
    indexWo = GetPoints(amp_wc(:,i), min(amp_wc(:,i)));%%%%%
    ampWc(i) = amp_wc(indexWc,i); %Amplifier on wc
    ampWo(i) = amp_wc(indexWo,i); %Amplifier on wo
    phaseWc(i) = phase_wc(indexWc,i); %Phase on wc
    phaseWo(i) = phase_wc(indexWo,i); %Phase on wo
    wo(i) = w(indexWo)/pi; % Wo in dependency from wc
end
dw_wc = drawWcWoPhase(wc,wc,wo,phaseWc,phaseWo, 'rs = const, wc = variable','wc'); %%%%%

set(0,'DefaultAxesFontSize',14,'DefaultAxesFontName','Calibri');
figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
subplot(2,1,1);
plot(w/pi, amp_wc);
title(strcat('amp pool; rs = const, wc = variable, rs:',sprintf('%.0f',rs)));
subplot(2,1,2);
plot(w/pi, phase_wc);
title(strcat('phase pool; rs = const, wc = variable, rs:', sprintf('%.0f',rs)));

%% Check const wc, const rs => phi(wc, rs) = variable
wc = 0.34; rs = (1:91);
for i = 1:length(rs)
    [a, b] = cheby2(2,rs(i),wc,string);
    [h,w]=freqz(a,b,points);
    %function abs from hnc
    amn=abs(h);
    %function angle grom hn (atan2(imag(h), real(h))
    phan=angle(h);
    
    calculatedAmp_rs(:,i) = amn;
    calculatedPhase_rs(:,i) = phan;
    clear amn; clear phan;
    %Equation amlifier friquency char
    for j=1:length(w)
        ampNum(j)=a(2)+2*a(1)*cos(w(j));
        ampDenum1(j)=(1-b(3))^2+b(2)^2;
        ampDenum2(j)=2*b(2)*(1+b(3))*cos(w(j));
        ampDenum3(j)=4*b(3)*(cos(w(j)))^2;
        amp2(j)=(ampNum(j))^2/(ampDenum1(j)+ampDenum2(j)+ampDenum3(j));
        amp_rs(j,i)=sqrt(amp2(j));
        clear ampNum; clear ampDenum1; clear ampDenum2; clear ampDenum3; clear amp2;
    end
    
    %Equation phase friquency char
    for j=1:length(w)
        phaseNum1(j)=(1-b(3))*sin(w(j));
        phaseNum2(j)=a(2)+2*a(1)*cos(w(j));
        phaseDenum1(j)=a(2)*b(2);
        phaseDenum2(j)=(2*a(1)*b(2)+a(2)*(1+b(3)))*cos(w(j));
        phaseDenum3(j)=(2*a(1)*(1+b(3)))*(cos(w(j)))^2;
        phase_rs(j,i)=atan2((-(phaseNum1(j)*phaseNum2(j))),(phaseDenum1(j)+phaseDenum2(j)+phaseDenum3(j)));
        clear phaseNum1; clear phaseNum2; clear phaseDenum1; clear phaseDenum2; clear phaseDenum3;
    end
end
clear i; clear j;
rsForGraph = 8;
drawAmpAmpPhase(calculatedAmp_rs(:,rsForGraph),amp_rs(:,rsForGraph),phase_rs(:,rsForGraph),wc,[1,rsForGraph],3,'low');%%%%%
for i = 1:length(rs)
    index = GetPoints(amp_rs(:,i), 1/(sqrt(10^(0.1*rs(i)))));%%%%%
    PhaseFc(i) = phase_rs(index,i);
end
DrawPhs(PhaseFc, 'rs',wc);

for i = 1 : length(rs)
    indexWc = GetPoints(amp_rs(:,i), 1/(sqrt(10^(0.1*rs(i)))));%%%%%
    indexWo = GetPoints(amp_rs(:,i), min(amp_rs(:,i)));%%%%%
    ampWc(i) = amp_rs(indexWc,i); %Amplifier on wc
    ampWo(i) = amp_rs(indexWo,i); %Amplifier on wo
    phaseWc(i) = phase_rs(indexWc,i); %Phase on wc
    phaseWo(i) = phase_rs(indexWo,i); %Phase on wo
    wo(i) = w(indexWo)/pi; % Wo in dependency from wc
    pool_wc(i) = w(indexWc)/pi;
end
dw_rs = drawWcWoPhase(rs,pool_wc,wo,phaseWc,phaseWo, 'rs = var, wc = const','rs'); %%%%%

figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
subplot(2,1,1);
plot(w/pi, amp_rs);
title(strcat('amp pool; rs = var, wc = const, wc:',sprintf('%.2f',wc)));
subplot(2,1,2);
plot(w/pi, phase_rs);
title(strcat('phase pool; rs = var, wc = const, wc:',sprintf('%.2f',wc)));
