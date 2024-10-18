%% This example has been extracted from 
% https://enkimute.github.io/ganja.js/examples/coffeeshop.html#timespace_lorentz

% We implement the example from https://www.youtube.com/watch?v=MvEJat0T_Kw&gl=BE
% in a coordinate free way.
% 
%   In the earth's reference frame, a tree is at the origin and a pole is at x=20km
%   Lightning strikes both the tree and the pole at t=10microseconds. The lightning
%   strikes are observed by a rocket traveling in the positive x direction at 0.5c
% 
%   1. what time does the lightning strikes take place for the rocket.
%   2. are they still simultanious ?

% Declare an algebra for space-time calculations
GA([1,3,0])
%The spacetime unit we use is lightseconds (for both time and space)
% A couple of anonimous functions in otder to push-pull events into
% space-time format

c=299792.458; % Light speed in our universe
micros = @(x)x*0.000001*e1;
km = @(x,y,z)(x*e2+y*e3+z*e4)/299792.458;

%Define two events in our own reference frame. (the earth's)
strike_tree = micros(10) + km(0,0,0);
strike_pole = micros(10) + km(20,0,0);

%Calculate the lorentz transform to go to the rockets frame.
rocket_speed = 0.5; % Half the speed of light.
rocket_frame = exp(atanh(rocket_speed)*0.5*e12);

% Transform the events to the rockets frame.
strike_tree_r = rocket_frame*strike_tree*~rocket_frame;
strike_pole_r = rocket_frame*strike_pole*~rocket_frame;

out1=sprintf("rocket sees lightning strike the tree at time %f ms", strike_tree_r(e1)*1000000);
out2=sprintf("rocket sees lightning strike the pole at time %f ms",strike_pole_r(e1)*1000000);
disp(out1)
disp(out2)
disp("Wow! That's not at the same time!");

%Expected output from Ganja.js
%     rocket sees lightning strike the tree at time = 11.547004760359414 ms
%     rocket sees lightning strike the pole at time = -26.969659302267246 ms
%     Wow! That's not at the same time!

%-------------------------------------------------------------------------

% also this other example no longer available at the link pointed by
% ganja.js
%
% what does the timespace event at (1,1) to a static observer look like for
% an observer going at 0.5c ?

event = e1 + e2;
frame = exp(atanh(0.5)*0.5*e12);
event_in_frame = frame*event*~frame;

out1=sprintf("event time as seen at 0.5c %f ", event_in_frame(e1));
out2=sprintf("event position as seen at 0.5c %f ",event_in_frame(e2));
disp(out1)
disp(out2)
% Expected output from Ganja.js
%    event time as seen at 0.5c = 0.5773501396179199 
%    event position as seen at 0.5c = 0.5773501396179199