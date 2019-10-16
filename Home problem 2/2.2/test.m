
epochs = 10000;
numberOfParticles = 40;
numberOfVariables = 2;
xMin = -5;
xMax = 5;
alpha = 1;
deltaT = 1;
c1 = 2;
c2 = 2;
vMax = (xMax - xMin)/deltaT;
wInertia = 1.35;
beta = 0.99;

particleSbValue = intmax;
previousFunctionValues = zeros(numberOfParticles,1);
previousFunctionValues(1:numberOfParticles, 1) = intmax;

particleSb = zeros(1, 2);
particlePb = zeros(numberOfParticles, 2);

particles = zeros(numberOfParticles, numberOfVariables);
velocities = zeros(numberOfParticles, numberOfVariables);

% Initialize particles and velocities
particles = InitializePositions(numberOfParticles, xMin, xMax);
velocities = InitializeVelocities(numberOfParticles, xMin, xMax, alpha, deltaT);

for iEpochs=1:epochs

  functionValues = zeros(numberOfParticles, 1);
  % update xPb 
  for iParticles=1:numberOfParticles
    functionValues(iParticles) = EvaluateIndividual(particles(iParticles,1),particles(iParticles,2));
    
    if functionValues(iParticles) < previousFunctionValues(iParticles)
      previousFunctionValues(iParticles) = functionValues(iParticles);
      particlePb(iParticles,:) = particles(iParticles,:);
    end

      % update xSp
    if functionValues(iParticles) < particleSbValue
      particleSbValue = functionValues(iParticles);
      particleSb(:) = particles(iParticles,:);
    end
  end
  % update velocity
  velocities = UpdateVelocities(particles, velocities, particlePb, particleSb, deltaT, vMax, wInertia, c1, c2);

  if wInertia > 0.35
    wInertia = wInertia*beta;
  end
  
  % update x
  particles = UpdatePositions(particles, velocities, deltaT);
  
end

format long
particleSbValue
particleSb

