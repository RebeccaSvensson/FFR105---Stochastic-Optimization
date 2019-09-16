polynomialCoefficients = [6, -9, 1, 0, -4, 9, 4, 9];
startingPoint = 1;
tol = 0.0000001;

if length(polynomialCoefficients) < 2
    error('the degree of the polynomial must be 2 or larger'); 
end

iterationValues = NewtonRaphson(polynomialCoefficients, startingPoint, tol);
PlotIterations(polynomialCoefficients, iterationValues)

disp('Minumum located at x = ')
disp(iterationValues(end))