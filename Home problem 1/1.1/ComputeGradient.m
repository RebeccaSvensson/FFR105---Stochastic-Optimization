function gradient = ComputeGradient(x, mu)

    if (x(1)^2+x(2)^2-1<0)
        gradient = [2*(x(1)-1); 4*(x(2)-1)];
    else
        gradient = [2*(x(1)-1)+4*mu*x(1)*(x(1)^2+x(2)^2-1); 4*(x(2)-2)+4*mu*x(1)*(x(1)^2+x(2)^2-1)];
    end

end