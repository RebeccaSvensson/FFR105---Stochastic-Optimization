function diversity = ComputeDiversity(population)

    populationSize = length(population);

    totalDistance = 0;
    for i = 1:populationSize-1
        chromosome1 = population(i).Chromosome;
        
        for j = i:populationSize
            chromosome2 = population(j).Chromosome;
            distance = ComputeDistance(chromosome1, chromosome2);              
            totalDistance = totalDistance + distance;

        end
    end
    diversity = 2/(populationSize * (populationSize-1)) * totalDistance;
    
end