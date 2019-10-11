clear all; clc; clf;

% Variable initialization
populationSize = 40;
nGenes = 30;
mutationProbability = 0.025;
tournamentSelectionParameter = 0.75;
crossoverProbability = 0.8;
numberOfGenerations = 50000;
tournamentSize = 6;
nCopies = 2;
nRuns = 1;
cMax = intmax;
minChromosomeLength = 4;
maxChromosomeLength = 100;
% Initialize registers

numberOfVariableRegisters = 3;
numberOfConstantRegisters = 3;
numberOfOperands = numberOfVariableRegisters + numberOfConstantRegisters;
variableRegister = zeros(numberOfVariableRegisters, 1);
constantRegister = [1, 5, -10];

operators = ['+', '-', '*', '/'];
numberOfOperators = length(operators);

functionData = LoadFunctionData();
nDataPoints = length(functionData);

globalMaximumFitness = 0;
globalbestChromosome = zeros(1,nGenes); 

figureHandle = figure(1)
hold on
dataFunctionHandle = plot(functionData(:,1), functionData(:,2))
chromosomeHandle = plot(functionData(:,1),zeros(1,201))

for j = 1:nRuns
    j
    fitness = zeros(populationSize,1);

    % Initialize population
    population = InitializePopulation(populationSize, minChromosomeLength, maxChromosomeLength, numberOfVariableRegisters, numberOfConstantRegisters, numberOfOperators);

    for iGeneration = 1:numberOfGenerations
        iGeneration
        maximumFitness = 0.0; % Assumes non-negative fitness values!
        bestChromosome = zeros(1,nGenes); 
        bestIndividualIndex = 0;

        % Calculate fitness score for entire population
        for i = 1:populationSize
            chromosome = population(i).Chromosome;
            errors = EvaluateIndividual(chromosome, functionData, constantRegister, variableRegister, operators, cMax);
            if chromosome > maxChromosomeLength
                
                penalty = 
            fitness(i) = 1/errors;
            % Save info about best individual
                if (fitness(i) > maximumFitness)
                    maximumFitness = fitness(i);
                    bestIndividualIndex = i;
                    bestChromosome = chromosome;
                    for i = 1:nDataPoints
                        yVals(i) = EvaluateIndividual(bestChromosome, functionData, constantRegister, variableRegister, operators, cMax);
                    end
                    set(chromosomeHandle, 'YData', yVals)
                    drawnow
                end
        end
        
        %Generate new individuals
            tempPopulation = population;
            for i = 1:2:populationSize
                i1 = TournamentSelect(fitness, tournamentSelectionParameter, tournamentSize);
                i2 = TournamentSelect(fitness, tournamentSelectionParameter, tournamentSize);
                chromosome1 = population(i1).Chromosome;
                chromosome2 = population(i2).Chromosome;

                r = rand;
                if (r < crossoverProbability)
                    [newChromosome1, newChromosome2] = Cross(chromosome1, chromosome2);
                    tempPopulation(i).Chromosome = newChromosome1;
                    tempPopulation(i+1).Chromosome = newChromosome2;
                else
                    tempPopulation(i).Chromosome = chromosome1;
                    tempPopulation(i+1).Chromosome = chromosome2;
                end
            end 
            
        % Mutate new generation
        for i = 1:populationSize
            originalChromosome = tempPopulation(i).Chromosome;
            mutatedChromosome = Mutate(originalChromosome, mutationProbability, numberOfVariableRegisters, numberOfConstantRegisters, numberOfOperators);
            tempPopulation(i).Chromosome = mutatedChromosome;
        end
        
        % Insert best individual to the nCopies first positions
        bestIndividual = population(bestIndividualIndex).Chromosome;
        tempPopulation = InsertBestIndividual(tempPopulation,...
            bestIndividual, nCopies);
        population = tempPopulation;
        
        if mod(iGeneration, 100)
            maximumFitness
        end
        
    end
    
    
    if maximumFitness > globalMaximumFitness
        globalMaximumFitness = maximumFitness
        globalbestChromosome = bestChromosome

    end
    
end

