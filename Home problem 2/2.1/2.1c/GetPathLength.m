function pathLength = GetPathLength(path,cityLocation)
    
    numberOfCities = length(path);
    
    currentCityIndex = path(1);
    currentCityCoordinates = cityLocation(1, :);
    
    pathLength = 0;
    
    for i = 2:numberOfCities
        nextCityIndex = path(i);
        nextCityCoordinates = cityLocation(nextCityIndex,:);
        
        pathLength = pathLength + norm(nextCityCoordinates-currentCityCoordinates);
       
        currentCityIndex = nextCityIndex;
        currentCityCoordinates = nextCityCoordinates;
    end
    
    nextCityIndex = path(1);
    nextCityCoordinates = cityLocation(nextCityIndex,:);
    
    pathLength = pathLength + norm(nextCityCoordinates-currentCityCoordinates);
end