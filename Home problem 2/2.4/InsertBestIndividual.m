function newPopulation = InsertBestIndividual(population, bestIndividual, nCopies)

    newPopulation = population;
    
    for i = 1:nCopies
        chromosomeLength = length(bestIndividual);
        newPopulation(i).Chromosome = bestIndividual;
    end
    
end
