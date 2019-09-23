clc; clear all;

mu = [1, 10, 100, 1000];
x = [1, 2];
step_length = 0.0001;
threshold = 1e-6;

for i = 1:size(mu)
    RunGradientDescent(x, mu(i), step_length, threshold)
end

