function stationary_point = RunGradientDescent(x_start, mu, step_length, threshold)

x = x_start;
gradient = ComputeGradient(x, mu);

while (norm(gradient) > threshold)
    gradient = ComputeGradient(x, mu);

    x = x - step_length * gradient;
end

stationary_point = x;

end
