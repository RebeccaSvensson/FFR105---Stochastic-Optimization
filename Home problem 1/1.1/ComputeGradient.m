function gradient = ComputeGradient(x, mu)

    if (x(1)^2+x(2)^2-1<0)
        gradient = [2*(x(1)-1); 4*(x(2)-2)];
    else
        unconstrained_gradient = [2*(x(1)-1); 4*(x(2)-2)];
        constraint_gradient = [4*mu*x(1)*(x(1)^2+x(2)^2-1); 4*mu*x(2)*(x(1)^2+x(2)^2-1)];
        gradient = unconstrained_gradient + constraint_gradient;
    end

end