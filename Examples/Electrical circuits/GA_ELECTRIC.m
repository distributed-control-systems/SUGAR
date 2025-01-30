clear all
close all
syms s % Laplace transform variable
syms Lu L R real % Lu: unbalanced inductance, L: balanced inductance, R: resistance.
syms V_a V_b V_c real % Voltages at each node of the circuit
syms V1_a V1_b V1_c real % Currents through the voltage sources
syms w0 % Working frequency
syms V_0 % Amplitude of the input voltage
syms t real % Time variable

%% 1. CIRCUIT MODELING USING THE ADMITTANCE MATRIX
% -------------------------------------------------------------------
% The circuit is modeled using the **nodal admittance matrix (Y_bus)**:
%
%       Y_bus * x = z
%
% Where:
% - `x = [V_a, V_b, V_c]'` (vector of node voltages)
% - `z = [V1_a, V1_b, V1_c]'` (vector of input currents)

Y_bus = [(3*R + 2*Lu*s)/(3*R),       -(Lu*s)/(3*R),       -(Lu*s)/(3*R);
                 -(L*s)/(3*R), (3*R + 2*L*s)/(3*R),        -(L*s)/(3*R);
                 -(L*s)/(3*R),        -(L*s)/(3*R), (3*R + 2*L*s)/(3*R)];

%% 2. TRANSFORMATION TO ALPHA-BETA COORDINATES (SYMMETRICAL COMPONENTS)
% -------------------------------------------------------------------
% The three-phase system is transformed into **alpha-beta coordinates** 
% using the **Clarke Transformation matrix (T)**:
%
%       Y_bus * x_abc = z_abc
%       T * x_abg = x_abc
%       Y_bus * T * x_abg = T * z_abg
%       T^-1 * Y_bus * T * x_abg = z_abg
%
% The transformation matrix `T` is:

T = sym([   1,          0, 1;
       -1/2,  3^(1/2)/2, 1;
       -1/2, -3^(1/2)/2, 1]);

% Compute the **admittance matrix in alpha-beta coordinates**:
Y_abg = simplify(T^-1 * Y_bus * T);

% Since the system does **not** have a neutral wire, the **gamma component is discarded**:
Y_ab = Y_abg(1:2, 1:2)

%% 3. EMBEDDING INTO GEOMETRIC ALGEBRA (GA)
% -------------------------------------------------------------------
% The circuit equations are now rewritten in terms of **Geometric Algebra (GA)**
% using a **2D Euclidean geometric algebra representation**.

GA([2 0 0], "verbose") % Define the geometric algebra space

%% 4. EMBEDDING ALPHA-BETA VARIABLES INTO GEOMETRIC ALGEBRA
% -------------------------------------------------------------------
% The **alpha-beta variables** are embedded into **multivectors (MV)**.
% This transformation matrix `Cd` embeds **classical coordinates into GA**.

Cd = [e0+e1 e2-e12;
      e2+e12 e0-e1] * sym(1/2);

% Compute the **admittance matrix in MV representation**:
Y_mv = Cd * Y_ab * Cd;

% The resulting matrix is **diagonal with identical elements**, 
% meaning the system behaves equivalently in both subspaces.
% We can extract only one element for further computation:

Y_mv = Y_mv(1,1) % Extract one representative element

%% 5. COMPUTE THE IMPEDANCE MATRIX (Z = Y⁻¹)
% -------------------------------------------------------------------
% The impedance matrix **Z_mv** is computed as the inverse of **Y_mv**:

Z_mv = simplify(Y_mv^-1) % Compute the inverse using Geometric Algebra

% This gives the system's impedance in terms of **multivectors**.

%% 6. SIMULATION OF THE SYSTEM RESPONSE (OPEN-LOOP)
% -------------------------------------------------------------------
% The system is now simulated using an **open-loop sine wave input**.
%
% The **Laplace domain input function** is:
%
%       Input_s = Cd * [ (s / (s² + w0²)) * V₀ ; (w0 / (s² + w0²)) * V₀ ]
%
% - The first term represents a **cosine wave**.
% - The second term represents a **sine wave**.

Input_s = Cd * [ s/(s^2 + w0^2) * V_0 ; ... % Cosine component
                 w0/(s^2 + w0^2) * V_0];    % Sine component

% Since **one component is the dual of the other**, we only keep **one component**:
Input_s = Input_s(1);

% Compute the **open-loop output voltage response**:
Output_s = Z_mv * Input_s;

%% 7. TIME-DOMAIN RESPONSE (INVERSE LAPLACE TRANSFORM)
% -------------------------------------------------------------------
% The **inverse Laplace transform** is computed to obtain the **time-domain response**:

syms s t
V1_t = ilaplace(Output_s, s, t)

%% 8. SIMULATION PARAMETERS AND PLOTTING
% -------------------------------------------------------------------
% Define **physical circuit parameters** for numerical evaluation:
R = 22;          % Resistance (Ohms)
L = 1e-3;        % Inductance (H)
Lu = 1e-1;       % Unbalanced inductance (H)
V_0 = 155;       % Peak voltage (V)
w0 = 2 * pi * 60; % Frequency (60 Hz)

% Convert the symbolic function to a **MATLAB function** for plotting:
V = (2 * subs(V1_t(e1 + e2))); 

% **Plot the output voltage response in the α-β plane**:
fplot(V(1), V(2), [0 0.1])
axis equal
xlim([-180 180])
ylim([-180 180])