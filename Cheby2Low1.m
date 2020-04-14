clear all; close all;
% Length - 100; table values ??for low pass filter
tableLowCheb2 = [-0.672122471549586,-0.941400490632538,-1.14187336634512,-1.30579070990842,-1.44578834753862,-1.56842185730907,-1.67763226262576,-1.77601950396479,-1.86541316789329,-1.94716362526815,-2.02230488302446,-2.09165221700416,-2.15586396551608,-2.21548238366141,-2.27096164136573,-2.32268759704078,-2.37099212500609,-2.41616372842284,-2.45845555350483,-2.49809154479651,-2.53527124448953,-2.57017358540225,-2.60295992548649,-2.63377650270778,-2.66275644140493,-2.69002140762243,-2.71568298686126,-2.73984384023283,-2.76259868215429,-2.78403511315296,-2.80423433413849,-2.82327176301389,-2.84121757027864,-2.85813714700743,-2.87409151603180,-2.88913769513892,-2.90332901950430,-2.91671542930064,-2.92934372740094,-2.94125781126668,-2.95249888244029,-2.96310563651300,-2.97311443598972,-2.98255946810291,-2.99147288932088,-2.99988495804283,-3.00782415676043,-3.01531730478962,-3.02238966252706,-3.02906502806107,-3.03536582686093,-3.04131319517873,-3.04692705772192,-3.05222620008908,-3.05722833640641,-3.06195017255345,-3.06640746532608,-3.07061507784857,-3.07458703151508,-3.07833655471465,-3.08187612856895,-3.08521752989203,-3.08837187156240,-3.09134964048173,-3.09416073327990,-3.09681448991315,-3.09931972529076,-3.10168475905518,-3.10391744363116,-3.10602519065114,-3.10801499585642,-3.10989346256665,-3.11166682380394,-3.11334096315200,-3.11492143442536,-3.11641348021903,-3.11782204940414,-3.11915181363123,-3.12040718289884,-3.12159232024146,-3.12271115558778,-3.12376739883675,-3.12476455219652,-3.12570592182815,-3.12659462883408,-3.12743361962831,-3.12822567572366,-3.12897342296915,-3.12967934026846,-3.13034576780916,-3.13097491483002,-3.13156886695259,-3.13212959310175,-3.13265895203814,-3.13315869852454,-3.13363048914666,-3.13407588780777,-3.13449637091559,-3.13489333227866,-3.13526808772849];
points = 1000; %
x = (1:length(tableLowCheb2));
%% PICTURE 1
f = 0.6;
 [alb,blb] = butter(2,f,'low');
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
line([f f],[0 -pi],'Color','black');
line([0 1],[-pi/2 -pi/2],'Color','red');
grid on;
%
%% picture 2
f = 0.6;
rs=3;
[alb,blb] = cheby2(2,rs,f,'low');
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
line([0 1],[1/(sqrt(10^(0.1*rs))); 1/(sqrt(10^(0.1*rs)))],'Color','red');
title('PICTURE 2')%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
grid on;
subplot(2,1,2);
plot(w/pi,F2);
line([f f],[min(F2) max(F2)],'Color','black');
line([0 1],[tableLowCheb2(rs) tableLowCheb2(rs)],'Color','red');
grid on;
%
%% picture 3
f = 0.6;
rs=7;
[alb,blb] = cheby2(2,rs,f,'low');
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
line([0 1],[1/(sqrt(10^(0.1*rs))); 1/(sqrt(10^(0.1*rs)))],'Color','red');
title('PICTURE 3')%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
grid on;
subplot(2,1,2);
plot(w/pi,F2);
line([f f],[min(F2) max(F2)],'Color','black');
line([0 1],[tableLowCheb2(rs) tableLowCheb2(rs)],'Color','red');
grid on;
%% picture 4
figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
plot(x,tableLowCheb2);
line([0 length(x)], [-pi -pi], 'color', 'red');
%% picture 5 
lned = -0.76.*(log(x)) - 0.2117;
figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
plot(x, [tableLowCheb2; lned]);
title('logarithmic approx, -0.76ln(x) - 0.2117');
legend({'table phase(rs)','logarithmed'},'FontSize',12);
%% picture 6
thed = -tanh(0.2*x.^ 0.57)*pi;
figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
plot(x, [tableLowCheb2; thed]);
title('approximation by hiberbolic tangent');
legend({'table phase(rs)','by tanh'},'FontSize',12);
%% picture 7
arg = 0.2*x.^ 0.57;
decomposed =-pi *(arg.*(1 - 0.333*(1 - 0.4.*arg.^2).*(1 + 0.162.*arg.^4).*arg.^2));
figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
plot(x(1:10), [tableLowCheb2(1:10); decomposed(1:10)]);
title('decomposed by =-pix[1-0.333(1-0.4x^2 )(1+0.162x^4 ) x^2 ]');
legend({'table phase(rs)','by tanh'},'FontSize',12);
%% picture 8
argument =0.2*x.^ 0.57;
A1=1;
A2=1/3;
A3=2/15;
A4=17/315;
A5=62/2835;
for i = 1:length(x)
    sin(i) = argument(i) + ((argument(i).^3)/6) + ((argument(i).^5)/120) + ((argument(i).^7)/5040)+ ((argument(i).^9)/factorial(9));
    cos(i) = 1 + ((argument(i).^2)/factorial(2)) + ((argument(i).^4)/factorial(4)) + ((argument(i).^6)/factorial(6))+ ((argument(i).^8)/factorial(8));
    sincos(i) = -pi * sin(i)/cos(i);
end
figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
plot(x, [tableLowCheb2; sincos]);
title('line decomposition for hiberbolic tanh by 0.2*x^0^.^5^7');
legend({'table values','decomposed tanh'},'FontSize',12);

%% picture 9
argument = 0.269 * sqrt(x - 0.9);
for i = 1:length(x)
    sin(i) = argument(i) + ((argument(i).^3)/6) + ((argument(i).^5)/120) + ((argument(i).^7)/5040)+ ((argument(i).^9)/factorial(9));
    cos(i) = 1 + ((argument(i).^2)/factorial(2)) + ((argument(i).^4)/factorial(4)) + ((argument(i).^6)/factorial(6))+ ((argument(i).^8)/factorial(8));
    sincos(i) = -pi * sin(i)/cos(i);
end
figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
plot(x, [tableLowCheb2; sincos]);
title('line decomposition by 0.269*sqrt(rs-0.9)');
legend({'table values','decomposed tanh'},'FontSize',12);
