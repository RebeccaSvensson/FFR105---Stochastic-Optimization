function [newChromosome1, newChromosome2] = Cross(chromosome1, chromosome2)

    nGenes = size(chromosome1, 2);  % Both chromosomes must have the same length
    nSetsOfInstructions = nGenes/4;
    
    % crossover points for chromosome1
    crossoverPoint11 = 4*randi(nSetsOfInstructions) - 3;
    crossoverPoint12 = 4*randi(nSetsOfInstructions) - 3;
    
    if crossoverPoint11 > crossoverPoint12
        tmpVal = crossoverPoint11;
        crossoverPoint11 = crossoverPoint12;
        crossoverPoint12 = tmpVal;
    end
    
    % crossover points for chromosome2
    crossoverPoint21 = 4*randi(nSetsOfInstructions) - 3;
    crossoverPoint22 = 4*randi(nSetsOfInstructions) - 3;
    
    if crossoverPoint21 > crossoverPoint22
        tmpVal = crossoverPoint21;
        crossoverPoint21 = crossoverPoint22;
        crossoverPoint22 = tmpVal;
    end
    % keep first bit of both chromosomes
    newChromosome1(1:crossoverPoint11-1) = chromosome1(1:crossoverPoint11-1);
    newChromosome2(1:crossoverPoint21-1) = chromosome2(1:crossoverPoint21-1);
    
    genesToRemoveChromosome1 = chromosome1(crossoverPoint11:crossoverPoint12-1);
    genesToRemoveChromosome2 = chromosome2(crossoverPoint11:crossoverPoint22-1);
    
    endingChromosome1 = chromosome1(crossoverPoint12:end);
    endingChromosome2 = chromosome1(crossoverPoint12:end);
    
    newChromosome1 = [newChromosome1, genesToRemoveChromosome2, endingChromosome1];
    newChromosome2 = [newChromosome2, genesToRemoveChromosome1, endingChromosome2];
end
    