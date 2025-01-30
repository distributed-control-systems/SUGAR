% This example implements the iconic **PGA dynamics for 2D solid bodies**.
% The theoretical background can be found in the document:
%   "PGA Dynamics" - https://bivector.net/PGAdyn.pdf
%
% This script simulates the motion of a rigid body in **2D Projective Geometric Algebra (PGA)**
% under forces such as **gravity, Hookean forces (spring attachment), and damping**.
% The animation showcases the real-time evolution of the system.

clear all

%% 1. INITIALIZE 2D PROJECTIVE GEOMETRIC ALGEBRA (PGA)
% -------------------------------------------------------------------
% The algebra `[2,0,1]` represents a **2D PGA system**.
% The third basis element `e3` acts as the "point at infinity" 
% needed for translations in PGA.

GA([2,0,1])  

% Functions to convert between PGA representation and Cartesian coordinates:
Point2PGA = @(x, y) dual(x*e1 + y*e2 + e3);  % Convert (x, y) to PGA
PGA2Point = @(P) [P(e23), -P(e13)];  % Extract Cartesian coordinates from PGA representation

%% 2. DEFINE THE RIGID BODY SHAPE
% -------------------------------------------------------------------
% A **square** is used as the rigid body representation.
% It consists of four **corner points** expressed in PGA.

points_list = [Point2PGA(-0.5, -0.5), ... % Bottom-left corner
               Point2PGA( 0.5, -0.5), ... % Bottom-right corner
               Point2PGA( 0.5,  0.5), ... % Top-right corner
               Point2PGA(-0.5,  0.5)] % Top-left corner

% Define the **attachment point** on the square (point used for constraints)
attaching_index = 4;
attached = points_list(attaching_index);

% Define an **external attachment point** (fixed reference point)
x_attach = -0.5; 
y_attach = 1;
attach = Point2PGA(x_attach, y_attach);

% -------------------------------------------------------------------
% IMPORTANT NOTE ON FORMULAS (Reference: PGA Dynamics PDF)
% -------------------------------------------------------------------
% The original document defines transformations using `exp(-1/2 * B t)`,
% with a note explaining that this guarantees proper orientation and displacement
% signs. However, in **SUGAR (this implementation)**, the basis elements are
% chosen in a more intuitive way. 
%
% - **Rotations** follow the **clockwise** direction.
% - **Translations** follow the **right (x) and up (y) positive direction**.
%
% Therefore, in **SUGAR**, we can use the natural exponentiation: `exp(1/2 * B t)`.

%% 3. DEFINE THE FORCE MODEL
% -------------------------------------------------------------------
% This function computes the **forces** acting on the system.
% It includes:
%   - **Gravity**: Acts downward (-e23 direction).
%   - **Hookean Force** (Spring): Acts between the body and the fixed attachment.
%   - **Damping**: Acts opposite to velocity.

F = @(S) dual(S(1).reverse * (-9.8 * e23) * S(1)) + ... % Gravity (downward)
         -12 * (attached & (S(1).reverse * attach * S(1))) + ... % Spring force (Hooke's Law)
         dual(-0.25 * S(2));  % Damping (opposes motion)

%% 4. DEFINE THE EQUATIONS OF MOTION
% -------------------------------------------------------------------
% The **state derivative function** calculates the time evolution 
% of the rigid body's position and velocity.
% This follows from Newton’s second law **F = m*a**, implemented as:
%
%   State_derivative(S) = [ 0.5 * S(1) * S(2), 
%                           dual(F(S) + 0.5 * (S(2).dual * S(2) - S(2) * S(2).dual)).grade(2) ]
%
% - `S(1)` is the **position state** (current transformation).
% - `S(2)` is the **velocity state** (current velocity).
% - The **derivative of velocity** comes from the applied force and system dynamics.

State_derivative = @(S) [0.5 * S(1) * S(2), ...
                         dual(F(S) + 0.5 * (S(2).dual * S(2) - S(2) * S(2).dual)).grade(2)];

% **No additional negative sign** is needed, since torque already carries the correct sign.

%% 5. SYMBOLIC REPRESENTATION OF THE DYNAMICS
% -------------------------------------------------------------------
% We define **symbolic variables** to analyze the equations of motion.

syms R Dx Dy Rs Dxs Dys real % Rotation, displacement, angular velocity, linear velocity

% Define the **symbolic state**:
state = [exp(1/2 * (Dx * e13 + Dy * e23 + R * e12)), ... % Position state
         Dxs * e13 + Dys * e23 + Rs * e12];             % Velocity state

% Compute the symbolic **state derivative**
SD = State_derivative(state).';

% Display the **state-space-like equations of motion**:
[vector(SD(1)).'; vector(SD(2)).']

%% 6. ANIMATION OF THE SYSTEM DYNAMICS
% -------------------------------------------------------------------
% WARNING: This animation is computationally expensive.
% If you need a **faster animation**, use `matlabFunction` to optimize computations.

x = zeros(1,6);
y = x;
x(end) = x_attach;
y(end) = y_attach;

% Initial plot setup
hold off

% Define the **initial state** (zero initial velocity, unit displacement)
Dx = 1; Dy = 0; R = 0; Dxs = 0; Dys = 0; Rs = 0;
state = [exp(1/2 * (Dx * e13 + Dy * e23 + R * e12)), ... % Initial position
         Dxs * e13 + Dys * e23 + Rs * e12];             % Initial velocity (zero)

% Initialize the transformation matrix `M`
M = state(1);

% Compute the **initial shape** of the square
for j = attaching_index:attaching_index+4
    P_plot = M * points_list(rem(j,4)+1) * M.reverse;  % Apply transformation
    p = PGA2Point(P_plot);  % Convert to (x, y) coordinates
    x(rem(j,4)+2) = p(1);
    y(rem(j,4)+2) = p(2);
    if attaching_index-1 == rem(j,4)
        x(1) = p(1);
        y(1) = p(2);
    end
end

% Plot the initial square shape
line = plot(x, y);
line.XDataSource = 'x';
line.YDataSource = 'y';
ylim([-3 3])
xlim([-3.5 2.5])
axis equal

% Perform the animation loop
for i = 1:400
    for j = 0:30
        state = state + 1/600 * State_derivative(state); % Integrate motion
    end
    M = state(1);
    Mr = ~M; % Inverse transformation

    for j = attaching_index:attaching_index+4
        P_plot = M * points_list(rem(j,4)+1) * Mr;
        p = PGA2Point(P_plot);
        x(rem(j,4)+2) = p(1);
        y(rem(j,4)+2) = p(2);
        if attaching_index-1 == rem(j,4)
            x(1) = p(1);
            y(1) = p(2);
        end
    end
    plot(x, y)
    ylim([-3 3])
    xlim([-3.5 2.5])
    drawnow
end