%% --------------------------------------------------------------
% This script presents an advanced example of three-phase electrical 
% system modeling, using Geometric Algebra (GA) as an alternative to 
% the traditional alpha-beta representation. Due to the complexity of 
% the concepts involved, including spatial transformations, 
% positive and negative sequence analysis, and modal decomposition 
% of the system, its understanding requires a high level of expertise 
% in electrical engineering and advanced mathematics, 
% making it difficult to grasp for anyone who is not an expert in the field.
% This problem was our primary motivation for exploring Geometric Algebras,
% as we sought a more elegant and unified mathematical framework for 
% analyzing electrical systems. 
% For this reason, we have included this example in the package, 
% as it represents both a practical application and a key inspiration 
% behind our work in GA.
%  --------------------------------------------------------------
clear all
close all

%% --------------------------------------------------------------
% PART 1: TRADITIONAL METHOD (MIMO ALPHA-BETA REPRESENTATION)
% --------------------------------------------------------------
% This section solves the electrical circuit using the **classical** 
% alpha-beta transformation, treating it as a **MIMO** (Multi-Input Multi-Output) system.

% Initialize symbolic variables
syms Raa Rab Rba Rbb w t real % Resistance matrix components, frequency, and time

% ---------------------
% SYSTEM MODEL (MIMO)
% ---------------------
% The resistance matrix `R` in **alpha-beta coordinates**:
R = [Raa Rab;
     Rba Rbb];

% Define the **input current** as a circular trajectory
current = [cos(w*t);
           sin(w*t)];

% Compute the **output voltage** in **alpha-beta representation**:
voltage = R * current; % MIMO system (2 inputs, 2 outputs)

% --------------------------------------------------------------
% PART 2: GEOMETRIC ALGEBRA (GA) METHOD (SISO IN PGA)
% --------------------------------------------------------------
% Now, we transform the system into **Geometric Algebra (GA)**
% to simplify the analysis into a **SISO (Single-Input Single-Output) system**.

GA([2 0 0], "verbose") % Initialize Geometric Algebra space

% ---------------------
% SYSTEM MODEL (GA)
% ---------------------
% The **coordinate transformation matrix** (Clarke transformation in GA):
Cd = [e0+e1  -e2+e12;
      -e2-e12  e0-e1] * sym(1/2);

% Convert **resistance matrix to GA**:
Rga = Cd * R * Cd;
Rga = Rga(1,1); % Extract single component (since matrix is diagonalized)

% Convert **input current to GA**:
current_ga = Cd * current;
current_ga = current_ga(1); % Extract first component (SISO system)

% Alternatively, define the **GA input current directly**:
current_ga = sym(1/2) * exp(w*t*e12) * (1+e1); 

% Compute the **output voltage in GA**:
voltage_ga = simplify(Rga * current_ga);

%% --------------------------------------------------------------
% COMPARISON OF OUTPUT REPRESENTATIONS
% --------------------------------------------------------------
% Traditional (MIMO) output:
disp('Voltage output in MIMO alpha-beta representation:');
disp(voltage);

% Geometric Algebra (SISO) output:
disp('Voltage output in GA representation:');
disp(voltage_ga);

% --------------------------------------------------------------
% COMPUTE SYSTEM RESPONSE TO EXPONENTIAL INPUT
% --------------------------------------------------------------
% **Positive sequence gain**:
A = Rga{e0 + e12}; 

% **Negative sequence gain**:
B = Rga{e1 + e2};

% Compute **gain magnitudes**:
K_plus = A.length;  % Positive sequence magnitude
K_minus = B.length; % Negative sequence magnitude

% Compute **phase shifts**:
a_plus = atan2(A(e12), A(e0)); % Phase shift of positive sequence
a_minus = atan2(B(e2), B(e1)); % Phase shift of negative sequence

%% --------------------------------------------------------------
% NUMERICAL EXAMPLE
% --------------------------------------------------------------
% Assign **random resistance values** to simulate system behavior:

Raa = rand();       % Random resistance value
Rbb = rand();       % Random resistance value
Rab = rand() * 0.1; % Small resistance, so the negative sequence is moderate
Rba = rand() * 0.1; % Small resistance, so the negative sequence is moderate

% Compute **numerical values**:
K_plus_NUM = eval(char(K_plus));
K_minus_NUM = eval(char(K_minus));
a_plus_NUM = eval(char(a_plus));
a_minus_NUM = eval(char(a_minus));

