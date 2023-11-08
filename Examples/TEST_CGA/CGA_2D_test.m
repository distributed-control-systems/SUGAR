close all
clear all
CGA(2,"verbose")
%%
% Generate three points with a random component
off=1*rand*e1+1*rand*e2;
p1=push(e1+off);
p2=push(e2+off);
p3=push(-e1+off);

point=p1;
dipole=point.^p2;
circle=dipole.^p3;
flat_point=p1.^ni;
line=p1.^p2.^ni;

%%
clc
point
point.plot()
point.info()
%%
point.dual
point.dual.plot()
point.dual.info()
%%
dipole
dipole.plot()
dipole.info()

%%
dipole.dual
dipole.dual.plot()
dipole.dual.info()
%%
circle
circle.plot()
circle.info()
%%
circle.dual
circle.dual.plot()
circle.dual.info()





%% FLATS
flat_point
flat_point.plot()
flat_point.info()
%%
flat_point_dual=flat_point.dual
flat_point_dual.plot()
flat_point_dual.info()
%%

line=dipole.^ni
line.plot()
line.info()

%%
line_dual=line.dual()
line_dual.plot()
line_dual.info()

