function errors = EvaluateIndividual(chromosome, functionData, constantRegister, variableRegister, operators, cMax)
    
    nGenes = length(chromosome);
    numberOfVariables = length(variableRegister);
    
    nDataPoints = length(functionData);
    estimates = zeros(nDataPoints,1);
    
    for k = 1:nDataPoints
        tmpVariableRegister = zeros(1, numberOfVariables);
        tmpVariableRegister(1) = functionData(k, 1);
        
        operands = [tmpVariableRegister, constantRegister];
        for j = 1:4:nGenes
            operatorIndex = chromosome(j);
            destinationIndex = chromosome(j+1);
            operand1Index = chromosome(j+2);
            operand2Index = chromosome(j+3);

            operator = operators(operatorIndex);
          %  destination = tmpVariableRegister(destinationIndex);
            operand1 = operands(operand1Index);
            operand2 = operands(operand2Index);
          
            if operator == '+'
                tmpVariableRegister(destinationIndex) = operand1 + operand2;
            elseif operator == '-'
                tmpVariableRegister(destinationIndex) = operand1 - operand2;
            elseif operator == '*'
                tmpVariableRegister(destinationIndex) = operand1 * operand2;
            elseif operator == '/'
                if operand2 == 0
                    tmpVariableRegister(destinationIndex) = cMax;
                else
                    tmpVariableRegister(destinationIndex) = operand1 / operand2;
                end
            end

        end
        
        estimates(k) = tmpVariableRegister(1);
    end
    
    errors = ComputeErrors(estimates, functionData);
   
   
end