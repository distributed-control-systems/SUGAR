% This example is extracted from the prominent library Ganja.js.
% The original example can be found at:
% https://enkimute.github.io/ganja.js/examples/coffeeshop.html#pga2d_differentiation
%
% The script demonstrates how **Projective Geometric Algebra (PGA)** can be used 
% for **automatic differentiation** by leveraging the properties of dual numbers.

% Initialize 2D Projective Geometric Algebra (PGA)
GA([2 0 1]) 

% IMPORTANT: Basis Differences between Ganja.js and SUGAR
% -------------------------------------------------------
% In Ganja.js, the **null basis** is denoted as **e0**.
% However, in SUGAR, basis elements are named in sequential order.
% Here, the **null basis is e3** instead of e0.

%% Embedding Dual Numbers in PGA
% --------------------------------------
% The **PGA2D framework** canonically embeds **dual numbers** as bivectors
% using **e13** and **e23**.
% These dual numbers can be used to compute **automatic differentiation**.
% 
% In this framework:
% - `dx = e13` acts as the **infinitesimal differential in the x-direction**.
% - `dy = e23` acts as the **infinitesimal differential in the y-direction**.

dx = e13; 
dy = e23;
    
%% Partial Derivatives using PGA Dual Numbers
% -----------------------------------------------
% The goal is to compute the **partial derivatives** of a function 
% using **automatic differentiation**.
%
% Consider the function:
%     f(x, y) = 3x² - 2y³
%
% By substituting `x + dx` and `y + dy`, we obtain:
% - The **e0 component** representing the original function.
% - The **dx and dy components** representing the **partial derivatives**.

% Define the function
f = @(x, y) 3*x*x - 2*y*y*y;

% Prepare two symbolic variables for symbolic computation
syms x y real

% Compute the function with symbolic inputs
f(x+dx, y+dy) 
% The output will be:
% - The e0 component corresponds to f(x, y) itself.
% - The e13 component (dx) represents ∂f/∂x.
% - The e23 component (dy) represents ∂f/∂y.

% Compute the function at a specific numerical point (x=3, y=5)
f(3+dx, 5+dy)
% The output will contain the function value at (3,5) and its partial derivatives.

%% Extending to Higher Dimensions
% ----------------------------------------------
% Since we have **four basis elements that square to zero**, 
% we can compute **derivatives with respect to four variables** (x, y, z, w).
%
% The new differential basis elements are:
% - `dx = e3`  → Represents the infinitesimal change in **x**.
% - `dy = e13` → Represents the infinitesimal change in **y**.
% - `dz = e23` → Represents the infinitesimal change in **z**.
% - `dw = e123` → Represents the infinitesimal change in **w**.

dx = e3;
dy = e13;
dz = e23;
dw = e123;

% We can now perform differentiation on functions of **four variables**.

% Define a function in four variables:
%     g(x, y, z, w) = x^4 - exp(y^3) + sin(z^2) - log(w^2)
g = @(x, y, z, w) x*x*x*x - exp(y*y*y) + sin(z*z) - log(w^2);

% Declare the variables as symbolic for further manipulation
syms x y z w

% Compute the function with dual differentials
result = g(x+dx, y+dy, z+dz, w+dw);
% The output will now include:
% - The function **g(x, y, z, w)** itself.
% - The **partial derivatives** with respect to **x, y, z, and w**.