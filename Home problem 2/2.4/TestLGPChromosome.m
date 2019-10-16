clf;

numberOfVariableRegisters = 3;
numberOfConstantRegisters = 3;
constantRegister = [1, -1, -3];

operators = ['+', '-', '*', '/'];
numberOfOperators = length(operators);

functionData = LoadFunctionData();
nDataPoints = length(functionData);

cMax = 10^5;
chromosome = BestChromosome();

errors = EvaluateIndividual(chromosome, functionData, constantRegister, variableRegister, operators, cMax);
fprintf('The error is %d\n', errors);

f = GetSymbolicFunction(chromosome, numberOfVariableRegisters, constantRegister, operators, cMax);
fprintf('The symbolic function is %s\n', f);

figureHandle = figure(1);
hold on
dataFunctionHandle = scatter(functionData(:,1), functionData(:,2), 'c');
chromosomeHandle = plot(functionData(:,1),zeros(1,201), 'k');
legend({'Function data points','Obtained function'},'Location','southeast');

syms x
xVal = functionData(:,1);
yVal = 0;
for i = 1:nDataPoints
    x = xVal(i);
    yVal(i) = subs(f, x);
end

set(chromosomeHandle, 'YData', yVal);