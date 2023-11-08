% CGA BASICS
CGA(2)
hold on
%% Building a point ....
% A point has two representations, as a simple vector or as a trivector,
% depending on the choosen duality of the representation.

% Lets say you have a point, P, in the euclidian space with coordinates a, and
% b
syms a b
P=a*e1+b*e2

%The equivalent CGA representaion is given by the simple construction
P_CGA=n0+P+1/2*P.*P*ni

% It has an intrinsic caracteristic, the scalar product with itself is zero
simplify(P_CGA.*P_CGA)

%This also occurs in the dual representation of the point
P_CGA_d=dual(P_CGA)
simplify(P_CGA_d.*P_CGA_d)

%this allows us to discriminate whenever we are in front of a point whith
%independence of its representation, dual or not dual.

% In the case that we whant to recover the point position we can perform
% this operation
E=n0.^ni;
Ei=E^-1;
P_eucl=((P_CGA*(-P_CGA.*ni)^-1).^E)*Ei
% In case we have a dual notation, we must first transform to normal
% notation
P_eucl=((P_CGA_d.dual*(-P_CGA_d.dual.*ni)^-1).^E)*Ei

% Now the question is, its easy to know whenever the object is a point,
% but, how do we know if it is expresed in standart form or in dual form?
% There is a simple test if P.grade(3)==0 then we are in front of a
% standart basis. If P.grade(3)~=0 then is a dual representation

% It's posible to plot a single pont using the cgaplot2() function
a=2;b=1;
p=a*e1+b*e2
P=n0+p+1/2*p.*p*ni
P.plot()
P.info()
%%
% A point pair is formed by two points, equivalent to 1D circle
p1=e2-e1;
p2=e1-e2;
P1=push(p1);
P2=push(p2);
PP=P1.^P2;
PP.plot()
%%

% A circle is formed by three points three points 
p1=-1*e1+2*e2;
p2=e1+e2;
p3=e2-2*e1;
P1=push(p1);
P2=push(p2);
P3=push(p3);

PPP=P1.^P2.^P3;
PPP.plot()
%%
%Here you can see the grade diferences among the three objects in inner
%representation
[P.BasisNames;P.vector;PP.vector;PPP.vector].'

%% Intersect two circles
r=2;
C1=push(-1*e1+1*e2)-1/2*r^2*ni;
C2=push(1*e1)-1/2*r^2*ni;

C1.plot()
hold on
C2.plot()

DP=dual(normal(C1).^normal(C2));
DP.plot()
grid on

%% Animate two circles crossing one over the other and plot the intersection
p1c1=push(-2*e1);
p2c1=push(2*e2);
p3c1=push(2*e1);
C1=normalize(p1c1.^p2c1.^p3c1);


for off=6:-0.1:-16

p1c2=push(5*e1+off*e1);
p2c2=push(-e1+off*e1);
p3c2=push(2*e1+2.5*e2+off*e1);
C2=normalize(p1c2.^p2c2.^p3c2);
hold off
C1.plot()
hold on
C2.plot()
intersection=(dual((dual(C1)).^(dual(C2)))); % The meet of the two circles is its intersection
intersection.plot()

grid on

xlim([-17,6])
ylim([-10 8])

drawnow()
end