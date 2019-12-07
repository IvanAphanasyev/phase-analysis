
N = 91; %count of cut freqiency
ws = linspace(0.05,0.95,N); % array of cut frequencies from 0.05 to 0.95 with step 0.01


for i=1:N
    %get butter with cut frequency from ws
 [a,b] = butter(2,ws(i),'low');
 %% coof from matlab
 ma0(i) = a(1); ma1(i) = a(2); ma2(i) = (3);
 mb1(i) = b(2); mb2(i) = b(3); mb0(i) = b(1);
 % coof from matlab
 %% coof from equastions
 eb2(i) = ((sqrt(2) - sin(ws(i)*pi))/(sqrt(2) + sin(ws(i)*pi)));
 eb1(i) = - (1 + eb2(i)) * cos(ws(i)*pi);
 
 ea0(i) = 0.5 * (1 + eb2(i)) * sin(ws(i)*pi/2)^2;
 ea1(i) = 2 * ea0(i);
 ea2(i) = ea0(i);
 %
end
draw2(ws, mb2, eb2, 'b2 coofs', 'cut frequency', 'coof');
draw2(ws, mb1, eb1, 'b1 coofs', 'cut frequency', 'coof');
draw2(ws, ma0, ea0, 'a0 coofs', 'cut frequency', 'coof');
draw2(ws, ma1, ea1, 'a1 coofs', 'cut frequency', 'coof');