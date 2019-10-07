function nearestNeighbourPathLength = GetNearestNeighbourPathLength(cityLocation)
    
    tmpCityLocation = cityLocation;
    numberOfCities = length(tmpCityLocation);
    
    startCityIndex = randi(numberOfCities);
    startCityCoordinates = tmpCityLocation(1,:);

    currentCityIndex = startCityIndex;
    currentCityCoordinates = startCityCoordinates;
    tmpCityLocation(currentCityIndex,:) = [];
    
    nearestNeighbourIndex = 0;
    nearestNeighbourCoordinates = zeros(1, 2);
    
    nearestNeighbourPathLength = 0;
    
    nCitiesLeftToVisit = size(tmpCityLocation, 1);
    
    while nCitiesLeftToVisit ~= 0
        shortestDistance = intmax;
        
        for j = 1:nCitiesLeftToVisit
            nextCityIndex = j;
            nextCityCoordinates = tmpCityLocation(nextCityIndex,:);
            distance = norm(nextCityCoordinates - currentCityCoordinates);

            if distance < shortestDistance
                shortestDistance = distance;
                nearestNeighbourIndex = nextCityIndex;
                nearestNeighbourCoordinates = nextCityCoordinates;
            end

        end
        
        nearestNeighbourPathLength = nearestNeighbourPathLength + shortestDistance;
        
        currentCityIndex = nearestNeighbourIndex;
        currentCityCoordinates = nearestNeighbourCoordinates;
        
        tmpCityLocation(currentCityIndex,:) = [];
        
        nCitiesLeftToVisit = size(tmpCityLocation, 1);

    end
    
    
end
