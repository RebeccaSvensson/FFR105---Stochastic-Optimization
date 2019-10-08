function deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection)
    
    numberOfCities = size(pathCollection, 2);
    numberOfAnts = size(pathCollection, 1);
    
    deltaPheromoneLevel = zeros(numberOfCities);
    
    for k = 1:numberOfAnts
        path = pathCollection(k,:);
        pathLength = pathLengthCollection(k);
        for i = 1:numberOfCities-1
            currentCityIndex = path(i);
            nextCityIndex = path(i+1);
            deltaPheromoneLevel(nextCityIndex,currentCityIndex) = deltaPheromoneLevel(nextCityIndex,currentCityIndex) + 1/pathLength;   
        end
        
        lastCityIndex = path(end);
        startCityIndex = path(1);
        deltaPheromoneLevel(startCityIndex,lastCityIndex) = deltaPheromoneLevel(startCityIndex,lastCityIndex) + 1/pathLength;   
        
    end
end