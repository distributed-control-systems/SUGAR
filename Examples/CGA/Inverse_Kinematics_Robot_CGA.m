clear all
close all

% Fixed parameters of the Stäubli (provided in the book, and they are 
% actually the measurements of the three links).

d1 = 480;
a3= 425;
d4 = 425;

% Initialization of the algebra

CGA(3)

%% Forward Kinematics

% Desired configuration (generated randomly). Since the robot has 
% three actuated joints, its configuration is a 3-dimensional vector. 
% The range for each joint is [0, pi/2].

%q_d = [(pi/2)*rand(),(pi/2)*rand(),(pi/2)*rand()];

q_d = [0.4375,0.8590,1.5040];

% Desired position of the robot's end-effector.

pos_d = FK(q_d);

%% Inverse Kinematics for the position part of the Stäubli robot

% The following steps follow the development of the book "A geometric algebra 
% invitation to space-time physics, robotics and molecular geometry" - Carlile
% Lavor, Sebastià Xambó-Descamps & Isiah Zaplana.

% 1. We convert the desired position from Euclidean to a null vector of CGA.

POS_D = push(pos_d(1)*e1+pos_d(2)*e2+pos_d(3)*e3);

% 2. P0 is the point associated with the origin, so P0 = n0.

P0 = n0;

% 2. P1 is the result of translating P0 a distance d1 along the 
% z axis (=e3) of the base coordinate system.

% 2.1 Define the rotor that encodes this translation.

T1 = make_translation(d1,e3);

% 2.2 Apply the rotor using the sandwich product to P0.

P1 = T1.reverse*P0*T1;

% 3. Construct a plane passing through P0, P1, and POS_D, and two spheres, 
% one centered at P1 with radius a3 and the other centered at POS_D with 
% radius d4. The plane is in "outer" representation, while the spheres are 
% in "inner" representation.

plane = P0.^P1.^POS_D.^ni;

a = 0.5*(a3^2);
d = 0.5*(d4^2);

S1 = P1 - a*ni;
S2 = POS_D - d*ni;

% 4. Intersect the two spheres, which gives a circle.

C = S1.^S2;

% 5. Intersect the plane with the circle obtained in the previous step. 
% For this, we need to convert the plane from its "outer" representation 
% to its "inner" representation, which is done by taking its dual.

B = dual(plane).^clean(C);

% Plot all the geometric elements for visualization in SUGAR,
% and also to see the intersections that were just calculated.

S1.plot()
hold on

S2.plot()
plane.normalize().plot()
C.plot()
B.plot();
xlim([-1000,1000])
ylim([-1000,1000])
hold off

% 6. The intersection of the plane with the circle gives two points, which 
% in CGA are represented by a bivector. Each of these points will give 
% a different solution for the inverse kinematics (both are valid... 
% elbow-up/elbow-down phenomenon), so we extract both separately.

P2_sol1 = B.info.P1;
P2_sol2 = B.info.P2;

% Now we have all the points. To calculate the joint angles and thus obtain 
% the solutions for the inverse kinematics problem, we first define the 
% following three lines (in "outer" representation).

% The two solutions are identical except that one is constructed 
% entirely from P2_sol1 and the other from P2_sol2.

% COMMON PART -- solution for q1. Angle between the normal vector to the 
% plane defined and the x vector (=e1) of the base coordinate system.

normal_plane = dual(plane).info.n;
normal = normal_plane(e1+e2+e3);
x = [1,0,0];

q1 = acos(dot(normal,x)/(norm(x)*norm(normal)))-pi/2;

l1 = P0.^P1.^ni;

L11 = l1*l1;
L11_escalar = L11(G0);

% SOLUTION1

l2_sol1 = P1.^P2_sol1.^ni;
l3_sol1 = P2_sol1.^POS_D.^ni;

% Since the angles are calculated in MATLAB with a function not defined in 
% CGA, we perform the operations and then convert them to non-CGA MATLAB variables.

L12_sol1 = l2_sol1.*l1;
L12_escalar_sol1 = L12_sol1(G0);

L23_sol1 = l2_sol1.*l3_sol1;
L23_escalar_sol1 = L23_sol1(G0);

L22_sol1 = l2_sol1*l2_sol1;
L22_escalar_sol1 = L22_sol1(G0);

L33_sol1 = l3_sol1*l3_sol1;
L33_escalar_sol1 = L33_sol1(G0);

q2_sol1 = acos((L12_escalar_sol1)/(sqrt(L11_escalar)*sqrt(L22_escalar_sol1)));
q3_sol1 = acos((L23_escalar_sol1)/(sqrt(L22_escalar_sol1)*sqrt(L33_escalar_sol1)));

% SOLUTION2

l2_sol2 = P1.^P2_sol2.^ni;
l3_sol2 = P2_sol2.^POS_D.^ni;

% Since the angles are calculated in MATLAB with a function not defined in 
% CGA, we perform the operations and then convert them to non-CGA MATLAB variables.

L12_sol2 = l2_sol2.*l1;
L12_escalar_sol2 = L12_sol2(G0);

L23_sol2 = l2_sol2.*l3_sol2;
L23_escalar_sol2 = L23_sol2(G0);

L22_sol2 = l2_sol2*l2_sol2;
L22_escalar_sol2 = L22_sol2(G0);

L33_sol2 = l3_sol2*l3_sol2;
L33_escalar_sol2 = L33_sol2(G0);

q2_sol2 = acos((L12_escalar_sol2)/(sqrt(L11_escalar)*sqrt(L22_escalar_sol2)));
q3_sol2 = -acos((L23_escalar_sol2)/(sqrt(L22_escalar_sol2)*sqrt(L33_escalar_sol2)));

%% Verification of the result

q_propuesta_sol1 = [q1,q2_sol1,q3_sol1]
q_propuesta_sol2 = [q1,q2_sol2,q3_sol2]

q_d

pos_propuesta_sol1 = FK(q_propuesta_sol1)
pos_propuesta_sol2 = FK(q_propuesta_sol2)

pos_d

%% Function for solving forward kinematics using the conventional method

function pos = FK(q)

q1 = q(1);
q2 = q(2);
q3 = q(3);

T1 = [cos(q1),-sin(q1),0,0;sin(q1),cos(q1),0,0;0,0,1,480;0,0,0,1];

T2 = [cos(q2-(pi/2)),-sin(q2-(pi/2)),0,0;0,0,1,0;-sin(q2-(pi/2)),-cos(q2-(pi/2)),0,0;0,0,0,1];

T3 = [cos(q3+(pi/2)),-sin(q3+(pi/2)),0,425;sin(q3+(pi/2)),cos(q3+(pi/2)),0,0;0,0,1,0;0,0,0,1];

T4 = [1,0,0,0;0,0,-1,-425;0,1,0,0;0,0,0,1];

T = T1*(T2*(T3*T4));

pos = T(1:3,4);

end