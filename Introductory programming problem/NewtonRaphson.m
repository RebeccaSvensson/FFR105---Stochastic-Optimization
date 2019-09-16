function [iterationValues] = NewtonRaphson(polynomialCoefficients, startingPoint, tol)
iterationValues = zeros(1);
currentValue = startingPoint;
maxIterations = 5000;

for i = 1:maxIterations
    lastValue = currentValue;
    iterationValues(i) = lastValue; 

    firstDerivativeCoefficients = PolynomialDifferentiation(polynomialCoefficients, 1);
    secondDerivativeCoefficients = PolynomialDifferentiation(polynomialCoefficients, 2);
    firstDerivativeValue = Polynomial(lastValue, firstDerivativeCoefficients);
    secondDerivativeValue = Polynomial(lastValue, secondDerivativeCoefficients);

    if secondDerivativeValue == 0
        error('Value of second derivative at current x value is unvalid'); 
    end

    currentValue = NewtonRaphsonStep(lastValue, firstDerivativeValue, secondDerivativeValue);

    if abs(currentValue - lastValue) < tol
        break;
    end
end

end