function [fcnVal] = Polynomial(xVal, polynomialCoefficients)

fcnVal = 0;
numberOfCoefficients = length(polynomialCoefficients);

for i = 1:numberOfCoefficients
    fcnVal = fcnVal + polynomialCoefficients(i).*xVal.^(i-1);
end

end
