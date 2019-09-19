clc; clear all;

mu = 1;
x = [1, 2];
step_length = 0.0001;
threshold = exp(-6);

RunGradientDescent(x, mu, step_length, threshold)
disp(x)
