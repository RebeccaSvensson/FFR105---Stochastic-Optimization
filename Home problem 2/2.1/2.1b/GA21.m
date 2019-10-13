clear all; clc; clf;

addpath('../TSPgraphics')

% Variable initialization
populationSize = 40;
cityLocation = LoadCityLocations;
numberOfCities = size(cityLocation,1);
mutationProbability = 0.025;
tournamentSelectionParameter = 0.75;
numberOfGenerations = 5000;
tournamentSize = 10;
nCopies = 5;
nRuns = 500;

globalMaximumFitness = 0;
globalBestPath = zeros(1,numberOfCities); 

tspFigure = InitializeTspPlot(cityLocation,[0 20 0 20]); 
connection = InitializeConnections(cityLocation); 

for j = 1:nRuns
    fitness = zeros(populationSize,1);

    % Initialize population
    population = InitializePopulation(populationSize, numberOfCities);

    for iGeneration = 1:numberOfGenerations
        maximumFitness = 0.0; % Assumes non-negative fitness values!
        bestPath = zeros(1,numberOfCities); 
        bestIndividualIndex = 0;

        % Calculate fitness score for entire population
        for i = 1:populationSize
            chromosome = population(i,:);
            fitness(i) = EvaluateIndividual(chromosome);
            % Save info about best individual
                if (fitness(i) > maximumFitness)
                    maximumFitness = fitness(i);
                    bestIndividualIndex = i;
                    bestPath = chromosome;
                end
        end
        
        %Generate new individuals
        tempPopulation = population;
        for i = 1:2:populationSize
            i1 = TournamentSelect(fitness, tournamentSelectionParameter, tournamentSize);
            i2 = TournamentSelect(fitness, tournamentSelectionParameter, tournamentSize);
            chromosome1 = population(i1,:);
            chromosome2 = population(i2,:);
            tempPopulation(i,:) = chromosome1;
            tempPopulation(i+1,:) = chromosome2;
        end 

        % Mutate new generation
        for i = 1:populationSize
            originalChromosome = tempPopulation(i,:);
            mutatedChromosome = Mutate(originalChromosome, mutationProbability);
            tempPopulation(i,:) = mutatedChromosome;
        end
        
        % Insert best individual to the nCopies first positions
        tempPopulation = InsertBestIndividual(tempPopulation,...
            population(bestIndividualIndex,:), nCopies);
        population = tempPopulation;
    end
    
    if maximumFitness > globalMaximumFitness
        globalMaximumFitness = maximumFitness;
        globalBestPath = bestPath;

        PlotPath(connection,cityLocation,bestPath);
        pathLength = 1/globalMaximumFitness;
        disp(sprintf('New shortest path found on run %d. Path length is %.5f', j, pathLength));
    end
    
end

