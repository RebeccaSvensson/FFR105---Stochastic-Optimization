function errors = EvaluateIndividual(chromosome, functionData, constantRegister, variableRegister, operators, cMax)
    
    numberOfVariables = length(variableRegister);
    
    nDataPoints = length(functionData);
    estimates = zeros(nDataPoints,1);
    
    for k = 1:nDataPoints
        xVal = functionData(k,1);
        estimates(k) = GetEstimate(chromosome, xVal, numberOfVariables, constantRegister, operators, cMax);
    end
    
    errors = ComputeErrors(estimates, functionData);
   
    if isnan(errors) || isinf(errors)
        errors = intmax;
    end
    
end