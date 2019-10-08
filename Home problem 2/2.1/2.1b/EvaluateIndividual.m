function fitness = EvaluateIndividual(chromosome)
    
    nCities = size(chromosome, 2);

    cityLocations = LoadCityLocations;
    startIndex = chromosome(1);
    firstCityCoordinates = cityLocations(startIndex, :);
    currentCityCoordinates = firstCityCoordinates;
    
    pathLength = 0;
    for i = 2:nCities   % Starts at i = 2 since no distance to first city
        nextCityIndex = chromosome(i);
        nextCityCoordinates = cityLocations(nextCityIndex, :);
        distance = nextCityCoordinates - currentCityCoordinates;
        pathLength = pathLength + norm(distance);
        currentCityCoordinates = nextCityCoordinates;
    end
    
    distance = currentCityCoordinates - firstCityCoordinates;
    pathLength = pathLength + norm(distance);
    
    fitness = 1/pathLength;
end