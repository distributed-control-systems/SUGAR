% Simulation of body dynamics using a numerical approach instead of symbolic computation.
% 
% This example implements the **iconic PGA dynamics for 2D rigid bodies**.
% The theoretical foundation and detailed explanation can be found in:
%    "PGA Dynamics" - https://bivector.net/PGAdyn.pdf
%
% Unlike the symbolic version, this implementation **directly integrates** 
% the equations numerically, improving computational efficiency for simulation.

clear all
global attached attach

%% 1. INITIALIZE 2D PROJECTIVE GEOMETRIC ALGEBRA (PGA)
% -------------------------------------------------------------------
% The algebra `[2,0,1]` defines a **2D PGA system**.
% The third basis element `e3` acts as the "point at infinity" 
% needed for translations in PGA.

GA([2,0,1])  

% Functions to convert between PGA representation and Cartesian coordinates:
Point2PGA = @(x, y) dual(x*e1 + y*e2 + e3);  % Convert (x, y) to PGA representation
PGA2Point = @(P) [P(e23), -P(e13)];  % Extract Cartesian coordinates from PGA representation

%% 2. DEFINE THE RIGID BODY SHAPE
% -------------------------------------------------------------------
% A **square** is used as the rigid body representation.
% It consists of four **corner points** expressed in PGA.

points_list = [Point2PGA(-0.5, -0.5), ... % Bottom-left corner
               Point2PGA( 0.5, -0.5), ... % Bottom-right corner
               Point2PGA( 0.5,  0.5), ... % Top-right corner
               Point2PGA(-0.5,  0.5)];    % Top-left corner

% Define the **attachment point** on the square (point used for constraints)
attaching_index = 4;
attached = points_list(attaching_index);

% Define an **external attachment point** (fixed reference point)
x_attach = -0.5; 
y_attach = 1;
attach = Point2PGA(x_attach, y_attach);

%% 3. ANIMATION SETUP
% -------------------------------------------------------------------
% This section initializes the **animation variables**.
% `x` and `y` hold the updated positions of the square's vertices during the simulation.

x = zeros(1,6);
y = x;
x(end) = x_attach;
y(end) = y_attach;

% Initial plot setup
hold off

%% 4. INITIALIZE STATE VARIABLES
% -------------------------------------------------------------------
% The **state of the system** is represented by:
% - `M`: The **position state** (current transformation).
% - `B`: The **velocity state** (current velocity).

Dx = 1; Dy = 0; R = 0; Dxs = 0; Dys = 0; Rs = 0;

% Define the **initial transformation matrix** (position state)
M = exp(1/2 * (Dx * e13 + Dy * e23 + R * e12));  % Initial translations and rotations

% Define the **initial velocity state** (body velocity)
B = Dxs * e13 + Dys * e23 + Rs * e12;  % No initial angular or translational velocity

%% 5. TIME INTEGRATION LOOP (NUMERICAL SIMULATION)
% -------------------------------------------------------------------
% This loop integrates the **equations of motion** numerically using 
% a **simple Euler integration scheme**.
%
% - The position state (`M`) and velocity state (`B`) are updated iteratively.
% - The function `State_derivative(M, B)` calculates their time derivatives.

for i = 1:400
    for j = 0:30
        % Compute the **derivatives of M and B** based on the current state
        [Md, Bd] = State_derivative(M, B);
        
        % Update the state using Euler integration with a timestep of **1/600**
        M = M + 1/600 * Md;
        B = B + 1/600 * Bd;
    end
    
    % Compute the **inverse transformation** of M
    Mr = ~M;

    % Update the **positions of the square's vertices**
    for j = attaching_index:attaching_index+4
        P_plot = M * points_list(rem(j,4)+1) * Mr;  % Transform the vertex
        p = PGA2Point(P_plot);  % Convert to Cartesian coordinates
        x(rem(j,4)+2) = p(1);
        y(rem(j,4)+2) = p(2);
        if attaching_index-1 == rem(j,4)
            x(1) = p(1);
            y(1) = p(2);
        end
    end

    % Plot the updated shape
    plot(x, y)
    axis equal
    ylim([-3 3])
    xlim([-3.5 2.5])
    drawnow
end

%% 6. FUNCTIONS FOR DYNAMICS
% -------------------------------------------------------------------
% These functions define the **forces acting on the system** and 
% compute the **state derivatives** numerically.

%% 6.1 Forces Acting on the System
% -------------------------------------------------------------------
% This function calculates the **total force acting on the rigid body**.
% It includes:
% - **Gravity**: Acts downward (-e23 direction).
% - **Hookean Force** (Spring): Acts between the body and the fixed attachment.
% - **Damping**: Acts opposite to velocity, reducing oscillations.

function F = forces(M, B)
    global attached attach
    persistent e23
    if isempty(e23)
        e23 = MV([0 0 0 0 0 0 1 0], [2 0 1]); % Define the e23 basis element
    end
    
    F = dual(~M * (-9.8 * e23) * M) + ...  % Gravity (downward)
        -12 * (attached & (~M * attach * M)) + ... % Hookean force (spring restoring force)
        dual(-0.25 * B);  % Damping force (opposing velocity)
end

%% 6.2 Compute State Derivatives
% -------------------------------------------------------------------
% This function computes the **time derivatives** of `M` and `B`.
% The equations follow the standard PGA rigid body dynamics formulation:
%
%   - `Md = 0.5 * M * B`  (position update)
%   - `Bd = dual(F(M, B) + 0.5 * (B.dual * B - B * B.dual)).grade(2)` (velocity update)
%
% The function `forces(M, B)` computes the **external forces** acting on the body.

function [Md, Bd] = State_derivative(M, B)
    Md = 0.5 * M * B;
    
    % Compute the derivative of velocity
    Bd = dual(forces(M, B) + 0.5 * dual(B.dual * B - B * B.dual)).grade(2); 
end