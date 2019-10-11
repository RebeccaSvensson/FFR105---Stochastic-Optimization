function mutatedChromosome = Mutate(chromosome, mutationProbability, numberOfVariableRegisters, numberOfConstantRegisters, numberOfOperators)

    nGenes = length(chromosome);
    mutatedChromosome = chromosome;
    numberOfOperands = numberOfVariableRegisters + numberOfConstantRegisters;
    
    for j = 1:nGenes
        r = rand;
        if (r < mutationProbability)
            if mod(j-1,4) == 0
                mutatedChromosome(j) = randi(numberOfOperators);
            elseif mod(j-2,4) == 0
                mutatedChromosome(j) = randi(numberOfVariableRegisters);
            elseif mod(j-3,4) == 0 || mod(j-4,4) == 0
                mutatedChromosome(j) = randi(numberOfOperands);
            end
            
        end
    end
    
end
