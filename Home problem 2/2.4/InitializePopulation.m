function population = InitializePopulation(populationSize, minChromosomeLength,maxChromosomeLength, numberOfVariableRegisters, numberOfConstantRegisters, numberOfOperators)

    population = [];
    numberOfOperands = numberOfVariableRegisters + numberOfConstantRegisters;
    
    for i = 1:populationSize
        chromosomeLength = minChromosomeLength + fix(rand*(maxChromosomeLength-minChromosomeLength+1));
        chromosome = zeros(1, chromosomeLength);
        for j = 1:4:chromosomeLength
            chromosome(j) = randi(numberOfOperators);
            chromosome(j+1) = randi(numberOfVariableRegisters);
            chromosome(j+2) = randi(numberOfOperands);
            chromosome(j+3) = randi(numberOfOperands);
        end
        
        individual = struct('Chromosome', chromosome);
        population = [population individual];
    end
          
end