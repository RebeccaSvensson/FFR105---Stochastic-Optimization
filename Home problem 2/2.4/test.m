clf;

numberOfVariableRegisters = 3;
numberOfConstantRegisters = 3;
numberOfOperands = numberOfVariableRegisters + numberOfConstantRegisters;
variableRegister = zeros(numberOfVariableRegisters, 1);
constantRegister = [1, -3, -5];

operators = ['+', '-', '*', '/'];
numberOfOperators = length(operators);

functionData = LoadFunctionData();
cMax = 10^5;

chromosome;
errors = EvaluateIndividual(chromosome, functionData, constantRegister, variableRegister, operators, cMax);


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
xVal = functionData(:,1);
yVal = 0;
for i = 1:length(xVal)
    x = xVal(i);
    yVal(i) = subs(f, x);
end
set(chromosomeHandle, 'YData', yVal)