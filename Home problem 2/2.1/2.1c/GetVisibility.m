 function visibility = GetVisibility(cityLocation)

    numberOfCities = size(cityLocation, 1);
    visibility = zeros(numberOfCities);
    
    for i = 1:numberOfCities-1
        iCityCoordinates = cityLocation(i,:);
        
        for j = i+1:numberOfCities
            jCityCoordinates = cityLocation(j,:);
            visibility(i,j) = 1/norm(iCityCoordinates - jCityCoordinates);
            visibility(j,i) = visibility(i,j);
        end
    end
    
  %  visibility = 1./squareform(pdist(cityLocation));
end