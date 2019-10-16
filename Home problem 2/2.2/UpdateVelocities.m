function newVelocities = UpdateVelocities(positions, velocities, particleBestPositions, swarmBestPosition, deltaT, maxVelocity, inertiaWeight, c1, c2)

    numberOfDimensions =  size(positions, 2);
    numberOfParticles = size(positions, 1);
    newVelocities = zeros(numberOfParticles, numberOfDimensions);
    
    for i = 1:numberOfParticles
        r = rand;
        q = rand;
        
        for j = 1:numberOfDimensions
            cognitiveComponent = c1*q*((particleBestPositions(i,j) - positions(i,j))/deltaT);
            socialComponent = c2*r*((swarmBestPosition(j)-positions(i,j))/deltaT);
            
            newVelocities(i,j) = inertiaWeight*velocities(i,j) + cognitiveComponent + socialComponent;
            
            if newVelocities(i,j) > maxVelocity
                newVelocities(i,j) = maxVelocity;
            elseif newVelocities(i,j) < -maxVelocity
                newVelocities(i,j) = -maxVelocity;
            end
            
        end
    end
    
end
