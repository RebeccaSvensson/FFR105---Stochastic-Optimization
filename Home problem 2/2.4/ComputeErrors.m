function error = ComputeErrors(estimates, functionData)

    nDataPoints = length(functionData);
    
    fValues = functionData(:, 2);
    
    sumVal = sum((estimates - fValues).^2);
    
    error = sqrt(1/nDataPoints * sumVal);
end