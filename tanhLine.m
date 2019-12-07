N = 100;
rp=(1:N);
argument =0.0792*rp+0.4521;
A1=1;
A2=1/3;
A3=2/15;
A4=17/315;
A5=62/2835;
for i = 1:N
    sin(i) = argument(i) + ((argument(i).^3)/6) + ((argument(i).^5)/120) + ((argument(i).^7)/5040)+ ((argument(i).^9)/factorial(9));
    cos(i) = 1 + ((argument(i).^2)/factorial(2)) + ((argument(i).^4)/factorial(4)) + ((argument(i).^6)/factorial(6))+ ((argument(i).^8)/factorial(8));
   
    model(i) = pi * tanh(argument(i));
   
    line(i)=A1*argument(i)-A2*argument(i)^3+A3*argument(i)^5-A4*argument(i)^7+A5*argument(i)^9;
    target(i) = pi * line(i);
    sincos(i) = pi * sin(i)/cos(i);
end
figure
hold on;
plot(sincos);
plot(model);
[a,b,c,d] = Tables(N);
pigraph(1:N) = pi;
plot(pigraph);
plot(b);
legend({'sincos','model', 'pi', 'table'},'FontSize',12)