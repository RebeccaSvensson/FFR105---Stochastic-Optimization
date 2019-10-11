clear all; clc;

numberOfParticles = 40;
numberOfVariables = 2;
minVal = -5.0;
maxVal = 5.0;
alpha = 1;
deltaT = 1;
maxVelocity = (maxVal-minVal)/deltaT; 

for n = 1:1
    
swarmBestPosition = zeros(1, 2);
swarmBestValue = intmax;
particleBestPositions = zeros(numberOfParticles, 2);
particleBestValue(1:numberOfParticles, 1) = intmax;

% Initialize particles
positions = zeros(numberOfParticles, numberOfVariables);
velocities = zeros(numberOfParticles, numberOfVariables);

particles = InitializePositions(numberOfParticles, minVal, maxVal);
velocities = InitializeVelocities(numberOfParticles, minVal, maxVal, alpha, deltaT);

evaluatedIndividuals = zeros(numberOfParticles, 1);

inertiaWeight = 1.4;
beta = 0.99;
minInertiaWeight = 0.3;

nRuns = 1000;

fig = figure;
    for k = 1:nRuns
        
        for i = 1:numberOfParticles
            x = positions(i, 1);
            y = positions(i, 2);
            evaluatedIndividuals(i) = EvaluateIndividual(x, y);

            if evaluatedIndividuals(i) < particleBestValue(i)
                particleBestValue(i) = evaluatedIndividuals(i);
                particleBestPositions(i,1) = x;
                particleBestPositions(i,2) = y;
            end
            if evaluatedIndividuals(i) < swarmBestValue
                swarmBestValue = evaluatedIndividuals(i);
                swarmBestPosition(1,1) = x;
                swarmBestPosition(1,2) = y;
            end
            
        end

        velocities = UpdateVelocities(positions, velocities, particleBestPositions, swarmBestPosition, deltaT, maxVelocity, inertiaWeight);
        positions = UpdatePositions(positions, velocities, deltaT);
        
      %  scatter(positions(:,1), positions(:,2))
      %  xlim([-5 5])
      %  ylim([-5 5])
      %  drawnow
        
        if inertiaWeight > minInertiaWeight
            inertiaWeight = inertiaWeight*beta;
        end
        
    end

    format long
    disp('best position')
    disp(swarmBestPosition)
    disp('minimi value')
    disp(swarmBestValue)
end