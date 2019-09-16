function [differentiatedCoefficients] = PolynomialDifferentiation(polynomialCoefficients, orderOfDerivative)

numberOfCoefficients = length(polynomialCoefficients);
coefficientsToBeDifferentiated = polynomialCoefficients;

for i = 1:orderOfDerivative
    differentiatedCoefficients = zeros([1 numberOfCoefficients - 1]);
    
    for j = 2:numberOfCoefficients
        powerOfTerm = j-1;
        coefficientOfTerm = coefficientsToBeDifferentiated(j);
        differentiatedCoefficients(j-1) = powerOfTerm*coefficientOfTerm;
    end
    
    numberOfCoefficients = length(differentiatedCoefficients);
    coefficientsToBeDifferentiated = differentiatedCoefficients;
end 

end