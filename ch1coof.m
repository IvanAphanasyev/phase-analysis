w_range = linspace(0.05,0.95,25);
w_pi_range = w_range*pi;
rp = 3;

for i = 1:length(w_range)
    
    [a,b] = cheby1(2,rp,w_range(i)/pi,'low');
    a0(i) = a(1);
    a1(i) = a(2);
    a2(i) = a(3);
    
    b0(i) = b(1);
    b1(i) = b(2);
    b2(i) = b(3);
    
end