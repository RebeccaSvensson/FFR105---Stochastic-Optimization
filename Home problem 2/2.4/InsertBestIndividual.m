function newPopulation = InsertBestIndividual(population, bestIndividual, nCopies)

    newPopulation = population;
    
    for i = 1:nCopies
        chromosomeLength = length(bestIndividual);
        newPopulation(i,1:chromosomeLength) = bestIndividual;
    end
    
end
