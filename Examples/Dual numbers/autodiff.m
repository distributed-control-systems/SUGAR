% Dual numbers are an extension of real numbers used in specific mathematical 
% applications, especially in geometry and analysis. A dual number takes the 
% form  a + b\epsilon , where  a  and  b  are real numbers, and  \epsilon  is 
% an element that satisfies the property  \epsilon^2 = 0 . The term  a  
% represents the “real” part, while  b\epsilon  is called the “dual” part.
% Dual numbers are commonly used in automatic differentiation, kinematics, 
% and other areas that involve infinitesimal quantities.


% Here we present some uses in Sugar

% First declare the algebra
% Just a single degenerated basis
GA([0 0 1])

%now declare a symbolic variable
syms x real

% So you coud perform some nice operations, for instance, declare a
% function that depends o x
fn=sin(10*x) % outputs sin(x)
% but you can use dual numbers in order to get the derivative, just give a
% dual number to the function
fn=sin(10*(x+e1))  % outputs ( sin(10*x) )*e0+( 10*cos(10*x) )*e1
% And the you get the function and its derivative. Nice, isn'it?

%Lets make a plot of bots functions. To do so , convert them from symbolic
%to matlab functions

original=matlabFunction(fn(e0))
derivative=matlabFunction(fn(e1))

% Lets eval them in som points
x=-pi:0.01:pi;
plot(x,original(x));
hold on
plot(x, derivative(x));
legend("original","derivative");

%Of course you can go beyond first derivative with some nice triks in sugar


