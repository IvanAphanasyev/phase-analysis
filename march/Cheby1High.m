clear all; close all;
% Length - 100; table values ??for low pass filter
table = [1.47768281575589,1.78746524288205,1.99602989766830,2.15511958316753,2.28340574022566,2.39011044757311,2.48060124311885,2.55834386597659,2.62574372794052,2.68456158087821,2.73613972521969,2.78153440733820,2.82159786547985,2.85703159125442,2.88842228001634,2.91626692650237,2.94099087073675,2.96296112477632,2.98249645500303,2.99987517946343,3.01534131983171,3.02910954355383,3.04136919859840,3.05228765461243,3.06201310422947,3.07067693694256,3.07839576908503,3.08527319302317,3.09140129399947,3.09686197240512,3.10172810140674,3.10606454398652,3.10992904901306,3.11337304254628,3.11644232791878,3.11917770603031,3.12161552560283,3.12378817176942,3.12572450023753,3.12745022332343,3.12898825335907,3.13035900829618,3.13158068375225,3.13266949524272,3.13363989390823,3.13450475866704,3.13527556738970,3.13596254940114,3.13657482135751,3.13712050831780,3.13760685162851,3.13804030506166,3.13842662048747,3.13877092422316,3.13907778507361,3.13935127496916,3.13959502300645,3.13981226361056,3.14000587945831,3.14017843973279,3.14033223421703,3.14046930367960,3.14059146695555,3.14070034508194,3.14079738280863,3.14088386776962,3.14096094756943,3.14102964501132,3.14109087166946,3.14114543998497,3.14119407404666,3.14123741919927,3.14127605060684,3.14131048088482,3.14134116690220,3.14136851584385,3.14139289061367,3.14141461465007,3.14143397621785,3.14145123223326,3.14146661167317,3.14148031861339,3.14149253493672,3.14150342274633,3.14151312651686,3.14152177501145,3.14152948299036,3.14153635273379,3.14154247539906,3.14154793223023,3.14155279563613,3.14155713015120,3.14156099329182,3.14156443631953,3.14156750492120,3.14157023981531,3.14157267729226,3.14157484969588,3.14157678585264,3.14157851145416];
points = 1000;
%% PICTURE 1
f = 0.6;
 [alb,blb] = butter(2,f,'high');
 [hl,w] = freqz(alb,blb,points);
 aml = abs(hl);
 for i=1:length(w)
    CF1(i)=(blb(2)*(alb(1)-alb(3))-alb(2)*(1-blb(3)))*sin(w(i));
    CF2(i)=(alb(1)*blb(3)-alb(3))*sin(2*w(i));
    IF(i)=CF1(i)+CF2(i);
    ZF1(i)=alb(1)+alb(2)*blb(2)+alb(3)*blb(3);
    ZF2(i)=(blb(2)*(alb(1)+alb(3))+alb(2)*(1+blb(3)))*cos(w(i));
    ZF3(i)=(alb(1)*blb(3)+alb(3))*cos(2*w(i));
    RF(i)=ZF1(i)+ZF2(i)+ZF3(i);
    F2(i)=atan2(IF(i),RF(i));    
 end
 % plot 1 picture
 figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
 subplot(2,1,1);
plot(w/pi,aml);
line([f f],[0 1],'Color','black');
line([0 1],[1/sqrt(2) 1/sqrt(2)],'Color','red');
title('PICTURE 1')%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
grid on;
subplot(2,1,2);
plot(w/pi,F2);
line([f f],[0 pi],'Color','black');
line([0 1],[pi/2 pi/2],'Color','red');
grid on;
%
%% picture 2
f = 0.6;
rp=3;
[alb,blb] = cheby1(2,rp,f,'high');
 [hl,w] = freqz(alb,blb,points);
 aml = abs(hl);
 for i=1:length(w)
    CF1(i)=(blb(2)*(alb(1)-alb(3))-alb(2)*(1-blb(3)))*sin(w(i));
    CF2(i)=(alb(1)*blb(3)-alb(3))*sin(2*w(i));
    IF(i)=CF1(i)+CF2(i);
    ZF1(i)=alb(1)+alb(2)*blb(2)+alb(3)*blb(3);
    ZF2(i)=(blb(2)*(alb(1)+alb(3))+alb(2)*(1+blb(3)))*cos(w(i));
    ZF3(i)=(alb(1)*blb(3)+alb(3))*cos(2*w(i));
    RF(i)=ZF1(i)+ZF2(i)+ZF3(i);
    F2(i)=atan2(IF(i),RF(i));    
 end
 % plot 2 picture
 figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
 subplot(2,1,1);
