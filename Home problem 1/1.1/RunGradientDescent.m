function RunGradientDescent(x_start, mu, step_length, threshold)

x = x_start;

f_unconstrained = (x(1)-1)^2+2*(x(2)-2)^2;
constraint = x(1)^2+x(2)^2-1;
f_constrained = f_unconstrained + mu*constraint^2;

while (norm(f_constrained) > threshold)
    gradient = ComputeGradient(x, mu);
    
    x = x - step_length * gradient;
    mu = 1.00001*mu;
    
    f_unconstrained = (x(1)-1)^2+2*(x(2)-2)^2;
    constraint = x(1)^2+x(2)^2-1;
    f_constrained = f_unconstrained + mu*constraint^2;
end

end