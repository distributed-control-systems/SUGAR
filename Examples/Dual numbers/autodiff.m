% Dual numbers are an extension of real numbers used in specific mathematical 
% applications, especially in geometry and analysis. A dual number takes the 
% form a + bε, where a and b are real numbers, and ε (epsilon) is an element 
% that satisfies the property ε² = 0. 
% The term "a" represents the real part, while "bε" is called the dual part.

% Dual numbers are commonly used in:
% - Automatic differentiation
% - Kinematics and robotics
% - Infinitesimal calculus
% - Lie algebra representations

% Here we present some practical applications of dual numbers in Sugar.

%% Initialize the Geometric Algebra
% Define a single degenerate basis vector to model dual numbers.
GA([0 0 1])

%% Define a symbolic variable
syms x real

% This allows us to perform operations involving dual numbers.
% For instance, we can define a function that depends on x.

fn = sin(10*x); 
% Here, fn is not a callable function; it is a symbolic expression 
% that represents the function definition.

%% Compute the derivative using dual numbers
% By substituting x with a dual number (x + e1), we can automatically obtain
% both the function and its derivative in a single expression.

fn = sin(10*(x + e1));  
% The output will be: 
% ( sin(10*x) )*e0 + ( 10*cos(10*x) )*e1
% This means:
% - The e0 component represents the original function.
% - The e1 component represents the derivative of the function.

% As a result, we obtain the function and its derivative in a single computation.

%% Extracting Function Components for Plotting
% To visualize the function and its derivative, we extract their respective
% components from the multivector.

original = matlabFunction(fn(e0)); % Extracts the e0 component (the original function)
derivative = matlabFunction(fn(e1)); % Extracts the e1 component (the derivative)

% Generate a range of x values
x = -pi:0.01:pi;

% Plot the original function
plot(x, original(x));
hold on

% Plot its derivative
plot(x, derivative(x));
legend("Original function", "Derivative");

%% Higher-Order Derivatives using Dual Numbers
% With dual numbers, we can compute higher-order derivatives efficiently.
% We introduce a symbolic variable x with a dual component.

syms x A w real % A is the amplitude, w is the frequency

% Define x as a dual number
x = x + e1;

% Define the function using dual numbers
fn = A * sin(w * x);

% Compute derivatives up to the 10th order
derivatives = {fn(e0), fn(e1)}; % Store first two derivatives
for i = 2:10 % Compute up to the 10th derivative
    fn = eval(char(fn(e1))); % Extract and compute next derivative
    derivatives{i} = fn(e1);
end

% Expected output:
% The derivatives up to order 9 will be stored in the `derivatives` cell array:
%
% derivatives =
%   1×10 cell array
%   Columns 1 through 5
%     {[A*sin(w*x)]}      {[-A*w*cos(w*x)]}  {[-A*w^2*sin(w*x)]}  
%     {[A*w^3*cos(w*x)]}  {[A*w^4*sin(w*x)]}  
%   Columns 6 through 10
%     {[-A*w^5*cos(w*x)]} {[-A*w^6*sin(w*x)]}  
%     {[A*w^7*cos(w*x)]}  {[A*w^8*sin(w*x)]}  {[-A*w^9*cos(w*x)]}

% This method provides a systematic way to compute derivatives of any order using dual numbers.