function mandelbrotGA3(n, niter, p1, p2, p3, p4, p5, p6)
% MANDELBROTGA3 Mandelbrot plot in Geometric Algebra when p + q + r = 3.
% This function generates a Mandelbrot set plot using a plane within a 4-dimensional
% algebra, but additional parameters are needed to select the plotting plane.
%
% Parameters:
% n     - Resolution of the plot (number of points along each axis).
% niter - Number of iterations for the Mandelbrot calculation.
% p1    - Parameter for setting the e1 component in the iteration.
% p2    - Parameter for setting the e2 component in the iteration.
% p3    - Parameter for setting the e3 component in the iteration.
% p4    - Parameter for setting the e12 component in the iteration.
% p5    - Parameter for setting the e13 component in the iteration.
% p6    - Parameter for setting the e23 component in the iteration.
%
% The orientation of the plotting plane is always between the real component
% and the highest-order component of the algebra. The plane's position is
% determined by the parameters p1 to p6.
%
% Example usage:
% mandelbrotGA3(1000, 30, 0, 0, 0, 0, 0, 0) - recovers the standard Mandelbrot set.

% Set the axis limits for the plot
y0 = -1.7; y1 = 1.7; step = (y1 - y0) / n; % Y-axis range and step size
x0 = -2.5; x1 = 0.9;                      % X-axis range
valsy = y0:step:y1;                       % Y-axis values
valsx = x0:step:x1;                       % X-axis values

% Select the algebra
GA([3 0 0])

% Define symbolic components for the iteration
syms a0 a1 a2 a3 a12 a13 a23 a123 real
syms b0 b1 b2 b3 b12 b13 b23 b123 real

% Set fixed components for plotting plane
b1 = p1; b2 = p2; b3 = p3;  % Assign parameters to b1, b2, b3
b12 = p4; b13 = p5; b23 = p6;  % Assign parameters to b12, b13, b23

% Define symbolic multivectors a and b
a = a0 + a1 * e1 + a2 * e2 + a3 * e3 + a12 * e12 + a13 * e13 + a23 * e23 + a123 * e123;
b = b0 + b1 * e1 + b2 * e2 + b3 * e3 + b12 * e12 + b13 * e13 + b23 * e23 + b123 * e123;

% Define the standard Mandelbrot iteration: z = z^2 + b
iteration = a^2 + b;
modulus = a * a';

% Extract components for conversion into a MATLAB function
mod_vec = modulus.vector;
vector_iter = iteration.vector;

% Create the iterating function as a MATLAB function
function_iter = matlabFunction(vector_iter(1), ...
                               vector_iter(2), ...
                               vector_iter(3), ...
                               vector_iter(4), ...
                               vector_iter(5), ...
                               vector_iter(6), ...
                               vector_iter(7), ...
                               vector_iter(8), ...
                               mod_vec(1), "Outputs", {'z0', 'z1', 'z2', 'z3', 'z12', 'z13', 'z23', 'z123', 'mod'});

% Generate the mesh grid for plotting
[B0, B1] = meshgrid(valsx, valsy);

% Initialize multivector components for each point in the plane
z0 = zeros(size(B0));
z1 = zeros(size(B0));
z2 = zeros(size(B0));
z3 = zeros(size(B0));
z12 = zeros(size(B0));
z13 = zeros(size(B0));
z23 = zeros(size(B0));
z123 = zeros(size(B0));

% Initialize the iteration result tracker
k = zeros(size(B0));

% Perform the iterative calculation
for ii = 1:niter
    [z0, z1, z2, z3, z12, z13, z23, z123, mm] = function_iter(z0, z1, z2, z3, z12, z13, z23, z123, B0, B1);
    % Update the iteration result based on divergence
    k(abs(mm) > 5 & k == 0) = niter - ii;
end

% Plot the Mandelbrot set and set the axis properties
figure
imagesc(valsx, valsy, k);
colormap parula
axis square

end