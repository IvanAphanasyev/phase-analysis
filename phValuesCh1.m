function [table, th, sincos] = phValuesCh1(N)
rp=(1:N);
argument = 0.0792*rp+0.4521;
for i = 1:N
    sin(i) = argument(i) + ((argument(i).^3)/6) + ((argument(i).^5)/120) + ((argument(i).^7)/5040)+ ((argument(i).^9)/factorial(9))+ ((argument(i).^11)/factorial(11))+ ((argument(i).^13)/factorial(13))+ ((argument(i).^15)/factorial(15))+ ((argument(i).^17)/factorial(17));
    cos(i) = 1 + ((argument(i).^2)/factorial(2)) + ((argument(i).^4)/factorial(4)) + ((argument(i).^6)/factorial(6))+ ((argument(i).^8)/factorial(8))+ ((argument(i).^10)/factorial(10))+ ((argument(i).^12)/factorial(12))+ ((argument(i).^14)/factorial(14))+ ((argument(i).^16)/factorial(16));
    th(i) = -pi * tanh(argument(i));
    sincos(i) = -pi * sin(i)/cos(i);
end
[table,a,c,d] = Tables(N);
end

