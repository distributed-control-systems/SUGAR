close all
clear all
CGA(2, "verbose") % Initialize Conformal Geometric Algebra (CGA) in 2D with verbose mode enabled.

%% Generating Points and Geometric Entities
% This section generates three points with a random offset and constructs 
% different geometric entities such as dipoles, circles, and lines.

off = 1 * rand * e1 + 1 * rand * e2; % Generate a random offset in 2D space.
p1 = push(e1 + off); % Transform the first point to CGA.
p2 = push(e2 + off); % Transform the second point.
p3 = push(-e1 + off); % Transform the third point.

point = p1; % Assign the first point.
dipole = point .^ p2; % Compute the dipole (outer product of two points).
circle = dipole .^ p3; % Compute the circle (outer product of three points).
flat_point = p1 .^ ni; % Construct a "flat" point (a point at infinity).
line = p1 .^ p2 .^ ni; % Compute the line passing through p1 and p2.

%% Display and Plot a Point
clc % Clear command window
point % Display the point's algebraic representation.
point.plot() % Plot the point.
point.info() % Show detailed information about the point.

%% Dual Representation of a Point
point.dual % Compute the dual of the point.
point.dual.plot() % Plot the dual representation.
point.dual.info() % Show detailed information about the dual representation.

%% Display and Plot a Dipole (Point Pair)
dipole % Display the dipole representation.
dipole.plot() % Plot the dipole.
dipole.info() % Show detailed information about the dipole.

%% Dual Representation of a Dipole
dipole.dual % Compute the dual of the dipole.
dipole.dual.plot() % Plot the dual dipole.
dipole.dual.info() % Show detailed information about the dual dipole.

%% Display and Plot a Circle
circle % Display the circle representation.
circle.plot() % Plot the circle.
circle.info() % Show detailed information about the circle.

%% Dual Representation of a Circle
circle.dual % Compute the dual of the circle.
circle.dual.plot() % Plot the dual representation of the circle.
circle.dual.info() % Show detailed information about the dual representation.

%% Flats: Flat Points and Lines
flat_point % Display the flat point representation.
flat_point.plot() % Plot the flat point.
flat_point.info() % Show detailed information about the flat point.

%% Dual Representation of a Flat Point
flat_point_dual = flat_point.dual % Compute the dual of the flat point.
flat_point_dual.plot() % Plot the dual flat point.
flat_point_dual.info() % Show detailed information about the dual flat point.

%% Construct and Plot a Line
line = dipole .^ ni % Compute the line using the dipole and the null vector.
line.plot() % Plot the line.
line.info() % Show detailed information about the line.

%% Dual Representation of a Line
line_dual = line.dual() % Compute the dual of the line.
line_dual.plot() % Plot the dual representation of the line.
line_dual.info() % Show detailed information about the dual line.