% Compute **ellipse maximum and minimum directions**:
p1 = (a_plus_NUM - a_minus_NUM) / 2;        % Major axis direction
p2 = (a_plus_NUM - a_minus_NUM) / 2 + pi/2; % Minor axis direction

w = 50 * 2 * pi; % Set frequency to 50 Hz (European power system)

% **Compute system output using GA**
syms t real
V_plus_t = K_plus_NUM * exp((a_plus_NUM + w*t) * e12);
V_minus_t = K_minus_NUM * exp((a_minus_NUM - w*t) * e12) * e1;

% Compute **vectors in maximum and minimum directions**:
Constructive = K_plus_NUM * exp(p1 * e12); % Maximum direction vector
Destructive = K_plus_NUM * exp(p2 * e12); % Minimum direction vector

% Compute **initial positive and negative sequence values**:
v_plus_0 = subs(V_plus_t, t, 0);
v_minus_0 = subs(V_minus_t, t, 0);

%% --------------------------------------------------------------
% PLOTTING SYSTEM RESPONSE
% --------------------------------------------------------------
t = 0:0.0001:.1;
hold off

% **Plot positive sequence computed using GA**
plot(eval(char(V_plus_t(e0))), eval(char(V_plus_t(e12))));

ax = gca;
hold on

% **Plot negative sequence in maximum and minimum directions**
ax.ColorOrderIndex = 3;
plot(eval(char(V_minus_t(e1))) + Constructive(e0), eval(char(V_minus_t(e2))) + Constructive(e12));
plot(eval(char(V_minus_t(e1))) + Destructive(e0), eval(char(V_minus_t(e2))) + Destructive(e12));

% **Plot initial phase vectors**
ax.ColorOrderIndex = 1;
plot([0 v_plus_0(e0)], [0 v_plus_0(e12)]); % Initial positive phase
ax.ColorOrderIndex = 3;
plot([v_plus_0(e0) v_plus_0(e0) + v_minus_0(e1)], [v_plus_0(e12) v_plus_0(e12) + v_minus_0(e2)]); % Initial negative phase

% **Plot actual alpha-beta system response**
v = subs(voltage);
plot(v(1,:), v(2,:), 'k'); % Expected alpha-beta output
plot(v(1,1), v(2,1), 'ko'); % Initial alpha-beta response point

legend("V+, GA computed",...
       "V- in the constructive direction, GA computed",...
       "V- in the destructive direction, GA computed",...
       "Initial Phase of V+, GA computed",...
       "Initial Phase of V-, GA computed",...
       "Alpha-beta expected output",...
       "Alpha-beta initial point");

grid on
axis square
axis equal

%% --------------------------------------------------------------
% RELATIONSHIP WITH SVD (Singular Value Decomposition)
% --------------------------------------------------------------
% The **Singular Value Decomposition (SVD)** provides an alternative 
% way to analyze the system response.

[U, S, V] = svd(subs(R));

% Extract **system transformation properties**:
phi = angle(U(1,1) + 1i * U(1,2)); % Rotation of matrix U (output directions)
gamma = angle(V(1,1) + 1i * V(2,1)); % Rotation of matrix V (input directions)

% Compute **positive and negative sequence magnitudes from SVD**:
positive_gain_magnitude = (S(1,1) + S(2,2)) / 2; % K_plus (GA)
negative_gain_magnitude = (S(1,1) - S(2,2)) / 2; % K_minus (GA)

% Compute **positive and negative sequence phase shifts**:
positive_gain_phase = phi - gamma; % a_plus (GA)
negative_gain_phase = -(gamma + phi); % a_minus (GA)

%% --------------------------------------------------------------
% ANALYZING UNBALANCED INPUTS IN GA
% --------------------------------------------------------------
syms Vp Vn ap an w t real
input_ga_un = (Vp * exp((ap + w*t) * e12) + ... % Positive part
               Vn * exp((an - w*t) * e12)) * ... % Negative part
              (1 + e1); 

% Compute system output for unbalanced input:
K_i = (Vp * exp(ap * e12) + Vn * exp(an * e12) * e1);
T = Rga * K_i;

% Extract positive and negative gains:
A = T-T{G1};
B = T{G1};

% Doing the same in SVD is almost impossible.