function fitness = EvaluateIndividual(chromosome, functionData, constantRegister, variableRegister, operators, cMax)
    
    nGenes = length(chromosome);
    numberOfVariables = length(variableRegister);
    
    nDataPoints = length(functionData);
    estimates = zeros(nDataPoints,1);
    
    for k = 1:nDataPoints
        tmpVariableRegister = zeros(1, numberOfVariables);
        tmpVariableRegister(1) = functionData(k, 1);
        
        operands = [tmpVariableRegister, constantRegister];
        for j = 1:nGenes
            value = chromosome(j);
            if value == 0
                break;
            end
            
            if mod(j-1,4) == 0
                operator = operators(value);
            elseif mod(j-2,4) == 0
                destination = tmpVariableRegister(value);
            elseif mod(j-3,4) == 0
                operand1 = operands(value);
            elseif mod(j,4) == 0
                operand2 = operands(value);
            end

            if mod(j,4) == 0
                if operator == '+'
                    destination = operand1 + operand2;
                elseif operator == '-'
                    destination = operand1 - operand2;
                elseif operator == '*'
                    destination = operand1 * operand2;
                elseif operator == '/'
                    if operand2 == 0
                        destination = cMax;
                    else
                        destination = operand1 / operand2;
                    end
                end
                
                estimates(k) = destination;
            end

        end
    end
    
    errors = ComputeErrors(estimates, functionData);
    
    fitness = 1/errors;
end