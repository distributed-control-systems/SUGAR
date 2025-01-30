close all
clear all
CGA(3, "verbose") % Initialize Conformal Geometric Algebra (CGA) in 3D with verbose mode.

%% Generating Points and Basic Round Structures
% This section generates four points with a random offset and constructs 
% different geometric entities such as dipoles, circles, spheres, and planes.

off = 1 * rand * e1 + 1 * rand * e2 + 1 * rand * e3; % Generate a random offset in 3D space.
p1 = push(e1 + off); % Transform the first point to CGA.
p2 = push(e2 + off); % Transform the second point.
p3 = push(e3 + off); % Transform the third point.
p4 = push(-e1 + off); % Transform the fourth point.

% Constructing fundamental geometric entities:
point = p1; % Assign the first point.
dipole = point .^ p2; % Compute the dipole (outer product of two points).
circle = dipole .^ p3; % Compute the circle (outer product of three points).
sphere = circle .^ p4; % Compute the sphere (outer product of four points).
point_f = p1 .^ ni; % Construct a "flat" point (a point at infinity).
line = p1 .^ p2 .^ ni; % Compute the line passing through p1 and p2.
plane = p1 .^ p2 .^ p3 .^ ni; % Compute the plane defined by three points.

%% Display and Plot a Point
clc % Clear command window.
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

%% Display and Plot a Sphere
sphere % Display the sphere representation.
sphere.plot() % Plot the sphere.
sphere.info() % Show detailed information about the sphere.

%% Dual Representation of a Sphere
sphere.dual % Compute the dual of the sphere.
sphere.dual.plot() % Plot the dual representation.
sphere.dual.info() % Show detailed information about the dual representation.

%% Flats: Flat Points, Lines, and Planes
flat_point = point .^ ni % Compute the flat point representation.
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
dual_line = line.dual % Compute the dual of the line.
dual_line.plot() % Plot the dual representation of the line.
dual_line.info() % Show detailed information about the dual line.

%% Construct and Plot a Plane
plane = circle .^ ni % Compute the plane using the circle and the null vector.
plane.plot() % Plot the plane.
plane.info() % Show detailed information about the plane.

%% Dual Representation of a Plane (Fails)
% The computation of the dual representation of a plane seems to fail.
dual_plane = plane.dual % Compute the dual of the plane.
dual_plane.plot() % Plot the dual representation.
dual_plane.info() % Show detailed information about the dual plane.