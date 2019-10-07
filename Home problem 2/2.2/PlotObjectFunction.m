function PlotObjectFunction()
    variableRange = 5.0;
    delta = 0.1;
    
    limit = fix(2*variableRange/delta) + 1;
    [xValues, yValues] = meshgrid(-variableRange:delta:variableRange, -variableRange:delta:variableRange);
    zValues = zeros(limit, limit);
    a = 0.01;
    for j = 1:limit
        for k = 1:limit
            zValues(j,k) = log(a + EvaluateIndividual(xValues(j,k), yValues(j,k)));
        end
    end
    contour(xValues, yValues, zValues)
    
    
end
