function pheromoneLevel = InitializePheromoneLevels(numberOfCities, tau0)

pheromoneLevel(1:numberOfCities, 1:numberOfCities) = tau0;

end

