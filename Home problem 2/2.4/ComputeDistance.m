function meanDistance = ComputeDistance(chromosome1, chromosome2)
    
    chromosomeLength1 = length(chromosome1);
    chromosomeLength2 = length(chromosome2);
    maxLength = max(chromosomeLength1, chromosomeLength2);
    
    totalDistance = 0;
        
    for k = 1:maxLength
        gene1 = 0;
        gene2 = 0;
        
        if k <= chromosomeLength1
            gene1 = chromosome1(k);
        end
        if k <= chromosomeLength2
            gene2 = chromosome2(k);
        end
        
        if gene1 == gene2
            diff = 0;
        else 
            diff = 1;
        end

        distance = diff;
        totalDistance = totalDistance + distance;
    end
    
    meanDistance = totalDistance / maxLength;
end
