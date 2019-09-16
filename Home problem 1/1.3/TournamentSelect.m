function iSelected = TournamentSelect(fitness, pTournament, tournamentSize)

    r = rand;
    fitness = sort(fitness);
    
    for i = 1:tournamentSize
        if (r < pTournament)
            iSelected = i;
            break;
        end
    end
   
end
