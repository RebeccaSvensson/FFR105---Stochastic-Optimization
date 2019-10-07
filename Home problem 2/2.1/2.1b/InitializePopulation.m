function population = InitializePopulation(populationSize, nGenes)

    population = zeros(populationSize, nGenes);
    for i = 1:populationSize
        population(i, :) = randperm(nGenes);
    end
          
end