 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Ant system (AS) for TSP.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
clc;
clf;

addpath('../TSPgraphics')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cityLocation = LoadCityLocations();
numberOfCities = length(cityLocation);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numberOfAnts = 30;  
alpha = 1.0;        
beta = 3.0;         
rho = 0.5;          

nearestNeighbourPathLength = GetNearestNeighbourPathLength(cityLocation); 
tau0 = numberOfAnts/nearestNeighbourPathLength;

targetPathLength = 122.0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

range = [0 20 0 20];
tspFigure = InitializeTspPlot(cityLocation, range);
connection = InitializeConnections(cityLocation);
pheromoneLevel = InitializePheromoneLevels(numberOfCities, tau0); 
visibility = GetVisibility(cityLocation);                         

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main loop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
minimumPathLength = inf;

iIteration = 0;

while (minimumPathLength > targetPathLength)
iIteration = iIteration + 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate paths:
%%%%%%%%%%%%%%%%%%%%%%%%%%

pathCollection = [];
pathLengthCollection = [];
for k = 1:numberOfAnts
path = GeneratePath(pheromoneLevel, visibility, alpha, beta);   % To do: Write the GeneratePath function (and any necessary functions called by GeneratePath).
pathLength = GetPathLength(path,cityLocation);                  
if (pathLength < minimumPathLength)
minimumPathLength = pathLength;
disp(sprintf('Iteration %d, ant %d: path length = %.5f',iIteration,k,minimumPathLength));
PlotPath(connection,cityLocation,path);
bestPath = path;
matlab.io.saveVariablesToScript('BestResultFound.m', 'bestPath');
end
pathCollection = [pathCollection; path];           
pathLengthCollection = [pathLengthCollection; pathLength];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Update pheromone levels
%%%%%%%%%%%%%%%%%%%%%%%%%%

deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection);  % To do: write the ComputeDeltaPheromoneLevels function
pheromoneLevel = UpdatePheromoneLevels(pheromoneLevel,deltaPheromoneLevel,rho);          % To do: write the UpdatePheromoneLevels function

end
