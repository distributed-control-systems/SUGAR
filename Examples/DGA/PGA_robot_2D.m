% PGA 2D algebra initialization with two differentiable parameters up to
% order 1
DGA([2,0,1],[2 1])

% The Robot has 2 arms which can be actuated with angles ai
syms a1 a2  real

% Each robot arm has a lenght li
syms l1 l2 real

% The desired position of the end effector
syms x y real

%lets declare the differentiable variables, those that move the robot
A1=a1+D1;
A2=a2+D2;


%Point embedding for PGA2D and unembedding
Point2PGA=@(x,y)( 1 )*e12+( -y )*e13+( x )*e23
PGA2Point=@(P) [P(e23),-P(e13)]

%The point at the origin
P0=Point2PGA(0,0)

% The rotors associated with each arm 
% First arm lenght, Di, displacement of element i
D1=exp(l1/2*e13);
% Second arm lenght
D2=exp(l2/2*e13);

%Rotations due to angles, Ri, rotation of element i
%first join angle
R1=exp(-A1/2*e12);
%Second join angle
R2=exp(-A2/2*e12);


% Rotors (Displacement + Rotation) for each arm
P1M=R1*D1; % First arm rotor
P2M=P1M*R2*D2; % Second arm rotor

%Apply the rotors to each point
P1_robot=P1M*P0*~P1M;
P2_robot=P2M*P0*~P2M;

%%
%Obtain symbolic explicit kinematics, this simplifies a lot the representation 
P1_cin=PGA2Point(P1_robot.tangent(0));
P2_cin=PGA2Point(P2_robot.tangent(0));

%The desired end effector position
Pd=Point2PGA(x,y)

% The Error in position
Error=P2_robot-Pd;

% The local basis (a1 a2) orientations and lengths at a given position

da1=simplify(Error.shift("D1"));
da2=simplify(Error.shift("D2"));

% So, right now I don't have the dual defined over DGA, so in order to
% project the Error onto da1 and da2 I'm doing the meet by hand
Err_da1=(Error(e13)*da1(e13)+Error(e23)*da1(e23))/(da1(e13)^2+da1(e23)^2);%*e123
Err_da2=(Error(e13)*da2(e13)+Error(e23)*da2(e23))/(da2(e13)^2+da2(e23)^2);%*e123

a1_dot=-Err_da1
a2_dot=-Err_da2


%%

%Convert to function in order to plot (This is a GALOOP natural substitute)
P1_fin=matlabFunction(P1_cin);
P2_fin=matlabFunction(P2_cin);
P3_fin=matlabFunction(P3_cin);

%Pintamos con unos valores a ver que tal...
l1=1;l2=1;length_3=1;a1=0;a2=pi/2;angle_3=0;

points=500
ps=NaN*zeros(2,points);
%%
for k=(1:points)
    t=k*7/points;
    a1=1;%sin(t);
    a2=1;%2*cos(t);
    angle_3=0;%cos(2*t);

    P1_fix=P1_fin(a1,l1);
    P2_fix=P2_fin(a1,a2,l1,l2);
    P3_fix=P3_fin(a1,a2,angle_3,l1,l2,length_3);

    ps(:,k)=P3_fix;

    %First segment
    hold off
    plot([0 P1_fix(1)],[0 P1_fix(2)])
    hold on
    %second segment
    plot([P1_fix(1) P2_fix(1)],[P1_fix(2) P2_fix(2)])
    % Last segment
    plot([P2_fix(1) P3_fix(1)],[P2_fix(2) P3_fix(2)])
    %End point trajectory
    plot(ps(1,:),ps(2,:));

    axis equal
    xlim([-4,4])
    ylim([-4,4])
    drawnow()
end
%%

a1=pi/4 ;
a2=pi/4;
angle_3=pi/4;

P1_fix=P1_fin(a1,l1);
P2_fix=P2_fin(a1,a2,l1,l2);
P3_fix=P3_fin(a1,a2,angle_3,l1,l2,length_3);

ps(:,k)=P3_fix;

%First segment

plot([0 P1_fix(1)],[0 P1_fix(2)],'k')
hold on
%second segment
plot([P1_fix(1) P2_fix(1)],[P1_fix(2) P2_fix(2)],'k')
% Last segment
plot([P2_fix(1) P3_fix(1)],[P2_fix(2) P3_fix(2)],'k')


axis equal
xlim([-4,4])
ylim([-4,4])

%%
syms xd yd a1 a2 angle_3 real
syms a b c
destino=Point2PGA(xd,yd);
cin=P3M*P3*P3M.reverse();
A=e1*dual(cin-e12);
B=e1*dual(destino-e12);
eq1=simplify(rewrite(A([1,5])*[1;1i],'exp'))-B([1,5])*[1;1i];
eq1=subs(eq1,{exp(a1*1i),exp(a2*1i),exp(angle_3*1i)},{a,b,c})
A=dual(cin-e12)*e2;
B=dual(destino-e12)*e2;
eq2=simplify(rewrite(A([1,5])*[1;1i],'exp'))-B([1,5])*[1;1i];
eq2=subs(eq2,{exp(a1*1i),exp(a2*1i),exp(angle_3*1i)},{a,b,c})

S=solve([eq1,eq2],{b,c})

%% test


l1=1;l2=1;length_3=1;a1=0;
xd=0
yd=0

X=0.9*cos(0:0.01:10);
Y=1.5*sin(0:0.01:10)+1.5;

for k=0:0.01:10
xd=0.9*cos(k);
yd=1.5*sin(k)+1.5;

a1=atan2(xd,yd)/2;

R2=eval(subs(S.t2));
R3=eval(subs(S.t3));
if abs(R2(1))<abs(R2(2))
    a2=R2(1);
    angle_3=R3(1);
else
    a2=R2(2);
    angle_3=R3(2);
end

hold off
plot(X,Y,'k')
hold on
P1_fix=P1_fin(l1,a1);
    P2_fix=P2_fin(l1,l2,a1,a2);
    
    
    P3_fix=P3_fin(l1,l2,length_3,a1,a2,angle_3);



    %First segment

    plot([0 P1_fix(1)],[0 P1_fix(2)],'b')
    hold on
    %second segment
    plot([P1_fix(1) P2_fix(1)],[P1_fix(2) P2_fix(2)],'r')
    % Last segment
    plot([P2_fix(1) P3_fix(1)],[P2_fix(2) P3_fix(2)],'g')
    %End point trajectory
   

    axis equal
    xlim([-4,4])
    ylim([-4,4])
    drawnow()
end