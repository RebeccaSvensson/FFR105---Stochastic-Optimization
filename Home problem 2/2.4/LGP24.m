clear all; clc; clf;

% Variable initialization
populationSize = 40;
nGenes = 30;
mutationProbability = 3;
tournamentSelectionParameter = 0.75;
crossoverProbability = 0.8;
numberOfGenerations = 50000;
tournamentSize = 6;
nCopies = 3;
nRuns = 10;
cMax = intmax;
minChromosomeLength = 4;
maxChromosomeLength = 100;
Dmin = 0.69;
Dmax = 0.69;
alpha = 1.1;
% Initialize registers
constantRegister = [1, -1, -3];
numberOfConstantRegisters = length(constantRegister);
numberOfVariableRegisters = 3;
numberOfOperands = numberOfVariableRegisters + numberOfConstantRegisters;
variableRegister = zeros(numberOfVariableRegisters, 1);

operators = ['+', '-', '*', '/'];
numberOfOperators = length(operators);

functionData = LoadFunctionData();
nDataPoints = length(functionData);

globalMaximumFitness = 0;
globalbestChromosome = zeros(1,nGenes); 

figureHandle = figure(1);
hold on
dataFunctionHandle = plot(functionData(:,1), functionData(:,2));
chromosomeHandle = plot(functionData(:,1),zeros(1,201));

nMaxSteadyIterations = 9000;
maxFitnessCurrentGen = 0;
maxFitnessLastGen = 0;
nSteadyIterations = 0;
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
        
        if maximumFitness == inf
            matlab.io.saveVariablesToScript('BestChromosome.m', 'bestChromosome');
        end
        if maxFitnessCurrentGen == maxFitnessLastGen
            nSteadyIterations = nSteadyIterations + 1;
        else
            nSteadyIterations = 0;
        end
        
        maxFitnessLastGen = maxFitnessCurrentGen;
        if nSteadyIterations == nMaxSteadyIterations
            break
        end
        
        % Calculate fitness score for entire population
        for i = 1:populationSize
            chromosome = population(i).Chromosome;
            errors = EvaluateIndividual(chromosome, functionData, constantRegister, variableRegister, operators, cMax);
            if errors < 0.01
                matlab.io.saveVariablesToScript('BestChromosome.m', 'bestChromosome');
            end
            chromosomeLength = length(chromosome);
            penalty = 1;
            if chromosomeLength > maxChromosomeLength
                penalty = exp(chromosomeLength-maxChromosomeLength);
            end
            fitness(i) = 1/errors * 1/penalty;
            % Save info about best individual
                if (fitness(i) > maximumFitness)
                    maximumFitness = fitness(i);
                    bestIndividualIndex = i;
                    bestChromosome = chromosome;
                    for k = 1:nDataPoints
                        xVal = functionData(k,1);
                        yVals(k) = GetEstimate(chromosome, xVal, numberOfVariableRegisters, constantRegister, operators, cMax);
                    end
                    set(chromosomeHandle, 'YData', yVals)
                    drawnow
                    
                    maxFitnessCurrentGen = maximumFitness;
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
        
        % Calculate diversity
        diversity = ComputeDiversity(population, numberOfVariableRegisters, numberOfConstantRegisters, numberOfOperands);
        
        if diversity < Dmin
            mutationProbability = mutationProbability*alpha;
        elseif diversity == Dmin
            mutationProbability = mutationProbability;
        elseif diversity > Dmax
            mutationProbability = mutationProbability/alpha;
        end  
        
        % Mutate new generation
        for i = 1:populationSize
            originalChromosome = tempPopulation(i).Chromosome;
            chromosomeLength = length(originalChromosome);
            individualMutationProbability = mutationProbability / chromosomeLength;
            mutatedChromosome = Mutate(originalChromosome, individualMutationProbability, numberOfVariableRegisters, numberOfConstantRegisters, numberOfOperators);
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

