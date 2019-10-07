clear all; clc;

% Variable initialization
populationSize = 40;
nGenes = 30;
mutationProbability = 0.025;
tournamentSelectionParameter = 0.75;
crossoverProbability = 0.8;
numberOfGenerations = 50;
tournamentSize = 10;
nCopies = 5;
nRuns = 10;
cMax = intmax;
% Initialize registers

numberOfVariableRegisters = 3;
numberOfConstantRegisters = 3;
numberOfOperands = numberOfVariableRegisters + numberOfConstantRegisters;
variableRegister = zeros(numberOfVariableRegisters, 1);
constantRegister = [1, 3, 10];

operators = ['+', '-', '*', '/'];
numberOfOperators = length(operators);

functionData = LoadFunctionData();

globalMaximumFitness = 0;
globalbestChromosome = zeros(1,nGenes); 


for j = 1:nRuns
    j
    fitness = zeros(populationSize,1);

    % Initialize population
    population = InitializePopulation(populationSize, nGenes, numberOfVariableRegisters, numberOfConstantRegisters, numberOfOperators);

    for iGeneration = 1:numberOfGenerations
        iGeneration
        maximumFitness = 0.0; % Assumes non-negative fitness values!
        bestChromosome = zeros(1,nGenes); 
        bestIndividualIndex = 0;

        % Calculate fitness score for entire population
        for i = 1:populationSize
            chromosome = population(i,:);
            fitness(i) = EvaluateIndividual(chromosome, functionData, constantRegister, variableRegister, operators, cMax);
            % Save info about best individual
                if (fitness(i) > maximumFitness)
                    maximumFitness = fitness(i);
                    bestIndividualIndex = i;
                    bestChromosome = chromosome;
                end
        end
        
        %Generate new individuals
            tempPopulation = population;
            for i = 1:2:populationSize
                i1 = TournamentSelect(fitness, tournamentSelectionParameter, tournamentSize);
                i2 = TournamentSelect(fitness, tournamentSelectionParameter, tournamentSize);
                chromosome1 = population(i1,:);
                chromosome2 = population(i2,:);

                r = rand;
                if (r < crossoverProbability)
                    [newChromosome1, newChromosome2] = Cross(chromosome1, chromosome2);
                    chromosomeLength = length(newChromosome1);
                    tempPopulation(i,1:chromosomeLength) = newChromosome1;
                    chromosomeLength = length(newChromosome2);
                    tempPopulation(i+1,1:chromosomeLength) = newChromosome2;
                else
                    chromosomeLength = length(chromosome1);
                    tempPopulation(i,1:chromosomeLength) = chromosome1;
                    chromosomeLength = length(chromosome2);
                    tempPopulation(i+1,1:chromosomeLength) = chromosome2;
                end
            end 
            
        % Mutate new generation
        for i = 1:populationSize
            originalChromosome = tempPopulation(i,:);
            mutatedChromosome = Mutate(chromosome, mutationProbability, numberOfVariableRegisters, numberOfConstantRegisters, numberOfOperators);
            chromosomeLength = length(mutatedChromosome);
            tempPopulation(i,1:chromosomeLength) = mutatedChromosome;
        end
        
        % Insert best individual to the nCopies first positions
        tempPopulation = InsertBestIndividual(tempPopulation,...
            population(bestIndividualIndex,:), nCopies);
        population = tempPopulation;
    end
    
    if maximumFitness > globalMaximumFitness
        globalMaximumFitness = maximumFitness
        globalbestChromosome = bestChromosome


    end
    
end

