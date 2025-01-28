clc
clear all
CGA(2)

%% Test points on a grid

X=2:.1:3;
Y=2:.1:3;

P=make_points_from_grid(X,Y);
[m,n]=size(P);
%% Rotation
R=make_rotation(pi/4,e12);
Pi=[];
for i=1:n
    Pi=[Pi R.reverse*P(i)*R];
end

% Plot the original point grid 
figure; axis equal; grid on; hold on
for i=1:n
    P(i).plot()
    Pi(i).plot()
end
push(0).plot()

%% Translate
R=make_translation(4,-e1);
Pi=[];
for i=1:n
    Pi=[Pi R.reverse*P(i)*R];
end

% Plot the original point grid 
figure; axis equal; grid on; hold on
for i=1:n
    P(i).plot()
    Pi(i).plot()
end
push(0).plot()
%% Dilation
R=make_dilation(1);
Pi=[];
for i=1:n
    Pi=[Pi R.reverse*P(i)*R];
end

% Plot the original point grid 
figure; axis equal; grid on; hold on
for i=1:n
    P(i).plot()
    Pi(i).plot()
end
push(0).plot()


%% Inverssion 

p1=point([4.5,0]);
p2=point([-4.5,0]);
p3=point([0,4.5]);
C=p1.^p2.^p3;
Circle=@(x,y,r)(( n0+x*e1+y*e2+0.5*(x*x+y*y - r^2)*ni));
C=Circle(1,1,1.5);


R=make_inverssion(C);


Pi=[];
for i=1:n
    Pi=[Pi C.reverse*P(i)*C];
end

% Plot the original point grid 
figure; axis equal; grid on; hold on
for i=1:n
    P(i).plot()
    Pi(i).plot()
end
C.plot()



%% Accesory function
function r=make_points_from_grid(x,y)
    point = evalin('base','point');
    P=[];
    [m,n]=size(x);
    for i=1:n
        for j=1:n
            
            P=[P point([x(i),y(j)])];
        end
    end
    r=P;
end