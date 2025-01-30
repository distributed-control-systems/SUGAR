%% 1. INITIALIZE PROJECTIVE GEOMETRIC ALGEBRA (PGA 2D)
% -------------------------------------------------------------------
% This script models a **3-link planar robot arm** using **PGA 2D**.
% Each joint of the robot is **actuated by an angular rotation**, and each arm
% has a defined **length**. The robot moves dynamically in a **2D space**.
%
% The end-effector trajectory is visualized over time.

GA([2,0,1]) % Initialize 2D Projective Geometric Algebra (PGA)

%% 2. DEFINE SYMBOLIC VARIABLES
% -------------------------------------------------------------------
% Define **joint angles** (actuated by motors)
syms angle_1 angle_2 angle_3 real  

% Define **arm lengths** 
syms length_1 length_2 length_3 real  

%% 3. DEFINE CONVERSIONS BETWEEN CARTESIAN & PGA REPRESENTATION
% -------------------------------------------------------------------
% Functions to embed Cartesian **(x, y)** coordinates into **PGA**:
Point2PGA = @(x,y) dual(x*e1 + y*e2 + e3); % Convert Cartesian to PGA

% Function to **extract** Cartesian coordinates from PGA representation:
PGA2Point = @(P) [P(e23), -P(e13)]; % Extract (x, y) coordinates from PGA

% Define the **initial base point** (robot's base at the origin)
P0 = Point2PGA(0, 0); 

%% 4. DEFINE ROTORS FOR JOINT ROTATIONS & ARM DISPLACEMENTS
% -------------------------------------------------------------------
% The **motion of the robot** is represented using **rotors** in PGA.
% Each arm **first displaces along its length**, then **rotates at the joint**.

% Define **displacement rotors** (translational motion along arm length)
D1 = exp(length_1 / 2 * e13); % Displacement of the first arm
D2 = exp(length_2 / 2 * e13); % Displacement of the second arm
D3 = exp(length_3 / 2 * e13); % Displacement of the third arm

% Define **rotation rotors** (joint angles)
R1 = exp(-angle_1 / 2 * e12); % Rotation at the first joint
R2 = exp(-angle_2 / 2 * e12); % Rotation at the second joint
R3 = exp(-angle_3 / 2 * e12); % Rotation at the third joint

%% 5. COMPUTE ROBOT ARM KINEMATICS USING PGA
% -------------------------------------------------------------------
% The **total transformation rotor** for each arm is computed as:
% - `P1M`: First joint's rotation and displacement.
% - `P2M`: Second joint's rotation and displacement (relative to P1).
% - `P3M`: Third joint's rotation and displacement (relative to P2).

P1M = R1 * D1; % First arm rotor (rotates + displaces)
P2M = P1M * R2 * D2; % Second arm rotor (relative to first)
P3M = P2M * R3 * D3; % Third arm rotor (relative to second)

% Apply the rotors to transform the **base point P0** to each joint:
P1_robot = P1M * P0 * ~P1M; % Position of first joint
P2_robot = P2M * P0 * ~P2M; % Position of second joint
P3_robot = P3M * P0 * ~P3M; % Position of third joint (end-effector)

% Convert to **explicit symbolic equations** for kinematics:
P1_cin = PGA2Point(P1_robot); % (x, y) coordinates of first joint
P2_cin = PGA2Point(P2_robot); % (x, y) coordinates of second joint
P3_cin = PGA2Point(P3_robot); % (x, y) coordinates of end-effector

%% 6. CONVERT TO MATLAB FUNCTIONS FOR NUMERICAL SIMULATION
% -------------------------------------------------------------------
% These functions allow us to **evaluate kinematics numerically** and **plot results**.

P1_fin = matlabFunction(P1_cin);
P2_fin = matlabFunction(P2_cin);
P3_fin = matlabFunction(P3_cin);

%% 7. SIMULATION OF ROBOT MOTION
% -------------------------------------------------------------------
% This section simulates the **movement of the robot** over time.
% The angles are **varied sinusoidally** to generate a smooth motion.

length_1 = 1; length_2 = 1; length_3 = 1; % Set arm lengths
angle_1 = 0; angle_2 = pi/2; angle_3 = 0; % Initial joint angles

points = 500; % Number of simulation steps
ps = NaN * zeros(2, points); % Store end-effector trajectory

for k = (1:points)
    % Time-dependent joint angles (sinusoidal motion)
    t = k * 7 / points;
    angle_1 = sin(t);
    angle_2 = 2 * cos(t);
    angle_3 = cos(2 * t);

    % Compute the joint positions numerically
    P1_fix = P1_fin(angle_1, length_1);
    P2_fix = P2_fin(angle_1, angle_2, length_1, length_2);
    P3_fix = P3_fin(angle_1, angle_2, angle_3, length_1, length_2, length_3);

    % Store the **end-effector position** for trajectory visualization
    ps(:, k) = P3_fix;

    % Plot the robot arm at the current time step
    hold off
    plot([0 P1_fix(1)], [0 P1_fix(2)]) % First arm segment
    hold on
    plot([P1_fix(1) P2_fix(1)], [P1_fix(2) P2_fix(2)]) % Second arm segment
    plot([P2_fix(1) P3_fix(1)], [P2_fix(2) P3_fix(2)]) % Last arm segment
    plot(ps(1, :), ps(2, :)); % Plot the **end-effector trajectory**

    axis equal
    xlim([-4, 4])
    ylim([-4, 4])
    drawnow() % Update the plot dynamically
end

%% 8. STATIC PLOT OF FINAL ROBOT CONFIGURATION
% -------------------------------------------------------------------
% This section plots the **final robot configuration** with a fixed set of angles.

angle_1 = pi/4;
angle_2 = pi/4;
angle_3 = pi/4;

% Compute the final joint positions numerically
P1_fix = P1_fin(angle_1, length_1);
P2_fix = P2_fin(angle_1, angle_2, length_1, length_2);
P3_fix = P3_fin(angle_1, angle_2, angle_3, length_1, length_2, length_3);

% Store the final **end-effector position**
ps(:, k) = P3_fix;

% Plot the **final robot configuration**
plot([0 P1_fix(1)], [0 P1_fix(2)], 'k') % First segment
hold on
plot([P1_fix(1) P2_fix(1)], [P1_fix(2) P2_fix(2)], 'k') % Second segment
plot([P2_fix(1) P3_fix(1)], [P2_fix(2) P3_fix(2)], 'k') % Last segment

axis equal
xlim([-4, 4])
ylim([-4, 4])
