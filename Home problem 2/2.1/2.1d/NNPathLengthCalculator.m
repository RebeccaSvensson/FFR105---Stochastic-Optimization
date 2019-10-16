
addpath('../TSPgraphics')

cityLocation = LoadCityLocations;
numberOfCities = length(cityLocation);

startCityIndex = randi(numberOfCities);
startCityCoordinates = cityLocation(1,:);

currentCityIndex = startCityIndex;
currentCityCoordinates = startCityCoordinates;
cityLocation(currentCityIndex,:) = [];

nearestNeighbourIndex = 0;
nearestNeighbourCoordinates = zeros(1, 2);

nearestNeighbourPathLength = 0;

nCitiesLeftToVisit = size(cityLocation, 1);

while nCitiesLeftToVisit ~= 0
    shortestDistance = intmax;

    for j = 1:nCitiesLeftToVisit
        nextCityIndex = j;
        nextCityCoordinates = cityLocation(nextCityIndex,:);
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

    cityLocation(currentCityIndex,:) = [];

    nCitiesLeftToVisit = size(cityLocation, 1);
end
connectingDistance = norm(currentCityCoordinates - startCityCoordinates);
nearestNeighbourPathLength = nearestNeighbourPathLength + connectingDistance;
    
disp(sprintf('Starting at node %d, the nearest neighbour path length is %.5f', startCityIndex, nearestNeighbourPathLength));
