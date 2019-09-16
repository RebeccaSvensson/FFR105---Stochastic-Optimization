function x = DecodeChromosome(chromosome, nVariables, variableRange)
    
    chromosomeLength = size(chromosome, 2);
    nGenes = chromosomeLength/nVariables;
    
    x = zeros(1, nVariables);
    xGeneral = -variableRange + 2*variableRange/(1-2^(-nGenes));
    for i = 1:nVariables
        for j = 1:nGenes
            x(i) = x(1) + xGeneral * (2^(-j)*chromosome(j + (i-1)*nGenes));
        end
    end
end

