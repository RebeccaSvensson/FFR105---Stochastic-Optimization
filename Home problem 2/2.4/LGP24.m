clear all; clc; clf;

% Variable initialization
populationSize = 40;
mutationProbability = 3;
tournamentSelectionParameter = 0.75;
crossoverProbability = 0.8;
numberOfGenerations = 500000;
tournamentSize = 6;
nCopies = 3;
nRuns = 100000;
cMax = 10^5;
minChromosomeLength = 4;
maxChromosomeLength = 100;
Dmin = 0.69;
alpha = 1.1;

% Initialize registers
constantRegister = [1, -1, -3];
numberOfConstantRegisters = length(constantRegister);
numberOfVariableRegisters = 3;
numberOfOperands = numberOfVariableRegisters + numberOfConstantRegisters;
operators = ['+', '-', '*', '/'];
numberOfOperators = length(operators);

functionData = LoadFunctionData();
nDataPoints = length(functionData);

figureHandle = figure(1);
hold on
dataFunctionHandle = plot(functionData(:,1), functionData(:,2));
chromosomeHandle = plot(functionData(:,1),zeros(1,201));

% Used to reinitialize if fitness hasn't been updated in nMaxSteadyIterations
nMaxSteadyIterations = 5000;
maxFitnessLastGeneration = 0;
nSteadyIterations = 0;

for j = 1:nRuns
   
    globalMaximumFitness = 0;
    globalbestChromosome = 0;
    maximumFitness = 0.0;
    
    fitness = zeros(populationSize,1);

    % Initialize population
    population = InitializePopulation(populationSize, minChromosomeLength, maxChromosomeLength, numberOfVariableRegisters, numberOfConstantRegisters, numberOfOperators);
    foundFunction = 0;
    currentRunMutationProbability = mutationProbability;
    
    for iGeneration = 1:numberOfGenerations
        
        if mod(iGeneration, 100) == 0
            fprintf('Generation number: %d. \n', iGeneration);
        end
        
        if maximumFitness == maxFitnessLastGeneration
            nSteadyIterations = nSteadyIterations + 1;
            if nSteadyIterations == nMaxSteadyIterations
                if foundFunction == 1
                    f = GetSymbolicFunction(chromosome, numberOfVariables, constantRegister, operators, cMax);
                    fprintf('The wanted function is %d', f);
                    return
                else
                    break
                end
            end
        else
            nSteadyIterations = 0;
        end
        
        maxFitnessLastGeneration = maximumFitness;
        
        if foundFunction == 1
            if maximumFitness < maxFitnessLastGeneration
                matlab.io.saveVariablesToScript('BestChromosomeNew.m', 'bestChromosome');
            end
        end
                
        maximumFitness = 0.0; % Assumes non-negative fitness values!
        bestChromosome = 0; 
        bestIndividualIndex = 0;
        
        % Calculate fitness score for entire population
        for i = 1:populationSize
            chromosome = population(i).Chromosome;
            errors = EvaluateIndividual(chromosome, functionData, constantRegister, numberOfVariableRegisters, operators, cMax);
            if foundFunction == 0
                if errors < 0.01
                    matlab.io.saveVariablesToScript('BestChromosomeNew.m', 'bestChromosome');
                    foundFunction = 1;
                end
            end

            fitness(i) = GetFitness(chromosome, errors, maxChromosomeLength);
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
        diversity = ComputeDiversity(population);
        
        if diversity < Dmin
            currentRunMutationProbability = currentRunMutationProbability*alpha;
        elseif diversity > Dmin
            currentRunMutationProbability = currentRunMutationProbability/alpha;
        end  
        
        % Mutate new generation
        for i = 1:populationSize
            originalChromosome = tempPopulation(i).Chromosome;
            chromosomeLength = length(originalChromosome);
            individualMutationProbability = currentRunMutationProbability / chromosomeLength;
            mutatedChromosome = Mutate(originalChromosome, individualMutationProbability, numberOfVariableRegisters, numberOfConstantRegisters, numberOfOperators);
            tempPopulation(i).Chromosome = mutatedChromosome;
        end
        
        % Insert best individual to the nCopies first positions
        bestIndividual = population(bestIndividualIndex).Chromosome;
        tempPopulation = InsertBestIndividual(tempPopulation,...
            bestIndividual, nCopies);
        population = tempPopulation;
    
        if maximumFitness > globalMaximumFitness
            globalMaximumFitness = maximumFitness;
            globalBestChromosome = bestChromosome;
            
            fprintf('New global maximum fitness found. Fitness value = %f \n', globalMaximumFitness);
            
            for k = 1:nDataPoints
                xVal = functionData(k,1);
                yVals(k) = GetEstimate(globalBestChromosome, xVal, numberOfVariableRegisters, constantRegister, operators, cMax);
            end
            set(chromosomeHandle, 'YData', yVals)
            drawnow

        end
        
    end
    
end

