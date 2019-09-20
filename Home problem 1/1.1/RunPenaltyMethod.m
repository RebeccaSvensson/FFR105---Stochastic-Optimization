clc; clear all;

mu = 1000;
x = [1, 2];
step_length = 0.0001;
threshold = 1e-6;

RunGradientDescent(x, mu, step_length, threshold)
