function fitness = EvaluateIndividual(x)
    
    fNumerator1 = (x(1) + x(2)+ 1)^2;
    fNumerator2 = (19 - 14*x(1) + 3*x(1)^2 - 14*x(2) + 6*x(1)*x(2) + 3*x(2)^2);
    fNumerator3 = (2*x(1) - 3*x(2))^2;
    fNumerator4 = (18 - 32*x(1) + 12*x(1)^2 + 48*x(2) - 36*x(1)*x(2) + 27*x(2)^2);
    

    f = (1 + fNumerator1 * fNumerator2)*(30 + fNumerator3 * fNumerator4);
    
    fitness = 1/f;
end