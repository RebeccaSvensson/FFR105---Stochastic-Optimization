function mutatedChromosome = Mutate(chromosome, mutationProbability)

    nGenes = size(chromosome, 2);
    mutatedChromosome = chromosome;
    for j = 1:nGenes
        r = rand;
        if (r < mutationProbability)
            geneIndexToSwapWith = randi(nGenes);
            while(geneIndexToSwapWith == j)
                geneIndexToSwapWith = randi(nGenes);
            end
            
            gene1 = mutatedChromosome(j);
            gene2 = mutatedChromosome(geneIndexToSwapWith);
            mutatedChromosome(j) = gene2;
            mutatedChromosome(geneIndexToSwapWith)= gene1;
        end
    end
    
end