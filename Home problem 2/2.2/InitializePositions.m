function positions = InitializePositions(numberOfParticles, xMin, xMax)

    numberOfDimensions = 2;
    positions = zeros(numberOfParticles, numberOfDimensions);
    
    for i = 1:numberOfParticles
        for j = 1:numberOfDimensions
            r = rand;
            positions(i,j) = xMin + r*(xMax-xMin);
        end
    end
    
end