plot(w/pi,aml);
line([f f],[0 1],'Color','black');
line([0 1],[1/(sqrt(10^(0.1*rp))); 1/(sqrt(10^(0.1*rp)))],'Color','red');
title('PICTURE 2')%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
grid on;
subplot(2,1,2);
plot(w/pi,F2);
line([f f],[0 pi],'Color','black');
line([0 1],[table(rp) table(rp)],'Color','red');
grid on;
%
%% picture 3
f = 0.6;
rp=7;
[alb,blb] = cheby1(2,rp,f,'high');
 [hl,w] = freqz(alb,blb,points);
 aml = abs(hl);
 for i=1:length(w)
    CF1(i)=(blb(2)*(alb(1)-alb(3))-alb(2)*(1-blb(3)))*sin(w(i));
    CF2(i)=(alb(1)*blb(3)-alb(3))*sin(2*w(i));
    IF(i)=CF1(i)+CF2(i);
    ZF1(i)=alb(1)+alb(2)*blb(2)+alb(3)*blb(3);
    ZF2(i)=(blb(2)*(alb(1)+alb(3))+alb(2)*(1+blb(3)))*cos(w(i));
    ZF3(i)=(alb(1)*blb(3)+alb(3))*cos(2*w(i));
    RF(i)=ZF1(i)+ZF2(i)+ZF3(i);
    F2(i)=atan2(IF(i),RF(i));    
 end
 % plot 3 picture
 figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
 subplot(2,1,1);
plot(w/pi,aml);
line([f f],[0 1],'Color','black');
line([0 1],[1/(sqrt(10^(0.1*rp))); 1/(sqrt(10^(0.1*rp)))],'Color','red');
title('PICTURE 3')%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
grid on;
subplot(2,1,2);
plot(w/pi,F2);
line([f f],[0 pi],'Color','black');
line([0 1],[table(rp) table(rp)],'Color','red');
grid on;
%

%% picture 4
    
 figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
plot(table)
line([0 length(table)],[pi pi],'Color','red');
grid on;
xlabel('RP','FontSize',12);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
legend({'table phase(RP)','pi'},'FontSize',12)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
title('picture 4')%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%% logarithm
range = 19;
  log_fnc = 0.537*log((1: range)) + 1.4355;
 figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
  plot(log_fnc);
  hold on;
  plot(table(1:range))
  grid on;
  title('y=0.537 ln(RP)+1.4355')%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  legend({'y=0.537 ln(RP)+1.4355','table'},'FontSize',12)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%% picture 5
th =pi* tanh(0.0792*(1:length(table)) + 0.4521);
figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
 plot(th);
  hold on;
  plot(table)
  legend({'ph(RP)=th(0.0792RP+0.4521)','table'},'FontSize',12);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  title('picture 5');%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%% picture 6
length = 10;
rp = (1:length);
A1=1;
A2=1/3;
A3=2/15;
A4=17/315;
A5=62/2835;
argument =0.0792*rp+0.4521;
for i = 1:length
    line(i)=A1*argument(i)-A2*argument(i)^3+A3*argument(i)^5-A4*argument(i)^7+A5*argument(i)^9;
    model(i)=tanh(argument(i));
end
figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
plot(pi * line);
hold on;
plot(pi *model)
legend({'decomposed','model'},'FontSize',12);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
title('picture 6');%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%% picture 7
length = 40;
rp = (1:length);
A1=1;
A2=1/3;
A3=2/15;
A4=17/315;
A5=62/2835;
argument =0.0792*rp+0.4521;
for i = 1:length
    sin(i) = argument(i) + ((argument(i).^3)/6) + ((argument(i).^5)/120) + ((argument(i).^7)/5040)+ ((argument(i).^9)/factorial(9));
    cos(i) = 1 + ((argument(i).^2)/factorial(2)) + ((argument(i).^4)/factorial(4)) + ((argument(i).^6)/factorial(6))+ ((argument(i).^8)/factorial(8));
   
    model(i)=tanh(argument(i));
    sincos(i) =  sin(i)/cos(i);
end
figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
plot(pi * sincos);
hold on;
plot(pi * model)
legend({'decomposed sincos','model'},'FontSize',12);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
title('picture 7');%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
