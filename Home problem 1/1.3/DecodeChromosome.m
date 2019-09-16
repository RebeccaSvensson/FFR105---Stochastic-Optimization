function x = DecodeChromosome(chromosome, variablesPerChromosomes, variableRange)
    
    chromosomeLength = size(chromosome, 2);
    nGenes = chromosomeLength/variablesPerChromosomes;
    
    x = zeros(1, variablesPerChromosomes);
    xGeneral = 2*variableRange/(1-2^(-nGenes));
    for i = 1:variablesPerChromosomes
        for j = 1:nGenes
            x(i) = x(i) +(2^(-j)*chromosome(j + (i-1)*nGenes));
        end
        x(i) = x(i)*xGeneral - variableRange;
    end
end

