clear all; clc;

numberOfParticles = 40;
numberOfVariables = 2;
minVal = -5;
maxVal = 5;
alpha = 1;
deltaT = 1;
maxVelocity = (maxVal-minVal)/deltaT; 
c1 = 2;
c2 = 2;
nRuns = 10000;
beta = 0.99;
minInertiaWeight = 0.35;
inertiaWeight = 1.35;
    
swarmBestPosition = zeros(1, 2);
swarmBestValue = inf;
particleBestPositions = zeros(numberOfParticles, 2);
particleBestValue(1:numberOfParticles, 1) = inf;

% Initialize particles
positions = InitializePositions(numberOfParticles, minVal, maxVal);
velocities = InitializeVelocities(numberOfParticles, minVal, maxVal, alpha, deltaT);

fig = figure;

for k = 1:nRuns

    evaluatedIndividuals = zeros(numberOfParticles,1);
    
    for i = 1:numberOfParticles
        x = positions(i, 1);
        y = positions(i, 2);
        evaluatedIndividuals(i) = EvaluateIndividual(x, y);

        if evaluatedIndividuals(i) < particleBestValue(i)
            particleBestValue(i) = evaluatedIndividuals(i);
            particleBestPositions(i,:) = positions(i,:);
        end
        
        if evaluatedIndividuals(i) < swarmBestValue
            swarmBestValue = evaluatedIndividuals(i);
            swarmBestPosition = positions(i,:);
        end
    end

    velocities = UpdateVelocities(positions, velocities, particleBestPositions, swarmBestPosition, deltaT, maxVelocity, inertiaWeight, c1, c2);
    
    if inertiaWeight > minInertiaWeight
        inertiaWeight = inertiaWeight*beta;
    end
    
    positions = UpdatePositions(positions, velocities, deltaT);

%    scatter(positions(:,1), positions(:,2))
%    xlim([-5 5])
%    ylim([-5 5])
%    drawnow


end

format long

disp('best position')
disp(swarmBestPosition)
disp('minimi value')
disp(swarmBestValue)
