function pathLength = GetPathLength(path,cityLocation)

    numberOfCities = length(path);
    
    currentCityIndex = path(1);
    currentCityCoordinates = cityLocation(currentCityIndex, :);
    
    pathLength = 0;
    
    for i = 2:numberOfCities
        nextCityIndex = path(i);
        nextCityCoordinates = cityLocation(nextCityIndex,:);
        
        edgeLength = norm(nextCityCoordinates-currentCityCoordinates);
        pathLength = pathLength + edgeLength;
       
        currentCityCoordinates = nextCityCoordinates;
    end
    
    nextCityIndex = path(1);
    nextCityCoordinates = cityLocation(nextCityIndex,:);
    edgeLength = norm(nextCityCoordinates-currentCityCoordinates);
    pathLength = pathLength + edgeLength;
    
end