function newPositions = UpdatePositions(positions, velocities, deltaT)

    numberOfDimensions =  size(positions, 2);
    numberOfParticles = size(positions, 1);
    newPositions = zeros(numberOfParticles, numberOfDimensions);
    
    for i = 1:numberOfParticles
        for j = 1:numberOfDimensions
            newPositions(i,j) = positions(i,j) + velocities(i,j)*deltaT;
        end
    end
end