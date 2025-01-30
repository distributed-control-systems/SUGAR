% CGA BASICS
CGA(2) % Initialize Conformal Geometric Algebra (CGA) in 2D.
hold on

%% Building a point in CGA
% A point in CGA has two possible representations:
% - As a simple vector.
% - As a trivector.
% This depends on the chosen duality of representation.

% Let's define a point P in Euclidean space with coordinates (a, b)
syms a b
P = a*e1 + b*e2; % Euclidean point representation

% The equivalent CGA representation is constructed as follows:
P_CGA = n0 + P + 1/2 * P .* P * ni;

% A key property of this representation:
% - The inner product of the point with itself is always zero.
simplify(P_CGA .* P_CGA)

% This also holds true in the dual representation of the point.
P_CGA_d = dual(P_CGA);
simplify(P_CGA_d .* P_CGA_d)

% This property allows us to identify whether an object is a point, 
% regardless of whether it is in dual or standard representation.

% Recovering the Euclidean coordinates of a CGA point:
E = n0 .^ ni; % Euclidean subspace representation
Ei = E^-1; % Inverse of Euclidean subspace
P_eucl = ((P_CGA * (-P_CGA .* ni)^-1) .^ E) * Ei

% If the point is in dual notation, first convert it to standard form.
P_eucl = ((P_CGA_d.dual * (-P_CGA_d.dual .* ni)^-1) .^ E) * Ei

% Identifying the representation format:
% - If P.grade(3) == 0, then the object is in standard basis.
% - If P.grade(3) ~= 0, then it is in dual representation.

% Plotting a single point using `P.plot()`
a = 2; b = 1;
p = a*e1 + b*e2; % Define Euclidean coordinates
P = n0 + p + 1/2 * p .* p * ni; % Convert to CGA representation
P.plot(); % Plot the point
P.info(); % Display information about the multivector

%% Constructing a point pair
% A point pair is equivalent to a 1D circle (a segment in projective geometry).
p1 = e2 - e1; % Define the first point
p2 = e1 - e2; % Define the second point
P1 = push(p1); % Convert to CGA representation
P2 = push(p2);
PP = P1 .^ P2; % Compute the outer product of the two points
PP.plot(); % Plot the point pair

%% Constructing a circle from three points
% A circle in CGA is defined by three points.
p1 = -1*e1 + 2*e2;
p2 = e1 + e2;
p3 = e2 - 2*e1;

P1 = push(p1); % Convert to CGA representation
P2 = push(p2);
P3 = push(p3);

PPP = P1 .^ P2 .^ P3; % Compute the outer product of the three points
PPP.plot(); % Plot the resulting circle

%% Comparing grade differences among the objects
% The basis representation and vector representation of the point, point pair, and circle.
[P.BasisNames; P.vector; PP.vector; PPP.vector].'

%% Intersecting two circles
% Define two circles and compute their intersection.

r = 2; % Circle radius
C1 = push(-1*e1 + 1*e2) - 1/2 * r^2 * ni; % Define first circle
C2 = push(1*e1) - 1/2 * r^2 * ni; % Define second circle

C1.plot(); % Plot first circle
hold on
C2.plot(); % Plot second circle

% Compute the intersection using the dual operator
DP = dual(normal(C1) .^ normal(C2));
DP.plot(); % Plot the intersection
grid on

%% Animation: Two circles moving and intersecting
% This loop animates the intersection of two moving circles.

p1c1 = push(-2*e1);
p2c1 = push(2*e2);
p3c1 = push(2*e1);
C1 = normalize(p1c1 .^ p2c1 .^ p3c1); % First circle

for off = 6:-0.1:-16
    % Define the second moving circle
    p1c2 = push(5*e1 + off*e1);
    p2c2 = push(-e1 + off*e1);
    p3c2 = push(2*e1 + 2.5*e2 + off*e1);
    C2 = normalize(p1c2 .^ p2c2 .^ p3c2);

    hold off
    C1.plot(); % Plot first circle
    hold on
    C2.plot(); % Plot second circle

    % Compute and plot the intersection
    intersection = (dual((dual(C1)) .^ (dual(C2)))); % Compute meet operation
    intersection.plot();

    grid on

    % Set axis limits to follow the movement of the second circle
    xlim([-17, 6])
    ylim([-10, 8])

    drawnow(); % Update the plot for animation effect
end