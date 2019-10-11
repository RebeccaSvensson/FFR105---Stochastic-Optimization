function polynomial = GetPolynomial(chromosome, variableRegister, constantRegister, operators)

   % for k = 1:nDataPoints
        tmpVariableRegister = zeros(1, numberOfVariables);
        tmpVariableRegister(1) = 1;
        
        operands = [tmpVariableRegister, constantRegister];
        for j = 1:4:nGenes
            operatorIndex = chromosome(j);
            destinationIndex = chromosome(j+1);
            operand1Index = chromosome(j+2);
            operand2Index = chromosome(j+3);

            operator = operators(operatorIndex);
            destination = tmpVariableRegister(destinationIndex);
            operand1 = operands(operand1Index);
            operand2 = operands(operand2Index);
          
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

        end
        
        estimates(k) = destination;
   % end
end