function distance = ComputeDistance(chromosome1, chromosome2, numberOfVariableRegisters, numberOfConstantRegisters, numberOfOperators)
    
    chromosomeLength1 = length(chromosome1);
    chromosomeLength2 = length(chromosome2);
    maxLength = max(chromosomeLength1, chromosomeLength2);
    
    numberOfOperands = numberOfVariableRegisters + numberOfConstantRegisters;
    
    totalDistance = 0;
        
    for k = 1:maxLength
        gene1 = 0;
        gene2 = 0;
        
        if k < chromosomeLength1
            gene1 = chromosome1(k);
        end
        if k < chromosomeLength2
            gene2 = chromosome2(k);
        end
        
        if gene1 == gene2
            diff = 1;
        else 
            diff = 0;
        end
        %diff = abs(gene1 - gene2);
        range = 1;
        
        if mod(k-1,4) == 0
            range = numberOfOperators;
        elseif mod(k-2,4) == 0
            range = numberOfVariableRegisters;
        elseif mod(k-3,4) == 0 || mod(k-4,4) == 0
            range = numberOfOperands;
        end
        
        distance = diff / range;
        totalDistance = totalDistance + distance;
    end
    
    meanDistance = totalDistance / maxLength;
end
