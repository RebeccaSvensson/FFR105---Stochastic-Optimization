clc; clear all;

mu = [1; 10; 100; 1000];
x = [1; 2];
step_length = 0.0001;
threshold = 1e-6;

x1_values = [];
x2_values = [];

for i = 1:size(mu)
    located_minima = RunGradientDescent(x, mu(i), step_length, threshold);
    x1_values(i) = located_minima(1);
    x2_values(i) = located_minima(2);
end

table(mu, x1_values', x2_values', 'VariableNames', {'mu', 'x1', 'x2'})

