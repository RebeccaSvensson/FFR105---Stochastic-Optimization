function [] = PlotIterations(polynomialCoefficients, iterationValues)

minIter = min(iterationValues);
maxIter = max(iterationValues);
padding = 0.2*(maxIter-minIter);
x = linspace(minIter - padding, maxIter + padding);
y = Polynomial(x, polynomialCoefficients);
plot(x, y)
hold on

for i = 1:length(iterationValues)
    xVal = iterationValues(i);
    yVal = Polynomial(xVal, polynomialCoefficients);
    plot(xVal, yVal, '-o')
    hold on
end
 
end
