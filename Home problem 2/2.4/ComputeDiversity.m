function diversity = ComputeDiversity(population, numberOfVariableRegisters, numberOfConstantRegisters, numberOfOperators)

    populationSize = length(population);

    totalDistance = 0;
    counterI = 0;
    counterJ = 0;
    for i = 1:populationSize-1
        chromosome1 = population(i).Chromosome;
        counterI = counterI + 1;
        for j = i:populationSize
            chromosome2 = population(j).Chromosome;
            distance = ComputeDistance(chromosome1, chromosome2, numberOfVariableRegisters, numberOfConstantRegisters, numberOfOperators);              
            totalDistance = totalDistance + distance;
            counterJ = counterJ + 1;
        end
    end
    tot = (populationSize * (populationSize-1));
    diversity = 2/tot * totalDistance;
    
end