function estimate = GetEstimate(chromosome, xVal, numberOfVariables, constantRegister, operators, cMax)

    nGenes = length(chromosome);
    
    variableRegister = zeros(1, numberOfVariables);
    variableRegister(1) = xVal;

    operands = [variableRegister, constantRegister];
    for j = 1:4:nGenes
        
        operatorIndex = chromosome(j);
        destinationIndex = chromosome(j+1);
        operand1Index = chromosome(j+2);
        operand2Index = chromosome(j+3);

        operator = operators(operatorIndex);
        operand1 = operands(operand1Index);
        operand2 = operands(operand2Index);

        if operator == '+'
            operands(destinationIndex) = operand1 + operand2;
        elseif operator == '-'
            operands(destinationIndex) = operand1 - operand2;
        elseif operator == '*'
            operands(destinationIndex) = operand1 * operand2;
        elseif operator == '/'
            if operand2 == 0
                operands(destinationIndex) = cMax;
            else
                operands(destinationIndex) = operand1 / operand2;
            end
        end

    end
    
    estimate = operands(1);
end