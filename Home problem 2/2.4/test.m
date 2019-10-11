numberOfVariableRegisters = 6;
numberOfConstantRegisters = 6;
numberOfOperands = numberOfVariableRegisters + numberOfConstantRegisters;
variableRegister = zeros(numberOfVariableRegisters, 1);
constantRegister = [1, 5, -10, -1, 4, 7];

operators = ['+', '-', '*', '/'];
numberOfOperators = length(operators);

functionData = LoadFunctionData();
cMax = 1;

chromosome = [3,4,2,3,2,5,5,8,3,2,8,7,2,1,1,12,4,2,1,10,4,2,8,8,4,4,11,7,3,1,3,1,4,2,10,1,2,6,1,10,3,2,10,9,4,5,5,9,2,6,10,11,1,3,7,9,2,3,6,4,2,1,9,5];
for k = 1:nDataPoints
    xVal = functionData(k,1);
    yVals(k) = GetEstimate(chromosome, xVal, numberOfVariableRegisters, constantRegister, operators, cMax);
end  
