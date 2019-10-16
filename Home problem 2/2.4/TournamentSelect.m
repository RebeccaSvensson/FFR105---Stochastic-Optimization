function iSelected = TournamentSelect(fitness, pTournament, tournamentSize)
    
    tournamentPopulation = zeros(2, tournamentSize);
    populationSize = size(fitness, 1);
    
    for i = 1:tournamentSize
        index = 1 + fix(rand*populationSize);
        tournamentPopulation(1, i) = fitness(index);
        tournamentPopulation(2, i) = index;
    end
   
    [~,idx] = sort(tournamentPopulation(1,:), 'descend'); % sort only the first column
    sortedPop = tournamentPopulation(:,idx);
    
    iSelected = 0;
    
    for i = 1:tournamentSize
        r = rand;
        if (r < pTournament)
            iSelected = sortedPop(2,i);
            break;
        end 
    end
    
   if iSelected == 0
       iSelected = sortedPop(end);
   end
   
end
