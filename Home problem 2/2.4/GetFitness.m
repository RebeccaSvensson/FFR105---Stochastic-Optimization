function fitness = GetFitness(chromosome, errors, maxChromosomeLength)

    chromosomeLength = length(chromosome);
    penalty = 1;
    if chromosomeLength > maxChromosomeLength
        penalty = exp(chromosomeLength-maxChromosomeLength);
    end
    fitness = 1/errors * 1/penalty;
    
end