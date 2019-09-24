function newPopulation = InsertBestIndividual(population, bestIndividual, nCopies)

    newPopulation = population;
    
    for i = 1:nCopies
        newPopulation(i,:) = bestIndividual;
    end
    
end
