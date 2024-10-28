%% Set up the enviroment in order to perform the caluclation
% Clear all matlab variables
% Close all opened plots
% Clear the command window
clear all; close all; clc

% Shorten output, but keep precission
format short

% Declare geometric algebra variables in 2,0,0
GA([2,0,0])

% The key variable change
Tga=1/2*[e0 +  e1    e2 - e12 ;
         e2 + e12    e0 -  e1];

% An anonymous function to convert from abc to unbalanced form 
% corresponds to equations (16)(17)(18)
abc2AVUN=@(ra,rb,rc)deal((ra+rb+rc)/3,(ra-rc)/3,(ra-2*rb+rc)/3);

% An anonymous function to convert from balanced-unbalanced to GA 
% corresponds to equation (15)
AVUN2GA=@(rav,run1,run2)  3/2*rav * e0 ... 
                       + 3/2*run1 * e1...
                 + sqrt(3)/2*run2 * e2...
                  - sqrt(3)/2*rav * e12;

% Composition of previous functions f(g())
abc2GA=@(ra,rb,rc)         3/2*(ra+rb+rc)/3 * e0 ... 
                            + 3/2*(ra-rc)/3 * e1...
                 + sqrt(3)/2*(ra-2*rb+rc)/3 * e2...
                  - sqrt(3)/2*(ra+rb+rc)/3 * e12;
% Truncate big numbers when working with symbolic variables
truncate=@(x)MV(vpa(x.vector,2),x.Lsignature);

%% Modeling Parameters in GA

% Figure 2(a) Power network part
rtha=1.0; rthb=3; rthc=2;
rth=abc2GA(rtha,rthb,rthc);

% Figure 2(a) Line transmission part
rla=1; rlb=0.5; rlc=0.75;
rl=abc2GA(rla,rlb,rlc);

% Figure 2(a) load 1
r1a=10; r1b=2; r1c=17;
r1=abc2GA(r1a,r1b,r1c);

% Figure 2(a) load 2
r2a=5; r2b=15; r2c=10;
r2=abc2GA(r2a,r2b,r2c);

%% Circuit analysis

% Paralel sum of geometric resistances
rL=(r1^-1+r2^-1)^-1;

% Simple voltage divisor og geometric resistances
m=rL*(rL+rth+rl)^-1;

disp('================================================')
disp(' Components of the equivalent resistance vector ')
disp('=============================================== ')
disp(vpa(m.vector.',4))
disp('================================================')


%% Output voltage
syms w t real

% The thevening voltage , same as 1/2*T*[cos(wt);sin(wt)]
vth=1/2*exp(-w*t*e12)+1/2*e1*exp(w*t*e12);

% The output voltage
v2=m*vth;


disp('========================================== ')
disp(' Components of the V2 vector e0 e1 e2 e12 ')
disp('========================================== ')
disp(vpa(v2.vector.',4))
disp('The vector itself is:')
disp(v2)
disp('========================================== ')


%% Simulation 
tfinal=0.1;
t=linspace(0,tfinal,1e2);

f=50;
w=2*pi*f;
vthafun=cos(w*t);
vthbfun=sin(w*t);

valphafun=va_c*cos(w*t)+va_s*sin(w*t);
vbetafun=vb_c*cos(w*t)+vb_s*sin(w*t);


%% Simulations
c=2/3;
T=c*[1,-1/2,-1/2;
0,sqrt(3)/2,-sqrt(3)/2;
1/sqrt(2),1/sqrt(2),1/sqrt(2)];

iT=inv(T);

Vth=1;
phi=-30+90;


StepSize=1e-4;

sims=sim('ISCAS_GA_example01_model.slx');

%% Plots

figure
subplot(2,1,1)
plot(sims.tout*1e3,sims.vthabg(:,1),'LineWidth',1.2)
hold on
plot(sims.tout*1e3,sims.vthabg(:,2),'LineWidth',1.2)
grid on; grid minor
ylabel('$v_{th\alpha}$, $v_{th\beta}$ [V]','Interpreter','latex')
subplot(2,1,2)
plot(sims.tout*1e3,sims.v2abg(:,1),'LineWidth',1.2)
hold on
plot(sims.tout*1e3,sims.v2abg(:,2),'LineWidth',1.2)
plot(t*1e3,valphafun,'ok')
plot(t*1e3,vbetafun,'+k')
grid on; grid minor
ylabel('$v_{2\alpha}$, $v_{2\beta}$ [V]','Interpreter','latex')
xlabel('Time [ms]','Interpreter','latex')

