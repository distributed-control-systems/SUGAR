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
% Here fn is not a function that you can call like any function. fn is a
% expression that jas contains the "text" describing the function.

% but you can use dual numbers in order to get the derivative, just give a
% dual number to the function
fn=sin(10*(x+e1))  % outputs ( sin(10*x) )*e0+( 10*cos(10*x) )*e1
% And the you get the function and its derivative. Nice, isn'it?

% Here fn is not a function that you can call like any function. fn is a
% multivector, each component of the multivector is an expresion that just
% contains the "text" describing the specific function component.


%Lets make a plot of both functions. To do so , convert them from symbolic
%to matlab functions

original=matlabFunction(fn(e0)) % We are not evaluating fn at e0, we are retriving the e0 component from the multivector
derivative=matlabFunction(fn(e1)) % We are not evaluating fn at e1, we are retriving the e1 component from the multivector

% Lets eval them in som points
x=-pi:0.01:pi;
plot(x,original(x));
hold on
plot(x, derivative(x));
legend("original","derivative");

%Of course you can go beyond first derivative with some nice tricks in sugar
%Declare a dual number named x in the matlab workspace with two components,
% a real part, which is a symbolic variable and a dual part, which is just 1.
syms x A w real %A amplitude of a sine wave, w freqüency of the sine wave
x=x+e1;
fn=A*sin(w*x)
derivatives={fn(e0),fn(e1)};
for i=2:10 % up to the tenth derivative
    fn=eval(char(fn(e1)));
    derivatives{i}=fn(e1);
end

%Expeted output, the derivatives up to order 9
% derivatives =
%   1×10 cell array
%   Columns 1 through 5
%     {[A*sin(w*x)]}      {[-A*w^2*sin(w*x)]}  {[-A*w^3*cos(w*x)]}  {[A*w^4*sin(w*x)]}  {[A*w^5*cos(w*x)]}
%   Columns 6 through 10
%     {[-A*w^6*sin(w*x)]} {[-A*w^7*cos(w*x)]}  {[A*w^8*sin(w*x)]}   {[A*w^9*cos(w*x)]}  {[-A*w^10*sin(w*x)]}