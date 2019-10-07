function path = GeneratePath(pheromoneLevel, visibility, alpha, beta)
    
    numberOfCities = size(pheromoneLevel, 1);
    currentCityIndex = randi(numberOfCities);

    path = currentCityIndex;

    for nCity = 2:numberOfCities
        nextNode = GetNode(path, pheromoneLevel, visibility, alpha, beta);

        path(nCity) = nextNode;

    end
end