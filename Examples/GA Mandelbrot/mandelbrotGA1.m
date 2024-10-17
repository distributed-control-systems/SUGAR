function mandelbrotGA1(n, niter)
% MANDELBROTGA1 Mandelbrot plot in Geometric Algebra when p + q + r = 1.
% This function generates a Mandelbrot set plot using a 2-dimensional
% algebra, equivalent to using complex numbers.
%
% Parameters:
% n     - Resolution of the plot (number of points along each axis).
% niter - Number of iterations for the Mandelbrot calculation.
%
% The algorithm iteratively applies the function z = z^2 + b to generate
% the Mandelbrot set.
%
% Example usage:
% mandelbrotGA1(1000, 30) - generates a conventional Mandelbrot plot.

% Set the axis limits for the plot
y0 = -1.7; y1 = 1.7; step = (y1 - y0) / n; % Y-axis range and step size
x0 = -2.5; x1 = 0.9;                      % X-axis range
valsy = y0:step:y1;                       % Y-axis values
valsx = x0:step:x1;                       % X-axis values

% Select the algebra, in this case, complex numbers (2D algebra)
GA([0 1 0])

% Define symbolic components for the iteration
syms a0 a1 b0 b1 real

% Define symbolic multivectors a and b
a = a0 + a1 * e1;
b = b0 + b1 * e1;

% Define the standard Mandelbrot iteration: z = z^2 + b
iteration = a^2 + b;
modulus = abs(a);

% Extract components for conversion into a MATLAB function
mod_vec = modulus.vector;
vector_iter = iteration.vector;

% Create the iterating function as a MATLAB function
function_iter = matlabFunction(vector_iter(1), ...
                               vector_iter(2), ...
                               mod_vec(1), "Outputs", {'z0', 'z1', 'mod'});

% Generate the mesh grid for plotting
[B0, B1] = meshgrid(valsx, valsy);

% Initialize multivector components for each point in the plane
z0 = zeros(size(B0));
z1 = zeros(size(B0));

% Initialize the iteration result tracker
k = zeros(size(B0));

% Perform the iterative calculation
for ii = 1:niter
    [z0, z1, mm] = function_iter(z0, z1, B0, B1);
    % Update the iteration result based on divergence
    k(abs(mm) > 5 & k == 0) = niter - ii;
end

% Plot the Mandelbrot set and set the axis properties
figure
imagesc(valsx, valsy, k);
colormap parula
axis square

end