function population = InitializePopulation(populationSize, nGenes, numberOfVariableRegisters, numberOfConstantRegisters, numberOfOperators)

    population = zeros(populationSize, nGenes);
    numberOfOperands = numberOfVariableRegisters + numberOfConstantRegisters;
    
    for i = 1:populationSize
        chromosome = zeros(1, nGenes);
        for j = 1:4:nGenes
            chromosome(1, j) = randi(numberOfOperators);
            chromosome(1, j+1) = randi(numberOfVariableRegisters);
            chromosome(1, j+2) = randi(numberOfOperands);
            chromosome(1, j+3) = randi(numberOfOperands);
        end
        chromosomeLength = length(chromosome);
        population(i,1:chromosomeLength) = chromosome;
    end
          
end