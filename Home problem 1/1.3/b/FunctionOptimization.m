clear all;

% Variable initialization
populationSize = 100;
numberOfGenes = 50;
variablesPerChromosome = 2;
crossoverProbability = 0.8;
mutationProbability = [0.00, 0.02, 0.05, 0.1];
tournamentSelectionParameter = 0.75;
variableRange = 10.0;
numberOfGenerations = 100;
tournamentSize = 2;
nCopies = 1;
nRuns = 100;
bestFitness = zeros(nRuns, 1);

for k = 1:size(mutationProbability, 2)
    
    for j = 1:nRuns
        fitness = zeros(populationSize,1);

        decodedPopulation = zeros(populationSize, 2);

        % Initialize population
        population = InitializePopulation(populationSize, numberOfGenes);

        for iGeneration = 1:numberOfGenerations

            maximumFitness = 0.0; % Assumes non-negative fitness values!
            xBest = zeros(1,2); 
            bestIndividualIndex = 0;

            % Calculate fitness score for entire population
            for i = 1:populationSize
                chromosome = population(i,:);
                x = DecodeChromosome(chromosome, variablesPerChromosome, variableRange);
                decodedPopulation(i,:) = x;
                fitness(i) = EvaluateIndividual(x);
                % Save info about best individual
                    if (fitness(i) > maximumFitness)
                        maximumFitness = fitness(i);
                        bestIndividualIndex = i;
                        xBest = x;
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
                    newChromosomePair = Cross(chromosome1, chromosome2);
                    tempPopulation(i,:) = newChromosomePair(1,:);
                    tempPopulation(i+1,:) = newChromosomePair(2,:);
                else
                    tempPopulation(i,:) = chromosome1;
                    tempPopulation(i+1,:) = chromosome2;
                end
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

        bestFitness(j) = maximumFitness;
        minValue = 1/maximumFitness;

    end
    
    disp('mutation probability = ');
    disp(mutationProbability(k));
    disp('median fitness');
    disp(median(bestFitness));
end
