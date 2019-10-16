function node = GetNode(tabuList, pheromoneLevel, visibility, alpha, beta)

    numberOfCities = length(pheromoneLevel);
    probability = zeros(numberOfCities, 1);
    currentCityIndex = tabuList(end);

    denominator = 0;
    for l = 1:numberOfCities
        cityVisited = ismember(l, tabuList);
        if ~cityVisited
            denominator = denominator + pheromoneLevel(l,currentCityIndex)^alpha * visibility(l,currentCityIndex)^beta;
        end

    end

    for i = 1:numberOfCities
        cityVisited = ismember(i, tabuList);
        if ~cityVisited
            numerator = pheromoneLevel(i, currentCityIndex)^alpha * visibility(i, currentCityIndex)^beta;
            probability(i) = numerator/denominator;
        else
            probability(i) = 0;
        end
    end

    if denominator == 0
        avaliableNodes = setdiff(1:numberOfCities, tabuList);
        numberOfAvaliableNodes = length(avaliableNodes);
        index = randperm(numberOfAvaliableNodes, 1);
        node = avaliableNodes(index);
    else

        r = rand;
        summedProbability = 0;
        node = 0;
        prob = sum(probability);
        for i = 1:size(probability)
            summedProbability = summedProbability + probability(i);
            if r < summedProbability
                node = i;
                break;
            end
        end
      %  node = find(rand<cumsum(probability),1,'first');
    end



end
