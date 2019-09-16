function [nextXVal] = NewtonRaphsonStep(xVal, firstDerivativeValue, secondDerivativeValue)

nextXVal = xVal - firstDerivativeValue/secondDerivativeValue;

end