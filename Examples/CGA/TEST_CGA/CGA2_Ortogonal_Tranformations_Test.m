clc
clear all
CGA(2) % Initialize the Conformal Geometric Algebra (CGA) environment in 2D.

%% Test points on a grid
% Generate a grid of points in 2D space.

X = 2:0.1:3; % Define the range of X values.
Y = 2:0.1:3; % Define the range of Y values.

P = make_points_from_grid(X, Y); % Create points from the grid.
[m, n] = size(P); % Get the number of generated points.

%% Rotation
% Apply a rotation transformation to the points.

R = make_rotation(pi/4, e12); % Create a rotation of π/4 radians around the e12 plane.
Pi = []; % Initialize an empty array for rotated points.

for i = 1:n
    Pi = [Pi, R.reverse * P(i) * R]; % Apply the rotation to each point.
end

% Plot the original and rotated points.
figure; axis equal; grid on; hold on
for i = 1:n
    P(i).plot(); % Plot the original points.
    Pi(i).plot(); % Plot the rotated points.
end
push(0).plot(); % Plot the origin or reference point.
title("Rotation example");
%% Translation
% Apply a translation transformation to the points.

R = make_translation(4, -e1); % Create a translation of 4 units along the -e1 direction.
Pi = []; % Reset the transformed points array.

for i = 1:n
    Pi = [Pi, R.reverse * P(i) * R]; % Apply the translation to each point.
end

% Plot the original and translated points.
figure; axis equal; grid on; hold on
for i = 1:n
    P(i).plot(); % Plot the original points.
    Pi(i).plot(); % Plot the translated points.
end
push(0).plot(); % Plot the reference point.
title("Traslation example");

%% Dilation
% Apply a dilation (scaling) transformation to the points.

R = make_dilation(1); % Create a dilation transformation.
Pi = []; % Reset the transformed points array.

for i = 1:n
    Pi = [Pi, R.reverse * P(i) * R]; % Apply the dilation to each point.
end

% Plot the original and dilated points.
figure; axis equal; grid on; hold on
for i = 1:n
    P(i).plot(); % Plot the original points.
    Pi(i).plot(); % Plot the dilated points.
end
push(0).plot(); % Plot the reference point.
title("Dilation example");

%% Inversion
% Apply an inversion transformation using a circle as the inversion element.

p1 = point([4.5, 0]); % Define a point at (4.5, 0).
p2 = point([-4.5, 0]); % Define a point at (-4.5, 0).
p3 = point([0, 4.5]); % Define a point at (0, 4.5).

C = p1 .^ p2 .^ p3; % Compute the circle from three points using outer product.

% Define a function for a circle with center (x, y) and radius r.
Circle = @(x, y, r) (n0 + x * e1 + y * e2 + 0.5 * (x * x + y * y - r^2) * ni);
C = Circle(1, 1, 1.5); % Create a specific circle at (1,1) with radius 1.5.

R = make_inverssion(C); % Compute the inversion transformation.

Pi = []; % Reset the transformed points array.

for i = 1:n
    Pi = [Pi, C.reverse * P(i) * C]; % Apply the inversion to each point.
end

% Plot the original and inverted points.
figure; axis equal; grid on; hold on
for i = 1:n
    P(i).plot(); % Plot the original points.
    Pi(i).plot(); % Plot the inverted points.
end
C.plot(); % Plot the inversion circle.
title("Inversion example");

%% Accessory function
% Function to generate a set of points from a given grid.

function r = make_points_from_grid(x, y)
    point = evalin('base', 'point'); % Retrieve the 'point' function from the base workspace.
    P = []; % Initialize an empty array to store points.
    
    [m, n] = size(x); % Get the grid size.

    for i = 1:n
        for j = 1:n
            P = [P, point([x(i), y(j)])]; % Create a point for each (x, y) coordinate.
        end
    end
    
    r = P; % Return the generated points.
end