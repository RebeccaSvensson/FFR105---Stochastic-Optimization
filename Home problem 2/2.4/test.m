clf;

numberOfVariableRegisters = 3;
numberOfConstantRegisters = 3;
numberOfVariables = 6;
numberOfOperands = numberOfVariableRegisters + numberOfConstantRegisters;
variableRegister = zeros(numberOfVariableRegisters, 1);
constantRegister = [1, -1, -3];

operators = ['+', '-', '*', '/'];
numberOfOperators = length(operators);

functionData = LoadFunctionData();
cMax = intmax;


%chromosome = [2,2,6,2,2,2,5,3,2,3,1,2,4,3,3,2,4,2,4,4,1,2,6,2,4,1,6,1,2,2,5,3,1,2,6,2,1,1,6,3,2,2,5,5,1,2,5,3,4,2,5,3,2,2,2,3,4,3,3,1,4,3,3,4,2,2,2,3,4,3,3,2,2,2,2,3,1,3,1,2,4,3,3,2,1,1,6,3,2,2,5,4,2,2,5,4,4,1,3,2];
chromosome = [1 2 1 1 1 2 5 1 3 2 6 2 4 2 3 1 1 2 1 3 3 3 2 1 4 2 2 ...
                  2 4 2 5 1 4 1 5 2 1 3 4 3 2 2 2 3 2 3 4 3 1 3 4 2 1 3 ...
                  2 1 1 3 4 2 1 2 2 3 4 2 5 1 1 2 1 3 1 3 5 1 1 3 4 3 4 ...
                  1 4 2 4 2 5 1 1 3 4 3 1 2 1 3 4 1 4 2];
%chromosome = [1,2,1,4,3,3,1,5,3,1,2,3,3,3,3,3,1,3,2,3,4,2,1,3];
f = GetStringFunctions(chromosome, numberOfVariableRegisters, constantRegister, operators, cMax)
%f = DecodeChromosome(chromosome, numberOfVariables, constantRegister, cMax);
figureHandle = figure(1);
hold on
dataFunctionHandle = plot(functionData(:,1), functionData(:,2));
chromosomeHandle = plot(functionData(:,1),zeros(1,201));

for k = 1:nDataPoints
    xVal = functionData(k,1);
    yVals(k) = GetEstimate(chromosome, xVal, numberOfVariableRegisters, constantRegister, operators, cMax);
end
set(dataFunctionHandle, 'YData', yVals)
drawnow

syms x
%fSym = str2sym(fString)
%f = simplify(fSym)

xVal = functionData(:,1);
yVal = 0;
for i = 1:length(xVal)
    x = xVal(i);
    yVal(i) = subs(f, x);
end
set(chromosomeHandle, 'YData', yVal)